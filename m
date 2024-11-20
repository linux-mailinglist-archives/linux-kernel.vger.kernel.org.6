Return-Path: <linux-kernel+bounces-415586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 985AF9D3891
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 11:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D6A9283F47
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 10:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DED519D89E;
	Wed, 20 Nov 2024 10:43:21 +0000 (UTC)
Received: from mail115-118.sinamail.sina.com.cn (mail115-118.sinamail.sina.com.cn [218.30.115.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F86415853B
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 10:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732099400; cv=none; b=nnbogui+GadkJZPOzlUTRVTMT/2aMznk7bXCzp6mAghcJ3nLFyGHXKX6/H3Ri/tfVNHM4toei1dPziPWAuC81DwvRks/mRkutw4POTio7526f0NVBUESY90LwKm8k6/mdpHhPvh82QNp5nlAWsBUeW5wokt35bcr1rOl/XdTRP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732099400; c=relaxed/simple;
	bh=yADP6UqHVQXBmag/4HSVVZjtZ1hqnan7Sjjr/1PVf7Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s7e4GNKL1CjBHi+JiYe+PJ5gFGX2sj15c6qhT3WsJ5kHsDOqjAVm5itT3BTK3pIclhL+/Fu8sl4ELCC4SZg+yr2QVJh8eVtgGry1UjthdTrVzh+iMCVQ5CqE/NrJ8YMmqrox4YRd8paLIl9Ayhhhwt6w2kTMzdwu3ObB93XXP3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.48.11])
	by sina.com (10.185.250.24) with ESMTP
	id 673DBD0E0000420A; Wed, 20 Nov 2024 18:42:30 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 96987610748643
X-SMAIL-UIID: 4B47F449016D49FEB2DA6990CD64E586-20241120-184230-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+6105ffc1ded71d194d6d@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [keyrings?] [lsm?] KASAN: slab-use-after-free Read in key_put
Date: Wed, 20 Nov 2024 18:42:12 +0800
Message-Id: <20241120104212.1462-1-hdanton@sina.com>
In-Reply-To: <673b6aec.050a0220.87769.004a.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 18 Nov 2024 08:27:24 -0800
> syzbot found the following issue on:
> 
> HEAD commit:    adc218676eef Linux 6.12
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11c672e8580000

#syz test

--- x/security/keys/key.c
+++ y/security/keys/key.c
@@ -645,21 +645,30 @@ EXPORT_SYMBOL(key_reject_and_link);
  */
 void key_put(struct key *key)
 {
+	int quota_flag;
+	unsigned short len;
+	struct key_user *user;
+
 	if (key) {
 		key_check(key);
 
+		quota_flag = test_bit(KEY_FLAG_IN_QUOTA, &key->flags);
+		len = key->quotalen;
+		user = key->user;
+		refcount_inc(&user->usage);
 		if (refcount_dec_and_test(&key->usage)) {
 			unsigned long flags;
 
 			/* deal with the user's key tracking and quota */
-			if (test_bit(KEY_FLAG_IN_QUOTA, &key->flags)) {
-				spin_lock_irqsave(&key->user->lock, flags);
-				key->user->qnkeys--;
-				key->user->qnbytes -= key->quotalen;
-				spin_unlock_irqrestore(&key->user->lock, flags);
+			if (quota_flag) {
+				spin_lock_irqsave(&user->lock, flags);
+				user->qnkeys--;
+				user->qnbytes -= len;
+				spin_unlock_irqrestore(&user->lock, flags);
 			}
 			schedule_work(&key_gc_work);
 		}
+		key_user_put(user);
 	}
 }
 EXPORT_SYMBOL(key_put);
--

