Return-Path: <linux-kernel+bounces-373092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F8B9A521E
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 05:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90C611C2115C
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 03:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E7C8831;
	Sun, 20 Oct 2024 03:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="mb4QxhFZ"
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2900C79DC
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 03:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729395318; cv=none; b=SgbYxSsNVAZsT7ntIbnTV5u1/1BNihA9PPYVB0CMG2mteq/q5typavW/z6ccVXh8C/nmYf2c9hUNHKRGJOu68NVIGl1FZeb56pZrd/Sk699pLEtF8wOFod/f1ZW96hUZx5lIC17yWzOpmd7CrStYjNJ0p9CGIHJN+syZxgPRF6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729395318; c=relaxed/simple;
	bh=Z0x1981zG3ZYuYYAirYgLS/KH/VFbyZ1v3MqtFfsEOk=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=P3m8o2Sf5ySr0EJklb8JqmzCRNIlvBiesV7nhCX6jBUlkv2mZFm09MLzf5q/jQlLcQxK6Mj1G2qifSJ+WSTkvnbfFW0pN2Y2vdwAUtir1JtePF50MF4GufMijBYGTMDJHkL64U5FJyi0/N2o2juF4Otoy2G+khBa4w/6E+rRCw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=mb4QxhFZ; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1729395309; bh=dGtPwrXvsrcoXZ0EWDeowsuRQo1Vv7lhG9R0Qgq6fK8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mb4QxhFZ4GhnD0tvu6+xlPH+orsNJY/kWgkJ15kNxl+jyx6Aa3uQsUD2kUYWkT3HR
	 PGzFdAUgGAvzdPUsZOLKelnEJyxi2Gdl9dgktPfow30BHz7EUfNbKHMH5ikFsmtCxC
	 Bm0sdoNYvEnaIVGt066Y3r1BoaHI3niLeTuZ3hQc=
Received: from pek-lxu-l1.wrs.com ([111.198.224.50])
	by newxmesmtplogicsvrszb21-0.qq.com (NewEsmtp) with SMTP
	id 8C810035; Sun, 20 Oct 2024 11:35:08 +0800
X-QQ-mid: xmsmtpt1729395308t6wnjj467
Message-ID: <tencent_87498E2ECA6EE38C96E7C6C6F952D3C65206@qq.com>
X-QQ-XMAILINFO: NkHKfw09D6j8xDszqrDnNcaTS3gRmz2NWwIBkuf7AjrHRZj5GmqL2KKzkkpVK0
	 aNSG9tmoqhuooNTpYW/mfruPVAo62PiRmRVCRsbIWTOo4DSTcZbvoUcmw0vOuaBKojBE9Ho4eozw
	 xaMXGXHStxNG+JZUXYqin3MlGcbxB7lxRRFv0vUXPynvPvzgw2PyhMT5I1ogPRFWfrzCTiUB3cHC
	 sHTa2n2fxLr8EDyvUiKd/gmnVwcFGTxdfDm+qw6j+y16Z+fHo4U26UmUhG+DJC3hq8f3BnZeFTgD
	 pvikR1V9xdo/B6LgAnScVuzEb5QjxztDhCfsQKd6UDdNslU7baE2ZGIVSadiFfaTVCi98h87zHPp
	 vTjoc4SZGgjwi8YtRK27MsDSZ2worOpY15RbpA3ka+uy4qwtt+l5LFikUaNNFauqaa5SQhq4xIoI
	 lUlCHe2YcpmQ5CG1UOFMhppMyvHnsqAoHZT6W8seDECplWqADD7uZIAFCl39FC8OfmlS/YXawHkn
	 DSvPGuhhaH+fbNfWm1UfaAXi2NC+73adO0+qKvQVfXJtA5kDIPFGZ+H35ngtgAM/3kMiOfJJv1Fa
	 5pTj9+v+PcVzDezVjbOPtVlOOxzGAd5QMaq2e4k5J9vM2Z18ilUa4juKKEuGNd0TTicoieEe1BHr
	 ER2CCfiGOqZeUCTTS2ApNWqV5b0t6jm0Z7zfoSj92N5rwARy5j1I8mYSISjJYfaCEEYxv4Ag20bn
	 CFa8pnqBetMvdZneyUxy1MBqwxw+hL6MYzUAC7aF8bgteHpGim0lPBUg0pL3iXa9kIycxlMv74SK
	 1CkWdi7I3W5r5UVnFmW+O+bOk42TPJ1q1aF1ZApTQXL56+ihTNOr2OHXeWE9lJle0bM1Kkb/TUaQ
	 1NidKULF04lZl1/WfkW3xkrtfilbEOw7KQvu8FDzBdySLHOWrxf5oxMzGrhJ8XDOfjz233lHz5Sl
	 rrufYa3v8=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+4125a3c514e3436a02e6@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [xfs?] KASAN: null-ptr-deref Write in xfs_filestream_select_ag (2)
Date: Sun, 20 Oct 2024 11:35:08 +0800
X-OQ-MSGID: <20241020033507.2327353-2-eadavis@qq.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <6712b052.050a0220.10f4f4.001a.GAE@google.com>
References: <6712b052.050a0220.10f4f4.001a.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

catch can't pick any perpag

#syz test

diff --git a/fs/xfs/xfs_filestream.c b/fs/xfs/xfs_filestream.c
index e3aaa0555597..f4c731fd61ea 100644
--- a/fs/xfs/xfs_filestream.c
+++ b/fs/xfs/xfs_filestream.c
@@ -159,6 +159,8 @@ xfs_filestream_pick_ag(
 			free = maxfree;
 			atomic_inc(&pag->pagf_fstrms);
 		}
+
+		return -ENOSPC;
 	} else if (max_pag) {
 		xfs_perag_rele(max_pag);
 	}


