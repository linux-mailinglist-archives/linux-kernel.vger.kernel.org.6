Return-Path: <linux-kernel+bounces-364087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1352499CAF9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 15:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D0041C235EF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 13:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F16201AA7AF;
	Mon, 14 Oct 2024 13:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="KhEERjrZ"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFE319F43B
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 13:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728911170; cv=none; b=HEUsw7fFZGHBdTU6Og43hJf9UOHilyFvEpsLuPg67eL2V4lH1RpCdvEY/56BpNZ85e1PaZpolhVjbipoX6GWSEa0tvN6hKpyMvrif+GquAufYrNxFoEST6PaUMD7PLSA93NWbsb+uqwxvL7mB9km4wsE+OvH4SEazlGBzoV0QGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728911170; c=relaxed/simple;
	bh=LCNS312XX8+QtPMLYe1AhAHuLD8/5nIRC3vEE2GCZXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XdnPjkwSabZVfKHiepc7Hxh/No43Vd9sfXGoArSXu5KDv2yxGy3xcV7bwDlXSU/2ctx5JPjm/roOaqROKq2zzFfpF+0UPiuL0u+pTldnTfu9ROjxULgWOyBCwlcF4fXA0ImS4QgscUDS3J0/xvsuwJyO4pbBiW8nXHLbyb5r460=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=KhEERjrZ; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539f58c68c5so1518560e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 06:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728911167; x=1729515967; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0KbDLhMcvfgwNdAQUxsq+9HS6SfLDbI1Cx605AIvkyo=;
        b=KhEERjrZHh1uVqqmefRgJpp5a5PqNEN/WVt5no1ccHX/QrZ1ow4DD+wjIWT85E//wD
         1aqRunAA+894XMWrAPBYAIKr4KEKHEnVVLKXlpRb+L3TLI8tkhoE0UPrm+obtR255dWT
         tovaEVJDvS6TXyYzk6KBNPR7xURY5Wy8zwL0dHwHbenCMafVV56WSEV5gl1uJIexgC9a
         bf3J8wEZTk/VCNaWAtrsaq0o9WAXPUXunLcnE7wirzOyRVSeXMuF4W1hgjKYQlVnoeVL
         pCcCQDECGRBTDybPAwBqIsN6tIswSOn2YZTi4rtmUE6JD3UN37F6NxfKojdBzfBuiDeZ
         M5sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728911167; x=1729515967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0KbDLhMcvfgwNdAQUxsq+9HS6SfLDbI1Cx605AIvkyo=;
        b=Mg3oewuUa5FePM7mhpB88fTrZTKEaA5p4hdyR6P8FbK9eakxYbx+W9cLPQeM2FHe6P
         /NgG0nBk0rxuPe+KNsUpYRlwixRVRkods7NYc6t8+eo66RZbLHBZIgfqbu+r4KYoOuLU
         QHUuT48U38ojyjRjNykKMM3Vk2bsyWvCebrUX5+hNh067Axk0u0KKbhYKyy2WXgEXrF7
         vTJjp7A5GvWZzsbCth52SpB9vdYmDue+WgzgBmwVsUnFrQwkYWMcfIR0TIlnoYrnFJvl
         Ir7fpbisVqRvxC/ZU6HynO6r6vNujXrzGm2jyHJPUaYY7sZtF7ed1STEFiH9d/gDvbL0
         XLOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkTLkHzcSXharAj2hEcLefPIQLcpFJdVFup8B5Z0NTjUibmyzPxlnUu1RQFy8AF7icB4qzUECMaiLlAX0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2VzrOr/BYyFpQQe3fkvtRCXNK+HiEn2s6QvsaY2TkElb7oz6Z
	hHBGXw0MCCa1quOLRxbORVOZeCwIs3RkfjuG91Ng/BWigrCFtWopHLwgNmdp74D98Miqp7NX9VH
	tn007WVY483DUtQBj82VFS1BgDaW+GSbOCyeJqA==
X-Google-Smtp-Source: AGHT+IEi9IXCmsD/OTpLrWSBlnQTF9y5K6Luts4kPNK9yagRWRstei7sNO9KfkZuBL7Rewk8E0uOpRK3pAasdzgDkpY=
X-Received: by 2002:a05:6512:1598:b0:539:905c:15c5 with SMTP id
 2adb3069b0e04-539e5521da6mr4247180e87.35.1728911167032; Mon, 14 Oct 2024
 06:06:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014111527.2272428-1-quic_kuldsing@quicinc.com> <20241014111527.2272428-2-quic_kuldsing@quicinc.com>
In-Reply-To: <20241014111527.2272428-2-quic_kuldsing@quicinc.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 14 Oct 2024 15:05:55 +0200
Message-ID: <CAMRc=MftQBH_d4Ew_5jdqqk1WpM511huWJH2ZDwnhXVYDboYLg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] firmware: qcom: scm: Return -EOPNOTSUPP for
 unsupported SHM bridge enabling
To: Kuldeep Singh <quic_kuldsing@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Qingqing Zhou <quic_qqzhou@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 1:19=E2=80=AFPM Kuldeep Singh <quic_kuldsing@quicin=
c.com> wrote:
>
> From: Qingqing Zhou <quic_qqzhou@quicinc.com>
>
> When enabling SHM bridge, QTEE returns 0 and sets error 4 in result to
> qcom_scm for unsupported platforms. Currently, tzmem interprets this as
> an unknown error rather than recognizing it as an unsupported platform.
>
> Error log:
> [    0.177224] qcom_scm firmware:scm: error (____ptrval____): Failed to e=
nable the TrustZone memory allocator
> [    0.177244] qcom_scm firmware:scm: probe with driver qcom_scm failed w=
ith error 4
>
> To address this, modify the function call qcom_scm_shm_bridge_enable()
> to remap result to indicate an unsupported error. This way, tzmem will
> correctly identify it as an unsupported platform case instead of
> reporting it as an error.
>
> Fixes: 178e19c0df1b ("firmware: qcom: scm: add support for SHM bridge ope=
rations")
> Signed-off-by: Qingqing Zhou <quic_qqzhou@quicinc.com>
> Co-developed-by: Kuldeep Singh <quic_kuldsing@quicinc.com>
> Signed-off-by: Kuldeep Singh <quic_kuldsing@quicinc.com>
> ---
>  drivers/firmware/qcom/qcom_scm.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qco=
m_scm.c
> index 10986cb11ec0..0df81a9ed438 100644
> --- a/drivers/firmware/qcom/qcom_scm.c
> +++ b/drivers/firmware/qcom/qcom_scm.c
> @@ -112,6 +112,7 @@ enum qcom_scm_qseecom_tz_cmd_info {
>  };
>
>  #define QSEECOM_MAX_APP_NAME_SIZE              64
> +#define SHMBRIDGE_RESULT_NOTSUPP               4
>
>  /* Each bit configures cold/warm boot address for one of the 4 CPUs */
>  static const u8 qcom_scm_cpu_cold_bits[QCOM_SCM_BOOT_MAX_CPUS] =3D {
> @@ -1361,6 +1362,8 @@ EXPORT_SYMBOL_GPL(qcom_scm_lmh_dcvsh_available);
>
>  int qcom_scm_shm_bridge_enable(void)
>  {
> +       int ret;
> +
>         struct qcom_scm_desc desc =3D {
>                 .svc =3D QCOM_SCM_SVC_MP,
>                 .cmd =3D QCOM_SCM_MP_SHM_BRIDGE_ENABLE,
> @@ -1373,7 +1376,15 @@ int qcom_scm_shm_bridge_enable(void)
>                                           QCOM_SCM_MP_SHM_BRIDGE_ENABLE))
>                 return -EOPNOTSUPP;
>
> -       return qcom_scm_call(__scm->dev, &desc, &res) ?: res.result[0];
> +       ret =3D qcom_scm_call(__scm->dev, &desc, &res);
> +
> +       if (ret)
> +               return ret;
> +
> +       if (res.result[0] =3D=3D SHMBRIDGE_RESULT_NOTSUPP)
> +               return -EOPNOTSUPP;
> +
> +       return res.result[0];
>  }
>  EXPORT_SYMBOL_GPL(qcom_scm_shm_bridge_enable);
>
> --
> 2.34.1
>
>

The patch looks correct to me and like something that should go upstream.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

That being said, this doesn't seem to address any of the issues that
we saw with SHM Bridge and it still leads to a crash on sc8180x. :(

Bart

