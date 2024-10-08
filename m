Return-Path: <linux-kernel+bounces-355885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0720299585F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 22:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAE9D28822B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 20:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BFF3216437;
	Tue,  8 Oct 2024 20:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="RM7gjzy+"
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23624215037
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 20:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728419189; cv=none; b=NA868aQpPCYOPUtgWxajv70Y1RVa/y5k0oLJCDrmiORnogXXbkiqkxzwjMlbdTfH9f0eXWf/jD14TahZI7gDA74OUjLPYM22HidViIW3nJIV4+dK/79cH6B77++KzIGyYo7ZqLYoZW+LwSgfmPyR0Hd0/ado1rlkgzMt9v6WOpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728419189; c=relaxed/simple;
	bh=4OaWZQj2r7KW4hU7DOCWvsAxJCgl5pJj7S8Li1eYu8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GZ+izJ2KJpO1IeYANEumnP6TrqbTyTkQ0+MQ3hI8awzg1db5ZzEFMAN7ooL5IPB82Xx4oKkIObajVCdM4GCyBkx7lbtWuFqbtm89Ps43JtLvVr3CZEArhpH8SApi0946vmluNGINeAmIsS/zerkuR/kuStBLOcw9xT2R0pXTdww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=RM7gjzy+; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4XNSGV3wf9z6ClY9N;
	Tue,  8 Oct 2024 20:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1728419184; x=1731011185; bh=1npcv
	IHXQr/o/yu80ET0P8TxfjQQlT/eFnS/czBdy4w=; b=RM7gjzy+P5CBsB2NqWSR7
	8+GOKOdoJSlI5tn1CxOgLv085NpmdTuTaRp1xRrwpUNAeus5hwt0/C4NrG2PqGZU
	NXjs1GN1WWFfCrlehHjHyuC/FENeIc2LSuupl6jQLZl0tHjFgMNgBLlv53ApYto8
	bhpVIkkIqlqm1lbngAPgBg5SFu3AUjdX33PDuZwSh2us5GWy2qGad6HLXWFAdeOI
	sw8l69aYjgJ0AqxzJJrBT2R7QqMeDJtUgUpDGOu+YW4EMYyh9yeuEvCFW7RPFBmV
	kE4wg4u+aBiPkcKJLTM4IziyeBnEDBVNsJc5vGj/KpHusd5I1IfSrOFkHMTy5d/9
	Q==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id bK53Xc7h6XVK; Tue,  8 Oct 2024 20:26:24 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4XNSGR1hvqz6ClY9R;
	Tue,  8 Oct 2024 20:26:23 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Heiko Carstens <hca@linux.ibm.com>
Subject: [PATCH v2 05/22] s390/irq: Switch to irq_get_nr_irqs()
Date: Tue,  8 Oct 2024 13:25:44 -0700
Message-ID: <20241008202601.3737326-6-bvanassche@acm.org>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
In-Reply-To: <20241008202601.3737326-1-bvanassche@acm.org>
References: <20241008202601.3737326-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Use the irq_get_nr_irqs() function instead of the global variable
'nr_irqs'. This patch prepares for changing 'nr_irqs' from an exported
global variable into a variable with file scope.

Cc: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 arch/s390/kernel/irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/irq.c b/arch/s390/kernel/irq.c
index 2639a3d12736..a2c867181b5a 100644
--- a/arch/s390/kernel/irq.c
+++ b/arch/s390/kernel/irq.c
@@ -253,7 +253,7 @@ int show_interrupts(struct seq_file *p, void *v)
 		seq_putc(p, '\n');
 		goto out;
 	}
-	if (index < nr_irqs) {
+	if (index < irq_get_nr_irqs()) {
 		show_msi_interrupt(p, index);
 		goto out;
 	}

