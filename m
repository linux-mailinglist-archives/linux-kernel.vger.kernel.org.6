Return-Path: <linux-kernel+bounces-311717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4F6968CAC
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 19:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D1D9283CC0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 17:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D291AB6E7;
	Mon,  2 Sep 2024 17:06:04 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2697914A0AB
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 17:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725296764; cv=none; b=r3CtRT8D8YmSNEzPdeZ4jp47dL6Z/d7LBUMa2nol1ceQrtWdPS9mWPLkz7abH0bcPG+MxZdGG/lcitdRt2sp4wiMDQrrIrDiGpZpfSbKN9zJbOJksIU93fJSDB8x3SXD295pM9PXB/PrQvdFOZ76Uk0KJv3r2RqQK12QFSMvDIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725296764; c=relaxed/simple;
	bh=HOVuxjh35ngrgfxee8gTrNkL4Q+ttvvmZJhms8WiX2I=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Rs51NG7YTg9B1oZTMNOBLWhVAyAysHbyb6fQD9rz3qhk/2XnrxmUr2LiMDzvkHHe/bXTYOwo0vuJ4j2DqjadRMzW80+cYYnyjguV1b6AD3ZtOG4nhR4NKLFiSr36DiuMETrLXRpE6zLsPcb0091DPlIb1vry4C25edtjLXUNYho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39d505a087aso37504775ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 10:06:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725296762; x=1725901562;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+9h8gvuBv7gC6hTSducA5gk1xPgAH5x4Z4ANO2RXsDg=;
        b=F4gDt54s7HDzvYUD4Vev7ozz6Fzn1nA3NRQ/0Gc5jmTEi7YN6F6oUqd2Rz9K2JhW9B
         M6Suqqe20fJM+JUWcyeokh44UhKLvWUObD/YV8zqNL2LEkgyVlAOym7qIzScph/I/MyY
         71XbKJM9mXlHs8ippcbAPTpS6suKiNa35XXHfUl3OYZq1XjajnkdXwPi9Bi5P9B/UUGF
         iQjVM2/eXZ3y1QYHJGlpXU4qlokEynGysfch8RvoAEZJDT5oS84Nic3kVwXj3PWHY4dx
         RU4xNLnKGCzqziNjyAZmVSU9xOl8pQDpZb2okR2an3o9Qjzi4SFfNH1W/HKsTfnx9XeH
         UTAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpPae6B9M+Y2m2tCglh1cd14fJozhel6wcZFad5godRdpXcRePeWtF1I8rg3Wraa6uupPpT9EYgm2Z6cg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqCeFhL0zEhidzIdLzPvgOF7W4wh9hQ9U/bCdoN7IkGVQazjI5
	rey6xLx4SxtapSSM86O1U1d0GVq3l4UXDV/t6snt8pMeMdqcoU56kCjFD4lCc7DqYTya4nPmHB7
	YKuN1V9Hz3lN69ofRlJDod3rxKjrT8G2P4Md2qTyDGr8j+QdZRbsR0Z4=
X-Google-Smtp-Source: AGHT+IEe6jLSLtpb87ZQ/VnQKgC+L9fl50UNNSivU+n4GBtPHWB8Jggov4IARNh/WWDFpQrJuocyo7Zt71lYa8YpdIK2taJ1RW8+
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1647:b0:381:37d6:e590 with SMTP id
 e9e14a558f8ab-39f413c0904mr8119985ab.2.1725296762125; Mon, 02 Sep 2024
 10:06:02 -0700 (PDT)
Date: Mon, 02 Sep 2024 10:06:02 -0700
In-Reply-To: <20240902164326.76207-2-djahchankoike@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a39036062125f43f@google.com>
Subject: Re: [syzbot] [ntfs3?] BUG: sleeping function called from invalid
 context in ntfs_d_hash
From: syzbot <syzbot+7f71f79bbfb4427b00e1@syzkaller.appspotmail.com>
To: djahchankoike@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+7f71f79bbfb4427b00e1@syzkaller.appspotmail.com
Tested-by: syzbot+7f71f79bbfb4427b00e1@syzkaller.appspotmail.com

Tested on:

commit:         67784a74 Merge tag 'ata-6.11-rc7' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1534c70b980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d34743b6e48523a6
dashboard link: https://syzkaller.appspot.com/bug?extid=7f71f79bbfb4427b00e1
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15d4c70b980000

Note: testing is done by a robot and is best-effort only.

