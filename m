Return-Path: <linux-kernel+bounces-517122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7CC5A37C64
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 08:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D08783AEA48
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 07:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634A219048F;
	Mon, 17 Feb 2025 07:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WkbSbzZN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CA94S8a6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646B718FC65
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 07:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739777957; cv=none; b=pXwPmN1Ex9MbRmaxVR/7o2d9UOcQjT2hcnJI5WfCuSt7uSj/QUliB0XYsw6Hpu/wbTv6+5I30d+adIveI+U7NxPotycflbDZCJekxOdv/KxraoNLP6CGLPww7D/s3vPHF0Iho7vEHb1MZQC0sr5AN1YOGD5vmF7/+tTEqAvwphY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739777957; c=relaxed/simple;
	bh=ZDBkYP7e4RRQZyV4NkDx9AEqrR4TIznTk080XM4j54M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=PgMMuNL6ydcIuoybPU3645RqI8OtNnMtu6Cswuh4nKIVJtBrOYxLS3laMCSv+TNovMl42bio4ZVLl6hxML5MBHQSfjFmgLUqDMDagkCo3J7Rczrb4KlAc0ILM5eIMoikf0Ww5JgLzEmPJhKnvvcThW2+MhyfAoaOGLEeHlP4WN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WkbSbzZN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CA94S8a6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739777954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jNR2ygIUsv1k2EwiRdxBTOrxxKHAiE6CwbD0ihBu6Rs=;
	b=WkbSbzZNRaEuDRvrrP6VuKH12tXH4xgciMpzBxX7Gjbv1m4tuUB2gvazEFTkkDLShXs4fz
	qJY3rQQZeLRxglKztsImHSSsyuN4GL5VrNG39omZteOkd0DQSsnuza2lVXaIVAGDCT4dR+
	UX7FqbhCZlAkV4dQZuIE8l7BS/7KIInUEFKgdgH7+qdTARpvmZCm9t6AjhAKxUrS9CRpni
	765j7tSch1HNOwbX7fgwyrYgyVByQGAumgGXCnZuqwod1r0W09wJ2f17d6ENcPTN3v7KyU
	yQlF/4+Pn3Nrkm7wT6GVKLMCyMzkO1WDnibCwXKEqcsW2RMgbd8zXBbukBoM1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739777954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jNR2ygIUsv1k2EwiRdxBTOrxxKHAiE6CwbD0ihBu6Rs=;
	b=CA94S8a6eKEdcb5IbTZort5zGI6i+XjCK15imPv864Dh/EXMbsXwj3jPqWciP16CNRhdBM
	697soIUP1StY2LDg==
Date: Mon, 17 Feb 2025 08:39:06 +0100
Subject: [PATCH] arm64: mm: Don't use %pK through printk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250217-restricted-pointers-arm64-v1-1-14bb1f516b01@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAJnnsmcC/x3MQQqDMBBG4avIrDtg0thAr1K6COaPnUWjzIQii
 HdvcPkt3jvIoAKj53CQ4icma+1wt4HmT6oLWHI3+dFPo3eRFdZU5obM2yq1QY2Tfh+BY8hTSCj
 uXiL1flMU2a/3632efzuKxw9rAAAA
X-Change-ID: 20250217-restricted-pointers-arm64-74d54aef13f7
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739777954; l=1156;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=ZDBkYP7e4RRQZyV4NkDx9AEqrR4TIznTk080XM4j54M=;
 b=wxuocKS2tQ3eCVPZ3TBJCg+/tK4UpvZZR490FRiwdA5RJ6Uy2HcgjUnzyQh7SivJ0nn6Nieyf
 LK2TnDTB5eaBOZa3PeB1AB8LSiWITw/W+AwccNf37sQfw5hCWpvmoZr
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Restricted pointers ("%pK") are not meant to be used through printk().
It can unintentionally expose security sensitive, raw pointer values.

Use regular pointer formatting instead.

Link: https://lore.kernel.org/lkml/20250113171731-dc10e3c1-da64-4af0-b767-7c7070468023@linutronix.de/
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/arm64/mm/physaddr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/mm/physaddr.c b/arch/arm64/mm/physaddr.c
index cde44c13dda1bc0924d2d50369ad87f544a0a802..7d94e09b01b35094e883875a46b979666549095c 100644
--- a/arch/arm64/mm/physaddr.c
+++ b/arch/arm64/mm/physaddr.c
@@ -10,7 +10,7 @@
 phys_addr_t __virt_to_phys(unsigned long x)
 {
 	WARN(!__is_lm_address(__tag_reset(x)),
-	     "virt_to_phys used for non-linear address: %pK (%pS)\n",
+	     "virt_to_phys used for non-linear address: %p (%pS)\n",
 	      (void *)x,
 	      (void *)x);
 

---
base-commit: 0ad2507d5d93f39619fc42372c347d6006b64319
change-id: 20250217-restricted-pointers-arm64-74d54aef13f7

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


