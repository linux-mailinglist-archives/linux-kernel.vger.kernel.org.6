Return-Path: <linux-kernel+bounces-556200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB82A5C25C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 14:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F3A21891CC3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 13:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECD02222BD;
	Tue, 11 Mar 2025 13:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r8u+PQK9"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9802571A3
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 13:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741699121; cv=none; b=PAhw86UrjqpEgzZEVxOxFLX39KVwlf65A8nHQ3cemYJdwMaCE1iHtKoPOo9AG2v/MmNIKpwuDc7Rg2jBmHhqMiB/1c5Gw/b9ows5rIYZK6WD0yUcqP3CPdlicGKfq7LAYKMojegXIk4KDHzSew1m3a9Fg/03y3agieTbEV0i6y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741699121; c=relaxed/simple;
	bh=keuqAf1Yd7pMC60Jehq/im4QvYhNmbzI5DqGZpBJqLI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=B6ZlPmAlgJMOvuuNEFDRN2+My/3OCboNuv8mGR545AT2Te/W0Mt6pURRQ9tfPtOVI3+HTnIkQGXusw2T6GPzISsXywhBLZu8xsXWu3Ge3lvuBtr4tqk3eD7Q4aCDEqWWPDu/77qLCxRgoJYrqlFtsi7jsMdVMrsCdMrY2+PkCt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r8u+PQK9; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43d00017e9dso9065545e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 06:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741699118; x=1742303918; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=h7ic2pHOinjRIlh+O43kggDBsm61b3OXoKlUUGdMcQQ=;
        b=r8u+PQK9GbqRfxVUanAZh6A/XMo4EDT2oMZ1q8Uo/0jpRjQuNHIxczEEHPIm9oPzgu
         c3yIthtIbM+U8OMSBHSotcuAfucj6NmSybVqopKRA+qM3dCPhgcJKO8jxGnOiAU3PqR9
         J9Xr+kdubXkcNeLEeNXf8NoRE7dK+gVMblUPc4PrS2yqHmzwIriUFFFnko5gDmv0vYPM
         VdWX6OK6oV/yMIwc0Cs5TUeyYCg6qi9MvV7kalpzmQIcaK5Omk1ClmiW4LE4LTsUbGHz
         JIsOXoOo2vnLtzrO/w9C72qZ+RUC/2UiWcX5+aPpYzN9WXwq9KnmNuMxNNQ+rr9X5Z4S
         nCBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741699118; x=1742303918;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h7ic2pHOinjRIlh+O43kggDBsm61b3OXoKlUUGdMcQQ=;
        b=eZ+pUig2GmXI/Q5Z1Ao+qgYJrxs1bxYpPwUEF7qLQ4aCBaFpgzBkZcfqe6BhbVj9Sv
         0JdZuPzWnM7pK0wPZU0ptb/GuMmVmi2I1dvfLq4M6gzD0czSk26It3AfDX0cXvwvMtY1
         wJo0F0NqnWEaBpvytJ5KYWZAbvXsCS3dfSVZ/QqgM8FxXEJBe2EBOxwXo7omAg2yHeYf
         1GeN0geOM3sZBHxcy+vO4gsqGm1IQ6qmuNAAe/HafYTNQiSqAPXUJuWywQz6N7kS0uQ/
         A96RqiOfUGoPsBvI1GwOskh2FXsLzsIpby8iwGhBcWJa7umitaSKET+52A2rSI6+7YCi
         uiPg==
X-Forwarded-Encrypted: i=1; AJvYcCWe8qrlq9ui45vKt8UkFVb44efva9wkjhFALNJOJbwYcNcgt4m8tcC93/TH15BQR2NC3K6HXd/DGO4HpDo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbpbjlV0oL410edDv98RG24DthEuGl1tg/koVUfmXy2xpKLJ/q
	qctr85vFUQCmu9Tut37aB32S+xtcAcyZGieOSolhUeJTBnAMq65BPtpG2Oj5M+xrFp3xuYw4n0F
	UxbErG2cUbg==
X-Google-Smtp-Source: AGHT+IHZlMGTcKX5RZ/uPw4+acv8n0aHStFuR6vrPyvpA6CiIDxxzLWRCjz5dgJEeQYAtTRRHyrT3C1VMcyAzA==
X-Received: from wmbea7.prod.google.com ([2002:a05:600c:6747:b0:43c:f8e5:6033])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3586:b0:43c:ec4c:25b1 with SMTP id 5b1f17b1804b1-43cec4c26d2mr91373805e9.23.1741699118100;
 Tue, 11 Mar 2025 06:18:38 -0700 (PDT)
Date: Tue, 11 Mar 2025 13:18:21 +0000
In-Reply-To: <20250311-mm-selftests-v4-0-dec210a658f5@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250311-mm-selftests-v4-0-dec210a658f5@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20250311-mm-selftests-v4-10-dec210a658f5@google.com>
Subject: [PATCH v4 10/12] selftests/mm: Ensure uffd-wp-mremap gets pages of
 each size
From: Brendan Jackman <jackmanb@google.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>
Cc: Dev Jain <dev.jain@arm.com>, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

This test allocates a page of every available size and doesn't have any
SKIP logic if the allocation fails. So, ensure it's available and skip
the test if we can't do so.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 tools/testing/selftests/mm/run_vmtests.sh | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
index 0f9fe757c3320a6551e39b6d4552fd4874b0bf43..e86ef8cb37d00e572be8cf0ea9cc8246d4eecd7e 100755
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -309,9 +309,30 @@ CATEGORY="userfaultfd" run_test ${uffd_stress_bin} hugetlb "$half_ufd_size_MB" 3
 CATEGORY="userfaultfd" run_test ${uffd_stress_bin} hugetlb-private "$half_ufd_size_MB" 32
 CATEGORY="userfaultfd" run_test ${uffd_stress_bin} shmem 20 16
 CATEGORY="userfaultfd" run_test ${uffd_stress_bin} shmem-private 20 16
-CATEGORY="userfaultfd" run_test ./uffd-wp-mremap
+# uffd-wp-mremap requires at least one page of each size.
+have_all_size_hugepgs=true
+declare -A nr_size_hugepgs
+for f in /sys/kernel/mm/hugepages/**/nr_hugepages; do
+	old=$(cat $f)
+	nr_size_hugepgs["$f"]="$old"
+	if [ "$old" == 0 ]; then
+		echo 1 > "$f"
+	fi
+	if [ $(cat "$f") == 0 ]; then
+		have_all_size_hugepgs=false
+		break
+	fi
+done
+if $have_all_size_hugepgs; then
+	CATEGORY="userfaultfd" run_test ./uffd-wp-mremap
+else
+	echo "# SKIP ./uffd-wp-mremap"
+fi
 
 #cleanup
+for f in "${!nr_size_hugepgs[@]}"; do
+	echo "${nr_size_hugepgs["$f"]}" > "$f"
+done
 echo "$nr_hugepgs" > /proc/sys/vm/nr_hugepages
 
 CATEGORY="compaction" run_test ./compaction_test

-- 
2.49.0.rc0.332.g42c0ae87b1-goog


