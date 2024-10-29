Return-Path: <linux-kernel+bounces-386328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5A99B41F9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 06:54:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF5782834BA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 05:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53BB520124C;
	Tue, 29 Oct 2024 05:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P717lp3h"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE2B2010E8
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 05:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730181196; cv=none; b=ZFVLitEdPc+/ajqxVJA3wvAA4BSPDHWEx1iuUy20QolWjjhjLGh3dfn8NfSEnb6cVz/CmWy0QE0alPzjCOYO7Me6EG6wVhL1HTqi3fSBqFTKpGrTViTNDc/HlKCuk7U0G3/btDsrhldtIMTncYJrbi3a1TjQEi6pEm7MIgSDgkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730181196; c=relaxed/simple;
	bh=d8Bt5adGDGwo3V2Z0dttiq7ezDVmTkWZxy3JE0RUu/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iV7GQh2Mcpewp0QjA3cecNkzJljtldZcRGVgidOFD6KSil/jpFyqLTVzHsAx83GHPz3jFEBTLsH7J4473i8cQFF2qWJD+3wYkEE9vpBykN71B0JCuO6uixXtrYbleucahe8yQbiBsZ/S25f2f4sT/eB5Z5Yb/lmDn5yHkJyr7rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P717lp3h; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730181193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uo5L+VgmTjh6XwtSjWx3uno6HruWIf6FNemxob1bKlI=;
	b=P717lp3hPpLPnMGmKCre0jJ3KDpEQbVZR8jOvPRe68AehJ+m/WHzz6uk+XtUjhf6WgSixR
	grV5ySJAlVqGKhfKIUOgt0wptqbRorCnL/jwbk/bsXrBcx/yS9q13iESG7uO7veN9O6+xD
	nEeeb7Ojnz6q+VPvbBT5xx+BbJA/zyE=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-1xpZ7wO_OYOkpv1VrdTHAQ-1; Tue, 29 Oct 2024 01:53:11 -0400
X-MC-Unique: 1xpZ7wO_OYOkpv1VrdTHAQ-1
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-71806ab1a97so4885022a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 22:53:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730181191; x=1730785991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uo5L+VgmTjh6XwtSjWx3uno6HruWIf6FNemxob1bKlI=;
        b=GjVNsGGLZq8pEbaWkpwBKUcgF8XcxJcpysD7rEHXBJ4dabCzQdvorKKjsgTKweMSnn
         pBfHOKoVmu5tl+iL0e2DfoHzP2BrQAGAtYIvHBHWLLfOyppNxolrwFP3x84dODJaNaPz
         TeB43JVDJXuaRaiKZhEH9/o4TdNoWlgtfR2uijPdwXGFeoc58Kb1zNjaXM9g2uAXNFeB
         clCDyy792rP4dkBxmUakeaMpKeGCrFV/PV7xi4zuBgixLUMdWyvC7RXndAU8/i4auf9s
         hmvPyUZFEZHIk23q2GjoBLQeQkngoxyGZ7pUgVfss9L9FR1Y8KAVFvHo/kueZ+WE+ctz
         TRvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiqIaGgZt17xRYONjQk+QXjMbF85jk/mNWl+uMq9wkwpzKVpxn3T7beb1uFKOAwOSSlPr0rw/AHcNC0Sc=@vger.kernel.org
X-Gm-Message-State: AOJu0YybWAiHwjo4Z73A+nzAfpGx4uEpsdnsD7OiKQBFEGbcodGaxBBg
	OtVZ4NrWqgGhgUc4n9Uu+27rKRspzwQuZYIkQ/54wD+1OgiS4O7XBCRg+bueV7rnlWKNvAr/CwV
	JuSz34vUvEz4yATb3knHTGKYX9zXS1m5zDh7OE+Fe1l5aW14tSsZ9NOCR/eKwsg==
X-Received: by 2002:a05:6870:6590:b0:278:1863:f4b6 with SMTP id 586e51a60fabf-29051b5edb6mr9553423fac.15.1730181190830;
        Mon, 28 Oct 2024 22:53:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOrme0N7lDABZ6zeXKC9s2HBoZLQciyQpqHGHhIZzIWySUR20Lx1U8S8dKA1C/4iFsv3PKjQ==
X-Received: by 2002:a05:6870:6590:b0:278:1863:f4b6 with SMTP id 586e51a60fabf-29051b5edb6mr9553412fac.15.1730181190562;
        Mon, 28 Oct 2024 22:53:10 -0700 (PDT)
Received: from localhost ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057921863sm6757783b3a.33.2024.10.28.22.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 22:53:09 -0700 (PDT)
From: Coiby Xu <coxu@redhat.com>
To: kexec@lists.infradead.org
Cc: Ondrej Kozina <okozina@redhat.com>,
	Milan Broz <gmazyland@gmail.com>,
	Thomas Staudt <tstaudt@de.ibm.com>,
	=?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	Kairui Song <ryncsn@gmail.com>,
	Jan Pazdziora <jpazdziora@redhat.com>,
	Pingfan Liu <kernelfans@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	Dave Hansen <dave.hansen@intel.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v6 7/7] x86/crash: make the page that stores the dm crypt keys inaccessible
Date: Tue, 29 Oct 2024 13:52:20 +0800
Message-ID: <20241029055223.210039-8-coxu@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241029055223.210039-1-coxu@redhat.com>
References: <20241029055223.210039-1-coxu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds an addition layer of protection for the saved copy of dm
crypt key. Trying to access the saved copy will cause page fault.

Suggested-by: Pingfan Liu <kernelfans@gmail.com>
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 arch/x86/kernel/machine_kexec_64.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 9c9ac606893e..7389b912ba43 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -579,13 +579,35 @@ static void kexec_mark_crashkres(bool protect)
 	kexec_mark_range(control, crashk_res.end, protect);
 }
 
+/* make the memory storing dm crypt keys in/accessible */
+static void kexec_mark_dm_crypt_keys(bool protect)
+{
+	unsigned long start_paddr, end_paddr;
+	unsigned int nr_pages;
+
+	if (kexec_crash_image->dm_crypt_keys_addr) {
+		start_paddr = kexec_crash_image->dm_crypt_keys_addr;
+		end_paddr = start_paddr + kexec_crash_image->dm_crypt_keys_sz - 1;
+		nr_pages = (PAGE_ALIGN(end_paddr) - PAGE_ALIGN_DOWN(start_paddr))/PAGE_SIZE;
+		if (protect)
+			set_memory_np((unsigned long)phys_to_virt(start_paddr), nr_pages);
+		else
+			__set_memory_prot(
+				(unsigned long)phys_to_virt(start_paddr),
+				nr_pages,
+				__pgprot(_PAGE_PRESENT | _PAGE_NX | _PAGE_RW));
+	}
+}
+
 void arch_kexec_protect_crashkres(void)
 {
 	kexec_mark_crashkres(true);
+	kexec_mark_dm_crypt_keys(true);
 }
 
 void arch_kexec_unprotect_crashkres(void)
 {
+	kexec_mark_dm_crypt_keys(false);
 	kexec_mark_crashkres(false);
 }
 #endif
-- 
2.47.0


