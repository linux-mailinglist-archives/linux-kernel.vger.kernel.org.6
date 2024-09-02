Return-Path: <linux-kernel+bounces-310545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC84C967E1B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 05:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 289C41C21337
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 03:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871953E479;
	Mon,  2 Sep 2024 03:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZLnq7cZk"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF2B282EE
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 03:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725247081; cv=none; b=Ee3XgygUGSSbpAMe6z9TcUGh149NZKvHQDVWdyhhBAEwxxQHMDnpE9dA6coK1QzpkCrXMC+f0yCiResa7hulrTAUOKYlrJWm+wRjtBHkeCZKHXkfUNLhXSGfcNaRBNze9LX0gvKPzXvOJQVILVn+alBQEXJcgeW/3wTqp+7qMzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725247081; c=relaxed/simple;
	bh=Nwd1/k7XVCP7K/tGkrGONl9s30ZlQ5ap/hqOYlhX6eM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dySB9bN8+mqbtNV3xugKWulPuYhI3NikaoN0Dm79Xy5L8CSVUf+Hv4Wza7mEUR21FYvOcoe8Qw+xYIVvxC1N9NW9YlHRdCW8oUuQyMqo3C3I/8AzwnU4QxXUbSTpjG3Br0tk/PiCMNdCXf5aoF5Uysik3VdzxeMIdUokTZuCIAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZLnq7cZk; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2d89dbb60bdso936910a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 Sep 2024 20:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725247080; x=1725851880; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T3N7De+0939d6NZS86Emr2LVxI0z0Wq/JpD0yjK8hS8=;
        b=ZLnq7cZkLarO3AvTMcMSxCdC+5odY8BkeOoic2eQAAGKW0cSPcFZViNZiIe63vndq4
         rAXiOTwW08yg9EC5yQ7iwd/t+49dLoqS7j51URWPM/DXN5GwfixAc+1LAx5ysmwBav+D
         hd//Ypxcx1a8mGp343yge4IDwmdJvtC3Jty+w9lr20CjLG308pG0+PYqXQHEQctnWXFC
         q/P8PIYZkiC5Xh84U8X9oav91PREjWXeBf8q7V5PJynnCJt7dr2p8R6pOE/BoQwK1+mA
         cJBkOMLNIYMo5O5uc6p0G/HfgdEvk3Zfx0DRwgescXtQo/GmmP7r1BgAuAir3Ef6txOU
         4BGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725247080; x=1725851880;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T3N7De+0939d6NZS86Emr2LVxI0z0Wq/JpD0yjK8hS8=;
        b=a4j//9et4TA2cdHgkS5tqdKAUxX23AjzWzeFSHB4HFPk2mg3TwiLnUGWQ1OgXYnyXm
         s0KExKzVNJfJhbdyajSmXmgRysGVam9zInfOiKVdEWyZLLrtUpR1avoS1QmyViIk+ntm
         l1aPC2MVmjHVTJFwC/tw/NLhYQykn1lk2Mg8P6nfZvMCEzer8kp5iXep6FwA3xIC5XkO
         q8pEnWANBnaQR7JZgv/OmZ7XoHzQ5sBNCYdVNS+COghkuLnD1TSKgKNGPwynvblzxcMA
         c4lf8cznpboSxwLcFswYr0OXIJy727tIa56Xplksc47vCaSCOwqk4w908OH20B2w1Fbn
         qfgw==
X-Gm-Message-State: AOJu0YyrEGcfmxyzNX74IBhVqvSEt4rDnPnYAxbZfhK6JFlS4AC2vT0P
	91dEEngQMXRg/crw7Q+XzJvDvWqGp+Gy1MdIcIEhfTzmqAI9RtTr
X-Google-Smtp-Source: AGHT+IEWSSoRYKEqR2rJ4k3fUTsPBa9GiQubzHTLYBrHBdJXXXfTtOgchXIWz+c85/pXoZtEse0cwg==
X-Received: by 2002:a17:90b:4b45:b0:2d8:b923:b56a with SMTP id 98e67ed59e1d1-2d8b923b62emr3196107a91.41.1725247079364;
        Sun, 01 Sep 2024 20:17:59 -0700 (PDT)
Received: from den-build ([116.228.68.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d8446f35eesm10365544a91.47.2024.09.01.20.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2024 20:17:58 -0700 (PDT)
Date: Mon, 2 Sep 2024 11:17:53 +0800
From: Richard Clark <richard.xnu.clark@gmail.com>
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	torvalds@linux-foundation.org, richard.xnu.clark@gmail.com
Subject: [PATCH] irq: fix the interrupt trigger type override issue
Message-ID: <ZtUuYXSq8g2Mphuq@den-build>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

In current implementation, the trigger type in 'flags' when calling request_irq
will override the type value get from the firmware(dt/acpi node) if they are
not consistent, and the overrided trigger type value will be retained by irq_data,
consequently the type value get from the firmware will not match the retained one
next time in case the virq is available.

Thus below error message will be observed by the __2nd__ 'insmod' within the
'insmod - rmmod - insmod' operation sequence for the same device driver kernel
module, in which request_irq(..., IRQ_TYPE_LEVEL_HIGH, ...) is used:

	irq: type mismatch, failed to map hwirq-182 for interrupt-controller!

The corresponding 'interrupts' property of that device node is:
	interrupts = <0 150 1>;

This commit fixes the above issue by adding a new checker - irqd_trigger_type_was_set:
the irq_create_fwspec_mapping(...) will return the interrupt number directly if the
trigger type has been set previously.

Signed-off-by: Richard Clark <richard.xnu.clark@gmail.com>
---
 kernel/irq/irqdomain.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index cea8f6874b1f..fb0be8e73c5b 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -895,25 +895,25 @@ unsigned int irq_create_fwspec_mapping(struct irq_fwspec *fwspec)
 	 */
 	virq = irq_find_mapping(domain, hwirq);
 	if (virq) {
+		irq_data = irq_get_irq_data(virq);
+		if (!irq_data) {
+			virq = 0;
+			goto out;
+		}
+
 		/*
 		 * If the trigger type is not specified or matches the
-		 * current trigger type then we are done so return the
-		 * interrupt number.
+		 * current trigger type or has been set previously then we are done so
+		 * return the interrupt number.
 		 */
-		if (type == IRQ_TYPE_NONE || type == irq_get_trigger_type(virq))
+		if (type == IRQ_TYPE_NONE || type == irq_get_trigger_type(virq) ||
+		    irqd_trigger_type_was_set(irq_data))
 			goto out;
-
 		/*
 		 * If the trigger type has not been set yet, then set
 		 * it now and return the interrupt number.
 		 */
 		if (irq_get_trigger_type(virq) == IRQ_TYPE_NONE) {
-			irq_data = irq_get_irq_data(virq);
-			if (!irq_data) {
-				virq = 0;
-				goto out;
-			}
-
 			irqd_set_trigger_type(irq_data, type);
 			goto out;
 		}
-- 
2.34.1


