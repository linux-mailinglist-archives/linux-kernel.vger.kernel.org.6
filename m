Return-Path: <linux-kernel+bounces-399381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A4939BFE3E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 07:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01AC51F23D4E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 06:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53353190679;
	Thu,  7 Nov 2024 06:12:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7392F194089
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 06:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730959926; cv=none; b=iHrvPkjHd5jLuRsT502aTtuyw5GmIA/NuKbO7d2CG0fRga/nqaMaSawUA58atcYAOwAqnC/sbPeB+LDJg0XZGl28d6GNr6hJrqCU28UvDKpKCXsQHetKHXehVD2AJ/W6h/NQeZknxfhQ4nwv4IkIjoM2feVknQTk7yjwCBxnKOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730959926; c=relaxed/simple;
	bh=kJ09/lMHxbmOz8JDjhvty8nnO+wHW9DF3cKDxHabsVI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=S/MWaBTkaXUVz90xJtB5RPzK+L92IkV7i35ZrKKqk1OGpJjTP6MjxbRv4LnXmDdeCNDlK5o14zZmoYZ1XB2O5f/MzrvziFYiJEZShKLW9Ld1ilkYYw06hoTlDJPCz7YUeIq2it3VyRM2a5ex1xsYRY4btKIKUAspjOloSNgDp+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-83b567c78c3so152675239f.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 22:12:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730959924; x=1731564724;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I4teBTFNvXh5bzx1qVqv24mt40bKPvUWhk+WVNIHqaA=;
        b=SrSgEU4FRE6RdOk0PAxMsXgQgR1EqPrfgockrq8ADHEtUyedd9HbEu2ZiI+YTY+PRS
         EMdgfqopT5bDXKUsTg6HgEGx6x4VaCzLG4rX18FIUrOFg8I2w+2nhjrrzauu+8T2k5OT
         XBK/RXBWmfiFzeRxV4HJCJ9jXnOSTfCV3lSG0gw0l6mCrF4AqdEgF6N41sbgcpeN/P1S
         X3jrwYkomWzzHtvpgUf64r+L8BlALBUfxRzy9o1mplM7cWM7AL4ypPmiUwv1Bd2UPvY8
         XTyw6EqabEpN6yLEWMgnDRq9HAzVtmJX3WiqV9T3ZwtV/n6btIlAuV+VGcxky6aSab45
         otYw==
X-Forwarded-Encrypted: i=1; AJvYcCUBeVTdDszuCegPVRkC2E6UCfIf5wp/Voiv5oLZmTZOhw7NE03w4WaJmff7dqlcW+Uz81PZeqPT/TVoqFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFpvhQCwi62OzYwEF4JIbUBL6GahZVLSlAtG1hosC9rsQ8pDxY
	uD0pWJ0DK7vetoehBpA/vBOGPxJMq/PeKdqdZmNg4rz8OhnOJbuMXf9K/Q2hHdleEvqCaxl7kLh
	0efFhk+iUcWSW35CgU0AHmezzqRdt8r0dJWyl5KV4BGKHZp5Gdb50SRk=
X-Google-Smtp-Source: AGHT+IF6XBD/7WAeIK8IlHUomzmVP7ZKws83LrRsHqM956IFWY/OFmLNYR+Xp/SSQQ5nLnVSApUkTBLm4n/T6p/u9jW5KQBEh+/d
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:152d:b0:3a6:ad8c:9173 with SMTP id
 e9e14a558f8ab-3a6e895f367mr19074795ab.10.1730959923749; Wed, 06 Nov 2024
 22:12:03 -0800 (PST)
Date: Wed, 06 Nov 2024 22:12:03 -0800
In-Reply-To: <20241107054740.p8xGy%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672c5a33.050a0220.350062.028b.GAE@google.com>
Subject: Re: [syzbot] [jfs?] kernel BUG in clear_inode (2)
From: syzbot <syzbot+ac2116e48989e84a2893@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+ac2116e48989e84a2893@syzkaller.appspotmail.com
Tested-by: syzbot+ac2116e48989e84a2893@syzkaller.appspotmail.com

Tested on:

commit:         ff7afaec Merge tag 'nfs-for-6.12-3' of git://git.linux..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=106f2e30580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2a6113a06ffd9630
dashboard link: https://syzkaller.appspot.com/bug?extid=ac2116e48989e84a2893
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15f0df40580000

Note: testing is done by a robot and is best-effort only.

