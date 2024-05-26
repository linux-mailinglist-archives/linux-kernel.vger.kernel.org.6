Return-Path: <linux-kernel+bounces-189898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A57688CF6D0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 01:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFF2D1C20D25
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 23:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6DDA13A3E9;
	Sun, 26 May 2024 23:28:52 +0000 (UTC)
Received: from mail115-171.sinamail.sina.com.cn (mail115-171.sinamail.sina.com.cn [218.30.115.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF251854
	for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 23:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716766132; cv=none; b=KAx5IGtJQZ8qNdMpTkxeKfEq0pYZcyWHU0IeGzdKwNtUe21ptss255XPYTuBoHxjQDPAvlp2OIDys/ZSWqDCx3Nbps0O//jV7Lp39Vrq9WWe9vjG0v5UUE2WR9HNmAW+RluIqA4P3IjyHm2lK8INds4qP5WoJZMGZsiQrmglJ94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716766132; c=relaxed/simple;
	bh=EiqQnuPmXeSHZqFhcWIC3pLsSkrPbzZqBxoh+dr7PgQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=murj2u87rD0O120Wz806iMBisjXswG7r/dQHu9qn77/XxpIbkWLFFIfklr5v8uqNIGp3oB3GbaWrIxFiHOikf2qZENnwiMbwAR1A472XljvNdyIPAc/8EkoQs1VbFwbiALEgk3ANGOp46uQVhGuArqh4mjHHVfI6uJBhMCv8KPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.50.196])
	by sina.com (172.16.235.25) with ESMTP
	id 6653C580000071DB; Sun, 27 May 2024 07:28:03 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 7405334210313
X-SMAIL-UIID: 7F652A71595B458D892F0C923BB0364B-20240527-072803-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+2459c1b9fcd39be822b1@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] WARNING in inet_csk_get_port (3)
Date: Mon, 27 May 2024 07:27:50 +0800
Message-Id: <20240526232750.2504-1-hdanton@sina.com>
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
+	if (tb != inet_csk(sk)->icsk_bind_hash)
 		inet_bind_hash(sk, tb, tb2, port);
 	WARN_ON(inet_csk(sk)->icsk_bind_hash != tb);
 	WARN_ON(inet_csk(sk)->icsk_bind2_hash != tb2);
--

