Return-Path: <linux-kernel+bounces-204855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5938FF440
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 20:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A63B11C259B8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 18:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C15919923F;
	Thu,  6 Jun 2024 18:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gYvZ/zl2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2071991B5
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 18:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717697200; cv=none; b=JQfKbmG6XYXZ5PZzkAOtu3gA9uPEgGlFhkMFCU/yy6fL1llZXWTyHRcXQjEJK714lX7D9ISshhd00J0I280sB2kUbwhsJeFLRXQt6c+gAbrf82TdeGuxckqLTP87sBBJHwIvhf/OVpBciqktrm2/h7IPz/dUXFnDQdKOMy1VL9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717697200; c=relaxed/simple;
	bh=lMDn1uocnjXfnaNs7h/6Vc00lDfGKLB++g8s7GmYspM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TeuxtUhg17HFH0ObAHn6YHvAupInioGUVqDla7KqUDRkT8wYsReEIvgBTM/8xn0BwdxuIY1YW4JoJmJk5fJz+g2e6FsrXaufPA/BjnjuLC5IEzveFIqiebk0gFJw+KqwV9qeooMHWCmut35ACgm8EtSTQNW9b94eifh+nY0x9T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gYvZ/zl2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717697197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ploNnb30dcebwBkPeSH7wgb98OTua6fPbvs/Oi2kKNM=;
	b=gYvZ/zl2Ep2/I2TuiOBDbpRNDaKeN26g9geGMJsZGqEfl6a32TYyN+0OsHaUKitBBCoUt2
	ZkHMkQmW9EKMxVBjqnFrL16qbLTZMQJ9aHdvnSPU0SM+dse5vtnVooMj1MkLlXxC1aq2ls
	DK30V9Vsc7Q2a1t+LiPlI66lwlr47OM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117--H01VEbSOwWD8FC8IfBTNw-1; Thu, 06 Jun 2024 14:06:32 -0400
X-MC-Unique: -H01VEbSOwWD8FC8IfBTNw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D52CC8007A1;
	Thu,  6 Jun 2024 18:06:31 +0000 (UTC)
Received: from optiplex-lnx.redhat.com (unknown [10.22.16.6])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0751B2023299;
	Thu,  6 Jun 2024 18:06:30 +0000 (UTC)
From: Rafael Aquini <aquini@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Heiko Carstens <hca@linux.ibm.com>,
	Petr Mladek <pmladek@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Paul McKenney <paulmck@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Rafael Aquini <aquini@redhat.com>
Subject: [PATCH v2] mm: mmap: allow for the maximum number of bits for randomizing mmap_base by default
Date: Thu,  6 Jun 2024 14:06:22 -0400
Message-ID: <20240606180622.102099-1-aquini@redhat.com>
In-Reply-To: <20240606170026.101839-1-aquini@redhat.com>
References: <20240606170026.101839-1-aquini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

An ASLR regression was noticed [1] and tracked down to file-mapped areas
being backed by THP in recent kernels. The 21-bit alignment constraint
for such mappings reduces the entropy for randomizing the placement of
64-bit library mappings and breaks ASLR completely for 32-bit libraries.

The reported issue is easily addressed by increasing vm.mmap_rnd_bits
and vm.mmap_rnd_compat_bits. This patch just provides a simple way to
set ARCH_MMAP_RND_BITS and ARCH_MMAP_RND_COMPAT_BITS to their maximum
values allowed by the architecture at build time.

[1] https://zolutal.github.io/aslrnt/

Signed-off-by: Rafael Aquini <aquini@redhat.com>
---
v2: fix "architercure" typo in config's help text

 arch/Kconfig | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index 975dd22a2dbd..25ec91ac923a 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1046,10 +1046,21 @@ config ARCH_MMAP_RND_BITS_MAX
 config ARCH_MMAP_RND_BITS_DEFAULT
 	int
 
+config FORCE_MAX_MMAP_RND_BITS
+	bool "Force maximum number of bits to use for ASLR of mmap base address"
+	default n
+	help
+	  ARCH_MMAP_RND_BITS and ARCH_MMAP_RND_COMPAT_BITS represent the number
+	  of bits to use for ASLR and if no custom value is assigned (EXPERT)
+	  then the architecture's lower bound (minimum) value is assumed.
+	  This toggle changes that default assumption to assume the arch upper
+	  bound (maximum) value instead.
+
 config ARCH_MMAP_RND_BITS
 	int "Number of bits to use for ASLR of mmap base address" if EXPERT
 	range ARCH_MMAP_RND_BITS_MIN ARCH_MMAP_RND_BITS_MAX
 	default ARCH_MMAP_RND_BITS_DEFAULT if ARCH_MMAP_RND_BITS_DEFAULT
+	default ARCH_MMAP_RND_BITS_MAX if FORCE_MAX_MMAP_RND_BITS
 	default ARCH_MMAP_RND_BITS_MIN
 	depends on HAVE_ARCH_MMAP_RND_BITS
 	help
@@ -1084,6 +1095,7 @@ config ARCH_MMAP_RND_COMPAT_BITS
 	int "Number of bits to use for ASLR of mmap base address for compatible applications" if EXPERT
 	range ARCH_MMAP_RND_COMPAT_BITS_MIN ARCH_MMAP_RND_COMPAT_BITS_MAX
 	default ARCH_MMAP_RND_COMPAT_BITS_DEFAULT if ARCH_MMAP_RND_COMPAT_BITS_DEFAULT
+	default ARCH_MMAP_RND_COMPAT_BITS_MAX if FORCE_MAX_MMAP_RND_BITS
 	default ARCH_MMAP_RND_COMPAT_BITS_MIN
 	depends on HAVE_ARCH_MMAP_RND_COMPAT_BITS
 	help
-- 
2.45.1


