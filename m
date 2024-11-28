Return-Path: <linux-kernel+bounces-424178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A47E9DB14E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 03:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D08B9164638
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 02:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC4633F7;
	Thu, 28 Nov 2024 02:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XhmyBh9j"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C370517557
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 02:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732759234; cv=none; b=bSa1uurpLM2TwIQVj1S2Wv7wEnwThMd7rin+PulH0yc56ES8BNQRZ1dfERxmVR/226gjFO8ETN8PglqfuKPURbbva6G7VbnCWU15nypH45UCIdMYwOxsZASGu1Xyj73BiSNLidtZDgJwkSYgbXJCMcpiiSMdWsvpworySxp8g84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732759234; c=relaxed/simple;
	bh=hOOOULTJUDl6V4BuKieCinx2cEaSAl1r+q1YY0fONjA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QWspDcltP+JbGgjUziQKKmnRwuUzCjGq2oRS+2c3TzskWjltWuxvggpZ8m6FSZKY/XbXDvr4YQcKdrrenPhktXOCUsPLdF/sfFDeHpUMIA5P6PltGr3Fk0o4rElSfgnxHLqTReGoZStIcv1TlBeJ+8eahjzGgp/w/BmcXsq+tsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XhmyBh9j; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732759230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=obLlZ+jmbczg3UIn8oVPQK96dLu2F2rrMm0/IsSd8DU=;
	b=XhmyBh9jC3RF+JOE+OZIWCrx80gRhFSlsiv0zcyJ55NRxrXJ2AUp6dMTFrqlrd+H/o6ZDS
	rfEvc0wxB4Pa32H76OcAy7bPbcpzR1cs7u3cN1KX+D5pZ+fIPIcL+/xJd6W+d8v5VJRT2E
	Z0aqdZLR1bd24JK3H6hD2wJySHVg4B4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-118-SIMpgOg-Puu3KI1i6C9nZA-1; Wed,
 27 Nov 2024 21:00:24 -0500
X-MC-Unique: SIMpgOg-Puu3KI1i6C9nZA-1
X-Mimecast-MFC-AGG-ID: SIMpgOg-Puu3KI1i6C9nZA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 13F811955F41;
	Thu, 28 Nov 2024 02:00:23 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.88.24])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DE5E71955F40;
	Thu, 28 Nov 2024 02:00:20 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will.deacon@arm.com>,
	Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Guenter Roeck <linux@roeck-us.net>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH v2] locking/lockdep: Enforce PROVE_RAW_LOCK_NESTING only if ARCH_SUPPORTS_RT
Date: Wed, 27 Nov 2024 21:00:09 -0500
Message-ID: <20241128020009.83347-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Relax the rule to set PROVE_RAW_LOCK_NESTING by default only for arches
that supports PREEMPT_RT.  For arches that do not support PREEMPT_RT,
they will not be forced to address unimportant raw lock nesting issues
when they want to enable PROVE_LOCKING.  They do have the option
to enable it to look for these raw locking nesting problems if they
choose to.

Suggested-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 lib/Kconfig.debug | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 1e37c62e8595..942b4cb138bd 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1397,9 +1397,9 @@ config PROVE_LOCKING
 	 For more details, see Documentation/locking/lockdep-design.rst.
 
 config PROVE_RAW_LOCK_NESTING
-	bool
+	bool "Enable raw_spinlock - spinlock nesting checks" if !ARCH_SUPPORTS_RT
 	depends on PROVE_LOCKING
-	default y
+	default y if ARCH_SUPPORTS_RT
 	help
 	 Enable the raw_spinlock vs. spinlock nesting checks which ensure
 	 that the lock nesting rules for PREEMPT_RT enabled kernels are
-- 
2.47.0


