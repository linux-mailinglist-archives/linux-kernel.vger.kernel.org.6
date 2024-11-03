Return-Path: <linux-kernel+bounces-393709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C8EB9BA43D
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 07:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 190DC1F21612
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 06:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7BC145FE5;
	Sun,  3 Nov 2024 06:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="c469KUfa"
Received: from out203-205-221-236.mail.qq.com (out203-205-221-236.mail.qq.com [203.205.221.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37FB143C4C
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 06:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730614100; cv=none; b=cKGZs5yAob0CZ3sszsK3+aUJpEk5nKCIKVxwfiLogLdagAaXTPkpSAskQfBLmQUSQY8ixokcKNK3++w+jSz5d6N5j17Sz94uZbGgKKBxi9fQBAQN7wcdKvVRV1Dq8AWblLc1TiFhvVOrK491+b2T5Ha/7WRSvtd92YtT6pjNueM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730614100; c=relaxed/simple;
	bh=pve6vO/i+jMXtF5J8dML6xMhayjDuwv5GfcsHG4CZJ8=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=pzwhVKv7WkpXZgtLF5leQBKQ0GrXjCLGh7QPXxtFZwBWjLz2fL8J67A36qadr98A9dnWR89lx3tCS+iiVENRDHUOj79L+xw6FQGl6tQcmpyqYXDHk1i+kxlsUTLu5ySOmjKRf63gQlSVQjOHuejlve4Mck7vPK8wneng2V0IzPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=c469KUfa; arc=none smtp.client-ip=203.205.221.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1730614091; bh=Gjcg4Hj4Wx7LB7zABTS3wlz6fDq4zGCL2p3txSVNDmU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c469KUfaPibp0D02Hm0+hIdBEUBxedNbJf80sIoUfNbjLeMskwrUz8GkLYIVg9zl5
	 MAWW2b8Xp5SbTfRxmyL1SPt4Y8rCSxw/5CsO3K21OcpkM9s7pN9IJosSmnsi81v2WA
	 Us5MeFsmIToiYlYcCxd6UYLuoWTa2kvUllIrqKj4=
Received: from pek-lxu-l1.wrs.com ([111.198.227.254])
	by newxmesmtplogicsvrszb20-0.qq.com (NewEsmtp) with SMTP
	id 2099EE58; Sun, 03 Nov 2024 14:08:09 +0800
X-QQ-mid: xmsmtpt1730614089tm7sjiwcr
Message-ID: <tencent_357089BF2EF46ECD4C8DE7DF46F312CDC606@qq.com>
X-QQ-XMAILINFO: No7DFzN00JnRMIS22XzL3JMkY95DjhpUvttPgwoKND7gT8Y1hcJlyEH75lR6IQ
	 KcY0oTkqBlzO1H7/ikm4k99g7y0h88KCisj4mo1rmDTYhj87MOAVM8mc4JWtzUBDZJ7bRAkdo7IK
	 JRfDETHt4I3wCzgkVDQtd6WNSSyqEk+WCi7N0T9PJcGSXf9GYDzFszG2n0XDg/uwhZgkEZjRRlCN
	 kiWe311JfiCkJpQGcvrbTC9OZbU5aofkwHp6hawG3A91AOcDg2TBzVkjjJSgelBnfU+PWPAdfqe3
	 ytpq8g2Mx5HaxrjTc8SS5pBHY+kFGx/wrvcS1Kpu2rbYweeffQ9gqPfh2oOT0+Gy8KOBteuTWwmv
	 uBMwCe29DEHzZUs4XmHyl4UQ13a+ewGx7oxCt+j8UV15iyrxNlWyuV7Qpftl6kStw4Pfmo4oiiIc
	 SdYMATFEyoH9Bl9LHSy3BmTylvLCEtKoyWOU1ReafzbiCKl9cDqK4X3l9/drV2tYHqq/ZceOBrcD
	 JqoT53YR7ZRPWpoXuoyzwt8LiYzHF6iv7ELwH+0gusggj6n59MXI2lJ6L45cem88NV7VsqT7GZq8
	 eBwdrbcmW/tjim7XLwC2KGVu9Cl6xM6ZP7ZXN4kGTSpY2jUZoUwIg7aYM2GbZa77c+y0ugB7E0mV
	 QNT7DJi2v3N4NKhRnxpy5sHUkgo+45xTKSthPM5QDTGuWTtisqXIBNUFlszLpvY1kOs6k3eeqy3R
	 +C2d/wMI0aTlv4P0wR9CtfngOJ+jkS5kqgmC+MtcJW5rW1XQ2NcpOiZ7BOwma+EwdC40psply2lB
	 tve3V/QKqkle/LoY/ufK0E7c6PTOCHXNTFqzhiDZcD/VKEqQsldwxdk+jHkEJUvdZjEKKwOXuC3t
	 fXGAW2zhw9ooHGJFUyR6ocM9MQpwB3Ld/50aaIwTvU76l198s/0jE5MDUwIZdm2RQkJ/APKysJlT
	 y/UpW1iqOE+zabpkQIvg==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+f51a2a34984e4d8888fd@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bfs?] general protection fault in bfs_get_block (3)
Date: Sun,  3 Nov 2024 14:08:10 +0800
X-OQ-MSGID: <20241103060809.804118-2-eadavis@qq.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <67218131.050a0220.4735a.0265.GAE@google.com>
References: <67218131.050a0220.4735a.0265.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

add a check for new bh 

#syz test

diff --git a/fs/bfs/file.c b/fs/bfs/file.c
index fa66a09e496a..5fb6428d692d 100644
--- a/fs/bfs/file.c
+++ b/fs/bfs/file.c
@@ -40,6 +40,11 @@ static int bfs_move_block(unsigned long from, unsigned long to,
 	if (!bh)
 		return -EIO;
 	new = sb_getblk(sb, to);
+	if (!new || !buffer_uptodate(new)) {
+		bforget(bh);
+		return -ENOMEM;
+	}
+
 	memcpy(new->b_data, bh->b_data, bh->b_size);
 	mark_buffer_dirty(new);
 	bforget(bh);


