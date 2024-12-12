Return-Path: <linux-kernel+bounces-442543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F64E9EDDFF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 04:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73E1C2822A3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 03:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863C91547F0;
	Thu, 12 Dec 2024 03:43:04 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CE113C918
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 03:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733974984; cv=none; b=ZQLQok3pDt3Yv+lrrqjd+GoJBLhoXWTMTkjlt+1ZlKIQztM47P0IQY9f3L/Wv2T1HyMlYSbJmsslqjFEuQI46LKypFYeoO0IrSt25Q8HqLOgu3Q1QCsZNxp2WCqFJw0GNMhdktusacTrN0x7bSiw+CEC5NQdGW5KMKp0ExibWfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733974984; c=relaxed/simple;
	bh=/RDgmxuFpen2iP7O+9582wteRZ8llcZAR9CRzV+1IKE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=e9uS8xHZebGSVI0G05R9PWGNHnoRicOJDUjAfG0S8kCcD4dGGgKiYe3ktBcDle80mmUNG0jc+w3Xtx8IQ/A6U8wrRj2ef8adzjk+UM8kE4jke2PdpIHzut0dtIJsfc5yk0Q7FUXJojLziV6moJ+1fRjb32/ZDOKNyB8PvQRf/Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a9c9b37244so4267885ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 19:43:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733974982; x=1734579782;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BwzyXxhkdNL37dP4NiV8NSpth17QRvVoswvdZ/m6ZBM=;
        b=c5AJczsaCzMvppOFK2N+Un31juFTbkPk98VjEJrRLeCCX+g/RwQKG44CvE0iDOKGDv
         LHeZ/t9ywJ64GAHdyo29kKzCMTYBfWorLwidpnA6vGSoF4733vMk8JLFpR+CMo2dW8c6
         RcQgvP+ruodLi/2fnV64a8DzwEl5cLAClz+5V0lKbQKX6TTnnJxkcPYbG2t8k2kCov9g
         S9vfs6/1rS/iRKwADepY9Tgrdz1QjiIYlsyl0erqWZWZ8kfVNmPAJxosH1VE14e6uUCl
         TBrhQrZ8qTcbBlL9UUM8Xz5bTJoujt/0D2eH/BZWreKUugyomStZYlo6bYGiC0Cv1DTy
         tNdA==
X-Forwarded-Encrypted: i=1; AJvYcCVMUQ/ZgGrApVR8m9oFdTfczeyicVaO9VLZ7jgdMqnqnoXqOcimTB0Z6jVsG397TawPzsqCCsdZI5LqYI8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLO2LNlKl/PTPvfzDoWDLEKEUHEy6HgUfC5fSdhR6QWsplW4CQ
	4zuiim3Mk5NEOj4nAYWuT6TyMgusuLit0dCtL7us61pKnOLx3TRh5jEWIZN1/zKDTTzYXnA6Sq5
	+fm8r0HB3/5c4QhXOVss6BvLEcDHYHnD7B/mN6g5fsJOSTkSWv03cMa0=
X-Google-Smtp-Source: AGHT+IG/G7WCfSwKhhF7hEYExpMd8HpS98/n5t1VnMSS706shQe7VJb94c1bS4X/oCIzGyoIJRMGVzNYIjCDesBqnI0G4TQlUzdf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13a7:b0:3a7:dfe4:bd33 with SMTP id
 e9e14a558f8ab-3ac4830790dmr19153195ab.6.1733974982030; Wed, 11 Dec 2024
 19:43:02 -0800 (PST)
Date: Wed, 11 Dec 2024 19:43:02 -0800
In-Reply-To: <PUZPR04MB6316AD522079C7FEB8E44540813F2@PUZPR04MB6316.apcprd04.prod.outlook.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675a5bc6.050a0220.1ac542.0015.GAE@google.com>
Subject: Re: [syzbot] [exfat?] INFO: task hung in exfat_sync_fs
From: syzbot <syzbot+205c2644abdff9d3f9fc@syzkaller.appspotmail.com>
To: linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com, yuezhang.mo@sony.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+205c2644abdff9d3f9fc@syzkaller.appspotmail.com
Tested-by: syzbot+205c2644abdff9d3f9fc@syzkaller.appspotmail.com

Tested on:

commit:         231825b2 Revert "unicode: Don't special case ignorable..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13f97b30580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c7c9f223bfe8924e
dashboard link: https://syzkaller.appspot.com/bug?extid=205c2644abdff9d3f9fc
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16e77544580000

Note: testing is done by a robot and is best-effort only.

