Return-Path: <linux-kernel+bounces-341675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6F598836E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 13:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECE911C22984
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 11:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7953189F59;
	Fri, 27 Sep 2024 11:42:54 +0000 (UTC)
Received: from mail115-100.sinamail.sina.com.cn (mail115-100.sinamail.sina.com.cn [218.30.115.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A654187349
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 11:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727437374; cv=none; b=jh9+4BdWAKsGC0PJ88k1vReodOfGGrsrikFJhyK9qgwgaLGWFGm/MPxeXh01qR0rYOasMr8qGh7lsA1XHr5J3OPsHviRup37gJQhK4XqEhe6j5qkC3dJ0O9/TWJXR1RXW4Qy/R9iwVFuIksLoX1VE5+TLblRJhvcEa1eyudzpsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727437374; c=relaxed/simple;
	bh=2/TM2NHM2Z6JbDF6sxIrQU/Yg2Y3AlAVhKkUXPDJ4+w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TRc3hUg2AdlJ9Fmu8FSa7VMnLkBmi59zE3G1S3KBPZhskiE4dst7abXytOD4epzURdOiE2/zqK+yz0PWYUQPlAvs0casuzYaxdxuomoJVzxSTX/6wOlAd+MDJKwMX6GYSXDU0VsQIXo4c/lPiUyI2OKsnqnbPjN/JpDnbeYpREA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.71.54])
	by sina.com (10.185.250.23) with ESMTP
	id 66F69A0D000026DB; Fri, 27 Sep 2024 19:42:08 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 6840358913239
X-SMAIL-UIID: A2F331F45F294C8C95E71D6C31C39589-20240927-194208-1
From: Hillf Danton <hdanton@sina.com>
To: Eric Dumazet <edumazet@google.com>
Cc: syzbot <syzbot+05f9cecd28e356241aba@syzkaller.appspotmail.com>,
	linux-kernel@vger.kernel.org,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Boqun Feng <boqun.feng@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] INFO: task hung in new_device_store (5)
Date: Fri, 27 Sep 2024 19:41:58 +0800
Message-Id: <20240927114158.1190-1-hdanton@sina.com>
In-Reply-To: <CANn89iLKhw-X-gzCJHgpEXe-1WuqTmSWLGOPf5oy1ZMkWyW9_w@mail.gmail.com>
References: <66f5a0ca.050a0220.46d20.0002.GAE@google.com> <CANn89iKLTNs5LAuSz6xeKB39hQ2FOEJNmffZsv1F3iNHqXe0tQ@mail.gmail.com> <20240927110422.1084-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 27 Sep 2024 13:24:54 +0200 Eric Dumazet <edumazet@google.com>
> I suggest you look at why we have to use rtnl_trylock()
> 
> If you know better, please send patches to remove all instances.

No patch is needed before you show us deadlock. I suspect you could
spot a case where lockdep fails to report deadlock.

