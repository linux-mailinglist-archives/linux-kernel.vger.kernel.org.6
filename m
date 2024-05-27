Return-Path: <linux-kernel+bounces-190446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2CC28CFE60
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 12:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ECF6281B4F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 10:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D3113B5AB;
	Mon, 27 May 2024 10:50:58 +0000 (UTC)
Received: from mail115-100.sinamail.sina.com.cn (mail115-100.sinamail.sina.com.cn [218.30.115.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68E013AA31
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 10:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716807058; cv=none; b=NbDXqy0XT67s2QhAwHYuTPBjWuWaoZt9xQGJzEmdApZjwSb2BW+eAWJ7B5ZzJ+iVnUo7GJxo0cIGACKh1UiTs2j9WzKfgsMyau9TLnUtqBowi1yMRNaIhsiQt923muESCmNTkEHoQnYsZqR9LUEVgoSh/dUAGiR3oCJYef+qnjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716807058; c=relaxed/simple;
	bh=M+5oJJBFymwz7yytBUNL9Ovt9zv5azHe+2mI94Y5ekw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oD1JNRy5yOLAK3lTr937DfE4G1UL1FQ2THpeFONLFtFou1G1b06792Q/psNW/LmCphKtExThY5kqIlIurBhNpxjC59oxK3MpOMTZK8Yi14SetQ3ueN/JqtKDdwEuzWbpNpmN0F6UNyRk83UyR2rEy/WKGTZH1Ef4NXfI3YTg16E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.50.196])
	by sina.com (172.16.235.24) with ESMTP
	id 6654644300000507; Mon, 27 May 2024 18:45:25 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 39220745089343
X-SMAIL-UIID: 5D1534DC5E0A47D2A6A59D59E8846220-20240527-184525-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+2459c1b9fcd39be822b1@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] WARNING in inet_csk_get_port (3)
Date: Mon, 27 May 2024 18:45:12 +0800
Message-Id: <20240527104512.2559-1-hdanton@sina.com>
In-Reply-To: <0000000000005736990617c4fa63@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 06 May 2024 01:37:21 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    977b1ef51866 Merge tag 'block-6.9-20240420' of git://git.k..
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11135520980000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  977b1ef51866

--- x/net/ipv4/inet_connection_sock.c
+++ y/net/ipv4/inet_connection_sock.c
@@ -589,7 +589,7 @@ int inet_csk_get_port(struct sock *sk, u
 success:
 	inet_csk_update_fastreuse(tb, sk);
 
-	if (!inet_csk(sk)->icsk_bind_hash)
+	if (tb != inet_csk(sk)->icsk_bind_hash || inet_csk(sk)->icsk_bind2_hash != tb2)
 		inet_bind_hash(sk, tb, tb2, port);
 	WARN_ON(inet_csk(sk)->icsk_bind_hash != tb);
 	WARN_ON(inet_csk(sk)->icsk_bind2_hash != tb2);
--

