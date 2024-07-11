Return-Path: <linux-kernel+bounces-249069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 576BB92E5EB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 13:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 128B32880DE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 11:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345E715FA8B;
	Thu, 11 Jul 2024 11:10:11 +0000 (UTC)
Received: from mail115-69.sinamail.sina.com.cn (mail115-69.sinamail.sina.com.cn [218.30.115.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CC915F410
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 11:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720696210; cv=none; b=PYIuujCxSJB4NxurXVz4JGNrT7f48srqZ/oBFsLSnT8Nba1bZhzA8P2t4TOU1KFGlSpa0WKnlthKVkl3TRp/0Zq2IBtDK3zPJlZOOv+SneS8YOxSuKjDGIB8Aw5qZ4mreQaI4oB5R0rKTnHdVTLQAzcsf86vxw3QVXNB4hM6GZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720696210; c=relaxed/simple;
	bh=NTRu7/lRqX08hMMUgvUR2vyaRxokJ8enD5eSjzRWk8I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ozsJwKoJfukYFoTE2gtRX2e39DihaThkJ+j5tQMPu0BXQhPShJZhzElcXfnLV5sOCfFrfFQd+1vbtl22bNevzvT7/4CYijXSr9ffQhXlWb/ysPRH/xwLf1m5AViCR0HgV5lxLLTRYv4sgc845y2B/o8gUHlQClwdAhI2qL3dckc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.49.89])
	by sina.com (10.185.250.22) with ESMTP
	id 668FBD8000002AEF; Thu, 11 Jul 2024 19:09:55 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 1093397602675
X-SMAIL-UIID: 2FD65D3EE3B349B4ACC5ACD482700370-20240711-190955-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+733a96463546d3026b60@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] BUG: workqueue leaked atomic, lock or RCU: kworker/u9:NUM[NUM]
Date: Thu, 11 Jul 2024 19:09:45 +0800
Message-Id: <20240711110945.1147-1-hdanton@sina.com>
In-Reply-To: <0000000000002fcc8d061ced3d52@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 10 Jul 2024 16:45:19 -0700
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    ef445d1539dd Merge remote-tracking branches 'origin/arm64-..
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=176e2c7e980000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git  for-kernelci

--- x/net/bluetooth/l2cap_core.c
+++ y/net/bluetooth/l2cap_core.c
@@ -6774,6 +6774,7 @@ static void l2cap_conless_channel(struct
 	bt_cb(skb)->l2cap.psm = psm;
 
 	if (!chan->ops->recv(chan, skb)) {
+		l2cap_chan_unlock(chan);
 		l2cap_chan_put(chan);
 		return;
 	}
--

