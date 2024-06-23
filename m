Return-Path: <linux-kernel+bounces-225945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C9499137F9
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 07:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88590B2186B
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 05:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B3622079;
	Sun, 23 Jun 2024 05:43:50 +0000 (UTC)
Received: from smtp134-24.sina.com.cn (smtp134-24.sina.com.cn [180.149.134.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEF314A90
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 05:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.149.134.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719121430; cv=none; b=VtCxP6g01LKKHvnlNucwML4TFPonYI1u+Pa4LvWOR7Y+Ek9Ny+WFhhHlvykZbxRTVmwqEhMOfzqAiP1n7LsCbybF3NdFYyskHP7fdud9xgsWy1OXyapTANINYyaDTuHomqxApk65YetSomSuTTvp/BYqYc4hjEnJpmw0Nf9lLA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719121430; c=relaxed/simple;
	bh=UzM2/d5PP8CeqWUPpeduSWxwrm1iz9s3Z+4fwh/KHe0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N2Zdlb6I2QS9yClZyC1J/tDQeIueb4XqMnLXY0gDnZhQv+LWFlScc2wVShdRDgnycvr++EU5WrOOHiGt06iUoJXFD3qvB5l8b9ToAZ25HwHU9UfoLGFPfRGXxQ3BbAr4Jyt+CFMOQdSUO041GpfhXgX+h8vlWv7ong7z5HsxqmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=180.149.134.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.49.160])
	by sina.com (10.185.250.21) with ESMTP
	id 6677B5FD00004668; Sun, 23 Jun 2024 13:43:27 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 9067893408642
X-SMAIL-UIID: 32AC4F89003F4A1A9016C9DD20613314-20240623-134327-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+35ebc808442df6420eae@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] KASAN: invalid-free in hci_req_sync_complete
Date: Sun, 23 Jun 2024 13:43:14 +0800
Message-Id: <20240623054314.1929-1-hdanton@sina.com>
In-Reply-To: <00000000000033a6e8061b3c6d4a@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 19 Jun 2024 04:23:24 -0700
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    2ccbdf43d5e7 Merge tag 'for-linus' of git://git.kernel.org..
> git tree:       upstream
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=125874ea980000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  2ccbdf43d5e7

--- x/net/bluetooth/hci_request.c
+++ h/net/bluetooth/hci_request.c
@@ -181,7 +181,6 @@ int __hci_req_sync(struct hci_dev *hdev,
 		break;
 	}
 
-	kfree_skb(hdev->req_skb);
 	hdev->req_skb = NULL;
 	hdev->req_status = hdev->req_result = 0;
 
--

