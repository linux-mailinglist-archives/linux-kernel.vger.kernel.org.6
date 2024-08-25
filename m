Return-Path: <linux-kernel+bounces-300591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D0595E593
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 00:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 781E0B20F7C
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 22:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE1F768EF;
	Sun, 25 Aug 2024 22:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MLkivtSW"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4A447A6A
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 22:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724625769; cv=none; b=S5+DCBpfgESXSzdYtslWudCr1yxSZjjjOuHlUfLQtAZiAzaHG+3G+9ahlRWIBWiOEr8d3ogBxK9B1cwE4HAoL6zc7l9e+e4wMxPxr8KsSKtJrG7xJc1Dgss6H+1FsDbwoh1Jy51kh3Ct1VvZRrHtNurJHWLipwGU5TkxnuLhUGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724625769; c=relaxed/simple;
	bh=uZnQzlZJslSibUauQgkTs7hu2kmRwa/XGHZMpjqG0Jk=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=rq6CPshrE4J22BAiBbDol1knsLV/fZr0aEEMScROnKla3t+0oiVL65E71VkG+1Vv76JZRUdymNSMWlb/kcabnVHPh/6Vl3o8AyBANjG7InrzjCavp66DVrrRpWTVVasaeMYDPWyHDTgQiAwUW0zKbS5Kpoejb0/JyGdSeROY1Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MLkivtSW; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7141feed424so3036644b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 15:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724625767; x=1725230567; darn=vger.kernel.org;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0rBvHDWVfkdQt9ZpCo+KYmKH0Q02QEi1n33koP6jBAs=;
        b=MLkivtSW1hCD/WBsZvx3p2F5m44Lcxu9ThLEd6OISC9KN3y8dNfrw9jJcTx3PtG4Ou
         wXyZeMGzKNlCAsBVDxbnxMcIuEF0LW+a/Nt1IC97Itaj5ZNH/fIDvqX2CbW/ulqz92/d
         PjAp8QpsYevRhbHF96Rfg1bs24Zi55Om2bT0FFCZnxHyrOq2Anhum2IohiwJt0TNsdFr
         r2mi4GCux7gAIsXJZJM6TE9frYbGBZJei8BwfvGdVLje4i7xFCOmAzg79fQ7bUBJYtM9
         LIJWJVaq7Lu4nWR16tdJNpwXtI5jzkZl49JuwY0NKrwKzCo6rVEd1Lkh8UFZ98eyy0mO
         8dLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724625767; x=1725230567;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0rBvHDWVfkdQt9ZpCo+KYmKH0Q02QEi1n33koP6jBAs=;
        b=BZnQCm3tadAwbNswoRJ+Gf9YI70scd32H5GKTBCB8+jWQHENDizKdRuXtq2g/LhLTi
         +/4uq0Z7hBHU0WieztOHmzcqb+3Lrmb98vS45CaL4VK4baV/h/BJcQDN3Eo44EHBleKf
         Ge96lahFG4lYVsKYHpW+P2SsjAcLZO7dFcsZGGxuizG4HSgIHlBn33meAXlkH08Q1VzD
         h5xINIS6HLG/VTn7VCjWIdZB38XzjLvpFIq0QFjeNXziP91zKgRlk8J2M+129SlM3Jre
         MEuBQAi5ww1ZUnUUCUDFdar6soL7oNTkoAkFMWHAi7ba/UCsnUuvDiWc/2i2kaYGMxyy
         I+qQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDp+T9vbvY94bdrgSDEfnrt0/UXzfOkAeFXvJF5t+pA8v+Nx64yrKpRrliwd+9FqEKuooeZ1NlhCWR604=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9Tmox7JaDIxM2IEbxVi1HQnLxKHcNpGDXVOF23pQ+nHBuky8A
	n577NplhUORCFxTORprPT/x0c7jmuMzlm8dve70FmsNKgHo5f1D23ZDSl5foldNVZzKMkz804oC
	7Cg==
X-Google-Smtp-Source: AGHT+IHJwZpY6lEHZ/ct9FFk8qm5lFxEP/XcocOCIhB7oCMa+mmuyaBprncVdk8yfSnsFc5hznBgYA==
X-Received: by 2002:a05:6a20:9e4d:b0:1ca:db51:85df with SMTP id adf61e73a8af0-1cc8b419fe7mr8650270637.8.1724625767042;
        Sun, 25 Aug 2024 15:42:47 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d613b2048fsm8379942a91.54.2024.08.25.15.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2024 15:42:46 -0700 (PDT)
Date: Sun, 25 Aug 2024 15:42:45 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
    Baolin Wang <baolin.wang@linux.alibaba.com>, 
    Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org, 
    linux-mm@kvack.org
Subject: [PATCH] mm: shmem: fix minor off-by-one in shrinkable calculation
Message-ID: <d8e75079-af2d-8519-56df-6be1dccc247a@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

There has been a long-standing and very minor off-by-one, where
shmem_get_folio_gfp() decides if a large folio extends beyond i_size
far enough to leave a page or more for freeing later under pressure.

This is not something needed for stable: but it will be proportionately
more significant as support for smaller large folios is added, and is
best fixed before duplicating the check in other places.

Fixes: 779750d20b93 ("shmem: split huge pages beyond i_size under memory pressure")
Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/shmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 85e3bd3e709e..37c300f69baf 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2326,7 +2326,7 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
 	alloced = true;
 	if (folio_test_large(folio) &&
 	    DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE) <
-					folio_next_index(folio) - 1) {
+					folio_next_index(folio)) {
 		struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
 		struct shmem_inode_info *info = SHMEM_I(inode);
 		/*
-- 
2.35.3


