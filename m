Return-Path: <linux-kernel+bounces-402502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57ECC9C286A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 00:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 104D61F2312A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 23:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E5520DD77;
	Fri,  8 Nov 2024 23:48:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EB720DD5E
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 23:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731109685; cv=none; b=k7TmEvQuqqbaBFfRX/OuB6tvoBJW5+XWSVq+GzacN44A1Tptvll1dtH4MGYA7koB5dpWRa7+NceQKwWEizMvt0hV32cw77gRfq5WOHRQvgk3oQbuk/AgrbCnGF3wJSJM1q2uvdSTPGKa/jPKz9MW9jbseU+sclYOyeDSlAtS1+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731109685; c=relaxed/simple;
	bh=rvAc4AuEnWLazR3uwlZdmkVDKP3FZtuRXNgxNzf893g=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=sWu8PDpCDDeWuZoHpB13WJs9n7k0cO4h4TjSmVjIqVUQfBC3g4bMcTO7AhLPP3GBEjTmZ2lwFyw9S7tQYFpsIxeORTRaDtV3QP9NT8oQ22qqFuquBtxo9yZ+K4SMRLIwGoyUCxQx7Yk31BSJdvkWZwt3l/O+AapSDmQmk7uNitE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a4e41e2732so32832595ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 15:48:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731109683; x=1731714483;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5NdKLJEI+3so+sgxgTyuL2cP1a672i8hFvo9fUvl/z4=;
        b=dG7zfty1eJSjNfmKMPa1XE54oDtBSoJWKRzsSXOtAtoJmtk5n19i1lt0bD8JmoLpIp
         4DfMmRwZNgWYK7/sl314hCT8TOBb3SzDSLFztNLaPwjMALpfykn3qSdzePTva+jHItMS
         TU3ztx/ct+X7AXmZCXVxDT5WHdycMNBkEQgV2ppVCVYXh/07Ie+COfNycFOKp29lNzzg
         HARKLpdUBBXBx2UJecluP/T6IsOztHsQOugBLkr9NftOUUTxnp8NsfxQO2MMMV+XUYCX
         XfvxnN7KAymNa+qnLHXZQiJmr+qOk0zSu7CbGpm37dlzTN6uwcDXzgxEiG25eeFlhsol
         6Cqw==
X-Forwarded-Encrypted: i=1; AJvYcCWxnj2s4BAmaMHZmeitUzMOQf3qGdLwR2kdHLkFnXYB9xmRhgw2/7vF8F8L5ahIUFLHyJlfFCQ/Df+ACug=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxVRUZVuJJlkN38gCBS7I4r/OV/civ/RizbfduOtRvkNRIRbDP
	0c1IgeEkkoZktn5aHQRi+SEDk56tWjbTBw3KxmlwEOjmzCdMeTdN6QXDQfqRJmDhst9vc8URzlZ
	rQD1+EKaLGu513y9VWdnAYibVpjKl+frGx0b+uOI6tAj+8ETU4yU18RU=
X-Google-Smtp-Source: AGHT+IEXy29VJIeTJ+tpKP7UEF5UjyxKkM1nHy34Z6s8zb3R73/aCedMbX7lbUIJEcmKa3LE5A+czLTjYoV7AeYPDIG3Fr2Vjvsj
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a28:b0:3a6:b258:fcf with SMTP id
 e9e14a558f8ab-3a6f19a0126mr66449115ab.2.1731109683043; Fri, 08 Nov 2024
 15:48:03 -0800 (PST)
Date: Fri, 08 Nov 2024 15:48:03 -0800
In-Reply-To: <20241108231609.3572-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672ea333.050a0220.138bd5.0035.GAE@google.com>
Subject: Re: [syzbot] [kernfs?] WARNING: locking bug in kernfs_path_from_node
From: syzbot <syzbot+6ea37e2e6ffccf41a7e6@syzkaller.appspotmail.com>
To: bigeasy@linutronix.de, boqun.feng@gmail.com, elver@google.com, 
	gregkh@linuxfoundation.org, hdanton@sina.com, linux-kernel@vger.kernel.org, 
	paulmck@kernel.org, syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+6ea37e2e6ffccf41a7e6@syzkaller.appspotmail.com
Tested-by: syzbot+6ea37e2e6ffccf41a7e6@syzkaller.appspotmail.com

Tested on:

commit:         f9f24ca3 Add linux-next specific files for 20241031
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=125e435f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=328572ed4d152be9
dashboard link: https://syzkaller.appspot.com/bug?extid=6ea37e2e6ffccf41a7e6
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1062bd87980000

Note: testing is done by a robot and is best-effort only.

