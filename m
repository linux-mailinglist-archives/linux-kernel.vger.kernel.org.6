Return-Path: <linux-kernel+bounces-334709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17EF497DAED
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 01:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8C79285294
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 23:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11EAE18DF93;
	Fri, 20 Sep 2024 23:54:33 +0000 (UTC)
Received: from mail115-118.sinamail.sina.com.cn (mail115-118.sinamail.sina.com.cn [218.30.115.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148F717A5A4
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 23:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726876472; cv=none; b=Rn+JzucwS4KagFQBMizrrzMYolGjq4WYcPi9eycEuRSokAlqeqp1K/aVdEc5vsfQskc+i/4YoS7RpHBRSdI5CqGrvDVhO8O/101IfITa+8A059wRpMJnsvH9sf59ueDBGMrJa6pWibHaz4raEtlsSoWb48W2naiTkAv7ZznzeD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726876472; c=relaxed/simple;
	bh=EpAxF6lJIM9iAk9VMD/4N0iCEQ23YQW7ZdIZ8BdrHo4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C0BJt42skih4xK7/fSCUsr79IabI0ff+a3Itf/3miQKtba4TIvfL8zQrglskTbwxPxVb6hoIEv8Q/HCRFQkgMVNE0v+Qo7BspW0WPzDf8JTW7/oiW1jEefyCOalo+2rgKauBxSMODrI53pPIG0+GH2N8B5AVzCLGsC9dZNj8KCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.10.129])
	by sina.com (10.185.250.24) with ESMTP
	id 66EE0B2D0000432D; Fri, 21 Sep 2024 07:54:23 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 81291710748469
X-SMAIL-UIID: 98C380FB80754754A5FC5BE342966804-20240921-075423-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+7c48153a9d788824044b@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [netfs?] KASAN: slab-use-after-free Read in iov_iter_advance
Date: Sat, 21 Sep 2024 07:54:14 +0800
Message-Id: <20240920235414.755-1-hdanton@sina.com>
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
--

