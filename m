Return-Path: <linux-kernel+bounces-531284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66193A43E6D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 12:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EB97188EE24
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21AC7267B68;
	Tue, 25 Feb 2025 11:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="U3kTrveU"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DED267F59
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 11:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740484591; cv=none; b=hF+C1kNCL5B+HjzcP+i9nxHG+KWZnvIlrIepoXoCNsxHrrF/QEF3UoZiW7QwZz3mAdSrtQavr4PCdc8MQLeHGi45iMTnSHykXvUP3XqY9Rfv0kybBC/H9KvTurIhKckp6SuFJZRGmuyjCUSyAaC4+5X+3GxpyVcdUaRVa2aw3No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740484591; c=relaxed/simple;
	bh=jw4grsK73ycxe7rNsAtJyTCYG51gJibv2ijP91WZ7/0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=n4o+oY92XNEh1L9H8UqgdAll2MNuufkFL3I/u2DwlZJFX+wGXMRCowz/uRHeeAlE2r4lSCa/9r8sHgUN3SsGnhXcyFjSS++Odj42GEV/DiPG0AzEPz7v2FixCcqspe3AnRyDflTzrdAuPjZdyJg0uYo1C0/Bizw+eM1GIz4d0JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=U3kTrveU; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-38f3ee8a119so2699605f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 03:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1740484588; x=1741089388; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fTXeslNQW8wd7byMTnTq+hLFA12VSk6yiKE0BlL47BU=;
        b=U3kTrveUUkFzwroTRmzoJGUx0Npy5dACz/yQmEtYmrbQ+FM/0IMjyYdwTGFX1qSxe/
         efGkQwkx4NFScHlLBLGVGx77Ysg3QKPf/ZAoWTpjvlXkDNdrZ76c3fXzRDfRl+DDUA+D
         bf5H72KKEKP4l4JzIoQn/dwjbz8lGU23LQ1Ap1aH5IuXQF685anpOb23eVaL1Tc5TIxs
         yjekhKtr6rFcnJeSjTDnbxs9Gymq516jbTgX7DqldtV/cLpQ3JlrKjabYNbBn/g0sRtD
         nfDItluypiGuOPznVUu0c0qBz74relhPkRXo+tCkFbwj4afzQkpbEKP6PdKVrvH9SWNg
         L03Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740484588; x=1741089388;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fTXeslNQW8wd7byMTnTq+hLFA12VSk6yiKE0BlL47BU=;
        b=POP1JuyA1WAtMyiJ2hWLbOqQmK0TGMegnXr6+bXvR8nOZdst5s9LeA8THagRHUEYOx
         yo8U7+YpOuMKR7UDLOiY7enhTPetj0g+ShrtmOBbFxl+J9k1xz1SX0gQ/ZuaW0A7HXSN
         BTi2CLahN9EJEftaNUcSDrokFZuoikwm7GiHr3aVwBu4tVpyqsF44l7c/0+wwFTBm22H
         o5tcW2BL4xBpNGT8bHBPzNDEr+JH2w7VI1Nuy8bhQOS2RkOUEjNDjP8qxaSJE5hnDA4g
         89DVBVnKRyEa414gfFRfa8LUocKoWPnKMBsxYtAch/HXSo7U7pfJIDahRDsBI5ifroC0
         Up1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXnfQhB1m6SeHVlTIOJqERXY+KQs7v3J7vmb2WHOhhPalq7FlJ1wIXZFdq0u20IeA8k75hLf+Evo+fRRJc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7Fq4ctAHgmE0r9INM3AWt3b/Gm39Dl3lfgIAPWqAMQGdFKoKD
	MuPzaHC+aj+gxVSbu9tQJZa3yY3vPozOKTGVk78llTL6NXeI533UUKYftRClPh4=
X-Gm-Gg: ASbGncurzyZ56ORcDdjkfqCkrHol2dGCMYTHRlRcI13WACxUt/NrQKlX6F/RtUc0mOF
	L5Nx4bhzp6fvM7pMu1edeKC9coZkndy0OGF9WcwtazQuaLQ/VLLD8mkohdzIIc7+1rf/YN7se5+
	+2SoMWfyY1FHQ2xTwKCjlYSJNeqNF6asJ4GDFGpYdjn+zOZ1YWF2Mk0YHteNBrhZCYdfktdvt9w
	fZ0mPGH7ci0VL6dQg5oLE3crLyI4yDjXP5rTXJcvSW8fTjFa0UXJceSchoRUVrf2d58TBFKRQv6
	Ix48uYZMlYhe41cchpg=
X-Google-Smtp-Source: AGHT+IEBHC3jqRoZ7lBvSyle6e+5x+mlb7hOzvSOgVBIJlyybjIfOr7hAq9kvJ4EvooJ6O7aqUaR4Q==
X-Received: by 2002:a5d:5f51:0:b0:38d:dffc:c133 with SMTP id ffacd0b85a97d-38f70827ad7mr15293026f8f.44.1740484587587;
        Tue, 25 Feb 2025 03:56:27 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:15ae:2cfe:447a:4a32])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd883521sm2058054f8f.56.2025.02.25.03.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 03:56:27 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 0/3] gpiolib: fix bugs in retval sanitization
Date: Tue, 25 Feb 2025 12:56:22 +0100
Message-Id: <20250225-retval-fixes-v1-0-078c4c98517a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOavvWcC/x3LQQqAIBBA0avIrBNGQ6iuEi2GmmogLMaIQLx70
 vLx+RkSq3CCwWRQfiTJGStcY2DeKW5sZakGjz6g98Eq3w8ddpWXkyVH2JPjlrCDulzKf6jHOJX
 yAQfrONleAAAA
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=740;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=jw4grsK73ycxe7rNsAtJyTCYG51gJibv2ijP91WZ7/0=;
 b=owEBbAKT/ZANAwAKARGnLqAUcddyAcsmYgBnva/qgGTgSzrknq2UdAjSMV7eckhdntQDybkhO
 n500OUwoM+JAjIEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ72v6gAKCRARpy6gFHHX
 coRYD/iCW0nHcPPLaGQ6TgazlqbjJNvnAh8mYRANHE7ZHSp1a5ejb42JKuebpvXUy3gJvTviX4z
 3hJ+iKTjikW3YUuqfeeTb29ERY51pP/0C7CeR9ILYliT+GJCRgfHseh9pBEiFmHEBo5u77F2xf3
 TmI0tFLGLTejJ49cTzy7P3OLz3OhG0hTCAqSnuh9MTDucnxPwZ8qIyXt+ni5x3MZOmsiOrDnC7D
 k93pY/Q66b3vfrDDIjDwpfYI20P0qhKrkGGaBrKoGi7SwgpIUnrXDBrxyc8ip426L6HKnJQyHjU
 jIlaLl74ICwVBdiRK47WjyIM9WUN5KotMxfaHO1OPAXSVakWpx/bVIc9ggTjXiESKR6gYvxhoNG
 LvMXo1uj0eFPuMsOPndHgMDEz4SMvb3YuPwC9ej8Q9itGNY00gCKe91IKd4nMQmTepw55Xh/XK2
 EUwDCuC0mCdrBCEtaISrUpsGZQ03noeSBh/SsDj9d5UBpFr3/ZRPd2YFuQRI+S27qO8WJW/NubE
 2RuylAd7O+jT8NTOiGE4rwgHLAq5Ff4Rir1LGTlSofjQsz1e+fdFPbwlFxICDmcaXiYl0UuLzy6
 iIKhLioC6DvIxvE3DrMdu2JoQNQN/dbZrUoOJhYGGwNRHI8IKmnqFeNJqTGa1iJNoYrffnwuC6O
 PcSkB9PjiF3VT
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

Here's a set of fixes to issues spotted in next after queuing the series
adding return value sanitization to GPIO core.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
Bartosz Golaszewski (3):
      gpiolib: don't use gpiochip_get_direction() when registering a chip
      gpiolib: use a more explicit retval logic in gpiochip_get_direction()
      gpiolib: don't double-check the gc->get callback's existence

 drivers/gpio/gpiolib.c | 29 ++++++++---------------------
 1 file changed, 8 insertions(+), 21 deletions(-)
---
base-commit: 0226d0ce98a477937ed295fb7df4cc30b46fc304
change-id: 20250225-retval-fixes-a1a09a1e3a08

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


