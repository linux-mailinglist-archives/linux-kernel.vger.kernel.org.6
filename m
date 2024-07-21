Return-Path: <linux-kernel+bounces-258093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B796938362
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 07:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E47828176D
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 05:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738BC441D;
	Sun, 21 Jul 2024 05:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="u/9SFE4o"
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A1B1FBA
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 05:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721539263; cv=none; b=U5NG41golKHb5dkY+2yGl7r0reuxWYvWyCWXWMGFbNRWwphp7IVO2XdlPWvzr4uKaKe0U+FxdOJ+f1JKt/DtGFlK5mWLIG3W+AKBIHfFOcWpx+WlG2RMJD7LOREVPH84uoNPEjzxV9Vcz7rreto/L0TMNB9BlizhGoUCbzhxoUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721539263; c=relaxed/simple;
	bh=CUvafZm9PXoKuTY9DW0YQJcv9RoCtEwgh79nadQKUfc=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Bxed5Wi0Wn7ImWgfH7GYTrz3On5kovM9KbGcdukwLNQFXIERCfCiyhwdlDeUL5Eaqj6j50QP3QZneYxsQZvYIcMJm5jJ9SoGXtBhSid2T4wH7uvTLy4xh1Wmprqcpzt42OvPRLgKo2Knb85zjav5+bJrs/AaCd9kX+RN40F0ArY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=u/9SFE4o; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1721539250; bh=IfORuzqiJAwlbujaaLkEJbQtvC91r2v267VLRz1/yMk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=u/9SFE4o+5F0J/GpOli3Yu9XWZJJVMiOOC74wt/DPU3pCNxq+j03KJzdfc4pDxdDF
	 vaIPgsly+twPvB1kiwHq9XuRkKx4KFN3bAmVIfuJvHery/5lC2NnwyT7ZYwgeBEdH+
	 6TO4PYZLGll2oApBzuzx0ZhAK+vWLlsMjJLuabHA=
Received: from pek-lxu-l1.wrs.com ([111.198.228.103])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id 3A78D84A; Sun, 21 Jul 2024 13:14:39 +0800
X-QQ-mid: xmsmtpt1721538879tuwlwqlqb
Message-ID: <tencent_864C4BBC74D1772167023D5936EC96683609@qq.com>
X-QQ-XMAILINFO: MwqrwaLzgdeb9KnR5IMzvuD3N+XD8zO00OWzgrc41M5MHi2ZhwpiTBP4pJ5HDt
	 PdZHu68oRbd/7kPQFVib+IjzmekFBttBIivEF9XyI0DVY+MkwspnP0lvu/Ie9T3Y7aIGVMj91fWt
	 W0E/BkjWLniI7ixEjhMjMBGVqx9K7Noxo/X80AIGOJRqLjRYaQO6LqozOlDgb20jl60B1W1bcfy+
	 yCsEWcwSdQLfVKuOxz0g6wl6xrBMr5BQEDB/16c/wrWikwKBbuFJhqrKb2B5+YBf1Pb2/WTho6XB
	 p3Qg4uHIz4mUZvkQTQPtnisAweO4QPApCnKk84X59NxamBWkTduGjPph/71C48Kt1+sOv/smm4Cj
	 8XWLz6k9sWbgPux/U7yuyobEzC82RJIzsW8MWj28R5dOUI+fGvm7r/u3ffTpHbyGyzE5wJzrcIwc
	 CtjdgARiuNI1bkr66jIqFy/qSiTE2H78mzhv3sJPWOvjrq9mnazYlKPqF+BRohuBt/1R2tbRb2s2
	 i2k9euB2W36/F2Q+AXuYXNeiUbtroLpJ6p9WtLn18ZMYy0MTNHIOfyERA4YZ4XDBS5BCgCQyx2fz
	 vy2GB/2teVqypP03NFvNETRDjKVUGzFbo1tCQTG5I9jzu1DclIfdG1u/jtUE3SCiuRSr1iUKkU/+
	 I6DDl7GMvzZHCjiTQ2vBUyot+ss/juNzzd9/DzkwRb/mydVr6wWMf2iNi1t0GJgfabeBsQyHSujs
	 dX5n/ol0CmcDpmJklbG7vo99DzOFbp623g+ZOdtcRWYPdiHnOzyeJXfEj8rncUz10p3EAXJXIJIa
	 Dd5kmuF/a5e7G0ZeHQRSjYu4hO5v5By09prsmcCO/ABLk2J8FuF9lo+jncmPi2yLbqvSpMexpiml
	 Db3+imKd+h2xLAClWAu1A29TdyWdcprKaWe9y8ETsMkZck5wpxixrIrhFLS1Qy7H4ih1wiM5044+
	 6TTwo9MJZbG8jNT4XQQrC+BZAc99HO
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+34a0ee986f61f15da35d@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fs?] BUG: unable to handle kernel NULL pointer dereference in path_from_stashed
Date: Sun, 21 Jul 2024 13:14:40 +0800
X-OQ-MSGID: <20240721051439.1606444-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000cf8462061db0699c@google.com>
References: <000000000000cf8462061db0699c@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

time_ns is null ?

#syz test: upstream 51835949dda3

diff --git a/fs/pidfs.c b/fs/pidfs.c
index c9cb14181def..fdae58eb1d98 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -168,6 +168,8 @@ static long pidfd_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	case PIDFD_GET_TIME_NAMESPACE:
 		get_time_ns(nsp->time_ns);
 		ns_common = to_ns_common(nsp->time_ns);
+		if (!nsp->time_ns)
+			return -EINVAL;
 		break;
 	case PIDFD_GET_TIME_FOR_CHILDREN_NAMESPACE:
 		get_time_ns(nsp->time_ns_for_children);


