Return-Path: <linux-kernel+bounces-301717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A34B295F481
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 16:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5FBE1C21EEE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 14:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBCAC1917E0;
	Mon, 26 Aug 2024 14:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Tt2R1zkZ"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32B5189511
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 14:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724684383; cv=none; b=BmhotXIlW5mOWZT2fhDAp9wHzbUj59YxGAKG9ScriuEHDa/AAhPHUPxye6Bt+8lLu5ZoZXRDl5wCZ0Y3IDme+PP92lLW+rzqZ9mHpEVmQf32dfKMGfejzvAq4ZMbNOpDrbzNhnTDYHhM2Zpz2VpJNxoyvxzBLLXdhMGY3+LS6gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724684383; c=relaxed/simple;
	bh=UCinY4dhevlS+63EtUDJjwPcpV+opgPAFpeQm9zX0sg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D/BnMYUqkt+846ebNNgrL6yjxijgfEyAMjmXYoLCNXxrA5o9a290dcchOUV8GWpLTmNLzRf3Z9iCUYvnHuY+vICJGDW+PckAk3sFByvLQsHLiofmR/68vNGObYk7/Dn2L72TVMym/JZSh5RIn+pMYeH8iRkVg3iTk/F6en/qoC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Tt2R1zkZ; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724684378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dFq9qiR5jkoFktyKqKe0B+h5cG7i6Rw5SPfyAyDC8c4=;
	b=Tt2R1zkZfm/ff0T7bdS7jwt6hdHI/xS6/lRXI9JO8rLv7/5clJ3+06bxWkAi5zKrh3BjIA
	/gWXjsx0hNMjh11rSAgxdblfuCL9PlFRI+Z/j4c6TF8iJBbgU69Jsar5wukTeRazCPx7Ft
	VhO4+4Wc09m77NNx50kZsOks/s0e6tY=
From: Jeff Xie <jeff.xie@linux.dev>
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org,
	xiehuan09@gmail.com,
	Jeff Xie <jeff.xie@linux.dev>
Subject: [PATCH] genirq/procfs: Change the return value for set affinity permission error
Date: Mon, 26 Aug 2024 22:58:05 +0800
Message-ID: <20240826145805.5938-1-jeff.xie@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Currently, when the affinity of an irq cannot be set due to lack of
permission, the write_irq_affinity() returns the error code -EIO

Obviously, due to a permissions error, it should return -EPERM

Signed-off-by: Jeff Xie <jeff.xie@linux.dev>
---
 kernel/irq/proc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/proc.c b/kernel/irq/proc.c
index dcf8190a58ca..7b3a4c92d148 100644
--- a/kernel/irq/proc.c
+++ b/kernel/irq/proc.c
@@ -142,7 +142,7 @@ static ssize_t write_irq_affinity(int type, struct file *file,
 	int err;
 
 	if (!irq_can_set_affinity_usr(irq) || no_irq_affinity)
-		return -EIO;
+		return -EPERM;
 
 	if (!zalloc_cpumask_var(&new_value, GFP_KERNEL))
 		return -ENOMEM;
-- 
2.43.0


