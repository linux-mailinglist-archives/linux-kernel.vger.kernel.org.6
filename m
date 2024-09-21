Return-Path: <linux-kernel+bounces-334733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 457CA97DB6D
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 04:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B5AF1C21405
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 02:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB013846D;
	Sat, 21 Sep 2024 02:08:57 +0000 (UTC)
Received: from mail115-24.sinamail.sina.com.cn (mail115-24.sinamail.sina.com.cn [218.30.115.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F3AA32
	for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 02:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726884537; cv=none; b=BWKnkqcscCtgSoqoy0hISd54tqpvS2Nzo/tJrys1iUq5O02fLaSdjatxuOFoX4nq7eVa+DIX5MnUs+vnID2kkIKgT9JHFujRd38h1m2qjNh/rxG3NhOQVi40Bo3fO2CW26Q1sDTzbHNthBhBtXlGPFO5L2QS5MjmU4bCuhXfQ7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726884537; c=relaxed/simple;
	bh=Y0OHW3lYUP9kLcdu08o7ZHzTIHgjO8Ab/ICz6fjAUs0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dNG9i089AiqelL/H4+TR8B2F/c5vPX1XCZ+OrL9+ydwK1upqqhqY+hyv8p1rmScu6Ouf/VlzoFXfLSi+KHTROd54pzTF1brbj5ZRJragd+AZrCeBuOEtNoDT+fRBNGX10GlxH/T/Aq5Bza471NRNlK9U7TdDEys3dxbgo3omlPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.10.129])
	by sina.com (10.185.250.22) with ESMTP
	id 66EE2A1E000073CF; Sat, 21 Sep 2024 10:06:25 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 2380327602660
X-SMAIL-UIID: 8994CCC8654B464C9BA724FEBA187712-20240921-100625-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+7c48153a9d788824044b@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [netfs?] KASAN: slab-use-after-free Read in iov_iter_advance
Date: Sat, 21 Sep 2024 10:06:15 +0800
Message-Id: <20240921020615.822-1-hdanton@sina.com>
In-Reply-To: <66ed861a.050a0220.2abe4d.0015.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 20 Sep 2024 07:26:34 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    a430d95c5efa Merge tag 'lsm-pr-20240911' of git://git.kern..
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10c7d69f980000

#syz test

--- x/fs/netfs/write_collect.c
+++ y/fs/netfs/write_collect.c
@@ -548,7 +548,9 @@ void netfs_write_collection_worker(struc
 		return;
 	}
 
+	mutex_lock(&ictx->wb_lock);
 	netfs_collect_write_results(wreq);
+	mutex_unlock(&ictx->wb_lock);
 
 	/* We're done when the app thread has finished posting subreqs and all
 	 * the queues in all the streams are empty.
--- l/net/9p/client.c
+++ c/net/9p/client.c
@@ -1039,7 +1039,7 @@ struct p9_client *p9_client_create(const
 	 * followed by data accessed from userspace by read
 	 */
 	clnt->fcall_cache =
-		kmem_cache_create_usercopy("9p-fcall-cache", clnt->msize,
+		kmem_cache_create_usercopy(client_id, clnt->msize,
 					   0, 0, P9_HDRSZ + 4,
 					   clnt->msize - (P9_HDRSZ + 4),
 					   NULL);
--

