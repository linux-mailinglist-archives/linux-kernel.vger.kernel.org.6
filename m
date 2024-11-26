Return-Path: <linux-kernel+bounces-422890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F43B9D9F77
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 00:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73567284CC1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 23:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423701DC04C;
	Tue, 26 Nov 2024 23:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U1kZ7DEy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA9A156F54
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 23:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732662745; cv=none; b=JZ3JhAB7rUBE2vZNnguZBFDLwo0YmHBvfAFAzv68Uk/P/0e6CzznNx7o7VzFYgGdwIYAkKCwwXZR6q8/eGEEXdhhCDIaEP6HnW8w4FPNYW9wu9whFfVTIcvBEadlCNoD26vnoTR0WPzX87UbWIUAtZnQrQXdqJIrEIJ6eloAiQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732662745; c=relaxed/simple;
	bh=uPCk0tjzuCae921/ffB6a8jwmhKwDjKt82puj2TlVQE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VT4RSlP3ZrE0lADqQSswwB7TjYHwiwcdoTrnEUV0/GuIODLGtjetJN2SmGEsYbCz9KVGk501HWm/zfZcZlbLn/ROXDb5BymDhRB9QQ3EXbanOfbFpmUhqfBqGwD+9yC+iXuOgwvniSEh5UKEwf9+0OMTObbyWbafMiHsYhdEqIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U1kZ7DEy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732662742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=a3E4zCW/QYvuCUsmMiYm11wdBakri5Yl3axYTs/8eUw=;
	b=U1kZ7DEylny0Apf4ZUHQlu/6Wx8nP1vL5BwR3PKSdwNLeVcanEbt1suer9uLmeQi2aSzSQ
	X7YSzTaaC8TETRoghDNDizKUfzdOXwxbFXDstdSkZI/5aA+uXGgXvX2k2/VbB+cy0b9DQ4
	ABC4ZZ5MX7IChkivXgq6lewOxjfvN70=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-214-mu48ss-3NnqvVzsztuznVA-1; Tue,
 26 Nov 2024 18:12:19 -0500
X-MC-Unique: mu48ss-3NnqvVzsztuznVA-1
X-Mimecast-MFC-AGG-ID: mu48ss-3NnqvVzsztuznVA
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E435A1955F77;
	Tue, 26 Nov 2024 23:12:16 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.80.155])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 93E9F1955F43;
	Tue, 26 Nov 2024 23:12:14 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will.deacon@arm.com>,
	Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Guenter Roeck <linux@roeck-us.net>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH] locking/lockdep: Enforce PROVE_RAW_LOCK_NESTING only if ARCH_SUPPORTS_RT
Date: Tue, 26 Nov 2024 18:11:54 -0500
Message-ID: <20241126231154.29151-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Relax the rule to set PROVE_RAW_LOCK_NESTING by default only for arches
that supports PREEMPT_RT.  For arches that do not support PREEMPT_RT,
they will not be forced to address irrelevant raw lock nesting issues
when they want to enable PROVE_LOCKING.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 lib/Kconfig.debug | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 1e37c62e8595..c53a498dc33f 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1398,7 +1398,7 @@ config PROVE_LOCKING
 
 config PROVE_RAW_LOCK_NESTING
 	bool
-	depends on PROVE_LOCKING
+	depends on PROVE_LOCKING && ARCH_SUPPORTS_RT
 	default y
 	help
 	 Enable the raw_spinlock vs. spinlock nesting checks which ensure
-- 
2.47.0


