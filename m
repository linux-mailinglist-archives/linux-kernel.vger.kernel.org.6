Return-Path: <linux-kernel+bounces-237834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E699E923EC8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 15:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3075287697
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 13:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6451B47D4;
	Tue,  2 Jul 2024 13:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="K4l7T/Lo"
Received: from out203-205-221-240.mail.qq.com (out203-205-221-240.mail.qq.com [203.205.221.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17431B47A5
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 13:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719926469; cv=none; b=SbdirKrwPNq3aWAqblRm1G8FVBnG0jdSnSy9T9n7sy240tW1yxEOsbEk6kBEcSWSxYWj/K/VrMaP2Lx8w2sO+qfI+UqHiPBHgJ1SFHGiaHMVjfvzei5xzJjsCHMfN9eM67QwOL8kCPdlNxUtPtixAMBTnGcyF+YT+qoIQX9BHpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719926469; c=relaxed/simple;
	bh=EmQHO97FIP/vJTqSG5INUnUFiptrKtdUB536EBRtKEo=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=NIubzfXz47cZBUdNsV/hKg7Pp4TL7xlwu6OJmEV+6HHXhc0xlfMlcbKJn8W04oK319EezBQ5F6YifSNN5FdgiwSBjRYNb7cUMPqK//n2kXfb6x7P+TbAm9x88oGe36X2rsEGfRFTjMv08y6lhP65/pvn+a9PrTyUVhCgfKitOmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=K4l7T/Lo; arc=none smtp.client-ip=203.205.221.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1719926456; bh=0VrEWnjb6+LRo8SvQr5MhH/XfRQjhw5tJiE96jU1xoQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K4l7T/LoZaAthKKPYoLjuALxsooxVofL/1T5iW+ObCui+kd98Pzdf9OVEgcrU436S
	 jGuTllFsVeF/sPVAwsJJzmuhP4Msq7jvhjVtrvkzAFqU5+GTTmJI8ZtB5Pj1gZAJ64
	 7xofYdjxGZ/2RRutAXKDTDmfN8n4Iz3oFcx4NfVw=
Received: from pek-lxu-l1.wrs.com ([111.198.228.103])
	by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
	id 3AD8B6A4; Tue, 02 Jul 2024 21:14:45 +0800
X-QQ-mid: xmsmtpt1719926085t1o9pn6rw
Message-ID: <tencent_1625C3BA12BB3633E59EF81B504BC11B6808@qq.com>
X-QQ-XMAILINFO: MIaS6BHTUnR1SXYH9uQdeZjAzg7a0KDALnwNmFJEct4ItRTDVN3LYHFmK8UZtj
	 m+YPTpEutUOa4GpW+gUKogqaEAmPma9OZAFTkxTq6eqaQnh/TxDWIQ6DY8c8CuTSQUw7DDBwDEZ7
	 ct89ChJ6GpdBtmn0Dh+f+B+EligI0A09zz1Iv1XVnF/B6TtN9wzBSAfuoIWljgacnpL3RyNeDLYJ
	 yKFoLXHpIcdZx/xWXpWisfGuIp9y/sdy94b5ZLkdszoWOA67wMP2qzlmsftPv+98juk4b9gPtZr+
	 F2Cu5vsgkMwjbOAqIN+Y8I0Bddeqwdkw/X1WvYkrP+O7nCBaiRGFvL62P+6GD/rf2BSM6lKZwMjt
	 /qzSdx2FtYcXKefI4zzqvKkM0uPXUsKmOOgZnYKXAALShtISzFA5MS1xysFntALtMK3Grj9drldp
	 o0fBQbg3GN0ynmvqVMgipM/3ojs2Mv3QTMpCtZuaEIa+ryAjKX1K9sqt0hJlMFcIwbLqtO5DeNQT
	 kmontiVQiP+UHOhI1/f3DZLwUneXon+zbld+uSOiJUKc7QmTKXhWWW+BapCyPrZq0Cyb3+hTDOpE
	 grE4MXcFS5bLe82nVCKzln7hpLRWpXXwMgt5wLGqXmEpDJEjS5XfseIgx48dve3fuVhqUeMj+zJF
	 F6Pf8TFzKwbcGB6X+e98l57oMqlpNjHcLioh7qsvQXbJ7qohpkjIkwqNsdjzCGsBccnCS138stw8
	 LoIUI3Qliw+2TIA7vpbKkHE1et6XmlcSuMTn7HXLdvQ40kZO553GEq2v2Wbf18e+ZfCspC2YniRt
	 3lxSGd9oIVqREvgf01AwoWulg9J62qOQqX/mW9wdSYnRqPcLwnA3ZrU0HdlVujymI/5BkTPJIkZd
	 JXockgiZm56OVnzBmi6jw5BkjS1QQ5zG0K2DhzAHuelGiaRhilybrN34kQWLCYgUg71mCxFDgW5T
	 dEVfqLz3x9vRxDwE/iJA==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+4fd66a69358fc15ae2ad@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [netfilter?] KASAN: slab-use-after-free Read in nf_tables_trans_destroy_work
Date: Tue,  2 Jul 2024 21:14:46 +0800
X-OQ-MSGID: <20240702131445.3838529-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000aa1dbb061c354fe6@google.com>
References: <000000000000aa1dbb061c354fe6@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unbalanced increase and decrease of use in the table

#syz test: net-next 1c5fc27bc48a

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 70d0bad029fd..b77b764955a0 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -1498,6 +1498,7 @@ static int nf_tables_newtable(struct sk_buff *skb, const struct nfnl_info *info,
 	if (err < 0)
 		goto err_trans;
 
+	nft_use_inc_restore(&table->use);
 	list_add_tail_rcu(&table->list, &nft_net->tables);
 	return 0;
 err_trans:


