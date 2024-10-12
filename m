Return-Path: <linux-kernel+bounces-362659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12CA899B7C5
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 01:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD34D1F22510
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 23:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB1E1547CD;
	Sat, 12 Oct 2024 23:57:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653292F870
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 23:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728777424; cv=none; b=owHFKjLvC3CstrVr9hCIbmFHkK5QRMazizKbQFAIn0wMXXTbK8rG9GXVGrUS006uXwASSjtG6vDLxbk7xTedIHwaWntILfacnAGN6unGc+o/2TGDMiaxkjjgK1HuXz5RSlMg8tIm5xKEOP8YaBapT0MPRp0BzTaPvklss6L8Ogc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728777424; c=relaxed/simple;
	bh=LPAIARRScQLd9wTab2MD72Be6/xZS6aC2u84e6LQGGk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=nB4uo+lgnYTnsPqQp6ho+WImbuxGNrwBFMyGMrdwQQTblIHzyoCi+PKnZSLXcRGO4zjtvJ1wC7ZxmfncS5MQEN3B6jUetEhli4cDVUQpBH95ST/J0FtyWqgcZS27bA1Dg0qFUuIxyw9XkjanWRrKcw7HWcaenOUlCQZNyBcwPlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-8354ae12ac2so240468039f.2
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 16:57:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728777422; x=1729382222;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Abhncd2f0tTKXI5Kj++kj2nRdRbtxqrZhhpNtXyuiNg=;
        b=IcZIpJc9MGu3By7VzAtXW16bM2eTO5UO/RX6wGVH+2attFUfMbLUX37e+oANU6ssp1
         trWC89Q7wI9+hb2uOtqjnHKKgZrWFu0HTHkNUJ+7pTBxfMqhmfjDOwtWcp9v/bLnj4kX
         OC+Dlin+I+h/exmac/ktte24c3xzd3QUy0wXNEPL2DvJ/QHW6QE1+BjktP67IFTNAeMS
         JdW5oqyF3Iv9Px1alyrGgLpzitP6I66KhBVm2DuKVuf9UrGzsOrSnL4WcAPwVQUJJymA
         n6gK+nvnDqdS9OAkidAzaZ8zBlBcqISHGh8MdnJlcpVXyg+Mfw+L/cmfoAHKK514b9Rd
         auTw==
X-Forwarded-Encrypted: i=1; AJvYcCXRZGF1A6moZSTqKOZoFuBqdHqcFum6oCiVHQ8NJIjH6Pbb0Fy3ECgPecE0tqM2Y8ot8RH8FjVfUM7Eup0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR7ZjBpZlkF+venbGi62cjzreQj4GexwhGwF88/DeO7jUeElrE
	0s3Vv4IWfnOeEBSCTI3RYYwmDClyKox/5C+aTuR615X5v94/6tY6+VlBIRq0c9bYG1yEi4CM/yq
	gk96RCFMk6WSnW2h3EiLzRVJlfR89Bi9IwrAprJVq4Dr/1Y073f3BNRo=
X-Google-Smtp-Source: AGHT+IHK6gqNbdj5bb33QFPfWY0KhqyH/h6Tf3FhKcEcVbtTvZTHsBCb6RQAuHUYTcT711P4FOWTPp7YsXH0hueWIjUEwReu9UL1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1885:b0:39d:637f:97bc with SMTP id
 e9e14a558f8ab-3a3bccda708mr30247415ab.0.1728777422319; Sat, 12 Oct 2024
 16:57:02 -0700 (PDT)
Date: Sat, 12 Oct 2024 16:57:02 -0700
In-Reply-To: <7a6ebbbc-6d5a-4bb4-a00c-f05de54ee091@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670b0cce.050a0220.3e960.002f.GAE@google.com>
Subject: Re: [syzbot] [fs?] BUG: unable to handle kernel NULL pointer
 dereference in read_cache_folio
From: syzbot <syzbot+4089e577072948ac5531@syzkaller.appspotmail.com>
To: gianf.trad@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+4089e577072948ac5531@syzkaller.appspotmail.com
Tested-by: syzbot+4089e577072948ac5531@syzkaller.appspotmail.com

Tested on:

commit:         7234e2ea Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13c70440580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cdc4dc68c55ee863
dashboard link: https://syzkaller.appspot.com/bug?extid=4089e577072948ac5531
compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13ff3fd0580000

Note: testing is done by a robot and is best-effort only.

