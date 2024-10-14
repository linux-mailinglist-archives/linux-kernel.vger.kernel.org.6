Return-Path: <linux-kernel+bounces-363111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FA199BDF6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 05:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1D6C1F21BEC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 03:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83C183CDA;
	Mon, 14 Oct 2024 03:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JSizq0n6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE57E60DCF
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 03:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728875048; cv=none; b=Idt599Zeqh/+E5REg58RqNO4neYRS6aEz1vnNWO3mR5jVgTAH7ZfyM88Ofp21ic7/yWJEoRS/Z4FCVS4HCOiq3wvLxUPjd3gk9T/CSFhiseStZSb+iPojXluy1LIbA6x01tEFkwc+A7NuUrEi4Cx8ZkyVUVyf/gccsN3AtMSBsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728875048; c=relaxed/simple;
	bh=V/A5wKBg+heZ0o4kfd6BznYPDwJojza3vD8ut9oR6HQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GiiYSeMbn2TqYrPdbTBJclA2IAs9FeKdGTOCQ8DvON+w89a/J04lJkzkMcAheqcBayZiP3sDbJi/eRbJhfup5rYSNn8dhJrJky/yOgoVgeuU5dtBn/1YeWvLhwD7NPzPWyj9ASIRm7chwthzns2/fcpvBlm31pW9QR5t2RVO2ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JSizq0n6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728875045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rPWNnRQiSqjkFtkd3ZlbeGElr4t1vBhj9P7kgspNttw=;
	b=JSizq0n6WrEKo3dGX4q8qnrwRIcqrV8Qy1JvuLYidfoHLgaCI1TP4TGP7RswpTMIPlqKIJ
	Rvi7BaIh2wAGkXUfIs68zlPQba73I12yG5i6nd+Jw7TXeoaM1ffHRvZ6e1OPKX/SEuZbGs
	adtpqBwJB00yYI/dwa2QmSEXh/gJxs4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-180-SVb_aXQROFSzZZDUSKcmjg-1; Sun,
 13 Oct 2024 23:04:02 -0400
X-MC-Unique: SVb_aXQROFSzZZDUSKcmjg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 755D11956095;
	Mon, 14 Oct 2024 03:03:55 +0000 (UTC)
Received: from gshan-thinkpadx1nanogen2.remote.csb (unknown [10.64.136.10])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 371481956052;
	Mon, 14 Oct 2024 03:03:50 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	catalin.marinas@arm.com,
	will@kernel.org,
	ardb@kernel.org,
	anshuman.khandual@arm.com,
	gshan@redhat.com,
	shan.gavin@gmail.com
Subject: [PATCH] arm64: head: Drop SWAPPER_TABLE_SHIFT
Date: Mon, 14 Oct 2024 13:03:41 +1000
Message-ID: <20241014030341.995806-1-gshan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

There is no users of SWAPPER_TABLE_SHIFT after commit 84b04d3e6bdb
("arm64: kernel: Create initial ID map from C code"). Just drop it.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/include/asm/kernel-pgtable.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/include/asm/kernel-pgtable.h b/arch/arm64/include/asm/kernel-pgtable.h
index bf05a77873a4..fd5a08450b12 100644
--- a/arch/arm64/include/asm/kernel-pgtable.h
+++ b/arch/arm64/include/asm/kernel-pgtable.h
@@ -26,7 +26,6 @@
 #define SWAPPER_SKIP_LEVEL	0
 #endif
 #define SWAPPER_BLOCK_SIZE	(UL(1) << SWAPPER_BLOCK_SHIFT)
-#define SWAPPER_TABLE_SHIFT	(SWAPPER_BLOCK_SHIFT + PAGE_SHIFT - 3)
 
 #define SWAPPER_PGTABLE_LEVELS		(CONFIG_PGTABLE_LEVELS - SWAPPER_SKIP_LEVEL)
 #define INIT_IDMAP_PGTABLE_LEVELS	(IDMAP_LEVELS - SWAPPER_SKIP_LEVEL)
-- 
2.45.2


