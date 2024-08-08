Return-Path: <linux-kernel+bounces-279296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9382394BB7E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 12:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D0201F23870
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 10:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF35018B47F;
	Thu,  8 Aug 2024 10:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BAFqKXDp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338E018A92B
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 10:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723113683; cv=none; b=ZxjtLWMdRazFtIbsGt+ghWHyzUUCEKCIFajnDt7uzOnODJ0/MS6wVmljEP31esyTWSz1FASIWL0qMUx2M/r7f3XIWmb8caKgjKKXKBWg+ujfdVEO5XfW+PWyEhmnqAwlFWLfL/tiBnwSX8r2u1D3uVyMcCh5CIbyFNwNzrHY5mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723113683; c=relaxed/simple;
	bh=7GYyRLtHz1nJwhZvbjXG03AfXx7jBJfatxsQgtLx8oU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=riLne6rmcUhplWvHqs+wuwLkyJ6+iucOGrdkp3Z0Nt3QUnL5drvhYlYHdCkkAy5M+7xWRqOLzSj4hpReSsRlB8hhU8UQngRg1vLE16gVHRptfbqoiAWyhQkEzF4iPBHyu4S4zBoGG584Y6Q+SPF1z5vvZ3ttJ+Km6Wo7OGaeYHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BAFqKXDp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6956C4AF0D;
	Thu,  8 Aug 2024 10:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723113682;
	bh=7GYyRLtHz1nJwhZvbjXG03AfXx7jBJfatxsQgtLx8oU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BAFqKXDpJ/OT+J1dIsYjy4SfeGSTNHRo57V/t0ZiA6ACytNsjHRjzoPgIYQUbT4hI
	 7CkeSu+RDQGwTLTR8bvZwqnyuRo08lQkebdciK4WYvrTp+AgZh0HqTVVOUDuQMpt8t
	 GPt4X757sBYhJHN4D+4pVIOaiu9zRdKpqzJKMUzNM5lguJjpAbsB59A+1VImLtKTE4
	 Qupm8U7gN/dyIkGRQ6jxAouYoOL8swUOMq5s7sclU+alKexti87+w+M7O1h+ExAemx
	 kY/lgWl3jKRN5rturapw3FaZcvj3sz3/KawGIkCdsmLQ/jtRj3qEEa2L5miWWYNCY+
	 AYVFQ6Z/rwHtg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 2/3] genirq: Remove unused irq_chip_generic::{type,polarity}_cache
Date: Thu,  8 Aug 2024 12:41:17 +0200
Message-ID: <20240808104118.430670-2-jirislaby@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240808104118.430670-1-jirislaby@kernel.org>
References: <20240808104118.430670-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The type_cache and polarity_cache members of struct irq_chip_generic are
unused. Remove them both along with their kernel-doc.

Found by https://github.com/jirislaby/clang-struct.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/irq.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 1f5dbf1f92c9..00490d6ead65 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -1040,8 +1040,6 @@ struct irq_chip_type {
  * @irq_base:		Interrupt base nr for this chip
  * @irq_cnt:		Number of interrupts handled by this chip
  * @mask_cache:		Cached mask register shared between all chip types
- * @type_cache:		Cached type register
- * @polarity_cache:	Cached polarity register
  * @wake_enabled:	Interrupt can wakeup from suspend
  * @wake_active:	Interrupt is marked as an wakeup from suspend source
  * @num_ct:		Number of available irq_chip_type instances (usually 1)
@@ -1068,8 +1066,6 @@ struct irq_chip_generic {
 	unsigned int		irq_base;
 	unsigned int		irq_cnt;
 	u32			mask_cache;
-	u32			type_cache;
-	u32			polarity_cache;
 	u32			wake_enabled;
 	u32			wake_active;
 	unsigned int		num_ct;
-- 
2.46.0


