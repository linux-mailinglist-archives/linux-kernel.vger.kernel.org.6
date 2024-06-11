Return-Path: <linux-kernel+bounces-210156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B16B90400C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 17:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 038051C2224F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 15:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3093282FD;
	Tue, 11 Jun 2024 15:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="vPDSx2Zk"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A707F381AA
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 15:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718119944; cv=none; b=T0ryRrCtiKMIg3/akoOvsPJA5sRWlLrKbhvXD/L1lTUNpUf7/a3lcYHfS0FMpxF9wH+WJ88Rs4JT3ucay06LghjKdxRQ6chsTquqH36WEQIKMIYqgtrmhCr61apQQ/DtXdmws0RE0cKOl8PDjt3tbladV4gKDOtWWBT2C8eQ1h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718119944; c=relaxed/simple;
	bh=Waa2QxlIQGGLHl3qzRzioGmGSOteKlR9WJy0AE1RVn8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OINsxwi9U0vJsOc28f2Li/0O8aaaT69DKwBuXnbwBMaJvDtPpxw3sxgluzkEFBg2+w+wswkEqvOoM1krAwWLav/AubFSnNi8sTL5hl09OUBttGwXCF/Dqe0reoO0fEt3vIepKhCqYyUwZOvLhkrcM9qZsmfGvyM1Baz4tolqxpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=vPDSx2Zk; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6f8ec7e054dso940998b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 08:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1718119942; x=1718724742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4WBSjvhJreTEtepRDQegBl7/h1bqM/BuRQ3shzErAR0=;
        b=vPDSx2ZkGz3ipdjdz/1SvCvZ3wTHCbnkuE8p6Sq5EtpsiyivlEqDJvN0+31gxZkw/h
         Cck4KGkTStpcfQIsHZmMe9JBPG899YfiACbBAqNB0coTJV26iEsosuvziJ8XMnTtvi05
         5+iO7rlBs4ffZa4LwaSQ5GaoiZXj5bNhGa/QIj8gEStgdpYNUhk2oLL38unhMLgn9cjt
         kUln4XWvbSUUanW2FRVsomBIiJ628kVvW91PpEZNj7UAXQqlhuvWJ9z++2/zxExdu5j3
         cnzNt5G64L6bYHn3b8DMK+LEvVY4hHGLrAltDcbZf5nhGzWcOnPyBuHeao4uiTeYj+IN
         Rsqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718119942; x=1718724742;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4WBSjvhJreTEtepRDQegBl7/h1bqM/BuRQ3shzErAR0=;
        b=n+1HSKccsYvC6Z/j+6iN+YQ5FovpmRkSbVCrNgC33eAcdh29XjNB46iQ6bmEobYC5G
         e0sj/r/BDbJ6OxtzqJRhCpZ6bXX1Es0nFfsHpZWcAqDmkxADZ5bjUWz/e+FdCZ/N8GVV
         IIFZkicr1NfJzdrrNygXlc21uADooKPRQk6/2nVEgOHt91jg9G0sEuKNyUiH5X913b02
         d7ac6NezDJv7XAKObDhFBQEF2KDwfoJsstV++iiCtGGUxEFRrZunaeT6cKTMVzDuIdmY
         duSLXRecth8CHAVOE8uJEsNrHVOcycDL3c6h15fnUe7D7Q+X3SAKNqpp0p7xldQ7kKKI
         a74w==
X-Forwarded-Encrypted: i=1; AJvYcCXGaaSdDAxUk+Xolp5NfAAG0IWVWgdJCP8HhpfNzELq6jbUVZR/y+hDfQCaGZECEmBx2vBOc640g4fDXtCUUM8hfSykrNyuU55N5d/Y
X-Gm-Message-State: AOJu0YzZEHuRZUIgo2XOUuRkiWg4dXv1ISrL0HCgiRnq7Qr9rBPXMTEi
	eN5bwrhUbNeCS2XZFACrHWO6YKi9y1oElFiGIUmcjZi7CJw4U15jnvNki9SiIvI=
X-Google-Smtp-Source: AGHT+IGhdVFCWkzP2rSxEhKbT7GEv+zjGYeBIK0VmSu9eFx7L6rNmuaj3x/L3YiOdz87JL0HvO5Q5A==
X-Received: by 2002:a05:6a20:da86:b0:1b8:44af:daba with SMTP id adf61e73a8af0-1b844afdb4bmr4717767637.31.1718119942024;
        Tue, 11 Jun 2024 08:32:22 -0700 (PDT)
Received: from abrestic.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-704173684d1sm7094364b3a.166.2024.06.11.08.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 08:32:21 -0700 (PDT)
From: Andrew Bresticker <abrestic@rivosinc.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Andrew Bresticker <abrestic@rivosinc.com>
Subject: [PATCH v2] mm/memory: Don't require head page for do_set_pmd()
Date: Tue, 11 Jun 2024 08:32:16 -0700
Message-Id: <20240611153216.2794513-1-abrestic@rivosinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The requirement that the head page be passed to do_set_pmd() was added
in commit ef37b2ea08ac ("mm/memory: page_add_file_rmap() ->
folio_add_file_rmap_[pte|pmd]()") and prevents pmd-mapping in the
finish_fault() and filemap_map_pages() paths if the page to be inserted
is anything but the head page for an otherwise suitable vma and pmd-sized
page.

Fixes: ef37b2ea08ac ("mm/memory: page_add_file_rmap() -> folio_add_file_rmap_[pte|pmd]()")
Signed-off-by: Andrew Bresticker <abrestic@rivosinc.com>
---
 mm/memory.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index 0f47a533014e..a1fce5ddacb3 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4614,8 +4614,9 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
 	if (!thp_vma_suitable_order(vma, haddr, PMD_ORDER))
 		return ret;
 
-	if (page != &folio->page || folio_order(folio) != HPAGE_PMD_ORDER)
+	if (folio_order(folio) != HPAGE_PMD_ORDER)
 		return ret;
+	page = &folio->page;
 
 	/*
 	 * Just backoff if any subpage of a THP is corrupted otherwise
-- 
2.34.1


