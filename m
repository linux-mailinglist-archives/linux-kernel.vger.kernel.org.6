Return-Path: <linux-kernel+bounces-204586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D9D8FF0C7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 17:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11E1E2841A2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 15:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42734196C92;
	Thu,  6 Jun 2024 15:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="HRSJNuX2"
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AEA196435
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 15:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717688191; cv=none; b=IuYrR9sMZ+ObxYo2/yB/jQLncMlI7kbKcz95kvXC2yy977+1e96Q4j5rwT+OFPPYVXjR1SaBbpRSESWa+rj0D9Q43/QBGkHH74E+cDSluvC/m3jGJe3GUmadFnCHjGJ6n6bziawajp1qphsZicwkCzqOdJEw7ZZz4JJ3IuiDVCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717688191; c=relaxed/simple;
	bh=DMWAGyFqLiUWvbNs9QDYkBkhVwbCJWKpXAzb+JyJW6k=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Fk+QLM27yMwaCgiPww2XygspqNIvsJfAkavD0yJ23E+NiRQR/kOgtGmq5Q9+Nv9BfeKhyInMgMXLL5bxoSarKFG9tvCgJgLv4fcXZxpVK/Eqyq4e3TXr7X017EtyGk2hTeBUkb2K6PUOoCsXzc0YO2Im+EsIMlNYnvQk3592ofA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=HRSJNuX2; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1717688177; bh=++8ewb9EX0RP8F9ywU1zC5YXQy/naWwkIEvGHucm84U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HRSJNuX27ze0gqAPIDTE5UUkbm+SFxA4/2WEzuLV3Rk9BQKeEQqwTkoKwUHR9BaeY
	 pi+u6QKkg/BGMOm8g8sG/eHSwg3qSqdfWDYC/azSVvlLf7EVhn+0nM8yPrBGqvbMJQ
	 YGdxWQKHQeUrIaHsn7BScUEo62J8tq7Xr9f5ioRM=
Received: from pek-lxu-l1.wrs.com ([111.198.228.153])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id 58C258CB; Thu, 06 Jun 2024 21:22:12 +0800
X-QQ-mid: xmsmtpt1717680132tcxy0shw6
Message-ID: <tencent_92497A23B524569769377926D4536A636A05@qq.com>
X-QQ-XMAILINFO: MesT5uKpDagVV8yG3LJVEpNsjnpzrQS9uLKt9eiJm3n5sjWvhLLJroV/j1Oa3J
	 fRp3gFuPPOxohfAwT+ebtATtoCNyrBdUZ1VVYr6PH3aHpOuontwILuv/2hxEP/WcnxA8bzsawfbi
	 jac9EGdCrd6nOZMsDXaoyfHjRwhiZB2MzzQax3MMLjrWx+18Y8j3CPrMylCi9NttqfeYAvyFEDF0
	 kNoB7f7dyIPjfbHEi+cSu+W9dQ8/yRZalyiAqspBTEubW+dImFN0OPbfaoif69fl5PtPVutUxSSb
	 tyCc3Ls54AQFp0KA6bEITTGBpJbjhLocw1Q/jZLdn/VBIPC6kGq5OjcW1h8Hp5GikjwY+vDc4ofy
	 yTyJmQSgkC2hcTgKrEj7IkdRfZfGyLnKE13bl0R1MkMSdvBw+BWAMcS/Exe9lHYMF6kkT7jTkq74
	 N60vl7vS+OflFQd6yn807EyUuR2YLxRwxhF52YVqVuifX6lM9FwlWylEwADFgxhM6IjcnWOzTpEC
	 lhRE0+K4lzyCexRZNc4hLB2JAsZEU6dCxO4XhYc5fRxcpZnHR5rYnmnF/sW7OiEExl9o8rzDIm6s
	 pChRcQnvTlzEh3K7+ON2U42ObgsibgN6Is0d4NLnIywKtKhJP3THkgIsEJdGHUedljafl0ECwgJv
	 Lu/Fg8t0Idu/02X8VkzCgwlEpN8oCOUNG8mWGnxDyqUFO1oFpj3iDpVAKRNWZFThgld06lLGriXm
	 ICjM/jUZoKKpjeLuomEL5jA4FCnit3g8er4/2IeCkbiXA10KgjtFLbizeh57Y4A0JjnOUOclyf/y
	 66eE9aN/gkWUS9U7fU6fS2aHDg9fmIEpbgBZdm1bLls56kC7AlfTFlQlU9oM1en4ZUMeAMFrjwHo
	 jhJE2xyV7id6BQ2YoICl8I7cngv8PjqR9DFCTSpQaVGF4F+Qj/5e5/ouPj8XyHY2MSjFJHSPzjuw
	 ckc+EAAyM=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+ee157488ade46c021ef4@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [gfs2?] WARNING: locking bug in gfs2_fill_super
Date: Thu,  6 Jun 2024 21:22:12 +0800
X-OQ-MSGID: <20240606132211.778639-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000b241e40619e1c3bc@google.com>
References: <000000000000b241e40619e1c3bc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test wr in gfs2_fill_super

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git 9d99040b1bc8

diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index 0561edd6cc86..7288a6221fde 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -1308,6 +1308,7 @@ static int gfs2_fill_super(struct super_block *sb, struct fs_context *fc)
 fail_delete_wq:
 	destroy_workqueue(sdp->sd_delete_wq);
 fail_glock_wq:
+	flush_workqueue(sdp->sd_glock_wq);
 	destroy_workqueue(sdp->sd_glock_wq);
 fail_free:
 	free_sbd(sdp);


