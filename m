Return-Path: <linux-kernel+bounces-301526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A7B95F220
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 14:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FDE62857B7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 12:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD3F192B80;
	Mon, 26 Aug 2024 12:51:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A82817D8A6
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 12:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724676664; cv=none; b=rOeLLeWx4GHlbNQ5nR3QiFglLkR34XTHhV4UNQXFDfJJGL16+FM81/vLWF89OMq+VbDjbKItFIbu8hHemJ8AFYiYiXra0uSDDE5DprNBDHjSkfkHvuxASknbHW8T7f3QYXNQdJ0hu0aFDuJScQZuHnshEyX4aQQY5pYfLl+LR1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724676664; c=relaxed/simple;
	bh=9Nx9LIURt4LnIWuSY6OPnsB314ytV4DJ1MlUoyliyJA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=UTuT0LYi6EkPXftHJ9gRDpjOFHp46idwapKaApoBWsegdaDbKKyJEKkgjkoysL+f3knyYCLATBPZRdqBfPtjzueTWphB7Y0Mu6RbzTmC3FQdhe9gs1x2pkobrswQW226mNydqkIR2+IlSgVekCg18FOcYH91K2zEnsvg5YLQYF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-827878b991aso297918039f.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 05:51:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724676662; x=1725281462;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KYnoaanpvMXV9kNlXY7LMLhVONeO68nM0oD1lPFY/+A=;
        b=KQU+pDQl33nnoUSfiE2a3Np3s3svrYm7gJ/RsACM8kt1hJxQiOCfwUr5VaBjbU5TSs
         hcEX7h75NBsFkQexY8imeu1rvsy673UueIE6OtPcyu+X7N1hZ8SJQfukD8ZaqcHFaQD6
         GXmaQk6RCH3c9YQIUnEA9tfzmg1i8Z6NT7lNxLHoaWFX8FkUWMXKGTYWcaE2KlkSG36U
         mEEDrXk1a8jOpJe/+ztgIJXuKkQd8uh5LMKPFERSPheEsockFQMECo4AILOwVEcm6UTv
         3pID68QSjTaRfc0uDn0QwHbCVydYwd3hEfDB69zqZTSAWYkgY+0EAeWGHpYapVIkqC4H
         eweQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgrJ+aw4/lllrvlLNTZBw3rn2UFEFYusKZ9S9BCFYNYYlpeNfVaW/9RDVfx7kbW/Ve6nxhqOxQQWsCPTU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3jdhjkND2YEy/uGiK/2jPaRuia6/4lwBNmnwXzYT1TEwXuiMO
	4dBvTrH6a0fWvW5yNGEhG5QhUDakA6ddL0RYLpvdOEgo4YT9LZ1xpougU2nREFT34+pkBekCwnZ
	V7L/SqdFJ8jzB1GhlwUmKwbx6kCJiwFp4JnThbZPOa4SeN+WXtlifVC4=
X-Google-Smtp-Source: AGHT+IHHPRRK3xkPo8Q6JVELC7xochAGuGB6tcgZ0v1D5/TmGDLl2MPCQZmx/5EQfNRtmX3STmg41qi7aUGa7WRWYew8gTzioOHk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d01:b0:381:c14:70cf with SMTP id
 e9e14a558f8ab-39e3c975718mr9333295ab.1.1724676662388; Mon, 26 Aug 2024
 05:51:02 -0700 (PDT)
Date: Mon, 26 Aug 2024 05:51:02 -0700
In-Reply-To: <20240826122629.89698-1-djahchankoike@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d08d130620959354@google.com>
Subject: Re: [syzbot] [net?] WARNING in ethnl_req_get_phydev
From: syzbot <syzbot+ec369e6d58e210135f71@syzkaller.appspotmail.com>
To: djahchankoike@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+ec369e6d58e210135f71@syzkaller.appspotmail.com
Tested-by: syzbot+ec369e6d58e210135f71@syzkaller.appspotmail.com

Tested on:

commit:         18aaa82b net: netlink: Remove the dump_cb_mutex field ..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13a6c22b980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=df2f0ed7e30a639d
dashboard link: https://syzkaller.appspot.com/bug?extid=ec369e6d58e210135f71
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17a2f639980000

Note: testing is done by a robot and is best-effort only.

