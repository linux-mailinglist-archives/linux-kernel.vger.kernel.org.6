Return-Path: <linux-kernel+bounces-427249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 200669DFE96
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 11:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D91B9280217
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 10:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA231FBC9B;
	Mon,  2 Dec 2024 10:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="dpBtCa7R"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981A71D8E10
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 10:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733134573; cv=none; b=KTdOQobaCl0rC1Cg5EdUukDXV19mJFs6gPBAF9AG6Ac18+dC7aDFllWRz/dPq+6VKSClVdESyhvGsEByIZO7UwbXHbdEJgMcuwsPAE1HizgpPuYFR3SD3XTK+sqHW6JuJPLe9WPCO5G3oW7mlroEeoPLI9aUWdSGuy8SbG+DCfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733134573; c=relaxed/simple;
	bh=ReKNMlKfQn7XczdH7JHukU55OclGvk3mfG9gIQ8CmCk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YVaNa4yPJc0dqTzXw4q69ldldE6+h/vYFocm24zVVfPvTq4xW2/MtYkGLCdmiW1wJ4rDDQ+MOeVJ1XoaMoTTvxPI9RjSH7T27nzV0J8atoYoADpsGJ0mIvTSVV94pUhlrZK6gkjA014Dnaipz7aKBkCE+yWWVUr1Sc1TwsBmuxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=dpBtCa7R; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21288402a26so28976095ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 02:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1733134570; x=1733739370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AqdyYnh7L9JzbifPNftANkk0KPlnXsX4tMHkyCxaZPo=;
        b=dpBtCa7RSdYiQk3oVMT5EaUOqWVV+igXZuiB+sKYOriwGSrH5LKJ9rMkViXaumNOwW
         7IssmAwtOh2ZmULh3larjhqjwIdjNfYgNp10/gbv+VTKCDy0gqj93z0Flv8XEgesqP2M
         c3AuJrEzGqJzhqoN4z34HjVpFjlxtI3CS6D5kTfJxB+EEw6rwm3j0X0u4ZisDT8kVbJY
         YSKICkLdaCjbIVgDD7baUEuZa5UA8MhK7TYYHce91UEruKvCwZfHrf8cJxrUwwsabgSR
         5oqQ6rI4Rb+a1QTOwoe7nVJn+eQazY44nTdSavbmHIXfBqfP+W/x2mhdhVkGH0kw6kzE
         x+tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733134570; x=1733739370;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AqdyYnh7L9JzbifPNftANkk0KPlnXsX4tMHkyCxaZPo=;
        b=kbjUcQzXT/ouXfF/pykBEDHvH3x718re9L6U17Rvv70fyla7yE9tSDRmqBq37cg0FD
         IGPlpkfeOVgkrLBl8+OTLYekteN5fhvNdLDd3mfOYOKLy6piKt8+jursTX+dTy0SB31u
         hWUS+JEUP7C41BUpU7sb17rkvKiJ8gvL15axcFWA+28DtApHSrBG7QdNCCtK5u8SnQMM
         1fU/N1KrXMxfh9CZFxn2AttY0e7cZNWqJPKAhJrYxc0u+pWLqist32CnPyXXKF5ko7pE
         p/iqtyaKnkRWP3IF9MEeVDwupRb/gJ50aibsAicwZOQYUUrqePDtrOI4mK+SIQ7rgfrh
         w9Jg==
X-Forwarded-Encrypted: i=1; AJvYcCXbRw6R2wBjkqf92V78Xshy+DkmmTbXYzq/v41gGngQJAJcAT+3f69JZlo3pEEAQbwa913Zl3Wyd+YqCCI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwiJtVgnR0r9QyRfdJmTopiDQtpVYASXDkUqf3zYNkBYYwQ8gd
	ErM6cJyH4t9JKFSHYhO5okKAEQYKNXD/s/coQMT2vRNg1FMDaNr4jegVSvZIMfYPySb54hjJLU/
	i
X-Gm-Gg: ASbGncsJVKpfhGQ070rEHyZuZ4WE98HeUOawJFVyLsx5oIlhe5DMUeL18/uFIUcnjV1
	lUcZc+aUJz1yD3DEVvnnzI0LzQenihMU42e8bj+YW5mrKmghgo+uIifCb4Lkt1Z4xX3gTkVzpoq
	A2OTmiFO4XDbYVWYg7219kHOTiwXoZVaeWSzUyRZWYJl2cRRSysX7MLBRliQxm3dxsDVlzbJfq2
	43ldp/beuFiL20jYdX+5JP9vMuyUe5atMgqvTdfROhZYOf0aa47DqQqtE78cc52+wSZuTS1Z94K
	xWQMv3mgdTg45Jjeb5zoyFS//z4rxxDx
X-Google-Smtp-Source: AGHT+IH1+6Y2xOPT53z5KOINjW/eib1XXOUom5+MdqN7SgnYZHlbvRTsSjFLdTYt0jzINpPmKZcGeA==
X-Received: by 2002:a17:902:e541:b0:215:58f0:2606 with SMTP id d9443c01a7336-21558f02c9emr128817145ad.2.1733134569664;
        Mon, 02 Dec 2024 02:16:09 -0800 (PST)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.55])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21521969e59sm73097425ad.146.2024.12.02.02.16.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 02 Dec 2024 02:16:09 -0800 (PST)
From: Xu Lu <luxu.kernel@bytedance.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Cc: lihangjing@bytedance.com,
	xieyongji@bytedance.com,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Xu Lu <luxu.kernel@bytedance.com>
Subject: [PATCH] riscv: mm: Fix alignment of phys_ram_base
Date: Mon,  2 Dec 2024 18:16:01 +0800
Message-Id: <20241202101601.48284-1-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit fixes the alignment of phys_ram_base in RISC-V.

In sparse vmemmap model, the virtual address of vmemmap is calculated as:
'(struct page *)VMEMMAP_START - (phys_ram_base >> PAGE_SHIFT)'.
And the struct page's va can be calculated with an offset:
'vmemmap + (pfn)'.

However, when initializing struct pages, kernel actually starts from the
first page from the same section that phys_ram_base belongs to. If the
first page's physical address is not 'phys_ram_base >> PAGE_SHIFT', then
we get an va below VMEMMAP_START when calculating va for it's struct page.

For example, if phys_ram_base starts from 0x82000000 with pfn 0x82000, the
first page in the same section is actually pfn 0x80000. During
init_unavailage_range, we will initialize struct page for pfn 0x80000
with virtual address '(struct page *)VMEMMAP_START - 0x2000', which is
below VMEMMAP_START as well as PCI_IO_END.

This commit fixes this bug by aligning phys_ram_base with SECTION_SIZE.

Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
---
 arch/riscv/mm/init.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 0e8c20adcd98..9866de267b74 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -59,6 +59,8 @@ EXPORT_SYMBOL(pgtable_l4_enabled);
 EXPORT_SYMBOL(pgtable_l5_enabled);
 #endif
 
+#define RISCV_MEMSTART_ALIGN	(1UL << SECTION_SIZE_BITS)
+
 phys_addr_t phys_ram_base __ro_after_init;
 EXPORT_SYMBOL(phys_ram_base);
 
@@ -241,7 +243,8 @@ static void __init setup_bootmem(void)
 	 * at worst, we map the linear mapping with PMD mappings.
 	 */
 	if (!IS_ENABLED(CONFIG_XIP_KERNEL))
-		phys_ram_base = memblock_start_of_DRAM() & PMD_MASK;
+		phys_ram_base = round_down(memblock_start_of_DRAM(),
+					   RISCV_MEMSTART_ALIGN);
 
 	/*
 	 * In 64-bit, any use of __va/__pa before this point is wrong as we
-- 
2.20.1


