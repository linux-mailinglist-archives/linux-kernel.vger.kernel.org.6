Return-Path: <linux-kernel+bounces-171045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA6C8BDF17
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 11:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5E201F223AA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 09:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C8E14E2EA;
	Tue,  7 May 2024 09:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="T/RwNUCg"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391BC14E2E4
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 09:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715075774; cv=none; b=pL7VWGPZTP5RnufX2J0Xt7Q9oRHZM/v+yMeyXdrSWtNs4SXvzG65hd5Tw5CETg6Z/YVi7AT9AjfqPZgA/PKqH6j3JVvz+NYBcNpLve6//N8mF+gTczvSR4LoAzdkPiGez/GIVeqk9Me7ulOFI1W0LHPKH9iD4qbAt56GzRhKb0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715075774; c=relaxed/simple;
	bh=sRR+OoNe+CJbOABxoZNaQT2CCvoMwl0YHxGhGd8xLdY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=FWhvd2Vg8YraG2h5UgQIFm2YYO8PVKVevuYjGr+48mL6uUM2zoG0J68WCQLrVE04XqPWQ54+xXSMANivOZm3PiQcIXrL49FGE5NajgM7vMAkeH1AyosWtbtLGZS1VM3i8fUQ9Nlmw0AKGR8gcuILGyHB3T+v5zci0GvTqfdgJaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=T/RwNUCg; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=WY9vcFIYHyY28AUyfY/N7+e9B4gmGc0udXw0k/OYO9k=;
	b=T/RwNUCgCtPlL1Tz+IvhZmQnEuemqpXbQ52v4qVdmjEjZPB6whTLF4edXwPchf
	QjYG86/bXC6gDZunq6XPzTi6bMiyBgtqt5TJYHX5jM83G13zk7eQDmdQ39UTm/yL
	pWr7VS4rPA4p5u1iRYHp9iwQVbxfjJgBqvCzbikLTF2Jg=
Received: from localhost.localdomain (unknown [111.48.58.10])
	by gzga-smtp-mta-g2-0 (Coremail) with SMTP id _____wDnVy+x+jlmjspcBQ--.42362S2;
	Tue, 07 May 2024 17:56:02 +0800 (CST)
From: huanglei <huanglei814@163.com>
To: sudipm.mukherjee@gmail.com
Cc: linux-kernel@vger.kernel.org,
	huanglei <huanglei@kylinos.cn>
Subject: [PATCH] parport: Increase buffer max length to avoid memory out of bounds overflow
Date: Tue,  7 May 2024 17:55:58 +0800
Message-Id: <20240507095558.20828-1-huanglei814@163.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnVy+x+jlmjspcBQ--.42362S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ary7CFWfZw4kGr4UKr45Jrb_yoW8Gr4Upa
	98Krs0krZ8t3yUGw4kZwsI93yrXa97X3W8WF17G34akr4jqFn7ZFn0kF9FkF9Ygrs7uaya
	grs3Kr1UCr4jkF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UgYFZUUUUU=
X-CM-SenderInfo: xkxd0wxohlmiqu6rljoofrz/1tbiUBXX9mXAklvZpgAAs3

From: huanglei <huanglei@kylinos.cn>

Most of the time，will use 64 bit address.
such as port->base=0xffffffc010e21280 and then use
len += sprintf (buffer, "%lu\t%lu\n", port->base, port->base_hi),
port->base convert to string is "18446743799114896000" add
port->base_hi is "0" and "\t" "\n" len will be 23.
But buffer the original max length is 20, length 23 is out of buffer.
So to make sure 64 bit address will not experience buffer overflow,
need increase buffer size to 32.

Signed-off-by: huanglei <huanglei@kylinos.cn>
---
 drivers/parport/procfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/parport/procfs.c b/drivers/parport/procfs.c
index bd388560ed59..6722ae620b68 100644
--- a/drivers/parport/procfs.c
+++ b/drivers/parport/procfs.c
@@ -117,7 +117,7 @@ static int do_hardware_base_addr(struct ctl_table *table, int write,
 				 void *result, size_t *lenp, loff_t *ppos)
 {
 	struct parport *port = (struct parport *)table->extra1;
-	char buffer[20];
+	char buffer[32];
 	int len = 0;
 
 	if (*ppos) {
@@ -171,7 +171,7 @@ static int do_hardware_dma(struct ctl_table *table, int write,
 			   void *result, size_t *lenp, loff_t *ppos)
 {
 	struct parport *port = (struct parport *)table->extra1;
-	char buffer[20];
+	char buffer[32];
 	int len = 0;
 
 	if (*ppos) {
-- 
2.17.1


