Return-Path: <linux-kernel+bounces-302895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E6F9604C4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 10:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95EA1B22F79
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 08:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1FA719CD07;
	Tue, 27 Aug 2024 08:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2lEIu4UO"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA46919AD85
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 08:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724748368; cv=none; b=H41mHMWum3nOZVGWl7e8IRR2G3J5Mroc3aZWhpCrS92itbN7qTsNMIYvqQOXDSElQRJJzmirAYW9NaWhTZgD9ISSL+aysHP6jJYqzY4wgZrvVHJ+5YXiXZBGj+/CrenvdZy3iyiHrmP5E1fUmaoDOhOu+pGQLJtjRGiuen3mUhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724748368; c=relaxed/simple;
	bh=Lw37HyF37GzltMhnte000Ty23NUQC83Fy2jc5oyK3FA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TdUFrv/r6FjAa5hC6ht+LA2QaGc9BCAlutlXNPai3abo3yKUb+Xoj0/PAjggkLTPbvFmFYDD4VFQUmqGquwnY73OJGVrxWNn6hrDJFEBNfYCaI2SFxRHsesy8qRxYuNbC4yC8sbYI3sy5nDd3LOjP4i6Lu445rp9UWQ45ZxtXG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2lEIu4UO; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6b2249bf2d0so109104837b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 01:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724748366; x=1725353166; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=S/4eIk6jI1tjaj4UGqml6oE2hCNIy1npmCkHCveHD80=;
        b=2lEIu4UOD1oOax2M+SAPnqGL/oG1Mh65bzS0Xn0m4z9px1XM8T2BIILFAvycyL47Qm
         xiPfLjzjqloQClxWtFwGJWraYL7KHc93E+0yac3gHP8J8qmgLR/pRncWESAFy5ulX70e
         VghwM6QrbpxDDQmv3Lwnq3WpsgWk9SBY2MHEULwysNY+TuTS64VKcsOqmJ7JphshpBF6
         XDEarDVyo3ZiNNnE0elEVH0Y/mGk5z7E67ZxJLzL1I5UBVvWGCzaLQG4zodFVoFY0ibV
         0KsyaAPAwe0LXSoUUsBX5gjOIBqcw2psOMkGeRnxCB63y6kJpkhKbFL/GrTAYo+KVoEe
         1VBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724748366; x=1725353166;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S/4eIk6jI1tjaj4UGqml6oE2hCNIy1npmCkHCveHD80=;
        b=bgQ/eix6XVuURn9RfDptVCchJHL4JN5m8NWJtp4vjB5OqprLF8Qvt0YDqaZRPWS/4R
         0NHlikvegc+ADxeODAHc0co/UHAMsyrsy58wBlhLLYdC3/Ih1bfnmCiKxGGBtbnqCBBe
         4XtzbfJzGMViNTSbgWvXS47ZLiJ4t9oNOzeiBo5i3lWcabq27GW09NDUR2RLQUUKQAHz
         a6bagMuauO7JkrCoUbM2vJ3OBZCTjWyyaH7nUbJaEx2B8zpg8B60U3T07fCcUCU1dVh5
         vDSUGyexOGkpL0wg3sRZphfBN/hzv59vafFHRxbZUaVx11NyE5suNmAsx0NvqPNKsxi5
         a+hg==
X-Forwarded-Encrypted: i=1; AJvYcCUvUyK9L73GPGGoqVt2IYXltwDxsUsoUBBavTVjbzmDGAuOz5Lj7u+at9i2T3iXziHJO8VvDWV1ti+eJzg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2SDZ4kBkX37xgUliREkPMoonG3LtHnbQ1K5RuFXO7O6EHkSd+
	lqGtOaRmMmSSq5IyPApojWKhvpX1Y6KXnxb9JTi7ABYxM7+Ris71/aOL2ZA5ZMwldpFd3Sm2FQE
	s26aeysEgvFnLdSYOSPQQzS9H1A==
X-Google-Smtp-Source: AGHT+IH5RM7JuVVSPKnjdxxxYeoYnQeY0l7qLc/ywBgRIM547MLlZ6+2U/YgCfXhEykPoaO06zqlMD4Kq2MFsPnHn0E=
X-Received: from sebkvm.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:cd5])
 (user=sebastianene job=sendgmr) by 2002:a05:690c:4a06:b0:62d:1142:83a5 with
 SMTP id 00721157ae682-6cfbbadf920mr1801177b3.8.1724748365682; Tue, 27 Aug
 2024 01:46:05 -0700 (PDT)
Date: Tue, 27 Aug 2024 08:45:46 +0000
In-Reply-To: <20240827084549.45731-1-sebastianene@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240827084549.45731-1-sebastianene@google.com>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Message-ID: <20240827084549.45731-4-sebastianene@google.com>
Subject: [PATCH v9 3/5] arm64: ptdump: Use the ptdump description from a local context
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
2.46.0.295.g3b9ea8a38a-goog


