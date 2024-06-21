Return-Path: <linux-kernel+bounces-224656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 689F6912568
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 14:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23304281DDE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 12:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515A915574B;
	Fri, 21 Jun 2024 12:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wON6V2kI"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9E1155399
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 12:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718973167; cv=none; b=QALBrHJRVvqGCiKO80c/AjcQTIVePq+dlM0cXCSm4rUdsMp9OhISql2uMmOu29SEAo4q5LUi7KXM9+cJKtUnc6nrH+a6hmn37fxII2Iu5YoEg28GpJ7F0Jpwj6TyMdK3VThXUQrqy4d+wDOThhnMeB3+SC9m9ivdsIPfW0AMqwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718973167; c=relaxed/simple;
	bh=XvKH8yB7+J6NL1xJMHOJ0ToppJXlMKTu2n7fXKk/DyQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=m0kVWq1H8GCv0h7Qv9vUstg4JJB7WvDA6e+Cpnz+dzV81emNiwMmG2kO3Sz16z75VrKGwV9+kXJXD3l2Rd8Tud+gpD7zpHgZNcWWf/LsqrXU/EOTTSOYSf4+c3Hgeb65a1ru7e0lBkOf846yk+xXnyHduu9kL4RTWzT7xxWOYuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wON6V2kI; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4229bde57easo13529805e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 05:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718973164; x=1719577964; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CfipnPazTooSWljHtj0QKg/sbCS/LwM8w5FGtvn8eIw=;
        b=wON6V2kInKCFlMJE3PIYMoLSpyWBgZKa0j+ILw4wAJHu45WQZVrFpHMAk3egQIaeWH
         iIdaoGdBN8NIPo9dN3ov6UJbed3B5m1saxiWIUchiyyAC3Ly9MDHavYprgTqNAIREoGr
         T/n5SPyNxLoiTB2yNH3XbFmJCzIzcrEKl9hzTgbzSN3KLESM5wWMilvX05qTgnF7GgUU
         SbhK/Mp1SB+rF1XeKMgT0Tyg+MubjF9CsmFff4XMugq7EGRhjchLDlvSUEsSjYKGhPxk
         pqV5OrQ3IVaQVKjCcQIAlDMdZNlym6A/q3wAZaZIOxDl0aVDSHGPNgrMgJ8rqmRkWU75
         kxOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718973164; x=1719577964;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CfipnPazTooSWljHtj0QKg/sbCS/LwM8w5FGtvn8eIw=;
        b=Hv3xbwL0qtMjawPlseu0GZPqkyr6mjuPtDJtobIoE+Y++TuFMp7jG4cvUWGMQ05o8o
         jB31duTm/1Dtscnx5Lt/F41DBDmA27h3rTS4kbHQSM73QQsrnpijihD9bs08ZnLpwlHg
         7zFLcCPsFtO90cfUoVHs17JK3IAmCjtQzPvPrNkYWiTMqZQ3re6IJFIT0U6sKafE+rsh
         B7k7wUqRVoPLN9zoMFlrQrrmsparFzVQi4BfmKBjSO2QEh8nIiU9L5M+Z6XpoyMheume
         9negRVdR6JGksw2LaXK3J6X0V7Z9h9CmOeJPnavoQxUIDaHKkM88+wUhycs9p4d4Raux
         PDdw==
X-Forwarded-Encrypted: i=1; AJvYcCXhqNK2vcIaXrTdkPL+yIW/78yxkL+YmlnyEcMa4MSN8Bx3QtCIIRUY0WbQarHoe0FxSrQCRe3oBScsdOOzOrxHJNeDc8+hbhp1zuCR
X-Gm-Message-State: AOJu0YzVS86CNRcmKiZ9qJSEs7Ocj6tmpsqFyggO/NoIJCY0KG3KYtEZ
	t32WeyTWRelIdHYn8zn7YEOtZu+ZfmP8/z+FzWUdbhRj8WwWN5rkAEUJWhir6AdfeMcz7T8qLY+
	QE7a9nKR2gnuf081WML1rWyB8hg==
X-Google-Smtp-Source: AGHT+IGRdi8iCVedSAjQTPJq6auLk/a0anHCRS31CgRh12LvFMpWeGYnx6ArZlAwPEeWqjlBpzoOnFCppGjHDAYrqfw=
X-Received: from sebkvm.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:cd5])
 (user=sebastianene job=sendgmr) by 2002:a05:600c:3b9f:b0:421:7dc3:9a0c with
 SMTP id 5b1f17b1804b1-4247529a86bmr593065e9.3.1718973164436; Fri, 21 Jun 2024
 05:32:44 -0700 (PDT)
Date: Fri, 21 Jun 2024 12:32:27 +0000
In-Reply-To: <20240621123230.1085265-1-sebastianene@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240621123230.1085265-1-sebastianene@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240621123230.1085265-4-sebastianene@google.com>
Subject: [PATCH v7 3/6] arm64: ptdump: Use the mask from the state structure
From: Sebastian Ene <sebastianene@google.com>
To: akpm@linux-foundation.org, alexghiti@rivosinc.com, ankita@nvidia.com, 
	ardb@kernel.org, catalin.marinas@arm.com, christophe.leroy@csgroup.eu, 
	james.morse@arm.com, vdonnefort@google.com, mark.rutland@arm.com, 
	maz@kernel.org, oliver.upton@linux.dev, rananta@google.com, 
	ryan.roberts@arm.com, sebastianene@google.com, shahuang@redhat.com, 
	suzuki.poulose@arm.com, will@kernel.org, yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"

Printing the descriptor attributes requires accessing a mask which has a
different set of attributes for stage-2. In preparation for adding support
for the stage-2 pagetables dumping, use the mask from the local context
and not from the globally defined pg_level array. Store a pointer to
the pg_level array in the ptdump state structure. This will allow us to
extract the mask which is wrapped in the pg_level array and use it for
descriptor parsing in the note_page.

Signed-off-by: Sebastian Ene <sebastianene@google.com>
---
 arch/arm64/include/asm/ptdump.h |  1 +
 arch/arm64/mm/ptdump.c          | 13 ++++++++-----
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/ptdump.h b/arch/arm64/include/asm/ptdump.h
index c550b2afcab7..a4125d8d5a32 100644
--- a/arch/arm64/include/asm/ptdump.h
+++ b/arch/arm64/include/asm/ptdump.h
@@ -44,6 +44,7 @@ struct pg_level {
  */
 struct pg_state {
 	struct ptdump_state ptdump;
+	struct pg_level *pg_level;
 	struct seq_file *seq;
 	const struct addr_marker *marker;
 	const struct mm_struct *mm;
diff --git a/arch/arm64/mm/ptdump.c b/arch/arm64/mm/ptdump.c
index e370b7a945de..9637a6415ea7 100644
--- a/arch/arm64/mm/ptdump.c
+++ b/arch/arm64/mm/ptdump.c
@@ -192,6 +192,7 @@ void note_page(struct ptdump_state *pt_st, unsigned long addr, int level,
 	       u64 val)
 {
 	struct pg_state *st = container_of(pt_st, struct pg_state, ptdump);
+	struct pg_level *pg_info = st->pg_level;
 	static const char units[] = "KMGTPE";
 	u64 prot = 0;
 
@@ -201,7 +202,7 @@ void note_page(struct ptdump_state *pt_st, unsigned long addr, int level,
 		level = 0;
 
 	if (level >= 0)
-		prot = val & pg_level[level].mask;
+		prot = val & pg_info[level].mask;
 
 	if (st->level == -1) {
 		st->level = level;
@@ -227,10 +228,10 @@ void note_page(struct ptdump_state *pt_st, unsigned long addr, int level,
 			unit++;
 		}
 		pt_dump_seq_printf(st->seq, "%9lu%c %s", delta, *unit,
-				   pg_level[st->level].name);
-		if (st->current_prot && pg_level[st->level].bits)
-			dump_prot(st, pg_level[st->level].bits,
-				  pg_level[st->level].num);
+				   pg_info[st->level].name);
+		if (st->current_prot && pg_info[st->level].bits)
+			dump_prot(st, pg_info[st->level].bits,
+				  pg_info[st->level].num);
 		pt_dump_seq_puts(st->seq, "\n");
 
 		if (addr >= st->marker[1].start_address) {
@@ -262,6 +263,7 @@ void ptdump_walk(struct seq_file *s, struct ptdump_info *info)
 		.seq = s,
 		.marker = info->markers,
 		.mm = info->mm,
+		.pg_level = &pg_level[0],
 		.level = -1,
 		.ptdump = {
 			.note_page = note_page,
@@ -297,6 +299,7 @@ bool ptdump_check_wx(void)
 			{ 0, NULL},
 			{ -1, NULL},
 		},
+		.pg_level = &pg_level[0],
 		.level = -1,
 		.check_wx = true,
 		.ptdump = {
-- 
2.45.2.741.gdbec12cfda-goog


