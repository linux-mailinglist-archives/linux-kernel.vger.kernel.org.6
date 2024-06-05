Return-Path: <linux-kernel+bounces-202142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA7988FC850
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 11:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6396CB239FC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 09:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705C318FDAD;
	Wed,  5 Jun 2024 09:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hqyx4qbp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B483114B093
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 09:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717580898; cv=none; b=HqSEo+eFvd0nArsEW0tkWCsBw+rWVsUd2LQ3ujB+O6ZCfW0og1EuiHso1QWf3SxbJk+vyMsehLJEwPIQCV7joYbFOUR0xvmzpVWW/MBsOFsJP/t6GywOVk5o4A1jK/6/VhL0EjZpZPmIN5yWQeXmu7VAPOFuPxuzqpQtgfpKNus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717580898; c=relaxed/simple;
	bh=H5TT0W89gkFgRO4p1LpEpFm2+mHkOB1T7hF2dgtWVhc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=saKZiajmQrG9r7QJeA4X0BjWFukEUxxQ77XwdV6uyWWRjZo5jJA/+b4YoO5MI6St3t2p4TS4OokRkXNtBnE6MzUYD1QTD/oi6sPFU6L5HyMlpylYfnhDSHcKhLCnjOh2hPGBb49p+NNtd20xCOvKXazNG30MG4CbrKzPw++CV2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hqyx4qbp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAD07C32781;
	Wed,  5 Jun 2024 09:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717580898;
	bh=H5TT0W89gkFgRO4p1LpEpFm2+mHkOB1T7hF2dgtWVhc=;
	h=From:To:Cc:Subject:Date:From;
	b=hqyx4qbpaNNhWJYB6Mi3oYuOjsTV+U6K5ROXZ4OVTgHogSokk0qrl5OWGtoUvC+lQ
	 AplQ+lWnwqaELPRSz2Uz0C1xMmE71OFjKbDcnPITfKGZ4nElXQAfFkgwogVxskQ+p4
	 YWGiafS+jMRO6JNulFol5+CQpFHwhaL+7O6b6ydTcN+Y69GOh3GWra/mszoNlrW71n
	 u2dQ7s3PuEj1sGf4Vtj0dVPG5FLOWDISoIPi6WyInU2aFryQGmbM6LKI06WwlOVQE6
	 EIReqbiv9xzaHzQOSSTrOGmrAkKvLd0R7GoVZTHPXXCBkFjq5CEDp097feerGpXzm7
	 puVzKXd460daQ==
From: alexs@kernel.org
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	izik.eidus@ravellosystems.com,
	willy@infradead.org,
	aarcange@redhat.com,
	chrisw@sous-sol.org,
	hughd@google.com,
	david@redhat.com
Cc: "Alex Shi (tencent)" <alexs@kernel.org>
Subject: [RFC 1/3] mm/ksm: add anonymous check in find_mergeable_vma
Date: Wed,  5 Jun 2024 17:53:01 +0800
Message-ID: <20240605095304.66389-1-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Alex Shi (tencent)" <alexs@kernel.org>

We do vma_set_anonyous in do_mmap(), and then vma_is_anonymous()
checking workable, use it as a extra check since ksm only care anonymous
pages.

Signed-off-by: Alex Shi (tencent) <alexs@kernel.org>
---
 mm/ksm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index f5138f43f0d2..088bce39cd33 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -742,7 +742,8 @@ static struct vm_area_struct *find_mergeable_vma(struct mm_struct *mm,
 	if (ksm_test_exit(mm))
 		return NULL;
 	vma = vma_lookup(mm, addr);
-	if (!vma || !(vma->vm_flags & VM_MERGEABLE) || !vma->anon_vma)
+	if (!vma || !(vma->vm_flags & VM_MERGEABLE) || !vma->anon_vma ||
+			!vma_is_anonymous(vma))
 		return NULL;
 	return vma;
 }
-- 
2.43.0


