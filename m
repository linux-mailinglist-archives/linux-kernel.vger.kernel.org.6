Return-Path: <linux-kernel+bounces-435945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 837599E7F04
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 09:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59D2E1883363
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 08:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59ACB823DE;
	Sat,  7 Dec 2024 08:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="K4M9MTnM"
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8933F18638
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 08:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733560239; cv=none; b=o/TtyYN3M5lubW2s0ARVe7RpYrGZWOAsRon5FPrg3KiAycAXOegYyjz78mtCZerCtMu/JPcvmqE7ZLaTmzQMsBNN0XUxUqynUDoIziw7WJQA4Yul7fwoOBrJeTARVCufHRUcynno7tamTG6B7VfYtq6YrGyPKP1fRnj/Fwe1kSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733560239; c=relaxed/simple;
	bh=2S7/DaKEliSnzmrQvHZAYewUM6sNj40Q0iNUFEZC/MY=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=BOB81w3MS/3tHGuNdO930EnqvwZhVjkxS2Vr9uF/v4KtFnHptWErLY3Fqq3KwtILEdv1cQJPiaVB/bwT0I/ScqZU5mW2sNFQ3RNJcuxcrArK53Vyi+Weipe06Ju3XVGImPYGavatj3xwJc68+FS+7EJT4gkkpeG8r9A2pV9wvnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=K4M9MTnM; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1733560230; bh=4FT9aoBqSWgDh8FZQc8D2XKhp892BywhCV8mEuevhtY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K4M9MTnMj2rKbLhVZCTt/tbdrLSsOGuEfTR86rO5rgzwvfQwOjqN6gDS8VgqpF4c2
	 TNhzP3yzBtsvE5ozAcTC3SDPC24y1st/ieDYV0arUlCrB/kY7rhu6Ig0G9hbV6ISAO
	 j5l5NCHTw3SdTTj7V098tN7wtV1BzQng5538T4iw=
Received: from localhost.localdomain ([2409:875e:a030:1001:14::e66])
	by newxmesmtplogicsvrszb20-0.qq.com (NewEsmtp) with SMTP
	id 449A50C2; Sat, 07 Dec 2024 16:17:09 +0800
X-QQ-mid: xmsmtpt1733559429tv5j8mwvn
Message-ID: <tencent_38F9530F8D11EC9B038B77AE97E73145DA07@qq.com>
X-QQ-XMAILINFO: MPRquJFDOUjCaHY5a7u0HPFnAdzYWm5MsO5pcMgTq56Tu4wMmK8yhVm8nREGag
	 R9jeN6K2CcOKeGCZYFAUECFdEAI+BvCAkBvvPPjoUj/WXEZNXNlNtT/+KSZGEfvmQED4n2QOl+Ul
	 TuWDiXfKEVPCfuWIhMj2Xq6bZhZtdfHPuqt6FuPC9E8R6wcV65zmYRvikZW+G/Vhnp9KMGCw7XtG
	 Vg3lwx4DPBJlNNtzkwmNqaK+00SCA1guL/rjp+LVdLy4dhtEzWc/idKikRt9NTcfIHVrLbnbzGYA
	 1BqzzNFrrvu9iMDiK5gSFbQgz9rVLQoIB8awbvcCNDgigiBDEcFpQguqqaCMpkfuXzllN1CDixBj
	 8j4ZKog7BTnQdeK/Lf93AI6pKJTQXxvBt5orZatvrPI6/7pqdA1P/7Jjona2JQg31GqJLHpnMyL7
	 lybcR1eAi2z43IFVUsOU319dDgqf8svQttIzibB3O0PBnRmkUjOqnidz/4B03BaYPWnGGAWS2V+d
	 /LYE3JT8gROCzn23Lg1ZAI8XZKNcs08FSi/m3dKx2X+p2IOYl9IrXAPRz/xWa8ernQb/Auybd0KN
	 1PopmlcvdO5O4nrG4HrJpNevHXRd4h+qTxtq4Pg8h9fwp7F2AwTB5a70l/mr2kBSGmUD/7R0NW52
	 wVGe2Rbimgy/s6n2c0jXuE44AqWs1LNDL6vDY+QKXRIMOCm+xCyaHOflf4fkHqoaCsyvXgvBpuok
	 vGZvowZkacXVCjhfHwmVyXNadxMKUhBZNzKWpnlFLkp58oOkL5ymsGj4l1QKd/ZHqNTn6ZQiSBHt
	 prxc+8FVMLDiceNfwwUsK/b5yqfLwufF1DdbbwxQUw8juHmCe+W8rHDHx5IKw3i3J6KvqaUd53st
	 l4IRAp0X14FaEb3tXUO/ByMasy2laoHSPTH46lep6zs9JuyUw7ZuTLzIAEfu7bzNYn7T794w5my1
	 6IPFDFubuWz5Z69nLtYg==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Junjie Fu <fujunjie1@qq.com>
To: akpm@linux-foundation.org
Cc: fujunjie1@qq.com,
	gourry@gourry.net,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	mhocko@suse.com,
	willy@infradead.org
Subject: [PATCH] mm/mempolicy.c: include pagemap.h directly
Date: Sat,  7 Dec 2024 16:14:30 +0800
X-OQ-MSGID: <20241207081430.1972561-1-fujunjie1@qq.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241206220037.5c0cd212d3269dd8a6f36e4d@linux-foundation.org>
References: <20241206220037.5c0cd212d3269dd8a6f36e4d@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks for the review and suggestion. I agree that depending on indirect
includes isn't ideal. This patch followed your suggestion and now directly
includes pagemap.h in mempolicy.c

Signed-off-by: Junjie Fu <fujunjie1@qq.com>
---
 mm/mempolicy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 88eef9776bb0..c3f25a7951e0 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -113,7 +113,7 @@
 #include <asm/tlbflush.h>
 #include <asm/tlb.h>
 #include <linux/uaccess.h>
-
+#include <linux/pagemap.h>
 #include "internal.h"
 
 /* Internal flags */
-- 
2.34.1


