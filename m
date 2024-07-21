Return-Path: <linux-kernel+bounces-258292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1023E9385DF
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 21:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4186C1C20935
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 19:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6D41684A7;
	Sun, 21 Jul 2024 19:12:15 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A1E5228
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 19:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721589134; cv=none; b=ZWQaKg6Rc3QMMmWXKHsTR1pgwOxo9DSUm0vLfsRVzWWqyhG6Te7ebpqSn8IXJBTo5cv+8j6tvjNealwkImhfq7Mujbt1oeSnang/sHL0VsmjWdsQxkhuFIPgZYkTN0IJMvDOOCUYD4P6O00IULJoo+3FT4CKDXp+bhbbCPPtrPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721589134; c=relaxed/simple;
	bh=4zUgbqdECJ2bZRo0smP6NlkBX6RrisKcWASE6RIpa4M=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=IQROcwz8VlDZEHc4IQcGEEPyGwHMNxtXw6n9nqXjZH+Suu8IhLu58Oy5FJWyGABIn57f9NK4njgMHv7Fbm9TeGH2My6v32o+mWDTlQsIAtk7753hGU1aQtwIeIvpequx8TOJ7DGcwR80SUM4WgpjU3l47QOsaLv7xwNtL/ZTuUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3982257ab28so40928635ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 12:12:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721589132; x=1722193932;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rktk6/7LzE6MTgTTHhHP5XesAUc8CbD66qviMDJQpig=;
        b=eZRuByIHyew2L17WB7L8j/OjkTzpJy7wxw985Uuzh6bR+eP+t+kRJ09F2jjhjWGpY1
         eZfh4xPuiPMh2H0rlqAQyOBMM/jhhDTDt9j6gDRnh+amwAEeAhkezUoFKTVTGM5kClqR
         NK6i+R/5F1zWbdTKdHsV8+i9ZsR3jzGW6a0Ilj9cALBG8sMBRcnYTTsHB6YjTLub6laT
         FOTJiafZxzYu8iNEMZ7glX8fXT8TrZ/PlAYIk0g1Ea3Xp5il5LkawrxMHVSfh8+3N7Ls
         DZUaW13WyYcGyLgs1MbsW3o2Qeghm83oSu8oz0xh9UnGr/5B38F2+uUDtMxSha5tIPkd
         EcxQ==
X-Gm-Message-State: AOJu0YxhU2Kld+SnWIjrIq5Q0ns9J8mBL5cXUxL5gMNLZBQWyZESqXiV
	zXzacCdjexg25/aBhtDN980jkYJMiQ2nuHuivbjsFE03Ctxp80bh44H46op3Na2qvpjVY8xSvV4
	KfTN6VZORG8YMsITes+tIidQUpPAa6a5ClFYeK8BZF3Yuma2HzvSsC2s=
X-Google-Smtp-Source: AGHT+IFvTbCpEBzE8ItwoGi0/PlRdjK/6zNCdw+QACFhDziRO6gAP+rWZsGVz5bpNEDNHajCallCTPezYC5Wb5tGuf6F/qm91uqK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2166:b0:376:417e:c2b2 with SMTP id
 e9e14a558f8ab-398e83b1417mr2389165ab.5.1721589132608; Sun, 21 Jul 2024
 12:12:12 -0700 (PDT)
Date: Sun, 21 Jul 2024 12:12:12 -0700
In-Reply-To: <000000000000660926061ab2a441@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b2d612061dc6b4fd@google.com>
Subject: Re: [syzbot] [PATCH] btrfs: Change iov_iter_alignment_iovec to check
 iovec count before accesses an iovec
From: syzbot <syzbot+f2a9c06bfaa027217ebb@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [PATCH] btrfs: Change iov_iter_alignment_iovec to check iovec count before accesses an iovec
Author: dennis.lamerice@gmail.com

#syz test

Signed-off-by: Dennis Lam <dennis.lamerice@gmail.com>
---
 lib/iov_iter.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 4a6a9f419bd7..2d82ecf1b622 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -783,7 +783,7 @@ static unsigned long iov_iter_alignment_iovec(const struct iov_iter *i)
 	size_t size = i->count;
 	size_t skip = i->iov_offset;
 
-	do {
+	while(size) {
 		size_t len = iov->iov_len - skip;
 		if (len) {
 			res |= (unsigned long)iov->iov_base + skip;
@@ -794,7 +794,7 @@ static unsigned long iov_iter_alignment_iovec(const struct iov_iter *i)
 		}
 		iov++;
 		skip = 0;
-	} while (size);
+	} 
 	return res;
 }
 
-- 
2.45.2


