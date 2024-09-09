Return-Path: <linux-kernel+bounces-321379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 227569719D1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 14:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 268931C22966
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 12:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B381B9B2F;
	Mon,  9 Sep 2024 12:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p/375S7T"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1AE1B86FF
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 12:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725886055; cv=none; b=RVjYoFzxmV0suP1Gu6iI/dyz8fjzwYF9PlTOKz3OOjzofvshbM2odbBMB/+9Lj1j9wQHl2QtSKS9TKTwfDae9VpxXSMs5hT9EjggDiqO+OaOPDAmvoMkCc16KrVSyVvbuETB7ifh9GCMiCMLfBs8A4fxMyFdizLXC3NEmLoNQ6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725886055; c=relaxed/simple;
	bh=VtR8TuQkNfUkd5xyRn11f5JLt2Zxl4vNilvMS7v/n5o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mnGyfmTrSy15pV0Hcxc8GBWlvF++2vWPJWVincEnOyD0qeXCLezVUVE9AV/5EDr/Ba0nAFKeWimRE13DSY2I1ByfX20B4HNGxuIVVSDr1mCkRrxv2bz+jy8D3591aNp42m5eK5HSmQej0Rf+ny6HWBBQkJpI7KOnfXWA4PonbWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p/375S7T; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-42ac185e26cso34022115e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 05:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725886052; x=1726490852; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=z5YaerhLrnlA1kDn0gvbQTCDMMWwt29NrOwuLXna95M=;
        b=p/375S7TjHJMK071UTt/aO7P0VMn2NK7DsEoiMC5pQ621qXfY7zE1Tu/P4H9ywWK26
         +5Q0XBddtb4A6YXts781V/fdgdtep86GnO53EWdlcJeIzVjNrvGbWSwNxDFjnFbRMYoI
         5HeEX3cSv513uK6NU9AGhubuprOo3O2K3SixGumcnUm+vfqB4idQSEdeVvVZt/xl9HA8
         uHYz1lG4gMJ2pLg7WTjwYSpuvCUdmqshvnQmCDQJ3enRbDn9Ir4ThZbeeYGmk+1Kynpw
         h0XmRpd9sTMnJP++/J5RiFroAcWnuB0FP8mkVbnbU4z6hI5rbJqPeBI8z74tUmdgK+6U
         JCbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725886052; x=1726490852;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z5YaerhLrnlA1kDn0gvbQTCDMMWwt29NrOwuLXna95M=;
        b=bO6lBxgPMnHa8a7WZna3g94gziYYtSk089jze9AoTttETSCqWdG3VU6ExbR/e0cnpI
         KEPBIio/Gvfwao8vE8ww77x1FWHKLO3snvXTNQzsYw2RoPbyE8104iC3vlEGgQHSASZF
         XPimVy+JcfYH6rjpzjVxr8lG7hldoQa2pAUc6JFW2fMsTtdnOqZeC1cgmuH0D6zkxajm
         pNoueiiuKVxkCToVxgJWPozTcvW0X6Ei0HNf6YZJ4rZGUWPRubF4io2JApNAq1P676Ko
         BryAZH2/V9Y6MLJPE6kGWTXjA2mmvEXKfDOW712xOYuhZsGpdSJNzrDNll7yocPHL6N5
         pUQw==
X-Forwarded-Encrypted: i=1; AJvYcCVtsxBHYPhebBQ7RKRppFN3s4ZD5PdTLR9ty6z5nkNeV7evZtv1B/7EtyTTl1Td1p0xlNi+mrMyQKpJmek=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW7lw2oXPTV9SeoGMXeYog6F4BxCGsshPS/7esOqOtPcgk+5NW
	9Xag6txojxgPwCTBnNfZKnp0hO5vZTV0ZaZHPJP9kL8WmpdbCyidSdEc6NSIj2IjIgo5zWNHNjt
	X+YxZcB6Mz6Kj0MlE872bCoX2bg==
X-Google-Smtp-Source: AGHT+IHvFQbj0rKg0Z2E+lg4FZtxEigwOSWg+BND77qixGLBIzbCZ5lpRaiz0wEgqDC0ZzG+egBczPT3YnPFvCYHpdQ=
X-Received: from sebkvm.c.googlers.com ([fda3:e722:ac3:cc00:68:fe9:ac10:f1b7])
 (user=sebastianene job=sendgmr) by 2002:a05:600c:6b6d:b0:42c:8875:95da with
 SMTP id 5b1f17b1804b1-42c9f9e090emr259485e9.7.1725886051855; Mon, 09 Sep 2024
 05:47:31 -0700 (PDT)
Date: Mon,  9 Sep 2024 12:47:19 +0000
In-Reply-To: <20240909124721.1672199-1-sebastianene@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240909124721.1672199-1-sebastianene@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240909124721.1672199-4-sebastianene@google.com>
Subject: [PATCH v10 3/5] arm64: ptdump: Use the ptdump description from a
 local context
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

Rename the attributes description array to allow the parsing method
to use the description from a local context. To be able to do this,
store a pointer to the description array in the state structure. This
will allow for the later introduced callers (stage_2 ptdump) to specify
their own page table description format to the ptdump parser.

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
2.46.0.469.g59c65b2a67-goog


