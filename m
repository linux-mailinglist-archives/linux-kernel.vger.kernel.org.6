Return-Path: <linux-kernel+bounces-377864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0FCE9AC7D3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 12:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B9E21F27764
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 10:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACBE31A08D7;
	Wed, 23 Oct 2024 10:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="QabmDlQ6"
Received: from out203-205-221-210.mail.qq.com (out203-205-221-210.mail.qq.com [203.205.221.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A8A1A08C5
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 10:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729678999; cv=none; b=JhS7DbT8Tli/q+SH72iqqfFvmiNyHq8gkA/K7pV69kh7nYynyoBOArZGwccyYdL/jq3ipA8VfHLqCplciSTYbGAQXH2A9AszI62mkVMK5Bw/pnhorpM/GbRc4AXSIU5Cth3dv5pk6clsUYOw+fT4vtcBIgbH4tvYeO0JhkcPv44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729678999; c=relaxed/simple;
	bh=lR88YYAk63UFRbOKdPyOhulUX80lvynBTUQ66IdwKak=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=seo5dpNNr65HSB4fdmIPdGshDIaJ7JiQ0zha+oQJNKIx9JTJYGreed7nprqyLUzudjYi6YJkrjyUx3Wyk0WJDdVRqIqZreIee57puwpTR0UPHO3XPBN593sIz85ek3LFx5ZEfHVZQVtzcQ1RSblLgbJFJhDP54yiRX+4Oaw9+9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=QabmDlQ6; arc=none smtp.client-ip=203.205.221.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1729678687; bh=vl9Xn58O2NJHYgGnOrCkACfNW3jd+gPb9bKgPNHhJlk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QabmDlQ67aI/lyt2KCxPbHy9zuVS+TjKJ27yqVNgI04DxSIwr9wHeLsu3v33nAC/g
	 Ig9IKCLkt2rEgxCwmEIYjufUW3VOkXPDKgxKe00WfPInvHZAW9fQP2WGbOF+QOCEAW
	 6IThDW+pgqtpUmfgY+mtm/9ieGFK9JdBNxxCSKWA=
Received: from pek-lxu-l1.wrs.com ([111.198.227.254])
	by newxmesmtplogicsvrsza36-0.qq.com (NewEsmtp) with SMTP
	id 4852A095; Wed, 23 Oct 2024 18:18:05 +0800
X-QQ-mid: xmsmtpt1729678685t6zy7z2hs
Message-ID: <tencent_A7941CEA22EDEACFC87A5A6C242D5D6E780A@qq.com>
X-QQ-XMAILINFO: MIAHdi1iQo+zF/zgUJiJLT0u0hWVkTlOx3pjP7HQC6YRlIgZwxFuKZAw6F3ApQ
	 RGGSFJTUMhB9uCpeOgks2Gd8pimKfZsotfZnaAQl4AWI/n+DCmIw64nrtj5U1agjo2fxfxlLtlip
	 OGRiNocFDlrwgPaDJvJvg6Pmom87aV6BIocUb0ZZ7yCTpPl8u96ytUTt5NI4iO/YWEePoDwsDYvn
	 Em1RkMzHXIVPOOOZKFrbhkG8fTkVqqPW5xBlwvvrNsV4/FStlYM/w+HBadYzymhhuNIP+labXldK
	 3fbPro6XXdEKdhrgxL8XUSDZbiNtVA05uFjo1FM3q7e9j7LewuShcGwP5kqmhn1zS3uzJP1skr0o
	 eyOohiSqtXkhdgamkbFyyljwLis7nZWFG1PlC2t0jjfQ6eYeG43yqlT1UNvXF22T1WYgVzriT5nH
	 alSsbd4h0Hl7tEBvIe8yzrfK2D3bhudRRFeZgBrjS+RL+4VlSrxTVGfZE0mxvxAGQvibwMF7uFkc
	 0pNuoiHLT9LALQnCFqNZ2mzmjz1zOK/jFfWJVqfCKvrEeLOApdHUQQLkfjnwWuaWaGgZszex7/ST
	 +IIUPiyQHTkFPwsTAKLpdwUdVvC7RZNW4QtnHtP97q7IEmx1iCUjHIxXIew7iCRelZtPOgxVkHae
	 EVIqzhTc3S6qwdq9OujJSwG9tDTc8hyFBT1i6bGxue+mtecj5FSnOYz7uYO1EHKd+u75o6IAdQRI
	 LtrxXqpqAS9gDbf6uXztQPXFXmUBPs7wGt/zknCpPRRbv7Z+7Lb416BKdWrbcGKqD8UNeYU+2rLx
	 nMxuRMJpi1xMWZ7kllc2FTsdsQa/V8U9Xv+XM11w3pjnoQJzfXRMFjzHCkuJ+FTXfGxOUe30MPqP
	 iIqPFQWv3tf/RnVt+cx5bCMbPz/2RLS0DKzM0IbZwinc0pDlsau9o5E5dhdoLeTyWTSFnioL8Z
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+5d2b33d7835870519b5f@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [btrfs?] general protection fault in btrfs_lookup_csums_bitmap
Date: Wed, 23 Oct 2024 18:18:05 +0800
X-OQ-MSGID: <20241023101804.268484-2-eadavis@qq.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <6718bd15.050a0220.10f4f4.01a0.GAE@google.com>
References: <6718bd15.050a0220.10f4f4.01a0.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Did we load the csum root?

#syz test

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 3a3427428074..1ba4d8ba902b 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1602,7 +1602,8 @@ static int scrub_find_fill_first_stripe(struct btrfs_block_group *bg,
 	}
 
 	/* Now fill the data csum. */
-	if (bg->flags & BTRFS_BLOCK_GROUP_DATA) {
+	if (!test_bit(BTRFS_FS_STATE_NO_DATA_CSUMS, &fs_info->fs_state) &&
+	    bg->flags & BTRFS_BLOCK_GROUP_DATA) {
 		int sector_nr;
 		unsigned long csum_bitmap = 0;
 


