Return-Path: <linux-kernel+bounces-401959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA3B9C2194
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 17:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 302E52826CF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 16:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266E3126C0A;
	Fri,  8 Nov 2024 16:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="lExX0xwh"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40CE5A41
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 16:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731082074; cv=none; b=FAZsD/BrSTtlh1vmL0B4/nJJKZ7diucXRm03STwsexPntkMYY7ruSt36my0g1071JqMwX/zp/R2r4Yb0NtivLxMIk6+t9tfwQDqKZB3OvsHS6uykdLGC5UAzb+TPqU5QGWN5cNKxqL69PaNFNkIRFk7ZL7cXa9STSdwakcXc/+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731082074; c=relaxed/simple;
	bh=eZ0ufCR7x7V8u8i228PrKdkRdcKvQm8IHFgkZKgybnY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=s6iQaREEdoqMT+6rTh/5oqKKEsZmA9CjXREEm/Lxo5jegzZi8S6urH25FFZsDrlMI8kRd1XPIN8UD8aJwA908pWrU81D7ntqjBt1rslkDGmh79Azuflh1TiCV3eOs9HjPHmPbKKPpwCqu9AO0AlLqdCLRukT5AYAy/eL86+ExvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=lExX0xwh; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=hEhGJ
	1xX3uCm4kvCLfzAWwIoCelgH6XJ5bt8Ue0YouY=; b=lExX0xwhuxAk3JpM2hXup
	1LIkkujSZydfQmd/L+8G+gXkkBZL5fENycwh4g2bczveJhU2JdiBthNVY0xfMqez
	Br48ZKL/tDOgRm8MNlh3DfX+4Io3iUn6k6rZhT3Q+q/AAh4PQ5V831r9pJejtgkj
	ibH+vVG+it7ROVlQhsTqAw=
Received: from localhost.localdomain (unknown [111.35.191.191])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD3v3c3Ny5ngwX8GA--.64895S4;
	Sat, 09 Nov 2024 00:07:35 +0800 (CST)
From: David Wang <00107082@163.com>
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org,
	David Wang <00107082@163.com>
Subject: [PATCH 01/13] kernel/irq/proc: use seq_put_decimal_ull_width() for decimal values
Date: Sat,  9 Nov 2024 00:07:17 +0800
Message-Id: <20241108160717.9547-1-00107082@163.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3v3c3Ny5ngwX8GA--.64895S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7AFyxXw4xKFykGF4xtr47Arb_yoW8GF17pa
	yakFW3Aw48uw1Yq3W7Jan7Zwn8W3WYqF4Fk3Zakw4fA3Wjgr1vgr1avF13tr4akr9rZw45
	ZF90gw18tw4UWr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUyE_tUUUUU=
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiqQ6RqmcuNe8YfQAAsq

seq_printf() is costy, on a system with m interrupts and n CPUs, there
would be m*n decimal values yield via seq_printf() when reading
/proc/interrupts, the cost parsing format strings grows with number of
CPU. Profiling on a x86 8-core system indicates seq_printf() takes ~47%
samples of show_interrupts(), and replace seq_printf() with
seq_put_decimal_ull_width() could have near 30% performance gain.

The improvement has pratical significance, considering many monitoring
tools would read /proc/interrupts periodically.

Signed-off-by: David Wang <00107082@163.com>
---
 kernel/irq/proc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/irq/proc.c b/kernel/irq/proc.c
index 9081ada81c3d..988ce781e813 100644
--- a/kernel/irq/proc.c
+++ b/kernel/irq/proc.c
@@ -494,9 +494,11 @@ int show_interrupts(struct seq_file *p, void *v)
 	if (!desc->action || irq_desc_is_chained(desc) || !desc->kstat_irqs)
 		goto outsparse;
 
-	seq_printf(p, "%*d: ", prec, i);
+	seq_printf(p, "%*d:", prec, i);
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", desc->kstat_irqs ? per_cpu(desc->kstat_irqs->cnt, j) : 0);
+		seq_put_decimal_ull_width(p, " ",
+					  desc->kstat_irqs ? per_cpu(desc->kstat_irqs->cnt, j) : 0,
+					  10);
 
 	raw_spin_lock_irqsave(&desc->lock, flags);
 	if (desc->irq_data.chip) {
-- 
2.39.2


