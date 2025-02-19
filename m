Return-Path: <linux-kernel+bounces-521407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F84A3BCD1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 12:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B3E6189A112
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 11:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C901DF726;
	Wed, 19 Feb 2025 11:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M73jB6XR"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888341DF263
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 11:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739964576; cv=none; b=qyKHp6D4ElegWJx+481Ol/v0P13tTmSMI7VkfiqU9bmlKhtc/lxzNqIBohXLZ+9OzViESzcqGnE466F+njnr9pHH3rz2Gjl/PMX9Dnc7+JDJXbj5L8QdRmUDtipw6ORO2Q9Sv/z4cG8miHc7toUNlKju0uRSerdIaikhpv3VwZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739964576; c=relaxed/simple;
	bh=g3V+8dM6PJF1zoiI5WkU8Q5Ll2EqB8S0Nz4V7dxVGro=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uPy7QyupH5eZal0CHUdWSXTIbSFgLf4uWethAas/+1x0A8sXUjvnD192eXFNMR1oaXkH5LpT9iFsbigeg5pyAPJ2tnz55Or2fe3de97pPNfc2Um0uk3dtRSD6STf/5x5gbXDlg0zncEQZBZ+8yozhk7KAcdDLqEXgGrJZ0qSwUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M73jB6XR; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2fc0bd358ccso13151469a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 03:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739964574; x=1740569374; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5vU+z7o1n0G7VQ2M0U6SHnojITFeeAuqpaQx8uuT8Do=;
        b=M73jB6XRjEgyzQcFC/fEVboJgZtMSLW7jyoBeu3Kk/J2G7a+4WbYB1EYzPWZWVlCMF
         r5rwp71uWbxJjnu4zAo/1ghGG6coPyEYghpZe+UaS4kGyzrC9zLeQInFKfaBdkLV9Z6u
         KQD7JsodnyQfVqFULlyd/F7eZZKZ15e0uztxosgc8d3noqi3on8fR8sW5LmGi6H09xd2
         sslgj1pcqmoE44ET/h39S3JEDXzb3hNw+91cYVifPRAV+9d5q52+wH/KWKqGy0YSum/x
         u3XJ9uKgC39OcYLPtQy1kdgvjqwTX3BBBnc7jp6/9ih3aQXoBfULIS2jGPkc3EO42vLW
         /pJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739964574; x=1740569374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5vU+z7o1n0G7VQ2M0U6SHnojITFeeAuqpaQx8uuT8Do=;
        b=gccgmyz03/1oJoieJs7aOjTq+ac4vsfCX61N3FA4o33NnYcswtBvNCjXQzPQpQ4vaP
         sDw/lt5H5SO91H9Feco09DKgVhFTroDTu7V9uWFb7GvDmp7Ald4CaDSR5Lx/0Z2jid57
         bxSStbdGOwcVbmsOYTcYSgQz8jhA1FNk/n7EsWCyWAcKj5xXK13pkJM1GKXAnFGZP59d
         izwzsXB+3sgMKGdaiE+Ms65ifPEFFrHxwiibmQj+8kvlE8QWdkFo6EI23FQAZn4S/nJR
         ajeQd80wCiS/1tW1olcdn1Jn0BmV85tPYHXggEe9Jl5OxqN4umRk1HijZAhWezrHdkHZ
         eEMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWjZwUhm4geg2V+y3di7Se66d9qZVFffRCI74VfOtyF32krRdatm6v+NlkqWaeMJZc0CWL0pgt+0KgS5U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdIGIK/BmaO5FT16x4UDG3zjGL82v5AL3o6pYSmFEbd3Qn0B8K
	d1jdFu87JpykX904mBJtCpf9cJNxRxq/PLE69vRCykmcd4oJuZ0F5B7/ElO/ufynoHLLBadf8hX
	8CSLfPx7mN4ltCdinf0lQUi2a5hw=
X-Gm-Gg: ASbGnct/JOVIJ23r8ZECBrI4MeMTCe2uSRDLDFFipStjdLp9TDXC83Rzp0eFftXJXQu
	m0vGjxHq24P1Z0vvk84sH/mvgHsOojQsSIzvfsYghx8kJzEay1p/aajaofMHADL7cbIelB5qE
X-Google-Smtp-Source: AGHT+IEy3gIKsA2IQeCpKMMMuYndacoBsWC4Zu0rpUgMg6vNtThISaOrAnvzXl+MwdwzMRvuz0JKxEz5n2ulPBpyU6U=
X-Received: by 2002:a17:90b:3b4b:b0:2ee:fdf3:390d with SMTP id
 98e67ed59e1d1-2fc4115087fmr24105113a91.31.1739964573544; Wed, 19 Feb 2025
 03:29:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1739961770.git.guchongchong@xiaomi.com> <19ac11d6b9e5988d190025255c5ffe08c57c8023.1739961770.git.guchongchong@xiaomi.com>
In-Reply-To: <19ac11d6b9e5988d190025255c5ffe08c57c8023.1739961770.git.guchongchong@xiaomi.com>
From: Adam Ford <aford173@gmail.com>
Date: Wed, 19 Feb 2025 05:29:22 -0600
X-Gm-Features: AWEUYZn24v6r2D4b5o-SiBzC1qYQfPa9B6_jswODdfypF4PixQVAxs6BawZcytI
Message-ID: <CAHCN7xKtu2y=757_mAmR64vCKCo-g78U-qWYT+j5_Rv5Gc+USQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] phy: freescale: limit div value in FIELD_PREP()
To: Chongchong Gu <chongchonggu21@gmail.com>
Cc: vkoul@kernel.org, kishon@kernel.org, linux-phy@lists.infradead.org, 
	linux-kernel@vger.kernel.org, guchongchong <guchongchong@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 4:54=E2=80=AFAM Chongchong Gu <chongchonggu21@gmail=
.com> wrote:
>
> From: guchongchong <guchongchong@xiaomi.com>
>
> In fsl_samsung_hdmi_phy_configure_pll_lock_det, the variable named
> div becomes 4 after loop. It must less than 4 in function named
> FIELD_PREP(REG12_CK_DIV_MASK, div).
>


There has already been a fix applied to linux-next to address this
[1].  Have you tried this to see if it works with your compiler?

adam
[1] - https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/c=
ommit/drivers/phy/freescale?h=3Dnext-20250219&id=3Dcd57e4327707126dca3f9517=
b84274c001d4c184




> A way to reproduce when run the following shell command
> make ARCH=3Darm64 CROSS_COMPILE=3Daarch64-linux-gnu- defconfig
> make ARCH=3Darm64 CROSS_COMPILE=3Daarch64-linux-gnu- -j4
>
> Fixes: <d567679f2b6a> ("phy: freescale: fsl-samsung-hdmi: Clean up")
> Signed-off-by: guchongchong <guchongchong@xiaomi.com>
> ---
>  drivers/phy/freescale/phy-fsl-samsung-hdmi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c b/drivers/phy/f=
reescale/phy-fsl-samsung-hdmi.c
> index 45004f598e4d..0ad766359cbe 100644
> --- a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> +++ b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
> @@ -337,7 +337,7 @@ fsl_samsung_hdmi_phy_configure_pll_lock_det(struct fs=
l_samsung_hdmi_phy *phy,
>         /* Find int_pllclk speed */
>         for (div =3D 0; div < 4; div++) {
>                 int_pllclk =3D pclk / (1 << div);
> -               if (int_pllclk < (50 * MHZ))
> +               if (int_pllclk < (50 * MHZ) || div =3D=3D 3)
>                         break;
>         }
>
> --
> 2.48.1
>

