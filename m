Return-Path: <linux-kernel+bounces-184897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7FDA8CAD8C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 13:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 031641C22126
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 11:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563EF768E7;
	Tue, 21 May 2024 11:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GXrl8c02"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9874D763F0
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 11:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716292130; cv=none; b=KVPQn4uJah/I6+fMOkzkL2lIa8O+84QG6VizxLnV+OhFuAF5eICOYmqYv8TLjK4vT9sJ2N/Qa/5rOYH3bgOuzvT2O/lOiL7Sk9IJBtPq7DvxdDC5FwpNCt64VEaW5nrXLx43lucIN7hGUPLdnXxVRk6wcSWPInB2R1CH3E7TlzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716292130; c=relaxed/simple;
	bh=dNsU9/EzgA72vQ2DBRKYul88CUOKLAUu9MwoObC6yL8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jgiTmuceuJHaQAUTP2EtJnL/MbqTGi1LZ2GpPFHEGl11cmve4z58JUckR2iZIxv2ZhhzlWimmUUGOrD2S/yEF1GAUitRtVWf1O0JgU3f+0xxbnOD2wv86nwhu/1qqx/WepgyhpBhlVp51kvsF0ZCnqUm07qy/zWrKnETgvNMTUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GXrl8c02; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30B5DC32786;
	Tue, 21 May 2024 11:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716292130;
	bh=dNsU9/EzgA72vQ2DBRKYul88CUOKLAUu9MwoObC6yL8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GXrl8c02sxRhi+iEOVG7cmPLve4hs9PdvC3ifTK/0ZJ2fpiI1XBIM4f+Tw1XUK7oJ
	 E4gTG3lnIzNy0NnH7nrt/MisLxPNbNSdRPNHDns409n2DL9j/qql7OXIVmG+wbtrld
	 Kjm+nN8ILu0EkFtcEGiGNyfxoJyIGgCdRUFHFljWi+6cXzT8JsNglHSC1kyO0Gjzvq
	 TKOX/eyVGq0AbdiNIWzUz0oGDOjhKt/Mvsj09wXl9JKM00gjNZsK/YEwrBgqQ6GusU
	 /dOVij7LrrF21Q72kX1xKptNkdTTAiN8fiiWs98gKQJ3bmwiqITGgPQJChzVFnhp2N
	 k6bc9FLkN9NgQ==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: Alexandre Ghiti <alexghiti@rivosinc.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	David Hildenbrand <david@redhat.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	linux-riscv@lists.infradead.org,
	Oscar Salvador <osalvador@suse.de>
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Andrew Bresticker <abrestic@rivosinc.com>,
	Chethan Seshadri <Chethan.Seshadri@catalinasystems.io>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Santosh Mamila <santosh.mamila@catalinasystems.io>,
	Sivakumar Munnangi <siva.munnangi@catalinasystems.io>,
	Sunil V L <sunilvl@ventanamicro.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	virtualization@lists.linux-foundation.org
Subject: [PATCH v3 1/9] riscv: mm: Properly forward vmemmap_populate() altmap parameter
Date: Tue, 21 May 2024 13:48:22 +0200
Message-Id: <20240521114830.841660-2-bjorn@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240521114830.841660-1-bjorn@kernel.org>
References: <20240521114830.841660-1-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Björn Töpel <bjorn@rivosinc.com>

Make sure that the altmap parameter is properly passed on to
vmemmap_populate_hugepages().

Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
 arch/riscv/mm/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 2574f6a3b0e7..b66f846e7634 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -1434,7 +1434,7 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 	 * memory hotplug, we are not able to update all the page tables with
 	 * the new PMDs.
 	 */
-	return vmemmap_populate_hugepages(start, end, node, NULL);
+	return vmemmap_populate_hugepages(start, end, node, altmap);
 }
 #endif
 
-- 
2.40.1


