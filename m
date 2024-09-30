Return-Path: <linux-kernel+bounces-344595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE3498ABC8
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 20:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A0861C21AE1
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 18:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50F7198E93;
	Mon, 30 Sep 2024 18:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="tm5pX5sx"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972E0CA62
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 18:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727720197; cv=none; b=iF2Bue8vxa6Py7Sfd5qhz/iysQHYOIRMbvjwnEPQb3RAuHxOnXSkPRyafbCO9sIFTxm7pZkc0/2ycyperZ7eoOoHYHrl1v9Cbr4afXOz1rIxx3U/HPqZuzf6HoXdaUsPd7nie1kdzvAp2W4MZjxVHStNq+3HTt4nNcrkTAd3ASM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727720197; c=relaxed/simple;
	bh=vT5HWEWDVSNQ6yqs6+L4wLyOHJcKx6Pb2mPJODDrf3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H5kSv2obK0Lua5oTUzUGjlGfWnfvLE5EBUftGwKQiWjdCcoss9fb1pq0bh6Q2VHaFz8TCExPev0fdNpxs9QFgE+iU9rZLujPdsZ4kip9PWqeV+HS0JvhgxlDUAWxbC8iyEYO1IhJUVKzf3udOsTVc5R5eRvfanS0LW9c0XGUU9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=tm5pX5sx; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4XHTmF24gkzlgMVl;
	Mon, 30 Sep 2024 18:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1727720187; x=1730312188; bh=lLIQ5
	C+bYk0x61ONWAtWsD3jfb+Sj3p3mOak9EpltxQ=; b=tm5pX5sxehM0xXFe/81ph
	f3l0xVSf4hzRJzDGfgF1MS5U3EznuHbHyXa5ScfBnNRKxrO0UvW+FLm+Gt9EaKNu
	ibIj51QYOv2g4F5jc+CThJkbe3k/B2pm+IAZUjZQFc+HVk2UgQ9D7mzNIbjpYIlA
	lKkT8RXKyW0W/hbGNRerFML2umCNKWriOVt54F0Sgr1JNNj0JYmwBFSHqyhTrx7j
	tmNBlAL+9JKfMDa/rmZBu7Y8kRw5MUUPZ1T+Odt19QdLsy6X6FljXw01clZN0o/9
	weKPS2CPMClt/oy5E+Gdlb2IRIVUw8T/TLCdEUaZpQpHFM11+wVBqKvng5uUoqLt
	Q==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id EVPUsGlPxsXH; Mon, 30 Sep 2024 18:16:27 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4XHTmB6gMQzlgMVd;
	Mon, 30 Sep 2024 18:16:26 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 01/21] genirq: Introduce number_of_interrupts() and set_number_of_interrupts()
Date: Mon, 30 Sep 2024 11:15:40 -0700
Message-ID: <20240930181600.1684198-2-bvanassche@acm.org>
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

This patch prepares for changing 'nr_irqs' from an exported global variab=
le
into a variable with file scope.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 include/linux/irqnr.h |  2 ++
 kernel/irq/irqdesc.c  | 14 ++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/linux/irqnr.h b/include/linux/irqnr.h
index 3496baa0b07f..a8b2cb6146e8 100644
--- a/include/linux/irqnr.h
+++ b/include/linux/irqnr.h
@@ -6,6 +6,8 @@
=20
=20
 extern int nr_irqs;
+int number_of_interrupts(void) __pure;
+int set_number_of_interrupts(int nr);
 extern struct irq_desc *irq_to_desc(unsigned int irq);
 unsigned int irq_get_next_irq(unsigned int offset);
=20
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 1dee88ba0ae4..8c6280843964 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -141,6 +141,20 @@ static void desc_set_defaults(unsigned int irq, stru=
ct irq_desc *desc, int node,
 int nr_irqs =3D NR_IRQS;
 EXPORT_SYMBOL_GPL(nr_irqs);
=20
+int number_of_interrupts(void)
+{
+	return nr_irqs;
+}
+EXPORT_SYMBOL_GPL(number_of_interrupts);
+
+int set_number_of_interrupts(int nr)
+{
+	nr_irqs =3D nr;
+
+	return nr;
+}
+EXPORT_SYMBOL_GPL(set_number_of_interrupts);
+
 static DEFINE_MUTEX(sparse_irq_lock);
 static struct maple_tree sparse_irqs =3D MTREE_INIT_EXT(sparse_irqs,
 					MT_FLAGS_ALLOC_RANGE |

