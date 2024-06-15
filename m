Return-Path: <linux-kernel+bounces-215667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECE89095AE
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 04:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0431F283538
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 02:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7225B8BE5;
	Sat, 15 Jun 2024 02:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="qMTmfqny"
Received: from out203-205-251-53.mail.qq.com (out203-205-251-53.mail.qq.com [203.205.251.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753AA8825
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 02:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718418733; cv=none; b=CgFygO4iUrImkBW9cOjDOQiufyQZMBeVipxmrSkptZC/wHD24oFIpPRMgRslggCA90hXXYuWfsJlLXMvygsxwmS5Gf3pPWmSpeuZ+TMnOTLLobNSJv4uAWUf1xgWFFvmh0w2k6Uj5Oe8zHIwg1bhEYkZWPkPpZ/Efo4h91JAdFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718418733; c=relaxed/simple;
	bh=nbQfgvPdeXIDu8WT65DCVlG5XjQ4nSoRhTiGKfdDpck=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=fOgOKWmbO4pVKI8btx3UEVhaX1yWYI9273LNZmoMsuNLKlvpFH0fIjFx2Rvi2e7SUAjT5Cm91GhKwax6NZ7Y8F7+PNyehnVtbfDV4Viww5FaW/onVjFfbeLcLcOXK2y9oj3b2QV8CfGoYbr/esdgSMMXuWDibUfaye/QHKDgqHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=qMTmfqny; arc=none smtp.client-ip=203.205.251.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1718418421; bh=6hAqyrP6UwWj4t+o8mwaPSrgZwEvnY224lZy4GtT7xM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=qMTmfqnyXpedrIneWvUJTFK2up7SLdDSFuroVa4u6BBMphATFEOhPsMrcXESlYX+X
	 Eh0x/ad87VlGnatuyscHFnJbKzpwyIoTMyzjx5gfOsubrZXIJ9xdS5zMxyjuiI6VmA
	 /N4wMcZykn02dCXgaLM1f8Bc1+3LrBettr/be7wQ=
Received: from pek-lxu-l1.wrs.com ([111.198.228.103])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id 6BB9F467; Sat, 15 Jun 2024 10:26:59 +0800
X-QQ-mid: xmsmtpt1718418419turvj0wna
Message-ID: <tencent_8B769767163C3F3616964237F04BC074B109@qq.com>
X-QQ-XMAILINFO: OQhZ3T0tjf0aO645nJ9CGVH2jDx57WBcUYx8TBpKwHWArjdRqRerZ2dxoZPUDN
	 xRkwaB3CMryy0IhNj/ANG2c1AFAqw0bDpCt2x19N5/32ci4KGQqtyQ/0wkkPTEiLr1Yw8O1ru5z2
	 mNxw0iDwP9+onIqPJRLef1x5w91wuOycdaeJNOSQLZv+Aez78pPBbMJ177qfIHq7AgNb8I1O4VJY
	 ++wq1iy2kA2GcMdJLnMzMMJukEtSw9IZP7cNnlD6ziELqjzumpRiTBf8q74Mnzd0EdsKye2zZqan
	 iRAdT+27OUEnbGjGPQtl7bzKM57LzwSWJo4cKJHU+f/IAlSDFscA2IDMu2nsef3PIZ9e1YRsJ/f1
	 8zclKaVAMh3XEiIhMRXYzYLT4wW3LhpZuTSmhqtl4kgaiGfEGAtvP2vL6dQjIZyi1gv7WwGBS5yb
	 4JhEG5nwL69FSFp43T84768317OrCZg+yq1sZp8oKcSEAFZzoBgLc/3aBeRFj+4qc5U/8XcLaniq
	 xKNw5h+dfOmwKUcPhBPmI7exniGiRd1JiiihBqSotsRkXr5YjHWhOyjO6idwArOdrbKXe+T4gRtF
	 DiOdzUwpilCaA5COsoVnI+YV98cM4yM2pdQeDn9Pg5iKEvyTDzj4BkuhQ1LIGwJ2d2/V2oNqR3xj
	 OkYRLxtr6anA9MzZWPEqnmUgJ1Fhqt7z4GoDj2spX9L5kozdSypcDdTwhdDihk4GLXl5gjRtvKAa
	 rasdc6RELNIZ1IwXqMAj8UwVcuQ0FJ0PhpGgBhyO0DO3NRqa6J5VQvcivHJLu1vLiJ9lq0trw2WA
	 D0ZSKHkISAbGNSVMmMXMUpA4S5SxxmlVM6oC411+iwttxPQk4cf33F9WI2T0/Op5pQCcxSsKTF5u
	 UYjrHK7rXx9tqyKgADGlc2t+ju9w49S6+xr20jlKtzeymGbYUJlAB82IUBCFvubA==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+4366624c0b5aac4906cf@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bcachefs?] WARNING in bch2_fs_read_write_early
Date: Sat, 15 Jun 2024 10:27:00 +0800
X-OQ-MSGID: <20240615022659.3443907-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <00000000000053e574061ad89521@google.com>
References: <00000000000053e574061ad89521@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test no write lock in bch2_fs_read_write_early

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 2ccbdf43d5e7

diff --git a/fs/bcachefs/snapshot.c b/fs/bcachefs/snapshot.c
index 51918acfd726..b27a4327274d 100644
--- a/fs/bcachefs/snapshot.c
+++ b/fs/bcachefs/snapshot.c
@@ -1566,7 +1566,9 @@ int bch2_delete_dead_snapshots(struct bch_fs *c)
 		return 0;
 
 	if (!test_bit(BCH_FS_started, &c->flags)) {
+		down_write(&c->state_lock);
 		ret = bch2_fs_read_write_early(c);
+		up_write(&c->state_lock);
 		bch_err_msg(c, ret, "deleting dead snapshots: error going rw");
 		if (ret)
 			return ret;


