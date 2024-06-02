Return-Path: <linux-kernel+bounces-198111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 076D08D737F
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 05:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5FD22840D3
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 03:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83867BA45;
	Sun,  2 Jun 2024 03:45:04 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2078AD2D
	for <linux-kernel@vger.kernel.org>; Sun,  2 Jun 2024 03:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717299904; cv=none; b=IlvdnDKU+Uc06cHTKw4O17v1kmpsNVNkJd2pmJSbzf6X2Xo5QC+8bkw6i0zJpzVFnDM3tEerL9SwWhPKb0gJeiGN/RDMwnkqHZCyCLMHyCuPmGbqG3zAnxief5JHIz+cXMeBmvl5Vm2x9iZPq8lUfJDZ1qe+EuJLRDnbBgNI9xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717299904; c=relaxed/simple;
	bh=ixE64e2o8LqJg9ayNc+hDGAhUSw6nTymxsa/L7gXnjA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Z/Iu8Ai+x9GdT4gLRtht/3lNWdWQTaMcWceMuNG9mBJ6u0emAbpglm+a9ppSbZcvbXYaGkGf28eTKQYdZCO/LPw+0N9rVRwQOUdEbQcIFyiB+oiNZ81ZUOLBbt19N/CwRcvo9TV0VxAwTRbyG9VJVjKF8gHUCnhYPAC1JkWaPVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7e91ad684e4so443229939f.2
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jun 2024 20:45:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717299902; x=1717904702;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dikKlJlcuFJVMo6HfazQox4JUVRaZX1p3gyBAj+lt1Y=;
        b=XV/QI/BTIKkrGThKcrw/uw3y4PB3V4/1PU45qBk+7zgCA8JAw8AruPWBVAApnpfFLQ
         t7y3sCdKW4jbO20HRDFiGkEScuAjcm1wZSkiJrApN75nh2e/NSG/5vJm1Sx7Ntr8En4b
         OKKUODUCwxpjH4FdkN97iEs7aDPn24Y0v/UmicOBf6F3ty+wZuXV0URKtBQbm7CEKz/s
         LrjEBhkv6jogv/yoGMiv+cLJpvkekNP/xu9BQam6LAjoqK4/EXtBlXC9WIJgQmcEnGyM
         ZRYRr9glHLTfldxdLz15d9jISYLaqB10t6EnNYBvQBHvIO6zAOPrFLdDe8TDczcRLz/Z
         KvhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVF4LpVH8PvImsCYJazjCcc82hHplnrh5McLCMUACHAaElmji6elAOU1XPJJg2wnIxym3Aho19pmrJFBbWvSa0P2CJllnSqgQUYfFtO
X-Gm-Message-State: AOJu0YzFAAulfxvOAb3/5KFk8OL8YKFJSPBSkeyfzPMjee8oxSEOZO33
	fgj+6EVu0S/EXQto5JGzeIwoTGFLR7Nxf4SHo7xSGHPW/BZMYIf8vsyby90GvvKT4wkJj6A1VU/
	qYRvzGwQUDcXZbxCWTf+RTOLBcXZufzbc2IDfGLWHKaoJ7Rf9riuDIZc=
X-Google-Smtp-Source: AGHT+IGzeLZh5gioCfnbbIj+b5u0zhRCUWMJGltC7FpZALxG2bCmRU3XL3GaVnl0dysVo2Wem4MbFY7va1MAzxrncMN6cUmUYWVG
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6d03:b0:7e2:2c72:c616 with SMTP id
 ca18e2360f4ac-7eafff4abb0mr37857539f.3.1717299901964; Sat, 01 Jun 2024
 20:45:01 -0700 (PDT)
Date: Sat, 01 Jun 2024 20:45:01 -0700
In-Reply-To: <20240602032010.3726-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a132620619e00abf@google.com>
Subject: Re: [syzbot] [media?] [usb?] WARNING in usb_free_urb
From: syzbot <syzbot+b466336413a1fba398a5@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+b466336413a1fba398a5@syzkaller.appspotmail.com

Tested on:

commit:         83814698 Merge tag 'powerpc-6.10-2' of git://git.kerne..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=12b77be6980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=238430243a58f702
dashboard link: https://syzkaller.appspot.com/bug?extid=b466336413a1fba398a5
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1209fabc980000

Note: testing is done by a robot and is best-effort only.

