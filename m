Return-Path: <linux-kernel+bounces-282494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 904B694E4B5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 04:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C285B1C2120F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 02:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F34B5588F;
	Mon, 12 Aug 2024 02:18:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2ACF4690
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 02:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723429086; cv=none; b=gxoqZLMR9XwY81lOMtVmsZdDuNqbfZaKxFEhzMDnG1TFRhWyjmNlV1vfT384aOU0HWLS/5JNargVhADapyaqTIn5Cobw8SlfADRyK2ju+PSRwO+q2zudF907ItU5vKmW135vJ/7n+rJkH3SW4clPc5HmSOOTAnPdWJ7cIknndE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723429086; c=relaxed/simple;
	bh=0EL2SNliC4Spr+XKLhQMrizqm/AzyLGZmB8N3FGGR+M=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Fn6YfiJAjjPifNZJvp1ER0higPD5wmPuYZtSii1lRiD854glBzWUogFyhqMWTGyDH1BQ7EODE01bBH30czvbNqw6/VevxZhl1tOIiTtxYM5+1uI6ZxnR5aqgh42BMROq6u/BQQTEqLo5L6IrHarJkKqSrFAnGeAckOZz+9FPIfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-81f968e53b0so516669139f.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 19:18:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723429084; x=1724033884;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5jiETw0mkNUcTBDzFSo5bjSa2/hjikJGfnybbfCAzEQ=;
        b=VjDldzeQUMAuiPMQn8rSZoOnvnEkXdzMzzXzTXXM+OY2GJeCPR1+oNFGWxxIJ2DiRV
         /JoaxaKqZ9xVpMFt4Hs2Xk3yQzCxeM28Kz6NS5CMYu3CgJbbQ/hO15UhV/Pac2+cwTwQ
         3VjZU4dpyMoMUIV83e8/3m4+9oau47VBxgBGHOo0pqA66hiS9176fZiW8vHvur4cOaPt
         M4QMFOEFhn9qqv7fU0i3iUVtz8BpeiVECnyzeaY6eKoGJQIv22cdnO3tw8D4sqNp4IXh
         H+5XOZfbiSzrDwEUnindVMqPsGTI3u99VF+8F2NW7t+w2OCTN5YjQanNfD8PKjVFXlAx
         VFtA==
X-Gm-Message-State: AOJu0YwlsLDvUkjcReaFZr37p71gUbX1TxIz9CgbCZ/iES45wnZgE/Ov
	tNwvYBWizqdMVtyNmlMp5zGadw3QANE+HcX6pIk9JgiOVmYLGFDu0BnPWP7IUIxNuXVEMsZB3O2
	E1Y9kJfYFPR87qdE9Vnfu0OVz4gSrIeFKDddvTaJ5ohoE51MiIj+2OPs=
X-Google-Smtp-Source: AGHT+IHXwPtlIbjpVL3HjY22uOkP+sc9K78b7I0cdLFY5q7o6DKKPqn+t8onI+dmEAE9vktoUFFylTSjbs266HywJrb8ktMtNyyX
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8325:b0:4c2:2ad5:bfd0 with SMTP id
 8926c6da1cb9f-4ca6eba43abmr420313173.0.1723429084007; Sun, 11 Aug 2024
 19:18:04 -0700 (PDT)
Date: Sun, 11 Aug 2024 19:18:03 -0700
In-Reply-To: <CAM_iQpUTMQvq9Z7tM1upFGpKMWoc8FcftwREsy1SyTfHNv2cTw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000592189061f731a66@google.com>
Subject: Re: [syzbot] [net?] [virt?] BUG: stack guard page was hit in vsock_bpf_recvmsg
From: syzbot <syzbot+bdb4bd87b5e22058e2a4@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+bdb4bd87b5e22058e2a4@syzkaller.appspotmail.com
Tested-by: syzbot+bdb4bd87b5e22058e2a4@syzkaller.appspotmail.com

Tested on:

commit:         c4e82c02 net: dsa: microchip: ksz9477: split half-dupl..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=108d3f23980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e8a2eef9745ade09
dashboard link: https://syzkaller.appspot.com/bug?extid=bdb4bd87b5e22058e2a4
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1792e95d980000

Note: testing is done by a robot and is best-effort only.

