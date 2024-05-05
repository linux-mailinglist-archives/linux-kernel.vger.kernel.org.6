Return-Path: <linux-kernel+bounces-168881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C80EB8BBF2C
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 05:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F30C11C20C3F
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 03:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3F363B8;
	Sun,  5 May 2024 03:40:22 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4969A566A
	for <linux-kernel@vger.kernel.org>; Sun,  5 May 2024 03:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714880421; cv=none; b=aNP7iGc77urr3YFhc+AlNUn+31gYrzlkyXnwMH20XY+INvy4kNb6WbjilyKDoLRAzHmHcN0TACridG2ipNRdqNntovkidlFvmGWxKl6k9La0eacQBFV3oWBeRK4BO3P8r5huP+b3e+xlONVO25QUeZtx0MBw2Mpkgj8ZrmwPoAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714880421; c=relaxed/simple;
	bh=Kah9CIrso4VmA4GAgnN4rLSvj6Y+7OY1CGoXUozuv4U=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=WW1qZP9Om8aybIjBow35VzdY1ArdGjgaw1nLOs96qySbC01Z/S+Sak7tD3fQk9LR0GjhwzzrDw+Qx0MT+fGPPk5w1ySoQtpP+fQgZCWUQiz2MtGFyrszXH1Wku7J7oaknMSgHnwCIusd4kX/Aq2vfQCaiBPsqOd5Pn56NF/x1aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7e15eaeef60so95866139f.1
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2024 20:40:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714880407; x=1715485207;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s9Y72YxdT1jhsuKJQ9UU14gSLltd69pv+xEHz2N37WU=;
        b=FTHKzSbjjQLhOakLJTAqDKEN/X5pli2vtpbSn9Sdz+azYHT9Ozi73IowbtzVLUcZvf
         NP5FoeHK67zNNhg1/t9zpkYNnNa8/vxE1kQdGLeFpLJXQ0ikL1XPDhR5K7bActkwNjbK
         9oVdvHzMtg0E+ENzt16aS7qLFoDiujSRIg8MhTAvGMiC0UDp0nfhXNUOE8t0M+nDqCCA
         qDx6eOMEwVxrWNzeEWlnM7sV43dPQkG7g1wqiXD0PeTxV7DvoDTGpbhLFbhwlSL7vW9j
         LrQRZlKahzGnaGMz54Eb9IqGB8qjuGP7r0ZcYmd2F2IB1OXFSVnt84prxiRuEgfQEokl
         329A==
X-Forwarded-Encrypted: i=1; AJvYcCUcTjSLoroUgP7hyevfMmnZZfCYFt5nm8fqgQlnpAckgwd3SbHwl2sPlgp1AX8/JyzO3fbtUwmch2h9Uj03KjTWEX3N0D5Ib8MaO7Qj
X-Gm-Message-State: AOJu0YwvZ7bRV/oo156UxZiUjbsF2sxTxNL5+1I7Eqiz/cEnLQvM2pQa
	UoAHc4W4pK4z1TRzJW27bhCL3SUBS95oDPdB4QzitbTxwy5kYl4vZ6xrceSYzytUobheLV0KN4I
	qv49TxSmCB/Et9/366fipQfSPCaTvwDbi1Mnu3/PUtDDX2gnf2LxWXF8=
X-Google-Smtp-Source: AGHT+IHSuW+CmNmcyXU5yL4HEMtOIDBuiQTUQHwHXD/Zv5Tl1T1gDnTzqLTHpjf74LLdVLle+bkqjnOd1Wg56aZXeOMaiXsy5eS6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a26:b0:36c:5029:1925 with SMTP id
 g6-20020a056e021a2600b0036c50291925mr440601ile.0.1714880407145; Sat, 04 May
 2024 20:40:07 -0700 (PDT)
Date: Sat, 04 May 2024 20:40:07 -0700
In-Reply-To: <tencent_7040976837B44ADE740F760F669A3C493609@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000801cab0617acb578@google.com>
Subject: Re: [syzbot] [net?] [virt?] [kvm?] KASAN: slab-use-after-free Read in vhost_task_fn
From: syzbot <syzbot+98edc2df894917b3431f@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+98edc2df894917b3431f@syzkaller.appspotmail.com

Tested on:

commit:         bb7a2467 Add linux-next specific files for 20240426
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=157bf1f8980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5c6a0288262dd108
dashboard link: https://syzkaller.appspot.com/bug?extid=98edc2df894917b3431f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16d29450980000

Note: testing is done by a robot and is best-effort only.

