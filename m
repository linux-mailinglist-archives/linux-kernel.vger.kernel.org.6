Return-Path: <linux-kernel+bounces-349727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B90C498FA88
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 01:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BC12B21E24
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 23:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101B91CF7C9;
	Thu,  3 Oct 2024 23:35:16 +0000 (UTC)
Received: from smtp134-32.sina.com.cn (smtp134-32.sina.com.cn [180.149.134.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0741CF2B1
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 23:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.149.134.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727998515; cv=none; b=Kcazqh9/eTuTDEUuLWA06nNd7bji1eGo4a1RNDLGRyjTUPwZKqL/tv2JA/gzRbEWwCh9k7qOdU6K9le4Qlr0OliatwBDmVjeRVk2czdkhgcH7TEf07Q9nCRx8EkgePi0MwCit73w/KOH0GqANxsVzCD1PMHILMlUww7P4U0csj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727998515; c=relaxed/simple;
	bh=3woJkjGUddP3kur6qF8w7Nq0F98nXvjCoUytNpvgTl4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g6VMYDHjA1aNzovJZFXC8LZXwW9esfSdd+hMw9R0/CmKJV2+1DrCIcmRlI2ZHfkZVQuyhhCUY+Xxzlp7Ua488IDpSyOMJtw80JVy0NMG5EgV84Wjqv82Sxx/6crXYiG9FaSK0pw8Lt7NHtyCXsZrSCVH3LTaBpuOzSPeCwyPxSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=180.149.134.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.68.49])
	by sina.com (10.185.250.21) with ESMTP
	id 66FF2A250000688C; Thu, 4 Oct 2024 07:35:03 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 6250673408462
X-SMAIL-UIID: 1B12A4FF89A14B7EA2CD1CD75E5153D5-20241004-073503-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+d4e8dc385d9258220c31@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [can?] WARNING: refcount bug in sk_skb_reason_drop
Date: Fri,  4 Oct 2024 07:34:52 +0800
Message-Id: <20241003233452.2044-1-hdanton@sina.com>
In-Reply-To: <66fec2e2.050a0220.9ec68.0046.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 03 Oct 2024 09:14:26 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    a430d95c5efa Merge tag 'lsm-pr-20240911' of git://git.kern..
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15b9a607980000

#syz test

--- x/net/can/j1939/transport.c
+++ y/net/can/j1939/transport.c
@@ -1506,6 +1506,7 @@ static struct j1939_session *j1939_sessi
 
 	skb_queue_head_init(&session->skb_queue);
 	skb_queue_tail(&session->skb_queue, skb);
+	skb_get(skb);
 
 	skcb = j1939_skb_to_cb(skb);
 	memcpy(&session->skcb, skcb, sizeof(session->skcb));
--

