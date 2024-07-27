Return-Path: <linux-kernel+bounces-263938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D7BB93DCE4
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 03:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27BACB22890
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 01:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94361C2D;
	Sat, 27 Jul 2024 01:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="iJoZL+cs"
Received: from out203-205-221-245.mail.qq.com (out203-205-221-245.mail.qq.com [203.205.221.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABD5A21
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 01:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722042805; cv=none; b=P8TrdY2fmWjRQOmLcsVFDm6IFKnMHdAkH+qYhr4Zj8VLo80Mxw1s4wYT6/QdOG+ColJCG4pQPa5DPCiBfeYKDjrXVi5l+SAFQdelhbNOGdqneLlRdBMGF25tHVQoM7wCEv+upy0rqX/fyYxvpccxqaSou6HJe64Ajeb6G4vPsqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722042805; c=relaxed/simple;
	bh=RxnlzLUwCJ8JmcApTgSMdTywMBOlo/nf0+AyeC5bR1U=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=So/VmcqwWO+cZAWzNk1JMT6yOwOm5EXrMYEa6urHXzSihH/qLScHLA9DF55qOh1hKW0PqFO3k37D56V9PY1Hlb7eWK++DvJEJUPYD9nY7s7Ha6Ddsj1FXux+Y9BOVjYwCNIxwmCDpoVw5zJ4vPfqCZ0bb3urO0ZbTtxVjkXO+qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=iJoZL+cs; arc=none smtp.client-ip=203.205.221.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1722042493; bh=nyl+vIcOoT6Y+Vvd1vJ/tW9Gg2HFTRWhc1dTpJShxH0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iJoZL+cs4vjH2pawkLvSf8fNXwpVoZn1cb+2ajkkoyurxT1LBeKYmxQWoGnoYPt4S
	 HcQSEQ+cRo8SCXp7XRqs0mtajoCkOjTerQkFtv0Y06xI3VeTDWO+/u2foYntUK53cQ
	 OEUYP1V596hRJtt/7r2SXTHvTYiihyT47LuJsD2Q=
Received: from pek-lxu-l1.wrs.com ([111.198.228.103])
	by newxmesmtplogicsvrszc19-0.qq.com (NewEsmtp) with SMTP
	id 20B3022B; Sat, 27 Jul 2024 09:08:11 +0800
X-QQ-mid: xmsmtpt1722042491tw0g2gpw2
Message-ID: <tencent_2D67C43CF3361A96A4367A4BA874E776DB09@qq.com>
X-QQ-XMAILINFO: M0+mPbnDK3YA3Lg6RLWlnzgqAKDp69t9m3gTj4W5qYqLS+z/5wXPblCI9CZ6CH
	 /dgJPFlW86qT9o24hJj0RYBt5LYkF8okV6ciOHm2+WO2U/4DYHfEI8HWBjJSYyw140Ckz2cW3Yhh
	 3YnsJBsSpLlBFWuzqw2eRreQuuxjKjbaRHS3jv9nMsWL4JatulMbGRc/r08uJt27H9PY3oE8aZ/x
	 TPcJHfu88ZqG86N1eh+IMR9OOhCkKreXAwRyz4MmFDJy71vxmG+92Ry9s5fUqH7Dwm+Hs93zLegG
	 Jta5qWtyesj2XDBgHAnN/FdpT4jqru3eg9baFgD0QQjPkWtifKd2cjUzADoXpHymYxA05LCY23Qk
	 ydK5wmGRinVIKXKkqPjtzWpCpjvnsPHGoxV16ivW+6JLat+x5CSpqIfTvlo7nn7ZX59ogAJEcoFe
	 So+donqur4Ibc1nWrLTx6iAKVDHnX5MKZZWE2i7ermTTd59kMGqjYGiP+HvyADXiz0qYDnVI4RoN
	 qjMiyueJkLcrkEpnDiAeV5E+I03lUF50oo82IhPFce2ze+5E6ZNaplULJ0rnLdvTkoYGJ8t8pILI
	 mkl8Z8U9XRlXgx7R4Tpmt5Fss+XzFWKYCLewI/i67ra/90t3uYw2karZyWGAoRRvZdtHqa6SiO+u
	 PlCfFtAaoKJEFE+1xyK2pOAYG8AR11qtdj3tCK/oKycmn3cTASGfr8LKKpdIxrvpnEAi5Ye/tfr8
	 X9Pz5tbt+O5f7F2533E1FXRQSpWf539Rx7MMJmFLM8YjH+Mdp+qXBvpWrbGw5s72xrsLlNYaOY9Q
	 U4X2GGVivFHu3c8rovy2/AoGi6Jyobj7+enqrzCe34r3j9nQaVTcOxLlaMNvg8gkSaQAULOP/X2X
	 a1sI7v25O7Yk38p/MoqQF3jpz8dnKOVg==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+dca05492eff41f604890@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [jfs?] UBSAN: array-index-out-of-bounds in dbSplit
Date: Sat, 27 Jul 2024 09:08:11 +0800
X-OQ-MSGID: <20240727010810.2435646-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <00000000000064c7a0061e2004d6@google.com>
References: <00000000000064c7a0061e2004d6@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

check dmt_leafidx < 0 

#syz test: upstream 7846b618e0a4

diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index cb3cda1390ad..516bac758053 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -2976,6 +2976,8 @@ static int dbFindLeaf(dmtree_t *tp, int l2nb, int *leafidx, bool is_ctl)
 		 */
 		assert(n < 4);
 	}
+	if (le32_to_cpu(tp->dmt_leafidx) > LPERDMAP)
+		return -ENOSPC;
 
 	/* set the return to the leftmost leaf describing sufficient
 	 * free space.


