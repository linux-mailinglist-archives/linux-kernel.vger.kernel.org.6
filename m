Return-Path: <linux-kernel+bounces-308748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00835966146
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 14:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A02601C23720
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 12:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99073199954;
	Fri, 30 Aug 2024 12:04:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD67B1917C8
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 12:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725019446; cv=none; b=ALsw8seKZ2njCqHS14h2pqHe+tLDi8pPNBysbzK/2WxO5DZN4W5a0UY7OwNXNHBi3VMGYJy8xw2mxaEYSAbJZ/Q1M1ZrgVakb3gymiTiF0xzSPiTh55NAxiBApILnfl7gvSsb2tB3GxLm2U/WN+YaeILeLlradcvyA8boYMiVic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725019446; c=relaxed/simple;
	bh=LzYJkrUnXtqxg2sI+D1UMYC84BooZXybirjBd4noWGE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=tFI7f35ggXgjuQfPRKLCBCGx0mjHgUmSUvnXZ8TxM36Gn0Itt+Ktl3uoTFaqJv5Gxr9NEdGnIQcfXsii2yTPStrlcdY5r8FD7hlyiiYbjWWyggCUr91fgz+nTAyW9czenNlJw+/InwTITzj8Sq+Yd6yWllXfqCDHg1P/CxSZcAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-8223c3509a9so176656739f.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 05:04:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725019444; x=1725624244;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rHDsUT4NRjm0E62nv5pzyF9OkIWVCQzkDjrSQv8pAQQ=;
        b=t6ahIoPRNKqVsCtZf+8FZA6bq4vjNRXmzRePddd+/jn4kDCgrtr7nBzxnLgDXoq3Qc
         WVH2haYQY9B0bEqRemSEKglBwYg+drafY1kcKWGu4bAaV1JnTodmWwDokgYeyEkq8C+G
         O+nelTyyLdbhOl+qxei3da2sB3OkpubuJ3jo0VoNYXWxlNnAvdtooInd6PQBosa+v7Y1
         J+HRT0Wc0pb/NHpLXXkGwyYuxkXL5WuMu6aEGjjL2nJiih6WlntfAQWLj4TsibDzCx28
         gMNWHsZys9610N1pCjLbk3vIUj4/sxFxycvrLh02bxGx2Ylp6/40K89YO/Q0NWZ301B6
         1Tqg==
X-Forwarded-Encrypted: i=1; AJvYcCUOIH7/jNCdQheCs6cLL1xKCFDbB7EPo1O63buUYAJ2nmgLoXayeyVcF1rNqv3Gdj7KmOE2cDH+aqZeYMw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRIYYMsa9qw4UDAqsdqfr5rsqcYDS8p4djU9r5rMm17kRRPkZZ
	UI9pDoO4PmBXpuhGDwv0dO2zuh2u5CRoFpTH5Oiyir7xY2dCkRVRMti7yccLOZAFg+UHByD2CuL
	52LZJqk1MynnBRXJAFWLZ/+d6p1SDgTFwog15OKj1HBxUcgr9Pdacq7M=
X-Google-Smtp-Source: AGHT+IHkeMWqDAvDeGYJgg5YMOaQK7jdsKqdGcqreZ4lgwJEgGVi024TdtI8UpS+TYuDnfDMd5R10l/KDFcFhGhDgP0x6rTs28HB
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8907:b0:4c0:838e:9fd1 with SMTP id
 8926c6da1cb9f-4d017ed76a4mr83432173.5.1725019443909; Fri, 30 Aug 2024
 05:04:03 -0700 (PDT)
Date: Fri, 30 Aug 2024 05:04:03 -0700
In-Reply-To: <20240830113130.165574-1-sunjunchao2870@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002f63ae0620e563e2@google.com>
Subject: Re: [syzbot] [iomap?] [xfs?] WARNING in iomap_write_begin
From: syzbot <syzbot+296b1c84b9cbf306e5a0@syzkaller.appspotmail.com>
To: brauner@kernel.org, chandan.babu@oracle.com, djwong@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, sunjunchao2870@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+296b1c84b9cbf306e5a0@syzkaller.appspotmail.com
Tested-by: syzbot+296b1c84b9cbf306e5a0@syzkaller.appspotmail.com

Tested on:

commit:         ee9a43b7 Merge tag 'net-6.11-rc3' of git://git.kernel...
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=14a8e347980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9358cc4a2e37fd30
dashboard link: https://syzkaller.appspot.com/bug?extid=296b1c84b9cbf306e5a0
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13101f8d980000

Note: testing is done by a robot and is best-effort only.

