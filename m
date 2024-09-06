Return-Path: <linux-kernel+bounces-319145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D5096F879
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 17:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CE74B223EF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 15:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7011D2F65;
	Fri,  6 Sep 2024 15:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KsxQ5fGg"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801A11D1F60
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 15:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725637153; cv=none; b=VViF/2MW7h/VQSNAYhFP68SF0caHp3fepKOGY1P0f1u1dWvZemb/69dlEaMZryml2ABUpXfJ35WlzLDD8lvCSfKrdMqrxLmVlb6VIPxn8xC7yBNcIEbgUWKuzO0ZlAV/IwS4b5FN/3f2rwlegaML7j7F3usBCwRtGBrJ6FE67I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725637153; c=relaxed/simple;
	bh=2jh/01CfLnopoQeSXGKJsqfnsL69ZiVOPbdq2jRahuo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=oVrLz515wCKzHdzSHNzWxi0GBch4uhMdLfCblD6QLyQYg/MsK6IpWLt6J6qP4JvZXX93/6FwxL/JYDrY9N3kgnLbXGTIx/nRGqs7MJh2Ffa0OPqwb/RZj+mRSEQOeE6UuVrjygIIxpDW7d7EJOuhuP4PMTU/ajzs7t60/5D4zaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KsxQ5fGg; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-42c7aa6c13cso17160585e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 08:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725637150; x=1726241950; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=l1G2pbBlhU/iZ8tD3PYYP6to886D/6DLgSYjjguX5Ac=;
        b=KsxQ5fGgWNSeiSjuDZ0o3F/nqLH3d/iUs+nD7cZtxintAd+6L1n4h0vk7Ai05u3lFJ
         XamiXRi8lp9M58tvkwLBBKRmmnL7ejI1CqRuWZraFRKzu0+TfGYBE+w1rVIoLs9ar2+3
         gLWrJKymLVOpv/wavjQ2WVJXKpIyKb+cEhzQjWk6/XnPqc9M/2QIbXUdW9YWfIKm8cBd
         pSn55mTtgcE6SMele5JEZnrfCLbykml40AMieceUJ9wpM20ZYG/HKxWUPeIL2J3PFJv/
         /zMHN6dA5AzuQGZ4JKNRhgbVnPvzW7tuEbXqqNaok9/Vsc+QEdtpKAvQq/lHu4dOvzcG
         E9eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725637150; x=1726241950;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l1G2pbBlhU/iZ8tD3PYYP6to886D/6DLgSYjjguX5Ac=;
        b=A3PJjvi7ndzAj8wjLu4CDsAxZAu1PnEQnzIUS3gdQPg9sD5HLw3WzOK29578xNGIjL
         u1VcSvezurpf/UvKbSXBmhEccW/xh2eLVTjuGukDHvEMbIyogPXALvpm5YnncCbvaTbZ
         S2xT3vVtr6SyWNxlx9WEq7aNlrgiURuVLxJxg/tsVxSoaCB7Df+8N0OgPm7IkJx2nWOf
         XWd4WHOGiVgHw0COUBLp3kEkl1XtqeSDp/zr2hbW67inVOIntaHO5xqD441J+JmlGXBM
         j4KYanUJ27iEyEC6UVVi1wiqaYJ+8XrEU2S4IHDGw9Xx03s7LjLsqMkdBut1lwy1RC/u
         0alg==
X-Forwarded-Encrypted: i=1; AJvYcCX4sNaWM12W+KsFLnc7vMakcPQJaJygwXJ4KUtabu7j1tsHPMvvj/GA8ZCnJ9H5gp8CZvG+yJa1PCgzptQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNCSw89G7H7MsvwvFHEceE/2H3IiViJbSKmH09DKVSqjKLFCMJ
	HppCqwyrTOeQ/Ei+XYTS0ypA1tDPJMDUj0L2MxbvMdkhOFpPNPs/+FIp2B76M5o0RZC/pKExDWg
	5p67MKs2WIj/TPcelyQ==
X-Google-Smtp-Source: AGHT+IHRgpRfA9wWGPNKBGJ1EpsCPd8fYk0bzFkXnFVuKk/Kp0hTKRqbseKsP6yFCnPhy7nQ7gyyqmlkmkShS2wo
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:adf:f8c2:0:b0:371:8b81:b4ed with SMTP
 id ffacd0b85a97d-378896b14a7mr3241f8f.10.1725637149839; Fri, 06 Sep 2024
 08:39:09 -0700 (PDT)
Date: Fri,  6 Sep 2024 16:38:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Message-ID: <20240906153856.22204-1-vdonnefort@google.com>
Subject: [PATCH] module: Refine kmemleak scanned areas
From: Vincent Donnefort <vdonnefort@google.com>
To: mcgrof@kernel.org
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@android.com, Vincent Donnefort <vdonnefort@google.com>, Song Liu <song@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"

commit ac3b43283923 ("module: replace module_layout with module_memory")
introduced a set of memory regions for the module layout sharing the
same attributes but didn't update the kmemleak scanned areas which
intended to limit kmemleak scan to sections containing writable data.
This means sections such as .text and .rodata are scanned by kmemleak.

Refine the scanned areas for modules by limiting it to MOD_TEXT and
MOD_INIT_TEXT mod_mem regions.

CC: Song Liu <song@kernel.org>
CC: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

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


