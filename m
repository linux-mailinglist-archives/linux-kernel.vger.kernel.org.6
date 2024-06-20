Return-Path: <linux-kernel+bounces-222592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C5A91043F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 14:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A948B21B0F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 12:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99011ACE85;
	Thu, 20 Jun 2024 12:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="lh5FwdeX"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7773C1AC42E
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 12:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718886718; cv=none; b=U0p3cbrlFxRNP0qRSw9Wyj9zJnZMVmO1darRqk3XVrvoG4zdlvCM7kJXg+cYWYBEe7bYzUsjQf/Cqh/iN210uovmy7+xiKPSCy/PnWc3DrJ7P3nakWxED8Y3+z22Roncq3b/Rq1nG+9H30URlxvw5lnjooiu0I7Ibqw9/X0N+pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718886718; c=relaxed/simple;
	bh=jCb6yC3LV7RS1SBbrETONCjgbXRTz+kthAeBoPZk3uE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k3wSM0xV3IZw66pt3l0jAKoC7K6nq9SOjU8Q87hroS+PpFBahqu0a8IMfE7mF0HJudvlL1FY+ekJeXZ4ExfJwAi5xyJUa6jy7cDKG2K9KdlSyAmN6GYLJnQkoVc2KhQmRzzlNunBOVt+6hpVBNO5xM9l9E9pgTSKEQyXx0SekLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=lh5FwdeX; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52bc274f438so1138102e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 05:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1718886715; x=1719491515; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jCb6yC3LV7RS1SBbrETONCjgbXRTz+kthAeBoPZk3uE=;
        b=lh5FwdeXYRte/hibWQKRwvHpAFYIEi4E9KdPKeus3b/NANRah3MN0ZsjBIWtkeZVh0
         UtqMe/7gnUesKVU+fpcfpH1NdMZhbwC0GoHk/ufJj+ZiF01CPmlYhqXuKCUVHBVtdQiT
         upTOX59tCycNV1phIJ1oeMjyveovrCUrBZokEp9V6CClnJO5C1T66xMihFPSmiFWGlDC
         QDEfZaY6xEltKwoTSJGwGYesnt79Ti5Wjyf0U68wNTCEP58fmdr5Wis9G8rz4rqF0bl3
         f/aOqzQKDncGmcnJ3Z2wuORCcNOFdBtZ+ByexrEqci5BjwCbDJfFcY15TnZcD8cRf2ic
         clXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718886715; x=1719491515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jCb6yC3LV7RS1SBbrETONCjgbXRTz+kthAeBoPZk3uE=;
        b=N1OjN/PQWY00HoqvzWxKDqCczyaZqt530v2XNtjw9A/+MBvqqC3qkUKGbXYZVXJ9EH
         ufosaa6GkNlbHE9pPKWUhJ7Tuirr4MqR7eZKxlZJdAuzyVEcyE5cLXsZLMokOHOhQolk
         +C7/nigfEZ6NM6yT7WIkGxc5blIZRdLSr3B8C2FlCuwWYmbyhOLtXoY75K01LjSgQ9qi
         JO2lkzCNUuFN4AQm0UiVJ93P53FOVcygYWIw5sRrVOICbQIfW2q6dmu5EPLf3aL6xjH1
         beY0MF6jPxlsnQu5Aiki1SFAclY8AIdWs/uplLTBCl4jVJf6TTsmt9i5MEY09Xc4s8kC
         f8QQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmJ0F89AYK2vn+Tg9wN8WqLKlFotNfbjescJBDw7m3ez6e76tyLuaeYE+Fdq2584TA8PzgxDWvia04wA3ik2XoqOYxIyDq8rU+MDIV
X-Gm-Message-State: AOJu0YzRF4PGfH2C2fC6oNJWThwOc9iml8CYS8IV3BFP2MDvZAn0C/54
	US2lpG3tThVXUPDNyJuhHwzfcH1QnnAqEYHjtoJAf8d1ytOcCjIpU1iaRaj0BcWfU9acxypNziI
	ozT8u+Q6BkpqIhwptRmHDFObDplHa+Gl6bWPZ5d6Pim9jasOGiNE=
X-Google-Smtp-Source: AGHT+IFEBqVhz8d0V1M1pa0KZH9RCnVL/MBWmCY5jwSJkoCnbHQgQ/4ArnXiI+p5/MiLtoJrmvDlZdKPBbVkobzIYGE=
X-Received: by 2002:a05:6512:1242:b0:52c:8837:718a with SMTP id
 2adb3069b0e04-52ccaa918b4mr4529720e87.43.1718886714538; Thu, 20 Jun 2024
 05:31:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619184550.34524-1-brgl@bgdev.pl> <20240619184550.34524-9-brgl@bgdev.pl>
 <ZnQLED/C3Opeim5q@shell.armlinux.org.uk> <ZnQPnrfoia/njFFZ@shell.armlinux.org.uk>
In-Reply-To: <ZnQPnrfoia/njFFZ@shell.armlinux.org.uk>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 20 Jun 2024 14:31:42 +0200
Message-ID: <CAMRc=MeNGQBMZFg3FTtcFzVKU4xMpnm0BxsAgs+++sFDpU9t_g@mail.gmail.com>
Subject: Re: [PATCH net-next 8/8] net: stmmac: qcom-ethqos: add a DMA-reset
 quirk for sa8775p-ride-r3
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Vinod Koul <vkoul@kernel.org>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 1:16=E2=80=AFPM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Thu, Jun 20, 2024 at 11:57:20AM +0100, Russell King (Oracle) wrote:
> > I don't have time to go through stmmac and make any suggestions (sorry)
> > so I can only to say NAK to this change.
>
> Also... where is the cover message? I don't have it, so I don't have the
> context behind your patch series - and I haven't received all the
> patches either.
>

It's in lore alright:
https://lore.kernel.org/netdev/20240619184550.34524-1-brgl@bgdev.pl/

You were in TO for all the patches (as evident from lore) so maybe spam fol=
der?

Bart

