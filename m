Return-Path: <linux-kernel+bounces-514912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27746A35D40
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 13:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 866297A3812
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 12:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9265F263C69;
	Fri, 14 Feb 2025 12:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JFuAzu3g"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDB4221DA0;
	Fri, 14 Feb 2025 12:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739534573; cv=none; b=lbywM/lg5phFYeWnVWCcNH1BfMFlFT8kDdGmaIy2X4thVOxj4Z65QglQK4oLBXH+Ect0Qx3LgsXmRhHrw93+dbbXIE2hEa+BZ55lWaFdD3fqlf/yyRE5kR992y+64TFXDFakCnPcwkPo7s2Px7TtiamRMW+2ctd7uxkceBzm6FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739534573; c=relaxed/simple;
	bh=ZPTlGoAvuZDsiZlZBlGDJ1POLIj59iTdL2XecaLgiNk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L6PJojbhfFVh6Z6ykJXuij7F1qz2co2eNOQUA09wtmIyl5mnjUbkxOmOSYd96d5pUWwU+pQGAe10BRFxTEmemHYRHQWf8jA4Ru7SBHdGSSjwoLe+sVQE7oVP4DdZUZ8JuqLn+jsGFHNasZjQCuOrwgnk1Lx2rRP2FIKvQj5SDMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JFuAzu3g; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2fc0d44a876so2867731a91.3;
        Fri, 14 Feb 2025 04:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739534571; x=1740139371; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l+3CPNeqoZCzZqNRxUO54Y3vCSBLp9p1u471MLmZ1I8=;
        b=JFuAzu3gBhgnqBr5NT+KKHzQUgX+XprIhh46enmrI4jKFkMi3YJTw9gV1CBuBqMsqg
         VR3AGzcIay06VAJBovNx9IHnjadT9TRCRC+kWl6aAxnwH1k5npALSxbncSRZvpzHfktZ
         JupTk3RjYw4kT0fxmDzpO8HmFqsbafxH4zMqn7DUrKeAHBa0oaYq36PtR5u9yEvwRA/E
         OUZM1/prbqOD4LQ4EoUA5TKcla/T3OoBpCjy4j2JbomQFDotZfD7V/rTBbT93MoIktyA
         GOUi6nkbj187OcQCvz4SzIeTleeAH+9M4AawuWMQG4AHGHVV1/vCfW2Pw50VvvhMRBVq
         bcHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739534571; x=1740139371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l+3CPNeqoZCzZqNRxUO54Y3vCSBLp9p1u471MLmZ1I8=;
        b=Q02+AbCEl92XNyubrGgmUESD8jJiqACU23P5LcBqM/getEm4as7X7LqWqpsVOk3zuL
         3qDkkUAlx3ctOoeV3V6mSoo1boc9lKiTibg3WzuEpa0uZiRB4NaH63DZg7IpPhi5PQmL
         xQrXmOSbyMgYL+kjKHtwQchH85Kx1v/aMbU9lB0ZPUFO3gIGpGutnliU6wxg22QJo7bs
         FUfOebLTSgc6GCzQLyWOhaesuL8Mqk4kPYB8y8wGN3moTGCvqhr2AuvV4c0U80Cu2sD7
         cOG36WVwx+MRp/YnWDFwpzojwtUc6o1VBOhSSuAtuNvDFsgfejMHPVhtlWDn+Acr0shS
         aO5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVaVX2B3bGBxAqDit2Yph/9J5SE3xz9Pl5Lgyq/N8olnsUYKkXASjqXvVsdNtxLBOXSDqRVoEsu9LE5rl8=@vger.kernel.org, AJvYcCXDF3l1B7n0q7tvRKgPPxteyRWmoGOxmb9gjD3trgkvedAyjMRCEYWSFUGLBE8mMh3Pn6LDapsk1db3igY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYALBto0hD7GPv2cjvjreLSQjphNM+9bno2TxsT8hoRloo5ePn
	KMPdm92VzWeaZy56b3vsAzsQMkQtSU48xRCEnIOdtNTrA6AKYl8dM1oWDdbX+pZ7VH864FFspmx
	PDkxpBEt9l4s9xwk/zasmmRotqOU=
X-Gm-Gg: ASbGncst7v1JKfUW8dCN2YljYnz0WY/BXUIUyyOS3mgjCatjegU2DAWjZ/d+Fj10Zjn
	nlcyo3lx6MKmp/MzHslj0D/RpG4BnQNp0oYBuvKDhPKBJ7s0VRisNwaR2hh4yPIgxnPMt1w==
X-Google-Smtp-Source: AGHT+IGvWztfKlUGJ2WLRtNHFcChcht1iG1Pz9xgqQDdN9VXIRR7a8jyDsGxC3J/ad+Hwz78GM0iN/i5RDbRohXNQfo=
X-Received: by 2002:a17:90b:3a89:b0:2f4:423a:8fb2 with SMTP id
 98e67ed59e1d1-2fc0e98dd17mr10159553a91.20.1739534570753; Fri, 14 Feb 2025
 04:02:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214081458.296948-1-chancel.liu@nxp.com> <20250214081458.296948-2-chancel.liu@nxp.com>
In-Reply-To: <20250214081458.296948-2-chancel.liu@nxp.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Fri, 14 Feb 2025 14:04:23 +0200
X-Gm-Features: AWEUYZnUV8h3wyE_Qz0Ok8Jj-T8MZQVUBOK-aG4pwrrdiSsACc9urHDHo1Xwv1I
Message-ID: <CAEnQRZDBE7foG5qB2qeDP9GmaHybMJNj28MMW-VZLqe6tiu_bg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ASoC: imx-audmix: Update correct dai names
To: Chancel Liu <chancel.liu@nxp.com>
Cc: shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com, 
	nicoleotsuka@gmail.com, lgirdwood@gmail.com, broonie@kernel.org, 
	perex@perex.cz, tiwai@suse.com, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chancel,

This change should be squashed together with patch 1/2 otherwise you
break bisectability


On Fri, Feb 14, 2025 at 10:15=E2=80=AFAM Chancel Liu <chancel.liu@nxp.com> =
wrote:
>
> Update correct dai names which are changed in CPU dai.
>
> Signed-off-by: Chancel Liu <chancel.liu@nxp.com>
> ---
>  sound/soc/fsl/imx-audmix.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/sound/soc/fsl/imx-audmix.c b/sound/soc/fsl/imx-audmix.c
> index 50ecc5f51100..dac5d4ddacd6 100644
> --- a/sound/soc/fsl/imx-audmix.c
> +++ b/sound/soc/fsl/imx-audmix.c
> @@ -119,8 +119,8 @@ static const struct snd_soc_ops imx_audmix_be_ops =3D=
 {
>  static const char *name[][3] =3D {
>         {"HiFi-AUDMIX-FE-0", "HiFi-AUDMIX-FE-1", "HiFi-AUDMIX-FE-2"},
>         {"sai-tx", "sai-tx", "sai-rx"},
> -       {"AUDMIX-Playback-0", "AUDMIX-Playback-1", "CPU-Capture"},
> -       {"CPU-Playback", "CPU-Playback", "AUDMIX-Capture-0"},
> +       {"AUDMIX-Playback-0", "AUDMIX-Playback-1", "SAI-Capture"},
> +       {"SAI-Playback", "SAI-Playback", "AUDMIX-Capture-0"},
>  };
>
>  static int imx_audmix_probe(struct platform_device *pdev)
> --
> 2.47.1
>
>

