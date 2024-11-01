Return-Path: <linux-kernel+bounces-392411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD219B93D2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 15:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DE9BB21063
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 14:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85DC31AA7AA;
	Fri,  1 Nov 2024 14:57:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BC519DF53
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 14:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730473026; cv=none; b=MgP+chDcjMR5F0WTCyLbnrsEmyDQlQptvdIZOxzZGdMoc94MMfhEg3czZLwQsJimkd0BCR6cV/qzKOdk4g7s4zzoR9URApIDB3uoFZgJVDoqWj0pdXuLwX4a8Ym27qCKJlgTeBVxiJxSeWjlrfRlb6x3rRURHhMRJZr7ofxVGbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730473026; c=relaxed/simple;
	bh=7p7NxlZlrHgryQgSjVU1kcCEtuL0fyrzXG+TxUITzyU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=LDE9qFTZEZcYaWVG/IILZ1iKu7aZkXSPd1l2bfe/5zVOpGb6WFZGbcgckUeqjwiDqm/G8f655LC9viGeRQBCh8hCXG2vMMWVxioJPm3+lJAAK0+ZXpu6KpSohm/lxofnAUAuS3rDrFnXJt/NfWMsZs9PZjJYuMSNbtVVzMqWPtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a4f2698c76so18247005ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 07:57:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730473023; x=1731077823;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7bX5+Zc5C7DlFcCBk3Czk3smjZeeYWNDqBI7Biox78c=;
        b=aHZeie+azU2wXhD0mxfYdfhgkY++aOVDL249Ax6P/WwK+bXZ9OjZ0BFt8Ggc4Imes5
         9sr0PotuQW/+s9mfeEb8taOAcIq7xW5yYyDAH/FVhPK4nlc59KO4ZxmEQasnFN6y+ImY
         9vYW0eoPZK/Xgz6k1KkA1q1PH08QEuigfwaNpIFXSzmJrS/STp67ontACv3GWbMnHe50
         RzppekXpWczgkpeicqIG5VvMCK62U6kT0GmSF/TilkUlBiGRqJcLnCL3/nGo2yww6Le/
         Bu5AlhdgV+VY8vAQnKmDJC5x4J/lpbJb/PGcGNGbC3nl4YlPxztXntx51Gf3ZFboquvC
         MSUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpRQ0YHTJoV+DQT+9Ma0Vz6Xd044F1UGYOFg9V10VZxK5TARKxuyiN2sLSf17g11Qi48WlNMNYooILdBE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5bzlt69de2XJC3UtvGYlUJWisjTIJjRrKQC4euM01wCLID3ji
	rguktso2RtwD+gGBFZMCVhCJXfGjIOda+RxUHgbq+12qm6dgPbaiyJBrIIyEZkJLRYsMkmu8hlI
	o1OfIJ3OW+cOFpotTUrTSDwIYkJyL1nZIn0SJ4LpHVJ0vRPajIscXkjs=
X-Google-Smtp-Source: AGHT+IEFpdZP5uuWkzcnjIzf7bo7/W86L6XH59Sz/RXa1mVgXpiXlbfOipxGVxPUl9VZxpankvVhrIqXdvv4KozaqAODh6kBxmrP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b24:b0:3a6:ad61:7ffc with SMTP id
 e9e14a558f8ab-3a6b0329a4bmr47773005ab.17.1730473023301; Fri, 01 Nov 2024
 07:57:03 -0700 (PDT)
Date: Fri, 01 Nov 2024 07:57:03 -0700
In-Reply-To: <20241101143702.uKzjo%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6724ec3f.050a0220.529b6.0123.GAE@google.com>
Subject: Re: [syzbot] [netfs?] kernel BUG in iov_iter_revert (2)
From: syzbot <syzbot+404b4b745080b6210c6c@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+404b4b745080b6210c6c@syzkaller.appspotmail.com
Tested-by: syzbot+404b4b745080b6210c6c@syzkaller.appspotmail.com

Tested on:

commit:         6c52d4da Merge tag 'for-linus' of git://git.kernel.org..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=150fb2a7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4aec7739e14231a7
dashboard link: https://syzkaller.appspot.com/bug?extid=404b4b745080b6210c6c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14cbe630580000

Note: testing is done by a robot and is best-effort only.

