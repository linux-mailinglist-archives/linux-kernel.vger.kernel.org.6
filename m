Return-Path: <linux-kernel+bounces-356589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C749963DB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 10:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F4B6282C7F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 08:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F5518B46B;
	Wed,  9 Oct 2024 08:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="xNveB24j"
Received: from out203-205-221-164.mail.qq.com (out203-205-221-164.mail.qq.com [203.205.221.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DD1188587;
	Wed,  9 Oct 2024 08:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728463794; cv=none; b=uZy2vJmursg9u3pAkVKKkuKrqamzSovs57kcCTMuLdDMjB1WEe88TqVzEHdQ0sh1SpHVUwPyAqJ6ZOIPzeksRteLNAnZyHgBevMgFrantLJ1YocHU295az2pfR0GlxotALLdspbjXwdpqJAcgFX0D6mIhIV7nyKwDYBjMh8kagQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728463794; c=relaxed/simple;
	bh=U6gTVCR1SWTecSiJAAHM+y+OKQr6E2+zzUL4EqKAKQs=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=rJfJzJ0Lib2lh4yL7wLVSC6iWJMbK8vPo2cpHHeEyMZygA3JHMEwXfAM4aYzlpQWkNvm7bU40XGijTRnDgOAfvdyg/Ez5CNwOBpsFZQ2ENEjnUiI2xY3McOzPm53co5g0FojwCOVwLdl2wzVpMsPKJcOXPM2UTeeotWB4dbxJ8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=xNveB24j; arc=none smtp.client-ip=203.205.221.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1728463788; bh=znLFiy+Gufz/jmUYElMhphI9lilg+HPkttgJBBSJ1Zg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=xNveB24jHNYIp03gJyVWmg4PiDuMKQjZqefLB7O7Yi3raMVWXfhj+mNgxtBxkmMap
	 IybZi/nScK4ktkK2bVDxl92lEUxWbtHU1l6//D+LU0eRMsUEJtbc3FEMUssZ922mui
	 MYNVONMDqfZub8LdDGy3h6M7xZYFOdINKnkkR5MQ=
Received: from pek-lxu-l1.wrs.com ([111.198.224.50])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id AE5BA0EF; Wed, 09 Oct 2024 16:43:37 +0800
X-QQ-mid: xmsmtpt1728463417tk8hgwf3b
Message-ID: <tencent_3212D5C64009A62EE86ED08C8467FD46D606@qq.com>
X-QQ-XMAILINFO: Mg/0DM1Zd+nHbsxd1Kfjo30dG1gvo2fq9KTTwL0a0wwHq6dfeFx9K3zHgbvmwC
	 8l3I212s5YrDwMtusKMlyeW+s5UBPARG3sZdYiaSHLV4hznkNQfSZ303onfTy7DKL1LRwBKvD0rv
	 IECiKyXRuSx5hNCK7lisno7p7Z++slneScGk2ODRRVxreMYiRgPJZxlkhMUMtL/zMvPSmoVoHsf8
	 7G2her8rDFY2NYLIsUtvMR1NropqIkEELvSl+s24OxP2IYu9pLNWm0Degy5nqb3dKBz2NyuGA2ma
	 Cjz6BL4tCA3Av0DWT6tT0tg4fdQQLPRfPdrFkqfZJ3tsl5HgOoHyCyycys0XzfBPXJFgoRLAo3yG
	 Kt6ainktHFOHFIbRkgmxhmSWJxHqT83yaGoKHp5EZJz5bhdtQY5+DXt+aHp94u6TRIBv1XQnIxZ8
	 bhjL4BYojy7K3wBUWRIBHCm3vj/8hkz0Tm2JLdU0+oS6bQA1utLbRMTi88rEaKeEU8mU/ns4WG1P
	 yBLoOYhWfBpbbDghmgyPvs0Jhr62WVhQwNhmTyRjWIk4Cvmc/5TprD3aWHdCkrDsKQK8SlhwaV9a
	 5Us48mrLl3Q/ERy4sU6c+BQ4lhfhmuTxXyG2pPYmBDfZLObUjndKC7+eirnt7769OEpLpcoG8e1Z
	 wa4L/8hZlh30kAwEfebAALSMsWzc3gWpbpWJ/JRRtble6S6XwAucwINFmpH/RPyQDA6cPwqxkW/D
	 pKbOXOLSVFqRTzktauyidcOIMuYXBJ9flr2lRvn18DS5njj8jWObWiRtwXB6/ZTQD2I84upv0oNm
	 FBfeUcJrPwZWwrIqV4yT9DEz26h+0+XNgdwY62KOhKbq35zU+oz2CsW1Bni5CCNrvnYvzu8uNJ0B
	 XGxnDy3NOyh1hIM49JCF55xBFLRWwzYwuzR6KEbPZgZyF/ai3xuYBUHPyXF/CTT6xrnsISiqAVKe
	 a4aOqLKRU=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+685e14d04fe35692d3bc@syzkaller.appspotmail.com
Cc: gregkh@linuxfoundation.org,
	keithp@keithp.com,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [usb?] possible deadlock in chaoskey_open
Date: Wed,  9 Oct 2024 16:43:38 +0800
X-OQ-MSGID: <20241009084337.1215487-2-eadavis@qq.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <6705f983.050a0220.22840d.000d.GAE@google.com>
References: <6705f983.050a0220.22840d.000d.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

delay get the chaoskey_list_lock, avoid to circular locking dependency
chaoskey_release has a wrong logic lock for chaoskey_list_lock, it need unlock.

#syz test

diff --git a/drivers/usb/misc/chaoskey.c b/drivers/usb/misc/chaoskey.c
index e8b63df5f975..225863321dc4 100644
--- a/drivers/usb/misc/chaoskey.c
+++ b/drivers/usb/misc/chaoskey.c
@@ -232,10 +232,10 @@ static void chaoskey_disconnect(struct usb_interface *interface)
 	if (dev->hwrng_registered)
 		hwrng_unregister(&dev->hwrng);
 
-	mutex_lock(&chaoskey_list_lock);
 	usb_deregister_dev(interface, &chaoskey_class);
 
 	usb_set_intfdata(interface, NULL);
+	mutex_lock(&chaoskey_list_lock);
 	mutex_lock(&dev->lock);
 
 	dev->present = false;
@@ -319,7 +319,7 @@ static int chaoskey_release(struct inode *inode, struct file *file)
 bail:
 	mutex_unlock(&dev->lock);
 destruction:
-	mutex_lock(&chaoskey_list_lock);
+	mutex_unlock(&chaoskey_list_lock);
 	usb_dbg(interface, "release success");
 	return rv;
 }


