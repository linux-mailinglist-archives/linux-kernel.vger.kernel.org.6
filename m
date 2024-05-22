Return-Path: <linux-kernel+bounces-185783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C61A8CBAC6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 07:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BD3F280E33
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 05:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B3577113;
	Wed, 22 May 2024 05:45:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4187710C
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 05:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716356705; cv=none; b=c8CptzKAL1FT35aUwOVm1FWyRUdMefAYdentnlnbC5qi9C9C2CHrC95u10Hatgpaj4buZ8xl+XnR6TwBiVQ0aN58m5rNQU2OKz+ojUPGuB2OORMAFeHJttYmAFjQX1lmWuZaXtv6SyaDi93huUIU1JfVzNLX//cHeI5cNp/AbsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716356705; c=relaxed/simple;
	bh=GUNzKR17ExrlXxqaZ0pILUvwkdrZ3pQ14y1UNPvZkto=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Z1QLfnRXnsgCNy/bjMK+bzON88qzIrwV/cMerz0wis8xgYg3tOjFsZtQSn1yOcbidphfVlPMZMQN4a+H+0E1m3DEduLqmEaR5G98HP9enOiQ+Zd5H0uCHmQZ6YEHF5LtZt32HdlRDWXshO9nedro5f6e/586HZjvUm+9Et7fY68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7e1fe2ba2e1so969072339f.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 22:45:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716356703; x=1716961503;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rgty7Pfnmfl9KQwoZJU67HqbxOvFg+UokW7KT8OAsAU=;
        b=B/FDZuKW7dKfq1hzW8rTFUFnARf5z0GkcgpcZ5yny4Q534mbOghFHkRZxxyQRVAKb2
         dOyRrfFsCo5OydshrmaUdOtBA5Yh4LfTPKbUIMo7wDgiJ+wfwdJs4Ofx8BTRyn+FPv91
         oMIMS3v1xmrzEUibQ7e7lr2FOxcj/J80Wk7TPOyAx1BMMfYO8RmpKffDWf4OQ/UWJNg5
         BsDcAWVr3mxXM4NamX73OgnDJihrRu4Olk01hhdWEapjB0mJBTRkLbC4Vd7qN+3MBv1P
         f/8zjJTkMBK8+zPmLne3wreFIAemtSTCuoPehl487dJ5waQ+XiYXP+0SHd8xgG5xT6Ag
         J6qg==
X-Forwarded-Encrypted: i=1; AJvYcCUJ7py5nmqiuvKZILXTGrJ9CKXg8JMLNDx8JuRWCizmhP+ztNmhnWVEbCkYxFv6qdsdZTHjp9MnwnZefbqArCn9cMiXHHf0k5TwkNiy
X-Gm-Message-State: AOJu0Yxm+0GqDf7FMyeZNQUTxS2z6qRPM5jqdL+Mbb3GPUgyR60LTQ4J
	h7uTvkkU9S/ACX3/qcKcBDbum8HioG2xZ3swmxKUqv8+cYhtqiKmnRBIBzW9nfl25HbnoCQwT91
	BXNOSfosOvmEnymyqREPvASvQUsDZlNJrNH1xDrwCJBV/C254m18FB4M=
X-Google-Smtp-Source: AGHT+IFlXDjgQcMSg1MbONcL/etxR6wlTAo+jyX+GNoqh/OcR+Z6aOn0RzVOiLRANV/tkRDG60ybRjo1nTv5BU1FFXH88VBbnvi4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d92:b0:36c:11a0:7878 with SMTP id
 e9e14a558f8ab-371f73d553emr948305ab.2.1716356703406; Tue, 21 May 2024
 22:45:03 -0700 (PDT)
Date: Tue, 21 May 2024 22:45:03 -0700
In-Reply-To: <tencent_11C652F8465D499BEEC06EC00CAFE7D30606@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009d5c0f0619046f5f@google.com>
Subject: Re: [syzbot] [fs?] general protection fault in iter_file_splice_write
From: syzbot <syzbot+d2125fcb6aa8c4276fd2@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+d2125fcb6aa8c4276fd2@syzkaller.appspotmail.com

Tested on:

commit:         33e02dc6 Merge tag 'sound-6.10-rc1' of git://git.kerne..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=116d7244980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=25544a2faf4bae65
dashboard link: https://syzkaller.appspot.com/bug?extid=d2125fcb6aa8c4276fd2
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=127284e8980000

Note: testing is done by a robot and is best-effort only.

