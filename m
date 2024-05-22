Return-Path: <linux-kernel+bounces-185867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94BF88CBC25
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 09:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F7BE280DCF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 07:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2FF57D401;
	Wed, 22 May 2024 07:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="eIAPT8NN"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C8A3C099
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 07:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716363392; cv=none; b=AKzjCxTbFOxm/XHnRI+p6ZN57/DCbkjNYsjm7XgPxu5k6aVOt74sOtZGVKqg65Ljus9J7jBTXy7waEVdDYFj2DGsQlU/xZcTqnXMDqHVDQUABr6QsFmnExe4kN8CPBcSRzOJn5dfyeDSI1Ic9WJPNuWh5Q3ktKfYLwHnYhCcQc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716363392; c=relaxed/simple;
	bh=sRR+OoNe+CJbOABxoZNaQT2CCvoMwl0YHxGhGd8xLdY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=eETVo60JPo2BXYE0uS4JfmTfILfFauehsDpsv7DF9N4/F1PGvAN9b2kFxb3yLnT/TrmUOFaI/Po9yUqPYYJuKjVRixlsOTfE2/3W2UaPzqL3AFLb22SMUP284LPc7E9rgLiDoAXqfmJFFNlZCH+urR/gVIHO6DkVYVYbaD0wKF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=eIAPT8NN; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=WY9vcFIYHyY28AUyfY/N7+e9B4gmGc0udXw0k/OYO9k=;
	b=eIAPT8NN8l7lu5sTik9h/UTvBw47YSSsTQLnk8zh5ujmlIbS3246pv1xqLN3ly
	Bh5iL1/vSre4p+CVW5ir8vE/RXBuYZ/UBc6gC165vGJmstmeLKAs5BCGlqoSnY1p
	TDzU0xAdFFLzu8EC71HNwmoz6wGglzFnfa3Ist0cJVn3M=
Received: from localhost.localdomain (unknown [111.48.58.10])
	by gzga-smtp-mta-g2-0 (Coremail) with SMTP id _____wD3n7hxoE1mSfpFAw--.37392S2;
	Wed, 22 May 2024 15:36:18 +0800 (CST)
From: huanglei814 <huanglei814@163.com>
To: sudipm.mukherjee@gmail.com
Cc: linux-kernel@vger.kernel.org,
	huanglei <huanglei@kylinos.cn>
Subject: [PATCH] parport: Increase buffer max length to avoid memory out of bounds overflow
Date: Wed, 22 May 2024 15:36:07 +0800
Message-Id: <20240522073607.15076-1-huanglei814@163.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3n7hxoE1mSfpFAw--.37392S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ary7CFWfZw4kGr4UKr45Jrb_yoW8Gr4Upa
	98Krs0krZ8t3yUGw4kZwsI93yrXa97X3W8WF17G34akr4jqFn7ZFn0kF9FkF9Ygrs7uaya
	grs3Kr1UCr4jkF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UgYFZUUUUU=
X-CM-SenderInfo: xkxd0wxohlmiqu6rljoofrz/1tbiUBPm9mXAk3Pm7QAAsd

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


