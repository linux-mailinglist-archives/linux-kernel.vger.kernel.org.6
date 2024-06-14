Return-Path: <linux-kernel+bounces-214168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5AA908071
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 03:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F8171F22B87
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 01:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14DC2107;
	Fri, 14 Jun 2024 01:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="QLqtJfbS"
Received: from esa1.hc1455-7.c3s2.iphmx.com (esa1.hc1455-7.c3s2.iphmx.com [207.54.90.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED166FB0;
	Fri, 14 Jun 2024 01:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718326848; cv=none; b=VQjjdVCqGnkxma2pq2RZWjz8f4PYoQx2InB21Fs1kI51Y1HMrnvORMuE83xyTzFM5QUyoGgPJVK6Lao94rBN2+fmjaIXJk4Baj1J8HLPuVmaXdpxLUzWtIaBW+7t1oo6xsYZH0lBtJ4oyuTKuPpKBCTtzgFeSIoy5qmJkvGDokA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718326848; c=relaxed/simple;
	bh=58DWKisnhrHdCz55eXANJnDLMcyfb2It2isJmC5H1Aw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Xpk9mWiGH9vhjQr72BXaHIGKWNRkgBLEPdl643WkFqnUIIHzwo4T/26JH17f4JN6o5wsWOW9yAdQzWWmvuMoNMCDOk+24LwmclAJCbhquWh264ua6ul6nt8a5uTnFc9N4XB5L2iu5rz3asvjp1W13Ms1Wx2ngK+ktQULlEahdXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=QLqtJfbS; arc=none smtp.client-ip=207.54.90.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1718326845; x=1749862845;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=58DWKisnhrHdCz55eXANJnDLMcyfb2It2isJmC5H1Aw=;
  b=QLqtJfbSgqekF/o7LSAq2VynsUzCIn7MGBjboaVCUi9SoJkZN8u1FGGi
   shrWMB2bUH7uulZTksGJ/tICYqWulaRW6saxgUhHG1FzX6hBCN4MWs46j
   J+W8aux+58rRN1wr7C4YT2pUa2zLFIeS9kQMCTar2n8d0zXF0FQg4BOls
   YAnOnhewKI6FGmcOPutiIsE0+pPVSgo9nuJJDYUVo8y/PUcxxxBQnskH8
   mra0fkFm0pzfN42MfvmYSnWC78rHMTxFvjuLv2Fds2l6QpzfYrV0sSYtj
   DWEXS4vYTgPPpyOVTyUprYPFdwk1audvL19mWMbTr7pmUwpgWI00ydc7u
   Q==;
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="163059450"
X-IronPort-AV: E=Sophos;i="6.08,236,1712588400"; 
   d="scan'208";a="163059450"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa1.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 10:00:36 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
	by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id EA548CD6E4;
	Fri, 14 Jun 2024 10:00:33 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 2BD7E2552F;
	Fri, 14 Jun 2024 10:00:33 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id A660E20081310;
	Fri, 14 Jun 2024 10:00:32 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 5E2881A0002;
	Fri, 14 Jun 2024 09:00:31 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-doc@vger.kernel.org
Cc: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	corbet@lwn.net,
	hpa@zytor.com,
	linux-kernel@vger.kernel.org,
	Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH] Documentation: exception-tables.rst: Fix the wrong steps referenced
Date: Fri, 14 Jun 2024 09:00:28 +0800
Message-Id: <20240614010028.48262-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28452.003
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28452.003
X-TMASE-Result: 10--5.000200-10.000000
X-TMASE-MatchedRID: TWQD+6s80gMDCEXfCfH5DHnLJGGZe5swTSz0JdEAJbTVjNsehGf0vb8F
	Hrw7frluf146W0iUu2uQfYjCMFqIHif7ZnjOtvquRcGHEV0WBxCxXA8wqNmbVodlrZzkVCoONMj
	Eju2qSFCr1jKm0SUrl9EOCxfTciM35UcZtwNsCroURSScn+QSXpjDMT0TyDk5+gtHj7OwNO0LH2
	qjGZLbHT83Ey36k4b1h5odYtrQJ1Hbf9E1FWPAGoo+LwLI3KU0
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

When it was in text format, it correctly hardcoded steps 8a to 8c.
However, after it was converted to RST, the sequence numbers were
auto-generated during rendering and became incorrect after some
steps were inserted.

Change it to refer to steps a to c in a relative way.

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 Documentation/arch/x86/exception-tables.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/arch/x86/exception-tables.rst b/Documentation/arch/x86/exception-tables.rst
index efde1fef4fbd..562d1bc6d448 100644
--- a/Documentation/arch/x86/exception-tables.rst
+++ b/Documentation/arch/x86/exception-tables.rst
@@ -297,7 +297,7 @@ vma occurs?
    c) execution continues at local label 2 (address of the
       instruction immediately after the faulting user access).
 
-The steps 8a to 8c in a certain way emulate the faulting instruction.
+The steps a to c above in a certain way emulate the faulting instruction.
 
 That's it, mostly. If you look at our example, you might ask why
 we set EAX to -EFAULT in the exception handler code. Well, the
-- 
2.29.2


