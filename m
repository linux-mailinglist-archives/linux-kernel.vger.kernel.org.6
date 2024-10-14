Return-Path: <linux-kernel+bounces-364040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA89A99CA62
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 14:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 571DD1F22242
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 12:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B71FE1A76A5;
	Mon, 14 Oct 2024 12:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xc1d5mKy"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498A91A7265
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 12:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728909511; cv=none; b=d/Qms9TKHw92GliTQ45yNEisWDIAfr01hoIE0bR1ApkInc+ptrzP7yBZBu120/xEvCkYXcLsP5rXSuyioaDGPtnItOsE7cxxG/Rl85XAZA7sTtb/oa4O91mvcPliapZYAzhf6JmjuC19xFrkZGyifcIOlrjBNCsU3iv5I5XLc9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728909511; c=relaxed/simple;
	bh=oHa3sg3yHV3049lI3ps4FusUnEkYwbD8hi5+N5Daiy4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i0PBETnRoqCVc/3f/4TztHP32psMkRCL7OZAUQDgXbZpmxsdd6uY90KRYFnUZWzYefxGTLv9d/N+oYEUNBKyc9SPE6rRZs6DN3eb4y3WjT15gDgAG1Q7nIpK+jdZvo0KZabOBqEAdnfSiNmhqcCCkJZ/KYvZCkhfqDqRJ5D0d3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xc1d5mKy; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6e3881042dcso8391067b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 05:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728909507; x=1729514307; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y1KbYaY8K1HyomNgb7KZneANES2HAfN5golvwRDEYq0=;
        b=xc1d5mKyHrNYrV0HIPZ7QND5PJkJ5nYSfiy1q+E6MhW5lylBK6PaPLAU9ofIU8+JU1
         U0i3fDuvm6Wvq33IfHWOKUx39u7Exi5QWtoKFkQFG8vII+Y8Kj5ZeAwl/XXCdUF2TZMM
         bR+KyUPoWq8+nto5ClQfE2/n45bekjIwJ2dvbruwczhdEGsgYVlhcmnXiGaSY20VJmGr
         rCve7xk7jBEq7jZkTkDB39wAZGTw6ScvCwlSQUyadS4XCL7gc+RHhJS9QKXUuAnHzywX
         qYgy5YMTSHKBoI8J3W3aIKv0sXiqwSmNH71jEf7rW7bx9OS4iWbgbrPMn+PI1jclNBlA
         1IJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728909507; x=1729514307;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y1KbYaY8K1HyomNgb7KZneANES2HAfN5golvwRDEYq0=;
        b=FqKK1snfpHSagjnLeFAFNaTIj0qUv5E32HdB1fDF2AnmANFpoCpe4anpJrr0Hb+BUT
         ZPMZzAo4TjrLaKE+3MZkVhnP2be8EGs2Gns7vsN3K7vyIVkIuOlYGaRNm9kJweigDJgI
         XqoEuUH/rjASw0qj/e6Zt0Qio8NDBADVUHUf51PwoVWtKDMfNxT9CygCNNW6fEKLx0Oi
         2S+f3a0WhXMAxYxCixHEgH/1spbDxVAnE8iKOYTtmWmnDBcrrYSQXD2lF9Q+lLetJ4pZ
         nlBZLzCcFHVJJVCf2FeIO3tfBXWBED5If4VypmbM0E+lrJByiXBd7jN0xQDgsZC+hER4
         8LVA==
X-Forwarded-Encrypted: i=1; AJvYcCXcvQUpsIxEdeJkqXe3I/NULk3C49ZXtz61YevHhuyDuUS2Qr738ig5dZ96KT63A2Xl97jmya3/xrmndJM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKfdHWUBxmYGaROJrs/VPbhjMeLhcl4DnDDvUqaSI5hAp3al88
	a6Jb9syVCsgrt58VmkW+4mbwUI6xHMN4AXJPjTLQ0isyeOJEs+PsC3uK/XB3IV3SJjr1IPWX/yE
	9U5+PyQ70rhrucoBpfEUo686og8PO4dbQRUZt6w==
X-Google-Smtp-Source: AGHT+IEKIdxBvlCxcN3OTA+lxiBN4vMcu1QKbPOFmZXvDAC8Wzl1E/L2HknIRkdKPJzI017CldPFHbvAP7ZSwnk5K/U=
X-Received: by 2002:a05:690c:d90:b0:6e2:ac0a:8926 with SMTP id
 00721157ae682-6e364107deemr49225887b3.9.1728909507273; Mon, 14 Oct 2024
 05:38:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004212359.2263502-1-quic_mojha@quicinc.com>
 <20241004212359.2263502-7-quic_mojha@quicinc.com> <9eb910d4-e521-4c14-8e73-8fd3d5ff9573@linaro.org>
 <ZwP1t45ni/gk754B@hu-mojha-hyd.qualcomm.com> <ZwTPghV36CSIpkE4@hu-mojha-hyd.qualcomm.com>
 <dfe46653-5243-47c8-8de9-17a38d13da53@linaro.org> <20241011050518.GJ1421305@hu-shashim-hyd.qualcomm.com>
 <rbek5diyuwhquhbhk6pukzv474xug3pupcqqc2svrceyodvem5@obah2ahgmcox>
 <20241011070907.GK1421305@hu-shashim-hyd.qualcomm.com> <CAA8EJpr7KmTXv8WyxuhAprHoPku_YCt0fz74gd+44OeOT0uKqg@mail.gmail.com>
 <20241014123135.GB2147073@hu-shashim-hyd.qualcomm.com>
In-Reply-To: <20241014123135.GB2147073@hu-shashim-hyd.qualcomm.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 14 Oct 2024 15:38:16 +0300
Message-ID: <CAA8EJprhdRf5Kk2WAMHKEoqZ9JWXfd_sitknxM0NGrRiQeiFoQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] remoteproc: qcom: Enable map/unmap and SHM bridge support
To: Shiraz Hashim <quic_shashim@quicinc.com>
Cc: neil.armstrong@linaro.org, Mukesh Ojha <quic_mojha@quicinc.com>, 
	Bjorn Andersson <andersson@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, linux-arm-msm@vger.kernel.org, 
	linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 14 Oct 2024 at 15:31, Shiraz Hashim <quic_shashim@quicinc.com> wrote:
>
> On Fri, Oct 11, 2024 at 10:12:09AM +0300, Dmitry Baryshkov wrote:
> > On Fri, 11 Oct 2024 at 10:09, Shiraz Hashim <quic_shashim@quicinc.com> wrote:
> > >
> > > On Fri, Oct 11, 2024 at 09:23:05AM +0300, Dmitry Baryshkov wrote:
> > > > On Fri, Oct 11, 2024 at 10:35:18AM GMT, Shiraz Hashim wrote:
> > > > > On Thu, Oct 10, 2024 at 08:57:56AM +0200, neil.armstrong@linaro.org wrote:
> > > > > > On 08/10/2024 08:21, Mukesh Ojha wrote:
> > > > > > > On Mon, Oct 07, 2024 at 08:22:39PM +0530, Mukesh Ojha wrote:
> > > > > > > > On Mon, Oct 07, 2024 at 10:05:08AM +0200, neil.armstrong@linaro.org wrote:
> > > > > > > > > On 04/10/2024 23:23, Mukesh Ojha wrote:
> > > > > > > > > > For Qualcomm SoCs runnning with Qualcomm EL2 hypervisor(QHEE), IOMMU
> > > > > > > > > > translation for remote processors is managed by QHEE and if the same SoC
> > > > > > > > > > run under KVM, remoteproc carveout and devmem region should be IOMMU
> > > > > > > > > > mapped from Linux PAS driver before remoteproc is brought up and
> > > > > > > > > > unmapped once it is tear down and apart from this, SHM bridge also need
> > > > > > > > > > to set up to enable memory protection on both remoteproc meta data
> > > > > > > > > > memory as well as for the carveout region.
> > > > > > > > > >
> > > > > > > > > > Enable the support required to run Qualcomm remoteprocs on non-QHEE
> > > > > > > > > > hypervisors.
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> > > > > > > > > > ---
> > > > > > > > > >    drivers/remoteproc/qcom_q6v5_pas.c | 41 +++++++++++++++++++++++++++++-
> > > > > > > > > >    1 file changed, 40 insertions(+), 1 deletion(-)
> > > > > > > > > >
> > > > > > > > > > diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
> > > > > > > > > > index ac339145e072..13bd13f1b989 100644
> > > > > > > > > > --- a/drivers/remoteproc/qcom_q6v5_pas.c
> > > > > > > > > > +++ b/drivers/remoteproc/qcom_q6v5_pas.c
> > > > >
> > > > > <snip>
> > > > >
> > > > > > > > > > +         struct of_phandle_args args;
> > > > > > > > > > +
> > > > > > > > > > +         ret = of_parse_phandle_with_args(pdev->dev.of_node, "iommus", "#iommu-cells", 0, &args);
> > > > > > > > > > +         if (ret < 0)
> > > > > > > > > > +                 return ret;
> > > > > > > > > > +
> > > > > > > > > > +         rproc->has_iommu = true;
> > > > > > > > > > +         adsp->sid = args.args[0];
> > > > > > > > > > +         of_node_put(args.np);
> > > > > > > > > > +         ret = adsp_devmem_init(adsp);
> > > > > > > > > > +         if (ret)
> > > > > > > > > > +                 return ret;
> > > > > > > > >
> > > > > > > > > Why don't you get this table from the firmware like presumably
> > > > > > > > > QHEE does ?
> > > > > > > >
> > > > > > > > Well, AFAIK, QHEE(EL2) has this information statically present
> > > > > > > > and does not get it from anywhere., but will confirm this
> > > > > > > > twice..
> > > > > > >
> > > > > > > Double confirmed, device memory region required by remoteproc is
> > > > > > > statically present with QHEE.
> > > > > >
> > > > > > Right, in this case why those tables can't be embedded in the elf
> > > > > > .resource_table like it's done with qcom_q6v5_adsp.c by calling
> > > > > > rproc_elf_load_rsc_table() and let the remoteproc framework load the
> > > > > > resource table and setup the devmem ssmu_map ?
> > > > >
> > > > > Mainly for two reasons -
> > > > >
> > > > > firmware images on platforms where we like to bring additional no-qhee
> > > > > support do not have resource table.
> > > > >
> > > > > QCOM PAS implementation for secure remoteproc supports single TZ call
> > > > > of auth_and_rest that authenticates and brings remoteproc out of
> > > > > reset. And we don't have provision to authenticate resource table
> > > > > before it is used for devmem/iommu setup.
> > > >
> > > > So normally TZ / QHEE have the platform-specific resource table? Isn't
> > > > it tied to the firmware binary?
> > >
> > > Yes this table is with QHEE and not firmware binary. Now with no-qhee
> > > case, this patch series is proposing to get it from device tree.
> >
> > If it is platform-specific (rather than being device-specific), then
> > it should go to the driver, not the DT.
>
> Just to be clear, your reference to platform is SoC specific and
> device is board ?

Yes.


-- 
With best wishes
Dmitry

