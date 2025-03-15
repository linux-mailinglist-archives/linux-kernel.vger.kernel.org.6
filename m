Return-Path: <linux-kernel+bounces-562432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 534B4A6274B
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 07:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AE2F7A51DE
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 06:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3B919F117;
	Sat, 15 Mar 2025 06:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="KsXTjhiI"
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67361189916
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 06:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742020005; cv=none; b=pkFimBWc/XGMm4l/H86oJpq/oFUbBL47TnXLvzKHB6gjQqLr63EFnsl/ce4LDIyffhvBAgqfD9eJ2iEsymuC1mdjoIlMZue0TVrCa5Bp0pwxY533+IwRqPqFQrzosoqfSwndDJDeODMok1fnhMW3FEKu4ugY66u/RI7CP/W1k3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742020005; c=relaxed/simple;
	bh=JZdrjw8DLeInJc3GcHv4dw7d9P2XcsoDREB/MUnV0zo=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=eANueIcpRR5eMJ5TtQwZu+xmEoRc/Of44MrxXxCBkUl1moEMY2ifZcHy2KwmVD13e3qqqNL/B1dn8/wbLv3tQMwOWfwalGlt+pEaSJRh2ijPZEW7mJCC9uw06J67RjT52lcgFlz9vvOBvGY82NvTsBYQ0iec16jBxnBASN0bJx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=KsXTjhiI; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1742019988; bh=xENz+kOeDsq2tIM8qr5EawRu/9B0XkAt0NG2s12w9OM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KsXTjhiICCjy79DrN5khg4gwOGWx3SOpH2t42ziIdWweocxD2Y6bQ4qC/2XaHmp2O
	 xTzJ5QOybzi7oCE6o2TkPlnbzPrEptQsxGoLH8h+rcd1kh3WJiQE5tE50U+jaHT+9N
	 4y2/YfQrGBrgTiKP5vuB5iZi67ELVUALutg3J+Kw=
Received: from pek-lxu-l1.wrs.com ([114.244.57.157])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id 69A39029; Sat, 15 Mar 2025 14:26:26 +0800
X-QQ-mid: xmsmtpt1742019986tyx8q4g70
Message-ID: <tencent_8819BA58BBC933889E4C1B684BB91BAE2508@qq.com>
X-QQ-XMAILINFO: NBplAH1p/X/dJV/Bsl/B2EocWYOxpxzs2qk18orJ75e7xq3EqeBC4ATLxdGLWo
	 U5v8yCDpLg3BklwCI6u21iqo902NpRB/rwI0ssL01ZtT57eTw1jMkEcOf3R6gOYX60ocMu/sYdMc
	 lBJgiaaFEBngh0kihqbFF8zuiccAMp8OYQ+LMYtJ9HgNTvZDSnhCryJq32tOuYorRbr7AD8mwJPO
	 2Er/IJM2pEE/ttZx2iOg4S/Ac9kvCD/V3iB36M7pPE7Ilg9gziUm/6KLlaNE6CkvgM0jbfOdPqIx
	 KPrb3jzTCJdV1hN8NV6aDJrbkf46eEmJrJQOffij54gXMrKzZNGPuXhpcBwWv6ahp9bicPPDVJ1V
	 bRm/xZRg5+bWy1SotxtV+KXYfWXNr3qqgXByBd4v8NP0rbKp+idygCg51rZctnID503lwBplZuW+
	 wWyAJRo6WOsoVVDncOKgXZm6XMCOGV3SElcV3wllvRwbO8b3CYYcWwWp8A8l31dVUtIRwkBNHJbN
	 IwRwRsPG3sO/OuWkgKaC7gBmZ/SlDAuqci/wrHRFgNyBz0jpPGtnTBfrcNoyBuLGb8c8e9thuNH2
	 RM2YdqpAkJ7NwvrYVSPSSkZgxDuJa/4eND3s2CM6+CI3RA2SFVoj0nCr+NfPHLSGMjEg7PsJ/juF
	 PZVXnHjcSmGwlQiiguRupbG7N1SAgSp8v6Org0Q1a2JmFzZQ7M1Ko7uhMW77jdkN1kLoefbwZbmE
	 PyAzpDZXDTtlkSv1+GEfTmAZqJq//f1C7FkQ0zOBivQgAHWFpNv+d66yaanbyyK6BGseFbY2DF7E
	 dKSJ9kB+6xmN17fnSehL719YzEqL3i4Sr1v1M3f7XBlzubIcPTxf6jVFge0QxsGuvKK9g2xblAz8
	 645FPNHjSyHMZVrx7wPkuqGlnTzizLwWomNw3lcmoy
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+30de9d963fdd95d745f8@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [wireless?] possible deadlock in ieee80211_change_mac (3)
Date: Sat, 15 Mar 2025 14:26:27 +0800
X-OQ-MSGID: <20250315062626.1558169-2-eadavis@qq.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <67d4651e.050a0220.14e108.0048.GAE@google.com>
References: <67d4651e.050a0220.14e108.0048.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test

diff --git a/net/wireless/core.c b/net/wireless/core.c
index 12b780de8779..a271bea5699e 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -1477,12 +1477,12 @@ int cfg80211_register_netdevice(struct net_device *dev)
 	lockdep_assert_held(&rdev->wiphy.mtx);
 
 	/* we'll take care of this */
-	wdev->registered = true;
 	wdev->registering = true;
 	ret = register_netdevice(dev);
 	if (ret)
 		goto out;
 
+	wdev->registered = true;
 	cfg80211_register_wdev(rdev, wdev);
 	ret = 0;
 out:


