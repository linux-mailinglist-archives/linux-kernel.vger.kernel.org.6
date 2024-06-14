Return-Path: <linux-kernel+bounces-214598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7AF79086F3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 11:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74CBC1F2386C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 09:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2125A18C32B;
	Fri, 14 Jun 2024 09:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BU5n25U7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5068148844
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 09:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718355801; cv=none; b=CZHbvAFlJKWbYB8OBR+xDjO82Oc7vTtdfVe2cF/r5fAOc0HuF/Tp41ym2PDovIwoHm1K7mTy5uOxd0bVMMerGIaIWcHkvQnBP+k6fB9rZ00083LeU3b+sRCfV++zEBn8/XaKCYbExcEMC0kJaC7HQtQ6BqHaPVQG9HhC/UyoyQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718355801; c=relaxed/simple;
	bh=b7I5Tl0JW4uTtQ7s9QjyAYW5T4OAzZ3xsuUADWTLiiM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r2sCUrwf8FcoZ3geiZQZnbpJFMpp7GIpk1gdmve9QMkEh8VUhHnUuTh/0lccvgshitd5nFHuTBSeagr6RB/wSxthpGqUCi0PjM6S3GI1J/nW+VbFGBEZW5FFyNjxfSQUe1zsx4DZ7ZtzqcNMH0VclfT77RoUAnInV4M92UzQF+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BU5n25U7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718355798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=a4dxEa+doWbUECdCauPFkZSumhcXdmc3uGpssQtnBUc=;
	b=BU5n25U7S692DGmKOwfM15gllbVt5BrOF+ZACf0whPkODkZ3ZJUzMn2L4sD4RTtOgmOItP
	LN8/TaMGM0TngGr/mYetwffGny8cd19lh2VY1nT4WidPghMqZvJTxPm0kUeCb0sOyOfBQq
	mcJ0RBSlaXi5CzT6UQ6DYxO9dQ5FSgY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-672-B7-KTaEjNmuUKWuw__1JbQ-1; Fri,
 14 Jun 2024 05:03:17 -0400
X-MC-Unique: B7-KTaEjNmuUKWuw__1JbQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E5D5A195608F;
	Fri, 14 Jun 2024 09:03:14 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.73])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id ECA9C1956050;
	Fri, 14 Jun 2024 09:03:08 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: linux-doc@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] Documentation: Remove "mfgpt_irq=" from the kernel-parameters.txt file
Date: Fri, 14 Jun 2024 11:03:06 +0200
Message-ID: <20240614090306.561464-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The kernel parameter mfgpt_irq has been removed in 2009 already in the
commit c95d1e53ed89 ("cs5535: drop the Geode-specific MFGPT/GPIO code").
Time to remove it from the documentation now, too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a9b905bbc8ca..756ac1e22813 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3426,10 +3426,6 @@
 			deep    - Suspend-To-RAM or equivalent (if supported)
 			See Documentation/admin-guide/pm/sleep-states.rst.
 
-	mfgpt_irq=	[IA-32] Specify the IRQ to use for the
-			Multi-Function General Purpose Timers on AMD Geode
-			platforms.
-
 	mfgptfix	[X86-32] Fix MFGPT timers on AMD Geode platforms when
 			the BIOS has incorrectly applied a workaround. TinyBIOS
 			version 0.98 is known to be affected, 0.99 fixes the
-- 
2.45.2


