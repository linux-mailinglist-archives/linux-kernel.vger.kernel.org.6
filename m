Return-Path: <linux-kernel+bounces-261545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F1A93B89B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 23:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BCB71C235C5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 21:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966BB78C60;
	Wed, 24 Jul 2024 21:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a2IVfReB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DAD134DE
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 21:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721857005; cv=none; b=mG0MSzrZFjcYvOCKAXBQ80YUadmUA4KrwGzfEazY5WY1NsLZ930hrlUghWtcf/KhVvAVXnFo+/7NQ+XuiD4I9WtD7Y5urUxFzkkocxpr8tMUkOYRO4WR0CiT8297UCLRXWUnixv+r7CxESe+i22cRUDT4/4Lfclv9oo8ZNGeTN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721857005; c=relaxed/simple;
	bh=UvVOjl0/12oevUPYIpBpoCCzogDnOIpBlZFeYgpr5qg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nyAOHrE7prgOoliT2SXJ/c+sNl+kTOpH/XsyZvTnRHrRMhXo+cLbEtS8/uAzjOWeNbW6xF6m6HEJZh2tzEP0PgeYG5xGIIyqvd2ACwnB/OJAkXvNQs1o+IXDlVdf8NxUhMaFSJPNk6xnu7Mw1AWqo8ThE43UbhSRHEVpJz7QUtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a2IVfReB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721857003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2y89PNctEzPUc+h76+bt1W01RrcAjwiLgSR3Gn3y5wY=;
	b=a2IVfReBsx5UKErqCSWs/hQRTBbKNEwYz/MmS5i9UBSGSMU3eHg1KxYQZYIN534WQ9Vn2E
	iYbHK39cnMHLicAXA6AMxcILO6etaq2+552jKiqASSnuFuWusoBF4rBZ3P54vU17PlA9sN
	s+j+zTyIyJaEVEa2bmVaIF50KHRR4wQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-524-JaGloUhgMZy4TKbLi4QpzA-1; Wed,
 24 Jul 2024 17:36:37 -0400
X-MC-Unique: JaGloUhgMZy4TKbLi4QpzA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AB1301955D42;
	Wed, 24 Jul 2024 21:36:35 +0000 (UTC)
Received: from h1.redhat.com (unknown [10.22.33.84])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D210E1955F40;
	Wed, 24 Jul 2024 21:36:32 +0000 (UTC)
From: Nico Pache <npache@redhat.com>
To: linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org
Cc: akpm@linux-foundation.org,
	shuah@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	stable@kernel.org,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH v2] selftests: mm: add s390 to ARCH check
Date: Wed, 24 Jul 2024 15:35:17 -0600
Message-ID: <20240724213517.23918-1-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

commit 0518dbe97fe6 ("selftests/mm: fix cross compilation with LLVM")
changed the env variable for the architecture from MACHINE to ARCH.

This is preventing 3 required TEST_GEN_FILES from being included when
cross compiling s390x and errors when trying to run the test suite.
This is due to the ARCH variable already being set and the arch folder
name being s390.

Add "s390" to the filtered list to cover this case and have the 3 files
included in the build.

Fixes: 0518dbe97fe6 ("selftests/mm: fix cross compilation with LLVM")
Cc: stable@kernel.org
Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Nico Pache <npache@redhat.com>
---
 tools/testing/selftests/mm/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index 901e0d07765b..7b8a5def54a1 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -110,7 +110,7 @@ endif
 
 endif
 
-ifneq (,$(filter $(ARCH),arm64 ia64 mips64 parisc64 powerpc riscv64 s390x sparc64 x86_64))
+ifneq (,$(filter $(ARCH),arm64 ia64 mips64 parisc64 powerpc riscv64 s390x sparc64 x86_64 s390))
 TEST_GEN_FILES += va_high_addr_switch
 TEST_GEN_FILES += virtual_address_range
 TEST_GEN_FILES += write_to_hugetlbfs
-- 
2.45.2


