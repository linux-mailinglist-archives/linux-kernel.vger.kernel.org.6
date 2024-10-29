Return-Path: <linux-kernel+bounces-386606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6AE9B45BD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 10:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DABF2B2173B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 09:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF2720262B;
	Tue, 29 Oct 2024 09:28:07 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FE71DED7D
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 09:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730194086; cv=none; b=RFZU0UpfnOrJeWnX1h7XOPGxwGRvXcbKC9kQDPX4HAoscJG5sL2qZWdseag+m44ivgLh6nmbMQz9aP6ksDZhnLmCwPiWobCpTuWaeh+7/xQ5sMnaG8p6EZ5X6bAd1sxc2BUZBNqY8qHLwX/zZRsXXV6zTffPEeoqBh8z+4Rlwpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730194086; c=relaxed/simple;
	bh=F1Jm6Rb5Y120pS5QEJb8H1HXzC7Pzy6vWf58Yv105sE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Pm1BgQT48SzhGfBah46kUMLtO5gWpxjMuMSk6+yHD9M7opEW8+ceEYaHmD4+fFcomahL9LDHw603iQmrxepoLP14KOih+l0Tr5JkRu2MXEAMQVEQI73uBuQ5UUrhDBsf1QaHYA5dVqZaIMNw2BEUa0wIn1j/u8m/W/TaVfuu8f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a4f2698c76so23265515ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 02:28:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730194084; x=1730798884;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oNuT3oGDTf/McUeJVj06UU4pcEX8BAXgi4YYe2ZPzj8=;
        b=d1WqZ6VhDBGnZQ6eobv1U67jfxL9chehBWeRihiHqse4A+pwAXXVcIck6WG0lVAqHg
         Zrec0zXjc7Eg9q/p4VnTnWEFmlccsKjsXHroGbVHTyZFkwaTDh8vGPd34IAEyabWSsBZ
         PrsDENLfuQ/BIfj3yrd8NbpBM5N9sIs6YNdV0u7gguLrxZ6D57W02/Af+X9YUYFWudVE
         QC2tgoRY4e9fzeppGXF8K33+QhFLqPkDytbStoHgS9iQ02lUpWqfW3IQ0q0KClLksjSr
         p4bm5uB9j6US9pdIXEYymyqu6dgVg+ePYlICUMcIT+51eMXblLOVIkZt8dowGztXsQoB
         Gugw==
X-Forwarded-Encrypted: i=1; AJvYcCX7RjnIEEPNmvuMjSufaWFE89Ta3zoNzqlaqbyOPPNU3KDgwLZa6Zp0G0Ne/P2sNqBA1OVk0nf0vKY8Ai0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyenPNPkMaueH/osQmdtGbuyLG1GFJd7hFOcE8wvlkiO5Zordef
	mbwalfJF9DpNv/+h31bORGazwK91cpoIPi0YjGwSlfvTPndOPBInW6FIYb3wiztlL44tNKJghGz
	4PloR+wHUONmMJkrgA9FFFq5MTAegUjI7aMpiwMnTeGPZPnP1tQNLxZU=
X-Google-Smtp-Source: AGHT+IFqGlT6pG/aKhmo89qj+OXwcUNrQQmCY8suynnxw4ILuhJDcGJmFIGbJke6s9Q8RwWqh2Usx0akOWIxzD+nUSFgGS/y0KWX
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:188a:b0:3a1:a20f:c09c with SMTP id
 e9e14a558f8ab-3a4ed34b940mr122690435ab.22.1730194084074; Tue, 29 Oct 2024
 02:28:04 -0700 (PDT)
Date: Tue, 29 Oct 2024 02:28:04 -0700
In-Reply-To: <CAKYAXd-v5nQVkE58bvuk0V-kGTN+Q7vbsf678A7v3zb-Z2d8Kg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6720aaa4.050a0220.11b624.04be.GAE@google.com>
Subject: Re: [syzbot] [exfat?] KMSAN: uninit-value in __exfat_get_dentry_set
From: syzbot <syzbot+01218003be74b5e1213a@syzkaller.appspotmail.com>
To: linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com, yuezhang.mo@sony.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+01218003be74b5e1213a@syzkaller.appspotmail.com
Tested-by: syzbot+01218003be74b5e1213a@syzkaller.appspotmail.com

Tested on:

commit:         e42b1a9a Merge tag 'spi-fix-v6.12-rc5' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=142ec687980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8c11ea7cf15419ce
dashboard link: https://syzkaller.appspot.com/bug?extid=01218003be74b5e1213a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16bbef57980000

Note: testing is done by a robot and is best-effort only.

