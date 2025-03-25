Return-Path: <linux-kernel+bounces-574665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C04A6E83F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 03:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F15B189684D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 02:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4977156C79;
	Tue, 25 Mar 2025 02:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="UtKZfQw1"
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744F514A62A
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 02:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742868329; cv=none; b=i0zcFVqCcIaJ6drxBuBr98qg5UjV3X7pQnwMYDcmjsrGvvbFo8oSD8653h+NW/2cOANEmt9jgKGx0Qp4ZLoI2QF70z0RZJzafpT85dXVe+aWurTXlqt111bZHB4cpjUTFq8bHRoGuG39nlpZrR4tvxyp3VgCaWxJrjoGzE+479Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742868329; c=relaxed/simple;
	bh=749guTHReJ43QAYjWO2kY5aXsr/i1vmJXJpGgWaiEQ8=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=CrYs1XLg6HK/T/WRVhR1hsbp4PQ6B9sHRwXLxdcDEMhsm0/lE38Kh5LBTXPCROMyuroO9a9WvpG/SsRTtz0dEgPmk6H+BEdodI8AWbfB2BUNmYlIfvuZmBqesu+q/WXCnSqw5P+CXVEqNkOR9VYsTW/Lx2z5E3WufRj0Q7Acm3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=UtKZfQw1; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1742867962;
	bh=RXn3xdJvOCi1AozfgFkFj4o3yXrTvkZNmzS4EXmbBUQ=;
	h=From:To:Cc:Subject:Date;
	b=UtKZfQw1RVjVpG5S6oo0/dKOV9ra7P7ijClM6+pD8x0QWioj4ecYHV1TV2B+Ne6AT
	 foJ4V5e6DmcrBxqd0HTAqplVG8/CFQNjaytOG5k4hJExxpCqG1G4nK5teyGBs1Zp5E
	 WXl+6E33T+1Q3L05Mn1D37MoTu+/9sMdvt42Z6E4=
Received: from localhost.localdomain ([116.128.244.169])
	by newxmesmtplogicsvrszb21-0.qq.com (NewEsmtp) with SMTP
	id ED53A8FC; Tue, 25 Mar 2025 09:59:21 +0800
X-QQ-mid: xmsmtpt1742867961toj6rqhl1
Message-ID: <tencent_E59F5CCD55B9EE47D4712F517941BE78A50A@qq.com>
X-QQ-XMAILINFO: MAUQIEZVArhLcsV+j47LpxeFdXHP5qIdsW9xmY4ED+rvNEPHM496DxWsBSA8K9
	 02T0kJ4vypRFyQM+apKFzc2fYoSZXadA23zboIy5WPbUIC3GskQ0fMdc6dGqR2Szdv4lg3u0kxWg
	 3K6m0EwPscmSzvXCKrRhPyBTGbj/36apMJy6yFwrKegsQDUHe8O6IISW6h/Gx+n3IOBlfCQ10pSv
	 z8PmBvKhH9mvivCmzRbKeyOEzHWmqRDik7YWgQlf00m9/XMif/39KVy8SZ/tnIcC3GoriG+bHM5b
	 OzmEMDDxxzZHXaUPtrSH9V1JKdlLkFgmzLLSXR6d7TFuNh5zPLDB1sBPBYVEpjlstjhckF12wR8P
	 bT8Vbv+Y+ieYmM4DI5CH2UppPmfv4NZw/X+Jo6p73b+YAZOmjaobL4ftsAwglxy0hLG8HsOoBctl
	 gtrLrU2pIJDZmg0tBSo/rPn4H9fY40jPlnuOzpg7rKO17BYoTBnmd68ZzRoE4+kXTs/YA/ebkO2K
	 WW3O3eu5Nh/UEP++JQig1yn3KzsUHmWyY6ZbvBlxFBu2LZA2m4CAiauDOqKC4LrNv4SfZt58vcxK
	 iQR9GLy+tuJE5dKcQJWmSkfnZXBGhTFYgwglHaQzwKYoROtbMpREchnIuf3OaUIP29T7SqgiJaZV
	 Wv4/NG8xtV7W6jDD8KiBTS5w9S70HwjMIJN9/xtyTpJztkNFrKu9SkkjpZsYK3/BVgnU8/0p17F2
	 p2S47JM2fnUkVqclOcOd1KljBZ+iQgwr80YLbOSZIQ+Cw4glGQW4hQxiqS4wyZDyr5YVY2ihWhcf
	 10imUH8sigXFT/RO9hG6vYFZgax447QA0fFRwvD4xmh34UX2flHMfuBXid8P0ifDWYBIOzZGIu09
	 lPzuFRkPAcpUhDHS0JGGao3V9JLsIINWMR4Itv7Loae9J7Hw8NUPRHeBMFdm8CD1FHhPWgWPDMxu
	 wdibJAusRc24WDWJ8ZfFTONljA/bJOufVsnc8M38o=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: xiaopeitux@foxmail.com
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	yuanzhichang@hisilicon.com,
	john.g.garry@oracle.com
Cc: Pei Xiao <xiaopei01@kylinos.cn>
Subject: [PATCH] logic_pio: Add detailed comments for find_io_range() and logic_pio_trans_cpuaddr()
Date: Tue, 25 Mar 2025 09:59:19 +0800
X-OQ-MSGID: <b831fcad2e4f9f896f32a1890ae067718486bae6.1742867249.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pei Xiao <xiaopei01@kylinos.cn>

As a library file, every function should have comments,so add
comments for any functions that were previously overlooked.

Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
---
 lib/logic_pio.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/lib/logic_pio.c b/lib/logic_pio.c
index e29496a38d06..3a49f424acc0 100644
--- a/lib/logic_pio.c
+++ b/lib/logic_pio.c
@@ -138,7 +138,15 @@ struct logic_pio_hwaddr *find_io_range_by_fwnode(const struct fwnode_handle *fwn
 	return found_range;
 }
 
-/* Return a registered range given an input PIO token */
+/**
+ * find_io_range - find a registered range by PIO
+ * @pio: logical PIO value
+ *
+ * Return a registered range, NULL otherwise.
+ *
+ * Traverse the io_range_list to find the registered node for @pio.
+ * The input PIO should be unique in the whole logical PIO space.
+ */
 static struct logic_pio_hwaddr *find_io_range(unsigned long pio)
 {
 	struct logic_pio_hwaddr *range, *found_range = NULL;
@@ -204,6 +212,12 @@ unsigned long logic_pio_trans_hwaddr(const struct fwnode_handle *fwnode,
 	return addr - range->hw_start + range->io_start;
 }
 
+/**
+ * logic_pio_trans_cpuaddr - translate CPU address to logical PIO
+ * @addr: Host-relative CPU address
+ *
+ * Returns Logical PIO value if successful, ~0UL otherwise
+ */
 unsigned long logic_pio_trans_cpuaddr(resource_size_t addr)
 {
 	struct logic_pio_hwaddr *range;
-- 
2.25.1


