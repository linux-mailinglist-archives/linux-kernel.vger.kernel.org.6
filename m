Return-Path: <linux-kernel+bounces-545943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 618B0A4F41A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 02:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9BF91884AA4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 01:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D75E1547DE;
	Wed,  5 Mar 2025 01:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="FzpRCQsY"
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345E4146A6F
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 01:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741139620; cv=none; b=UleJU9/oRfhqmbmX+u8OKRWE3F2xDK1KnvmyiHgPHHz7IIF1QjgL/LE9G+vvQ4+ubgGF6Lgjkf9KmvRb99IqcmNeEWxDuX1F++RbKaKakEIBj8nEOeADOyoVQCoqBIJKWrD0l972XQHoD+oFIRN/80XECHUh3DeCc8ab+74FcG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741139620; c=relaxed/simple;
	bh=jiVZ20j6qP/HibU0z1Wfh4y0K8pQQf9Clj/9kePiVGQ=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=T6fsjfXyftHeE0UnVe7VjXMx984WXHmx+u6s+awgECSJGgQXOkZ5KKbogGox7bj0fiO6vl7NlqvSp/ew60LFbPDYRalQJZ7/x8Hn7EXfBthvPu6aei2CsHojJWiJR3d0oFlY+OLCkmcsjoZTf7SGDUxWZN3g9gxbQDg0v1fV/PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=FzpRCQsY; arc=none smtp.client-ip=162.62.57.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1741139610; bh=9LGLmHdFQaKXFTo/N4OLsN/9aBc+/pe07akCu9tcFEM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FzpRCQsYBQrRm626HN6PNY/tcDaJvRMSd8nENFO8eO6heSLV3gH55mz6uZHL9RXEC
	 s3G6wJ5pKVXAY5guGPJ1Tkbdl9D45Eciqz01PO0M2ZHWmSIQrOC+KerVl2xq511qzc
	 xP4KtDZgRfoDTB7TWslSKcrJ1VbWzDxWbGmZ5uM4=
Received: from pek-lxu-l1.wrs.com ([114.244.57.157])
	by newxmesmtplogicsvrsza36-0.qq.com (NewEsmtp) with SMTP
	id D5C88A5D; Wed, 05 Mar 2025 09:53:28 +0800
X-QQ-mid: xmsmtpt1741139608t1vdldn98
Message-ID: <tencent_1695E0E90AEC5ACFE478EE6F0C2DC56CE00A@qq.com>
X-QQ-XMAILINFO: Ny9b0zP53WzJG0B8Sg7QdXElLIL67uF56qxHRq51liAmPWA7qhcCYWGttJwQbV
	 e8sYOEU4L+JlL+kyzU1M5HNblgAHM42DWp9JakXLs94DCCukMeNArY3+bofcbUAqE6wxBx3htauR
	 qnz7kb/8PRbLE00UqHkpM6ACInMdvXGDaGeOHr4/kDNkgIif/iknGq8MAF/LeY7WnWwWSqJANpE2
	 giKBqEFThSMV2PRewqzH1/ccKZFFk4yPIJa58nKqdCjqZSzM8q2g0z5WIfuZfNJNKC1gTsP2vsPZ
	 MwMdO+DJiXnYRsx/GyIQFnVxpG4gQb8eo4NeGqlALvrkY1LeJ7xqk7ZRKui2i5Oen94lNqbYCpXK
	 MpVvWspJYhSRqDgf9sugWnxjwx2dKN95ul2YdTIr1NWWoZb9DLaui0uoBLx2xvl7E7Lt0sfUJfnh
	 w1zBhObEQJf7vc5E4b3uHoqZaD9Ova20G6ElNbf3etWR74NEgcNUwSPaykhkQpJAo27h6F4mb0qA
	 nTgqlmaXSg396dFlIdiPt/AWIJzVsLV94LwLfleW2rDuIq9Bhq3r8HUoHCPSGmV+fxxWPHwiRvRm
	 ooAget4Kj8LlWUgERMeUkvSXQd/fs/4Ep4jbw/YLQqT+2da2U/m1FRsddXTwaUZJw7R7ddyLFSC5
	 vVHtuCkgPLUhdhIHxurQdI6IxXDs3BI9Pcd/UrUmG+5nR+8bfR2EU+RP1R5Kx6pks7ZlYPtatRrx
	 coonCxqIjsMTfu3MUQhFHLqxx7Ip6OnfeRURD/Xiti2mjHhW87/RZEWvl6tQuAWRzLr8GE8B6Omn
	 73frwYbdAXlXVkpYZt9JfodSbBB9YM5kC2IwyuzEMImjoegyQHIv6V6QDSsIXUBuBKm53bU9SfZu
	 sToXdzrWvLdi2RoinoCoWg6kL1Gk8AsrQCXFsY4HAnev+zeUabXxw=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+9f6d080dece587cfdd4c@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [xfs?] KASAN: slab-out-of-bounds Read in xlog_cksum
Date: Wed,  5 Mar 2025 09:53:29 +0800
X-OQ-MSGID: <20250305015328.848304-2-eadavis@qq.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <67c72724.050a0220.38b91b.0244.GAE@google.com>
References: <67c72724.050a0220.38b91b.0244.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test

diff --git a/fs/xfs/xfs_log.c b/fs/xfs/xfs_log.c
index f8851ff835de..160eb6738c8c 100644
--- a/fs/xfs/xfs_log.c
+++ b/fs/xfs/xfs_log.c
@@ -1581,8 +1581,12 @@ xlog_cksum(
 		union xlog_in_core2 *xhdr = (union xlog_in_core2 *)rhead;
 		int		i;
 		int		xheads;
+		int		tail_xhead_len;
 
 		xheads = DIV_ROUND_UP(size, XLOG_HEADER_CYCLE_SIZE);
+		tail_xhead_len = size % XLOG_HEADER_CYCLE_SIZE;
+		if (sizeof(struct xlog_rec_ext_header) > tail_xhead_len)
+			xheads -= 1;
 
 		for (i = 1; i < xheads; i++) {
 			crc = crc32c(crc, &xhdr[i].hic_xheader,


