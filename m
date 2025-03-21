Return-Path: <linux-kernel+bounces-571548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1846AA6BEB1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 16:51:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12BEB3B8A81
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 15:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B5B227E9B;
	Fri, 21 Mar 2025 15:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="FSRtlb2H"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B903F1DE4CE
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 15:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742572192; cv=none; b=gDSxTUeh0gWwWFGyOxGwP6hFg4pombiHtRqtPoxSAf6QXs8hdcv/MSdTL9aMJ8pWyVccaDV8LjhiFchLPWGFL6PPf/vz4FcvihORejxdlilT56+Og7emi5JBWxoQh8mH33JCqFzuFSNlK8JGDi9Ihaky0MDWKD37s2m70ypPWY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742572192; c=relaxed/simple;
	bh=wCryCeTji9z+l3BRY73vuHL8dSisONmzkMMBaMEHPSQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lAX0leEBGI64ZzpEBC7tnGLI04joxMHvm/dPunkM3M1G6Zji7NG2J4kVAh65BDUDazxraBiP/Mgre3nz/7BSVTLzjjD6O0wJnLh5GPlSVFULcIkku0zbgm+fIE/4DJeu2ThdcylfmsFijZ2smCVx1PY8PAZW1F5xnFcb7De0MRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=FSRtlb2H; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3912baafc58so1756111f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 08:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1742572187; x=1743176987; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vRFYQEc1/AnB7Qk/B6GtdNGwcPqMS/OESaxUTMbOma4=;
        b=FSRtlb2H0ij4pmijJ8QTZrvs/JO0it3s7pRAcpDWenkhYiNep+DGeXVStzFwF/rPMJ
         u4Fgr11rHz4melVZFsaptxo+ov/q8fTVQqgYxg8yo+ISRJOwDWx+GtkYoxbJu69n0c9D
         IeZ75kA/GIr2YAQBzVg77ly0vOPzjhqOxc+kgYPxiKZzLwEqsBDHmKt016EimlByg0Bj
         mJ6XZ9qaqBYv73ig4M8ny4Bcw95/mj04saPgJY70D3x6Y2zJhBN8B4ZiDOfkg8AGUl1M
         2sLQ4GNwURjsX1vf5jPYwxRX4UCkYGSKoRU62mwAg7J1CEcId7yBl7lN/86mrOVx4q59
         p7IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742572187; x=1743176987;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vRFYQEc1/AnB7Qk/B6GtdNGwcPqMS/OESaxUTMbOma4=;
        b=i6M1bx416NiYT4JyJ68GOkf7YLj4kPcUZ2cBMBDKDU0HSRFfEcoXsBY+QblZRlbDpz
         6IMIQqPn4Wd2uL5jimS8cAvZEGW6oQWCDCKEVq9VxmOdxFy5Mb+zPnlX1nmJaHKQzQpX
         twgBhECIKNuxLlF+LPGW9knfG97xOvLwdp14iW0svFQzDeCg8ZQmgbTHrPjSWGAF42GW
         8996xMC1+0ggR7PWOmQKTh+Sth2CIALgMtlv6Z7O9IZqhkaT0TJ/SbSHQ62kO0TuUwFR
         M9ytM9GqgaAn7AJHBnRtNCXoG160guYp2/gwtHVidQGv8o5ELc2tLXIuHEPF5744djpD
         p0nw==
X-Forwarded-Encrypted: i=1; AJvYcCVw8BDGoOeNa+f8sMP37JPs/fS7MSgUPLBWY++sMgDITPnTqycvJEBHdCZl/mwRttiDqIooJ8UFYbleGtA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvePsdG/UiAwTbG+sjJohBa+tKVEHolAKhGPVgIHYtmQucBfYq
	D+kkz271Fua3JvCxfXCQVvNf1jiXYH9F5jz1xx8Kovbw2+07fhMX03uBymRWajqoWmT9DdfFUB9
	3
X-Gm-Gg: ASbGncskmD0Avm8uqsBIjKUEinoMIgar/6p2OHDsjMJJmPmdmkgbuKeE7IFa8/fBOCB
	GmTKlmBw5SXeMfmhjpBZSnnog10OsInI6PUxTnizY9nODPbN3RdhfBvBa4JmBEaxdSkoFDPUMrw
	Kl/FeZaR+JtjdSg74QvMBcfRo8nmCMjdJBlnGi2TLU+jHOv2wjR8pt3jqIp8v7dL9BO9zDcPbwi
	C3zamxsGuhgkFKQ9v5T6JQ3PseaSldvqe6GzjmjcfsJrAAQj0R2r3q78UEN7bESMQ39vTgcnP3X
	5foHx7lVu2SyQML7W309s8oCvq89nsWJ5Hpg/A==
X-Google-Smtp-Source: AGHT+IETwNIgi94lLdjAdGfdwQRhGw5FZ9fshyAOJpuVuTGfLMNBguhMUR+gJEky4ZZyufE/CE7CuA==
X-Received: by 2002:a5d:5f96:0:b0:391:fcc:9ee8 with SMTP id ffacd0b85a97d-3997f912529mr3661173f8f.23.1742572187419;
        Fri, 21 Mar 2025 08:49:47 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:1aa4:f3ec:847a:32d1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9a3b4bsm2664406f8f.25.2025.03.21.08.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 08:49:47 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 21 Mar 2025 16:49:33 +0100
Subject: [PATCH 1/6] gpio: TODO: remove the item about the new debugfs
 interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250321-gpio-todo-updates-v1-1-7b38f07110ee@linaro.org>
References: <20250321-gpio-todo-updates-v1-0-7b38f07110ee@linaro.org>
In-Reply-To: <20250321-gpio-todo-updates-v1-0-7b38f07110ee@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2470;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=wdL+OKAjw1IH0HSGRarL/B7X1Jbr68CDvNMAAbARso0=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBn3YqY+eO7xsW2SOOoNalGMEC3nIE5fQEeyXYNu
 C7+MtmOt6qJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ92KmAAKCRARpy6gFHHX
 cjjDEACUdUh9u4G6a7nZ38JQTvoUong4yxXKo114w46Cr8MRAEYvrjDEOmces4FI9YkqPYFXVAu
 34c+p0CBwTn/NB9Z3DQsn6AyT01ubB1O4m40tJrBl95xfWlLowgVoePp/FYgjBxgAlZZmkXNZPw
 IageYREwK/zCI3atdwUuW2l1G94D2WMS6aEAzsroWogQHSIuj/10m4C+aLJxgbl001q8Kgjgli6
 6+S7h5QLL0g7/UPxOtlSdeG7aBkCSY96ZDphrafT5j2EXrM9SByxO7qR8ZFAgbEL96Yc5RMdGA+
 LlkHHNs3XiMbu97B8ppR/pXpM9llaK2HJaHtYVTZ66ObQ4csCQJMcTG7R0v9DyiFyo5uP5+1PdP
 yy5pI2l0La2JixCrfI+4Iug1odM+oznr1IdjNa++l5MZTE3xjWqUEep9tJkfFCclL0eKZsN9fgz
 CGl8ckKcglney2WyEV25U2KtpkL9D6KQAGg45ts0PTiT17mOhnoK3WFYsgyaXMKflOZuZQV0U6D
 EUrIJjdznImvI6Pwl57Q3zRdtawmDLsKx1r7KV8a3xL40VqfNL4+l664G/vfAY8/LXM+h6KKqrk
 r/hKGjM5jYs0LorwAqMsESFAM35/PBfc1xxmsW7WCGe++9LHBj0ABgxbPs1wK7nVZF1Kq+y84Mt
 hVAHIwwfszHFcKg==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The consensus among core GPIO stakeholders seems to be that a new
debugfs interface will only increase maintenance burden and will fail
to attract users that care about long-term stability of the ABI[1].
Let's not go this way and not add a fourth user-facing interface to the
GPIO subsystem.

[1] https://lore.kernel.org/all/9d3f1ca4-d865-45af-9032-c38cacc7fe93@pengutronix.de/

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/TODO | 36 ------------------------------------
 1 file changed, 36 deletions(-)

diff --git a/drivers/gpio/TODO b/drivers/gpio/TODO
index 942d1cd2bd3c9..9cf7b84cdb869 100644
--- a/drivers/gpio/TODO
+++ b/drivers/gpio/TODO
@@ -156,42 +156,6 @@ multiplexing, pin configuration, GPIO, etc selectable options in one
 and the same pin control and GPIO subsystem.
 
 
-Debugfs in place of sysfs
-
-The old sysfs code that enables simple uses of GPIOs from the
-command line is still popular despite the existance of the proper
-character device. The reason is that it is simple to use on
-root filesystems where you only have a minimal set of tools such
-as "cat", "echo" etc.
-
-The old sysfs still need to be strongly deprecated and removed
-as it relies on the global GPIO numberspace that assume a strict
-order of global GPIO numbers that do not change between boots
-and is independent of probe order.
-
-To solve this and provide an ABI that people can use for hacks
-and development, implement a debugfs interface to manipulate
-GPIO lines that can do everything that sysfs can do today: one
-directory per gpiochip and one file entry per line:
-
-/sys/kernel/debug/gpiochip/gpiochip0
-/sys/kernel/debug/gpiochip/gpiochip0/gpio0
-/sys/kernel/debug/gpiochip/gpiochip0/gpio1
-/sys/kernel/debug/gpiochip/gpiochip0/gpio2
-/sys/kernel/debug/gpiochip/gpiochip0/gpio3
-...
-/sys/kernel/debug/gpiochip/gpiochip1
-/sys/kernel/debug/gpiochip/gpiochip1/gpio0
-/sys/kernel/debug/gpiochip/gpiochip1/gpio1
-...
-
-The exact files and design of the debugfs interface can be
-discussed but the idea is to provide a low-level access point
-for debugging and hacking and to expose all lines without the
-need of any exporting. Also provide ample ammunition to shoot
-oneself in the foot, because this is debugfs after all.
-
-
 Moving over to immutable irq_chip structures
 
 Most of the gpio chips implementing interrupt support rely on gpiolib

-- 
2.45.2


