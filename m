Return-Path: <linux-kernel+bounces-313982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 437D596AD44
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 02:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B82E22861B4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 00:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49E97F9;
	Wed,  4 Sep 2024 00:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="D1rnTOIW"
Received: from out203-205-221-231.mail.qq.com (out203-205-221-231.mail.qq.com [203.205.221.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04216391
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 00:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725409543; cv=none; b=OBP/tnAcyqBRkx69InebzvaQcJoXy39x8G4T11kjP8/+4IcMZ4BjkMPJel62kT89+swWoxtWv5GsG1LBzXgkXbl96jX5BakIYsLzl3go9QTb4epOUhFgiPQMTV4nyt4nxlZnjiayEmrcs1mZeBGjMXdqyyS/PzwMhk7OpS21DqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725409543; c=relaxed/simple;
	bh=Jp9KTqtVCnDFFMDNMliMFsg7zccoZTkWEJR3Iof6MkA=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=rbjcCnUYhkOI0e6lykK+3WmkbrJx57vg9tw1USXMBMJ70/n6pMQm1MkH2PMoiBzzZlu5AmBBs21xTi00EOtsV09//8DCULPIVx9w7M6Imv8BxnJYYDjb4n+qlp2Z3nrAkUSk76pqWvy1i1uJ59SFPtnKi2pArcd+DG0jTa0P9CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=D1rnTOIW; arc=none smtp.client-ip=203.205.221.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1725409230; bh=xNYACE97bcoLnmWU9sGTAE+KrHvjrAtNhsOZ1UzoMnU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D1rnTOIWzB0GtE9aMBMshDqnW2rz1bw6i6Qw2gGiAz2llkssrFAOCwiM+LfnW2fgE
	 UEnriv9eCIERYHiMOxFr81ugBddAD77MS9jdSUKmG5bMrUpXI6i08coxMMFha6kCO5
	 YECq0km0ywZawuLAD7Q8D9cMMlLrV9ngKJf/fYAg=
Received: from pek-lxu-l1.wrs.com ([111.198.224.50])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id 51D1CEA1; Wed, 04 Sep 2024 08:20:29 +0800
X-QQ-mid: xmsmtpt1725409229t9phjmkqe
Message-ID: <tencent_DD4C79766E502D6D6E1494B4E88AED6ECE0A@qq.com>
X-QQ-XMAILINFO: NhWS0W1hioO8cNRieFaL7bNwi0KWK/5aauhqM1RZsgpf97eRsV7Ay1ev39K+su
	 ToXRJsV0nNqq5VzUd40+PnThnK87qm0sSsmMGQzVyFM0HEFr79EXFVx3d/PtDF80yWoOjro/z/7g
	 8bQhDW6q5W8qO+8MPQwCYQ5/tt5rbd7pz4ZIAGE+AvyZ/k+TwapYtvLdE4JF8v8LG0ohQXI5IqVD
	 lZOOwH8kySh7BJVP34CokWIbUNRtLUw5/gLgfPK9dgj9O1ikuBdxCYu4RtoKy2dLsoMMKd1mlA27
	 HmFYagflEh00/yuWT+jWtL+nSJRgvSECNNK/1sgeic4/D8PXzZjoRUGJ+eckzouGWwc4L1sf5M4w
	 WHjtc5t2Kf2w4UI4c3EdeK0eGIf89N4YqSHBjYOuySegJbLyonHR7/wLnFpc9AG2OYKHVdczSSQ0
	 lsJN+ZN9CUTpkJ1XHsnU14jT0IKS+IKwsj0u6MiWeGNK6hsnFmBjwWCWmTaFkX04Xlty78sfu5cY
	 2H068l+MUMuuGsoiY30qiPvhO4KC9JyNnL1jZdoTOcTpWu4NtcdxrbgVynd6lz4lGEHWfAmhnvlb
	 90a5tEc9xGkp+6FvHhsEh4c8e2C2PopyrwGiGswQY4MN+vbnPU14bZ2RPV5nFNS9eGvkAB9P55DG
	 1S0G0Eum3P9ojvpqvTNtTQFD9IFnPKyMchdvTzSzmQqX0F8qdvbPpR4hJX9UvViYCd1Q13udQp5M
	 jYAs+diZH8aWm+vOvLaAGuZ+YzT5VJzbMBbbt2+vQfXEj2G/1GmgTN3M1z+sRGFZNoVMUnTOCeO5
	 Bjalh34pye9Q6iUs8qqkgcnYhrcaEp0hhJqOBBNUs9PWmdDLlC4B+mdeMClXgZYCMjJX2MIFU+Ku
	 2Wf04YHe6eHsD4C0yLhqftE2MIXRWqj6RjEJhxUlZV
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+f3a31fb909db9b2a5c4d@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [syzbot] [mptcp?] KASAN: slab-use-after-free Read in __timer_delete_sync
Date: Wed,  4 Sep 2024 08:20:29 +0800
X-OQ-MSGID: <20240904002028.3404360-2-eadavis@qq.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <000000000000b341bb062136d2d9@google.com>
References: <000000000000b341bb062136d2d9@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

entry need to be protected by pm.lock.

#syz test

Upstream-Status: Pending

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 3e4ad801786f..d4cbf7dcf983 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1430,8 +1430,10 @@ static bool remove_anno_list_by_saddr(struct mptcp_sock *msk,
 
 	entry = mptcp_pm_del_add_timer(msk, addr, false);
 	if (entry) {
+		spin_lock_bh(&msk->pm.lock);
 		list_del(&entry->list);
 		kfree(entry);
+		spin_unlock_bh(&msk->pm.lock);
 		return true;
 	}
 


