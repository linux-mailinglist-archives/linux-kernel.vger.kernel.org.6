Return-Path: <linux-kernel+bounces-195769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 101DC8D51A1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 20:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FC581C23309
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 18:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810F94DA10;
	Thu, 30 May 2024 18:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JbELKxnw"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E494C62B
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 18:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717092444; cv=none; b=VUmTpouNo44o37DXXHnEuBikvscQ2Ifv2dP8u6y2CXnfQKKHvc5K0nSmZM8LJFGdR1VhRyEYuCNG8wh2gKAzOI9X2ts8gZpXcWeBvMQ1US5sWj6+00zYXzn/CSCMR1ZYFl2v7tEsjufkns2Kt+QyE0DMosY5OLq/1fa65NF8wx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717092444; c=relaxed/simple;
	bh=j27AxGHEZKMmeJIIwPagI+4gamOMev7x0iEQzPnvbvI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YU3Al7mWboGY1Uvv149dFdsPHwAs9ms62324vnf0/s5apNLDf4cGdc0rBH0a2bt3TTPMpAkcENiRrt4WyIdNlIhI660f+zZgBnF67EX/1jfAgybu6+dqdDnQFMaePDC6b5WE/ySZW7gP43Blr5rpkCo+ZLCfx0BCMGE3cHg9LF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JbELKxnw; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1f48bd643a0so8821465ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 11:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717092443; x=1717697243; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZCBMRcsvlIlqx28L54Rw86q+aPP2pQJ5/hACrELl3Kw=;
        b=JbELKxnwFN2zF8EotiFULQEINBncPojd17A7zPQW98I9znemcpAYxe0ifuHRACc4Vg
         gqGqLxOLqSJqc9vMkQr5waZ4cOBz2q+MWd2rtP2pJ8PUzM0u2u3ZoDjvahHX7u5IEQqK
         z3B69GDkn+k7tBJaBzJOhc6IXRA+mkk7dEFBBRzyJVKYE4njdZUWsBeEFJVSfCdl4nCP
         bAGsMqDP3bxHpyF0xbOgXryF460cO84w+ynsmfvg9uZA7uGIdLFG2tpB3FxE043l4Kjd
         F8D+0gUYn2XX8+ozLcupDogL5I2Rbf7wWTzVfLOOdg0BR17hDtSjj0eyDQhYjhKUZMPM
         7QOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717092443; x=1717697243;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZCBMRcsvlIlqx28L54Rw86q+aPP2pQJ5/hACrELl3Kw=;
        b=X/Xxp7Ju6nFwune+Dz6OrVO93ncNYIcti7KZexGmVIpx0epkCu0TiIE+mGGO7zVnsm
         sxwfZjes0dC1YFDXHh5DpAJfAzLuqKv2kX/fTJF9cQgZ113Oe1Xl/S1PRdnbV7hc3fKH
         D/4IPBJABjleUpBTEj749SKsYAGk/zEqIVVPbmjnrw3UPRyZqTcI5KZKJ7eTUHb6ip/v
         BpESkgC6e+D5G6BJ/ubaxrIO2fOp2YPgGZaNu0XNn88m77Y54oguTYY6m+p1JeRci8Nj
         cciXFae5nt81H55w68v1NLNRJCLXDtpBVnG5Ywpvt8HIxjTVAUNtTAJxUciM6nSQi4hV
         7+Lw==
X-Gm-Message-State: AOJu0Yzf0ZD3fWrqzoB6rdrj/1Pw+dwjHNXoQCJ/1pKPp2/Be6NcdSQZ
	MPEgdxCn5cV0a/RSfjp+qLOp5frKQkq2rqwElzEbiLj4bcrbyAkudq6Y7Q==
X-Google-Smtp-Source: AGHT+IGoPLNvivXW5qjFVgwnIkG9DomDt067b3kCherll62AidJs7g8cljwoEt2zRLQhajxXjNSZgw==
X-Received: by 2002:a17:903:22c7:b0:1f4:9759:b226 with SMTP id d9443c01a7336-1f619932b65mr34806945ad.52.1717092442400;
        Thu, 30 May 2024 11:07:22 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:509f:4b2e:3586:eb1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f63235561csm791685ad.70.2024.05.30.11.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 11:07:22 -0700 (PDT)
Date: Thu, 30 May 2024 11:07:19 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH] linux/interrupt.h: allow "guard" notation to disable and
 reenable IRQ
Message-ID: <ZljAV6HjkPSEhWSw@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Drivers often need to first disable an interrupt, carry out some
action, and then reenable the interrupt. Introduce support for the
"guard" notation for this so that the following is possible:

	...

	scoped_cond_guard(mutex_intr, return -EINTR, &data->sysfs_mutex) {
		guard(disable_irq)(&client->irq);

		error = elan_acquire_baseline(data);
		if (error)
			return error;
	}

	...

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 include/linux/interrupt.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 5c9bdd3ffccc..3a36e64119c8 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -5,6 +5,7 @@
 
 #include <linux/kernel.h>
 #include <linux/bitops.h>
+#include <linux/cleanup.h>
 #include <linux/cpumask.h>
 #include <linux/irqreturn.h>
 #include <linux/irqnr.h>
@@ -235,6 +236,9 @@ extern void enable_percpu_irq(unsigned int irq, unsigned int type);
 extern bool irq_percpu_is_enabled(unsigned int irq);
 extern void irq_wake_thread(unsigned int irq, void *dev_id);
 
+DEFINE_LOCK_GUARD_1(disable_irq, int,
+		    disable_irq(*_T->lock), enable_irq(*_T->lock))
+
 extern void disable_nmi_nosync(unsigned int irq);
 extern void disable_percpu_nmi(unsigned int irq);
 extern void enable_nmi(unsigned int irq);
-- 
2.45.1.288.g0e0cd299f1-goog


-- 
Dmitry

