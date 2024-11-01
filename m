Return-Path: <linux-kernel+bounces-393043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3618F9B9B4C
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 00:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6813E1C210BD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 23:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5898C1D1F44;
	Fri,  1 Nov 2024 23:52:33 +0000 (UTC)
Received: from mail115-63.sinamail.sina.com.cn (mail115-63.sinamail.sina.com.cn [218.30.115.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2FE1CFEB6
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 23:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.63
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730505153; cv=none; b=R4REzh6w4vHt3dOl1YmK8EsGO6vp1a5LisvkuT63sH+5+wXo2gNzMm+PCBKhyFXI58d10J0HU4E8ElaPtuehnNJgCt7h2F7XrSAAnr4ZlmFd/WxsnZj3QgS8fxitoXg4pAeXYMor4sL6qB87Dq9YfeAvBlw2dEFGvmv0WkmfdVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730505153; c=relaxed/simple;
	bh=q8hLEUtoU35E3wiOm4Fy8q4kdPt6qAFj4Q0d5BE02fk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AKFCQtCESSfS3ghUEej8HU2ZQP//CPTEeFetracvZmLpE3RvaUYG+k03GE1LcnDWf4r5Lykjw/QwrNb+6CnHLhyCU8twsgGdmU+rscc1B7iExi8w9P7rvZibcSTqjGPyRLiVUOKezZo0ka6SXQk0PBUUJP7gFvQ03vuQpXXR/jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.64.22])
	by sina.com (10.185.250.22) with ESMTP
	id 672569AC00003567; Fri, 2 Nov 2024 07:52:16 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 5883737602705
X-SMAIL-UIID: 46E8A5DF42FC473ABC9BBA66C0E4A8A1-20241102-075216-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+71abe7ab2b70bca770fd@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] general protection fault in put_page (3)
Date: Sat,  2 Nov 2024 07:52:05 +0800
Message-Id: <20241101235205.2735-1-hdanton@sina.com>
In-Reply-To: <67251378.050a0220.3c8d68.08cb.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 01 Nov 2024 10:44:24 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    f9f24ca362a4 Add linux-next specific files for 20241031
> git tree:       linux-next
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=153e5540580000

#syz test

--- x/lib/iov_iter.c
+++ y/lib/iov_iter.c
@@ -1727,6 +1727,10 @@ static ssize_t iov_iter_extract_bvec_pag
 
 		(*pages)[k++] = bv.bv_page;
 		size += bv.bv_len;
+		if (size > maxsize) {
+			size = maxsize;
+			break;
+		}
 
 		if (k >= maxpages)
 			break;
--

