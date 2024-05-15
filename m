Return-Path: <linux-kernel+bounces-180253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0DCA8C6C12
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 20:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59DB51F22E3F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 18:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D349C158DD0;
	Wed, 15 May 2024 18:19:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FDE158DB5
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 18:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715797146; cv=none; b=NrLmdqsHnqPXxYJ9xa4K7XsPBVpXRZjyOTLG7PrOPtAVJyFA9DirXg9S9awF0c8Q6s7p4fMxT1OwZJZ/0H++7Ud78CPKF7JBocfXFL78PScKkeiweD2SlDijtrUvK6PQKdap2Qr8Gy8+GWtVJGl88FZYIzF+iRXxjEr8gG30NHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715797146; c=relaxed/simple;
	bh=5eudQLXKDiRsYY49Oc+zW6UDq5YXoyySbCrA4nZlq9w=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=nZj/8bgpsSRbyWRL5bAmLxYRlm7g6WSMataNZNQhOqrQH9+1huCX7Zq2eoq3/CKvp2v8BHsRoFcExL7UrybQLsMWqGK4YpKKXZM8z++IuGz2GH3G+H7b+EfCqfGLfeADg9RoS8Qc6MmnCMFFzhJyXd5JTWR/f/CT4jJwH087r0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7e1ea8608afso335650839f.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 11:19:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715797144; x=1716401944;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z+tpDgK2JCqXeT0yDQHOxK3Y5nf0WqVOLoMtiI3Y/bw=;
        b=Q8PU/4/IYR9hWLApMZBKjiIXbMIGSvrSAMf4GaR+quttf0+Sslsv9VXuEsWBfb8Pzg
         Mrn/XEFM9Cu3CUiSC2qbaJDAYJEw4ghv8L7vAKRgt9+7dV2FIpOd2Apgpb86vYEzQdw/
         4/2wJXNVQWYvXkIoIXKvM43mVirxdmdNJzpHVWSRPV8L/oDppu3eNH0GCN4c6vNo4NL5
         NiqcWrJK+unuPa9Gh1bAk4EwsdSQTCJsZJ3tJIPriH2Q2386AEz3YHCGLgviG30nQlL2
         v0tvc85b4ihx3AXQv70XDKPGYSrxf0rCZGBEf72lHjSZxl31t2H42VMuoVbIq8DUG/xV
         yimA==
X-Forwarded-Encrypted: i=1; AJvYcCV/jI5jND2Pl1reesR6iqUBCd/m40E7X1RlU+oQCU838zvC5QAqJCKJq6MsGcJhTSuOJdyVomDkoCxg+AqKYMB6+LGzbpX4/q+5ILGu
X-Gm-Message-State: AOJu0YzymV2hAFCioepfb80VObZCKttGAZOLAD7o/p897jQ5POfDCJq/
	KRlVojsavstmeUU/lPmFefVxsVzKp0sobpWE8ASwr0MaBCeBNcbCH6TRImeYnsobdselqXN7lQe
	tDpv9E3Lyq4FkBa/g3k7P4HApQtCsdxjTNKugXVoot1TtHwAISaP7MQU=
X-Google-Smtp-Source: AGHT+IEjNm55R8nOlSIvYdtT/+wPoKVbHS4MXBNSquAdO95DQ/qV9dYHkp5IQ0ROpBGxD/p/1FKq4FdnI5XNMO2HYBR0ez1OuwCN
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:861e:b0:488:59cc:eb4e with SMTP id
 8926c6da1cb9f-4895854473cmr1136597173.1.1715797144326; Wed, 15 May 2024
 11:19:04 -0700 (PDT)
Date: Wed, 15 May 2024 11:19:04 -0700
In-Reply-To: <000000000000c4b45a056a36872f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004b67120618822707@google.com>
Subject: Re: [syzbot] [ntfs3?] kernel BUG at fs/ntfs/aops.c:LINE!
From: syzbot <syzbot+6a5a7672f663cce8b156@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, anton@tuxera.com, 
	axboe@kernel.dk, brauner@kernel.org, cgel.zte@gmail.com, 
	dai.shixin@zte.com.cn, ebiggers@kernel.org, gregkh@linuxfoundation.org, 
	jack@suse.cz, jiang.xuexin@zte.com.cn, linkinjeon@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-ntfs-dev@lists.sourceforge.net, lu.zhongjun@zte.com.cn, 
	ntfs3@lists.linux.dev, ran.maosheng1@zte.com.cn, ran.xiaokai@zte.com.cn, 
	stable@vger.kernel.org, syzkaller-bugs@googlegroups.com, xu.xin16@zte.com.cn, 
	yang.tao172@zte.com.cn, yang.yang29@zte.com.cn, zealci@zte.com.cn, 
	zhang.songyi@zte.com.cn, zhang.wenya1@zte.com.cn, zhang.yanan14@zte.com.cn
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=134d0268980000
start commit:   ceb6a6f023fd Linux 6.7-rc6
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=e5751b3a2226135d
dashboard link: https://syzkaller.appspot.com/bug?extid=6a5a7672f663cce8b156
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=172458d6e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=120d8026e80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

