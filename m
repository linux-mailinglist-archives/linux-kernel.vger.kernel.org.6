Return-Path: <linux-kernel+bounces-272831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8FB9461AD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 18:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC8DD1F21894
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 16:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9CD1A83B2;
	Fri,  2 Aug 2024 16:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e2zQbNLz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mHHRCZP0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D701537CB
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 16:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722615345; cv=none; b=tTmBEzcQAQyemCecZaeYOIbcFMYqPowHq7AVPtk36FcL3901HEoLOhXjqcE5QaPxvGcRgQmsFR80u8mKX2XZAWgB0U1oaPyjfYT8fQ2CCFSGPdgcQsuyci4Ebl4PCjuCXqWI47nfJ4zg3n5uKbZeFH0tQuEiPY4SlgzGdtR7Dfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722615345; c=relaxed/simple;
	bh=wCo7/8WS01I6dJMgICCbTE4isnfUQKyvhGObCj7EyBI=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=JTSb1ZuwUQnYHtFnfTcRlsvB86rafOiYgi6+pEatDSm99Ual6xAs6np6zILQn/b7d/AyLdDjOd8l/uFu2olOmKzXZRtIU8iaX/mR2kJ83C/AnLVDDn8cs+axilUajG+sBAzRQLWZEu539Vp7FHbQt++tb/njZ5DQ5zNoBzEfHKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e2zQbNLz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mHHRCZP0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240802155440.339321108@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722615336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=qtachSD9CHGIuW1+NiF6ehzxlAFmcNUSE5sNOCErmPE=;
	b=e2zQbNLzh10c99bYqN0iVZoekTOpkGNYH07rMObKCOZkshvl9ZDwvvAg12HsTTjpVONTnn
	gyXWAyllh4M9VssF+ruAnOJcWRIAGqr+bN4HXZl8lGhU9Ot6FOSgrP2JNkexFLdBY+gdL1
	185WU8yrBaMPgtUgomvU+MbCopF9MfpS8ZtiYZ4wX8GNv4zLbkbvFmvA+YMjrJMQRHREmN
	nkRMi3oQ+kF4sX3KHTmbMZQNRdqGodrt/9m7Ek6t/ChZ0+ciscyqHboEi/EMulyor6hU/V
	JV+mvvXX5IZtX3P1/Uopy4lYvROBjlc7ATpRROIpHn7pAhdCY5jJH0+X5uaegw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722615336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=qtachSD9CHGIuW1+NiF6ehzxlAFmcNUSE5sNOCErmPE=;
	b=mHHRCZP0GqA64z1LB4h654m6R4+/gQYL9cFS4oc8jENyIwOH7J/GHDjmTO3XyHx4f9glSc
	5rZz3/mHPVohpYAQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org
Subject: [patch 02/15] x86/ioapic: Mark mp_alloc_timer_irq() __init
References: <20240802155038.556977544@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Fri,  2 Aug 2024 18:15:36 +0200 (CEST)

Only invoked from check_timer() which is __init too. Cleanup the variable
declaration while at it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/apic/io_apic.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -2122,10 +2122,10 @@ static int __init disable_timer_pin_setu
 }
 early_param("disable_timer_pin_1", disable_timer_pin_setup);
 
-static int mp_alloc_timer_irq(int ioapic, int pin)
+static int __init mp_alloc_timer_irq(int ioapic, int pin)
 {
-	int irq = -1;
 	struct irq_domain *domain = mp_ioapic_irqdomain(ioapic);
+	int irq = -1;
 
 	if (domain) {
 		struct irq_alloc_info info;


