Return-Path: <linux-kernel+bounces-392606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC559B961D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 18:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3EE91F220AA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 17:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D05A1CEEB2;
	Fri,  1 Nov 2024 16:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Hd0ON5do"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CA11CEAC6;
	Fri,  1 Nov 2024 16:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730480311; cv=none; b=honlwL82VmJxq5NbSLTRc+dU7Bcx+thKgIT8totRdf86zd2kAt1CQpgAS0Zgbk2zxhICMAek9maSM/v7/BR5E6yNnWG+yIgO2w0zyeaMveRp6CcfqmIlt6mqItwjF2kjYGF6TbwSVdfyF43THcLmiw+8ylNhYx0iJMqAsDApsaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730480311; c=relaxed/simple;
	bh=41oDt2C/swzs6nM497WHORhY2ywQ2dohkwZWzDrJpxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cph1XTfWa3AmTB0SPcXLnBtuut4+IFZK8CcbN/AhZxaGQP0q3PRlHjsLbf7+adKUWN4qPMR/HO9PJacDxPyHurXzL9yQu2G4LcGpnJ+92+4j+7Wkj5sPYpAXNTq88vZxoFBXgVRxr3i2vuYy0nB5Zlm+IVAjPL10iGhT6FHVwis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Hd0ON5do; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=SzEBSUiqX9q6QOwH+3lfpF0a+846J9p9dlVHwog/yj4=; b=Hd0ON5dofM+K8sGFGpSRovkF3c
	FpYVxRSX8UhzNY0CqbcP+N9S74zKJ2vyl75TGIaexlVAudkVi32l77OhZLN+3H5A/5IUAo/xZUQW4
	eXV4ypO5+apa0WBZJSGTeR8MJN+X45kCACF633xB4uJnmGCOZlafw+2wSn3yXxiyqQ/YnxAYuJsux
	E3h6yC+Xk2StrDO5W3tT3vmk/4sljHnMEGgIPSpzX/9ZYK4SnhaoOK5gwoB8PCoW2BABBcwS/8A8I
	Tef0giUQ9VqWFBKuSrsrAwtxOR2nCn/rmP/gGptZUZ2/Sf1EwRRpIuTwJChaa3wyMEIEcDN8ypOV0
	CTQDricw==;
Received: from [187.36.213.55] (helo=morissey..)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t6uyX-000VPu-N0; Fri, 01 Nov 2024 17:58:18 +0100
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>,
	Barry Song <baohua@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Lance Yang <ioworker0@gmail.com>
Cc: linux-mm@kvack.org,
	dri-devel@lists.freedesktop.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Subject: [PATCH v5 5/5] mm: huge_memory: Use strscpy() instead of strcpy()
Date: Fri,  1 Nov 2024 13:54:09 -0300
Message-ID: <20241101165719.1074234-7-mcanal@igalia.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241101165719.1074234-2-mcanal@igalia.com>
References: <20241101165719.1074234-2-mcanal@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Replace strcpy() with strscpy() in mm/huge_memory.c

strcpy() has been deprecated because it is generally unsafe, so help to
eliminate it from the kernel source.

Link: https://github.com/KSPP/linux/issues/88
Signed-off-by: Maíra Canal <mcanal@igalia.com>
Reviewed-by: Lance Yang <ioworker0@gmail.com>
---
 mm/huge_memory.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index a6edbd8c4f49..1ebe18ec4560 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -969,7 +969,7 @@ static int __init setup_thp_anon(char *str)
 
 	if (!str || strlen(str) + 1 > PAGE_SIZE)
 		goto err;
-	strcpy(str_dup, str);
+	strscpy(str_dup, str);
 
 	always = huge_anon_orders_always;
 	madvise = huge_anon_orders_madvise;
@@ -4167,7 +4167,7 @@ static ssize_t split_huge_pages_write(struct file *file, const char __user *buf,
 
 		tok = strsep(&buf, ",");
 		if (tok) {
-			strcpy(file_path, tok);
+			strscpy(file_path, tok);
 		} else {
 			ret = -EINVAL;
 			goto out;
-- 
2.46.2


