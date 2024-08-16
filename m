Return-Path: <linux-kernel+bounces-289664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5529E9548E6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 14:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EB8F1C23BD3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 12:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613A71B8EBB;
	Fri, 16 Aug 2024 12:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IpJqwvCe"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FFE1B8E85
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 12:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723811964; cv=none; b=GlyDvN04tIzylB5u33VeXSLKCeNbXvq01RD6acd34pamBY3ctthZowHZ0UXAld8NykpcidXQ4JFeKySwMX7vRFIk/YN6j1qM1p6uQ87qm7lSD5Euw8X/BycuN5HeS3k+Yj7vJ1vsFF/n9XiLSUyVP+87rW+rFjJbtBxWPegUKvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723811964; c=relaxed/simple;
	bh=eGtEtPkxRm/Bp/1pUnIw1ZGoSEo/VchDZHTGqv1Cie0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=P2pWftGEqq8342t8ckg8rK5Zo0RPxF0Db5utZ13qSSNTymm75JOJh6gjnHHj/wwPvcIzV2DNeFHJbNFDvhYUi0wtUzq1x3tVIArInPgAvs/JfKxdRx/dSnA2ZRIqZVrb6aw6f8hxSBirMqCt7lmOBG7pGheQ7OHz63NM+7VNdeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IpJqwvCe; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-37188f68116so821364f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 05:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723811961; x=1724416761; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TOVsSjbkFKkupVHDdUClsSrj3QZ/4GeILHKaUawEmW8=;
        b=IpJqwvCe090M9m+hp+O1Io0ePqnkjgIB2ISub8a9H42bIRcfwBCpJCLpHAlwJ3P0U/
         eqDajzY8YZSDeWhgKWEWL1iGL3eGTqVZ9z0DOGuyNwCPxH5Nnl0t+Hbp/WGQNJURXubE
         hpTy2Nv/sxAEheJosgsSB0DEErHZsEGfbEuPpJDpRQuem3g37spLN7BCfIQTKN+0hQb3
         6PDtDIO+wWsjSbIr8X4L79dJtUXLbEKLn2bVaBPAQMlhgDQo9y2mSH1BPQRsSVm9TyBq
         pnXYEnRPnXWXI8cV59xpcubzrWSSvaOCkviW8QwAxWvJlL5kphqGsCyaTGrYMkysPHX3
         mwAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723811961; x=1724416761;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TOVsSjbkFKkupVHDdUClsSrj3QZ/4GeILHKaUawEmW8=;
        b=qUdXT+kj25pgvJ8TJfIgTBbmT36rXyHHOF20Z8oIoN9Qe4VmqY2WRsNzXW1wmmzdk1
         0qhwvjq0dek/NV/lJ3dWPIZON6qT7PMDfeB4wJ3rbXwUZ48xUZOb6GTJ9oHfS2wI71t1
         +9h/jVJgDaYsIGFeEvQtGEcNrLHWCD3Z3EWj59OXWh97SDiP92UIsqJDmUbz60shW2s2
         o9ilbeqYjDtW998ED+uDZL/0nU0NpdeU3jl1wDD6KcmtdqPgTaZU5VzlnsOyln+DQtyc
         vTxydOJHSKFHKDuhDtugTPnzi2dLVSZfRH8BqAQOZ7EIrVsD21cxoQvuwJ9xjLv1WVq5
         e1ZA==
X-Forwarded-Encrypted: i=1; AJvYcCWaa5vmubUWEh59v84T30MZ8hCRY5I9XTitm/aJflM1eIdD59au4RzUGizjwyn+LUtVqNAlumQOuf12A4dKFEw33wmgDoBG34YngAzB
X-Gm-Message-State: AOJu0YyDLboTHcAAGPttDI5n9Q+dFxTQMF7Jg+vPwKkQYK7MgGox3lgJ
	JCeeTVTWxz5aEUhRsmch4rv8VV1zSVISe6g7UH430o3u0y042+Osaeat8pgLq+PaDtLcfLy1a0s
	bfMaB9HTLoW4Sr7cy0VR+zn9lNQ==
X-Google-Smtp-Source: AGHT+IHcICbWJmK89n8rtw3CIsZCVnNXfh2Wfm6YpkzCdhB56aOnbSeNarXn8GFhkvmcCHzcvJ1/hlKucHN9pFgTZco=
X-Received: from sebkvm.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:cd5])
 (user=sebastianene job=sendgmr) by 2002:a5d:6449:0:b0:371:8685:846 with SMTP
 id ffacd0b85a97d-3719465d24fmr4614f8f.8.1723811960947; Fri, 16 Aug 2024
 05:39:20 -0700 (PDT)
Date: Fri, 16 Aug 2024 12:39:03 +0000
In-Reply-To: <20240816123906.3683425-1-sebastianene@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240816123906.3683425-1-sebastianene@google.com>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Message-ID: <20240816123906.3683425-4-sebastianene@google.com>
Subject: [PATCH v8 3/6] arm64: ptdump: Use the mask from the state structure
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
index bd5d3ee3e8dc..71a7ed01153a 100644
--- a/arch/arm64/include/asm/ptdump.h
+++ b/arch/arm64/include/asm/ptdump.h
@@ -44,6 +44,7 @@ struct ptdump_pg_level {
  */
 struct ptdump_pg_state {
 	struct ptdump_state ptdump;
+	struct ptdump_pg_level *pg_level;
 	struct seq_file *seq;
 	const struct addr_marker *marker;
 	const struct mm_struct *mm;
diff --git a/arch/arm64/mm/ptdump.c b/arch/arm64/mm/ptdump.c
index 404751fd30fe..ca53ef274a8b 100644
--- a/arch/arm64/mm/ptdump.c
+++ b/arch/arm64/mm/ptdump.c
@@ -117,7 +117,7 @@ static const struct ptdump_prot_bits pte_bits[] = {
 	}
 };
 
-static struct ptdump_pg_level pg_level[] __ro_after_init = {
+static struct ptdump_pg_level kernel_pg_levels[] __ro_after_init = {
 	{ /* pgd */
 		.name	= "PGD",
 		.bits	= pte_bits,
@@ -192,6 +192,7 @@ void note_page(struct ptdump_state *pt_st, unsigned long addr, int level,
 	       u64 val)
 {
 	struct ptdump_pg_state *st = container_of(pt_st, struct ptdump_pg_state, ptdump);
+	struct ptdump_pg_level *pg_level = st->pg_level;
 	static const char units[] = "KMGTPE";
 	u64 prot = 0;
 
@@ -262,6 +263,7 @@ void ptdump_walk(struct seq_file *s, struct ptdump_info *info)
 		.seq = s,
 		.marker = info->markers,
 		.mm = info->mm,
+		.pg_level = &kernel_pg_levels[0],
 		.level = -1,
 		.ptdump = {
 			.note_page = note_page,
@@ -279,10 +281,10 @@ static void __init ptdump_initialize(void)
 {
 	unsigned i, j;
 
-	for (i = 0; i < ARRAY_SIZE(pg_level); i++)
-		if (pg_level[i].bits)
-			for (j = 0; j < pg_level[i].num; j++)
-				pg_level[i].mask |= pg_level[i].bits[j].mask;
+	for (i = 0; i < ARRAY_SIZE(kernel_pg_levels); i++)
+		if (kernel_pg_levels[i].bits)
+			for (j = 0; j < kernel_pg_levels[i].num; j++)
+				kernel_pg_levels[i].mask |= kernel_pg_levels[i].bits[j].mask;
 }
 
 static struct ptdump_info kernel_ptdump_info __ro_after_init = {
@@ -297,6 +299,7 @@ bool ptdump_check_wx(void)
 			{ 0, NULL},
 			{ -1, NULL},
 		},
+		.pg_level = &kernel_pg_levels[0],
 		.level = -1,
 		.check_wx = true,
 		.ptdump = {
-- 
2.46.0.184.g6999bdac58-goog


