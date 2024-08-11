Return-Path: <linux-kernel+bounces-282357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 305C594E2C2
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 21:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E67EB20E79
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 19:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A2B14B96F;
	Sun, 11 Aug 2024 19:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="0rRvsfug"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202B31D699
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 19:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723404438; cv=none; b=SJ8MQ//W5FikD2X8WTdu8lm1KDwbBAoh1YZvzNE5Jpre44IEh3LDL92UbmypwU6jhNCyCMzTHk/8x7inVM23Tteo/UOJkNBFRgAms2gWBA2fzCySK6ZcmakqsxCRXPKxazncUjZt20LY7WB8lW9yLPJLTH6KylrGwA4lqVZoYX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723404438; c=relaxed/simple;
	bh=fCMtz0tuHOR4dScOQBteNQbide3c0rC1YBKQmUX5DnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KV74g73CvNVsWmkrp2uE91fWCzcFgmzRgB3cKKx7IiD20pJy6uPqiF1LPY4CBteCSHEz+SKyIrmpAb3knBpeiVvMX/zVtECPm8N8XUSbxPGFdiVO/+Ba//jP3BsIMZcs/jNc4qCFt2UjShr0d8cUrsoKA2qadUthUPV5TfBPm9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=0rRvsfug; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4280ee5f1e3so27934205e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 12:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1723404435; x=1724009235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qi4pCNP1Gdr9h0T5um8ZgiG7jkuJMsbVZXb0oh3Hft4=;
        b=0rRvsfugDJv6Q2bwnrcxrI07Te9szTqH9lP6AQX0nFozBLLc6scN3kD5VDmKlIRiiQ
         8RCEtzadsUavkwPOGRFIn7Dy54nA4eS7QxzHkHm+7QCXXJUljVqbTBTdIFqiEHKr7Hjt
         TgxKuY4pH+qIlm9542kb3x4rOhaa1L/F98uKMRxwYBDUPcWpjDxSad+u5DP4rYasmbOY
         O72Owsi5n8HUgIgUkJ3X1DPTY8pfsZBDS4KD9G+UMmVRvK33RAjCBcDJo4kj2G/OWD6M
         xZ0NAzzalFBT1XEdF2pFQgfUwZG2Ge5XdOiMl6L/95Rmpizob4dfJxrXu/68fzE1I5fK
         3BSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723404435; x=1724009235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qi4pCNP1Gdr9h0T5um8ZgiG7jkuJMsbVZXb0oh3Hft4=;
        b=F1fcIm1Y9/14BtG0hYFikxcZ+goSOsb7567heCad+VTHV54HH/tT445jjehU11ogvU
         Yj9p9MTVpFCc7hgudpp83T+Z8XQiJDal7DZ9GI0SeE/L5iqrKMkHZNX3DZDIejplxS7w
         ylDoQgnk7Y1qYShmWO+Mz/H/fW83OIbUlINkxYuZ9DQyepXDvOfmHN8WJaygen/qv18W
         nLQY3wS1kTLCQL2o5VGD3ktov0knKqP37q7tvnEj/D+KIqzx5rCd+JWS1/rRPGrC1GNl
         jsQaISjIiLzmPKj4rEGW/uMj3QfgGi/jkGqSAgF1JcK2mTpPG7LxE8FtY2crsC6FaUZB
         ZDHg==
X-Forwarded-Encrypted: i=1; AJvYcCW3gQsSr+dzyYV0gWHuXGE7n4iFc5H0ACCG/6clhN/IRQp5Ne8p2w6rtiCgC7XJHtZ+YMJSQjO+II9fg0Ufo5iHI10Jsja+26XYMgYp
X-Gm-Message-State: AOJu0YzaHotUjtNM5QVH/+bZQ0qaGRiU03WDWuxJ3fL0tORGP+4IT2Z/
	HCiRL7CdDbuSQIhcBGTSZ5ww3DljLK6M5tgtPuToPYXkKoQtmm1NMbKfst5UHwU=
X-Google-Smtp-Source: AGHT+IGagufT2xNn/QKQu3bmVrV6jU72TWeF3FBl77gAzQllDDZ8/5qNg/Q6eq++X65pc/tFy4d3Pw==
X-Received: by 2002:adf:f349:0:b0:368:664a:d4f9 with SMTP id ffacd0b85a97d-36d5eb08646mr5681407f8f.28.1723404435210;
        Sun, 11 Aug 2024 12:27:15 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:6978:7b03:bbeb:d1af])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4cfefe71sm5552517f8f.62.2024.08.11.12.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 12:27:14 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: brgl@bgdev.pl,
	Heiko Stuebner <heiko@sntech.de>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ukleinek@debian.org,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 1/2] dt-bindings: eeprom: at24: Add compatible for Giantec GT24C04A
Date: Sun, 11 Aug 2024 21:27:13 +0200
Message-ID: <172340442666.7060.12608274118090495917.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240810211438.286441-2-heiko@sntech.de>
References: <20240810211438.286441-1-heiko@sntech.de> <20240810211438.286441-2-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Sat, 10 Aug 2024 23:14:37 +0200, Heiko Stuebner wrote:
> The gt24c04a is just yet another 2404 compatible eeprom, and does not
> follow the generic naming matching, so add a separate compatible for it.
> 
> 

Applied, thanks!

[1/2] dt-bindings: eeprom: at24: Add compatible for Giantec GT24C04A
      commit: a825dea2cd27a30e49816f18b7bc16545d5f0f89

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

