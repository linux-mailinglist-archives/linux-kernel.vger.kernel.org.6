Return-Path: <linux-kernel+bounces-566993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BEE2A67F84
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 23:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D328C42528D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 22:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5603E206F38;
	Tue, 18 Mar 2025 22:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ho9cpfUF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B078206F31
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 22:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742336106; cv=none; b=cp8GrGSw0HxxPS45hqvS4l6o4qYLSPH3ncqmoP63MY5jzh5s/htzkFyNOgur5Be7H4KNMPlUAzVg2mcweooh27xUa7z081In0zBpb3Eg4Bv/jdDsft8fBSwFAW4nJiUg23Jhce7DP+GAGNw3HWthSHlXNcnN5evX8IrizSUTI7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742336106; c=relaxed/simple;
	bh=dmIEFpP5Vzp4R9JKUVjUJzGbQUrzscJCuLnCPzsk7xQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UGuXtWIt2hPnWmGuRHvbyO5cSq+JB1t8e9p8VZ6/7oBwjbw+BJex3Fbbd9ZHt7bFtWa6kSNIqf+ilN8yJKHnzmR4zQlDL+B9WyTC+1tPxg8n1pckvUnzOcmhqAKNm1g0QagqUCiszlHTt7kPBw7aq9A3xizjnPgdArUKJoHeEew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ho9cpfUF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742336104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rus6kw9XsBL2c9jHGjOEjWiY0U6NqB+KHNJXO9LzuQY=;
	b=ho9cpfUFXwd2Fny0SJer32ZaUx+q33uj+lmS2tD3QdvQ2me7xjOJZXEeupEmu+Lr7RMCh4
	Cqb3QAxhKlJnGqvQvAMOApin8AVYUgpKOFLpbKJg+WvWTyGok80T+DNxl6hHrEKMdWUZtL
	YgLY9LjS91KD9ZAHq1BKMQWkangI6Aw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-UV6FgeMIMjuVgAgiNfzQew-1; Tue, 18 Mar 2025 18:15:03 -0400
X-MC-Unique: UV6FgeMIMjuVgAgiNfzQew-1
X-Mimecast-MFC-AGG-ID: UV6FgeMIMjuVgAgiNfzQew_1742336102
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-391345e3aa3so3650444f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 15:15:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742336102; x=1742940902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rus6kw9XsBL2c9jHGjOEjWiY0U6NqB+KHNJXO9LzuQY=;
        b=XnMWbJvs3WB1JtZXsKEd32eAZPyGS6wRhRUzAWlVYBoVs9EjDiSByMdiBdp/1dm62f
         MK64oH4IYtIS1Ped/1b2hXkF8/6EyNsGbnmrabnrqM1X59HEpsef3fNSqPmxOjYOLZS4
         jBp4BZzaqwrNUMTjmyf/7zpCrkzhlRpnKsAcirhZAGEbdwa8ZCOrP7U8TzgqYgp3Pz+h
         D+OkLu8+r4p17My7CY5KWEg2umWc+5zDXhM6EgklhCWGk6b6keXpsHIJtudNdZRo7x09
         RVO5NXXekZSm5gBuUfo2Ig3c1qmGmudWhNVNCl7pBxFwngVe4q5dQGkZx1WEwrmUKVC0
         G8qA==
X-Gm-Message-State: AOJu0YxzqCd4pb1cl1oBNTGHNQ656h1pSIewgMr4bVu80Nzz4E2c5E2L
	qfZU18ZI/t0SrGZfRqMGIaUEAUD3MNcBGBVqCD5Pk+NjCP+A2Z+LtWj3BcdQHqJgCt7gLL20Pb1
	jSZtLL6M/Q4cGiXnOOw9GGPYnj2dhkeTYlhDWp+VRcjDOodXn9zjx+DD6X4RP7IZabgYofnWnOL
	IQgNeFy3vgqBH8jIN/Ghp42D31+3+RIh7v2G/RaE7jb2kv
X-Gm-Gg: ASbGncvf4CHWD9wAVUbk83YR415Ca0xwZn/Cd3TeGGEdgJVyt2oMJ6nJRdwhlJjsILu
	hCpEZmxpluEO4FfaJENmBmqznoRzDgUq9dsH4rh66gwnaXb/1isiV/td8WwGS1WZgPCKY1I60yP
	d4y708gFvpiet8FhAThhH+4sR+UeolPo8G2ElaLwEjKXt5Y7bW59cOvCVrz1nDfEhqV6QaxEPXV
	z221JL9RJq2ydmZ3EFPh27EqwDvFi19PW3DbGW1GHP54qmsr8H5OOV/rA2DzrnUwYR4xzz7LVtU
	m0IuIt200/AfRGkVGPxrpVi3I6rPxVslmdYaiDWTtj4+eexv+IMsqkVv5cGZd0AXcKyZkW8H/J1
	6
X-Received: by 2002:a05:6000:2a6:b0:390:e8e4:7e3e with SMTP id ffacd0b85a97d-399739b484emr390681f8f.6.1742336101786;
        Tue, 18 Mar 2025 15:15:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEntLQOUh/Nv/fGa/REaqlKcGpxmQ8E/qfsoQdKPfCKbsE1Lco5OztnXYuajlRpXhgshxCpw==
X-Received: by 2002:a05:6000:2a6:b0:390:e8e4:7e3e with SMTP id ffacd0b85a97d-399739b484emr390645f8f.6.1742336101239;
        Tue, 18 Mar 2025 15:15:01 -0700 (PDT)
Received: from localhost (p200300cbc72d250094b54b7dad4afd0b.dip0.t-ipconnect.de. [2003:cb:c72d:2500:94b5:4b7d:ad4a:fd0b])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-395cb318a8bsm19682001f8f.66.2025.03.18.15.15.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 15:15:00 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Russell King <linux@armlinux.org.uk>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Tong Tiangen <tongtiangen@huawei.com>
Subject: [PATCH v2 1/3] kernel/events/uprobes: pass VMA instead of MM to remove_breakpoint()
Date: Tue, 18 Mar 2025 23:14:55 +0100
Message-ID: <20250318221457.3055598-2-david@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250318221457.3055598-1-david@redhat.com>
References: <20250318221457.3055598-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

... and remove the "MM" argument from install_breakpoint(), because it
can easily be derived from the VMA.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 kernel/events/uprobes.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 5d6f3d9d29f44..259038d099819 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1134,10 +1134,10 @@ static bool filter_chain(struct uprobe *uprobe, struct mm_struct *mm)
 	return ret;
 }
 
-static int
-install_breakpoint(struct uprobe *uprobe, struct mm_struct *mm,
-			struct vm_area_struct *vma, unsigned long vaddr)
+static int install_breakpoint(struct uprobe *uprobe, struct vm_area_struct *vma,
+		unsigned long vaddr)
 {
+	struct mm_struct *mm = vma->vm_mm;
 	bool first_uprobe;
 	int ret;
 
@@ -1162,9 +1162,11 @@ install_breakpoint(struct uprobe *uprobe, struct mm_struct *mm,
 	return ret;
 }
 
-static int
-remove_breakpoint(struct uprobe *uprobe, struct mm_struct *mm, unsigned long vaddr)
+static int remove_breakpoint(struct uprobe *uprobe, struct vm_area_struct *vma,
+		unsigned long vaddr)
 {
+	struct mm_struct *mm = vma->vm_mm;
+
 	set_bit(MMF_RECALC_UPROBES, &mm->flags);
 	return set_orig_insn(&uprobe->arch, mm, vaddr);
 }
@@ -1296,10 +1298,10 @@ register_for_each_vma(struct uprobe *uprobe, struct uprobe_consumer *new)
 		if (is_register) {
 			/* consult only the "caller", new consumer. */
 			if (consumer_filter(new, mm))
-				err = install_breakpoint(uprobe, mm, vma, info->vaddr);
+				err = install_breakpoint(uprobe, vma, info->vaddr);
 		} else if (test_bit(MMF_HAS_UPROBES, &mm->flags)) {
 			if (!filter_chain(uprobe, mm))
-				err |= remove_breakpoint(uprobe, mm, info->vaddr);
+				err |= remove_breakpoint(uprobe, vma, info->vaddr);
 		}
 
  unlock:
@@ -1472,7 +1474,7 @@ static int unapply_uprobe(struct uprobe *uprobe, struct mm_struct *mm)
 			continue;
 
 		vaddr = offset_to_vaddr(vma, uprobe->offset);
-		err |= remove_breakpoint(uprobe, mm, vaddr);
+		err |= remove_breakpoint(uprobe, vma, vaddr);
 	}
 	mmap_read_unlock(mm);
 
@@ -1610,7 +1612,7 @@ int uprobe_mmap(struct vm_area_struct *vma)
 		if (!fatal_signal_pending(current) &&
 		    filter_chain(uprobe, vma->vm_mm)) {
 			unsigned long vaddr = offset_to_vaddr(vma, uprobe->offset);
-			install_breakpoint(uprobe, vma->vm_mm, vma, vaddr);
+			install_breakpoint(uprobe, vma, vaddr);
 		}
 		put_uprobe(uprobe);
 	}
-- 
2.48.1


