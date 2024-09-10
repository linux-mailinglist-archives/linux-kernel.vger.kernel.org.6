Return-Path: <linux-kernel+bounces-323999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF35A9746A0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 01:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51C1A1F26C7B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 23:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94BB41BAEEA;
	Tue, 10 Sep 2024 23:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vHt0X+YR"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABF41B5331
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 23:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726011888; cv=none; b=HPdVeNevyx57lUUY3Zz31wdrWhuXF5pvMiFescoHe2oWKO2QJ7qF8GXkF+0JiDOTSnG8/eZUELNGugQ06qIvEx6k2qn38pELJ/Nn5qbAgx3AiiUDtlPmKUhUKGU9Rf0zIWJ9pBaLXZZxOcNanC5KuiMcnXMMx4gtNuv+BKzlOuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726011888; c=relaxed/simple;
	bh=P/1nrx2IuQ6u/tRlLat3CEqnsSzaylehYsr5F1KL3bU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Kqyp+djC9v1CbuJRwZcfrRoqw6ZLNCRRapRgAPtQNGVwIp0yNK5gZd0OxM0dhtaOeVZ1Bbnq4FgT9MgHS8rfKp/SR34ncLJEz/dKGNIgP74p9xYVnl3bHIPjbD8ksxK3/CuxzYGSKWY62DzUHnRuLqchu1C6gfCa0A8Pz8f4nw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vHt0X+YR; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2056364914eso79415555ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 16:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726011886; x=1726616686; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wCQtr3LYUTrh92YO/TM3BLSTa63Bn54Ak3CYVuDQSOE=;
        b=vHt0X+YRa0IQq9jff12LFWszMiRmTu81WRf95qZCHH2FBFUHpH3OwFaOVCXEKoGMwP
         eMxv1VWr2rKqOz+YKdr4jqT0avOy9isYIwsd2fbrWA3CzjCYYV+lmtLuk0PzgdP7akFX
         Ek4uF0STXC/7BaEF3Eq4GGTc26AZMh/U4GRo1UstG0GfjVCfU4CPCBHc7YZe36soVp+b
         oz2MIUONVw3/0DRYNAnue1KkJbWu5PDcD/nS/fZrudA3tdV16DX6TZTd6H0PB8L4VTSU
         RILZ1f89ZweoYEzrmeymJzi9RL07tHEb34uBq5ta9ImJNjo4vul0b2DgzCZ8hXogLLk+
         I+1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726011886; x=1726616686;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wCQtr3LYUTrh92YO/TM3BLSTa63Bn54Ak3CYVuDQSOE=;
        b=GCZEdFI3jPV4HqDIgIom0vPt5CAA4nFqpxhktPM1Kz2ao5abD2q/f8X2LtSfgez7Ui
         sVkH1LVB/XSDKkxRvo9EPrubWHNy2fm0Tb/ElFPTOqk5joEwtb11r9tarapC0CwhtXFf
         +tUSIZIvW0tyOLIzJfF7nHolTGnp+Na5scLDbWJBaN7O5bws54t1Bxs90HRpYDSBczgB
         bc1931D7HV4GmzcWLMhlRAMLP1QrtouL8VM/iwjaMG8Sl5XcGWSIxOelrCjhRLuzBici
         LBFFkFC5pujrGCZaCeVx9kR+C0YvV87Z/1EwaSjbfnxal52AT9lKx3dCda6x1AmlTCMF
         o+dg==
X-Forwarded-Encrypted: i=1; AJvYcCXi6x3l+hULpGsHrtKdRpSlff0Zqk4g8vZt7A0AwgCnWbbc1+AxPH3/kw+yl1xWoZlhZLphnFI9BKrDjIE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg8O4aBOpf7XCsUO+lYkF9CK8QyQtLg+cNJMTgcPjUfNMiyehh
	eNMlwEoc+UtW23UYBVIYAskpLIECQBR0UECkb+ZHBVX4TTtvfQOufzmT52ySs/GsOOjy64EaQX+
	eSXbb0A9JLpix4R9In4m3DA==
X-Google-Smtp-Source: AGHT+IH5Nj5kPHNo6rBfhQxFH2WNjr8MfjXL+h+toY4sJe8PVOOMsYFK1lr+WyYqGBk0WvcoCe7tmQGhI2Eo6rySgw==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a17:902:b686:b0:205:5db4:44b8 with
 SMTP id d9443c01a7336-2074c63a9cemr948735ad.5.1726011886284; Tue, 10 Sep 2024
 16:44:46 -0700 (PDT)
Date: Tue, 10 Sep 2024 23:43:39 +0000
In-Reply-To: <cover.1726009989.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1726009989.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Message-ID: <9f287e19cb80258b406800c8758fc58eff449d56.1726009989.git.ackerleytng@google.com>
Subject: [RFC PATCH 08/39] mm: truncate: Expose preparation steps for truncate_inode_pages_final
From: Ackerley Tng <ackerleytng@google.com>
To: tabba@google.com, quic_eberman@quicinc.com, roypat@amazon.co.uk, 
	jgg@nvidia.com, peterx@redhat.com, david@redhat.com, rientjes@google.com, 
	fvdl@google.com, jthoughton@google.com, seanjc@google.com, 
	pbonzini@redhat.com, zhiquan1.li@intel.com, fan.du@intel.com, 
	jun.miao@intel.com, isaku.yamahata@intel.com, muchun.song@linux.dev, 
	mike.kravetz@oracle.com
Cc: erdemaktas@google.com, vannapurve@google.com, ackerleytng@google.com, 
	qperret@google.com, jhubbard@nvidia.com, willy@infradead.org, 
	shuah@kernel.org, brauner@kernel.org, bfoster@redhat.com, 
	kent.overstreet@linux.dev, pvorel@suse.cz, rppt@kernel.org, 
	richard.weiyang@gmail.com, anup@brainfault.org, haibo1.xu@intel.com, 
	ajones@ventanamicro.com, vkuznets@redhat.com, maciej.wieczor-retman@intel.com, 
	pgonda@google.com, oliver.upton@linux.dev, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-fsdevel@kvack.org
Content-Type: text/plain; charset="UTF-8"

This will allow preparation steps to be shared

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 include/linux/mm.h |  1 +
 mm/truncate.c      | 26 ++++++++++++++++----------
 2 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index c4b238a20b76..ffb4788295b4 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3442,6 +3442,7 @@ extern unsigned long vm_unmapped_area(struct vm_unmapped_area_info *info);
 extern void truncate_inode_pages(struct address_space *, loff_t);
 extern void truncate_inode_pages_range(struct address_space *,
 				       loff_t lstart, loff_t lend);
+extern void truncate_inode_pages_final_prepare(struct address_space *);
 extern void truncate_inode_pages_final(struct address_space *);
 
 /* generic vm_area_ops exported for stackable file systems */
diff --git a/mm/truncate.c b/mm/truncate.c
index 4d61fbdd4b2f..28cca86424f8 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -424,16 +424,7 @@ void truncate_inode_pages(struct address_space *mapping, loff_t lstart)
 }
 EXPORT_SYMBOL(truncate_inode_pages);
 
-/**
- * truncate_inode_pages_final - truncate *all* pages before inode dies
- * @mapping: mapping to truncate
- *
- * Called under (and serialized by) inode->i_rwsem.
- *
- * Filesystems have to use this in the .evict_inode path to inform the
- * VM that this is the final truncate and the inode is going away.
- */
-void truncate_inode_pages_final(struct address_space *mapping)
+void truncate_inode_pages_final_prepare(struct address_space *mapping)
 {
 	/*
 	 * Page reclaim can not participate in regular inode lifetime
@@ -454,6 +445,21 @@ void truncate_inode_pages_final(struct address_space *mapping)
 		xa_lock_irq(&mapping->i_pages);
 		xa_unlock_irq(&mapping->i_pages);
 	}
+}
+EXPORT_SYMBOL(truncate_inode_pages_final_prepare);
+
+/**
+ * truncate_inode_pages_final - truncate *all* pages before inode dies
+ * @mapping: mapping to truncate
+ *
+ * Called under (and serialized by) inode->i_rwsem.
+ *
+ * Filesystems have to use this in the .evict_inode path to inform the
+ * VM that this is the final truncate and the inode is going away.
+ */
+void truncate_inode_pages_final(struct address_space *mapping)
+{
+	truncate_inode_pages_final_prepare(mapping);
 
 	truncate_inode_pages(mapping, 0);
 }
-- 
2.46.0.598.g6f2099f65c-goog


