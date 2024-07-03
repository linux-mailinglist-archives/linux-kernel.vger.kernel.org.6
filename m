Return-Path: <linux-kernel+bounces-239937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 988FF926702
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 19:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F2C61F23690
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 17:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43C2185084;
	Wed,  3 Jul 2024 17:23:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F01B17B50C
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 17:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720027385; cv=none; b=uN2V8NIQlFGjBTuk4bBJLeHwfQzUrBxdaxIKlbVI3MddbIc6+4XLtRJsizGITma90clGioHM8QvfAuHrusecRVsdhvMAGTbYKXCK7susR9t3ukBdOZjvG6V9B4OxDlu8n4AQ//u93iFNkJgDXNVUrxRDJbiRzz/9gdfnVc1SfdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720027385; c=relaxed/simple;
	bh=iDWqXvabKOgAqW3p3Iu5skUj2Zz2es1nqz12xkhpFQk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=BFFOIWHog6Z1R7D816JJSPlXTlNUdKwTymbIc1MUEeJfl0ttrB/M0JUiNs+jNZKScR9dzKwkQUolsltDRE0Au9mAyipiipl1N6RJLV0hrA+CcRXeg3uBiGJhOyHE9482JhDJG4K6jHLQtae7XN1nOkHOf9LG99OhlEf8xvHA8xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-37613924eefso64235955ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 10:23:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720027383; x=1720632183;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l11yEPDvI5YCrjj0DcoJuCs1C0g24MwZOXs8ZbcH3Vw=;
        b=ktopo4IUtRQnFwD6oHHutefjFqFUXXHW7MTiQnpy8zaf+9W06xy6ekPTqqRgxpALHX
         XKteNK2Htwez31eN6laFuUD1+O9LdptaHrvqcSRoXyPJqP5SOCwJXj5zEy8LAbBAQD7o
         O/M6LE6YVBb7HfA8rCRXdR7dllXQd9kPmpAc42sjJQFjs4QNfQU1mxZe2MpDdPNV+JjJ
         Ur/ZcPSmFVXzX2TwyQfj1UumGbx8ByBnDi8HDWwQqdpTzUTseHmgoZb9TSdaPczFejj2
         G+NL2RzRlzsmwaalxd7GkwLd0/kKjkhy2xq3Y0EGNe+1rGQZHRiXAic+Fj/PXT5kbxfU
         M7IQ==
X-Gm-Message-State: AOJu0Yy3+NYmoNiIUP2nQ0b/B8v8m6h+I4C0Ur++V9FVrr6xWiv7DHxy
	6olsVlaq/Q8kzEEYURNpc1Ue7xfJ6qxc8JmUwluziMFOTDzXnTi/qj9LdKFIX/BM7MGlWoWc/pI
	zC1U/w21aNgyxZ8lCJuqPsfq4PbxN4d60VH33TFjrgsO839MrG3QNyAU=
X-Google-Smtp-Source: AGHT+IGutl/H9tCG8cVtkfDGWkkjm4xSkPq4+cOkWdmH355BT6OaM3Wi7YwSczwmC9gXLNyJlbz7EAnROzEEPgaGhTZcvnpOpGvj
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cb88:0:b0:375:ae47:ba62 with SMTP id
 e9e14a558f8ab-37cd0448fa7mr2316875ab.1.1720027383240; Wed, 03 Jul 2024
 10:23:03 -0700 (PDT)
Date: Wed, 03 Jul 2024 10:23:03 -0700
In-Reply-To: <ZoV+N1lcTs1ztvay@katalix.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002eadd0061c5b15c6@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Write in l2tp_session_delete
From: syzbot <syzbot+c041b4ce3a6dfd1e63e2@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tparkin@katalix.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+c041b4ce3a6dfd1e63e2@syzkaller.appspotmail.com

Tested on:

commit:         185d7211 net: xilinx: axienet: Enable multicast by def..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=10eb109e980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e78fc116033e0ab7
dashboard link: https://syzkaller.appspot.com/bug?extid=c041b4ce3a6dfd1e63e2
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=101379c1980000

Note: testing is done by a robot and is best-effort only.

