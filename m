Return-Path: <linux-kernel+bounces-544799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB0BA4E50F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:09:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05D927A59DF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899AA25DD0E;
	Tue,  4 Mar 2025 15:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X7CuhkuP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996AF29B239
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 15:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741103342; cv=none; b=snZTceF021Qh79oK8pwgQw9OLLxbbP2qynm9wmDqotAWkNxkw1AU+WP5MS26m8Qx+4iySCwyej2W5H8196X5zbKjsNvM0ZlHLT9PoOlZjzFxERUA8b8mAlFt3jDbCzUJe4owwS0vSqg0T3oFhBAQkuyRzeJWIWsO+aIXt7mMzhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741103342; c=relaxed/simple;
	bh=uyHJhziojFGk/tam8soDl9qH4ruNaNMd8RrIguscx8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZTZfONBGuz2hIYztal3RZ1oPxadXg5sqy5NvaJYq5nUa+MlVjR7w9i1FiFZ4EuLv9yHTOo8WG1wHaZaORij9lwtMwWnM+ywW7xiCv7Hn4W0OsiqwNB0/3BD+TSchoBnNT8BpXp1n4icggANclxJNsPTeJJzirf3Pyr0KNyIdLG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X7CuhkuP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741103338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2RHlzy1ROEWhQbxxG4Yv+rRoMty5ce9tc18f8MaHZsU=;
	b=X7CuhkuPbYBTda83fxPRGYXpLuA18mEFewMgmujGYSXITIA0iduxHZcwucFd0ChYVv2SGw
	7QoJa89QhMOoDBsnbr2rTq7uXK0UMM73h9bwDLCSsEPFtL9I1sFkYB+jipljRW6bzvcW1t
	IwmabXd3s2NQlW+so3X5FGcCC9I3S5o=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-dSnJZsPzNOaAeEpmfwhw9A-1; Tue, 04 Mar 2025 10:48:52 -0500
X-MC-Unique: dSnJZsPzNOaAeEpmfwhw9A-1
X-Mimecast-MFC-AGG-ID: dSnJZsPzNOaAeEpmfwhw9A_1741103331
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-390f3652842so2401386f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 07:48:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741103331; x=1741708131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2RHlzy1ROEWhQbxxG4Yv+rRoMty5ce9tc18f8MaHZsU=;
        b=Hl6G4aF2B2+uqlVm2KmvaFEo/9JbqMvIyL5NAFVU04LzKXk5keNTbLPmWcUHG4skyH
         knwbYNMaAbXNdWZ0myQYp5lJ/d6+gAZjqV8KR3dtOgPwcuTbmhvwql01zbhjBkGiQqAL
         bVPiFRI5+QLuff51yMcgFceF4rvxZEFkAx6B+XoZMRbp88NZuCHkBAu69ESVncLld+pN
         ohUmTHP3OQA1VtravR2T+xmII3mCCeaHUhWTTd0IMwNikEVZie7euhczjL4DoKij9k8p
         LEGfSqfl8k8R48m48jhLpgXZCkUnztKA8lOTPgcqGJaOfeA3yzi1bol1khPjryY0E0U9
         DAXw==
X-Gm-Message-State: AOJu0YwoXjAX/cTm5PS7lqw3lRix4nspgIe5ZZnjftUgdGxl+ZsNb5kG
	QWzdVIMUSdBES/ukd2DB+s6LXSX8tmJ8SoJFdeHhM8t05T3pd8vsUuW8RQjQnQsJlyb25dGDdgK
	uDTWi7XxC0Ei2uaUBCwnnNMdL5ITujYZeatJa5b/+rJM3xj7PF1o5pf0d+Scyek4N3DFJChBMCj
	BxKWdfDZX0Oyj0qKN03FPuzBIdyHimtm0cE6ivMPcWLuTS
X-Gm-Gg: ASbGncuAu7zv6voB+sTzOyPiKwdl49u+U60+URqBqGSXQRdd431lDg8OBZzOH6dQTN0
	HuguZnIAnumGw3pUjY1toe8IwntNPydF4BpJzeHIOyJlOCA/mecXSz+yYBPCjw7aUCjvr/Zbpij
	LQSCAV75gynP++//dJIJYJJwl3OPWsfz6Q8ulzJYjVtIxEdN0B5v4DEC/pOf3VC5EGeWGGPeAsf
	AB1WWngvEXYwqMk6cYpn0rTcH8ogYwN9SOyqpXd2ObDP6fZjkVZcpiTBruXPj7qy8JVkdBCELhW
	MuLqXEhVLdkKOPD5f0wRfVA0QXflylB9FCpllVgQOfa1pNQ4pnkvlZB7Xf/KvlRjVFprfLq3JGy
	B
X-Received: by 2002:a5d:5847:0:b0:390:e94c:453e with SMTP id ffacd0b85a97d-390eca070b2mr17839177f8f.39.1741103331137;
        Tue, 04 Mar 2025 07:48:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFS2yQ2nIm92Fqm8oP87QtIsIbeZe5pQ0O0ho/Z0iCYCjljpWAZZP5v8ry/LGiAu8oiIQK1RQ==
X-Received: by 2002:a5d:5847:0:b0:390:e94c:453e with SMTP id ffacd0b85a97d-390eca070b2mr17839137f8f.39.1741103330643;
        Tue, 04 Mar 2025 07:48:50 -0800 (PST)
Received: from localhost (p200300cbc73610009e302a8acd3d419c.dip0.t-ipconnect.de. [2003:cb:c736:1000:9e30:2a8a:cd3d:419c])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-390e485d906sm18206420f8f.90.2025.03.04.07.48.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 07:48:50 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
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
Subject: [PATCH -next v1 1/3] kernel/events/uprobes: pass VMA instead of MM to remove_breakpoint()
Date: Tue,  4 Mar 2025 16:48:44 +0100
Message-ID: <20250304154846.1937958-2-david@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250304154846.1937958-1-david@redhat.com>
References: <20250304154846.1937958-1-david@redhat.com>
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
index 8fc53813779a4..991aacc80d0e0 100644
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


