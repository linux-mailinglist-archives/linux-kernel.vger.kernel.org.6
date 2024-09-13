Return-Path: <linux-kernel+bounces-327728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B99DB977A6B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 10:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2969AB209CE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 08:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A799A1BD511;
	Fri, 13 Sep 2024 08:00:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F9E1BD50F
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 08:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726214405; cv=none; b=qxfJn8ORiAxYxHhm9r2FX429ET5qo5XAHWHlpdipRM+Az61icN5PHEXL4z9kZMvzA4ceXeniGDsQ7NMeG8QUDUxjaJJq2u2320BtN9ONmYJ+OWJa5M8LOvZQLkUElp6ZqQo41+e8nC+ZH6pP4WH/hXMcQd4CWmTkMaN/bFINmUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726214405; c=relaxed/simple;
	bh=ib6OBfeC9NUYLRObmXHSXot7y+xLOzCW8Ew3BXmzOts=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=bOmm60aw1QclUCD5EH0jwRsdZV8S8/evwg+vK10mPKhwB6PuAYUi/+Q/h3J1HPZn8cN/9ABqF4TJIj+lnWbxYpWGKXFqQACRm9huS84gEVmzuf2FsUQ+129seBBr8WnK1lXdFBREIk+9aS0xJEfZrZ2xIxohf7eCzvhHBbDvn4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-82aa4678394so307857039f.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 01:00:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726214403; x=1726819203;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MP1EyJuSvI4HN8R/vMcfkiV6pui1erPgRYsozX3bYyg=;
        b=I1B9P23gxT0N95SbqzZL/ULNoaRC2Yg+AapiMg9TuP4cSoSpj+FSpOjpZjvwJpB8s4
         XKuhHcfgnAV1sEL8FN/lFgKcPtDYWiC1ujHSWwaDjOJnqmD8d1khvkVGOUnXRO2nipbZ
         idiOYWgEJQ0EaBjfD4EBjUTUk+vqviuPXhmZVuUZHl78RoEt+fQvyos2dkHDyPp0SgmW
         10Dsx7mtjHEdVY1X3nrFm+nG2MasnaeRscyFoTDavLz8zjfx5HXOiQMcdbtstTkaaoMo
         /gupqH8ZoZScDbDsn13gvuNBGq+stJE/9bvLZVh29XrSKUqlIqihgBwANTp4HVge9+Mm
         4Rxg==
X-Gm-Message-State: AOJu0Yw/yUyvxa39tmhOGlzb759oooydXKkxdyE/85TBQ1lyFX02sKum
	EOa2XMYGXR21Cz0BrfCTJV7V/VhkbKSl9Eb2+WpF6ipISVbsoXCGeaZJ7yA2QSSIj+nmkVZoB+X
	GQoFz/OEZeQVTHi3lwnjvP2ewMZ3tUjl+DpfbCXVHW2gEoRlzw1TrHSU=
X-Google-Smtp-Source: AGHT+IG5ksQCAKjHa/eFcCisvnv3pNqB4BXvdkzrrr0ja+1fkr8SHY+lnKtizaradKRnxZUmE2csr6RWtpXWTdGZMl2vet7bq3Ja
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6087:b0:82b:c70f:5061 with SMTP id
 ca18e2360f4ac-82d1f8de413mr624280639f.7.1726214403147; Fri, 13 Sep 2024
 01:00:03 -0700 (PDT)
Date: Fri, 13 Sep 2024 01:00:03 -0700
In-Reply-To: <20240913072742.1318906-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004e6ae20621fb9cf6@google.com>
Subject: Re: [syzbot] [net?] WARNING: refcount bug in ethnl_phy_done
From: syzbot <syzbot+e9ed4e4368d450c8f9db@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+e9ed4e4368d450c8f9db@syzkaller.appspotmail.com
Tested-by: syzbot+e9ed4e4368d450c8f9db@syzkaller.appspotmail.com

Tested on:

commit:         52fa3b65 memory-provider: fix compilation issue withou..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13dbe0a9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3e10d80c64e440c0
dashboard link: https://syzkaller.appspot.com/bug?extid=e9ed4e4368d450c8f9db
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=156ce797980000

Note: testing is done by a robot and is best-effort only.

