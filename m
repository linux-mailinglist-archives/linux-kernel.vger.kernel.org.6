Return-Path: <linux-kernel+bounces-375871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 896BB9A9C21
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 10:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34B2D28336C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 08:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5739915665E;
	Tue, 22 Oct 2024 08:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="OuJQkFqB"
Received: from out203-205-221-173.mail.qq.com (out203-205-221-173.mail.qq.com [203.205.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DA81553A7
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 08:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729584853; cv=none; b=n9CcWyWeIxOVqKycc0FWE0hhXDlQT9+YJ4Ne6xpGeqYMpqxVV6slKxC8jrchW8Z/biFvsk0w7MPA/fPcYOwz1PUbokB4djWt0No+0OarVo8QQy8pcbYkRfRiFuMRkHlT9lE3xDLk6z6D71hRjAq9adysGHOoD4ZiHOzvv5kMCg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729584853; c=relaxed/simple;
	bh=HcOyRxiccbtiOTOxsRRcjiKnOmEj+hIV5VUXrNlwyq8=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=gJ8k09Z4smdGhj7saOAJ2vod5HqMqBGQftuqpcWUHdJ+pLKfv3DMxvpVMTPVyehRCn6/8gVIpnBsHWAJqJ4sE62a2+Om+lSt07W9YR5q6rg0hrphFUXFcVCxiAhGStUJVfMfg5vGs9kbWAikYaIqYc5HdFP2fKze3d1nRO69EHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=OuJQkFqB; arc=none smtp.client-ip=203.205.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1729584844; bh=dcRFdkon/8P9gUWmmyQ3nX4Tvnh5+QEaMXWPK0pEoyI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OuJQkFqBnXJJHRwxFkp7gfyNy70rg3SKPDf5aphYok5xFvl/jIXFnae6NGfszoWCq
	 3WvnvgdmuW2mpODtmwcwkA52TqalSmYPqW5sLefkyBF5/uPqPOCFbv5W2+K0uZw9n+
	 c1UR8M9v0ncCB3l2bmJWhRDNAiTGXArgn3M3sUKQ=
Received: from pek-lxu-l1.wrs.com ([111.198.227.254])
	by newxmesmtplogicsvrszgpuc1-0.qq.com (NewEsmtp) with SMTP
	id 381A4814; Tue, 22 Oct 2024 16:14:01 +0800
X-QQ-mid: xmsmtpt1729584841tdhzg4lmu
Message-ID: <tencent_4DCD74787E6FAC2F296C109468E8F6EEDE0A@qq.com>
X-QQ-XMAILINFO: NO7nxmS7l766mSDBjsYz0GCzZahEoGRQ6x7+Q63dDSo0E2eCTk7Ba739UKqFLm
	 PpK1tmswnsp+noGeeQEppfk47K6dhgGbphbzXZPZg0L29TPyMczaqUyTeX32nzHi79bc9f/LDiit
	 W9GP5TJh2e8wpb50UgovkwWsMqDnJIfWAenthgONwaqlbaOZ4m7MkQCpik9EVCoT4DAwsU3xdm0f
	 sXqAB7Tk5+qvk6o2cIHYvG7QcZ5XiA90xg8CDwyzUfT4Q4x5v6M9iTqlv2pIwX24mKThB86vQw7H
	 xifKYqVE9Zh/5y5vY2/GGrCFLEAC4eo+rEzk2aaCX3mwDUq59I5YoYx4DqhEPGNwucdl7n2N+q4Q
	 6bz9GvnALtBm8tUtmvQDGB8hOAbUCnrRyrr+oZOkMeC5zVod2iWQd50SMtPIeLq8c2ZJ49B96AlT
	 N5C0VZcODwB1J5KeDSKrw9+xKt9ChS/M8+68duTq6Z2MBoCOXx7n42X5Mz5SYGcyAIE5FftQRv/s
	 Kx/LAFFhSAn19jAc/By5sBD8YLbfCboMI0DZZbMFjfpve43y/LcO7pPJgHn1EtV0TRMZBANoNWk9
	 /wOEZDHwckaMz5ofnjTfOJ+P+cpcqdEp/ZbvSuvN3O1CMff7+j4VgZX1w7n9oXKQis6T3PcNumfu
	 8iFt8mh8KLMq0bbdYEk86kxKFMIHAUrFBWwk6Ck1b/hfC0OPeXdBtzWsKfswSc5KEwsD5vfNF/CY
	 Peot45WPNzPFIXon+g/Yl+gD9irpH5xWVvu6cS4dsZS2G0/MZMhx2gsd+B6IwCUbFRrLorZ0MkzP
	 SCujYN7V6eZ2htyUiv7u7qaEm+ss0Jl9gEs1/eaXz9K1K2L72A5r5KSPTpV69Ww8ZMTBHp7M5yTe
	 b2CeHmGocL7vTe1msvmifsghJApmswIUs5eokv0L8/e7Qe/uFDDcUAHi0BDouvBGtbpEweHsi4
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+a234c2d63e0c171ca10e@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [serial?] BUG: soft lockup in debug_check_no_obj_freed
Date: Tue, 22 Oct 2024 16:14:02 +0800
X-OQ-MSGID: <20241022081401.3485277-2-eadavis@qq.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <6713d23a.050a0220.1e4b4d.0029.GAE@google.com>
References: <6713d23a.050a0220.1e4b4d.0029.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

maybe we can insert cond_resched()

#syz test

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 5ce473ad499b..82cbd7a68994 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -975,6 +975,7 @@ static void __debug_check_no_obj_freed(const void *address, unsigned long size)
 
 repeat:
 		cnt = 0;
+		cond_resched();
 		raw_spin_lock_irqsave(&db->lock, flags);
 		hlist_for_each_entry_safe(obj, tmp, &db->list, node) {
 			cnt++;


