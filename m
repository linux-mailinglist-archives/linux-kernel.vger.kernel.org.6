Return-Path: <linux-kernel+bounces-420520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 503F49D7BE9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 08:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16D84282214
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 07:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38F5184551;
	Mon, 25 Nov 2024 07:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="kDSCRvtt"
Received: from esa10.hc1455-7.c3s2.iphmx.com (esa10.hc1455-7.c3s2.iphmx.com [139.138.36.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C16143722
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 07:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.36.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732519400; cv=none; b=a/9xprpsa86ZZT39EpheUpkgylOutd/jKDwCbYfBfT8gpHRrhcHPtIhfskEJ+/vR0WvTSwjorVNZ6CRnhcB/rHpO5g4FZZj3VkA6a08XkjWAucMKy9Uh0ziZaG2dS7+k4R2V0gxE+Ja1RWDDXwItZ5YTQ82+RZHmKL/jgL8H7VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732519400; c=relaxed/simple;
	bh=2m95VsMaOSbi7trEb0b7oG7lGE8+MkWgx3MTsv5xGQM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=beTvwU4gz0nndcW7h3jP1lE4l70EMl102N4nbBIl+L46suwX9Ou9N9jOMab7T3OWX/iFFfdlFTzOPkAfxLUkBYCZ885sXElvtFpDWESLw+/RVs5SNl2tLDmCGFvKSaN1O8H4scLMBEldl/3VV2+bhjGCUsE+OmvdtC/LhAzJc6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=kDSCRvtt; arc=none smtp.client-ip=139.138.36.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1732519398; x=1764055398;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2m95VsMaOSbi7trEb0b7oG7lGE8+MkWgx3MTsv5xGQM=;
  b=kDSCRvttl90vNIyEeAxRCu11V8evObz7RDY1YFZSyJ5A0GYhsNoRtQeJ
   hS/gdYCKOT87hW+aNx8B5Kutcqd9V2wBILoxh33plTKRAc91segCJquJC
   lgbQwB5JYfU4b2SDIWvo1dy9Er+NovLU9uj/Dvk946PuXY5nvPOnNXBAp
   zE0l4hFtr8jIcsIzUaFkGLbXEeOxg+ooFBaYx2w2AuLWhhKP90OBZwE1y
   46LiE1UBCGUVzeZecAmzOcnVJLxDk7RzmSmlKYmnihUdziWr1TbKtawVJ
   sXY2Sq7FNcR9rJJqEvS11iyE1glXzaMP02qKg0ubPp69V8qUHcdVl/jdH
   A==;
X-CSE-ConnectionGUID: +sJNyvLjQQCkrzy8QMcaPA==
X-CSE-MsgGUID: J8KYb7/nRmu2CS8OJOuw/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11266"; a="168894413"
X-IronPort-AV: E=Sophos;i="6.12,182,1728918000"; 
   d="scan'208";a="168894413"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa10.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 16:23:10 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
	by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 05FA7C2260
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 16:23:08 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 93EB3BDA67
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 16:23:07 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 157E121D154
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 16:23:07 +0900 (JST)
Received: from iaas-rdma.. (unknown [10.167.135.44])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 438CB1A006C;
	Mon, 25 Nov 2024 15:23:06 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Kris Van Hees <kris.van.hees@oracle.com>,
	rostedt@goodmis.org,
	Li Zhijian <lizhijian@fujitsu.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] gitignore: Don't ignore 'tags' directory
Date: Mon, 25 Nov 2024 15:23:08 +0800
Message-ID: <20241125072308.421686-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28818.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28818.006
X-TMASE-Result: 10--1.368000-10.000000
X-TMASE-MatchedRID: BtOHxivXzUe1dF0jp4sQYLnHu4BcYSmtYjDXdM/x2VPXXbamj/TU55Xt
	W55mbY7s16DgGNxZtEwkJUzgP4DZVt/K1ikJIsLOTuctSpiuWyUUi4Ehat05499RlPzeVuQQLkz
	54ubvZDuhrwhaqCksE4Ay6p60ZV62To3UJuRLIoTdB/CxWTRRu+rAZ8KTspSzS2HXV6lu/QoleV
	8DYWCUAnskOd732lpePRbNlc9FkIL4nGMnUVoSCVyM+b340RV7cbypURy7f0bv8I4Y75FIUu8uJ
	2pxv/KWIcmnZRhVxyrE4HwnSlEuHInEpJmLAFfpC1FNc6oqYVV+3BndfXUhXQ==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

LKP reported warnings [1] regarding files being ignored:
   tools/testing/selftests/arm64/tags/.gitignore: warning: ignored by one of the .gitignore files
   tools/testing/selftests/arm64/tags/Makefile: warning: ignored by one of the .gitignore files
   tools/testing/selftests/arm64/tags/tags_test.c: warning: ignored by one of the .gitignore files

These warnings were generated by ./scripts/misc-check. Although these files
are tracked by Git and the warnings are false positives, adjusting the
.gitignore entries will prevent these warnings and ensure a smoother script
execution.

[1] https://lore.kernel.org/linux-kselftest/202411251308.Vjm5MzVC-lkp@intel.com/

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 .gitignore | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.gitignore b/.gitignore
index 56972adb5031..e63dbba823cd 100644
--- a/.gitignore
+++ b/.gitignore
@@ -130,6 +130,9 @@ series
 tags
 TAGS
 
+# don't ignore 'tags' directory
+!tags/
+
 # cscope files
 cscope.*
 ncscope.*
-- 
2.44.0


