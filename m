Return-Path: <linux-kernel+bounces-340476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A9F9873DC
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 14:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BA2F1F21B63
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 12:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1F118B1A;
	Thu, 26 Sep 2024 12:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="at/y/ri5"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351B1288B1
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 12:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727355217; cv=none; b=F3rkYrPOI/6SPja26xsZT8Uxg5BYvCWG3roAmXITunMDaj6Qg9fkpiSfI471vYgJB6RZtS4TJSsEX0gjVuWpmAAiJvLYtRYDu4K4cfVt/TWrnFTHzALxLwkN+maUWqiNW49yGLACauENhyin3p5drI2iEnLOlmk6zM2l8T3ibpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727355217; c=relaxed/simple;
	bh=T6AHcfzLiDeEYCiLsEpMeU6oCp+uXALgGuNWvnmWFko=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IL3NRitg5zYEf1x7fsQLee5BG8f3uiOPURiou939UVstiob0fh9ExhEws3qG1ZTMCCAnmg6ZKxInJ1xFORye8MpucRvKLkq3BaI8Fwyug0liA9+Y97qJZAgyBltf2/7soZSLo1GZTDVVdqCAN5xYdkxz6WmpErC193eOKC/RDCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=at/y/ri5; arc=none smtp.client-ip=220.197.31.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=uo/CD
	wD28iFk6b8sBmYv9zjeQaZmqCenGqV1I0a6BIY=; b=at/y/ri58UmlA1PQvttGJ
	Cf4US/STzjhwSudfkuu9b91JO9uXvNEqwp5n1drcWiFgzbiutnku48fpgAosu/hC
	UNTezfx3R3dEGMcvnBwpKil6vSNlFaeDtyIecNYdNNcCMX4PttkGGXi7cboPFp4b
	OYnLmsd6+33z+YfoLgB8ho=
Received: from localhost.localdomain (unknown [123.149.2.202])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD3P+ihTvVmYf4FAA--.19120S2;
	Thu, 26 Sep 2024 20:08:01 +0800 (CST)
From: Zhao Mengmeng <zhaomzhao@126.com>
To: jack@suse.com,
	zhaomengmeng@kylinos.cn
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] udf: refactor udf_current_aext()/udf_next_aext()/inode_bmap() to handle error
Date: Thu, 26 Sep 2024 20:07:50 +0800
Message-ID: <20240926120753.3639404-1-zhaomzhao@126.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3P+ihTvVmYf4FAA--.19120S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7trW3tFW5Jr13ZF4fXw4fKrg_yoW8Gr48pr
	nxC39Igr4rKFyfXrW3Ar18X345Gws5Wa1xWr12y39akFWUuF15Gr1FqF1rWFWUuFyfXa4a
	qr1jgrn0kwnrAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UFNtxUUUUU=
X-CM-SenderInfo: 52kd0zp2kd0qqrswhudrp/1tbi6Almd2b1Sv8njwAAs+

From: Zhao Mengmeng <zhaomengmeng@kylinos.cn>

syzbot reports a udf slab-out-of-bounds at [1] and I proposed a fix patch,
after talking with Jan, a better way to fix this is to refactor 
udf_current_aext() and udf_next_aext() to differentiate between error and
"hit EOF".
This series refactor udf_current_aext(), udf_next_aext() and inode_bmap(),
they take pointer to etype to store the extent type and just return 0 on 
success, <0 on error. It has passed the syz repro test.

[1]. https://lore.kernel.org/all/0000000000005093590621340ecf@google.com/

changelog:

v2:
----
 - Take advices of Jan to fix the error handling code
 - Check all other places that may involves EOF and error checking
 - Add two macros the simply the error checking of extent

v1:
----
 - https://lore.kernel.org/all/20240918093634.12906-1-zhaomzhao@126.com/

Zhao Mengmeng (3):
  udf: refactor udf_current_aext() to handle error
  udf: refactor udf_next_aext() to handle error
  udf: refactor inode_bmap() to handle error

 fs/udf/balloc.c    |  22 +++++--
 fs/udf/directory.c |  23 +++++--
 fs/udf/inode.c     | 155 +++++++++++++++++++++++++++++----------------
 fs/udf/partition.c |   6 +-
 fs/udf/super.c     |   3 +-
 fs/udf/truncate.c  |  41 ++++++++----
 fs/udf/udfdecl.h   |  18 ++++--
 7 files changed, 180 insertions(+), 88 deletions(-)

-- 
2.43.0


