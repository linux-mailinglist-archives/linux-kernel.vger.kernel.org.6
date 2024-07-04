Return-Path: <linux-kernel+bounces-241014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4499275C0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 14:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18B3D2843F7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 12:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1880D1AC23E;
	Thu,  4 Jul 2024 12:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="cSRx0WJ7"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704A51A072E
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 12:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720095361; cv=none; b=txaTH6yJzKWwT/qAEIFqlTJLZRWk2/Y/fxphizJJES40MK5xwXrzCP4orvin5taW1wsBwE6PDIglH5R3RY9cY6DV76sgWxu/WzYXmT2YXIf88DT26UMzZTGIkqQBrliDs7z+r89mGXoNgLE+Cg3fggkQ73MvnitumdJnZuk2ViY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720095361; c=relaxed/simple;
	bh=9re+ZPkirRwtA9q72yJ4ZBfrbSVVaq/MY2+zhm6rnEQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OT7i4GKcvImCQhV8Aj4DE7vgOpnG0lRT5D0ae0kDCcRWY7OtdsaLWb/AnERNGVpAEyP6JG2fgtWvsQA3NFYjPd6mtW7eUJcQkXtm84qioI+h7ICthCwv1NE3bZMW8Pg7v/KovKpPJJ7R5PsOsahjbhmECWA/a8VjZvdk0MvNc7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=cSRx0WJ7; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ee920b0781so761351fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 05:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1720095357; x=1720700157; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pxaBCPEGtzR3/vGobWG/WXT7hli0Br1nEUmusrFo3kM=;
        b=cSRx0WJ75+JuiLpHux9A34DaHj3cBZEF2LUxJ33Rvlszyc2UHpMg84WnnuhaLi+ItS
         HYxRmYut1SvLyVQue+zlfhClwe5Y7LVkqO2ShrMeRh3aG7yGhrWEZwT2Ps+5FhOUnR3H
         lwXZSzRhHbtpsqNGn6J+6MNnm0SyqEh1hHVGW5xJV/aWxsDxnAUbJH7Y6sOzLD1RWHaQ
         Xj1QGe76AzRh2F2D0T6tyruiLS3hinO1SOPJRn7GMnbxAOWC5W/Vb7FgKAapjQixkXXf
         uf9MuH6a0MUY06gWr1flvxqxv4qENPewokA/brPfPZPyrQGgjgar3ANo2SFZj+JCpRPM
         snPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720095357; x=1720700157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pxaBCPEGtzR3/vGobWG/WXT7hli0Br1nEUmusrFo3kM=;
        b=SpLhKvOPO0wuY3SFzcd1z/woEJrBTsa9Cc2FB1+elQmh1WshyLXkXJ9aZZ//21pxrb
         AikUJNXQTp751y5oMujIYWRQOqwiGf1oT0CcgSPoMtvwN1paQhEx3PjcKHy3rSuMoEIM
         +XAHEZ+YV9ozhVCAjkNmJAUdWPR9o38D6djotLSiCaHDWoGmfijNZHXGUQ/Qhz1OLUZQ
         VFcw9ZDH1xn2tbjE64Ff6gSoIRQG7NpriaMguyk8VOTkVLlQcDzUzt3hCaZvzjiRXAKH
         jIqRDyI1F/CxWtDa+lSKIhpDIcfDm1q7BMro4CaS9PBTnhMB5eB86L3diQIlooJ0/G2f
         TvhA==
X-Forwarded-Encrypted: i=1; AJvYcCXplXC6vTuYFsAE3+a2MCRdxGqfd6naOwiRKmCGrjdKPgaN2/c1wt0bgn+eYmqSouPWNtK0/L3lMrg4fYzsebDfccjfQ60pEDzH+aDa
X-Gm-Message-State: AOJu0YxmzbmW3bJJIVS9avJLJAySRTLJjViFokacUwbsC2i9VZRj+hA4
	uuCCA32pBOZvrwBPq2JxP41SVE+ADjdGamKmDXhqO3OIeJP0Eq14Xpj6qkah32QBbjREasqEA2d
	7oqi8aNjbEgMIB18lpLgkGsENKzw6fp+ueDoxPI07wdpfsuuQ
X-Google-Smtp-Source: AGHT+IHrxcdp9tSDSTnbT0CEN4kOmSsHbK2wdi9lcOLJ/Qc2ZO8wqheJLZl5EDpk6Ys4tt63eobTezcbCEYujZRpYT0=
X-Received: by 2002:a05:651c:b95:b0:2ee:7caf:db5d with SMTP id
 38308e7fff4ca-2ee8ee2a014mr8177331fa.51.1720095357422; Thu, 04 Jul 2024
 05:15:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704-shmbridge-blacklist-v1-1-14b027b3b2dc@linaro.org>
In-Reply-To: <20240704-shmbridge-blacklist-v1-1-14b027b3b2dc@linaro.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 4 Jul 2024 14:15:46 +0200
Message-ID: <CAMRc=MeczCNfRN_8T6YLja-8He-K6ESH82f1eNvxw-1w7_s_-g@mail.gmail.com>
Subject: Re: [PATCH] firmware: qcom: tzmem: blacklist more platforms for SHM Bridge
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Elliot Berman <quic_eberman@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Neil Armstrong <neil.armstrong@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 4, 2024 at 1:13=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> The SHM bridge makes the Qualcomm RB3 and SM8150-HDK reset while probing
> the RMTFS (in qcom_scm_assign_mem()). Blacklist the SHM Bridge on
> corresponding platforms using SoC-level compat string. If later it's
> found that the bad behaviour is limited just to the particular boards
> rather than SoC, the compat strings can be adjusted.
>
> Reported-by: Neil Armstrong <neil.armstrong@linaro.org>
> Fixes: f86c61498a57 ("firmware: qcom: tzmem: enable SHM Bridge support")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/firmware/qcom/qcom_tzmem.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/firmware/qcom/qcom_tzmem.c b/drivers/firmware/qcom/q=
com_tzmem.c
> index 5d526753183d..c715729f071c 100644
> --- a/drivers/firmware/qcom/qcom_tzmem.c
> +++ b/drivers/firmware/qcom/qcom_tzmem.c
> @@ -78,6 +78,8 @@ static bool qcom_tzmem_using_shm_bridge;
>  /* List of machines that are known to not support SHM bridge correctly. =
*/
>  static const char *const qcom_tzmem_blacklist[] =3D {
>         "qcom,sc8180x",
> +       "qcom,sdm845", /* reset in rmtfs memory assignment */
> +       "qcom,sm8150", /* reset in rmtfs memory assignment */

Like I said on IRC: both these platforms were tested at some point
during development so it's worth figuring out what changed.

Ok for disabling them for now.

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Bart

>         NULL
>  };
>
>
> ---
> base-commit: 82e4255305c554b0bb18b7ccf2db86041b4c8b6e
> change-id: 20240704-shmbridge-blacklist-021bd97b8a93
>
> Best regards,
> --
> Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>
>

