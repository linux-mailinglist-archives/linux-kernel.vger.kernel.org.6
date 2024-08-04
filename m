Return-Path: <linux-kernel+bounces-273732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68791946D16
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 09:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7872C1C214D8
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 07:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA3A17C68;
	Sun,  4 Aug 2024 07:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="AOI/rADU"
Received: from out203-205-221-155.mail.qq.com (out203-205-221-155.mail.qq.com [203.205.221.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6037DB67E
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 07:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722757075; cv=none; b=AIr9dVejpQ0G1aqYZfEwHA4REPItcnxX5xut9uPVDMXUVGGH/lHI61qL7IkLJpsFVhNNl4BrDKmlA1jmJrGWgx2WxV7uZOnRxEKtvtobaLgh8WRsYyzZFx6BJM8RIcoIgpgkR2CSyqn+dheJ7afdeGnkAxeo5BkyC65OuwgOGNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722757075; c=relaxed/simple;
	bh=d7MTlfsOFlhCujaapEC+0wi/rkr6DqF65rSr7xkhlbg=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Tng67AfkPlmlanFkHgAOHyNRpL9ZZV7hVVlsrS2SAgKIX1yZi51jfntTOlz6d3miT7joGRYV6Wc3y46SrCEv9OVNYQflnAgtKM8xdjH4P+2FO6HJUg2ytAXyB5VWSbKyJIA7paFSc5ZrxYLNj/S4cLSacziSckxkNzbu52jEDCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=AOI/rADU; arc=none smtp.client-ip=203.205.221.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1722756763; bh=omYkRP9fklddOT1lpvnvwQtdlKmLz7lo13X8d9alXho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AOI/rADURmj14ILnd7RhOe6Le99PWXyvGIVbWZVL93hRGGMW2UpNZzMqKaPoV84kV
	 51IZc9x3bAwTYrPJSO68EIx51YCxFRfVn9KqqohD41ve108LjHQaNrzrlyFTtvtHjz
	 fwkok/oHOqV28gSU3KOTD6gRVSxqrrB2/OuBAEKQ=
Received: from pek-lxu-l1.wrs.com ([111.198.225.4])
	by newxmesmtplogicsvrszc5-2.qq.com (NewEsmtp) with SMTP
	id 829260CF; Sun, 04 Aug 2024 15:32:41 +0800
X-QQ-mid: xmsmtpt1722756761txber3db0
Message-ID: <tencent_3753976AB76BE6C03368E36CC96363BE2405@qq.com>
X-QQ-XMAILINFO: NqN/wpVFVRYXUB8bZDyxXjZkoTNpZThpuixc5os0/u9FNsm9G72XVagO89/5tr
	 BRpfaLrL1lL3+tbZnyu5vJZPIJouWI+pK5g/xiwE/+EuXuvf5ktGAeuoMiO/RBD6IvZxa9vjuGWc
	 r8gjTBb84a4QiDqNunQ09C4R1Ce1HuGEYe5ue6sYTzC4lpQNTA/lu1PREoAI8A6ujp+a54ejTr4b
	 TzEY1NriyoQw8ciDJr6hyE5XOEX2H6mbltUPoyfj/zZ5ELhk79b2kLHwqFlaAeu4OiKNwDRGhoQ7
	 t+Z9lgZJtmQuVXYnvaIli2S/wjp2Clkxwe6xeJM3PPsGTMdiVGnhccChG27oPMJGw6O8yLY/qz8v
	 xAVcAarcmu1YpaCh4GV0b8GpMTKJMICYHV33LAb68SBRPTkQ7RFgDv5xe4V7FQDTZ2ueONFegVxe
	 uBH5WsAy25ftLTJULeRzLsv1t2YY6lH/X12MbS5rf7YYHBffdOiJkUmvC7V/Q0CU5itdJjFvrsmI
	 5vtIQH17ZzcKlvILo4+bxs3AgnMXk9wTRHfQt78IhOYcUmeakbQ0D2fjWZ3iOv/ggZc8F5m+oCM+
	 +Qe3smm5H0mXKFCgqBm3J4E6lTom+JFLxJuE9Lh8tgfmWU6PSCQdvTF/dhcjVbKD7rSzTSSY1M9j
	 yHlzyPLZ80UFplRM2voyhp1FEQ8n9xg7zt2ICbeewmIXUpRycSvM0tVX7kx2V6LzTNnRlN2Dvz7t
	 wqu2D9Cg9NAcUu5wLjWUk33jY/qeTJCPNZoBMUZduG7CZnzywMD8pjOcdj3RYWj2M+MST5ZLV492
	 IBsOeA0C720Ly/5CjJ3SttbpKOX8qpiFPknYkpfARb6Swp+fHyE0tj685nbPRQPmDVg2uYmp8dyv
	 AUpVDCKR9YB/0fZQMMcsw7JWpCkT7dvUbJtOxPeXZh
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+eda89a33c5856f66f823@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [jfs?] INFO: task hung in txBegin
Date: Sun,  4 Aug 2024 15:32:36 +0800
X-OQ-MSGID: <20240804073235.2495544-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0000000000001f253b061bb8a953@google.com>
References: <0000000000001f253b061bb8a953@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

with sb rwsem lock to order syncfs and wb worker

#syz test: upstream 50736169ecc8

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index b865a3fa52f3..172ca9e1eed5 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1865,6 +1865,7 @@ static long writeback_sb_inodes(struct super_block *sb,
 	long total_wrote = 0;  /* count both pages and inodes */
 	unsigned long dirtied_before = jiffies;
 
+	printk("path1, sb: %p, %s\n", sb, __func__);
 	if (work->for_kupdate)
 		dirtied_before = jiffies -
 			msecs_to_jiffies(dirty_expire_interval * 10);
@@ -1993,6 +1994,7 @@ static long writeback_sb_inodes(struct super_block *sb,
 				break;
 		}
 	}
+	printk("path1,end sb: %p, total_wrote:%lu, %s\n", sb, total_wrote, __func__);
 	return total_wrote;
 }
 
@@ -2720,6 +2722,7 @@ void writeback_inodes_sb_nr(struct super_block *sb,
 			    unsigned long nr,
 			    enum wb_reason reason)
 {
+	printk("path2: nr: %lu, sb: %p, %s\n", nr, sb, __func__);
 	__writeback_inodes_sb_nr(sb, nr, reason, false);
 }
 EXPORT_SYMBOL(writeback_inodes_sb_nr);


