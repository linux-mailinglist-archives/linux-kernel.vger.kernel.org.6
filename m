Return-Path: <linux-kernel+bounces-353819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B498993324
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 18:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D8E11C22B33
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 16:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABB71DA630;
	Mon,  7 Oct 2024 16:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="icowUNR4"
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCF91D2711
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 16:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728318409; cv=none; b=LhMvNUyB6EqGY22McEloo3YWrAZCeOt80kwP+hXHKs8a7xfVqwDonfiLjFGDGk1wdmBUwuv2DhmlcvOmt1/AMsVsRYebW2fc+f5o+UPv9a5ZjTNI4YvHaGVkg4PiBsbbNisVIRedhzXjT98sS5ZeH2LrZCQtmFBl71AKRI563X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728318409; c=relaxed/simple;
	bh=7fjFA7r/9mC9DN1IVzI7GzR8lpPWpWYTSl2fAVlwvXg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TDrXyI2kZt0ZiM3wDXqdKO9STipQc1MxMl67HKV7s5WbEzQB+cJ4JzhJ+lT5Rwe8mbwmR68fVnBRWneraMQSZwjOc30XC3Z5XjcfgyzQbNJfn3H+I9qc3vNrJCQlfVF2CHiMdEgQ0IlqpFDovnUnvp8Osxur8RPuZO0BnUoR1xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=icowUNR4; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4XMl0Q5y1qz6ClY9J;
	Mon,  7 Oct 2024 16:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1728318403; x=1730910404; bh=xzPmNdv2TFmV5boL0kfIaw0J
	ro3m689lcloJz0nHyeM=; b=icowUNR4HKdX07OoJZp7oN9d5x+Pdn5JrZOxQuEU
	aflqUcRG3VSJwVHwdc47YjMMHih4XoRwiaVvQ0QJEMoxX/M1fnGmPSI//rN6yala
	VExEBLtNvkGjbqavXkB+gq0iELYpwLGOsqU1H27InqRhnFQpZ4dqraRlTBzIH4ou
	9wh4u4K0MUlCl7pEGpg41xKkjSkWF8EzWzhnGhfs3iuOZnAPe8eBpXLID8QvrQpb
	Ox+1dqPxhB/DDf8lEWhk76YTh8ER0uPnd2IGwveJQu8KllYM54KbUoSc9KQLf9x/
	T5fsWmz4//On1rcbZVzdrxuliW0F+yGSNC1KNWtU+XNyeQ==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Iwld-yDRhRq6; Mon,  7 Oct 2024 16:26:43 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4XMl0L4h3wz6ClY8v;
	Mon,  7 Oct 2024 16:26:42 +0000 (UTC)
Message-ID: <562d3545-00f1-4ca2-80c0-7326f104c926@acm.org>
Date: Mon, 7 Oct 2024 09:26:41 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/21] genirq: Switch to number_of_interrupts()
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
 David Laight <David.Laight@ACULAB.COM>
References: <20240930181600.1684198-1-bvanassche@acm.org>
 <20240930181600.1684198-21-bvanassche@acm.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240930181600.1684198-21-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/30/24 11:15 AM, Bart Van Assche wrote:
> Use the number_of_interrupts() function instead of the global variable
> 'nr_irqs'. This patch prepares for changing 'nr_irqs' from an exported
> global variable into a variable with file scope.

(replying to my own email)

Although no code should loop over all interrupts in the hot path, if 
nobody objects, I will replace this patch with the patch below. The 
patch below does not rely on CSE (common subexpression eliminiation) to
reduce the number of irq_get_nr_irqs() calls. The patch below should
support code that uses 'break' or 'continue' inside for_each_irq* loops.

Thanks,

Bart.


Subject: [PATCH] genirq: Switch to irq_get_nr_irqs()

Use the irq_get_nr_irqs() function instead of the global variable
'nr_irqs'. This patch prepares for changing 'nr_irqs' from an exported
global variable into a variable with file scope.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
  include/linux/irqnr.h  | 33 +++++++++++++++++++--------------
  kernel/irq/irqdomain.c |  2 +-
  kernel/irq/proc.c      |  5 +++--
  3 files changed, 23 insertions(+), 17 deletions(-)

diff --git a/include/linux/irqnr.h b/include/linux/irqnr.h
index 7419b807b71b..a33088d27c54 100644
--- a/include/linux/irqnr.h
+++ b/include/linux/irqnr.h
@@ -11,26 +11,31 @@ unsigned int irq_set_nr_irqs(unsigned int nr);
  extern struct irq_desc *irq_to_desc(unsigned int irq);
  unsigned int irq_get_next_irq(unsigned int offset);

-# define for_each_irq_desc(irq, desc)					\
-	for (irq = 0, desc = irq_to_desc(irq); irq < nr_irqs;		\
-	     irq++, desc = irq_to_desc(irq))				\
-		if (!desc)						\
-			;						\
-		else
-
+#define for_each_irq_desc(irq, desc)                                      \
+	for (unsigned int __nr_irqs__ = irq_get_nr_irqs(); __nr_irqs__;   \
+	     __nr_irqs__ = 0)                                             \
+		for (irq = 0, desc = irq_to_desc(irq); irq < __nr_irqs__; \
+		     irq++, desc = irq_to_desc(irq))                      \
+			if (!desc)                                        \
+				;                                         \
+			else

  # define for_each_irq_desc_reverse(irq, desc)				\
-	for (irq = nr_irqs - 1, desc = irq_to_desc(irq); irq >= 0;	\
-	     irq--, desc = irq_to_desc(irq))				\
+	for (irq = irq_get_nr_irqs() - 1, desc = irq_to_desc(irq);	\
+	     irq >= 0; irq--, desc = irq_to_desc(irq))			\
  		if (!desc)						\
  			;						\
  		else

-# define for_each_active_irq(irq)			\
-	for (irq = irq_get_next_irq(0); irq < nr_irqs;	\
-	     irq = irq_get_next_irq(irq + 1))
+#define for_each_active_irq(irq)                                        \
+	for (unsigned int __nr_irqs__ = irq_get_nr_irqs(); __nr_irqs__; \
+	     __nr_irqs__ = 0)                                           \
+		for (irq = irq_get_next_irq(0); irq < __nr_irqs__;      \
+		     irq = irq_get_next_irq(irq + 1))

-#define for_each_irq_nr(irq)                   \
-       for (irq = 0; irq < nr_irqs; irq++)
+#define for_each_irq_nr(irq)                                            \
+	for (unsigned int __nr_irqs__ = irq_get_nr_irqs(); __nr_irqs__; \
+	     __nr_irqs__ = 0)                                           \
+		for (irq = 0; irq < __nr_irqs__; irq++)

  #endif
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index e0bff21f30e0..ec6d8e72d980 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -1225,7 +1225,7 @@ int irq_domain_alloc_descs(int virq, unsigned int 
cnt, irq_hw_number_t hwirq,
  		virq = __irq_alloc_descs(virq, virq, cnt, node, THIS_MODULE,
  					 affinity);
  	} else {
-		hint = hwirq % nr_irqs;
+		hint = hwirq % irq_get_nr_irqs();
  		if (hint == 0)
  			hint++;
  		virq = __irq_alloc_descs(-1, hint, cnt, node, THIS_MODULE,
diff --git a/kernel/irq/proc.c b/kernel/irq/proc.c
index 9081ada81c3d..36ffff4eb352 100644
--- a/kernel/irq/proc.c
+++ b/kernel/irq/proc.c
@@ -457,7 +457,7 @@ int __weak arch_show_interrupts(struct seq_file *p, 
int prec)
  }

  #ifndef ACTUAL_NR_IRQS
-# define ACTUAL_NR_IRQS nr_irqs
+# define ACTUAL_NR_IRQS irq_get_nr_irqs()
  #endif

  int show_interrupts(struct seq_file *p, void *v)
@@ -477,7 +477,8 @@ int show_interrupts(struct seq_file *p, void *v)

  	/* print header and calculate the width of the first column */
  	if (i == 0) {
-		for (prec = 3, j = 1000; prec < 10 && j <= nr_irqs; ++prec)
+		for (prec = 3, j = 1000;
+		     prec < 10 && j <= irq_get_nr_irqs(); ++prec)
  			j *= 10;

  		seq_printf(p, "%*s", prec + 8, "");


