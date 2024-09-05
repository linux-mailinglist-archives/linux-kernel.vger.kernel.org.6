Return-Path: <linux-kernel+bounces-316628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABEE296D222
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 10:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68A3B288174
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 08:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9BC15B541;
	Thu,  5 Sep 2024 08:29:41 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F91519340B
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 08:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725524981; cv=none; b=GPvffvVZMTYn63DSFYROnA6mlC4qwFrka1x//ILKmEzxszyC4mYiU+KfmyGDeIlDeijHmbYo33184kEYmoFDlJWbsX50wSuTH1I9IVxSgalFRA9P6lB6etI5ihXuHzVqOHOrxYloxQCTg4rMk6hbtqedTtkQR3fYGltYrX2pbZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725524981; c=relaxed/simple;
	bh=YaIP0zfntnnMvvvMsr9zDd/oCZOe1RYz2KusXeevzfc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=lxT6HL+SKyiBP4zYvZjWWy+X3AopM6pbDjk8gj115wp8F7gTtwmorIFDfYKHwBmf1O6sNipRYR+qUQd/6LPVBH1f/QmEgG7htReeHvjJYuxcKjozQtWH3m+od9QQOwed7iXIGADgfKV1Nv2+ldwR/FpiNOGPdBRWJUJVXCkGYTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a045bf5779so8626645ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 01:29:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725524979; x=1726129779;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8M99qiL1vL1FIolQ+fa/GNFS3dYJnMdpzHrU+gWGm/4=;
        b=NZkQHqRvtZzxa5hvzVwhDSPD2/RLq8iVBjelcvghfF+e7iiR9n9novOxqTZqnOiL5E
         13wQuxAhuMPaK0eciLTpiTig2k/K95GHGrFpMLM5uXlJBhL8NmaC9LrsFian5gtMDE51
         d/0w9tNLk1jR+6MJbwHQA5Nuq/AM8MiajE3dRTMg+8i+QxUgWLVndupFEDbnjx1/+YBC
         n3ahgQtq8E8ZKx/NyGo8JkRFu1x34onaEV7oF8O7WULhex4NEV1tE+ViJFW2/uVBaWZx
         cfaOzb/tKf5n242EHNgdUNLcDa1v+uQmhPwrk1vb0wCSLiGvi3E/Cv+H1V0xXQXshzIV
         qlPQ==
X-Gm-Message-State: AOJu0YxvgmgeKsoDJBTUz4oljp1CoOIujgpt3Yegv1zea980B6GwbBkL
	sNGryyfWczJ/m71ZSpVeZ3TQz3YWabXJ1J87udcZ54yk11OiN16m1phaFCJfwD3UsQJawXVNNQ8
	n5MCJteMQ6ruRFr+X3GsRp9Ch+TvCY3VUM638KFI65JsFiu/yYIzfkqE=
X-Google-Smtp-Source: AGHT+IFBFwccZgIlBQyJKvS4OOSUeZxIFFvmPCD8AII5fnt1JJqZSxMZu9I0fYYc9MwcKYIU0VJ7Nr20m4IuLShPbZc9aDlTuWOu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1548:b0:3a0:45c5:a358 with SMTP id
 e9e14a558f8ab-3a045c5a404mr1109015ab.2.1725524979327; Thu, 05 Sep 2024
 01:29:39 -0700 (PDT)
Date: Thu, 05 Sep 2024 01:29:39 -0700
In-Reply-To: <000000000000407108061e0ed264@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000071b79406215b1789@google.com>
Subject: Re: [syzbot] Re: [syzbot] [usb?] KMSAN: kernel-usb-infoleak in usbtmc_write
From: syzbot <syzbot+9d34f80f841e948c3fdb@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [usb?] KMSAN: kernel-usb-infoleak in usbtmc_write
Author: lizhi.xu@windriver.com

Short write.
User input data maybe invalid, clear the data buf of the user data before copying from user.

#syz test

diff --git a/drivers/usb/class/usbtmc.c b/drivers/usb/class/usbtmc.c
index e9ddaa9b580d..65092891ba2c 100644
--- a/drivers/usb/class/usbtmc.c
+++ b/drivers/usb/class/usbtmc.c
@@ -1586,6 +1586,8 @@ static ssize_t usbtmc_write(struct file *filp, const char __user *buf,
 		aligned = (transfersize + (USBTMC_HEADER_SIZE + 3)) & ~3;
 	}
 
+	printk("xf size: %u, count: %u, %s\n", transfersize, count, __func__);
+	memset(&buffer[USBTMC_HEADER_SIZE], 0, count);
 	if (copy_from_user(&buffer[USBTMC_HEADER_SIZE], buf, transfersize)) {
 		retval = -EFAULT;
 		up(&file_data->limit_write_sem);

