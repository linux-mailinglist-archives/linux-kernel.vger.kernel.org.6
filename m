Return-Path: <linux-kernel+bounces-367315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DBA9A00C9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 07:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9135B24518
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 05:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A9C189BBE;
	Wed, 16 Oct 2024 05:34:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340A9172777
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 05:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729056845; cv=none; b=jJoDtUHVz8k1LSqAwsHBOL2bV/a8x0v/YlJPfv8v1sbLFwnOrtZPzrGN0vltzfM0CQagOt5eT3fo3dGkQTbdZwsYpdTqz0Xjo3Fg513MwHtfugJV7hKVl0ujIqbnfynEo3LjZK9rsWzADrfnS2MWs1/VieHqM2NdV52Ki8nWIgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729056845; c=relaxed/simple;
	bh=kJLecZJXDQwCQ+Aj94XwkW9OyLWSVhjr115PCz0RzFM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=d6CvKGbqr3WD+9kTVyU334feag0OEz0IQDHQNorNReoosHSCi7ntgyQe315muThJAiK5SqyRpGIMkdQPv4PSkKuRU/rfehsRk3ZmJhf3+bp1cRJovIUcxQcCpp1VwftmGTlgMM8od0NGKUJ6sfXPfX+Jwh1rcVOx5PUu8DWisDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-83a709455a7so476115139f.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 22:34:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729056843; x=1729661643;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6FpoelTa9GKN5g/rJ1NmD/+p5tqyDj7lx/aPpf294Uo=;
        b=wNPQgT5zwJnU/G9+FIQxPQNHQHXsC53u7sgz/apbY/8I+f8XA4rd/L4Nw2YkCf6D0K
         ZQ9i1CQCFu6fCyPQEfa7nMGcZ8IpJ4TVLPaCLrNeXx6rjt/L3e7ZpHTzTEQQC4CeDXJ8
         nEU9WPOnqZSTbBj/kUTmfb9xbAFc4H3jrPF8hH2/3hPRpVTHAWX03ohRCailgQroxeMh
         xOk7tow4guiTg7R2R94De9FDsNI+8KprD+DFnzJ/wT9TQ5Dgfkc4UVX5+WkeQbc8/xWN
         pa9QbLWwTv4clPZyPaNi9tM8TijOh5vlHwFoinCrUbdUMXKMXqisLau1tmAdM1mm3wLW
         TGTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbMNUfaG8+KOC3zugDf7QwD/hiebksvD3wfKsRhIvYOxpX9NKhh+fMUU3pGOOpo/x7KNFqDRiHmUhG+PI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+/k5gv9l9+Utj4ljH5YuOVQBWCHwasIqYNmofTfJifT5hNmFM
	aqcSREi26zUrOekx2mzblpHGI/7r6PvJInIl/F6IxtL+mRIsdBMg5sYBpszxUlk2DSew03VG+j0
	yeC79CSPAOSLa0B08vZuboEb4VwepBxqUMh5r7YedB0ApTElG/6m8aEE=
X-Google-Smtp-Source: AGHT+IGlXH0hOYWbDCpliipMMkV+ON4CbsgpZ/j/WhoMG1UvkZ6fukspdIo97kjbryTAFGApMU6jRARXG+xOCO7hkilYu9rhX3Yq
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1e07:b0:3a3:6b20:5e20 with SMTP id
 e9e14a558f8ab-3a3bcdcdfc4mr112981725ab.13.1729056843213; Tue, 15 Oct 2024
 22:34:03 -0700 (PDT)
Date: Tue, 15 Oct 2024 22:34:03 -0700
In-Reply-To: <CAGiJo8T5fAOgFBo5PwDObAJM=aiT=J0i2quXFo6XmPX4Fe=bZw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670f504b.050a0220.d9b66.0161.GAE@google.com>
Subject: Re: [syzbot] [net?] KMSAN: kernel-infoleak in move_addr_to_user (7)
From: syzbot <syzbot+346474e3bf0b26bd3090@syzkaller.appspotmail.com>
To: danielyangkang@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
BUG: min NUM max NUM pkt NUM

EBUG: min 14 max 14 pkt 1
Warning: Permanently added '10.128.1.180' (ED25519) to the list of known hosts.
executing program
executing program
executing program
executing program
executing program
executing program
executing program


Tested on:

commit:         2f87d091 Merge tag 'trace-ringbuffer-v6.12-rc3' of git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17c52c40580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5242e0e980477c72
dashboard link: https://syzkaller.appspot.com/bug?extid=346474e3bf0b26bd3090
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1229c45f980000


