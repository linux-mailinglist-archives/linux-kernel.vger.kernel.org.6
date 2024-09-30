Return-Path: <linux-kernel+bounces-344599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A120698ABCD
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 20:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6DE01C2184C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 18:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8B0199FA8;
	Mon, 30 Sep 2024 18:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="ubH19xX9"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E97199259
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 18:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727720200; cv=none; b=NDzaQyC+g4Sj6fyIlA6/QCYU9EsY3xdETWqX4o+LRNCFA8ahj62cNun+tc80lBTxVluaLYyUc8DzTGJxJbujeY0r/g5T6GqWKMHcMwWOVjkEkgcs71iaIeDDlgRd/2so33za6BoLBXzCvU6jj3DCvbSj3sRaZYV5YgWwesbPJSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727720200; c=relaxed/simple;
	bh=ecJZgpHB7/0Jo7fcSCF38GUsYuaoxnJ/C6rGKksXjA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PD0Fi7AoBLoi61fJRJK3j4Z2r7U5M4u1GH20nhhEyTwwopLYgSvm1EXfUt5u4fVGO0QUt6b0D0BdzUZBk+zHZvSNoZNXZbTFs67gMjNrslwBroAfB61RGfTAQuNQvT9Gf7uHZv/CwqIFsR9sC/yqXi6v/gzz5OcRM5BykyF6QSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=ubH19xX9; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4XHTmJ0K7GzlgMVh;
	Mon, 30 Sep 2024 18:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1727720189; x=1730312190; bh=pMx0V
	IzQXMDEPRC6mdzDwP+uRN02UGl7uaT1XJ4pt3M=; b=ubH19xX9+/7TwFma0/wii
	T7pJjpJNOKS6myfGyMbZOeOmaEN+dpt7PjYty2VApNxuQP0RD1TgAByQJR5vaTHs
	z9NGfjNbx4QwHFm+G7xjEZGHJB6Leg2RY86GwLfiJYH+6vJUkIciHzkUftQK4eCc
	S/1xwrZHyln+nKpfgdW7zYu5lSqTaLDiSmpYc/l6DCFyPBfE5SWrsmTBf7jiPX+V
	0KG+s1/oTPGj1fHVc2H6NSuZ3ctnju4wD8c68PC96czc4pFh6LSg7FC/KD/pCHJs
	NOuzlaQEkz5JcwFdIYFl3qL7hoKsM/jR+H0zTk0F676uNNHCGWBI/yFgRXdjI4bw
	w==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Uf6Xx3EzOx41; Mon, 30 Sep 2024 18:16:29 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4XHTmF2zKjzlgMVd;
	Mon, 30 Sep 2024 18:16:29 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Heiko Carstens <hca@linux.ibm.com>
Subject: [PATCH 05/21] s390/irq: Switch to number_of_interrupts()
Date: Mon, 30 Sep 2024 11:15:44 -0700
Message-ID: <20240930181600.1684198-6-bvanassche@acm.org>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
In-Reply-To: <20240930181600.1684198-1-bvanassche@acm.org>
References: <20240930181600.1684198-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Use the number_of_interrupts() function instead of the global variable
'nr_irqs'. This patch prepares for changing 'nr_irqs' from an exported
global variable into a variable with file scope.

Cc: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 arch/s390/kernel/irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/irq.c b/arch/s390/kernel/irq.c
index 2639a3d12736..f3842d5eb2c3 100644
--- a/arch/s390/kernel/irq.c
+++ b/arch/s390/kernel/irq.c
@@ -253,7 +253,7 @@ int show_interrupts(struct seq_file *p, void *v)
 		seq_putc(p, '\n');
 		goto out;
 	}
-	if (index < nr_irqs) {
+	if (index < number_of_interrupts()) {
 		show_msi_interrupt(p, index);
 		goto out;
 	}

