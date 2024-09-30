Return-Path: <linux-kernel+bounces-344615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A249898ABE2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 20:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F877B23888
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 18:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B731019F11A;
	Mon, 30 Sep 2024 18:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="Eqv4QUeP"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9062E19E7C7
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 18:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727720215; cv=none; b=C9qcFrsojVuLzJzH73IvC4cO1R+a7fpxANlZ8QM4R9SSTjLIHsGlpP7fI0iZv79HPsMXEgnYEOxnsOelN//Pu47ijotjUZEhj8OOVlrllKyUqbZOkb3q+BgG50V/m12l05HvSMUtDnwGqgew2DpfaNCPyHUOa3SmUh1qP4w+KIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727720215; c=relaxed/simple;
	bh=6fIQS+BJHMrDzBCyTvIPpBuxib0fkVZ6ubELXzXbHFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZMZqulYq1vK64zNe5/f0rbl31NbXg+ZDm+hk57ZZj6joN1pulWfZ//13hAYbKvZQFqmDggecVhfKKnL/DP/vi8ye/0M+3R84Jtj89M6uy0vlREjaPGTj+3bWNjDE1SSYbxn/sWbC/YqwjBEO8ijpvm4eFVRKqao+H9JKmlUCUHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Eqv4QUeP; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4XHTmT5xdlzlgMVc;
	Mon, 30 Sep 2024 18:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1727720199; x=1730312200; bh=q/qU6
	988jHayCTZFGUCmRfVTMDudmq4NrZK60UHpue4=; b=Eqv4QUeP7nIKFaJVFjNaT
	rFkJ7hAQgv+MU71xxzrY5AV+FxXwV+GRpPtrntVd8QDNw4w6xKSHMOZ2nOjfS1oF
	ZuGhu0FhhgnDPbLT4k8/feb6XhbEiEnLOsVUoxiNWiv3n2aCyOYrSfBfsFyEG+U9
	2zt7Cd8Ibh2GO8lGl6Oa8IdKZ1FpJdBgth40btNu6CfrJU55mnpE7mAKNLQ1fGOl
	vKyV7+EExKk9Ehc+bgdfX5vy6HHSPVeqLbSF+S7M2YDyI/qZsEsdyQEhFnTtXeiq
	ttgKMqBlaI9HmSbYhVow43QeGLhX3PQ2o4GY9jIbQc055t59E4xoNBkuQE5rUTdO
	Q==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id fDQiSk2Gn0Hh; Mon, 30 Sep 2024 18:16:39 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4XHTmQ5x09zlgMVt;
	Mon, 30 Sep 2024 18:16:38 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Alexey Dobriyan <adobriyan@gmail.com>
Subject: [PATCH 19/21] fs/procfs: Switch to number_of_interrupts()
Date: Mon, 30 Sep 2024 11:15:58 -0700
Message-ID: <20240930181600.1684198-20-bvanassche@acm.org>
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

Cc: Alexey Dobriyan <adobriyan@gmail.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 fs/proc/interrupts.c | 4 ++--
 fs/proc/stat.c       | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/proc/interrupts.c b/fs/proc/interrupts.c
index cb0edc7cbf09..90cc6b9a30f5 100644
--- a/fs/proc/interrupts.c
+++ b/fs/proc/interrupts.c
@@ -11,13 +11,13 @@
  */
 static void *int_seq_start(struct seq_file *f, loff_t *pos)
 {
-	return (*pos <=3D nr_irqs) ? pos : NULL;
+	return *pos <=3D number_of_interrupts() ? pos : NULL;
 }
=20
 static void *int_seq_next(struct seq_file *f, void *v, loff_t *pos)
 {
 	(*pos)++;
-	if (*pos > nr_irqs)
+	if (*pos > number_of_interrupts())
 		return NULL;
 	return pos;
 }
diff --git a/fs/proc/stat.c b/fs/proc/stat.c
index da60956b2915..6e22a7bca973 100644
--- a/fs/proc/stat.c
+++ b/fs/proc/stat.c
@@ -76,7 +76,7 @@ static void show_all_irqs(struct seq_file *p)
 		seq_put_decimal_ull(p, " ", kstat_irqs_usr(i));
 		next =3D i + 1;
 	}
-	show_irq_gap(p, nr_irqs - next);
+	show_irq_gap(p, number_of_interrupts() - next);
 }
=20
 static int show_stat(struct seq_file *p, void *v)
@@ -196,7 +196,7 @@ static int stat_open(struct inode *inode, struct file=
 *file)
 	unsigned int size =3D 1024 + 128 * num_online_cpus();
=20
 	/* minimum size to display an interrupt count : 2 bytes */
-	size +=3D 2 * nr_irqs;
+	size +=3D 2 * number_of_interrupts();
 	return single_open_size(file, show_stat, NULL, size);
 }
=20

