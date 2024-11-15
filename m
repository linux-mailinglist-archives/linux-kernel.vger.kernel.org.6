Return-Path: <linux-kernel+bounces-410956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8F89CF0CF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 16:58:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53EE22867ED
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 15:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD4E1D131E;
	Fri, 15 Nov 2024 15:58:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B98D1DA23
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 15:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731686285; cv=none; b=JGO2OKlJEpFU/x2LS9U8UYJNu4wgp12xmsMaoR6cyzjVQNfN9FWrWVGl5cIc+VqJFqjoJ9V5sKNg+YJF46X6N/C3+Bz4zUHVcS/mg9xzv9M8fJvg2SQHkeUOGbuZKz4I72ql2kd4AQHBHahHiAS9gOyFK+9ScxmtLbaFgknDsfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731686285; c=relaxed/simple;
	bh=xGy66TX/c5+zNfHIIz1es8bCQGWAaweO2q7JddCn+9k=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=akn2s98DHbC5toXrc2yCHWwo5hRkKj7LEsLyF68f8WsOV03TXnYHZdlI0zcrH8IF5ocHr+ZP3OWHwoRAZylw5yc1178DYrDPQ60/zsNmc3T0nJbO5Fe8obxSs5gLsTwARmRNJQItfnGmSC+10AnPGR2fUB0Mcwr/rojIwR5eOz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a6bce8a678so10010355ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 07:58:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731686283; x=1732291083;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+cWlwXOusbqWeTNeMiSxvoCEQ/oVoW7J0lC9AaTbRlQ=;
        b=Lv+vTqrX9nFS7urGRjE7fsZeQQCelFXgEYfDNsir81IC6hhI+xKKya3kxXlXudtmvS
         TlwiYT7nGPC1zwBxqKZNMPVWfEIAjaLUTiaB9OueSmDMdi1und240Tj/h8w74x1i8Hwf
         1nJm9TE/Z2ZcRlGmrMGKkh6R/LdO15mR7GyAPZ2nUNOXTop2Rz1rEY70WCAEOVGDZaJA
         0VrLk0GYlukFd3u+MuYZ/VCNtctDRSqzHN3eVRU14Xc3pyGoZXtLNAAbQd4VW0ywRusk
         mVs4pzbGfMQj5cQW9+LS9IngT9TERMRbFjGDvULG7mfpg0wkyzYY43HP20k0dSYhVVdp
         aVmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHsfuIVWK1KJhLWwEaNvQtJVv9DuJSclSQGIQMMIVH+Vw7WZp0EuRfvF8oUbgoQHGMO6G9ebR0FNpwsVY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd2lOzV8wwkCer2RBdrA2suaAKBAxtOhcV6QaNc5D3zb3Bf70Y
	IF4REfKQH3mM40m65EI/hIff9DYO4RftcBGomctmcHtwSZXa5/6n13kIy4uAgDKeE1GkTAvaFjN
	mOygJrPBQyBTYq+P8saYFBGTVcDoDI+RQlrUH2GUMjwf5m3CsrgxUYvU=
X-Google-Smtp-Source: AGHT+IHTGp3JV//+H9Q4bAD3I1/WpULVrsc+LPXF3Q0YlnSD7pZ7kHe7MTmUG58gGe/82saVTqj6uj79tFnqJi8zBqxBqx8e+/55
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1786:b0:3a7:3760:7314 with SMTP id
 e9e14a558f8ab-3a7480836a8mr35148725ab.20.1731686283657; Fri, 15 Nov 2024
 07:58:03 -0800 (PST)
Date: Fri, 15 Nov 2024 07:58:03 -0800
In-Reply-To: <20241115152138.SNq2T%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67376f8b.050a0220.3bcb1c.0001.GAE@google.com>
Subject: Re: [syzbot] [btrfs] KMSAN: uninit-value in __crc32c_le_base (4)
From: syzbot <syzbot+549710bad9c798e25b15@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+549710bad9c798e25b15@syzkaller.appspotmail.com
Tested-by: syzbot+549710bad9c798e25b15@syzkaller.appspotmail.com

Tested on:

commit:         cfaaa7d0 Merge tag 'net-6.12-rc8' of git://git.kernel...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=14145130580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9d2d076474187685
dashboard link: https://syzkaller.appspot.com/bug?extid=549710bad9c798e25b15
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1382b1a7980000

Note: testing is done by a robot and is best-effort only.

