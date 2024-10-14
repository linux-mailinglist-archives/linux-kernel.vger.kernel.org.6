Return-Path: <linux-kernel+bounces-364392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D5E99D431
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 18:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85D97B2639D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 15:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 428931AE016;
	Mon, 14 Oct 2024 15:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Ji/ScHZ9"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C7B1AE861
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 15:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728921404; cv=none; b=ZvMvOXCp98LVfkHFs5ELQ34NCOdom3/Xte/bRrXrsVUE/gB+n0aDX+Y584B+bKFuphGlHuFxmJzLmWpmZQukLG27JKfHBAXiuGmbb5H3nQeUrZIiOLkSZpenShO3bLzzGBdon2M4OpzkiZXm2fCsFfNoWggQxssvdzlgzaCENFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728921404; c=relaxed/simple;
	bh=PbHHo5NkxCIAhHxxNosz6EiO1+G/cFptBNu8I2yfy60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R0ZxGOhZeX5gK6CQA/7HW05x5pR/ICU5mkcJkVv78FnxkbV3dKhXXA2/3udsgeihxynvEkm8cg/HibhL4E0C6jOYwwMYrPlb7weuCH8/XndWOS+ZV/QxP/2aSeeoea8LNa1QWa765Mt2iKwS/1cqSQuNuIFwGRBuLUDAn7HviSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Ji/ScHZ9; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539ebb5a20aso1773033e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 08:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728921400; x=1729526200; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1lDudDK0/43d4Z7N9Z+/XaVR+3f/xGvlf/JVC+34lAE=;
        b=Ji/ScHZ9JdLkGRA+HJCbn8CvMBZwWOLPrpeMl2OTXmMjfiwF4NC8KYyNFf3/R/G5Ii
         JdfcU4jVnL3PljPl5ZKZYQmdZIVK9hJ3Yyypw1w1pStvJ2KKNqGZZ5s92bl89Vz0QCkS
         qk1dgQuxASicwjb4vysJ38jifbraBWc39YHp5YO5WYEiy7T536pE/LIbQht/J/FCFJyq
         dKMcimn/wdQuMUqSlFlayodptl/D3pqbvWeQJC3a7qiYZM6kjErJ0rbu4Rl4/KMeuoLO
         W917arkA049t6W1rpKlnq1I2oaOa9EZV2Px2Yn3uDHFL5rWw/GrShajx5iEx1jkt3qEo
         9kqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728921400; x=1729526200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1lDudDK0/43d4Z7N9Z+/XaVR+3f/xGvlf/JVC+34lAE=;
        b=kHTsxl8ThvssmDXNs3g19KkCTJ2/3vlGYs3IvHgYVDE1AXl9o2yrChnVNy98mI4kj5
         Gr033NsOevImVsjx8PUx6SycOrxrdBvmPZhnCd9fblLxeicWizGCxRp973fNIP7O5IsR
         legchI3+tC+j9Ec/hnQv4jLocG+2Da39iOzX5ocWAH/RVsD0uOPi9YzpjNWRfSFXPaSe
         n+31v4Y65aFV1w39gIIOzkylC6/d9l0syxDp7Zgztv71lDsytxpXrAcE2aAH8LojTHns
         HAMz0K2ZT33KkNwdZdeIktnBd/o0ck3vWpzeFno+/gX3Up+HdcgHhpud4y/y0T8nYafh
         8e/g==
X-Forwarded-Encrypted: i=1; AJvYcCWn8dCVStR5dWQOdCe6oOftK0tnvkU/CNheNcWfZC4oUujqAVlMUKy74SOD2vlxcES1osmli6VKduOa3d4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yybp2ooUy2hjpduKNr1pIQywMzGxfsaZ90T+nX0Dm0PgGuDX1Ko
	US8izV+jkg/A/zEEs9xR5UAjp4J4EvhoLVaa+Nx6rLKBkwUe+aJDubeVr56ej0epOfQydcTKpFq
	RweviMnD70CsmrrzLnUJ3CvzMTur9X81VVuha5Q==
X-Google-Smtp-Source: AGHT+IE+ZXs7dOrxKsDNzCmr6QC4qsHoQPFLeLElLsyDMriCOYdNYZk7Gf9I/GFd8xo0qdQL/do3JSPGT9kn43tp4+A=
X-Received: by 2002:a05:6512:2398:b0:52c:9468:c991 with SMTP id
 2adb3069b0e04-539e54e72a2mr3758293e87.14.1728921400266; Mon, 14 Oct 2024
 08:56:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014111527.2272428-1-quic_kuldsing@quicinc.com>
 <20241014111527.2272428-2-quic_kuldsing@quicinc.com> <CAMRc=MftQBH_d4Ew_5jdqqk1WpM511huWJH2ZDwnhXVYDboYLg@mail.gmail.com>
 <d00f0a6e-575c-4886-8e06-30d5d1c15d81@quicinc.com>
In-Reply-To: <d00f0a6e-575c-4886-8e06-30d5d1c15d81@quicinc.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 14 Oct 2024 17:56:28 +0200
Message-ID: <CAMRc=MeiPbtHUQgJ5yR2EZbqRTS30zeuNEsXcgKdYt2c-X=fZA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] firmware: qcom: scm: Return -EOPNOTSUPP for
 unsupported SHM bridge enabling
To: Kuldeep Singh <quic_kuldsing@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Qingqing Zhou <quic_qqzhou@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 5:48=E2=80=AFPM Kuldeep Singh <quic_kuldsing@quicin=
c.com> wrote:
>
>
> On 10/14/2024 6:35 PM, Bartosz Golaszewski wrote:
> > On Mon, Oct 14, 2024 at 1:19=E2=80=AFPM Kuldeep Singh <quic_kuldsing@qu=
icinc.com> wrote:
> >>
> >> From: Qingqing Zhou <quic_qqzhou@quicinc.com>
> >>
> >> When enabling SHM bridge, QTEE returns 0 and sets error 4 in result to
> >> qcom_scm for unsupported platforms. Currently, tzmem interprets this a=
s
> >> an unknown error rather than recognizing it as an unsupported platform=
.
> >>
> >> Error log:
> >> [    0.177224] qcom_scm firmware:scm: error (____ptrval____): Failed t=
o enable the TrustZone memory allocator
> >> [    0.177244] qcom_scm firmware:scm: probe with driver qcom_scm faile=
d with error 4
> >>
> >> To address this, modify the function call qcom_scm_shm_bridge_enable()
> >> to remap result to indicate an unsupported error. This way, tzmem will
> >> correctly identify it as an unsupported platform case instead of
> >> reporting it as an error.
> >>
> >> Fixes: 178e19c0df1b ("firmware: qcom: scm: add support for SHM bridge =
operations")
> >> Signed-off-by: Qingqing Zhou <quic_qqzhou@quicinc.com>
> >> Co-developed-by: Kuldeep Singh <quic_kuldsing@quicinc.com>
> >> Signed-off-by: Kuldeep Singh <quic_kuldsing@quicinc.com>
> >> ---
> >>  drivers/firmware/qcom/qcom_scm.c | 13 ++++++++++++-
> >>  1 file changed, 12 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/=
qcom_scm.c
> >> index 10986cb11ec0..0df81a9ed438 100644
> >> --- a/drivers/firmware/qcom/qcom_scm.c
> >> +++ b/drivers/firmware/qcom/qcom_scm.c
> >> @@ -112,6 +112,7 @@ enum qcom_scm_qseecom_tz_cmd_info {
> >>  };
> >>
> >>  #define QSEECOM_MAX_APP_NAME_SIZE              64
> >> +#define SHMBRIDGE_RESULT_NOTSUPP               4
> >>
> >>  /* Each bit configures cold/warm boot address for one of the 4 CPUs *=
/
> >>  static const u8 qcom_scm_cpu_cold_bits[QCOM_SCM_BOOT_MAX_CPUS] =3D {
> >> @@ -1361,6 +1362,8 @@ EXPORT_SYMBOL_GPL(qcom_scm_lmh_dcvsh_available);
> >>
> >>  int qcom_scm_shm_bridge_enable(void)
> >>  {
> >> +       int ret;
> >> +
> >>         struct qcom_scm_desc desc =3D {
> >>                 .svc =3D QCOM_SCM_SVC_MP,
> >>                 .cmd =3D QCOM_SCM_MP_SHM_BRIDGE_ENABLE,
> >> @@ -1373,7 +1376,15 @@ int qcom_scm_shm_bridge_enable(void)
> >>                                           QCOM_SCM_MP_SHM_BRIDGE_ENABL=
E))
> >>                 return -EOPNOTSUPP;
> >>
> >> -       return qcom_scm_call(__scm->dev, &desc, &res) ?: res.result[0]=
;
> >> +       ret =3D qcom_scm_call(__scm->dev, &desc, &res);
> >> +
> >> +       if (ret)
> >> +               return ret;
> >> +
> >> +       if (res.result[0] =3D=3D SHMBRIDGE_RESULT_NOTSUPP)
> >> +               return -EOPNOTSUPP;
> >> +
> >> +       return res.result[0];
> >>  }
> >>  EXPORT_SYMBOL_GPL(qcom_scm_shm_bridge_enable);
> >>
> >> --
> >> 2.34.1
> >>
> >>
> >
> > The patch looks correct to me and like something that should go upstrea=
m.
> It's upstream mailing list only. Please see :)
>

Yes I know, by saying "go upstream" I mean "merged into mainline".

> >
> > Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>>
> > That being said, this doesn't seem to address any of the issues that
> > we saw with SHM Bridge and it still leads to a crash on sc8180x. :(
>
> Verified on qcs615, and qcs9100 by explicitly making shmbridge
> unsupported in QTEE and patch worked there.
> Sc,8180x is something different it seems as there's no scm driver probe
> failure and instead screen stuck is observed.
> I'd like to check this behavior and get rid off it from blacklist
> platform list.
>

Ah then my review is only more confident then. :)

Thanks,
Bartosz

