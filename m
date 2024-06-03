Return-Path: <linux-kernel+bounces-198765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D15118D7D21
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 10:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 721111F21E5F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 08:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179CB57CAA;
	Mon,  3 Jun 2024 08:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="oo5FhNmx"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00EE41C76
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 08:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717402636; cv=none; b=os2W0jgHcTqsI3k7l4JTb8arW2SYcJXgbvGohWl2xItAQMI/Xw9RPeEHmV1ejXyIZfzMC1ckwL7kv+udAxrYE2KM0JBaj1u3Zp/4F5l18gm5EgE/Rooae6Rkeuh5XC3Q2H4ksNoD1MmoK4R/oweYxaKQnhn8g74sZr3sO3tGCf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717402636; c=relaxed/simple;
	bh=ydnxOWl2dBIzZnuKszypKD1rZv/wX9sApZtO89araoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bphxHcuzzVIkm33hoPQMe3WO3zpvMCjg5bUGqNSSudjIa3meFO0aVHqlLrb2pDABRP585vkt/AHH40udd+XzKQq7OxXvZR38LcYJL0GQgzQgZSy5a7cz+ub4YSSHcgMCyrIAEUhW4mSemgyjwHBgMIFHDR4pI704aDJXUXw9iIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=oo5FhNmx; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2e95a7545bdso41031351fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 01:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1717402633; x=1718007433; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ydnxOWl2dBIzZnuKszypKD1rZv/wX9sApZtO89araoc=;
        b=oo5FhNmxxzh2dMF5RV7SrdfAw6w7RcUnRHpzcUPNfWvP4zbTgcYRRv3QGcQK7Gw/al
         HiiLXBseusuD82VihyZWi/VE93QrZBoojyPofZ7qmP9Mwi5iB8rh1soFf+wJMgL5x4sS
         xi49gGMsttsbN0vj73s1hUHgBcK8eCpMLNXnFGqKsy4mTZzszuOiO/AzF9NmKyU1yTel
         jUQcaFLzt1yzJn3wqxjlrx3j+SZF9Pego5V0MBBd6+McZMn3JR/wiIzKMO8QAHsoOrXg
         XkPe/cX7L7IrdukY5uLsqAQ2ldKCLwM0F6ppc1NfqUMr35OOwbFS0sbd6p62kdfL64dW
         PJTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717402633; x=1718007433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ydnxOWl2dBIzZnuKszypKD1rZv/wX9sApZtO89araoc=;
        b=ukffEKeOEW6eI8nvG0HAIEaiGbgacAosynzhnrB58g+8vulB5tENzAL1Kj+FSEVO/M
         3RDi8NVJrhWkSf5vrVhhRFJHxTDZ9BYJKlROzOVNbrkBYLxnmcQ67ATnT67+7yflRXHj
         3eTK6eHiPKBaF73eIFzUppXWKlYI34eKiP00F/fm7atcF7iu8cPng5Y5UadEpynxCCqK
         lacL4z4gP7kLRCVrKKs/h7JZwu1DUvg0j307AVJcI1VwXehmRrjqdqMKRWUyd3j/uIyF
         g/T+q8fcL5RttC2Mv6hZtP3lB8H4dGp6tTRxjOwtH1ggC26IIhzZKYaA/7MjjUM47fyz
         dC+A==
X-Gm-Message-State: AOJu0YwGQ8SOUb7fmWqW1tEOPpUAV1WfTjj3ps4TIX6KFM+wTEBSj/bG
	2wchPw6WqESBUkB41RRXSnQLYKHmg+XI5tp5N+TX0VUbuubS0TFdbT5hPdXumK7kTYou05X1vxF
	8MzufPk0fEi6avlg25PH/XKbOT1XB2w3o9qbjSqELqTcrn4Go
X-Google-Smtp-Source: AGHT+IHxDcGbTZJ+j/v1oZ/GQHP2RF96XIwK01e+mgVay6TTL5rBsuo7fofO8lBQV2LFWa+1TGNl44QNh0Hovok1bb8=
X-Received: by 2002:a2e:96ce:0:b0:2e7:5bdd:7d4c with SMTP id
 38308e7fff4ca-2ea95162ae9mr53835021fa.30.1717402632671; Mon, 03 Jun 2024
 01:17:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240602152412.29136-1-laurent.pinchart@ideasonboard.com> <20240602152412.29136-4-laurent.pinchart@ideasonboard.com>
In-Reply-To: <20240602152412.29136-4-laurent.pinchart@ideasonboard.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 3 Jun 2024 10:17:01 +0200
Message-ID: <CAMRc=MeG_BN_A2p_F1UtTSafn0=kK9wCcaDYrYg6XN2DHR47vg@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] gpio: adp5585: Add Analog Devices ADP5585 support
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, 
	Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Haibo Chen <haibo.chen@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 2, 2024 at 5:24=E2=80=AFPM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> From: Haibo Chen <haibo.chen@nxp.com>
>
> The ADP5585 is a 10/11 input/output port expander with a built in keypad
> matrix decoder, programmable logic, reset generator, and PWM generator.
> This driver supports the GPIO function using the platform device
> registered by the core MFD driver.
>
> The driver is derived from an initial implementation from NXP, available
> in commit 451f61b46b76 ("MLK-25917-2 gpio: adp5585-gpio: add
> adp5585-gpio support") in their BSP kernel tree. It has been extensively
> rewritten.
>
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---

If it goes through the MFD tree:

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

