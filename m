Return-Path: <linux-kernel+bounces-563311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD130A63D64
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 04:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB239188E6A6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 03:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994C7215044;
	Mon, 17 Mar 2025 03:42:04 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B2D51C5A
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 03:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742182924; cv=none; b=jOQvd5lh92KzUHyrQIcElu+6ViVUyDQkbmYxGPNwv9S+tqEhmqwayFJNmpTC7kiXZfhxTWNXa2DZuTqOvYtt5Q54LFElNSvDqYHzUYbiH6iVVQUCTruy5L+z5ttr8zqRpa1fBD88M8QifcVTSYZz56sGg5cXOUGjdS6zmQWRAyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742182924; c=relaxed/simple;
	bh=4bKMRgR40SFIGPrQst350r/1BhxLhA5iWiEP4IH6Wf4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MQAsRuoVqd5BFEn3EtKexJxyoBl0lu8+elIruvHsKxJetPpbOIs6VWM1xfy4K03ZbWNMwsmnU3Le/IAjCEhPtk6BXwkPOox0P4GWxTmS6JMpC/YRsl5fUYwK5Ts8gw6zKmkHHQYC6YJxNmaXJ1UIQPgm7RS2kQtIXMv5AJyJDFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3d4423d0c49so34277675ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 20:42:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742182922; x=1742787722;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZjiBm1c2DmGIm1FqaFSvnhp7T2ix8so/PQi/7DTSKoI=;
        b=hz4ewowmL8JHKutsNN6hRfT7cnz55sq8O3rKZMi/tGJ8ldT308kNXcw/5ewilmRr6S
         QENonGuG69SfBaoUMhdSdNLSbcpiwo7GmPXcMPMcshopHZi/e3alHPUX7Y/H8Php7Huf
         1FRHtyQdw29AcHlG+Wq3HUUH3iPe33F3r2Dbb3LIQaUhtyfYCClI5nnrJrW8jzpYMUlT
         c7hpHC9TaZib4UvDIRauNOAvQ9xUyuTtUJdWR7nYp/xDU+2G6dUq/MsyCaaqJrz+6VCe
         6jlsNDzlTJCSt5AkQplGKdyNeIERz2CT8+LhofjyN/M3L3Jl7pn26Qvm85/mnHJhX0i2
         ijRw==
X-Forwarded-Encrypted: i=1; AJvYcCX83CPPOoTtJw5a/iWehBlv4dxo5NTCPWdZb8uP2tMW7hDWoWTsWATRs6x3xP8Y404papeNUuJ1Ien+9jE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1XC5m6JAsJn/60RS9D/Kh59WiblmbHsOn81/tW6LGv4PcWw9y
	shQ66CGPFERjO8SAnOaBjOt6sOyJ9ci5XRB/pDSHG/ryil913FA9abj8McfrzST0WYDbRPCy1b2
	w53IkCyMCrVvI6Ap2c4KG71DKbHILDoHxh0fqz0qgDodwdnLr8P2KrN8=
X-Google-Smtp-Source: AGHT+IGRJxEYTkN4nNIUivh4AbwbqwYWEBSzEdyGdF65wRPtPt7zza6HZ7IgQX6o8I+5Es6ikmt9MGchhETcY8dWjrVY+2jO/J0F
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:378f:b0:3d3:dcb8:1bf1 with SMTP id
 e9e14a558f8ab-3d4839f440dmr135090345ab.3.1742182922001; Sun, 16 Mar 2025
 20:42:02 -0700 (PDT)
Date: Sun, 16 Mar 2025 20:42:01 -0700
In-Reply-To: <PUZPR04MB6316E1DB152B8065EB4615C781DF2@PUZPR04MB6316.apcprd04.prod.outlook.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67d79a09.050a0220.2ca2c6.000a.GAE@google.com>
Subject: Re: [syzbot] [exfat?] INFO: task hung in __blockdev_direct_IO (4)
From: syzbot <syzbot+f7d147e6db52b1e09dba@syzkaller.appspotmail.com>
To: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org, 
	yuezhang.mo@sony.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+f7d147e6db52b1e09dba@syzkaller.appspotmail.com
Tested-by: syzbot+f7d147e6db52b1e09dba@syzkaller.appspotmail.com

Tested on:

commit:         4701f33a Linux 6.14-rc7
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15154068580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=620facf12ff15d10
dashboard link: https://syzkaller.appspot.com/bug?extid=f7d147e6db52b1e09dba
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16b9c474580000

Note: testing is done by a robot and is best-effort only.

