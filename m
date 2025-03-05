Return-Path: <linux-kernel+bounces-547903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A09A50F12
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 23:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0DD61892B61
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 22:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194CF1FC7FE;
	Wed,  5 Mar 2025 22:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="T9TQvKwL"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9AFA1D8DEE
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 22:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741215038; cv=none; b=BNTlBEn7WbQ+EpQpmkQ0e4XQg7uw3pUYWCC57a07EHfwbW75KIb/uUcHPZZgS1nNpd0m1ZkQKyHIfD38QnA6yZH2/mVd1Mcw1P0MNPQUQd6rhMJZBRiWX53PyFHkyMmnLcKg4wRK2hQJ7xyiVJk9KL2BbS9E/czXw/FGI0PnFOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741215038; c=relaxed/simple;
	bh=hINIG5kxOwV7liYzl/+ZFhE/Yh0+VkapvzoZ/yUMGP8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=to0XfuNNmhdUrq2o3rtGHzTkgCcBmCMIUH2jGEbE32or1qYprQ4gypVWcmqKhojb/bDYNJ5pwTGUg9aqNLX2dsXLt0FE82a0XFwFLtMSxLhJMHFzUIRjgjYs4OHM01cTbiD3SF0dN8iMD3AJWMvEzj/kZlGbReQcC/HQJsZvxDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=google.com; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=T9TQvKwL; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-474e1b8c935so99151cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 14:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741215035; x=1741819835; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RsjM4YASNleulr3tBXWY5lzfU3eAoHcF5KVgOaYjt5c=;
        b=T9TQvKwLN2u+9y36lckxvdsuTFx31lvq1x1zggBu878diCilZ7xUW+aqF5EBspIg0A
         HUaVZQAK7KkQx4aRLCsS56FN2fqEvRpI8JhGXQIHDTM7FxQvld3ErSslCA2ebNzk7eGq
         GNqny3TiwsJ+IiVthCaZJMfHX3zKrijEWOXdg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741215035; x=1741819835;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RsjM4YASNleulr3tBXWY5lzfU3eAoHcF5KVgOaYjt5c=;
        b=jzkqWcY5V6AWKcvDxsluq7Sh0nU9x+2M3IPYzsR/dlMnj7QTXrJX13Ed6Rmieebn3p
         MeskGLyECNRsB4xR/vALCnt0gxbMHcMT6rcVtq5Z5Cb/FGbGG6bXX1ekKWCHwRYObZW3
         7A5DepGomdmOMfbJG4nZofXB43JA9ZkrRkDXpxQ/bEMFfkmjq5WuVXx8WCvwG2Z0UoU9
         lP2G7Re0WJBNKGyeIcK+jQLqXhvTpdguZ6LO8hp48BcWmYj6vgFXUlpfuG3cpWf0b70i
         7BLfrjD+WbJjrFQzmjCFb26e833s6pS7aam3XlWl1nMLZCdg6Sbgdvc4vnLNcBNuj94B
         okFQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/jTxAWBayy+8nJv9/hP3v/cGaIARpxjV7whki5d1wHbo6K4JqTJxitJROlKuIcugjxuQQpOhW+bohZB8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6Kb4+gWKkyEF16FrhjYTkCvX8M8v/e0+uVRwMUiiy/86eAjv5
	ku+IOlCX1muAAKr81EmfRXaHLfel98qn7MrsfJ9R9U8UbDj8yLCh9r75pv1DQhDCVpkowJNsQ4O
	0b9EOOJEoohc5XzIdI1/dBb8XsFkArIf9lvJ6
X-Gm-Gg: ASbGncvIqBr5TrIpF8KKxhWHp1pfiUE2vFFpubeOaZdg9wGGdjcFzBR5djLCh01molq
	au/KFykNXiU5qFAVXDRV36aro25l4ZsiBk7m+pnRN0rtQMh4cySzLbXqDS905AzP/2YYaYLAezj
	tU3I1a6Z6VsyKkDH8RYeG2fSjwMJDL86ZmM39Ka3e6P1KDdlkn1SPts3Hbxbc=
X-Google-Smtp-Source: AGHT+IHvK+t3RyIjKaNCRJHSF0lsNgux1FRjfJb7Y820KcKp5rPghSBOwl1IAFSXci0ouoP0BoEyc1UcQ1d61NKzM3g=
X-Received: by 2002:ac8:5905:0:b0:475:1754:e044 with SMTP id
 d75a77b69052e-4751c567b75mr312741cf.3.1741215034513; Wed, 05 Mar 2025
 14:50:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305101025.2279951-1-george.cherian@marvell.com> <20250305101025.2279951-2-george.cherian@marvell.com>
In-Reply-To: <20250305101025.2279951-2-george.cherian@marvell.com>
From: Julius Werner <jwerner@chromium.org>
Date: Wed, 5 Mar 2025 14:50:20 -0800
X-Gm-Features: AQ5f1Jq5WN2NBjpsa146UgayYxAH8L0biqGumwPp8sUUsQ-SzcQC8JeVH7zSTCI
Message-ID: <CAODwPW_3BCfTcTu=K+6Q3PMe8DtWTiKFHC6+HO2q+cTqs=EPAA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] watchdog: Add a new flag WDIOF_STOP_MAYSLEEP
To: George Cherian <george.cherian@marvell.com>
Cc: linux@roeck-us.net, wim@linux-watchdog.org, jwerner@chromium.org, 
	evanbenn@chromium.org, kabel@kernel.org, krzk@kernel.org, 
	mazziesaccount@gmail.com, thomas.richard@bootlin.com, lma@chromium.org, 
	bleung@chromium.org, support.opensource@diasemi.com, shawnguo@kernel.org, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, 
	andy@kernel.org, paul@crapouillou.net, alexander.usyskin@intel.com, 
	andreas.werner@men.de, daniel@thingy.jp, romain.perier@gmail.com, 
	avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com, 
	venture@google.com, yuenn@google.com, benjaminfair@google.com, 
	maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	christophe.leroy@csgroup.eu, naveen@kernel.org, mwalle@kernel.org, 
	xingyu.wu@starfivetech.com, ziv.xu@starfivetech.com, 
	hayashi.kunihiko@socionext.com, mhiramat@kernel.org, 
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, chrome-platform@lists.linux.dev, 
	imx@lists.linux.dev, linux-mips@vger.kernel.org, openbmc@lists.ozlabs.org, 
	linuxppc-dev@lists.ozlabs.org, patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"

>  static const struct watchdog_ops adv_ec_wdt_ops = {
> diff --git a/drivers/watchdog/arm_smc_wdt.c b/drivers/watchdog/arm_smc_wdt.c
> index 8f3d0c3a005f..794cf0086912 100644
> --- a/drivers/watchdog/arm_smc_wdt.c
> +++ b/drivers/watchdog/arm_smc_wdt.c
> @@ -90,7 +90,8 @@ static const struct watchdog_info smcwd_info = {
>         .identity       = DRV_NAME,
>         .options        = WDIOF_SETTIMEOUT |
>                           WDIOF_KEEPALIVEPING |
> -                         WDIOF_MAGICCLOSE,
> +                         WDIOF_MAGICCLOSE |
> +                         WDIOF_STOP_MAYSLEEP,
>  };

I don't think this driver can sleep, unless I'm missing something?
`arm_smccc_smc()` does a synchronous call into firmware that always
returns back to the caller.

