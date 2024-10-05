Return-Path: <linux-kernel+bounces-351749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE92A99159C
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 11:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D208283908
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 09:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29DBB14265F;
	Sat,  5 Oct 2024 09:57:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570BD231C85
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 09:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728122224; cv=none; b=AUUqtnZnyYI4QgCOYV0V9E2NnunJ+fRMdyj7s5M3ael8I5NO+yChnWKR4f50IBKC0oFno11IA0hB/tO7LZhWrSTwo8k8lDPpMM6LJm1SEmisvTi34gGy5wx5PGak/EhYhA32qmBhEPHMDPWMkQxxvFAr+M9pgee2kmerxDeub0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728122224; c=relaxed/simple;
	bh=+VXZYlZadDX5Ysug45KHFwS7miyhWrlgL/NFqe8mLW8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=oKZuwq5cbKI/FcqiG2cXKVERsRth2pXyEBngXeUu1zIUqmzz6vyCoUM5PzqToxPfEjwncE2akQdeYnANjc9EC4medg+TVlE6hRPFfyWF6m8WlD/BM+LcdUJQbdUxSzyeK3PEwOKjIJOm/psbPuAsHlmXHCy5bBEYqpIIXTqk0R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a34205e146so36097005ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2024 02:57:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728122222; x=1728727022;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cKfOArhbiccNC0ifJqwQ85fbq3+rf2fIBlPm1BKhFqY=;
        b=OV8HRL6sVvHU0IIzSM2hvgdHAK67gI48v6RKt/Pg+YLrSF632eNDINWS2n2UmO8q2+
         2gt6dBjEdeDbcNxb8hYOX35nK2verFvkIsj0al9BCyuAEjjDky8rfuLHb0k2aEtfgeYM
         dU2A0+emz5f++VJ82+DSXkJGt0Bz9mqkBthu4kDDu7/D38YWQPaf0XAIqs0FOpusUnJB
         HyYBGQXWAWbjwmez23xVR9ih/MTkjBuDU7/dFmUjWVEUfT2QWZHJOam/na+POiKAE5DJ
         A2HIPLSC0fy6GY7MVCtPn0sSclDrnj4qerzSJOI7s3Pj6XY0xG5d5Y73AkXa1WSv/wAB
         r8RA==
X-Forwarded-Encrypted: i=1; AJvYcCW7Gd2FC8omomN+0jY+kkEHDi5ofO0+mEjnZpFnBamX230ZLaBWlRP5lzDC8y+r96atAr43Vdj5Y3gS8SI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaJ2dkPeBJWBJxKfnCuoOt85Om2r2d5QY+3EEOoJYYiU7DpUjP
	+zxVCMrI/US6qzBFwJms25edSzxTI0QTBdVmlYCHdvMqjYOlaqPkcm3AIhpMWLiUN8OLJfXW1Np
	qSCHM22afgyBRnxLG19V4sQYs5AHQbCTfBk+/Q26NiWJOSUUng2+FVf4=
X-Google-Smtp-Source: AGHT+IGPIfyWZWHnHpVVimgFC/DsSt4ZpP2ApBcs8/FPWvD4x/Oiy+R1tz6SCS4AhSohPptYZKrpALNp+SHbXO4uoCu3b1ZMEvVj
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:148d:b0:3a0:8c5f:90c0 with SMTP id
 e9e14a558f8ab-3a375a9aabdmr58670955ab.10.1728122222467; Sat, 05 Oct 2024
 02:57:02 -0700 (PDT)
Date: Sat, 05 Oct 2024 02:57:02 -0700
In-Reply-To: <20241005092812.2152-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67010d6e.050a0220.49194.04b9.GAE@google.com>
Subject: Re: [syzbot] [net?] possible deadlock in gtp_encap_enable_socket
From: syzbot <syzbot+e953a8f3071f5c0a28fd@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+e953a8f3071f5c0a28fd@syzkaller.appspotmail.com
Tested-by: syzbot+e953a8f3071f5c0a28fd@syzkaller.appspotmail.com

Tested on:

commit:         d521db38 Merge branch 'net-switch-back-to-struct-platf..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=167bd380580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f95955e3f7b5790c
dashboard link: https://syzkaller.appspot.com/bug?extid=e953a8f3071f5c0a28fd
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13f0bbd0580000

Note: testing is done by a robot and is best-effort only.

