Return-Path: <linux-kernel+bounces-358743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81475998308
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 192472822D8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 09:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EDB41C2333;
	Thu, 10 Oct 2024 09:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="A8LhrUy/"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6261C0DC1
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 09:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728554312; cv=none; b=HTQa6gA9iTI/tYuctb1jZz4UzfOfo27DLMS1q0bE0qMKhwfhBE3hk0qFniMwNv0TAN+VwsxVR6jGWPwbCPF5jeoFeklbLZ5xP8OO7OhgcnccuWeZayt6OEhNU5NgiY6c17tl+lXBf2ft6ajfFt8fF8h6IfQfRanoWLjNLr16lL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728554312; c=relaxed/simple;
	bh=DHFw5q2YloFtaqbqYnA+n3xUeQwrKYdZTTMc6I80SuQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=khX2t1WgG9tvYtxE2Iuf3xRtyDu2IcdQED5Mtx2xkyyjnjAmQxoH2B/ai35GsaA50PXvC0nirw0ycDykpKhNUtCOJzRrLEdROgh927ltx2e1xorTWzTm13rq5FwdpRp4X3cvOn76Iyj8S2vaYSkP3P9rYHwqccREmIqtkyK86VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=A8LhrUy/; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728554303; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=TAqUYxnDAtyT0H6gtJz0ppazair4o9uzMNjBuGwGaBM=;
	b=A8LhrUy/2USDey0puPf9V5n74XjZquA/tmCUcu+ROxLj7M/ZcWxwJjSKxr0qb+GEUfrLu50w4Jfp2IAOmn0hOTQ+xpx14VvEdzfheEogI+mn164lAILwR2I37PzZJqqB19WlqpEGlX3+2i9rJ61QOlM4EjXVNpnPNzuQBoUXi60=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WGlzQYu_1728554301 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 10 Oct 2024 17:58:22 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	hughd@google.com
Cc: willy@infradead.org,
	david@redhat.com,
	wangkefeng.wang@huawei.com,
	21cnbao@gmail.com,
	ryan.roberts@arm.com,
	ioworker0@gmail.com,
	da.gomez@samsung.com,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v3 4/4] docs: tmpfs: add documention for 'write_size' huge option
Date: Thu, 10 Oct 2024 17:58:14 +0800
Message-Id: <556e9944f0328ccb0025e8582894ae01efd98842.1728548374.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1728548374.git.baolin.wang@linux.alibaba.com>
References: <cover.1728548374.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add documention for 'write_size' huge option, as well as making previous
huge options more clear.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 Documentation/filesystems/tmpfs.rst | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/filesystems/tmpfs.rst b/Documentation/filesystems/tmpfs.rst
index 56a26c843dbe..be998ff47018 100644
--- a/Documentation/filesystems/tmpfs.rst
+++ b/Documentation/filesystems/tmpfs.rst
@@ -115,10 +115,11 @@ The mount options for this are:
 
 ================ ==============================================================
 huge=never       Do not allocate huge pages.  This is the default.
-huge=always      Attempt to allocate huge page every time a new page is needed.
-huge=within_size Only allocate huge page if it will be fully within i_size.
+huge=always      Attempt to allocate PMD sized huge page every time a new page is needed.
+huge=within_size Only allocate PMD sized huge page if it will be fully within i_size.
                  Also respect madvise(2) hints.
-huge=advise      Only allocate huge page if requested with madvise(2).
+huge=advise      Only allocate PMD sized huge page if requested with madvise(2).
+huge=write_size  Can allocate various sized huge page based on the write size.
 ================ ==============================================================
 
 See also Documentation/admin-guide/mm/transhuge.rst, which describes the
-- 
2.39.3


