Return-Path: <linux-kernel+bounces-420799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC319D831C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 11:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00750163490
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 10:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1124B1AB531;
	Mon, 25 Nov 2024 10:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ICDk4L38"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8961922FC
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 10:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732529318; cv=none; b=W85IGD4ytClO/jymWuTneLX3gD6lp3g2yXCSDSvxNTSVyuhIXkrSEfEGf5JTJiRFqUXBSrzQ0zGNrzbyWLtykve9z4N+IsiE46PZ84tmiIQPlzj5OED5CnxFTJpKhDKYy0HuAXc4wL1sd9aK4D+2rqlXjyaIDAPzhvkFyKvDKKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732529318; c=relaxed/simple;
	bh=SG6BX6awQ7YAlg2FIVDK2+i/V4v4uTcOtNwlOzzD8jQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TBgQR+Sp0DEV/OgXxhp7ASbo6mNJGfUQaZoQYRN2KEPmfkmJwmxkfR+uCRmXreo5UqMi0B9PbltDNtDswgiA8zfa446yNerzYmwzWi/LMJjjfMJZUEvC5XntP/9ynPauHXTDT/Ot2d4RG4IZRnjcFg0yvbHgvZuQLE084txOjcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ICDk4L38; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Pqj93PX/ZBuMOhI7NqCP1vk+Pb2kRy0sc3yFUrpDIgk=; b=ICDk4L38lWqmR/R/Z8bEV2tqr6
	Wvu6keg0Pn81VmNwEu8AxgJLe5WPOHY+QPrsHm+1xtnwoBawoU+nwWy2XWaumJqtWHG4RnfH0rgZI
	nmDExwGfDcMF+YVjxutB+ZTwksZ2ozp64LQGXNgm8TBN2ZDbm/6cO93t1aM9ICX932W07LGSSl9bN
	LvPlV4XzPrZGu66EofuWwKq4lbJoNUJmarn8SAjNpYIuxiOUMdZBkknu/Zgke5rof+WKCyPnPlDi6
	nG0R8SFJkuxFZFf2h1zAeV4vwHNZO+bG/vc10BvkrrkEB1eG2ZY0bwlS0ziZbeldi90fZRjUj1sf1
	m4Mz9xmg==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tFW12-000000014f8-16EL;
	Mon, 25 Nov 2024 10:08:24 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tFW0z-000000000lX-3TXK;
	Mon, 25 Nov 2024 10:08:21 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: kexec@lists.infradead.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Dave Young <dyoung@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	jpoimboe@kernel.org,
	bsz@amazon.de
Subject: [RFC PATCH v3 14/20] x86/kexec: Mark relocate_kernel page as ROX instead of RWX
Date: Mon, 25 Nov 2024 09:54:44 +0000
Message-ID: <20241125100815.2512-15-dwmw2@infradead.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241125100815.2512-1-dwmw2@infradead.org>
References: <20241125100815.2512-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

All writes to the page now happen before it gets marked as executable
(or after it's already switched to the identmap page tables where it's
OK to be RWX).

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kernel/machine_kexec_64.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 43db1739fd7a..c51e688c1f91 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -329,7 +329,7 @@ int machine_kexec_prepare(struct kimage *image)
 
 	__memcpy(control_page, __relocate_kernel_start, reloc_end - reloc_start);
 
-	set_memory_x((unsigned long)control_page, 1);
+	set_memory_rox((unsigned long)control_page, 1);
 
 	return 0;
 }
@@ -339,6 +339,7 @@ void machine_kexec_cleanup(struct kimage *image)
 	void *control_page = page_address(image->control_code_page);
 
 	set_memory_nx((unsigned long)control_page, 1);
+	set_memory_rw((unsigned long)control_page, 1);
 
 	free_transition_pgtable(image);
 }
-- 
2.47.0


