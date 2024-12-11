Return-Path: <linux-kernel+bounces-440765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E939EC3E1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 05:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 865CC283D58
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 04:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384FD1BBBFC;
	Wed, 11 Dec 2024 04:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="KgV/78wI"
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E45C2451C0
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 04:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733890132; cv=none; b=MOkycjnBv6JT7ldmDOOICs5xf0u0wNlE/2f51aqLTfTJfdGG6MFyKKbxxDMm0NSqVOoEkIQlagBwAPEWkBv0EWT4heXGeQ47z9YTvqH397qadaqsJML/Rv0yPh/sVNS3ei+FsqECY4qhCavlkvwXbquNrI/k1Tgtet1rj8BhISI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733890132; c=relaxed/simple;
	bh=dozivQSECtHdJ5cGPUUriyKYYpEV7dFcvqkSIY2X/sY=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version:Content-Type; b=crRXSmWBt/7FjOsY0mYER6UplK9Pk5WcMKd9SBBRHtnpURQoonw8ijgi4xARAuKEY1vwV3OaKgokWa08OydRFYAaav7YjJ1mlc3KXa1GkEfbERTxb6Xgpq5nktDJ28hDjmLYa6WMDaebuHv6EKXIp7OpkwwvF4JEevcjYUnDPRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=KgV/78wI; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1733889823; bh=LkBoUmdBpLFzkj7kXBLhi46ju+g9LbQWgEQZgmD40uY=;
	h=From:To:Cc:Subject:Date;
	b=KgV/78wI9CtW4TNU6J8Amb/ISpPFpuqanNCD5JEkq6JzWGNbEdCtt14zXhiPf91uy
	 lUSOOfoeNgWVCN9KM4oK4X37jzENQxPOCms8DPF1QRS3MFLByHAr7ZOEvCCUNbQsyc
	 vU3r5hRKRwH8tX9zkrDMITchuKHL9k7kFT4iz5e8=
Received: from localhost.localdomain ([2409:875e:a030:1001:14::e66])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id EA164A2; Wed, 11 Dec 2024 12:03:42 +0800
X-QQ-mid: xmsmtpt1733889822tfxx3xs9w
Message-ID: <tencent_C12D22B8989E0314FDE7073D6446186E3C09@qq.com>
X-QQ-XMAILINFO: MaFEdJWNc83lhEh5TQ2KMz3IhgGLElsT4fP0hW61zMn3IQZqDJdfFBIWghAVUx
	 +IvHCBiBJAnKLmGGR8kA+mGYhl7QCxwTCEbGElzup+NxOzlbc1QsiUWGlZcz9eFndJJnABFx3lw+
	 MxM3mF/6tih7pEz7cCZhu3rWjigOEoBGYQ5rejspwWTr8h6+wD/n7/rWzqOnu2H8uuRjJe7cQffP
	 QPbzMNzttTAH85sj8HOu2zXeVTTEytMlRiIura1p5lxwfrEiIofF94Bq3EO7x0w2l/bNcb/5RrAr
	 Dop67Dmaz2uDOK0BQbH4RhlWQ/Dr30XGFAVGz/arTkcC75UtYFbtbaYFosomHJd1S5oCz6zZHRcv
	 +TNZVn0a4j2URmhqjyF2NgAQk1/t3v+OU2VsxPJBjSfOVSx6j1aDa673mhxg5lP9N9HPnASztZOX
	 nPWEVRMBSHG2Rmr1oh7pKlbyKjpiuW/+UTxiKuOZYPiFuaOBoKmUQmnaPu5VtwTHnPstp1aB/B8l
	 gpfrKzjDHRohLWSMrDuRtrOn6QX0WN3huZ1heYyn6fHdBJH2J0xvTdZVxPGEY3yRRas2NccRUhlQ
	 4QzvPA+ofblYszFJK8WNetZxD2YdyRFDQxQn+YizfjNHbzu1GRRxDZj8MSkhKcFtJ+v3bwaQg2Et
	 tXiipZTTFUB3xHp9WKsVNH7/GzFsZ6RBSNOrsAv+4ODNWK/4REzlpYcs93YSk5ymuzc/GVUiJIHf
	 vjaPabQxOzdnQuqsxqR27xbi+tpvSbrfegr8vTdKAvXXyfkHJY6kxVIQIufvlwABk7bAIsPoW7tL
	 cDaO1gpTwmyUd4LSggqVRclOUQHhgGwZbUMyqGRhmIlXOVLYVFd1p/h/wf8uqcxn+OvA6UiKYYwU
	 yiKYLl/VUN7P1DcF+G0Y1MokeIlvyksWopGpf2MqZ3a2qxGxTIwrhtNiKoUn4qtxOXX2BH61UR1Q
	 Nd5mX0yPbtdXcbjmMMXlNeOKNo3jN7HkBoWqg0WprmjH3d1lQ+pueL2zRm9zqvo5irkrascUEF1f
	 LMOToykQRURSE7uXZp7yCEjoxtx9uOJdC99kopnJbkRr0zGsUP
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Junjie Fu <fujunjie1@qq.com>
To: linux-mm@kvack.org,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	willy@infradead.org,
	sj@kernel.org,
	Junjie Fu <fujunjie1@qq.com>
Subject: [PATCH RESEND] mempolicy.h: Remove unnecessary header file inclusions with no test failure
Date: Wed, 11 Dec 2024 12:01:19 +0800
X-OQ-MSGID: <20241211040119.524324-1-fujunjie1@qq.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Originally, linux/mempolicy.h included linux/pagemap.h because vma_migratable()
was implemented inline within the header(linux/mempolicy.h), requiring
mapping_gfp_mask() function from pagemap.h to implement vma_migratable().
Now that vma_migratable() is only declared in linux/mempolicy.h and its
implementation has been moved to mempolicy.c, the inclusion of linux/pagemap.h
in the header is no longer necessary.

So the linux/pagemap.h in linux/mempolicy.h need to be remove. Since we
used the function of pagemap.h in mempolicy.c, we need to include
linux/pagemap.h in mempolicy.c.

It appears that the modifications have been completed, but there may be
compilation errors during testing.

kunit UM build errors as below:
    $ ./tools/testing/kunit/kunit.py run --kunitconfig ./mm/damon/tests/
    [...]
    fs/aio.c:525:71: error: ‘FGP_CREAT’ undeclared (first use in this function); did you mean ‘IPC_CREAT’?
      525 |                                             FGP_LOCK | FGP_ACCESSED | FGP_CREAT,
          |                                                                       ^~~~~~~~~
          |                                                                       IPC_CREAT
    fs/aio.c:532:17: error: implicit declaration of function ‘folio_end_read’; did you mean ‘folio_test_head’? [-Werror=implicit-function-declaration]
      532 |                 folio_end_read(folio, true);
          |                 ^~~~~~~~~~~~~~
          |                 folio_test_head
    [...]

FGP_CREAT defined in linux/pagemap.h was used in fs/aio.c, and the function
folio_end_read declared in linux/pagemap.h is also used in fs/aio.c, so fs/aio.c
need to include linux/pagemap.h.

Signed-off-by: Junjie Fu <fujunjie1@qq.com>
---
 fs/aio.c                  | 1 +
 include/linux/mempolicy.h | 1 -
 mm/mempolicy.c            | 1 +
 3 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/aio.c b/fs/aio.c
index 50671640b588..3c51c02631b2 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -38,6 +38,7 @@
 #include <linux/blkdev.h>
 #include <linux/compat.h>
 #include <linux/migrate.h>
+#include <linux/pagemap.h>
 #include <linux/ramfs.h>
 #include <linux/percpu-refcount.h>
 #include <linux/mount.h>
diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
index ce9885e0178a..d36877557b00 100644
--- a/include/linux/mempolicy.h
+++ b/include/linux/mempolicy.h
@@ -12,7 +12,6 @@
 #include <linux/rbtree.h>
 #include <linux/spinlock.h>
 #include <linux/nodemask.h>
-#include <linux/pagemap.h>
 #include <uapi/linux/mempolicy.h>
 
 struct mm_struct;
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 88eef9776bb0..c0c864b1bb67 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -98,6 +98,7 @@
 #include <linux/ptrace.h>
 #include <linux/swap.h>
 #include <linux/seq_file.h>
+#include <linux/pagemap.h>
 #include <linux/proc_fs.h>
 #include <linux/migrate.h>
 #include <linux/ksm.h>
-- 
2.34.1


