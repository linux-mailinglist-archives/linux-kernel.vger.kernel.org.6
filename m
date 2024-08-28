Return-Path: <linux-kernel+bounces-304185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D74961B8A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 03:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3FE9B21B96
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 01:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112CE38384;
	Wed, 28 Aug 2024 01:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="ucraPIpm"
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223B11BC2F
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 01:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724808898; cv=none; b=IIv4DQ9LXklSPvN8/Mp3ygpkVnLGHnK+oCVrX0n2xK1ooLH1+wPnWWfiDgaFG7Jxgzgl7FWTQcfC7nmIerSrv6hikALuOEyuXpvWdlWdSgBU+AiaDFpvzPV6jZ3zT+KivrmbScJNB18pdWMkdmA3DewPG71dzbJx5JXSGMpP6Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724808898; c=relaxed/simple;
	bh=Xut+9JPTgwaVgPaDC0Vj74uTer72lRRZ0rGUMUxaFSE=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=lqyNO742oJtYOt0PjIVHVcDvC8xwC0uBN4GuYg/POvBYQeXpgMvZYtsfK+H2R3vr7csnRDo2/kmCkdioZjdh3XIeDsIj6FPy5JGLqVjDky3JQvD2G0NQA2XHrIoFI4px5Sd2/hDLkwFKblSGj0dQbh2Sci0zk2t/D0rzWRvK2w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=ucraPIpm; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1724808891; bh=u3oxTbni08XsyEqcJ7oF63RwBMXOTVd32VrwJ9typz4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ucraPIpmmkUm0lyHSghYKgB9GLELxe4WA367wLIHlvI5xzgH8LvWEAczUgoTVE8wJ
	 mGNorvuqPCITR9pDIWKCj1244TMI1gFTYkLenAUWpP75s4Y9NSmZ9Puaj7w7d6LLmn
	 qu7fxw6fpVaMN9Y/YmIlWds1yHn/3PJkpPpSiiDo=
Received: from pek-lxu-l1.wrs.com ([111.198.224.50])
	by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
	id 8B10B29B; Wed, 28 Aug 2024 09:34:49 +0800
X-QQ-mid: xmsmtpt1724808889thxh8m1nw
Message-ID: <tencent_85866689832EDE6ED8CC92A7DD46FD12E406@qq.com>
X-QQ-XMAILINFO: MIAHdi1iQo+zcdiWYlGKji0ZfhkNuOiUstidkGnNt9ws8KUn/lEVmdsatx/lKi
	 1H964PaLeDM/naEnDlv4xTiaVSNH1IQCGG69rYzCNF512u6Fip7vmIhnj3YW61qD0KLBiFIffm/L
	 K6tqFX8pBA4URIrPSu9BkCmPK87AKhsE7yuz/vh4GZJ8fywiPckTaYEJZUk4w+XtnGtzhZHFTvvC
	 FxEI1L3NMwOi74NXKoY+g4exZFvQYy+mXo2qPUoah1fhSdJXBB+ooYWzjpWqkLBbRis3DCiwDOJl
	 7+xmgCLXBo2iocEDQSlYlc5KRJy7wXP6sx2nPGSckFH5QnY4rUjd3xLEduA41Rqb0Kn8PsyS8twU
	 bknkpt7JH4sSDwW6DLjfxedo8xJDru7k6XWvWSmIn0xfRJQw9+h7OqLnIpS5v3FAEs8fE6dTKtOP
	 4hvbPv3ke/B08qjuBjs6An7gqzAuvM1KUtfsNefy0vDNCkxAl5fIcJ5HOGFV5WKCFEmofxf5pe0y
	 UVyw14XiNzr3ZdW3X81DouDimnH0Fjtzl2nmdXkz4bt9TPs4UjrYNgVAW4Ws+pgNPgnQZ77JN8d0
	 ixBNIE8i0xnEc2xiyf5nqlNLqGJUb9iLux6az/c1lsYtxucnFv3xfrDfD6xJMHd1HBZCVYwpyyui
	 v/36bb4XeL2vPhA2rmDJN3TtyME0DFhHsScxNz4+RwydksRjp9v6M0QSaKGkknGR+8w89+r82URU
	 Bgp+fZDSnNvOkzWcBctdcqpcgaaAWKLCaZyA03M5SAy62m2iBhiJQ0qt7whGi9W7uYlyQV9ftyza
	 e6krCprlQOTdbrRbZGw+nt0zXsjNvXYKwAA6y7RCbmBFInJgKgQm6zh8MPk8WwyOlbkPCfv6z6kr
	 6aVpc73Uy1Ff/nhbyKNGge/J4bnwViE2j0R8IURl/P5pha4NhzfNA=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+5cf270e2069645b6bd2c@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] general protection fault in phy_start_cable_test_tdr
Date: Wed, 28 Aug 2024 09:34:49 +0800
X-OQ-MSGID: <20240828013448.46741-2-eadavis@qq.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <00000000000094740b0620b32b4e@google.com>
References: <00000000000094740b0620b32b4e@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a logical error in checking phydev

#syz test: net-next main

diff --git a/net/ethtool/cabletest.c b/net/ethtool/cabletest.c
index 3a91b65c1f9a..2fe5951b8e45 100644
--- a/net/ethtool/cabletest.c
+++ b/net/ethtool/cabletest.c
@@ -342,7 +342,7 @@ int ethnl_act_cable_test_tdr(struct sk_buff *skb, struct genl_info *info)
 	phydev = ethnl_req_get_phydev(&req_info,
 				      tb[ETHTOOL_A_CABLE_TEST_TDR_HEADER],
 				      info->extack);
-	if (!IS_ERR_OR_NULL(phydev)) {
+	if (IS_ERR_OR_NULL(phydev)) {
 		ret = -EOPNOTSUPP;
 		goto out_dev_put;
 	}


