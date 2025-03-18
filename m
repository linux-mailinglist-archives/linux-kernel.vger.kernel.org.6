Return-Path: <linux-kernel+bounces-565815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1B7A66FAC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 10:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DFA63A7872
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 09:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE5520764E;
	Tue, 18 Mar 2025 09:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="va/9/zTN"
Received: from out203-205-221-236.mail.qq.com (out203-205-221-236.mail.qq.com [203.205.221.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA00E146D6A
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 09:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742289964; cv=none; b=FSLtJfzIxr12N3wsinGBK9WErSWaumOsztbT0teWxBlz+b4iCJgGvJeClkOyfGpJBosb8MeFUCM3kXgUKdkrqeWYftFXC8lStwKhbBr5vQV64JVB0tsrAHouoaxS0MTsgoe9/MUBHt+OzoI4CCLVq+Tk+ljq7CThjE/lGBMW49A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742289964; c=relaxed/simple;
	bh=A7i3cr40fDVNDgpy8XKVzETKYkek8jHslUVV7CN4Y2M=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=FLm+7pMd4coakTlAxXOxpV1fcze32k6HhcqnSGt9VKFk3XTIckGAKO6sSIxbuQ9Wrvs3cerzmQZ5bIjeWn5bmH98UiH06dDk6o+D5D9doG+HxqLwbc5++NOgpyueANrRavsw9broaUDG01vH5T5loUTUcuWuKj+B2SANap1BbHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=va/9/zTN; arc=none smtp.client-ip=203.205.221.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1742289950; bh=bAjNfmWg9KBxVI6rssw95BWZMVE+YYRwt/FLUXMcm4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=va/9/zTNDRhDz4p0cneCCXA8kSwmENkuUhbMP00FXjQmTp/YB1+bX+hK8UdKNmsY3
	 rXjZYyIGMHX3DukNvNQRl3FGtRNACDXnJCb9O1cq+/VeiXG6kMKO/hbOpo1u2byeth
	 2Nl5C4f35NhcGxvZaWrx1ILzdTlOZqK/gZ7UVB4o=
Received: from pek-lxu-l1.wrs.com ([114.244.57.157])
	by newxmesmtplogicsvrszc16-0.qq.com (NewEsmtp) with SMTP
	id 44DAC8B1; Tue, 18 Mar 2025 17:17:13 +0800
X-QQ-mid: xmsmtpt1742289433tcuj20p0g
Message-ID: <tencent_DE79B66C942EF56F989538EA7EEC32CD3C0A@qq.com>
X-QQ-XMAILINFO: OZZSS56D9fAjU+YeLrlU/G3Id+qMYypBtWlnKWbAl3WPxYL6P2DHuPuZCHm7Dw
	 HKyyYbKc0smxMrKnojQAPLQTehZnl+iXfracfvU6qkSKZRLj4OltYriyiM6ArT8Yf1xS2Psx16vg
	 8lN5NyhmqKXUClGBcAPEc2hAdhYbBYt9hp3fgJhVafFXmUR1uoQkCXL68OXsN2zUJelMIIf/PUyY
	 ANqdtC4O0JIPBQtQE3YuI/Gv1KPrIS/7Vl+e4brFhr8WVgMpUVbrmyUwkjiE1jOTi55k/bmsSePg
	 SCefxug+YANJjRCjR6Zr9Yp10+aQZ+ncTFGxlpoDUeNch8zDnPV7LOEot+1JlAQkCf9lYy3zrjIA
	 eyFsHB+0t7Ydz7l9xYUDRvg0XQXbprjPfzP5L8cKDUBiAfK8ZilTsI2X4WjVaob39bgir0y/gJGo
	 YCcnAPpJvApdR9EHeIwU0UKaqaMJEhd0G3fCuCXbVKBNWDGuxh6gBeccxp+Y9Fck6o0VY0vLF/me
	 KS2rB0Py312Tg8pvyvFjZDPjBK6pqP3zxFnzsF7YBgIGnOpKr2tnOnaWUU9gWQAJhsQPhDRTknOR
	 FLUPeJPVXY0eYpIoIMdQUV6krphAF8Vd/CGMVjXr+NRoQTPWxm4T/kdUHmEBZVbcj6CwlLdMvVDi
	 6NMB6aBBMv9bSlPDtEBV2D3afh9qxEDF39Yr5LMs1S5l64QYkSLaxuLOes46A3ppDGXjARmBN+uh
	 GnnlVq44pZkYITy5QAnDyPMnGenZ1TYl1YxLtuz4GVvoN5Y0nsx9l2UFn1jIkhN+C0nrMBwcypji
	 UeisJ1V5GLZ/nv77jC7z2/wSCEH4eHYfoBTjKW452Ltu9AHR+k1A2FaP2uFJqF2Ts2DJCRCsu3vA
	 FAjsPYWjpjVIAScmldvp5ChwE1WpSzeTj8njYNC9AVZieFfyrbG60=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+76a6f18e3af82e84f264@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [afs?] general protection fault in afs_atcell_get_link
Date: Tue, 18 Mar 2025 17:17:14 +0800
X-OQ-MSGID: <20250318091713.3473902-2-eadavis@qq.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <67d92a74.050a0220.2ca2c6.014f.GAE@google.com>
References: <67d92a74.050a0220.2ca2c6.014f.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test

diff --git a/fs/afs/dynroot.c b/fs/afs/dynroot.c
index 008698d706ca..7d997f7a8028 100644
--- a/fs/afs/dynroot.c
+++ b/fs/afs/dynroot.c
@@ -314,6 +314,9 @@ static const char *afs_atcell_get_link(struct dentry *dentry, struct inode *inod
 	const char *name;
 	bool dotted = vnode->fid.vnode == 3;
 
+	if (!rcu_access_pointer(net->ws_cell))
+		return ERR_PTR(-ENOENT);
+
 	if (!dentry) {
 		/* We're in RCU-pathwalk. */
 		cell = rcu_dereference(net->ws_cell);
@@ -325,9 +328,6 @@ static const char *afs_atcell_get_link(struct dentry *dentry, struct inode *inod
 		return name;
 	}
 
-	if (!rcu_access_pointer(net->ws_cell))
-		return ERR_PTR(-ENOENT);
-
 	down_read(&net->cells_lock);
 
 	cell = rcu_dereference_protected(net->ws_cell, lockdep_is_held(&net->cells_lock));


