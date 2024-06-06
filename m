Return-Path: <linux-kernel+bounces-204761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B878FF342
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 19:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 675081F27908
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 17:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C288F198E7F;
	Thu,  6 Jun 2024 17:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="depOaQsQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825BC26AE3
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 17:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717693256; cv=none; b=GithEObt8xDlKTvevZj3+SQN40mtfNM5WiZFJoYsBz4CPwnih3499NPGAeybo9uGuBRuy+2Xd9xfsRnTfvlX7MNyXaobn3TrWYWmOD7qelZVrAFm3dgxlCGrcWDCB6gJoFvpLnindQfGLQ5xSrwEvAx6W/m0aB3dc+UoA7pbJ5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717693256; c=relaxed/simple;
	bh=gYqCnMw2W8NFjNyji+0KS2A9bl9lLZNC5dxAjJhfRWM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JMqmk/No81YG9mTwe6ixOEgLgStyZ17AIBaE6exqqmaqCwGJ/jeyKOwiOmjyNzYCvTfGuEPtoLrIfZQar53RL4PSFCBGgrUQi8me0uotpsOB4fTWkEuw0eJ1zbbFnSK9TSHChwFTwA0PeD2F2MVXdn0n9OpVEWnIlhXk+Y7TY1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=depOaQsQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717693253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=12SCf/jBTy7eK+7KYg6NLYNlOZ3t7D2JjPK/ZcEcsUQ=;
	b=depOaQsQdXlJS78usxk+iIKrb7H/tMsOcBnqXJ7uIzA6DX3x7ilGVndyjVVv4EA4lc8qIR
	BuqxofxSjD/9be3Hjxac1Pt59Aa5qUhIX+D3SC3KQsX7eDMVPGDVjNIj5dthrdmsH7WCOR
	7aE+Ct+Ec1vujfM1blGL4oHv2nSosYk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-qH1YXT1RNY-owifrvKOuJw-1; Thu, 06 Jun 2024 13:00:49 -0400
X-MC-Unique: qH1YXT1RNY-owifrvKOuJw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5D1BA800074;
	Thu,  6 Jun 2024 17:00:49 +0000 (UTC)
Received: from optiplex-lnx.redhat.com (unknown [10.22.16.6])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3CD1E37E0;
	Thu,  6 Jun 2024 17:00:48 +0000 (UTC)
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
Subject: [PATCH] mm: mmap: allow for the maximum number of bits for randomizing mmap_base by default
Date: Thu,  6 Jun 2024 13:00:26 -0400
Message-ID: <20240606170026.101839-1-aquini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

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
 arch/Kconfig | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index 975dd22a2dbd..b142f0752dc5 100644
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
+	  then the architercure's lower bound (minimum) value is assumed.
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


