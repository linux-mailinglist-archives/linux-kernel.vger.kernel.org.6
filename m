Return-Path: <linux-kernel+bounces-571170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E14A6B9F8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 12:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63ED67A9F08
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 11:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75CEA225402;
	Fri, 21 Mar 2025 11:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZNiyceq6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53112224895
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 11:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742557042; cv=none; b=tI5l9KGSfJkKVE7fF5dXStA0PGFI525p+tE8AOG+I2+4vZlVBUXDXd6PpxyjAZjuXR+HMWprFTwBrLftGlcTExQu4Dh1LdvBalxdtNe2X2BmdqAa7PFFz+MZDIdzy+eHJv4DIef8TUEG6O2LwsSu0/CvPEJBpawQPly3FpN+4Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742557042; c=relaxed/simple;
	bh=XqLEM356KJ4Nr3KBH7m+aoqP3r0tyveu5sLdaxismyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mZO3u5b9sDbywBF4xGGLMrkWrZ19vTl7r43iq1+714D7TtWV85sSVK5EFGaUiwMI9tov1RHCz7drUrY9fiN5Gu9WuX3B28BqWwOLcGTs9DsHnc0ccMsMbekdSL+Pzm7OZszqQVf7VqYv5JvTDoLHbV9Z67r61y2PlFB/niRVBtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZNiyceq6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742557040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/AdkIGrCnMsc+er9X66uqVETmxKiULUWSewMsh5Pldk=;
	b=ZNiyceq6mVerUlngThger5Bp4PHwJ8/EXAlLpA980qEtSfJ3ikz72XFYvnMu6uaaaG3LM9
	oM9Kegy9PlqCeB4jAh9z8qapARf9xJ4vVR1uRmOt4OVD9rnFzUVyFsDVow3CIHaP/3FJzx
	/HrONctspIWKVRrCnz1JzyJrPDuBrsI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-VH39COGfPamkZ6mA_SxkYg-1; Fri, 21 Mar 2025 07:37:19 -0400
X-MC-Unique: VH39COGfPamkZ6mA_SxkYg-1
X-Mimecast-MFC-AGG-ID: VH39COGfPamkZ6mA_SxkYg_1742557038
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-39143311936so882685f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 04:37:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742557038; x=1743161838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/AdkIGrCnMsc+er9X66uqVETmxKiULUWSewMsh5Pldk=;
        b=Bd9cwL+mJKkkQubPKzhb2wYpcp5QmZPuD5qQwPAj6fuvk2xQ0V0wLaEIIURicOX8I0
         M63GqHx+yYCIshRn/psqYrnK/CoH577JDcUgTe5Ui8YY6e+wggNDXUW6j+NpdNpXYQtr
         +pXl4Gt+1Am9ujNDIE3VENB6LDizbwkDG7Ob9lzKmZ/yJMZk1TUpyThBNEoznW/QIDIo
         wd2kUMuiRErXBle07QVeC3ro6MtgLs4L+2DiYa/sL4y6VzUlaqA7Adqom9qapMKsXYBC
         4LSRcAvo/otx6Ha9if3S9gKxhVuHYWJ7XKATfplzWLm2MNXf1WospLSGv2xC63anhOZT
         CNMw==
X-Gm-Message-State: AOJu0YzTefDvcDUWyOyyLF+s3QCn2SYck1EDOt5FBjgPaBfUJjOv3JuE
	Zcwf0zLttqAvzDVzTFnoDG6cFXmZXBhUUt9t0Y8y6a0knQhejyWaqii2RPXhJ/IZcSldLIr4yPj
	wwLF+Ol7o7O40VBnaNpmHyPkNmLklimVbzDIPzHaDft+yiWcwaYdY9UCU2VFwA/8mpIUmV5OmKB
	Wr1eBGE69zA55jCHlHh4pOVxfSyYpAdFfnlFIn8pFUoL6I
X-Gm-Gg: ASbGncuHCRvXrqb5rv0oWQL37D0mNksIh8PCwC+FKtIX+gM7JtseL4KSNhTKdIruAWM
	LhBKfpRgugxXzA8p1h2GU+Ep4fqu8znST8Z0fhPiPtRFuvdqkk2u2rAsts/Z5mK6aVf+KE8mi0W
	BP3P8hHplYgJBZTBOQw3TIJeOK25PJdEjhrUPww0MPKGHA5oSnRlu3Rev9OGP6bMQjlta2UB72J
	WuOGopY1pl6ghNtl35c4qnrU7MF6tvC1SrAPAudhJwof6itVDGhI9pgJiwLTWOC9QZB7597f7SF
	0F6idJBImrnUOLm0RaAzWVrq/f0bLo3GO8YIaOGaoGu9IoTVRZX0wwzI+pA0VnuC+33Hp9f0tht
	u
X-Received: by 2002:a05:6000:144c:b0:390:ea34:7d83 with SMTP id ffacd0b85a97d-3997f90e7c2mr2841371f8f.31.1742557037765;
        Fri, 21 Mar 2025 04:37:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG49ODTrypvf9tYQ5TgQ34vttK3IHB4Rj01M+eydlpDxfAmjxfWJ7Zgo7XydYKuCca6cGe7VQ==
X-Received: by 2002:a05:6000:144c:b0:390:ea34:7d83 with SMTP id ffacd0b85a97d-3997f90e7c2mr2841314f8f.31.1742557037213;
        Fri, 21 Mar 2025 04:37:17 -0700 (PDT)
Received: from localhost (p200300cbc72a910023d23800cdcc90f0.dip0.t-ipconnect.de. [2003:cb:c72a:9100:23d2:3800:cdcc:90f0])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3997f9a3f36sm2189825f8f.32.2025.03.21.04.37.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Mar 2025 04:37:16 -0700 (PDT)
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
Subject: [PATCH v3 1/3] kernel/events/uprobes: pass VMA instead of MM to remove_breakpoint()
Date: Fri, 21 Mar 2025 12:37:11 +0100
Message-ID: <20250321113713.204682-2-david@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250321113713.204682-1-david@redhat.com>
References: <20250321113713.204682-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

... and remove the "MM" argument from install_breakpoint(), because it
can easily be derived from the VMA.

Acked-by: Oleg Nesterov <oleg@redhat.com>
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


