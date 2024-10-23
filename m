Return-Path: <linux-kernel+bounces-377644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D76389AC1CF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 10:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9870E28347B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 08:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E400A16130B;
	Wed, 23 Oct 2024 08:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vSIIW/u/"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DBC15A86A
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 08:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729672560; cv=none; b=ukwhzdo3JhT6f4pL73gHil75snVnZMuEsy74pRWCma+df5/kLA6T2MWopl5oKmvpxctCd4ogmDqO3TQRbgFFW5coDymO+ldRgjcugTDgg8IMGESO6eLRKJsFUoDvKlQxKjs5cPbInU3atNYeIWG/Qqfp+lcDKJUiT/8jtj0aUiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729672560; c=relaxed/simple;
	bh=XANjDqllGmT7dZD62JTbxNbSLbnFk78EEE3Fi0qytB8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=C+zWHZWLIZOae7qJcrRUtX2A9sx0Yu25CbrXDsnthL9g2EDEyQP57XO6zks7yKrmB1lrY732/j+Vcwa6OxHKDtH4/C4BdCO7HK9m/xtWE9Sq+pni/zUUXuCc+4lsNH8hUza275kHua6LTsvTTELcN7Qx+qO5rWRMyWM7i77pA+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vSIIW/u/; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37ed3bd6114so3300176f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 01:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729672557; x=1730277357; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c4seAZLeLBao+DULFomE/haJsRyhT59WrLGt3SlbZ7o=;
        b=vSIIW/u/qTlmnv7yorcsVTR83ovEOTzX72z9osFIk7dTCZ67lzuVelpFCvqh7AgpO+
         zq7mjH47j+0zDS0nzyldaAH4WOLP2NS+i/UYq9icSytiVe47Nma3v24kE31YUW7UCpcb
         gjUnqYhxtCdQOZ0d8YNiMv2wcODmsHrBpAjBj3ydjJk1gCXU4vcUuSp0hvCOBuP89Th4
         G1r/1Rhs0EpbtB8UQCFerCgLJpwX7RUjC6Qsnvqd9wkwqp4nUgW2mRPgLxux0s5ThtBJ
         FcgqMy5+iRk2+KxE+WGj0aE0r6KGEgUnvbeGDWRk6zjJqCxyvtEcpL0Fbuq+3Mt5paxy
         vgFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729672557; x=1730277357;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c4seAZLeLBao+DULFomE/haJsRyhT59WrLGt3SlbZ7o=;
        b=lC55b89oXgEdgwUc1ZPPyUximF2hy7HH+sMvRTMQ0FBtsiSkJBpPfhivGcqNasYIal
         Df2e4GTysODUK1gLz0hI/3wjcF8eIS/pTS4xs7D5IGyIXg+fJIhtXW7/BSNk9kuYHykx
         mR/0/NtPe0F1TqDKDL/65C2Crowd8cbsHlzCtc0Wg5hqizu/Ih1aHg2yTRoMOjXoXtcP
         Lwzxo0IUOeSVEzZ64sgYNyLdrEHXOeoX/ZjibiL5LV+UtsDUjnudgTMa73m1CGg4CxMz
         ji52hFQAvV+mCdsn3EHu8KIy8n1wOcLEqAaQKmBY9R+ur2FaRYenuhzNwqCr4ZUvLXLc
         daZQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+b2Wwma8xrNf8Gv5teieMbOGhou56ZdM8xPJDjozD53sbZvShMLykYz682O+xP6vNIEDZj3pe+Ar8Cc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF4uwiteLi62FJJUMQuHul6ZMNZz4Wsf/WFwhh/HNyH+Duwjyk
	zz2q3XLIIQWzX/ofylUdCdoRFW/9ITqQ9ftgNQs/0FeeKERDfQavFINHCLwBSN4=
X-Google-Smtp-Source: AGHT+IGmggNRvQKAbAwZYa2Tm9b8tKfGWsofERa1h409m9EsubrlrhCiuo5ez/BbwM2CoYy92SzKew==
X-Received: by 2002:a5d:55cc:0:b0:37d:4e80:516 with SMTP id ffacd0b85a97d-37efcf1fe4cmr1093598f8f.34.1729672557127;
        Wed, 23 Oct 2024 01:35:57 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a583edsm8359536f8f.49.2024.10.23.01.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 01:35:56 -0700 (PDT)
Date: Wed, 23 Oct 2024 11:35:53 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] gpio: mb86s7x: remove some dead code in mb86s70_gpio_to_irq()
Message-ID: <b7f3a78b-7163-42a0-bd09-8b3184f29661@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The platform_get_irq() function never returns zero so delete this check.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
I have written more about the history of platform_get_irq() on my blog:
https://staticthinking.wordpress.com/2023/08/07/writing-a-check-for-zero-irq-error-codes/

 drivers/gpio/gpio-mb86s7x.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpio/gpio-mb86s7x.c b/drivers/gpio/gpio-mb86s7x.c
index 7efc9fc6f4cd..7ee891ef6905 100644
--- a/drivers/gpio/gpio-mb86s7x.c
+++ b/drivers/gpio/gpio-mb86s7x.c
@@ -145,8 +145,6 @@ static int mb86s70_gpio_to_irq(struct gpio_chip *gc, unsigned int offset)
 		irq = platform_get_irq(to_platform_device(gc->parent), index);
 		if (irq < 0)
 			return irq;
-		if (irq == 0)
-			break;
 		if (irq_get_irq_data(irq)->hwirq == offset)
 			return irq;
 	}
-- 
2.45.2


