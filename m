Return-Path: <linux-kernel+bounces-365592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC24699E4B8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 12:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57BFF1F242C3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 10:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060D81EF929;
	Tue, 15 Oct 2024 10:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="ATp3a/Q5"
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A351EF921
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 10:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728989739; cv=none; b=PwFOiuIeAqmPDbQsP536p27M7zOG01MQMhNIR/tgFEB5obBkQrUgDUYb3IuDn8BDw/cQSgMENrWCiXR1t5iiCqX9dtkaFKoKbkS+mirKOwcLArC1QXUrf9dakKdqXKI1cG/STPg1gFy1hLh03nALSfgcCeU+PDlY3LQBdHHujXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728989739; c=relaxed/simple;
	bh=4MzQu8RkYaVE25ff/bueC2yCjetJOfmkgdGcz5sa06w=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Nu/aL5YC5gtVaS4G6r7aLCBnjFzbu6RDzOZat4ZiwiT5z3JqNmX7E1Hlwhq53xaQ8znY34opvTEN2g/PVu+boP9JPu3Zb7AyVEV1Ha3suEFSuou7N1CNHP3WlHeaHuAwwemHFuim8ZHYr8CZ3AWlvGLLFsJZZwC57tcSRK+/raU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=ATp3a/Q5; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1728989726; bh=m/5UhyVkXtYBOWH/LiMao4014tHkRSUcKPL2eFzIdNY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ATp3a/Q5EbSAYsDDrju6BOYrXjZVMKkLBC5GczXgxz70tnMucg1o54XXhz7CQex1r
	 gmCSRzqioGzCDl7DTqgkInfgWAXnoTGB4No5Ud4jxhzMfodGmrOBDfqESp99LO46cw
	 q4Grr0a5QRxsmsPIRHTsnQZ575q+LX2gItcauRHU=
Received: from pek-lxu-l1.wrs.com ([111.198.224.50])
	by newxmesmtplogicsvrsza15-1.qq.com (NewEsmtp) with SMTP
	id C498305E; Tue, 15 Oct 2024 18:49:09 +0800
X-QQ-mid: xmsmtpt1728989349tzleicd27
Message-ID: <tencent_C4C8065D09956EC9EED90C8727FC06D75206@qq.com>
X-QQ-XMAILINFO: NY/MPejODIJVd1aLiI5anabvtnV9fBi6AcFEwTxpcolqcNOaL7SJbKYnyhy6Bf
	 H/fqd1Kbza1s87knh70yk6e3ynWj/1NXl4ujZFG5s5uvOBVw9j0p8ORSEtAcXZMlnmBBrz6oPehB
	 KSaR44oZAUPXTnuyILweSTCv4lcowQ0zml0RINXm2owx6nkCz7G97qgZQ2Xbu53Jr6drck58yAw7
	 5onHZeK3wxo2JNnT33uxK4JvARZ9MfcvO5pcd+RfhygTav/0j7XUUwuhvmgHdY0QKQb2FAR2FMij
	 43lUmBxbHMKdFavbJwebBPed1RlD/y1uglFLttdVEuH98UMaRyni8CbxpKyd4JL3aRcUI22WcR33
	 /97IJ5ksF76cDPrMApVtoGUKqcI8SyyuI4eL83m6k6SaVeKxMS8U27zBjaaJLO81f5ZiXH7h68bX
	 SnCEkyNCkFmZKqlbLuAsLVYkT011ESVI7epuJh5mp+/5d+n3cyw9KB8sNbkg6KlvFtw7A1kr/HSF
	 rhR0d/9yEuSz8MvwdT5yxvnyIOw2y7nrPXjrn5Mk29dlDv/CYJfvd3ArpTnQR1VsXrQ6hqRByCcS
	 juwLiR+7UBd2MTjAGIl7qQJlAjadTmsY1d2OhrNxIyjbSVwy8+wor7g5meiDnre5EvXZ2Ud+7vA3
	 e/Mg5e/nZX3yFvTql66cVfnU2X5RtiTtW/b5uSUyQNOdBUcpCkYoHLMc+LYH9O0YAzaJr63arJFY
	 VyH5nVhwlcaihDyypyqH60AvGAp48OhqaTZtRpIKNkCP2upedngw6FvKL5+NGqt9u31663L2aemw
	 2mjFctrNnnJLqKagcGlyGOrE57IAlFMH80VLk4H96KbvUfEvIkrIQUOVvOYuCkwPzbh2LTZc4ZVa
	 WkX6vc9ivJOZ0bOsSg/GxMvedNMgcuQVFV3OBvQnDj8lIcDs39yGy2CmfxXgoT+B/aJ4aAc1hAKe
	 THVpXpJzE=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+c3a3a153f0190dca5be9@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [btrfs?] KASAN: slab-use-after-free Read in add_delayed_ref
Date: Tue, 15 Oct 2024 18:49:10 +0800
X-OQ-MSGID: <20241015104909.45566-2-eadavis@qq.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <670d3f2c.050a0220.3e960.0066.GAE@google.com>
References: <670d3f2c.050a0220.3e960.0066.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

move head_ref->bytenr to the protection range of delayed_refs->lock

#syz test

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 13c2e00d1270..f50fc05847a1 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -1012,6 +1012,7 @@ static int add_delayed_ref(struct btrfs_trans_handle *trans,
 	int action = generic_ref->action;
 	bool merged;
 	int ret;
+	u64 bytenr;
 
 	node = kmem_cache_alloc(btrfs_delayed_ref_node_cachep, GFP_NOFS);
 	if (!node)
@@ -1056,6 +1057,7 @@ static int add_delayed_ref(struct btrfs_trans_handle *trans,
 		goto free_record;
 	}
 	head_ref = new_head_ref;
+	bytenr = head_ref->bytenr;
 
 	merged = insert_delayed_ref(trans, head_ref, node);
 	spin_unlock(&delayed_refs->lock);
@@ -1074,7 +1076,7 @@ static int add_delayed_ref(struct btrfs_trans_handle *trans,
 		kmem_cache_free(btrfs_delayed_ref_node_cachep, node);
 
 	if (qrecord_inserted)
-		return btrfs_qgroup_trace_extent_post(trans, record, head_ref->bytenr);
+		return btrfs_qgroup_trace_extent_post(trans, record, bytenr);
 	return 0;
 
 free_record:


