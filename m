Return-Path: <linux-kernel+bounces-420593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCAA9D7D03
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 09:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85ED7282105
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 08:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332A318A959;
	Mon, 25 Nov 2024 08:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="qMshGXwW"
Received: from esa4.hc1455-7.c3s2.iphmx.com (esa4.hc1455-7.c3s2.iphmx.com [68.232.139.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73671185955
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 08:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732523820; cv=none; b=YVrIr7pwIdIb35HHJxCnv3TTq8vQ/L6ydHsTLHUgs9LS20nlVRpTRtU7Jw0D3BKTMa2KIbOPPMqeXW98m5xQ/ihErBG9Wtbm+O/zgMRs4tdgEFloTuCWM4/q+aUbUMbkXM19XUbhq07gMzDvpiPARe1J7ca3Nd8YJh+2/goZb2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732523820; c=relaxed/simple;
	bh=XsKn7v6QktxBmJdF8JUiVUqmfGPwk7XPKXHjXZEMsT0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GuqbD4LwD5OyyHe9b3htOk2Kbdpcn1b8LoUvB7od2FVLJvH/9OcZLs+qS7rNYGlN7D9gBLEwj3Ne3M2wVQJFx6oIB92yGAQZbWxWCIH65Ght5LK7HLROYQRyVrI9r+DGwx8CVTmCht2GeS73nkvkjBvWABTrqPawhICMeEmX6eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=qMshGXwW; arc=none smtp.client-ip=68.232.139.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1732523818; x=1764059818;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XsKn7v6QktxBmJdF8JUiVUqmfGPwk7XPKXHjXZEMsT0=;
  b=qMshGXwWei5MWlJpSCcAVHLYov3vNxiX963FG2WiME0eWPYSjJd2kjss
   Yj05qjMndiP1d6+2GJLmBtP9hjvK4sUp5uY1OcC3C1R017kqv2+H8ahGO
   8kdqF9GhxJJsY06sKzIQ4ke+FJUwfv1CrHK4/uBMnxlAzZK9wYGLsl3XJ
   MEd0c0pIgoQcuHrDQFG9ulQhIY4oHh0AK0vgMTavNDnuWv0eqO3q7uBjM
   99hcJGFzbhDUgn7J8w/4/YPqbseddzSjniFhNkLylt5AeSi30BFPiGJDY
   orgXwNAPhLq91r8vcJAeCvhtqftBtptPnz61BGA7lnaf7qPoib5Jltppd
   A==;
X-CSE-ConnectionGUID: PcEaVUn+R6GSK6D3FtWmDA==
X-CSE-MsgGUID: XiXenBCUT7uWaSelHsudaw==
X-IronPort-AV: E=McAfee;i="6700,10204,11266"; a="181774468"
X-IronPort-AV: E=Sophos;i="6.12,182,1728918000"; 
   d="scan'208";a="181774468"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa4.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 17:36:49 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com [192.168.87.60])
	by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 074CDC2262
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 17:36:48 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 945A0D5610
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 17:36:47 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 20B33216F79
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 17:36:47 +0900 (JST)
Received: from iaas-rdma.. (unknown [10.167.135.44])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 266941A006C;
	Mon, 25 Nov 2024 16:36:46 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Kris Van Hees <kris.van.hees@oracle.com>,
	rostedt@goodmis.org,
	Li Zhijian <lizhijian@fujitsu.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v2] gitignore: Don't ignore 'tags' directory
Date: Mon, 25 Nov 2024 16:37:36 +0800
Message-ID: <20241125083736.422081-1-lizhijian@fujitsu.com>
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
X-TMASE-Result: 10--3.419900-10.000000
X-TMASE-MatchedRID: kGI9ImI8MJ21dF0jp4sQYLnHu4BcYSmtYjDXdM/x2VNM+b8yxBqvAy15
	IFUNL+ETeIGQlpBPw8W+VPyVsr45TnpsxhuKgz2pTuctSpiuWyUUi4Ehat0543Wm8bkL6PFTGEG
	9aBmVf7zi8zVgXoAltr8hWd4lAsFlC24oEZ6SpSmcfuxsiY4QFNNFtOtbd02JhX545CAt/1Mevv
	te46hBuPEixgv0HQXKDszABa2AeQAGG37QzSsZR/hJ1bwtIE6JtVGp8TW4gMJ3AhTNqE/oG5sNE
	GpLafrrLM/nEDLP056e+TDiyH/49wxfkLAfkNNSaAZk0sEcY14=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

LKP reported warnings [1] regarding files being ignored:
   tools/testing/selftests/arm64/tags/.gitignore: warning: ignored by one of the .gitignore files
   tools/testing/selftests/arm64/tags/Makefile: warning: ignored by one of the .gitignore files
   tools/testing/selftests/arm64/tags/tags_test.c: warning: ignored by one of the .gitignore files

These warnings can be reproduced by compiling the kernel with the W=1 option.
Although these files are tracked by Git and the warnings are false
positives, adjusting the .gitignore entries will prevent these warnings and
ensure a smoother script execution.

[1] https://lore.kernel.org/linux-kselftest/202411251308.Vjm5MzVC-lkp@intel.com/

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index 56972adb5031..6c57bb0259c6 100644
--- a/.gitignore
+++ b/.gitignore
@@ -128,6 +128,7 @@ series
 
 # ctags files
 tags
+!tags/
 TAGS
 
 # cscope files
-- 
2.44.0


