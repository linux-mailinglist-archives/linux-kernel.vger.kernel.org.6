Return-Path: <linux-kernel+bounces-234917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DCB91CC68
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 13:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71F50B21E06
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 11:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0FF24D8BB;
	Sat, 29 Jun 2024 11:34:35 +0000 (UTC)
Received: from mail115-79.sinamail.sina.com.cn (mail115-79.sinamail.sina.com.cn [218.30.115.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9831CF8D
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 11:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719660875; cv=none; b=W0A8HthzPbj97RjMy+PBdottH66SeHg4ZjQy48uCEqOJLK4Jw9Az+1tOk0Q23U44apC5JQXsD8R1UB0F99a8M6r4hTVl7Ps0cPBjSXG7+F3ClOuTqutbCwFvKf+jMQeNugcPEOjWgPeHYpVNZG1CWZiaUQHk5luokaBqKgGDUkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719660875; c=relaxed/simple;
	bh=NoZvw5o7A0OPYT8I3b8UocLC03Djw97y9ZS0/qEOGKU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CibNfX4u5kimwutQETeO1/xoYKFQZP4jt1FDFNKVRORVCMzoEyja/2VXTmHP2D+9VC6JgwYHVhaWgB0YiWwvXSx2L1la1xyZGZxw6apJNv3wKdVRO/6lUiJN4I4eKtIUGj9a1jmWaeA66fu5eVmdaER7WCIJW8FV34hGOLy88Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.49.233])
	by sina.com (10.185.250.22) with ESMTP
	id 667FF113000025F4; Sat, 29 Jun 2024 19:33:41 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 5198867602678
X-SMAIL-UIID: 30223D5B5A424F7391FDF3C063622554-20240629-193341-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+55cd5225f71c5cff7f6f@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] BUG: sleeping function called from invalid context in lock_sock_nested (3)
Date: Sat, 29 Jun 2024 19:33:29 +0800
Message-Id: <20240629113329.2452-1-hdanton@sina.com>
In-Reply-To: <00000000000001140f061c0322d0@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 29 Jun 2024 01:27:21 -0700
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    6c0483dbfe72 Merge tag 'nfsd-6.10-3' of git://git.kernel.o..
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15373b8e980000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  6c0483dbfe72

--- x/net/bluetooth/sco.c
+++ y/net/bluetooth/sco.c
@@ -1287,16 +1287,19 @@ static void sco_conn_ready(struct sco_co
 			return;
 		}
 
+		sock_hold(parent);
+		sco_conn_unlock(conn);
 		lock_sock(parent);
 
 		sk = sco_sock_alloc(sock_net(parent), NULL,
 				    BTPROTO_SCO, GFP_ATOMIC, 0);
 		if (!sk) {
 			release_sock(parent);
-			sco_conn_unlock(conn);
+			sock_put(parent);
 			return;
 		}
 
+		sco_conn_lock(conn);
 		sco_sock_init(sk, parent);
 
 		bacpy(&sco_pi(sk)->src, &conn->hcon->src);
@@ -1313,9 +1316,9 @@ static void sco_conn_ready(struct sco_co
 		/* Wake up parent */
 		parent->sk_data_ready(parent);
 
-		release_sock(parent);
-
 		sco_conn_unlock(conn);
+		release_sock(parent);
+		sock_put(parent);
 	}
 }
 
--

