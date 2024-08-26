Return-Path: <linux-kernel+bounces-301123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6123895EC9D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 11:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 117E2280DB5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 09:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBBB113E033;
	Mon, 26 Aug 2024 09:02:57 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4D013AD22
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 09:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724662977; cv=none; b=T4ClQa+MnT8IEyVeS2Wo9FqFuqNNaw1XXSiI1kMZiman2WepbnOput5XPi7XwFaw3dRcjuL7Y6X7lzffmLjJcflglbf4VaJw2TghkllrSMOdMr47IZHdLV1Jd5XlhvjcEJzH/8DCvH6Lk2dcJhvKyVea924b70lCViO/9MRK4lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724662977; c=relaxed/simple;
	bh=QGvof0Rw99PI8XpAFNAPY4o/L3KC7BAhCkWXawdqiOY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mQRbwpBc05PWumBtx+dduxaZCEBhc2HUUjmnhMrDwP+5+sScDV8muhhuHkzXn+yvgud2I+m2dIc2fbDK0eFjPjGEsiVg4vefNZRdbvY2WnXOxiEO1xpsQBT1Qqb4bIvJSF6LqNaKz+y0yEZWNLS15iK353ndoi4rN0jBlsw2M8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39d2ced7e8eso42038675ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 02:02:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724662975; x=1725267775;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xK+km/Nfi+Ke0Omx2P0pSP6qNE9tca+bC1fqshUE+Lg=;
        b=L0UL3FHfZdx6X1AoghqHnZqKx4procm6ufZTS8ewv+uWAB/QlQjH90ynIeO30aqG2R
         5ygkXWzMj8HIlgr9cwgwEQ9C69F/bphuEy0nCuH+jyWFhimzQWE9MAWOhV/MKPBlSnbr
         AmEmT8s6xg9EK7eNaxgJr6RHFLygQBJ+y82v/5mV6Tny5exgw2NQ+k3VrnpPYmW0FcQv
         rMQMGx0uJgGbFpjvEmRCZ6hz9IBcxXDN82eosyaxV9trji07/nhFR9elyNvX2dJjMiJh
         xZT4xVJZXtj3mIls0YRMF4p/RzGz6B9qusLSHM4z+hahk88jmr6BEh2SX3WDttSP8ws0
         D4Ww==
X-Gm-Message-State: AOJu0YwXOLenIC2UHU5gC8YPDdoaLEcS4RlgIXjWdGwd/tbryF+XWXQl
	PPb3uVLQ8zQ6CmlBblFsxpPtVpSvav8HBwzahiZvhGYQ8jeEVqRZeHU6bPL66hRC3G1jlpmsaGI
	GyxE4Ix+j1lr4yiPm6fSNolDaRnHU0RGtrrxEuaXFUmwcAk88d/UMwk4=
X-Google-Smtp-Source: AGHT+IGHkifQ/nGGNU1Nx2lfWIC/ApmmEYyTEm0fnWq0i4CKLq592y2F8V7JU0/4udBSwcbIFMEwOcbYHYfP6Wp8/CKv1fY0nlvV
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d19:b0:397:9426:e7fc with SMTP id
 e9e14a558f8ab-39e3c8d2ad1mr8552585ab.0.1724662975264; Mon, 26 Aug 2024
 02:02:55 -0700 (PDT)
Date: Mon, 26 Aug 2024 02:02:55 -0700
In-Reply-To: <000000000000ab44fc06203f0d28@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ff8b0d06209263b3@google.com>
Subject: Re: [syzbot] Re: [syzbot] [jfs?] KASAN: slab-use-after-free Read in lmLogInit
From: syzbot <syzbot+d16facb00df3f446511c@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [jfs?] KASAN: slab-use-after-free Read in lmLogInit
Author: lizhi.xu@windriver.com

blk dev max sector is 0

#syz test: upstream df6cbc62cc9b

diff --git a/fs/jfs/jfs_logmgr.c b/fs/jfs/jfs_logmgr.c
index 9609349e92e5..14404780f38d 100644
--- a/fs/jfs/jfs_logmgr.c
+++ b/fs/jfs/jfs_logmgr.c
@@ -1163,6 +1163,15 @@ static int open_inline_log(struct super_block *sb)
 
 	set_bit(log_INLINELOG, &log->flag);
 	log->bdev_file = sb->s_bdev_file;
+	printk("sb: %p, sb t: %s, sbf: %p, bdev1: %p, sbdev: %p, %s\n",
+		sb, sb->s_type->name, sb->s_bdev_file, file_bdev(sb->s_bdev_file), sb->s_bdev, __func__);
+
+	if (!bdev_nr_sectors(file_bdev(sb->s_bdev_file))) {
+		kfree(log);
+		jfs_warn("open_inline_log: block device max sector is 0");
+		return -EINVAL;
+	}
+
 	log->base = addressPXD(&JFS_SBI(sb)->logpxd);
 	log->size = lengthPXD(&JFS_SBI(sb)->logpxd) >>
 	    (L2LOGPSIZE - sb->s_blocksize_bits);

