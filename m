Return-Path: <linux-kernel+bounces-326580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3FD6976A60
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 15:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ACE91F2266D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 13:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E67D1A76C9;
	Thu, 12 Sep 2024 13:19:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A721A2634
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 13:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726147146; cv=none; b=vBbyWgOQbzW1laLbIwopy0PncRZDBTzyRx4w1sygRYOJIzkN1qYZyY8LrXrWFQ7RAxpkKCXySpZo1UZMefBJbBycCuJJ6yLf55N85+4qWcF+dkEUdIUVgL2iN3sssgNhpmJzM5nAXrqEbf/OmGsf8MtFEzdM2cZGeVD9A3Ud/nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726147146; c=relaxed/simple;
	bh=kQDvisJNzEYQ2yVM034DceHzZrqKfn6sskjdlTG9qbI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qwphtuio/xyflHu22j6ol9AUhJykdjRTNgPaT6p5fujHg0pUbM/UOEW9Wg+RSLNPkwsmb4aQpnlzaHormIuJQ9d0Sfu5CLi34n6BJ+Cf2aMO96qGl9GVGMZTWkCb0C/QD2jfn+YwAEWo6hqCaypFrxghjc8lPhrGXy+4hG0ywac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a04c88a379so16630915ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 06:19:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726147143; x=1726751943;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jAaKaFA2Ly6GC9Ux9vxF2p4puDjZArsno9EoTrRusZ0=;
        b=fkGA4B4UIkmZyNFlNuAmjfwfMlcAKZckzpIhTKhtF/LDYbLm4GYjUhUyHSXAG5/g5G
         4EG5zsdJODJ7GjHehKlA/E9itqEtUwgunuuL86Fu5TMzHhFUO4v+fmjiUf5/FRCHHgFv
         1aF3taTxnxmKZ3lflEiiLhP1DG8fKXphlRi6EB10ww/PrBjtluvGR75bbtwDjsb7V/aG
         ElKMq1w5AI1ijAJAbLRArRMfKeTt/bpYjMYNpIZB63pGkhf4R0aL31wL1+4DUJSk4EKk
         p7q4k7JBuLMOCMFPTW7JypldyCVq6jYCanJf4NaD5uM78Kbh7dDQoDjMqG/b376+PzUH
         Yb7A==
X-Forwarded-Encrypted: i=1; AJvYcCVzNE3GJDrlUXa/TLtbhwx6srcdeP1ys3eEUE5Iuoq50B6eutkkenKd6DGW6c6vCmhxCMVXOY7ybj5I4Bs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzorzEh03M2nZZRqNIMRsqjgIkRRFwEXjiMF/HaoZiJdgYgRxvZ
	+xPYXzyKNwnQvCnkUkaGYwDScz15MYr5LGr1p4gy9HHhztww5nXduNP/FNhsftwuSfDqhzuX0UX
	6XbEAS/CTdBeda3/LWJzlkx/yb/oqo40eCl1xzQH4WyiaMIBiIZIAsxc=
X-Google-Smtp-Source: AGHT+IFf1wWj9WjNS8DSpPiTIrjcJjFB2KsuX1AU+ksJW6YTe6rO0jQpM9Yz0CpdugWO4CRDMpYKy9d2UA51xseU7xGgpumLSw/U
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca46:0:b0:3a0:45d2:3e81 with SMTP id
 e9e14a558f8ab-3a0848afa89mr29945885ab.4.1726147143589; Thu, 12 Sep 2024
 06:19:03 -0700 (PDT)
Date: Thu, 12 Sep 2024 06:19:03 -0700
In-Reply-To: <20240902130045.6945-1-almaz.alexandrovich@paragon-software.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000052f9050621ebf343@google.com>
Subject: Re: [syzbot] [ntfs3?] general protection fault in run_is_mapped_full
From: syzbot <syzbot+9af29acd8f27fbce94bc@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+9af29acd8f27fbce94bc@syzkaller.appspotmail.com
Tested-by: syzbot+9af29acd8f27fbce94bc@syzkaller.appspotmail.com

Tested on:

commit:         689ecd06 fs/ntfs3: Rename ntfs3_setattr into ntfs_seta..
git tree:       https://github.com/Paragon-Software-Group/linux-ntfs3.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=10edb100580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c5ee621e7c3df264
dashboard link: https://syzkaller.appspot.com/bug?extid=9af29acd8f27fbce94bc
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=175409eb980000

Note: testing is done by a robot and is best-effort only.

