Return-Path: <linux-kernel+bounces-419319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD5E9D6C6B
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 02:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9808C28166C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 01:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90215FC1D;
	Sun, 24 Nov 2024 01:40:04 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE741E522
	for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 01:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732412404; cv=none; b=Nr5CyCknXaBfKFgSudefbPzDkGEGKGw5hWFyQg+Wq79dwr3Bc8ZKOIkvemKL0keVvATHZsFgHFWTNrpK2JxjuMNYIWGq+MQuMs2DcQ7t33EW29uCsSxHpVFY0bPBDQ+mSL5RK6Y0FEgL40rFr2reQs7KUbClMh/ZTT1CWgXaYMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732412404; c=relaxed/simple;
	bh=RktkeA3/HMgOVmPFR4NL5Mc9JJJotp9v139zX+2XHks=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=TR3SdVWrtR8Chh1CKQ2w3HV+teJZF7MAnYUaHyQ9ymivQTJKEvop4GFgGRmUk6OP878sjIgQxKm+oAVDidxmyGPZp950n/qWg6WIK7v5+3NOmARresbzSo7j9t6/OvyFkD8YqqOsWqErK+TbQCqX9XUlfS+jgANEn9OsHPABTx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a6b9f3239dso37994835ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 17:40:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732412402; x=1733017202;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YjnvTwZRN+j8oGsq1lXAqtFO6kntKG2HSXqADQ2xD/8=;
        b=LluU2VZdhzRE6hq2/tP0Jb5rdgyZiNc5GTvGOiVQUmFgqgQpwIdsmwnMZVz3k/Rm7G
         U0l+P8u8YUUPQtmIBuYItrdbERR7/2lK8PNFZs2wqOEbJfE/ubG2og1u+53+OMJap7bB
         2J2sp6o+Yq2/1cYUN8URcEpCjQAkXMIYnY3PBWSUwIutvS2PFoXaSk3D+rzG3Ne5h7eT
         fkVHe2CJn4L0VHqVLVDsrgCFtLax89451WeovQQ1a5HlI2DJFePLNOgbGB2FbyNP21Cx
         UugBm1MkT1A0TIasFWIe5KWyzZWFc2UqZn1pPe9KxcRUoXaxpZRGMVYImIYavwUyuexk
         ebUA==
X-Forwarded-Encrypted: i=1; AJvYcCVgekvE6GOeaKLXngDGRy3nbVJIhLsAbHANWGJNLoxT29gY6sWekNoWFZvPlsjnA2258rUmGotoFkK/l5M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb9+g8kqR9HHv/E0AIsHqmT1eh9Z0qLArBLoVv7Fj7l4RNwlR2
	Ys6tlhu9F4bV+sExrRKQCOv+Nm83hPjOSpLhHHjSPDOCjkZaR8xTeHV1Xf22aoxshEOngD64qAx
	JKkHau2p9+9jrKkEANUJRdQt0fa6W0v3QwaE7ZpT0khA0MQLR8P6iqho=
X-Google-Smtp-Source: AGHT+IGL5Lf+YBzZT0OpDq0ri6FMKUZTlGhh97G1oG7s/0nxvC8Unlrv+e1eJcQ4MUABqDopfugHmC0fm9gnQOHXJ9u/6om1qQSE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a41:b0:3a7:820c:180a with SMTP id
 e9e14a558f8ab-3a79af16bbemr83792775ab.19.1732412402028; Sat, 23 Nov 2024
 17:40:02 -0800 (PST)
Date: Sat, 23 Nov 2024 17:40:02 -0800
In-Reply-To: <20241124010459.23283-1-leocstone@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674283f2.050a0220.1cc393.0028.GAE@google.com>
Subject: Re: [syzbot] [f2fs?] WARNING in f2fs_unlink
From: syzbot <syzbot+b01a36acd7007e273a83@syzkaller.appspotmail.com>
To: anupnewsmail@gmail.com, chao@kernel.org, jaegeuk@kernel.org, 
	leocstone@gmail.com, linux-f2fs-devel@lists.sourceforge.net, 
	linux-kernel-mentees@lists.linuxfoundation.org, linux-kernel@vger.kernel.org, 
	shuah@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+b01a36acd7007e273a83@syzkaller.appspotmail.com
Tested-by: syzbot+b01a36acd7007e273a83@syzkaller.appspotmail.com

Tested on:

commit:         9f16d5e6 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14d40778580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e92fc420ca55fe33
dashboard link: https://syzkaller.appspot.com/bug?extid=b01a36acd7007e273a83
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15dd69c0580000

Note: testing is done by a robot and is best-effort only.

