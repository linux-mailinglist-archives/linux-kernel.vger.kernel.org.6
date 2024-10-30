Return-Path: <linux-kernel+bounces-388732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3FA9B63AA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 14:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E9C41C20F02
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 13:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692421EF09F;
	Wed, 30 Oct 2024 13:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="AjeU/KsG"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E245B1EBA16;
	Wed, 30 Oct 2024 13:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730293444; cv=none; b=M5p3lTuqkRA8U0v9BKTUgmB/mhqJrkyvJtkQc1uXEFWGHa3Zq8eb6xM2CAkUfuEhWe3lv7gbGEyPkKKO1sC/RZ7tzz96sLGWhfrNc46faJ2Kzv9iOfjBVZp86mRq1iZZsIiT1AtCCM3A7ynghmTnNFWU35SaC/++GirdvUmPR+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730293444; c=relaxed/simple;
	bh=jtzBEiiVYmdNANE1VaGgB4AR5jbo2kyA1L+ao7NBWbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GHqQRV65IiRoQniBm0o95klP/IYXHLFIsYuk/Va+TDwsxTDvEFprme22cGTICqn4f2bR3rwRtdj9l+Hra91dWubYr4EaOhBMsGTQrzJg3vC0ULySz+RTIDmPCdMSRKEVLL0y/fcC94gP+Q0VBoPubfdcZiZwjnADGtQPgMIPd74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=AjeU/KsG; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=/lH6a4L8gtRKOjPZ3v2254wh73VRSysBe4phJD9CDEs=; b=AjeU/KsGJLU50JSiT7VnonXpVh
	xz162mpXuW5PYT8HVrkynl+V4L5bYQ6ExijZcA+EMXvKfT6YIV+MAjIQJ4gsHzbRp79rnDgZdjgsb
	upmm9Teb+VtHj3VcJHi4NtlEBRE+XnecY0G26vW2jhQrT4TW46nw65Ed5GVT1hZ9HKRRLCCsDEQ+r
	sG1XmQcd6BDGZj/lJXYm8hAt9NXjZDSs0ej2GO41/QQC6TAR+iUcAVhs1Tvrrpqfn0X1iC/EtyHWU
	/RRQGdXOMT6j6rTERDtWG7RAq5YMYsinIfXvvLRGEiuqPZf8FybhAvLw+F78ANejVw4Pj1uJ4n0LO
	l2zQmP5A==;
Received: from [187.36.213.55] (helo=morissey..)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t68MY-00H5h8-CM; Wed, 30 Oct 2024 14:03:50 +0100
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
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Subject: [PATCH v3 4/4] mm: huge_memory: Use strscpy() instead of strcpy()
Date: Wed, 30 Oct 2024 09:58:58 -0300
Message-ID: <20241030130308.1066299-5-mcanal@igalia.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241030130308.1066299-1-mcanal@igalia.com>
References: <20241030130308.1066299-1-mcanal@igalia.com>
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
---
 mm/huge_memory.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index f92068864469..8f41a694433c 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -989,7 +989,7 @@ static int __init setup_thp_anon(char *str)
 
 	if (!str || strlen(str) + 1 > PAGE_SIZE)
 		goto err;
-	strcpy(str_dup, str);
+	strscpy(str_dup, str);
 
 	always = huge_anon_orders_always;
 	madvise = huge_anon_orders_madvise;
@@ -4175,7 +4175,7 @@ static ssize_t split_huge_pages_write(struct file *file, const char __user *buf,
 
 		tok = strsep(&buf, ",");
 		if (tok) {
-			strcpy(file_path, tok);
+			strscpy(file_path, tok);
 		} else {
 			ret = -EINVAL;
 			goto out;
-- 
2.46.2


