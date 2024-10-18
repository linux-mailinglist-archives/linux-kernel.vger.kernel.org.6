Return-Path: <linux-kernel+bounces-371296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BBE99A395F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 11:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 839BBB22472
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 09:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1C218EFF1;
	Fri, 18 Oct 2024 09:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j0RsXq22"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DB718FDA6
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 09:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729242218; cv=none; b=pKp9GTgMrKr3dH9A20y+gs0ZST/4Ih8CO/Kh25lfSJC989Ia8Jacvr/Xiq+lL0bFQNlmSjdwYxT2tTV1psoiRae1HTN51PEwY7IfCVfFf0e7cqkQUCvPi/Vrz/aXGJR7LIc9ri7Q5yU+S3pxu9J4clbhbXEN2WaEC/mZtuSEiV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729242218; c=relaxed/simple;
	bh=MAuK9ZpjaW//o3+/lqn2ofD4D+7bWlq6mbU3DdRjkEI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jbfK6meIV19j+05cY04w/67V9j9WKBWLBkdGPO/qDtNe73jCf+d7uF0GD3mWdnHA0W7A1+of+ibIsOgJtAi+ay4QjbT9mFmxv9itYCEE52lXh+/0lTL0uYEsqA5U5jktWrDnRSHmpnPJ0kxLiJRaxRC4wPigrohq+tu3t6UIRS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j0RsXq22; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6e38fc62b9fso19660547b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 02:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729242215; x=1729847015; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Y9pfIMsORbWEsl/vnzFg7G1qoNU1sMiSopJc4WsDjiQ=;
        b=j0RsXq222A7yum92BGgzlKcK5m5nNJKzoGCAr0MsCjn92PwYGV5XDyPyB8U5lvxj0J
         AXaPA7HAmof/33PqmSboRUyCJAAT3ocDUImuEhjjEg8Pd3m5w0/p8gVxMPvV7LbPCzVf
         Jja5fuuTEKPCTkSZDmbFZcrusxKHe+GpSC4H9gaU9jJmneDVreYiurGGralnzlq9xdgo
         tisgsiq7UBVMTL304T7cNnZMIfvuUuOjsG/78rNv2Bnz0JE9CXFY6PRkZ01PigMN+F3Z
         5hOfTs3H75dnbGVZgQv8fFoUf3seL71t8KeB5b+wQQKYRJt3pv6gFPQ+cGTdbu985wWl
         kg4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729242215; x=1729847015;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y9pfIMsORbWEsl/vnzFg7G1qoNU1sMiSopJc4WsDjiQ=;
        b=P+8CVog0vvRjs8hzecGpl4ruOJMdO5jaIgHWArHg0CdBXerSAn3fWiCrjeCkdY2bK8
         EmBOdINuuD3bbwXl6CVfE906ZD5X1QzuPgTWt7sNtfUwW4sklvkPeUukjln3CN+tk3xP
         RlIYSJVjGz5MXwDFRT+OjS1RlRyd5Dm53WndbOnqsnEMIXgSx3QmQwMJlroUm4jYgJ/L
         u16PxD6xtN5Ur4/H9YL5HlSUtsLrTFBoXHxVkvZ6rwTsheOtbhWJ3Pcl6hVBBF9HG4b8
         U/VVcnLlJT8oqlxF53ZaFHpgF9MSzaPK4mpkHLHRNiR3EbWG6CNxG28e4P0qQslnx7tK
         rs+A==
X-Forwarded-Encrypted: i=1; AJvYcCXrkJWvIkUyeZU5CvGSgqaDduC4xcIYEtqDCqkGrNg3s2QUtoaKYZ+3KcDBJv0Dvfv9nPLDKIzJfAGVHNs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7lLx0gck+IsHY2gLbchLyZ8vruBK+VqX7PlOklBV9u5dvhYuY
	HNZ1OtdH13gJI/oyJrbjst6ZspEjPNhilLzTDU2gUVThz04hI3+PY9Dq473e3FpX7X6BF3k/TlZ
	Le+KKpMw9UrO0dxVdqJEjmmcav1JpF9ttbkeZTA==
X-Google-Smtp-Source: AGHT+IEIdqLJnXhR9eBPZC+aIkQ6YsTEogGzB+/bb0aWbntjO40LQ3cW1sY0LwG4AT1TVSM2B1Norwd2BmiIa/TTqSI=
X-Received: by 2002:a05:690c:9a0d:b0:6e3:28af:730d with SMTP id
 00721157ae682-6e5bfc611efmr17451427b3.43.1729242213908; Fri, 18 Oct 2024
 02:03:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016135409.2494140-1-quic_bpothuno@quicinc.com>
 <mvzwlbeopenn5hpll3rmkdwcc7r7ir263nwvlh2hiy73qeipl6@nh4angyrt5p2> <LV8PR02MB102398337D13C6E0160E0FD14E7402@LV8PR02MB10239.namprd02.prod.outlook.com>
In-Reply-To: <LV8PR02MB102398337D13C6E0160E0FD14E7402@LV8PR02MB10239.namprd02.prod.outlook.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 18 Oct 2024 12:03:22 +0300
Message-ID: <CAA8EJpqJgxPErHkce8avfZUkU1D9rEiWTDQqJhUe_nm6n_PODg@mail.gmail.com>
Subject: Re: [PATCH] remoteproc: qcom_q6v5_pas: disable auto boot for wpss
To: "Balaji Pothunoori (QUIC)" <quic_bpothuno@quicinc.com>
Cc: "andersson@kernel.org" <andersson@kernel.org>, 
	"mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>, 
	"linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, 
	"linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"ath11k@lists.infradead.org" <ath11k@lists.infradead.org>, Kalle Valo <kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 18 Oct 2024 at 11:42, Balaji Pothunoori (QUIC)
<quic_bpothuno@quicinc.com> wrote:
>
> > -----Original Message-----
> > From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > Sent: Friday, October 18, 2024 3:59 AM
> > To: Balaji Pothunoori (QUIC) <quic_bpothuno@quicinc.com>
> > Cc: andersson@kernel.org; mathieu.poirier@linaro.org; linux-arm-
> > msm@vger.kernel.org; linux-remoteproc@vger.kernel.org; linux-
> > kernel@vger.kernel.org; ath11k@lists.infradead.org; Kalle Valo
> > <kvalo@kernel.org>
> > Subject: Re: [PATCH] remoteproc: qcom_q6v5_pas: disable auto boot for wpss
> >
> > On Wed, Oct 16, 2024 at 07:24:09PM +0530, Balaji Pothunoori wrote:
> > > auto_boot flag ensures to take the firmware and boots it up during the
> > > wpss remoteproc start.
> > > wpss host driver would like to control the load and unload of the
> > > firmware during the load and unload of the driver.
> > > Hence, disable the "auto boot" for wpss.
> >
> > Which driver?
> ath11k_ahb.ko
>
> What is the reason for manual control?
> > The board seems to function properly with the ath11k driver, which doesn't
> > seem to require manual control.
> >
> The rproc "atomic_t power" variable is incremented during:
> a. WPSS rproc auto boot.
> b. AHB power on for ath11k.
>
> During AHB power off (rmmod ath11k_ahb.ko), rproc_shutdown fails to unload the WPSS firmware because the rproc->power value is '2', causing the atomic_dec_and_test(&rproc->power) condition to fail.
> Consequently, during AHB power on (insmod ath11k_ahb.ko), QMI_WLANFW_HOST_CAP_REQ_V01 fails due to the host and firmware QMI states being out of sync.

Please move these details to the commit message and add Fixes/cc:stable tags.

>
> Therefore, this change disables rproc auto boot for WPSS.
> > >
> > > Signed-off-by: Balaji Pothunoori <quic_bpothuno@quicinc.com>
> > > ---
> > > Cc: ath11k@lists.infradead.org
> > > Cc: Kalle Valo <kvalo@kernel.org>
> > > ---
> > >  drivers/remoteproc/qcom_q6v5_pas.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/remoteproc/qcom_q6v5_pas.c
> > > b/drivers/remoteproc/qcom_q6v5_pas.c
> > > index ef82835e98a4..05963d7924df 100644
> > > --- a/drivers/remoteproc/qcom_q6v5_pas.c
> > > +++ b/drivers/remoteproc/qcom_q6v5_pas.c
> > > @@ -1344,7 +1344,7 @@ static const struct adsp_data
> > sc7280_wpss_resource = {
> > >     .crash_reason_smem = 626,
> > >     .firmware_name = "wpss.mdt",
> > >     .pas_id = 6,
> > > -   .auto_boot = true,
> > > +   .auto_boot = false,
> > >     .proxy_pd_names = (char*[]){
> > >             "cx",
> > >             "mx",
> > > --
> > > 2.34.1
> > >
> >
> > --
> > With best wishes
> > Dmitry
>
> Regards,
> Balaji.



-- 
With best wishes
Dmitry

