Return-Path: <linux-kernel+bounces-433105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A35769E53EA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30E551882A3E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92ED5207640;
	Thu,  5 Dec 2024 11:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J5pzfJ3B"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9F4206F1C
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 11:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733398117; cv=none; b=Sm0Kmf6FYqI+SUGj4hTS4brEsHL2mtin0Gihg9B+RFFnhFuRW5zYifLEJ8QxKyr6lcOsLDi5rMmpXSdLuluJnDH0USTGDfEKmtJOhmMNMoRj+lV/clJm1e6w25LHpDqbvq0YHgay1c88BwAOz/w6KhWrpa0QdH8Hdl3YumY8nG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733398117; c=relaxed/simple;
	bh=BJxWaG3LG07cByXogeTrhHPotDDC9djWuaXGZrlgS30=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=trzxe5SupcIayjSeqL1K19g+PG9BFpFGtuZ3cAzlyHEysHNGLWQwThGixIhzrXxKAP4vzFTL7y+EHN9NgyooZA4tKNJ5sVKX9Rk7juyfYHdOKFgxTEuNPu/GHQOQnLvK2qb60NUtXxSA+mE8/chnUUzYYpcMdLKTY9L1A3oxCOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J5pzfJ3B; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-385e1339790so552400f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 03:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733398113; x=1734002913; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EVxbuMOjYyrpPpcUh6qSzDwsNDxKmpVMu7erIHpl4HY=;
        b=J5pzfJ3Bh71J7o8VHITFA3RE6HT+uXx0gDULvfbWkQq7Wk0obFjX5MLrchmkuyc+Md
         DauLVd7Xt2l2/ekwjPuEteX3GHgcZwyPmpg0zAZMvNBq/jy1SrC6fLA+EAojKkQ83t0w
         H4Ac35U9FXfmoEqb9ghimTAgm9z3b//rrVSLqIghmlfTNVWsaBD0t9fiBis9di+wtzyL
         U46pN1FxGZVFhxXVvu9ejQNAPlDPm1FrTpngDPVviU10b+5QptH/j6hAvWUTVrTq2C6/
         WMIq3ux0FEhcD6u+BcNwYMzlWvGW+xM1cLLbVDgPGLbmhkf6L3GcFEApIKonsy+3OUtq
         Fm2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733398113; x=1734002913;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EVxbuMOjYyrpPpcUh6qSzDwsNDxKmpVMu7erIHpl4HY=;
        b=VbWMWsxgpbjjXcGHNEe/afCM5h3GUnXOe70c3+qL6QVJ4MqE5g1qjr711tUNZjdhX7
         KF+ssZc1fL9zmROar77u2OdQTS5908oWNdYUEHQgboVK+lh7mabRYHo0TWjVSRVIpmaa
         uZHEXt8fCKgPl3IJV3FfPc6ez8QWVpCEfk+1IXiIk0HnkdA8REoe64uFODs9c/IbRfMT
         7dypC8CVNI08PGr4OEPS2Kb4Z5ljIEZtzo04t5Q4fuUpP+vcfBjIcqxQxjfY5D0kdzuV
         nI61HjB+20YZjLMJCZg0T0/8wF548jRa+Tlfh26INjT/FH4NkV66DpZcaZjESjOfJHbc
         ZZjw==
X-Gm-Message-State: AOJu0YxRdp95MiXQrlxHQ6wQz6snRY+96yJnp0lSJ/bsJx6nOam4kcpQ
	AfhRcML/9m7pd7D/3yHhdQ8OGrV5l4Taaoo93ajyoqDqsyTZrlOuckd8r9bGEp4+oiW+0QfnI3Q
	4Co3wLQApdbJDw6mjjQwXNLqCzTDkqaziPYc9olH9QMBtCryQ7G40Fhli9e3DjzMWrCJEb611lC
	bA/uYyaK56HKQ4V3KXqVRqmIz+pCDMKQ==
X-Google-Smtp-Source: AGHT+IHrr3+PUxqcL2pee8GvT0QXdAtHoEfvoXnwzcg3QB/dtY60CjjL0g8V7CdoLbs8+b3I+wlKdjtx
X-Received: from wmbd19.prod.google.com ([2002:a05:600c:58d3:b0:431:1903:8a3e])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a5d:6d81:0:b0:386:144d:680f
 with SMTP id ffacd0b85a97d-386144d691emr3098753f8f.54.1733398113637; Thu, 05
 Dec 2024 03:28:33 -0800 (PST)
Date: Thu,  5 Dec 2024 12:28:11 +0100
In-Reply-To: <20241205112804.3416920-9-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241205112804.3416920-9-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1061; i=ardb@kernel.org;
 h=from:subject; bh=cMyytGdZQid8ZkRyymkz/WdbypNbvdtAWvmTUH1fzms=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIT2wz2+lZ+K5Ty5nhNI9MosX7WSIWPlh4fvXp0yFgu85L
 DNdcrm6o4SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAExE/xjDd38Zq2JpN7035xlP
 71rJ58yqtWTHoU7Wjhfn23NqXnN+ZPhn/+v87AWfi5XZGrNrnEw2HC6VCPyYuv/EdssjCnWxPue YAQ==
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241205112804.3416920-15-ardb+git@google.com>
Subject: [PATCH v4 6/7] x86/boot: Move .head.text into its own output section
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>, 
	Kevin Loughlin <kevinloughlin@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

In order to be able to double check that vmlinux is emitted without
absolute symbol references in .head.text, it needs to be distinguishable
from the rest of .text in the ELF metadata.

So move .head.text into its own ELF section.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/kernel/vmlinux.lds.S | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 1ce7889cd12b..56cdf13611e3 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -135,8 +135,6 @@ SECTIONS
 #endif
 		ALIGN_ENTRY_TEXT_END
 
-		/* bootstrapping code */
-		HEAD_TEXT
 		TEXT_TEXT
 		SCHED_TEXT
 		LOCK_TEXT
@@ -151,6 +149,11 @@ SECTIONS
 
 	} :text = 0xcccccccc
 
+	/* bootstrapping code */
+	.head.text : AT(ADDR(.head.text) - LOAD_OFFSET) {
+		HEAD_TEXT
+	} :text = 0xcccccccc
+
 	/* End of text section, which should occupy whole number of pages */
 	_etext = .;
 	. = ALIGN(PAGE_SIZE);
-- 
2.47.0.338.g60cca15819-goog


