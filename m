Return-Path: <linux-kernel+bounces-405394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 381F69C50B9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 09:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E167A1F229F2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 08:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627AF20B7E5;
	Tue, 12 Nov 2024 08:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="qqCbHHbY"
Received: from out203-205-221-190.mail.qq.com (out203-205-221-190.mail.qq.com [203.205.221.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D86208999
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 08:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731400515; cv=none; b=u0lAiViWF/QVd64QvUGGpkxXVl3RbO/l+oJbiJnr1aNyEkPUvFEaikD0kdZJ4U3MrO78+DRn1toh3anY/eNdT8z+cTPzDsOThCwYtrXY7K6MHFOUE5xUQD1pzIKFoXl+wpHvYYDQvrcFsysi+hRzDu+3sCeiuZncwglLeFWgs8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731400515; c=relaxed/simple;
	bh=yOJt1JU2WCPimdhlzcBbj157gyGVwGQKcieS91z5apA=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=F85EVO9pW//DPUiWc6bch35MsaC+kEiy7y4VrgogMUaekQFpX7RCtPPDa/zhlwk9O8JtBkUDfQ0f1J7v5nJ5S0VviXuZ0qGDKrZa36UWQGON6HDPZgyPRXZ2yGknHZPHYaxFHvx6HLr3iTLvKnelAeVcDbrVOgG62sP8VYNXPkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=qqCbHHbY; arc=none smtp.client-ip=203.205.221.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1731400502; bh=IRU3M3O1x/Dpmjh3mkGbJkIGWbDWGC3+BfUrOB6tf8I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=qqCbHHbYkR4h7M0fGQODYC3J2CHXEh/0q33OPzhThW6Q0iXxsCBw8o7SFOof9L/n3
	 Khk2yBqJVZIzV19QFFJ8umfxbGWban0umT2qg3moPSu/BybMgDMZ2nK5AsH3nqAyXz
	 KwUN/1yuVeTtKL+QQOAJPrrBfKyHVbfZ8fFJXh7I=
Received: from pek-lxu-l1.wrs.com ([111.198.227.254])
	by newxmesmtplogicsvrszb20-0.qq.com (NewEsmtp) with SMTP
	id 8C131C1E; Tue, 12 Nov 2024 16:35:01 +0800
X-QQ-mid: xmsmtpt1731400501trsh9xyos
Message-ID: <tencent_7423BEE445F76E7764C6C2336F8364696C05@qq.com>
X-QQ-XMAILINFO: MB5+LsFw85NotBAAAy0fbcgvI6y0eCCCYCtQZ8zqlGEPgwePZX9QqVFjIbj+eG
	 depg8iBRd8872fMzsjoDRTSQ0Oie90hmja2KK0qFQJYrj/maS9rIHI+GON9myvzaKdPwfOFVVOPh
	 UqDZPm5A2VvAYOER4oWmbpsXiIsZjeNMd5EEFRbNQ79rFaFv/UTUfXYWmlQZkox4Lwc35YItsvaG
	 rB+/X3oOg6fzNCohHyCP6iMOkHIMRp4Z0ClCuv74+TXgsmcoXuOFNg+PskrBxCXj0sSWzGSOTzEf
	 YlR3TKH3+jxpMFoWMnjVJiS8I0kWVUDmNHyTRChFLDQYYKb5E/7/6ECuJCfohWp8GthIe4wcFtiz
	 6vlRWRkyB7MW17HlddzqnYbUrUN38qyapUOt3q/W8szj97ahkH5/En6JvY/mvy4ImkO4fRiIO91u
	 UekUFAPUhGpJQJsbdJg7HWvzdHkhneGEoiBgFTvBRGn5a3gY2IIivqJBg47EYTerSMUzT9h4BnfZ
	 zhBcowGBOG8ly/moA55boyeczuEeGfKav335vDvH7cUVwl1G1eMlN88bSMK6ioqXNl4hZkIXBwNp
	 r2eLriETDL085eqYvuPhnIoI92R5NmJZHqGNNCrvD6hTHQN/PB90jYnRPTQaNd+jmc8JpDRulghg
	 kCbvOgHZ8QySc5pUU/Tx1o5h7idWZaT81eyd/Gtq3nvj3DTjVD+ahxWJTE7W4tXK/REEg2JK+M3m
	 73vEmelBphRWQCjX1f888v44aE3CeuGW3t13b2OZw2AlpP+v7ws1ENc1NiX4/vyZqzJNtm/IKCTo
	 /YRTZ3+0nrZ23g3kcUTuTi/Hl2YfdUHNJvMcGFi2FtrIraVktEKJWn3Bt2qBbP7v71zgncA+rlxg
	 Yd4Zo0AHsFKQ+NtNfdPPbWWkW87FfEBR0toIr9IInsze6PROmHJds=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+96d5d14c47d97015c624@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [nilfs?] KASAN: use-after-free Read in nilfs_find_entry
Date: Tue, 12 Nov 2024 16:35:01 +0800
X-OQ-MSGID: <20241112083500.1405986-2-eadavis@qq.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <6732e1d8.050a0220.138bd5.00d3.GAE@google.com>
References: <6732e1d8.050a0220.138bd5.00d3.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

calc last byte dec reclen overflow ?

#syz test

diff --git a/fs/nilfs2/dir.c b/fs/nilfs2/dir.c
index a8602729586a..f014b7fed5ce 100644
--- a/fs/nilfs2/dir.c
+++ b/fs/nilfs2/dir.c
@@ -317,7 +317,10 @@ struct nilfs_dir_entry *nilfs_find_entry(struct inode *dir,
 
 		de = (struct nilfs_dir_entry *)kaddr;
 		kaddr += nilfs_last_byte(dir, n) - reclen;
-		while ((char *)de <= kaddr) {
+		printk("isize: %u, n: %lu, last byte: %u, reclen: %u, %s\n", dir->i_size, n, nilfs_last_byte(dir, n), reclen, __func__);
+		if (nilfs_last_byte(dir, n) < reclen)
+			break;
+		while ((char *)de + sizeof(*de) <= kaddr) {
 			if (de->rec_len == 0) {
 				nilfs_error(dir->i_sb,
 					    "zero-length directory entry");


