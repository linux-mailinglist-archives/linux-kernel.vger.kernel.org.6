Return-Path: <linux-kernel+bounces-345833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E8498BBA2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 13:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F7731C237D0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 11:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670FF1C2451;
	Tue,  1 Oct 2024 11:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="nlqq2xPD"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.7])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA421C174A
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 11:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727783735; cv=none; b=u+dFoP/DWK79sQhfVegEqwERFQQaZE/PDSoi6CjKIdgTnmPjMwwhJ/ImvEq2c8rDK91doxJk8nfMFQIkfSv+z1QeU3YTMwqjJW0cCR18ISZNaT6BFqCDttnfENQ57BQ4Ofs8JibkfW7Q6bkKSQCEf5QC/ehZDHOobpz3/TebxHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727783735; c=relaxed/simple;
	bh=4/JvPSJwxHzsQfkEyhPwXWLx8AJoLCKUUqXbkxM87zI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HcuQ5liVyBtjOh5+fYbwLqEUOxPHKTH1Rf0LFlSbUpTY+oQsrZeDCpScMFI53EGk4Wt6LnFn5L/AAbAtCoaEN+fD2C6LAZDjMTppjkammSP/bjXEjNvNyHKf9ATvU+yAk5qduNqoVaG/r6OrBjRg+RBJMyf4GmFQlOoG/l+NugI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=nlqq2xPD; arc=none smtp.client-ip=220.197.31.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=MYHAm
	j9WCdZ7xul6Zal5KokULrSlZ1ePdhicswVKVFo=; b=nlqq2xPDS0/7oiXSTyrWf
	XSeOETzkxiE9KfGijcw6i13SNTjNzmVGhrIHvw/MyqDBrPL9zLB8S9zxLh0B8Kva
	Tg3HyWP2BewwKmUOq1ow1o39sLVkaXK4+C66tUFtQ3EBTec3kTS5f97AfBMp44QV
	jDn3xs7ugBvUK7aiN7ZK1Y=
Received: from localhost.localdomain (unknown [39.162.142.163])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD33yf24vtm4rdrAA--.18425S2;
	Tue, 01 Oct 2024 19:54:31 +0800 (CST)
From: Zhao Mengmeng <zhaomzhao@126.com>
To: jack@suse.com,
	zhaomengmeng@kylinos.cn
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] udf: refactor udf_current_aext()/udf_next_aext()/inode_bmap() to handle error
Date: Tue,  1 Oct 2024 19:54:22 +0800
Message-ID: <20241001115425.266556-1-zhaomzhao@126.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD33yf24vtm4rdrAA--.18425S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7trW3tFW5Jr48CFyxGF1rJFb_yoW8Wry8pr
	nxC39I9r4rKFyxX3y3Aw18X345Kws5W3WxWr12y3sakF4Uur1UGr40qr1rWFWUCF93Xa4Y
	qF4qqFn0kwnrAa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRg6pQUUUUU=
X-CM-SenderInfo: 52kd0zp2kd0qqrswhudrp/1tbi6Btrd2b7149naAAAsl

From: Zhao Mengmeng <zhaomengmeng@kylinos.cn>

syzbot reports a udf slab-out-of-bounds at [1] and I proposed a fix patch,
after talking with Jan, a better way to fix this is to refactor 
udf_current_aext() and udf_next_aext() to differentiate between error and
"hit EOF".
This series refactor udf_current_aext(), udf_next_aext() and inode_bmap(),
they take pointer to etype to store the extent type, return 1 when 
getting etype success, return 0 when hitting EOF and return -errno when
err. It has passed the syz repro test.

[1]. https://lore.kernel.org/all/0000000000005093590621340ecf@google.com/

changelog:
v3:
----
 - Change function return rules, On error, ret < 0, on EOF ret == 0, 
on success ret == 1.
 - minor fix on return check

v2:
----
 - Take advices of Jan to fix the error handling code
 - Check all other places that may involves EOF and error checking
 - Add two macros the simply the error checking of extent
 - https://lore.kernel.org/all/20240926120753.3639404-1-zhaomzhao@126.com/

v1:
----
 - https://lore.kernel.org/all/20240918093634.12906-1-zhaomzhao@126.com/

Zhao Mengmeng (3):
  udf: refactor udf_current_aext() to handle error
  udf: refactor udf_next_aext() to handle error
  udf: refactor inode_bmap() to handle error

 fs/udf/balloc.c    |  27 +++++---
 fs/udf/directory.c |  23 +++++--
 fs/udf/inode.c     | 167 +++++++++++++++++++++++++++++----------------
 fs/udf/partition.c |   6 +-
 fs/udf/super.c     |   3 +-
 fs/udf/truncate.c  |  41 ++++++++---
 fs/udf/udfdecl.h   |  15 ++--
 7 files changed, 190 insertions(+), 92 deletions(-)

-- 
2.43.0


