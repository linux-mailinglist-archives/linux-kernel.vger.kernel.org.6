Return-Path: <linux-kernel+bounces-268069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8295942003
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 20:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F43A1F24CDC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 18:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05CCD18C92B;
	Tue, 30 Jul 2024 18:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZyPXR6Sa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDB918C91D
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 18:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722365462; cv=none; b=VawD4HgEbOD3mzLDzbY8mFPTzJxuWQv/h84Do/Znc2eRfZe2cm3XGK+h9wczo9gBVvNLmXwj2lkZPTkG9KUgHK4HzL6L8Ij7fgGdRfsGj824cdWN0x5mFBkA23m7+WAQ8GZ65uzd00xCVwfP4XBPjquqGAY3VZMXBFCXCi0rBiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722365462; c=relaxed/simple;
	bh=GszPI8ByV+1qtGMCf/91ybTKQ8raCzOdvtpEYU0MI+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M/SvurnayyAaBMRgFLK5HM+zvery71f26V6HBiNACZKMy5oPo9XwILk6N9DvWqzmgRL3fPy1vziEME5D14oGqCg2UP+jEzLZec+d5liOz+kkhVWPSX2uBXT6yz3De5MHHHH450AV3XeSoTlkgfVltbyx2jHsaopQmSF94fwdInM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZyPXR6Sa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F798C4AF0F;
	Tue, 30 Jul 2024 18:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722365461;
	bh=GszPI8ByV+1qtGMCf/91ybTKQ8raCzOdvtpEYU0MI+o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZyPXR6SaSqI0F9wenpqipaQ6eymbMTrxBfG7CUNsILMrxtXzoF59HoD/rB34noBng
	 GqC1WjTj4nSG3OFM2vk7pJsF7ZWFZjuhgUtVG4okRj51/vSKSZEz2wuuysJqSeEnBo
	 YTBnoYBeKDlmwBJFr1Afgwpj6W0t2MRMJ2SjM01JAhhm+SnVZFnAYFDXesiku/aQGT
	 lsF3giHR0Qb9pC7sgEx0Zxz5+L850wX3Dq0RJNeAXXHUV1pW2JYbtmsyDRZjpfx4ON
	 R36cynKzYELGkdyX4UfarNSz/i2FJtQC2TR1GoApn7mCnn6sv7/QY5BRHxFCIgu/Gb
	 cNV3RlUzrimGg==
From: Danilo Krummrich <dakr@kernel.org>
To: akpm@linux-foundation.org,
	urezki@gmail.com,
	hch@infradead.org,
	vbabka@suse.cz
Cc: mhocko@suse.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 3/4] mm: vrealloc: properly document __GFP_ZERO behavior
Date: Tue, 30 Jul 2024 20:49:43 +0200
Message-ID: <20240730185049.6244-4-dakr@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730185049.6244-1-dakr@kernel.org>
References: <20240730185049.6244-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Properly document that if __GFP_ZERO logic is requested, callers must
ensure that, starting with the initial memory allocation, every
subsequent call to this API for the same memory allocation is flagged
with __GFP_ZERO. Otherwise, it is possible that __GFP_ZERO is not fully
honored by this API.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 mm/vmalloc.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 6a2fef6378e4..48cc10dd06c0 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -4043,12 +4043,17 @@ EXPORT_SYMBOL(vzalloc_node_noprof);
  * @size: the size to reallocate
  * @flags: the flags for the page level allocator
  *
- * The contents of the object pointed to are preserved up to the lesser of the
- * new and old size (__GFP_ZERO flag is effectively ignored).
- *
  * If @p is %NULL, vrealloc() behaves exactly like vmalloc(). If @size is 0 and
  * @p is not a %NULL pointer, the object pointed to is freed.
  *
+ * If __GFP_ZERO logic is requested, callers must ensure that, starting with the
+ * initial memory allocation, every subsequent call to this API for the same
+ * memory allocation is flagged with __GFP_ZERO. Otherwise, it is possible that
+ * __GFP_ZERO is not fully honored by this API.
+ *
+ * In any case, the contents of the object pointed to are preserved up to the
+ * lesser of the new and old sizes.
+ *
  * This function must not be called concurrently with itself or vfree() for the
  * same memory allocation.
  *
-- 
2.45.2


