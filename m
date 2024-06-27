Return-Path: <linux-kernel+bounces-231735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E250919D17
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 03:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9BB21C218F1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 01:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E961379CD;
	Thu, 27 Jun 2024 01:59:40 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A196AB9
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 01:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719453580; cv=none; b=MX00s8WiloQ+qdygjvnxsCGrAzfSdBfwJssSSP0DhZN+KVzOy/2odJB1hfhuVugFh1PEw71y8GS6risfLEEXmIy9jA9oF8RTqqA9cZyPZT7HsJ5eXY2uFWezztbkWaerDKQf2f1soFWmS49/VSCnltVz1weHP9PbJULWvEZbsRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719453580; c=relaxed/simple;
	bh=2o7vVUFIfOIjSP1vlIJZp2XcD0VwqpvB/JMpkZfbhFQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=OspvGrH6EbiAMWXTKfphUUGlv3hmiyi08DGrFxOyC9Uwjj3Km0yJ9b7gsRb7Qt5fj525nc4N+dFp7hT6a3bC55JJttJhtw9S3iqmfIerpfNZz+yPp/YadR2UfoS5ad2Ny2nOxC+Xb4GnGJVeShOherxS6FEJM77s4wyd2yCnYYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3762171acdfso117065445ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 18:59:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719453578; x=1720058378;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BtRnbB5lhTlj9XZiSmNlzzjHv5YCVNooOTZHzrf5RrI=;
        b=dYEAvPmO+ECcDaNkNMU32mb0HPsfprYXJxGZ7mB/hcx8mZyi4MwjAPMkUqFAgdPKWs
         JVTnzbxycs+UOSrkm3ktBzugykJI/7DIHKgnimvEKgJqXOyWgRA01w1e48lziRE77E60
         eHuud8jc3zAjVeFHpRU4kisXvjGeQczlWjE8ruX61gwFGjOx/0qSYMSIyDLlyoqxc4mc
         DMzLxrj1iPi6Dg3Bzd1fRgLh4pPwn3z+Od8Me0j1nJ2KEtZAKHo7tyPLr7EGpRe+1dTM
         HJAKp3vm1+z3vZZZLp4NJu4s/+Dqby9kxFXeoC3ZEQwn8x/PXwgbnN/i/BNpiBKK5Dmp
         fT1A==
X-Gm-Message-State: AOJu0YzVSSRC41WoVCRp3dKGr+ymDYRdD7WqwAvukjDeaxDvQ0flAU/b
	8iN6FliCVoe4axAhcA2mCNK0D4M2Ut++Amru4xfJCf/xee0skYHCjlEYJwD1HUaxgejr4VnEJFw
	Z9371MhMV923CwXV3dcK3Jijw5Kp9c4Y71VFgY+7OttStVpp/lJJWRe4=
X-Google-Smtp-Source: AGHT+IH2qFO6VVBj6qitPNn63ICKJ6s5Ri7+Jes4J93zDI1jhh8KHWOXye043wtXfNtaXJ9sNCqFSRI5E+Ds5/hfnuxUVxnafXe0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d16:b0:376:4a18:a4ca with SMTP id
 e9e14a558f8ab-3764a18a6b5mr9377355ab.4.1719453578381; Wed, 26 Jun 2024
 18:59:38 -0700 (PDT)
Date: Wed, 26 Jun 2024 18:59:38 -0700
In-Reply-To: <0000000000001f253b061bb8a953@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bf5f28061bd57be5@google.com>
Subject: Re: [syzbot] Re: [syzbot] [jfs?] INFO: task hung in txBegin
From: syzbot <syzbot+eda89a33c5856f66f823@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [jfs?] INFO: task hung in txBegin
Author: lizhi.xu@windriver.com

#syz test: upstream 50736169ecc8

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 92a5b8283528..965bd3f109cc 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -2078,6 +2078,7 @@ static long wb_writeback(struct bdi_writeback *wb,
 	bool queued = false;
 
 	blk_start_plug(&plug);
+	down_write(&work->sb->s_umount);
 	for (;;) {
 		/*
 		 * Stop writeback when nr_pages has been consumed
@@ -2162,6 +2163,7 @@ static long wb_writeback(struct bdi_writeback *wb,
 		/* This function drops i_lock... */
 		inode_sleep_on_writeback(inode);
 	}
+	up_write(&work->sb->s_umount);
 	blk_finish_plug(&plug);
 
 	return nr_pages - work->nr_pages;

