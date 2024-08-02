Return-Path: <linux-kernel+bounces-272840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5543B9461B9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 18:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F34E31F2344A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 16:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC3E2101AB;
	Fri,  2 Aug 2024 16:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rt18SADs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N8ZZeT6X"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D751537CB
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 16:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722615350; cv=none; b=N7uf9BKD7DR7FAsooP5Y7/pugzp1kiZhIwdFwPh++eKbg+fozxQiRA6NpHbY8xekxxdSzkB406PlqzduaXXu5scul0D37LAJ4FDJCTPGehDopZZmoxS/VOR7eYgLHSXEDiPZygccs+i6iDsFzysTdINmZIjlMwzPyBj/U+VQnCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722615350; c=relaxed/simple;
	bh=Fs0K/UjwZhMJSjeEiZJnFQQy1pNOEUGEst5p68HK7JA=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=rX0EcpWQDv0t+Dr5YuI71Ue6UNCpxHkJxHeg0+apyOOy5NsWPzjzxCWCFUG40UnT8mYdbQfRWy04zKC9tDLK7f1NDBqo6FtFAh7KAnbwlgYAQ1LVlngoErMyBW8TCwVYdafFX2kGuszcmDCEotcL77IgrJMYBhhfrZgz2UGwV24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rt18SADs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N8ZZeT6X; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240802155440.906636514@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722615347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=17mnREW+bYg81keMy3JfytNa+W5aLA1S7jMZdqHm8g0=;
	b=rt18SADsyo/bPuxqk01T3JazHQHCpC0gTP/4GtYqWrG7X0gWcedj+5OhQ06yCoNZG5x4G8
	zmaGUya2Zxcr6i7ACdN2PcPLYj4mwa8qY+0W/cFvoGVcWkC5rXUV7ejLEZ6KmHwQk9tw7P
	yS+rw/O1/hJIiEJrbOoVruHHzgXm5FOUE4Ybm4+lgT9B6VL21TYPXLDTj5yJREFgiHymZH
	0oifYjdg3vrKB+QjXqGPJdCpa+sdewMUcnV/b7ugSmCJnJ6/3bkTCBvefFEsd9+MRJ6kZ7
	WFXjuG1fH0qLMkxet1prhVvufFi4mMBWoXy+qtJcl78ws8NlWrSUqGYkn6DOHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722615347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=17mnREW+bYg81keMy3JfytNa+W5aLA1S7jMZdqHm8g0=;
	b=N8ZZeT6Xs8PckH1wOd57k6AuGsR5NjEWYXIHQV3/l/5UuFWnSSmtWqtXNbrw7Qdu8hCv/A
	pV0O5ZP1yVxFFNBg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org
Subject: [patch 11/15] x86/ioapic: Move replace_pin_at_irq_node() to the call
 site
References: <20240802155038.556977544@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Fri,  2 Aug 2024 18:15:47 +0200 (CEST)

It's only used by check_timer().

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/apic/io_apic.c |   40 ++++++++++++++++++----------------------
 1 file changed, 18 insertions(+), 22 deletions(-)

--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -370,28 +370,6 @@ static void __remove_pin_from_irq(struct
 		}
 }
 
-/*
- * Reroute an IRQ to a different pin.
- */
-static void __init replace_pin_at_irq_node(struct mp_chip_data *data, int node,
-					   int oldapic, int oldpin,
-					   int newapic, int newpin)
-{
-	struct irq_pin_list *entry;
-
-	for_each_irq_pin(entry, data->irq_2_pin) {
-		if (entry->apic == oldapic && entry->pin == oldpin) {
-			entry->apic = newapic;
-			entry->pin = newpin;
-			/* every one is different, right? */
-			return;
-		}
-	}
-
-	/* old apic/pin didn't exist, so just add new ones */
-	add_pin_to_irq_node(data, node, newapic, newpin);
-}
-
 static void io_apic_modify_irq(struct mp_chip_data *data, bool masked,
 			       void (*final)(struct irq_pin_list *entry))
 {
@@ -2069,6 +2047,24 @@ static int __init mp_alloc_timer_irq(int
 	return irq;
 }
 
+static void __init replace_pin_at_irq_node(struct mp_chip_data *data, int node,
+					   int oldapic, int oldpin,
+					   int newapic, int newpin)
+{
+	struct irq_pin_list *entry;
+
+	for_each_irq_pin(entry, data->irq_2_pin) {
+		if (entry->apic == oldapic && entry->pin == oldpin) {
+			entry->apic = newapic;
+			entry->pin = newpin;
+			return;
+		}
+	}
+
+	/* Old apic/pin didn't exist, so just add a new one */
+	add_pin_to_irq_node(data, node, newapic, newpin);
+}
+
 /*
  * This code may look a bit paranoid, but it's supposed to cooperate with
  * a wide range of boards and BIOS bugs.  Fortunately only the timer IRQ


