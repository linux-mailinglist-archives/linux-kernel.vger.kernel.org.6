Return-Path: <linux-kernel+bounces-188274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D5C8CDFF0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 05:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8E1EB22A70
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 03:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80AD82D638;
	Fri, 24 May 2024 03:51:43 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F891C17
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 03:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716522703; cv=none; b=XTg16VP1ATA1k/pnDsdLfCk4H7cBvQ59YaMa1VqmC4dIivvDrkm9JF2Zxt+QeE3lHaMurCzVKd0ooe2Q8T9lpOV1vxHSn7Hsk7o/1H57LLObOqUwFROWfAYHzsr0tk0o3AhmyofabHldZwb0imG/qrURwAgLJDHHhhNsqzEqNzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716522703; c=relaxed/simple;
	bh=U9TSv8E+s5XPWS4jn59GlUaI7uiL+0vhvxh45qs0HbE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=kC2MvvhJfmxCUgzfHOt8mOoVlpN4m4aWAOGkHqNKgUTzN8+r1pagD06f/kgdHCn9qlaWfU+AECslec5ZJw70pYhXUwjSYe+1UE5MSTm6Op6qF4pSxgJV2BkFrNgm3vDXztmyyLpx02UrEC64ifFSR0BitrO7YbF9vbnt/0ncNW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7e8dbc4a698so33207739f.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 20:51:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716522700; x=1717127500;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e7FXaAOJ0JZIPMPON1PZBtTxOAtUEwk1xL+NQzn+0zI=;
        b=c0VETlbdn3GTamiAUNBgjKk23A1CU0QEJ+wxYPVOSSU5BRAcunSjVs4SVh9ro2x+qU
         HK9Ws34jQRoLRSbSwcgrQPSoljZIOieAbocv220PsUY45+H+ulS2FoSLK/GRGmOkXP/Y
         lD5/FPEL9KtZdb8NbP1P3wi81MkkCzbMm0IbMOUPjqyHB0YvuR/Me25UPgTTgCc6w/aO
         XidM/ruwY9VhebLIzt2Ti36DGk1Gm5lnQEUOlEyxhTGnCjpUO5GBQ+bn6wNVEKTHJU4P
         it+IXSmxRFLD8AwaPtyMOJrJwS6HT+DXHTdHqXA2/vqp75MAjGC1YNmytY4AkZMIYfOP
         opBg==
X-Gm-Message-State: AOJu0Yx48YSgJ/YhQ/grvO8rnewOvcIWzc1I4EskWfmJdN//DgrpxN/R
	xNH+3z6bjKO8vR+6GA+MBte3GyZrWT7fAFvvdaaut9VZRLyrRuCk0SGjnKb2P2FQQHTMeU0LABO
	ENgrmEaeXiugM9o2B3G7CJhwzBiNVTisQlEe0aIsbf5CZZfFROnK2M6c=
X-Google-Smtp-Source: AGHT+IG1N4TA8P4AYjDW2OGzbruuIYXYUeyYuB/y2ddkmotIYuMA9o39T+W9DYzhcL34PosatX8ZW6DGpLY5lhFMA01R59qN/Y2o
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:154c:b0:36c:4c63:9c93 with SMTP id
 e9e14a558f8ab-3737ad8d851mr836545ab.3.1716522700814; Thu, 23 May 2024
 20:51:40 -0700 (PDT)
Date: Thu, 23 May 2024 20:51:40 -0700
In-Reply-To: <0000000000002fd2de0618de2e65@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d4d13806192b156e@google.com>
Subject: Re: [syzbot] [syzbot] [fs?] general protection fault in iter_file_splice_write
From: syzbot <syzbot+d2125fcb6aa8c4276fd2@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [syzbot] [fs?] general protection fault in iter_file_splice_write
Author: lizhi.xu@windriver.com

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 33e02dc69afb

diff --git a/fs/netfs/direct_write.c b/fs/netfs/direct_write.c
index 608ba6416919..d74761fb1876 100644
--- a/fs/netfs/direct_write.c
+++ b/fs/netfs/direct_write.c
@@ -69,7 +69,7 @@ static ssize_t netfs_unbuffered_write_iter_locked(struct kiocb *iocb, struct iov
 		 */
 		if (async || user_backed_iter(iter)) {
 			n = netfs_extract_user_iter(iter, len, &wreq->iter, 0);
-			if (n < 0) {
+			if (n <= 0) {
 				ret = n;
 				goto out;
 			}

