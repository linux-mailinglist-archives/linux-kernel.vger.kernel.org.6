Return-Path: <linux-kernel+bounces-520233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C37D8A3A74D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 20:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1C693B1BC7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 19:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857FD1E835A;
	Tue, 18 Feb 2025 19:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BUUPTzZ6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCEF17A31C
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 19:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739906594; cv=none; b=X7oQxcfghRXynTpSKkVVwJL0cbfsjnz9OGqzPDAyxajdmuHfQk71v7XsXOzFuw4EN2EM77aJ4Q9I8czbF4g3UrVI1wv/v5x5rbN7TUDF/adR6CEIsc2jF5QZYuRq7GOHZah5pwby5RmDFUUU7TulU2b2PITWoH11zthEgMRak8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739906594; c=relaxed/simple;
	bh=rIbyj8Nfyu7DcneP0IRpGppUs09YF1sxNIX45ZVw0hE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EUiGZ3eTWYBYeJqbokrWtFwulHnMLwskx7u7lD7RrYkMuqOIRv+yrArXVmGIv/4Xtg7ae9ZdP1KxMOSm0rxH+5IGsyGDgfgay6svPIHVfSp+q7Mdh9Peiqu87a1XSzQI/3pY2PJt6oj8mlqiAV46Co7qKJxD4mY4uc/Q/knikWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BUUPTzZ6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739906591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MERCQpBpo0tKF1DN4IvIC5vT6oTv8oj1DKhfqvfja4w=;
	b=BUUPTzZ6tOiDp5U1VYK1ImOaArqWZi10kcWMtkT/kpNM8rBtlUZ8XKn5s9E2CkBgR9XSDe
	q4IDmSUFyuRhJfb7vZ3Gr8jisBcRZfvxD1qxsoDl8fJkgxn4bf3FGy4naG76a8cg7gX2s/
	YInKRroKeXuM1lT4mvOALmtRrIhG6IM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-650-sytx-8WxP9i_Ga2YRr4Ajw-1; Tue,
 18 Feb 2025 14:23:06 -0500
X-MC-Unique: sytx-8WxP9i_Ga2YRr4Ajw-1
X-Mimecast-MFC-AGG-ID: sytx-8WxP9i_Ga2YRr4Ajw_1739906585
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6AC891800878;
	Tue, 18 Feb 2025 19:23:05 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.22.58.10])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D89C81800374;
	Tue, 18 Feb 2025 19:23:03 +0000 (UTC)
From: Rafael Aquini <aquini@redhat.com>
To: linux-kselftest@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Peter Xu <peterx@redhat.com>,
	David Hildenbrand <david@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Subject: [PATCH] selftests/mm: run_vmtests.sh: fix half_ufd_size_MB calculation
Date: Tue, 18 Feb 2025 14:22:51 -0500
Message-ID: <20250218192251.53243-1-aquini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

From: Rafael Aquini <raquini@redhat.com>

We noticed that uffd-stress test was always failing to run when invoked
for the hugetlb profiles on x86_64 systems with a processor count of 64
or bigger:
  ...
  # ------------------------------------
  # running ./uffd-stress hugetlb 128 32
  # ------------------------------------
  # ERROR: invalid MiB (errno=9, @uffd-stress.c:459)
  ...
  # [FAIL]
  not ok 3 uffd-stress hugetlb 128 32 # exit=1
  ...

The problem boils down to how run_vmtests.sh (mis)calculates the size
of the region it feeds to uffd-stress. The latter expects to see an
amount of MiB while the former is just giving out the number of free
hugepages halved down. This measurement discrepancy ends up violating
uffd-stress' assertion on number of hugetlb pages allocated per CPU,
causing it to bail out with the error above.

This commit fixes that issue by adjusting run_vmtests.sh's half_ufd_size_MB
calculation so it properly renders the region size in MiB, as expected,
while maintaining all of its original constraints in place.

Fixes: 2e47a445d7b3 ("selftests/mm: run_vmtests.sh: fix hugetlb mem size calculation")
Signed-off-by: Rafael Aquini <raquini@redhat.com>
---
 tools/testing/selftests/mm/run_vmtests.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
index 333c468c2699..157d07e5aaa3 100755
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -304,7 +304,9 @@ uffd_stress_bin=./uffd-stress
 CATEGORY="userfaultfd" run_test ${uffd_stress_bin} anon 20 16
 # Hugetlb tests require source and destination huge pages. Pass in half
 # the size of the free pages we have, which is used for *each*.
-half_ufd_size_MB=$((freepgs / 2))
+# uffd-stress expects a region expressed in MiB, so we adjust
+# half_ufd_size_MB accordingly.
+half_ufd_size_MB=$(((freepgs * hpgsize_KB) / 1024 / 2))
 CATEGORY="userfaultfd" run_test ${uffd_stress_bin} hugetlb "$half_ufd_size_MB" 32
 CATEGORY="userfaultfd" run_test ${uffd_stress_bin} hugetlb-private "$half_ufd_size_MB" 32
 CATEGORY="userfaultfd" run_test ${uffd_stress_bin} shmem 20 16
-- 
2.47.0


