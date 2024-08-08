Return-Path: <linux-kernel+bounces-279297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE06494BB7F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 12:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 856EA1F23E8D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 10:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC3418C320;
	Thu,  8 Aug 2024 10:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U2YXY8Vc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F24218B48D
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 10:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723113684; cv=none; b=MvYTpJwWAn/PpIGTnwCGZDtmqvSFiRrmCUwAw3i+pP6AY4GhlPb5SVEt2A7TEhlG/ohGccMiizNPfhtHjmZiohO8jQaTvKu0fFZwz/+WqBGy4flbyw5TqiE7dKEBHhQ/yben4vHJnNwkEOy9KRevBmnfueSJm9zJ5dm+RzVZjXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723113684; c=relaxed/simple;
	bh=S50KjHKRO/8zukIahL/hN+YRuEbMiPfD5nmvJHevMyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DJFzWfPz88U5NiNZ1nrJJ3VZVmxGL6eyzAWAFErZgdUoTwNNAPWXH2zJA580+gODzK/gBVArGDddtGBocEeulVgjvlZKEz9UG1rM40M9q/+VdNo37+Ilwhy/PBdrXiaK6WxxQ+O95j6afz5XQp1xYZusFAfVh0Fzb/kgIHudsNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U2YXY8Vc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E862C4AF0E;
	Thu,  8 Aug 2024 10:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723113684;
	bh=S50KjHKRO/8zukIahL/hN+YRuEbMiPfD5nmvJHevMyQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U2YXY8VcU2gcPYO0C86M1j4PcGT17vfYektr/fe8OSOrGOx14NfPdPfnIxFI1TE6e
	 kG13mxn50Nxuu0i29VOhc6wk0ZcYhTlxNfv8tcvuHs9x1n7CO+g+0KdQqua3K+hFdN
	 faPQQll91FiLxvdiAVVbZJ6WBkIo4wN5hByrjo/yI3c6vXJ7Fp6WCdwpA/EknDLK7h
	 9qUJafIjZeDs7MRtVOBVpw6zEQZBMaKIPWJRTyYmef8aYIemlV/cy4qO//SVjnNTgz
	 ZVCnYLCwuYSH4lm743AArs9vVCc/ULGUM5E/ltpIoDt9Y6lT/nYuN4IsHPO02c6GkB
	 bpA70JMVVWuVA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 3/3] genirq: Remove irq_chip_regs::polarity
Date: Thu,  8 Aug 2024 12:41:18 +0200
Message-ID: <20240808104118.430670-3-jirislaby@kernel.org>
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

The polarity member of struct irq_chip_regs is unused. Remove it along
with its kernel-doc.

Found by https://github.com/jirislaby/clang-struct.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/irq.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 00490d6ead65..fa711f80957b 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -991,7 +991,6 @@ void irq_init_desc(unsigned int irq);
  * @ack:	Ack register offset to reg_base
  * @eoi:	Eoi register offset to reg_base
  * @type:	Type configuration register offset to reg_base
- * @polarity:	Polarity configuration register offset to reg_base
  */
 struct irq_chip_regs {
 	unsigned long		enable;
@@ -1000,7 +999,6 @@ struct irq_chip_regs {
 	unsigned long		ack;
 	unsigned long		eoi;
 	unsigned long		type;
-	unsigned long		polarity;
 };
 
 /**
-- 
2.46.0


