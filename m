Return-Path: <linux-kernel+bounces-261475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA9293B7CC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 22:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1745B1F250B4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 20:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62EC916C694;
	Wed, 24 Jul 2024 20:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LpO3Z+4q"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E1650284
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 20:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721851849; cv=none; b=OceyHfiGNTBtNlQcHFUzN8xyXaL7Ylxzja47sMCoN9trdssuagi7ekQ7V7cKeUM2zUGBbUyrQxG3esh5hR0/0m3OhisMSQ5NFAzBnSck4IzInpD7Tr0WjgZNgFY5ZL3XMelQUF1vQQAqeIJQSEgHjgPYs3ja1HxyZ9iBFs+VSF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721851849; c=relaxed/simple;
	bh=jLkje1TMaMcDFZ1isivzibz735Gz2ysL24u90U03b/U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jANQ985ohSRtYlAqz8oRZKkTCl3dgS92bS5i6/gBxuzYcUaYvJfwJYx2WopsJip3A0VmkU0HrqxTYDkgUhQ7QjqrvD7wC4Vbip3M3HgyiOAIy5FBsVdHfdOqAmI1/qPvkt+6IoZI9jm4xwMf6q+KMPbMDKe1ibNRQMwx8DZzjz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LpO3Z+4q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721851846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=B+KGAhlehjnwvrQJqvaNqFPQndDkZyQpii0lamAO9o4=;
	b=LpO3Z+4qIt/yuPQgPD/51FG7VA7qSqYZtg3Ua70kEIeZrEk91tdVNp1Qg6MndA+bbgotQx
	fc0ZEfULmD4Wz2FN4VyMjrl6D3OGgKvehcjYLp6Xo0GH3I6cuIQPQBM9ILU2uqHwS3IpD1
	G536SJIdE4csKq42xntz5XfwTHylahU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-595-PNLVw-IsPMmHl6nqa7JusQ-1; Wed,
 24 Jul 2024 16:10:41 -0400
X-MC-Unique: PNLVw-IsPMmHl6nqa7JusQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 32B2119560B3;
	Wed, 24 Jul 2024 20:10:39 +0000 (UTC)
Received: from h1.redhat.com (unknown [10.22.33.84])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7BDEE1955D42;
	Wed, 24 Jul 2024 20:10:36 +0000 (UTC)
From: Nico Pache <npache@redhat.com>
To: linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org
Cc: akpm@linux-foundation.org,
	shuah@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Subject: [PATCH] selftests: mm: add s390 to ARCH check
Date: Wed, 24 Jul 2024 14:09:55 -0600
Message-ID: <20240724200955.14882-1-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

When compiling with ARCH already set, the s390x ARCH is actually s390.
Add s390 to the ARCH check list, so we can properly build selftests for
s390.

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


