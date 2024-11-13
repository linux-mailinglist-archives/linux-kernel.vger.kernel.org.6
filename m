Return-Path: <linux-kernel+bounces-407909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D21F9C775E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 16:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CEF2281866
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 15:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410B41632D9;
	Wed, 13 Nov 2024 15:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ETZwWDqb"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A711E16087B
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 15:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731511858; cv=none; b=BW+K9nOyKzeISembqcE9s3JamRexs55muuiVGQvijrwX1cdr8nqMl23utKhkc/te4NDTYUGleHqIZ5jGr6+kWyQyMKWy31zlL8YZ28M5GDupWwe3D+TlcA0ya7hoj1gASRnxBoCfh6hOGNJIejc0Z+rh0rZykRxKbU+2Bx/Cg0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731511858; c=relaxed/simple;
	bh=haEridOgQHCmmtKLPgrZed4sltMc33ZVnB/hDcfhsf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qf1DBUnr+9YYWfobxtkytaroAr9H+2oUm4ZS1TImkehcl6XDmQLrnKqYaLCJ3nwrG5r1XWmg15oo+pEWOWzo+sQwPZz8zdZdaGUAxdk2EthSr8vVHCiew8kblB/R3sP7MgSfvxrfFov3SRd9/lzV3qzvv4bqn0bvPpqvdIZ7Kvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=ETZwWDqb; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37d6a2aa748so4308979f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 07:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1731511855; x=1732116655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n5Is3Oh7ydLFl6T+vL0M6CtHoi+ednqbxLHSW9hK3aU=;
        b=ETZwWDqb24MUuuUSC7MFruZgjDSWo/DYFNBvtZr/iE0bV9WAlDgysLACcmSf+DvXL1
         g23xtQSWaPt8T3Xw62YqfHzdzHVXlpUA2phI50orTbxGhz75EscLlFTJtg6srC4LCyK8
         BBJeLkM/7lY9vOwTaOgUgfqklhU1oR3AmDY2Xqehv8VMMYUykGl11Ts45lhoimG78ZGP
         5cST2tzGOGgUqL8YP3rMwjgIpKxWeEnisTH/1vaqqUk9fgYNZ9jwRYCtM/zrmAxl/K+V
         OfCjAVFTTg71gvSWQ13LqM9aMl+gYbP+SP4ruHQyPifXcg65D/aGBGy+QAdZRBcWh74e
         VLQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731511855; x=1732116655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n5Is3Oh7ydLFl6T+vL0M6CtHoi+ednqbxLHSW9hK3aU=;
        b=M8xJK8KQR/7cQ2jG3lv32hX0kOaswU8of7yDpVTn2gWr2N+SQxIW0GYijXX/32CG1I
         8S2MgDQMrf2/QWUM2MEAmDejfUrG5ZBf3tnpFqMsNqQ3FlcBPz515y3lTIsNxjz7yETw
         Nq0Ia88s7B7iEBtYAgguf3dN1E9rG11CfaJy4YmPK0ZY+uPv4u18fta7JGT6Sl0+dyrF
         kX7FRlon6IEPunD/4ZnUEJfO35CtRrIKxXcOTqInKzsH1cKsGfMmRtSAcLZHA3Q3rioa
         4BIlYvqqPZyccJE7rs3izyk621gqGzdFFSEbao952FvHBgnGbgG8wtVIjFnniqIue8QK
         eE3A==
X-Forwarded-Encrypted: i=1; AJvYcCXEMK0el0OSE0S2GfG8+wRCWbJ43BeTLem9Z9A1E1AnYQSAZcV0jOA1c8odSJS1+Qgs6TAESSKePMgHlLU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVY5Wzb426Sq+6UoRUGhVD1jajymzHWhRo/yipcRn1aScRKw+8
	7I7+d0JGZXfwJDWVFipLndaSo7PabyR4OiLRtpQr/iyuEHf56kZBx3Ka+sg65AQ=
X-Google-Smtp-Source: AGHT+IFxiR/WL41z6iEsuMbw3qc6EJEwdN3TZBFGtfwYiY7iyMeJYUsl2YzrRMkMb4yvLW4eiUSS/A==
X-Received: by 2002:a05:6000:2aa:b0:37e:f1ed:67e8 with SMTP id ffacd0b85a97d-381f186dd5cmr16703079f8f.35.1731511854613;
        Wed, 13 Nov 2024 07:30:54 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:1b75:191:f7eb:da75])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed9ea4ebsm18689381f8f.69.2024.11.13.07.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 07:30:53 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: linux-gpio@vger.kernel.org,
	Conor Dooley <conor@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/1] polarfire gpio driver follow-ups
Date: Wed, 13 Nov 2024 16:30:51 +0100
Message-ID: <173151177291.90710.9989301559939159522.b4-ty@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241113-ramble-blaspheme-b303dbf37271@spud>
References: <20241113-ramble-blaspheme-b303dbf37271@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Wed, 13 Nov 2024 12:01:03 +0000, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> Yo,
> 
> I realised last week, while rebasing the interrupt portion of the
> driver, that coregpio a compatible in the kernel as well as a dts user.
> Given how long the driver has taken to even get partially accepted, I
> waited to get it to gpio/for-next rather than showing up with last
> minute additions to it.
> 
> [...]

Applied, thanks!

[1/1] gpio: mpfs: add CoreGPIO support
      commit: 65e936372d8f56f9faf3879925738cecc0a5f7e7

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

