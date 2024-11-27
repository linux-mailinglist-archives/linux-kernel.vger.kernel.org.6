Return-Path: <linux-kernel+bounces-423317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F283E9DA5C1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 11:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27A7BB22630
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 10:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD4F19413B;
	Wed, 27 Nov 2024 10:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Ll/hxxKB"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D747118E0E
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 10:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732703427; cv=none; b=jLWz+pvFCXolWOJrfS+qLkh/pG7ItQMxo1mLuqocT3mJN0zAKbx8OADLJFhEzVxybhXvXq8m0Fa/ds4REMIi9n4dq5NV8RIPLIyxzVb02NDaqbFOHa2FPDz/daNdKw6AZYz6H0M0j5A5gMhg/13cxkJBsLfg6kH0b4haGIw6A0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732703427; c=relaxed/simple;
	bh=Ds7C5pb194YFdxwzXToNBRyWu8AEFEM9Ll5NtubIdb0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UTFrQtGYsKfznK2yA3ZWLyQOiKgkHxmuL4ejFEyC1uPsS8lsWbOns0dwNR6vGxd4ZcIXv84QMzYpfyS/sK9QKqu5tQ59REtzQ5LbSGVpjuu7lwT/XuM6Ze0FSHsqIJEemMxivuUHB5UXNFz5CCw6CqMA57ZA/xBJn3R2UsLg/C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Ll/hxxKB; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-434a1fe2b43so22691705e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 02:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1732703423; x=1733308223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mdmWojUkhwpwXLovz/kimDZeMrYf2eBrW2EF70Dlfbc=;
        b=Ll/hxxKBnVb7wV0bK4sye/7/cuCMrV2+NvJfp/JaKqZV+6pWyDlNvW7HVlwsFRv+l7
         yY5nH8hvE4zpMolM1N/B7h+aJ2kRBEnNyebFdAleBXm5w3AlQW0YyDRhFSuiIoQsqlv3
         QKZCyG8i82RNzL6oZpxDnCNwFobwIXt+BDeTD1wwWKydZXuEGnVqa8OJ6f0Gm6hc9LYB
         wUxGR5EEpl27cyiaXUhW74mKzqXXHnW3s/zEyUxX+ekGut8zOgCRu6WEzgSnVMsfTxpu
         HXS1yb8R2vEOmXGuqeAoQTWri4PS9Ndg7D2UaTfKUeTMLc6OWpUdpIPSSNh5XbzuM4an
         u7NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732703423; x=1733308223;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mdmWojUkhwpwXLovz/kimDZeMrYf2eBrW2EF70Dlfbc=;
        b=jU69Hg7X6O6YzzZBSppPDOt9uP6KT6hj2dpTrdGMycOWklJZdhLKfRGyE0ZNwhiTyT
         0CxY0KLBvSNubTyHpqeFuwFL4KzEjlIT7BmeBOP2b0Lo1ueRveClnIQdrewNl547viGL
         6W44UjZdrzOK90yme1pmodOjQVrNeTH9UTcuAQ0qmGUz7dOx3lfj5Q+2AqE96IiWV/lD
         LeHJaZ4kYQRXcqeB3IaVtCKfd8NxOal3QPUrd8vnIl72Kyt8+mE+9dODiWCv2eO6bCHV
         T77H4s1WFcYBs2z5eg8y8p+TiSys3pfRIMN52B/6zhNW4f0RspYtwkGSbA1RUSleTvLz
         hmyA==
X-Forwarded-Encrypted: i=1; AJvYcCXyQoVLp5ELsOEgdwT50FXplgm683pUYh7CkI7qAzjNqDksrO/DIqu1lF6Ou1RFN/lcZ3SQHGWrIZFY6Bs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNj/Nl7xP3qFVu6V4mxS6hp9g9u74LVwQt8tad+B8myO8V/qB7
	WWmVn/VO4dcNPya1SR3e+VUdz+Cuph/NviJhHJOBWzBCWJPD695W5Yp+1MqRNW8=
X-Gm-Gg: ASbGncv/xa9bHawN4c/Fm8QkjVcJeEXgWXZfbG4wmFhLU+dl8xdGa2U3L7qDU44XRL+
	Wv8XOW+2fww6LtMbHWWBj5dCebjKEJstMoiSkicI6u7GituUUfoPTmj7A28SNrLjY36R+S3/DY8
	h1RcLyxp04RWMvsao22jEEc5sb7L599qGQAyIhWiufKKp0qlAgvTMFYbUSTM7yxuf7RbBIt2lUC
	sO4+PBHg5h6FPGcqtjyajyU4UoiaHHM+7dOx29qkLnLSZsbWBk=
X-Google-Smtp-Source: AGHT+IF5IkFBTeO7XGVr/CEmevonfUf2d58+nLijve3eXN4jnhveTHhqS1Pg0SJtzoux/aBfgEgZRw==
X-Received: by 2002:a05:600c:3546:b0:431:4e82:ffa6 with SMTP id 5b1f17b1804b1-434a9de54b7mr20134735e9.24.1732703423049;
        Wed, 27 Nov 2024 02:30:23 -0800 (PST)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fafeceesm15947776f8f.37.2024.11.27.02.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 02:30:22 -0800 (PST)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	zhangkai@iscas.ac.cn
Subject: [PATCH] riscv: module: use a plain variable for list_head instead of a pointer
Date: Wed, 27 Nov 2024 11:30:14 +0100
Message-ID: <20241127103016.2699179-1-cleger@rivosinc.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

list_head does not need to be allocated, it can be a plain variable.
Remove the pointer which allows to get rid of the allocation as well as
an existing memory leak.

Signed-off-by: Clément Léger <cleger@rivosinc.com>

---
 arch/riscv/kernel/module.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/arch/riscv/kernel/module.c b/arch/riscv/kernel/module.c
index 1cd461f3d872..47d0ebeec93c 100644
--- a/arch/riscv/kernel/module.c
+++ b/arch/riscv/kernel/module.c
@@ -23,7 +23,7 @@ struct used_bucket {
 
 struct relocation_head {
 	struct hlist_node node;
-	struct list_head *rel_entry;
+	struct list_head rel_entry;
 	void *location;
 };
 
@@ -634,7 +634,7 @@ process_accumulated_relocations(struct module *me,
 			location = rel_head_iter->location;
 			list_for_each_entry_safe(rel_entry_iter,
 						 rel_entry_iter_tmp,
-						 rel_head_iter->rel_entry,
+						 &rel_head_iter->rel_entry,
 						 head) {
 				curr_type = rel_entry_iter->type;
 				reloc_handlers[curr_type].reloc_handler(
@@ -704,16 +704,7 @@ static int add_relocation_to_accumulate(struct module *me, int type,
 			return -ENOMEM;
 		}
 
-		rel_head->rel_entry =
-			kmalloc(sizeof(struct list_head), GFP_KERNEL);
-
-		if (!rel_head->rel_entry) {
-			kfree(entry);
-			kfree(rel_head);
-			return -ENOMEM;
-		}
-
-		INIT_LIST_HEAD(rel_head->rel_entry);
+		INIT_LIST_HEAD(&rel_head->rel_entry);
 		rel_head->location = location;
 		INIT_HLIST_NODE(&rel_head->node);
 		if (!current_head->first) {
@@ -722,7 +713,6 @@ static int add_relocation_to_accumulate(struct module *me, int type,
 
 			if (!bucket) {
 				kfree(entry);
-				kfree(rel_head->rel_entry);
 				kfree(rel_head);
 				return -ENOMEM;
 			}
@@ -735,7 +725,7 @@ static int add_relocation_to_accumulate(struct module *me, int type,
 	}
 
 	/* Add relocation to head of discovered rel_head */
-	list_add_tail(&entry->head, rel_head->rel_entry);
+	list_add_tail(&entry->head, &rel_head->rel_entry);
 
 	return 0;
 }
-- 
2.45.2


