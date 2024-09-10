Return-Path: <linux-kernel+bounces-322557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91080972AD2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 09:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EF3E1C23ECD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 07:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8FC917DE36;
	Tue, 10 Sep 2024 07:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oMzpcFD5"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB30617D346
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 07:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725953490; cv=none; b=MhqtBKk+arkna0Fe2a+2R90iqvjJdZ4mUO3iFFoX+68sj2c8UaDptGSLZMEWh8gdgUGvRhoo6F30KikkaZsVUdcVPWvAkG7SIcXb5skGGCbhk60VOXXFwpQbeUnL5MnRcF4aVSDiN9M8n3xgdjKxTcHUcXZb0R8pX3yEoL81/xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725953490; c=relaxed/simple;
	bh=90iErQjUuxlZuLvLxHWwZTKsBLvAE0hLjm8Girdgx/8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=GPWcgucJcJbmavvv6bPV5cIz5vw24zV4cqzqukaabvR11FEgwVKq025JmMSVpkRV2sQ8kM0JkkxZJSneSJDKyTk+GKVmu2Ig9RFApsKI/q+BgimQ3MlwVB94+AjeVv6bRaN5Eu9FrwANOHyVCWEGNCL+4UoB8o9DCufPS39yw/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oMzpcFD5; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6b2249bf2d0so155170077b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 00:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725953487; x=1726558287; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iJF/m32H/gSTOtDci0bGeFjM2c8K5gpqBOSZEpRycYk=;
        b=oMzpcFD5v6K9M71PPwB4CYtolR2F1HOgh8iyc1YbLWf4pvfTXC0BqDLjSbEmVDXQbR
         gtzeiI+gX0BhP9uSid3aCd3ygox1AoXu0Qj+xVLOOXT/2O6HTqPM1jsrseXvjN8HdOYy
         RxCYS8nF3/sII2UqvTk3sEgxtpk1Rmk30Z4sxSdU15rypxR20s3F+02mKihKbm2SzwyC
         jfH2Nxei+e1MqsbTrG/vqVgJvwvLBsI4F3PzN4mGXq7wB1Y7m91U53xR8GECLiDM4Mju
         xOzh0nPOMTM54HAmZsmml609Omon5VB1bbRlR15pNBwd03w5aUj+gDOSfr2XNJqv04Dd
         K3Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725953487; x=1726558287;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iJF/m32H/gSTOtDci0bGeFjM2c8K5gpqBOSZEpRycYk=;
        b=oi8NpSrUSVm4xoG1gQKwVtbtN2dN8jEO3IxGtrItqdSK7j7EiC4BCCSLy+ezZJz/t1
         ayMl1dwhK0rr6V9JsgB8bra361NIBX2GK70+vCXtmgWXfz1K04IbnE8eVn6y46OYmdHd
         taXlLyJ29H5Xxxo1+MgPVlI/SOGOCR/+lG93EeaAHhstmUiw0/wqWSNl0gIHb3yZzDA4
         SAhCTi7wmqsfPTr0fKVb9ObicAhM7p5sn1Wo1N5AjOwAO8Iy1/5PmOPfF6Csqa6aNJ46
         1RJkouCYrUdEGbsJZPGGJuOC4luykzn0H6cF22JVmV9lxmcTkNIjuhhRmN++vYos6hBt
         l7tg==
X-Forwarded-Encrypted: i=1; AJvYcCXiSnAx2Oi6qhz0XDVd1HYAxGqzLx+HYn2aOp/WOJCB/20pixDUi5lxs95Dxivw0pXHE7An1mxTWKnPcOw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB/MTgMSQvwTZurs4uEserPQaYik1rZfC6voDZj2Kxxfd6DZrI
	ZcvDi+OJ0it+00YwrsDSdGYNbBbmT34dNZk+XfEvA017bM2SQiN410kEehEheVW1MnFIaxupdGL
	lkrbLkWZ6C3pcgEO/hg==
X-Google-Smtp-Source: AGHT+IEhwdMjndZFC3i4poKbvtH8lAHK/uqKnN/s5k3PNYjKW74EYSM43oKDyzJ/vCyOoq4uBwnRAOwSYQUOSV3+
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a05:690c:3746:b0:690:d536:27e1 with
 SMTP id 00721157ae682-6db44d4dc82mr11184727b3.2.1725953487457; Tue, 10 Sep
 2024 00:31:27 -0700 (PDT)
Date: Tue, 10 Sep 2024 08:31:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Message-ID: <20240910073123.2362028-1-vdonnefort@google.com>
Subject: [PATCH v2] module: Refine kmemleak scanned areas
From: Vincent Donnefort <vdonnefort@google.com>
To: mcgrof@kernel.org
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@android.com, Vincent Donnefort <vdonnefort@google.com>, Song Liu <song@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"

commit ac3b43283923 ("module: replace module_layout with module_memory")
introduced a set of memory regions for the module layout sharing the
same attributes. However, it didn't update the kmemleak scanned areas
which intended to limit kmemleak scan to sections containing writable
data. This means sections such as .text and .rodata are scanned by
kmemleak.

Refine the scanned areas for modules by limiting it to MOD_TEXT and
MOD_INIT_TEXT mod_mem regions.

CC: Song Liu <song@kernel.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

---

v1 -> v2:
  - Collect Reviewed-by tag

diff --git a/kernel/module/debug_kmemleak.c b/kernel/module/debug_kmemleak.c
index 12a569d361e8..b4cc03842d70 100644
--- a/kernel/module/debug_kmemleak.c
+++ b/kernel/module/debug_kmemleak.c
@@ -12,19 +12,9 @@
 void kmemleak_load_module(const struct module *mod,
 			  const struct load_info *info)
 {
-	unsigned int i;
-
-	/* only scan the sections containing data */
-	kmemleak_scan_area(mod, sizeof(struct module), GFP_KERNEL);
-
-	for (i = 1; i < info->hdr->e_shnum; i++) {
-		/* Scan all writable sections that's not executable */
-		if (!(info->sechdrs[i].sh_flags & SHF_ALLOC) ||
-		    !(info->sechdrs[i].sh_flags & SHF_WRITE) ||
-		    (info->sechdrs[i].sh_flags & SHF_EXECINSTR))
-			continue;
-
-		kmemleak_scan_area((void *)info->sechdrs[i].sh_addr,
-				   info->sechdrs[i].sh_size, GFP_KERNEL);
+	/* only scan writable, non-executable sections */
+	for_each_mod_mem_type(type) {
+		if (type != MOD_DATA && type != MOD_INIT_DATA)
+			kmemleak_no_scan(mod->mem[type].base);
 	}
 }

base-commit: 431c1646e1f86b949fa3685efc50b660a364c2b6
-- 
2.46.0.598.g6f2099f65c-goog


