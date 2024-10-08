Return-Path: <linux-kernel+bounces-355902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B2E995870
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 22:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEE7D283E41
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 20:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C73F21B45E;
	Tue,  8 Oct 2024 20:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="ZbqO9kyW"
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FD021B42C
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 20:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728419206; cv=none; b=n/sshMb8oB4zpsycnthNzOvN75RJasgL0Ve8NzKoh7XfTXrgonHWEF9bYtSK9l4kMvlifyhrqlW82vLOGXL+PzGz5En5X7I+6PlnO9NBbyV00jqB6sUNlnX6krxkry7hy9sUNXA3jvKZk+igojhq5AnNeZfsIcRa/l8oLUjZNos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728419206; c=relaxed/simple;
	bh=7QCRcY70pmIo12QeM9BsUHbH41DkG4WOFFxB+kB4FkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qsTD/sBR5jy64OH2Hk2J4m4uY08iWQa+msjdfQN4KT0Vbq0EG879R35RdX8SvJrNJqCL0fhVA1CQdiHbWY8At+86xCo9X/ful/mTMsdzNDPTaGI91Eh4Wm5ls0wlkNqsUg3RMKb9BbQxYV64Slkieq2vydB2deZkXk2n/gcVtFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=ZbqO9kyW; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4XNSGg68bnz6ClY9L;
	Tue,  8 Oct 2024 20:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1728419193; x=1731011194; bh=/wM3P
	9p1Yiy75TZVpSluehkydQ/ep7xUeajJ+6eskao=; b=ZbqO9kyWhN2o+UKKy2hks
	Nymo+7/FglN3WtRBue0YcUS0bU4A403yyaencWgz/Tke7w8bb9J4QmbFy7XMphnn
	EHyLrrDFPZoTs2ktSWcpUZOCAB2g18fYk1WI9UOkz/kEDlWf0z9MENgk0nRjTE1+
	5fNxgLbjx/dJnc90h1VCbnWNofi8rtIE9rrkFFcPaNKV+dRveSEl5LN9orVY0wBg
	6fXQzRkdcJLlIWN59g8pQJVEFpwm2P9MDEnIN6oBk8izQvULxxPkNOshWxLGv3yD
	HHElPkBiNwPt8L5EJxdfeyrISUsoqmLHZAL11V7q0Il4huYRYF6dMjpmQC0cZITn
	w==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id T982ad5--R8b; Tue,  8 Oct 2024 20:26:33 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4XNSGc3rvFz6ClY9Y;
	Tue,  8 Oct 2024 20:26:32 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Alexey Dobriyan <adobriyan@gmail.com>
Subject: [PATCH v2 20/22] fs/procfs: Switch to irq_get_nr_irqs()
Date: Tue,  8 Oct 2024 13:25:59 -0700
Message-ID: <20241008202601.3737326-21-bvanassche@acm.org>
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

Cc: Alexey Dobriyan <adobriyan@gmail.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 fs/proc/interrupts.c | 4 ++--
 fs/proc/stat.c       | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/proc/interrupts.c b/fs/proc/interrupts.c
index cb0edc7cbf09..714a22ded8a8 100644
--- a/fs/proc/interrupts.c
+++ b/fs/proc/interrupts.c
@@ -11,13 +11,13 @@
  */
 static void *int_seq_start(struct seq_file *f, loff_t *pos)
 {
-	return (*pos <=3D nr_irqs) ? pos : NULL;
+	return *pos <=3D irq_get_nr_irqs() ? pos : NULL;
 }
=20
 static void *int_seq_next(struct seq_file *f, void *v, loff_t *pos)
 {
 	(*pos)++;
-	if (*pos > nr_irqs)
+	if (*pos > irq_get_nr_irqs())
 		return NULL;
 	return pos;
 }
diff --git a/fs/proc/stat.c b/fs/proc/stat.c
index da60956b2915..8b444e862319 100644
--- a/fs/proc/stat.c
+++ b/fs/proc/stat.c
@@ -76,7 +76,7 @@ static void show_all_irqs(struct seq_file *p)
 		seq_put_decimal_ull(p, " ", kstat_irqs_usr(i));
 		next =3D i + 1;
 	}
-	show_irq_gap(p, nr_irqs - next);
+	show_irq_gap(p, irq_get_nr_irqs() - next);
 }
=20
 static int show_stat(struct seq_file *p, void *v)
@@ -196,7 +196,7 @@ static int stat_open(struct inode *inode, struct file=
 *file)
 	unsigned int size =3D 1024 + 128 * num_online_cpus();
=20
 	/* minimum size to display an interrupt count : 2 bytes */
-	size +=3D 2 * nr_irqs;
+	size +=3D 2 * irq_get_nr_irqs();
 	return single_open_size(file, show_stat, NULL, size);
 }
=20

