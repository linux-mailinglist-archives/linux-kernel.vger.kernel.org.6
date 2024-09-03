Return-Path: <linux-kernel+bounces-312084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4109691B4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 05:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DA00284275
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 03:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C7B1CDFA5;
	Tue,  3 Sep 2024 03:18:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4385F1CCEFB
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 03:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725333484; cv=none; b=WY1mFuYmeC/t1PjvDH94xXivAXq7rapMsDTqXFQrHxJJZNstDdC5+VG3hCoGRiSw51f1cYqg1+CanmadcZbC6+DoI0+fNdvagryg4B1cJeAmTMCkjQFgZ0JsElnQrPjVLIAG4Faz52p+TSmmDbyaER//tCcIfAS8jHi2E/PB0bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725333484; c=relaxed/simple;
	bh=UKsafaKOpTutBvBKN9RjSvOLoEECFLlcAw8a8v5Ys9c=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=IcidKn5rdRsnCIyA6SkeV27XncFzs7FGbvGUEN71DGR369Ji2cs5DhfV4jiGoUsQF6eDgVLcRhKNNLuWcGZX0n86+KFA34ByOmby/ozNwpwvY+L1Ln5CWOGYxw8DlLosmQ04M+nAzGLm+qz46mhO1YgSLSJ8aw1jYPM11N1BPQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39d4c0fc036so55249805ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 20:18:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725333482; x=1725938282;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GIY3qxhs+YBnko6fNMwuLTrNPy2grAd1WtMWfLFkFJI=;
        b=BrblMTorWp1Qlzcp0qp9utQl43dfLNVHT0PZnAq2rLPSYXL00jO0n3omSH1wu8HOFc
         Z6e/00flMTqmEKgncy+/lH3Y2i7vY4xxP7ZO6QXIttQj0fKU5cT+JEugxaPuqh5Z4PkP
         kgTzv2M0TYS2Bgq1+HaeOXVxQddQKgXav7XdDcWXVHSqnqU1zjp4PyyaPqNvbl4gWF+t
         Ydn3icjRJ1ySkFH7iZAL3jsue4sXCOuL0t5fZ7w8DfyoU1umNKlD+Zp+dA5QfDUDlaEp
         Uo6tGQrU7iTlMrbMjmZ8tbfNNgVPJZ0PYbXBcy00+yfpy03gasPsF4eYXk2xjOtzI/Yg
         rpDg==
X-Forwarded-Encrypted: i=1; AJvYcCWYWKEYzNGAFNsvy1jq5c0xAJQqaZt7UiB1QMC51G0MzfQC+lV2eiajA00ldn7ysXckHwmdulY5Ft4r/n4=@vger.kernel.org
X-Gm-Message-State: AOJu0YysCLkZPkfR7gkZchWKj3zn+ht8ciQDM51nGxx6uxvJ9o5PPZEF
	RlopII8LpQpcsRrYwvXNG8rJ2krTsxgqATHqCjbRzEqyZYevVr72Yq6ZXjriOS7zeXeRDv3c56I
	60C1qFipMyOTDf0SJHdkk0DJ6R4ZiBVlRQvExXCPJpARSwkSrXbHGy1E=
X-Google-Smtp-Source: AGHT+IFBMybLBaTqLgdWh7TJcaJZmtU5urQQ0tUdUlaaZlUimQoe76aQQTRgUjuWFNqjN5iwq8C6BagGTlxKEWjfCUs7Kgr/GiO0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a6c:b0:381:c14:70cf with SMTP id
 e9e14a558f8ab-39f40f06998mr7888575ab.1.1725333482204; Mon, 02 Sep 2024
 20:18:02 -0700 (PDT)
Date: Mon, 02 Sep 2024 20:18:02 -0700
In-Reply-To: <tencent_A536BA4B40741D769567D23CF5373096CA09@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000053836306212e81a7@google.com>
Subject: Re: [syzbot] [media?] WARNING in __v4l2_ctrl_modify_dimensions
From: syzbot <syzbot+a828133770f62293563e@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	mchehab@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+a828133770f62293563e@syzkaller.appspotmail.com
Tested-by: syzbot+a828133770f62293563e@syzkaller.appspotmail.com

Tested on:

commit:         67784a74 Merge tag 'ata-6.11-rc7' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11b49929980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=660f6eb11f9c7dc5
dashboard link: https://syzkaller.appspot.com/bug?extid=a828133770f62293563e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=143f0f33980000

Note: testing is done by a robot and is best-effort only.

