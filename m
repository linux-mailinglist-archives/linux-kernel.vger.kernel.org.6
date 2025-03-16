Return-Path: <linux-kernel+bounces-562795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB65A6330C
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 02:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F76E188EE11
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 01:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C29DF71;
	Sun, 16 Mar 2025 01:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="DogkCNN2"
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18407BE4A
	for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 01:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742087598; cv=none; b=sCBbrtrS1bw9jPJz8rWivCRvICKUv3sinz9BJ2IZOrjP1ytuXn2pQXMCAz0adD/6hOuSW8GEzC7RSNqP/GD7xJush8dGJrxC4a1wGtUvvuL8rr7uOEG3GxM7KVenmJOjghlSYy6Aezr7EqFeXK0b/RMeUzXy35eCT4nKf39JvHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742087598; c=relaxed/simple;
	bh=5vel7QkAMJ8H/7vZiV62pKV9bW+7kfp8qkaCMnq6Ke0=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=u7kaDNmxMLrHOsxQV1AhOH1kJGY2ijVpSIDDmF10VQcp3YjZY2RNhQfvOn4yGMnzIiDw1b3xinOdMS0AN7TR1azv+magIw1KpraiHN0mp8PuuixwEhV4QPMfrKa8yXXtAK90MWdlR14rmEdzgEHpNj8oyjdT96jq5xRKYrRu0PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=DogkCNN2; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1742087583; bh=abv/fmhwC2DnOKbWbUPwzuwmHuBj0kicKFQtoJ1EMSc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DogkCNN2iYQwu43RyM+GTQJAbCTFu5m/iIaEGHq3AhyphTiPqQijzuKkRF41yFsIA
	 zUkD9nJCDiC3t32au3YKnnXJ6+uo5+V+Pzmpf1kcCNXq/pV/mM1pjib1cQQfFILfZU
	 O1AHwc7bbSxUh3IP+qz+tBYuzs2u+E1pgEh6NHNA=
Received: from pek-lxu-l1.wrs.com ([114.244.57.157])
	by newxmesmtplogicsvrsza36-0.qq.com (NewEsmtp) with SMTP
	id 12DA0013; Sun, 16 Mar 2025 09:04:45 +0800
X-QQ-mid: xmsmtpt1742087085tdynzwr5d
Message-ID: <tencent_FF211B3F4BBA1BCD253BBA0FBB3F33229E08@qq.com>
X-QQ-XMAILINFO: OYTBn1rNHH7tTgOLIbwc/t3Eq0Jox8WQIcbalGLLiJTJ/0EZMnFoHMFo5bYkle
	 uGeCW6NGXLRkgQyN9elEyJbjY48izZm65zz48LUQefT8F82bYGDOZE0wwTSxeiYlnIabSFgyLZhB
	 M6TyF1Ep14v7VI7LDYb+HgpbJxEryCtp2Ca/W4ddm/QyIzhV5b/XjKdr7W0p4G/yh3cqdFjRTHL/
	 4+NMTgott4azcIMt8e7zHygkOWT/D8dt7Q5FlBDl8potNmoWYVkS+jQNB3ExjHp0YUqRJn4KO+wZ
	 OgaBFhs41WVrKO9Vb150zQm4bFikJyMYuhxlJSv7X0erCkdXBfHaBJmGRtUvb3HqpKOa53HJN32E
	 VhA7on89/5fgMJyj5dXK/9vmpUpQ9CZCB/ioYwOQ4ekXQcnf+YiAjzWlj2tPbqOeA/t3nLwabU+A
	 5wDZh9NV0WV4UP/bw2EJ1oM8LyD8jGy9hB79sBdOoiFWTpUpS43ODb4PkRKBb8/oldEKSaTKfo2D
	 268Q0qvAzU5eKQBgU37PpJLDYXd8CRuqUYXuBiTih4Wk/xu/RYo/33oaj9yJtXINBNn0Q/vJzcDe
	 337R5/QA0oKIxTcXNKrjOES5Dwaq+AOrKS1GOEUbjnnjgWCdBwy/1ZxOIzkGhQJW+prqelR7id/3
	 TKvcuEWt7kIsPItvAo+V6vBlFS5w27i6jzvV84RKfAzXP16aQI6FeXRCd1MSZQIBI3tDYQ9iA3Qq
	 llPtVR5mdSGVQz8EAUkFD2Q/5mXt12cFyjgFMJsIDgfocr/lRk7QtEW/FQ2BSGE2zpUzdWoC5Iu8
	 vxdYIxTXssEcKvUvkpt+zU+9qYBbkKl2tjn6Cds7uOL7Z9XxwVDCtiOaSkD8srUr9oIP7fFEJ1Ao
	 DYJntqj78tm1hlcDIxj6dZQINiv0fcnDQ7Lxtdfon0a7d/jQFajaYeqT21+G/5rnRTOcslGSNJtI
	 HYoazlf10=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+30de9d963fdd95d745f8@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [wireless?] possible deadlock in ieee80211_change_mac (3)
Date: Sun, 16 Mar 2025 09:04:45 +0800
X-OQ-MSGID: <20250316010444.2081611-2-eadavis@qq.com>
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

diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 738de269e13f..87a970c18e96 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -301,7 +301,7 @@ static int ieee80211_change_mac(struct net_device *dev, void *addr)
 	 * active (maybe other cases?) and we must get removed from it.
 	 * But we really don't care anymore if it's not registered now.
 	 */
-	if (!dev->ieee80211_ptr->registered)
+	if (!dev->ieee80211_ptr->registered || dev->ieee80211_ptr->registering)
 		return 0;
 
 	guard(wiphy)(local->hw.wiphy);


