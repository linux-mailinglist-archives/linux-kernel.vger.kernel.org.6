Return-Path: <linux-kernel+bounces-314798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 333A496B8D3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 12:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 943C2B20E1B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 10:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15BD91CF29F;
	Wed,  4 Sep 2024 10:44:56 +0000 (UTC)
Received: from smtp134-24.sina.com.cn (smtp134-24.sina.com.cn [180.149.134.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6548E1CC16B
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 10:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.149.134.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725446695; cv=none; b=jtqUkyLopCbKKzcLJfG1Ug9cWmw31x7Ng4t0B5EueClS/TPLVLIDTqqwnZNMAA3ycoJOUM6BsGDQ7MkqU6GpOityqVjBLz0gLrvAwUzR3FcboPP21n/YHKOqYL8hKg0I3kb7qn+3viQdu6p1dGmVm2LuTjOKGDz1T+XMJdF63ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725446695; c=relaxed/simple;
	bh=Qoib1e2J3Lmu+u/fkZDmZJ5tEfjwbm+j4KshMfpexNs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GyWweG8XY6iQ88R6Z/25y+kU8ynboaEKtkX+1GGwpbUTvFEkhGzjOKlIguInntpIqGq6VuY2eWkrWKQn0Wi+u6VmiAuusMNs97PL59Wv5+biFO6+shrTktsR4VnFbGt3SOVBLK/j6YlOQ695od6R25EAOU9BB1KtboYQ0hyhpJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=180.149.134.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.71.23])
	by sina.com (10.185.250.21) with ESMTP
	id 66D83A1100007DF8; Wed, 4 Sep 2024 18:44:35 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 6004493408421
X-SMAIL-UIID: DFC6E09CA6E4414E9E1C1BAC93269636-20240904-184435-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+1c991592da3ef18957c0@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [wireless?] INFO: rcu detected stall in ieee80211_handle_queued_frames
Date: Wed,  4 Sep 2024 18:44:23 +0800
Message-Id: <20240904104423.1852-1-hdanton@sina.com>
In-Reply-To: <00000000000007103b061af41e81@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 03 Sep 2024 00:16:22 -0700
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    67784a74e258 Merge tag 'ata-6.11-rc7' of git://git.kernel...
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=171543db980000

#syz test upstream   67784a74e258

--- l/drivers/net/wireless/ath/ath9k/hif_usb.c
+++ h/drivers/net/wireless/ath/ath9k/hif_usb.c
@@ -754,6 +754,7 @@ static void ath9k_hif_usb_reg_in_cb(stru
 	case -ESHUTDOWN:
 		goto free_skb;
 	default:
+		goto free_skb;
 		skb_reset_tail_pointer(skb);
 		skb_trim(skb, 0);
 
--

