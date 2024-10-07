Return-Path: <linux-kernel+bounces-354237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37131993A8C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 00:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A40031F2332D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 22:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D3E18CC15;
	Mon,  7 Oct 2024 22:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ImYurYLf"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6898E18BC19
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 22:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728341281; cv=none; b=s8EHYPgYbYT3BzhrJ4TX7ztRramUzgk7RC0AWu8l+AgbPvTkZx2chJ7uBJKT2FFmSRXvV0bVsPcrP+0tlIJcTasTN4icJGS0BPNgA/fjg4IpCBmeqg0JQRJlWlbZAtByGBmXsrdyxfHh+luR9l8KOVHPQIboSfZjuXt5LCyvyU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728341281; c=relaxed/simple;
	bh=NDWRvLyTX7gZkEepoCtLwcYO9gC5yjzYcwXH68p+XEM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Nc2agM7PLKu/oJ37RnPTZDQ/Z7ziYbMyVIVkrFnAViHQIizAfcrPI8q6ME5r1LtIPzU2sY9dVLMNhkn4cW7O4cahsj8bGYNfcVD5BqsEb9DkRIG0AvWxJXu+m9t/uiRNcHMB+sEJzJgtyDVNii+Dw/iZU7QF0jLoJmZIcgM04iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ImYurYLf; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e2364f45a4so63840037b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 15:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728341279; x=1728946079; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ShTzLRbqyu/YgXkjUQkbW/8ewXalh+JZPMkvNrOvD9w=;
        b=ImYurYLft8PLV40PnDVym8bQdF9CyqDXTPgbk90/xALdT3lQTncW+51BEPOuYOoEn2
         1YCycory3VK1QP89kkDa++Ifnojd7mYTo6gXfcs9qavAzbEZH5bTiD/pqgFdaNediwAs
         Nk8LyAE34sUEYVDpVB/pZ74I3jmUyS6V4KLR3qLHp3Hj69Zk2uha5ha4HNhG28GCA6YU
         R/4aTxBRNWMG9Uoqm817OBAeMe8bRc8XVbZf2I1Xnx80x6IxAexb0O02bwr9hS+IeQKH
         oStPs95wDJXcrJbVAvXshKDIkEoIPMv2HlZtk8iUPnwxEOpxf/m9LsDbOhhz+80xR+SA
         npuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728341279; x=1728946079;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ShTzLRbqyu/YgXkjUQkbW/8ewXalh+JZPMkvNrOvD9w=;
        b=vmSqY/sUiONsGjqFgbsILGDtJysTjNrml/WLMqCHcemH05Xf/kZ9S/bhA7C1kUeQtm
         gTQfFfHWlniS5tYqXYgZK5G7mQ5Euj30YN5pQGprWHeAd/RznuR2mDVrhLHIY2rYUqEO
         v4NXqHanGYycWB4gaGkAVThzzInEZ8CL1xWPZ06lfKTdOEb3Yo4UZ5UXaaPF+7K9Mr5B
         d52P3A6U9TmN7bgZT1i3Bg8kKqbacUUVurk1ReKUIPZ5wGuo3xGXghvF6XEaB5OP1led
         2OYJaWeVahSqjo1FeobICP9yIvZ/Btg7VniviGqksRge0E3TGwqfd5/IHvjsIvdUxx2T
         oOWw==
X-Gm-Message-State: AOJu0YwtS2u9x6NkV2TYtEWgBEpzXaiqvr8IBlJYoM59iM1qe80tPKFw
	px/TT7Si1D08NjXksmIFiFr8hRotdF/HYyZuoUw9FuQvqBsl7PjFljvi3OKdv6XaJO/xuSLkUXK
	bQ8EIAt8+2r51qrjBk7K4L9tzYTaaKN/bNtRmkVd1naYOnJKT41Q5f7+kcAwfSclNal2qt+6Sca
	t7sCVIVtZkEfEEA9EnJ6GmxFLHyLyK+A==
X-Google-Smtp-Source: AGHT+IFNN2TzNcBJbVmxESUbP/63yVxeZO5I3RskREAU+kQlzLxdD0HGmcjKbl9+2e6Ht4xB96b3UgDj
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:a05:6902:1786:b0:e25:d202:d376 with SMTP id
 3f1490d57ef6-e28be89b1a9mr5152276.6.1728341278437; Mon, 07 Oct 2024 15:47:58
 -0700 (PDT)
Date: Tue,  8 Oct 2024 00:47:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3299; i=ardb@kernel.org;
 h=from:subject; bh=jjGogOkA3ibchETVyp2qZXTcAyKjOw0JI3mr3vJRgaw=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIZ0lVeSJSPnHzlV7vzRGuV8+fPfC/v/vPvSVPcs4PzHxi
 XLmHs7FHaUsDGIcDLJiiiwCs/++23l6olSt8yxZmDmsTCBDGLg4BWAi5wUZGe7uulVatMX9uoDl
 jelbX3f2urG0bN0lxnjA8Ecb85XXh+cyMrxnZl2p/CRxwdPEiZtqH74yc1vD/l5pDdNLb+utuSI qt5gA
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241007224747.3973322-2-ardb+git@google.com>
Subject: [PATCH] objtool: Deal with relative jump tables correctly
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Relative jump tables contain entries that carry the offset between the
target of the jump and the start of the jump table. This permits the PIC
idiom of

    leaq    jump_table(%rip), %tbl
    movslq  (%tbl,%idx,4), %offset
    addq    %offset, %tbl
    jmp     *%tbl

The jump table entries are decorated with PC32 relocations, which record
the offset of the referenced symbol to the target of the relocation.
This means that only the first entry produces the correct value
directly; the subsequent ones need to be corrected to produce the offset
relative to the start of the table accurately, by applying an addend.

Given that the referenced symbols are already expressed in terms of
sections and addends, e.g., .text+0x5df9, the correction is incorporated
into the existing addend. The upshot of this is that chasing the
reference to find the target instruction needs to take this second
addend into account as well.

Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 tools/objtool/arch/x86/special.c |  8 --------
 tools/objtool/check.c            | 14 ++++++++++++--
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/tools/objtool/arch/x86/special.c b/tools/objtool/arch/x86/special.c
index 4ea0f9815fda..415e4d035e53 100644
--- a/tools/objtool/arch/x86/special.c
+++ b/tools/objtool/arch/x86/special.c
@@ -150,13 +150,5 @@ struct reloc *arch_find_switch_table(struct objtool_file *file,
 	if (!rodata_reloc)
 		return NULL;
 
-	/*
-	 * Use of RIP-relative switch jumps is quite rare, and
-	 * indicates a rare GCC quirk/bug which can leave dead
-	 * code behind.
-	 */
-	if (reloc_type(text_reloc) == R_X86_64_PC32)
-		file->ignore_unreachables = true;
-
 	return rodata_reloc;
 }
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 3cb3e9b5ad0b..db5c5069473f 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2111,13 +2111,15 @@ static int add_jump_table(struct objtool_file *file, struct instruction *insn,
 	 * instruction.
 	 */
 	for_each_reloc_from(table->sec, reloc) {
+		bool pcrel = reloc_type(reloc) == R_X86_64_PC32;
+		unsigned long addend = reloc_addend(reloc);
 
 		/* Check for the end of the table: */
 		if (reloc != table && reloc == next_table)
 			break;
 
 		/* Make sure the table entries are consecutive: */
-		if (prev_offset && reloc_offset(reloc) != prev_offset + 8)
+		if (prev_offset && reloc_offset(reloc) != prev_offset + (pcrel ? 4 : 8))
 			break;
 
 		/* Detect function pointers from contiguous objects: */
@@ -2125,7 +2127,15 @@ static int add_jump_table(struct objtool_file *file, struct instruction *insn,
 		    reloc_addend(reloc) == pfunc->offset)
 			break;
 
-		dest_insn = find_insn(file, reloc->sym->sec, reloc_addend(reloc));
+		/*
+		 * Place-relative jump tables carry offsets relative to the
+		 * start of the jump table, not to the entry itself. So correct
+		 * the addend for the location of the entry in the table.
+		 */
+		if (pcrel)
+			addend -= reloc_offset(reloc) - reloc_offset(table);
+
+		dest_insn = find_insn(file, reloc->sym->sec, addend);
 		if (!dest_insn)
 			break;
 
-- 
2.47.0.rc0.187.ge670bccf7e-goog


