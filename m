Return-Path: <linux-kernel+bounces-303693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6E19613D0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 18:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76F361F2407D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 16:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68881CC14E;
	Tue, 27 Aug 2024 16:17:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F051C8700
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 16:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724775425; cv=none; b=C9y9NwpLtAZlnG3fM21BChuy+kU2njxN7bRBbhdBPY10ia+e2YJWiQahr4AduR5iTsqGfdHZI9s2N1Htz3KOrIcxf1N73Q/mjNUNuRr/HoBaEsbY5ujDS18tXjRtrK0n4rvyC78PA6HlkyIb/z17ZscoJ5+LOVaJuiQtYbvziiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724775425; c=relaxed/simple;
	bh=5XAqISp1O5JZg1ULLaLmQmHYO6E/l554W9XWwLazz7w=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=fx458OfMCi8F4fdDl+Ycchb4TdO2jfydhLV2maC0Cjzr1wTDzCB9/4ApZbWvhFx3oiTPHE5li9pBoH/8yso8ML3u0KfS5wkGw6jgA/M+Z+9mxfcT0ha8vtQ9Yn3LUjL21CoGSVGjAEq/pl4wGURUlZsUKub021jy7Eomwf/pAOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-81f99a9111fso606819739f.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 09:17:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724775423; x=1725380223;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xwdLy7ifDFmOoT2TcapjsucGnYM4zQXePJyan7677kc=;
        b=SY04ZKs0Tk8mjT0G2+VgnYBpm5lPoYx9OOo1S80M378Ut4x+KAXjYROe1YBsgnbcl0
         k1BsZP2hCNoupgE3mIs5Kc8wry5QHfpAqh754sGlgziGOHjiJWJYa2FWc4KszM4ibf+a
         9oX2jloB2qLIQuX1+UW0kXcvSmPGl11V0LjmiyUZwBv1t9FOl9XKqidKX4RvuK6Q8ivB
         VWSwCsluja4ZM1o4YGVQQga0m1A66111todrxXIENKw5y4/himBlyFPS2TFYiYeJlLtJ
         uXsimCjevREMhr+OaZkpWPZyg2zArXSn7QaOcprfv+V7PDENXGewMgZeR2kbEpHTiVga
         n5cw==
X-Forwarded-Encrypted: i=1; AJvYcCUSAfuYE29t4Zuz6orQGXubM4jjle6Jhnxs5MRTKqkXKOka/pspCwSZPhTaocI1KJbA41kr9mcdPx6kUfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7TsLTxgz5l11vlAKi7hLLxsjOaM37rXpskFLRXIS1GKmDtuPO
	VbIHJYxEuzdu/KypxLVncyME6CxU5xdg9/RhSHpHWxmMU9TMjkwXADWIU7MNINJYqIdrSGFGvYm
	LnZTnpSxo1T1KfgGWpmNm804caIdD1N9PJfTazej0k7rJkiJjrwjdvXE=
X-Google-Smtp-Source: AGHT+IGpwEmPBIxSKDNU4LNMXj+yBrZQT3OiZ3ToEhcwCQyzlfwwdNLqvvVvcM3LRCTQNIhnwWPtHyIODAfKlavgXJMzK0Y9wJWI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1485:b0:4b9:ad20:51ff with SMTP id
 8926c6da1cb9f-4ce8284ec5bmr330404173.1.1724775423189; Tue, 27 Aug 2024
 09:17:03 -0700 (PDT)
Date: Tue, 27 Aug 2024 09:17:03 -0700
In-Reply-To: <000000000000be9914061763f17a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006ab89d0620ac92fc@google.com>
Subject: Re: [syzbot] [ntfs3?] BUG: unable to handle kernel NULL pointer
 dereference in attr_make_nonresident
From: syzbot <syzbot+5b6ed16da1077f45bc8e@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 0f9579d9e0331b6255132ac06bdf2c0a01cceb90
Author: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Date:   Mon Jun 3 06:58:13 2024 +0000

    fs/ntfs3: Add missing .dirty_folio in address_space_operations

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=116e278d980000
start commit:   34afb82a3c67 Merge tag '6.10-rc6-smb3-server-fixes' of git..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=42a432cfd0e579e0
dashboard link: https://syzkaller.appspot.com/bug?extid=5b6ed16da1077f45bc8e
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=110a2c7e980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1312ea4e980000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs/ntfs3: Add missing .dirty_folio in address_space_operations

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

