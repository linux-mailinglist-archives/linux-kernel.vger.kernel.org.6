Return-Path: <linux-kernel+bounces-366543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D15B699F6E4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 21:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CB4D1F24013
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 19:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21BD202623;
	Tue, 15 Oct 2024 19:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="XfZxb2l3"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18AA201016
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 19:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729019452; cv=none; b=V4mZWd2sFY2g804q/C718YLeYWp3FoSxywusEJbE5QX/M3w8lqZ7+b+S927/wJVepLzmA6fNRZyTQjk/Exr2/nXo+5Am/wQ2kPlxJy2UsyF0AyGJqbrMkluVMaLnoAJbRqEfzw2wQizvOuTzERCJFtExaGkZsTjqzR7Gj2MC5vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729019452; c=relaxed/simple;
	bh=C65hrQQHOKFPoqfhTZVpg+tv2vUuUWpXuSIvSRQ/PQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T7uw41olCkjqsQV/HwluMz0cKYYJNVnRk3SMDnw6SLA0o6AFHom4Azhfma0V9kZ+fVCaGSLYsdn/Z5VyeN0/CBdFlkEBDJCue+IQQXSHHP570nSTLPFsklFTGe2dXkwGDkSFr00qDGeMD4nE3Tx3lXoir+mmDzc/cWXknwkLg94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=XfZxb2l3; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4XSkFz55G8zlgMW2;
	Tue, 15 Oct 2024 19:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1729019445; x=1731611446; bh=sT4hZ
	uUOjQ/KZbHYEzesO8WWdwvf1Nk3oNcZhQJfDq4=; b=XfZxb2l3CISEUSsKEPyF3
	P++C7hRd2UrosHVKNvR3XV3TnZ33z1YqjKmfjR20RVlskQxipk8fZ5TM8KKfaaC7
	vLZiOsiGt6x0ZOD546HFSJLwM8bp5zuamUb1i/9AFoaLeBWuhRlSxsQk2KI9fdMB
	6kZniGuot1t7EWZvTmNcXBYeLTYsY00P2P/MX0beyLEOtfU+5q1jNGMY26ajE3JO
	ito3c/BwiRR3wHS06f/BhbqGU08Jds394CP4nCAMGGlJ0km5f2fCBOptESUXZMFR
	Iv3AoeTDZ2fxa/1UGbpwIMPNvhEpPZ9UJCy23YKcWjqyjK0qG6YTIfg9CEL4TjZS
	g==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id AUTqvsrLb5dn; Tue, 15 Oct 2024 19:10:45 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4XSkFw3ZnrzlgMW9;
	Tue, 15 Oct 2024 19:10:44 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Alexey Dobriyan <adobriyan@gmail.com>
Subject: [PATCH v3 20/22] fs/procfs: Switch to irq_get_nr_irqs()
Date: Tue, 15 Oct 2024 12:09:51 -0700
Message-ID: <20241015190953.1266194-21-bvanassche@acm.org>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
In-Reply-To: <20241015190953.1266194-1-bvanassche@acm.org>
References: <20241015190953.1266194-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Use the irq_get_nr_irqs() function instead of the global variable
'nr_irqs'. Prepare for changing 'nr_irqs' from an exported global
variable into a variable with file scope.

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

