Return-Path: <linux-kernel+bounces-236236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 678A691DF26
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 14:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1450F1F21E01
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 12:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D412914B946;
	Mon,  1 Jul 2024 12:27:04 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2327514A098
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 12:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719836824; cv=none; b=dlzwbgmyDEUtUyoMs56fFIqZUdlpqcrfJ48HHr2MvhgVbAW1W5eSoAYaP1MVoo3Cfzqo67lfGdC33pKaRUhijkGX8Sujf8fne0qkqVSNjj/1QmJOGAy4NkDrahwZVRoQu0Jbi7WvGXo9LVI5gD6rZVtVC7IlB5SlvHaOOACixWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719836824; c=relaxed/simple;
	bh=6qdpZ2ZaMSNBLlhJwrtc5Vcmfp7+vv0OVMHqTXpWb7c=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=EN/35pZlNExkky9nW5tpg49GZ4lj6DgvdG8Gc6odgOCD6rCFiQL4fCWsBzJy3ySMv01TBTJP1wskEABmRY3r784oe1y8xol8lB97ypYHiR/lBPKkLmpd+z0S/pTyo61PriVVkXZ78L5oPwJlBhV2H/Ze4m1+RcbL1KQxc3WodOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7f63eb9f141so66556739f.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 05:27:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719836822; x=1720441622;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DbeecvukDyVo3VtHX6r0WAchUA0h1Wd3HInWyp6BZ+g=;
        b=u5RLJ6e1LtqYaBrLK6GVfCVxs47Ace5UMR7UN0ILQ0aO3gqEP6WRF5zWc8AZMvqkNW
         mCTItleWiDNyhE8cpfIxQTfLU+3hbahGyBx8tX1qhqyzJfJa2nv2y5z3ewGbO7AI97Z8
         wTKWOKdV0qllDRIHoZHl/1RKMAWgOE/sDp4fij/5+3LMfPe+a8ra6Yb2fz/JO2i9ilj7
         ssJUjAMiXcYpqGyGZ0b6Spa3Jw9EZX1ftakgLi8GYVTrLhpiCbkVw5mGvl3CbeVDAC9o
         iq48ROK+5PkOimsQy8RmNYtxWisRDEmE/Q5B297nCuZt5wzS7rHfdd3hQVarSVCvJz9n
         An5A==
X-Gm-Message-State: AOJu0YzYrrvDA+tDmLdQrMUN8TSghIFq32rDai/PoHsicxyVe/jTvffF
	Sc0R8HmF2tZ7DH4Mm2g06sL+rpHwZPZ5M/p7UTGz8ffMNA88kHnY50wzrTB75ZW9G8qcA/Hdbt3
	OzWrdaa+NfqreYRlsyKS614LkOPCYhbyRJIgUtOMQTFsYtUaY2UF4vPc=
X-Google-Smtp-Source: AGHT+IG/mr/OnbDSwOXZa2ArGb59Z6ZlPDlP2jnvk9DPb9ctSlK5vJy+y683Qw+5sOM2lDBk5bHFpGL+f0imr3ES4QJUteRpsKPa
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:d5c8:0:b0:375:cfd0:393d with SMTP id
 e9e14a558f8ab-37cbcc6d420mr2236345ab.2.1719836822341; Mon, 01 Jul 2024
 05:27:02 -0700 (PDT)
Date: Mon, 01 Jul 2024 05:27:02 -0700
In-Reply-To: <20240701101125.13829-1-wojciech.gladysz@infogain.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000de1f00061c2eb6ec@google.com>
Subject: Re: [syzbot] [bpf?] [net?] KMSAN: uninit-value in dev_map_hash_lookup_elem
From: syzbot <syzbot+80cf9d55d6fd2d6a9838@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	wojciech.gladysz@infogain.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
SYZFAIL: NL802154_CMD_SET_SHORT_ADDR failed

2024/07/01 12:26:06 ignoring optional flag "sandboxArg"="0"
2024/07/01 12:26:07 parsed 1 programs
2024/07/01 12:26:07 [FATAL] failed to run ["./syz-executor" "setup" "fault" "binfmt_misc" "usb" "802154" "swap"]: exit status 67
mkdir(/syzcgroup) failed: 17
mount(binfmt_misc) failed: 16
SYZFAIL: NL802154_CMD_SET_SHORT_ADDR failed
 (errno 16: Device or resource busy)


Tested on:

commit:         e478cf26 Merge branch 'bpf-fix-a-couple-of-test-failur..
git tree:       https://linux.googlesource.com/linux/kernel/git/torvalds/linux
console output: https://syzkaller.appspot.com/x/log.txt?x=15f181c1980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2ad6a8768920dd4b
dashboard link: https://syzkaller.appspot.com/bug?extid=80cf9d55d6fd2d6a9838
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=129891d1980000


