Return-Path: <linux-kernel+bounces-266795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C13EC9407BB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 07:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 698391F22EE4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 05:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4FA16132E;
	Tue, 30 Jul 2024 05:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="UCD5iHCK"
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197A08C0B
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 05:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722318399; cv=none; b=fh9bL76sbzP3gWTw9WcD2Cu6Zdo0jmWWAYIBdbD31TbQBOvI+xnnyxB8mIlOakCVUf/wmJ6otGbNijo649kibkwH5NGWCU0UFKvg8o5vHKAPpAKWifKRTapEeEi5hRWNsXv8tJ4MioxDcfggccA58GIBxUFMehx57u8K6fIXa0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722318399; c=relaxed/simple;
	bh=BQh0VGWm4KNjuJ4YtOmNl/mNztKQFreZcrwr4GKS3E0=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=H/Pr0DWBLQDP6oXEJvcx1viRbk5w8FmV4suymNr0OqOgyWQwjfxlBN2cIOkPh6WR9tLGaCW5uj2v71JnNxBhA7nTmU+Ydwy6dGkhW63dyoqrtTmjndArLtsqquGClfLzrytqI6y2OKFnUcFCItkAjH4cWph9aXw6soC8iPxGEUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=UCD5iHCK; arc=none smtp.client-ip=43.163.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1722318385; bh=N0Iiv2vX0gulg1pR2y4UCTKGgDa+YVKTwTd2Fx4yzp8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UCD5iHCKJbApiUy4Mn2Ru/yjvxZMKa7Rqis40OQDoOKLsuCYDc0N1nV9cxU1clx8G
	 B+IFQLN7tWzydmNJxRllcR9no9IBV/7OIJuNzgZ5P/gu8ZjY0uJAU6yDUTeF4G7lcO
	 QJYcmzGSlfCPJcd0hvdEfIMhKJZk12QinavZShfE=
Received: from pek-lxu-l1.wrs.com ([111.198.225.4])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id A08B32BF; Tue, 30 Jul 2024 13:40:08 +0800
X-QQ-mid: xmsmtpt1722318008tbav92nln
Message-ID: <tencent_EAF7DD8919014F8F8DD6259B0DA8123DDD07@qq.com>
X-QQ-XMAILINFO: OBxrK7/F30bEiMRUYypMWpRL070Zsz0UGj1yA/2wiWa3QBzNpzcqYfSR4I+Rim
	 TeDkO4mU3Pkcj8bUrGsllV5vbfDYH4/6dl4PICnjmduFHahCi6nfQUmQehEB4usvk5sTHPWZEUm8
	 WezOG4/oWpA421NpDDnSsJFrnyELEUSqWCqpaGCq9aETy/WEpWLAfESUtuzwI1g7gV5AIcqMr9dS
	 spTVjL+twSOv5lFeq3+cPbfSr+sNykSpeJLG6jIpdqzpEZ/bJgLYm9BKpH2PwglF8IQv1VupEACF
	 ZNI+Ck8hRhdp97ojvVE1wkMAhOrsK7aoN8NEYg3B/noZL1nVMH2MafUdWbJj1EahRYy7/Aa4FRRA
	 qp2SXNCR4evjPcDO+GvNtKd73ljQBnOdTEi0VwA+HoZe2wqa96J9AGu1WqFCOXrbiwW1vvHmUS3m
	 1YDi9umqTWqXYLtqhHsYJDzil/tqUpBvCzjFvPt/c4/oNw/PerwxoSvySjfTOITprj+tbgbBR00Z
	 5rZrjcjjDb4m0jFivngDkfI4prTn7tlxfWtlfi/tx1h7Q+oOaL4sVFqgCJ68U2qaLLIWxR0wb7Sn
	 OJyHzz+D3zDpTKQ0fjSKo6D46TfDNAP4HXLjVMdoaz/cSWPkbTjnHnp+9ejilsyH8b4dyAxxhuOW
	 2E4zouvHxRdAOo06Z0YDnrUBRjIOGmRTtkcumLiJyvlffUMogbzqAFyHqpCidA1X4HwRVwJM59Ii
	 po5/XS2RrIK0wuP2k6XDexxJ6/cXRk5i9THrhdZPZXx4DsnQX4VIZpclKa3PGhk+kgIxDByPfjg0
	 3DetSNtFUPQGTfKp8CuZStsgSQwMwfRTkLi+B1Gy98M6ImSGNPjNd7HLzMiuXtjfn2Y+M+2bkMri
	 UQ0RCi0tE7iBHUx8JWoZiziabRGt1UEL+8BN8/Y77xyZrnv6iIAOQU1hADXiutFJmCqRuTAiKI
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+916742d5d24f6c254761@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [usb?] KASAN: slab-use-after-free Read in hdm_disconnect
Date: Tue, 30 Jul 2024 13:40:09 +0800
X-OQ-MSGID: <20240730054008.162431-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000043dc4061e61370a@google.com>
References: <000000000000043dc4061e61370a@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

move the relase dev to the end

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git 933069701c1b

diff --git a/drivers/most/most_usb.c b/drivers/most/most_usb.c
index 485d5ca39951..ed3fcba00cae 100644
--- a/drivers/most/most_usb.c
+++ b/drivers/most/most_usb.c
@@ -1118,15 +1118,14 @@ static void hdm_disconnect(struct usb_interface *interface)
 	del_timer_sync(&mdev->link_stat_timer);
 	cancel_work_sync(&mdev->poll_work_obj);
 
-	if (mdev->dci)
-		device_unregister(&mdev->dci->dev);
 	most_deregister_interface(&mdev->iface);
 
 	kfree(mdev->busy_urbs);
 	kfree(mdev->cap);
 	kfree(mdev->conf);
 	kfree(mdev->ep_address);
-	put_device(&mdev->dci->dev);
+	if (mdev->dci)
+		device_unregister(&mdev->dci->dev);
 	put_device(&mdev->dev);
 }
 


