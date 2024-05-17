Return-Path: <linux-kernel+bounces-181663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 621658C7F56
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 02:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 913731C20F07
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 00:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E909F53BE;
	Fri, 17 May 2024 00:53:07 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162314C69
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 00:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715907187; cv=none; b=oI0uwTP1OEUuuNhaws5F9GUeDHA90I5K13+RMu5bQxBrx9lTqt+4nR8ixy1jrZkMBb5moSIm4ZsltD1JV8dRCj7uKh+7PU9mV3B58h2OvuBO33Oh7EFFHyIOI2UxhK1JHa0oGRaixp7jZmYVrNMUo8RZWyolsXxqvGKF36ZHjuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715907187; c=relaxed/simple;
	bh=sZkfRGx81PNy4l8XcKS/rTxCpOgCjpidypqeWZKggj8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=kDIxxnhvfmGjoT2QPiEt2iEzUTlR+oyewJOEN7cghKGK8eRim1XMO8eKRmiCL+/ebLhZTPX/unZXtdfOIgYvFIVMpyET0KsLEKtxAycAt13wTwdhRJEFKP60NgTjmKT0ZL1Gj0pr8fhOGV7CztBEbL4zsDIurJm4pTKPNzYPZng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7da4360bbacso1039705239f.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 17:53:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715907185; x=1716511985;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IjdWI0lJRz5eaa2H8IbUT/eaNWS9H4r38Ph856qRU5U=;
        b=YgsbvmyAZJXaonpAjUyLawfROnUP5Mbg5/bKBwAqZ0ds/7zWmRQ3SmtNPTXO6U79fs
         ftppYmh0TjM3IEJZ0F1tNjBmaBZBlqzg81YTsT3IvxMItXqx1dJAi/SXsE9j1DelQxfo
         ySkOdkOq/ZkaVWVRZzPqr7V2w2486ZTBaxXaliJAQJfxYwfpTwLQNULpmftzHGY5V7Z3
         jOhcoU9yEMvUCVg3nxNphUg8NZFBoFq3m6ZV5oM0t8YWAVYnQzjeQd8yE1gPkxLtzP+u
         ryh+jAxITaXBqsUXdhajHxNrHb/PexuqtMM3lLWa7hzM6/fKrAwb7Jz1zLkIS4fWbD5g
         n7HQ==
X-Gm-Message-State: AOJu0YzcreX1LbrjJGNWSamaiXq7g0aLXHyl4nIk5MUE/92nzR+CJAc7
	4JGWjs43dpw+g1thKGu+mdJ3eUfKKB4BfR8+DDBt1I0OqzmgZ87Vnas22jOyQ3DWewBb+PGzPSs
	TKuSJmEajhA+qHadF8M2BNaR0F7RO+SwQr3GNVlCn005v/EWMQhI3JEk=
X-Google-Smtp-Source: AGHT+IHRYRoEWHkjd9xLm9lAYmqsocJ3lI59iMwIlG8sUiWuSGbh7mLPu/AvDStztcPWKexd2ztckpC+F3KiDeWlyOrrCNwlSKl9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8404:b0:488:c345:73c4 with SMTP id
 8926c6da1cb9f-48958e13eb1mr1643674173.5.1715907183749; Thu, 16 May 2024
 17:53:03 -0700 (PDT)
Date: Thu, 16 May 2024 17:53:03 -0700
In-Reply-To: <00000000000001ab730616f23768@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000027bd8a06189bc622@google.com>
Subject: Re: [syzbot] [syzbot] [jfs?] KASAN: slab-out-of-bounds Write in diWrite
From: syzbot <syzbot+aa6df9d3b383bf5f047f@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [syzbot] [jfs?] KASAN: slab-out-of-bounds Write in diWrite
Author: lizhi.xu@windriver.com

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git ed30a4a51bb1

diff --git a/fs/jfs/jfs_imap.c b/fs/jfs/jfs_imap.c
index 2ec35889ad24..84c9abb0fa71 100644
--- a/fs/jfs/jfs_imap.c
+++ b/fs/jfs/jfs_imap.c
@@ -746,7 +746,9 @@ int diWrite(tid_t tid, struct inode *ip)
 		p = (dtpage_t *) &jfs_ip->i_dtroot;
 		xp = (dtpage_t *) & dp->di_dtroot;
 		lv = ilinelock->lv;
-		for (n = 0; n < ilinelock->index; n++, lv++) {
+		printk("sp ms: %d, dp ms: %d, %s\n", p->header.maxslot, xp->header.maxslot, __func__);
+		if (p->header.maxslot < DTPAGEMAXSLOT && xp->header.maxslot < DTPAGEMAXSLOT)
+		for (n = 0; n < ilinelock->index && lv->offset < DTPAGEMAXSLOT; n++, lv++) {
 			memcpy(&xp->slot[lv->offset], &p->slot[lv->offset],
 			       lv->length << L2DTSLOTSIZE);
 		}

