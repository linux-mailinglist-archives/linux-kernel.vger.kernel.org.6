Return-Path: <linux-kernel+bounces-423573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADE29DA9D6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 15:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19C67165B0F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 14:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC6C1FF60A;
	Wed, 27 Nov 2024 14:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="W4yP5bUc"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29291FCF63
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 14:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732717535; cv=none; b=Y74lzt4s69Ly2Z9D/kQaYxI4qkhW9UqYGwTr8NltBHUK6uwHUMjYoGeYyU4kKDonuwT3C1xt0NrZ7UVmaXVx0ZLTs3Gox9jFt2Gvi1xkt3c0k5IyxW4aMyYf93kCBp6DeMwjlZUPsEmGnuNsoxy5uDkzlXDNlBY3QQzFk9vAYFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732717535; c=relaxed/simple;
	bh=ehFyraypcr18yFYe5GaihWzp05ckn9/riEWHKnW47gs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gaJH9BB7U36bYqJO6/xvbCHgl6AYwag6S+/W7XU1e4GY31p6rXGteYBxMLb1PAarfRaYa+GReK8l28gXEyn42ZBw5EP504C8Utkg927poGN4AASFBvegbVmOTn3wSns8Rf0yK2H6GisLXXnfk2e+pnEz3R4ZRnlPD0auDm7p3kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=W4yP5bUc; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53dd8b7796dso5563122e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 06:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1732717531; x=1733322331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M9vG//8ehMp4lOpZgUGc6H5kOfF24HtjuZe7yPe7sl4=;
        b=W4yP5bUcfl+XTSiRzx9s7yq01brSw7aRxEVAGKG84IowFgxgW5OOdlhsmF/HOIJxvM
         glDcVtgUzj8LGsA23RhWYf+4jBU0DMMvHXBlv72i4mQ1qtyNt2hv+xHFXFdKDt7qW7DV
         /PSFJA/A0hMkvuvZPa0dgMwQwPa4+FrH4Jc4wHrX1apUymtzJ1lBXJMK4Dr9Ej+8dbyT
         SbjymzHKV4jTtb7JyzzLlMNECelZFouYcwnO4wJYUl5tg0Rj6lWH5BfmZraZj3316NDp
         g1ZgQSTJaW6v/zUY2D4umJb0En675lJ0wqdNXSaKKfpvkBhEwRnzhEoyHbUup0G9iTYR
         pTvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732717531; x=1733322331;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M9vG//8ehMp4lOpZgUGc6H5kOfF24HtjuZe7yPe7sl4=;
        b=Doif65iheF0dMG7XIrdQUqE3XHR2MzKeCcZtXn6c6Tr/pY26uxOdoqkAP89HFAhrkl
         Zp5y490K1kvglVLYnanGYgqzcty/Yb4wgZ0GEy0HkoVhQ+cer38Ec8vZ0+Et+bpWjlYy
         vNnRstSvZVPdX9evReutst09K38nEWDtrSkmMAhr1UN/5yqXdnJslqWQ0MzwG+fxhs7J
         VaZLa573vMz4HvRXkeZ5sTZT074Bg2NScnW4xm98/NrVHOoH8pCWLQZaCR4CY4IHnpKm
         awu7CM9277B/va8bVCIO92FuPy++fQU0K/CaCkOPPpiiqAIxESivF2hopW4DpPyHeLyk
         2oJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFaPq8aBF7mnW+7qNRokiSsH2psvZq3BkJ+8Lbqrf2dDAwDeIs2kZtvAZXW4gznBxGJNAEYyeS4msMb30=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8+xY9/iP/3haiMIRS1pxO+608bxmO0Q11GCRwY/wrJaTkx3qv
	tugy51bA42RxcsonRdFMeaAsPxm2EMGUqzV83rQ3tgOqaNQKGj3oSE+1CZqPIFA=
X-Gm-Gg: ASbGnctGdrtOrGgO+CQh+UuoSLjjpA5H/GnNOMAp0pky0w3FRKGahrJxXKjZ/0wglIr
	GqH6Lltz0U5VJ/ENhJNw/jLbc3mHcN4T3bwX4e7dR8YzYgqQsXfCkmWxSlZoXByivptCa2WsSno
	C9cZEuMnt2v2RwAInuRhrTsj2602bjojr1eBODmuD8EpAbXcBlWnulUAaMjl19KvQf7p8B58Gma
	/JMBb1LM6qTmfEHrlqGq9AmqKVJeaKNkPfh60uBcHFcWp2FA38=
X-Google-Smtp-Source: AGHT+IEq0o9PJ9NLeVH70cbpvzcAJwyOpE7QpuGsdHSdB/UiJnox4e1NTf1b0VEcLfTBl4+Lz2uo5w==
X-Received: by 2002:a05:6512:2244:b0:53d:ed66:e070 with SMTP id 2adb3069b0e04-53df010ea48mr1692848e87.47.1732717530883;
        Wed, 27 Nov 2024 06:25:30 -0800 (PST)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fb53858sm16389913f8f.62.2024.11.27.06.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 06:25:30 -0800 (PST)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Kai Zhang <zhangkai@iscas.ac.cn>,
	Andrew Jones <ajones@ventanamicro.com>
Subject: [PATCH v2] riscv: module: use a plain variable for list_head instead of a pointer
Date: Wed, 27 Nov 2024 15:25:17 +0100
Message-ID: <20241127142519.3038691-1-cleger@rivosinc.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

rel_head's list_head member, rel_entry, doesn't need to be allocated,
its storage can just be part of the allocated rel_head. Remove the
pointer which allows to get rid of the allocation as well as an existing
memory leak found by Kai Zang using kmemleak.

Reported-by: Kai Zhang <zhangkai@iscas.ac.cn>
Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---

V2:
 - Add Kai Reported-by
 - Reword the commit description (Andrew)

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


