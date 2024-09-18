Return-Path: <linux-kernel+bounces-332344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A51E897B89D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 09:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5225B1F22639
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 07:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86D915B57F;
	Wed, 18 Sep 2024 07:37:04 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157C1273DC
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 07:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726645024; cv=none; b=cxbFfUybrChuwac7TbnuoYXR/1fKPfmeO3pBkwUH93fF42A0kpoeZbZG9nxsTZXiPlvFrK0xiR/q+V+H74Rn/WnUdAA+5RJLzhUT3SaZHaddby7svi1OX6aVdwQEwNKrFqHs84rk681npi+v87yEzhpTezKeeAdR4akkZk1H52k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726645024; c=relaxed/simple;
	bh=UeMAVdDfkvgUwuxYrYuU5ivMnrozQpkGU4GumukxZsU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=OzFfDHfKY0750jfHcyfo8eG9i3BttbNwcae2CnfCYD+OLrri0dPJM2RPewyaTj1lCepReuWxTUQyXsNsqY1cUyoNiBjXKim2GLDuHUQmcRUKS/F3v6Sr583mzg4TEFY38FF/mk9Ps3gSpvHeTHuL80n+pLFsG2CXhjXyCb/4t+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a0a71b7d90so38599975ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 00:37:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726645022; x=1727249822;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zNDK2LKZ4njEZoeqFEptv9Q65TNnpy3U1I05FVRb5lk=;
        b=YGcG5nQfOQ7yhI+Kj8LFxIM+rKST10yrOQR+c9ElfW73LVzRnsdLvTXqijpoNNTNxF
         TFLnJiPsJIIAKwQ4pUIzmVmu3QpyEK06xvL5nIvyLyfIO/jw2vNw1RpRadrNB3F0L1wc
         ybIgvdn8qYGcEyYqJFAIZUbrhKEL6qO/19F+6a+qes4vu0W4rw2at5JUxrfZbRV/jm2t
         kApwzUPWZ4t3CT0s5r9F3y3CTZH2vBWBwIslBaXeR8OLVUkkXezjqzY3JgPexuUxFi7M
         6FNSDH7dRPoLtpjEMbv/FQRLF7ywi+Uhcvble/krY6+NAdnLB3R/YqM2fqJ1GNK1NXBX
         0XTg==
X-Forwarded-Encrypted: i=1; AJvYcCVhfwIfINPOxuLEZSoWE7a1jvZ6rlKECQTFbO1Sw731Ez3jz9TypCplE0iMwo+P2x3FtVkn0bgK/G6eRxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKzYKB0XuhHG0lrzcOnML7rIZVn1ba11//VUbvxlCAUicH79oe
	SG7/jSpe5C1ns1jAEdH0QNw3OO9GuZFi6TadkBAytz3pd8YI56W1Wh/poVmEh8UBkjEK1ax9Pib
	I6iyolfT3jT5h4fBf4LClazB7ULbKOSwbIIatzvZdlhP4o2lhgsgCMdU=
X-Google-Smtp-Source: AGHT+IHRLgBYYx+9Az9JF+y7koLf4BPzUIQAOG6YuGVKOs23tWbIlvXKYy3/tvDLZXR9YEgBJGzDoGVxRrmMLfUYdvzfJMdrD/9w
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12cc:b0:3a0:a385:9128 with SMTP id
 e9e14a558f8ab-3a0a3859420mr75605905ab.6.1726645022141; Wed, 18 Sep 2024
 00:37:02 -0700 (PDT)
Date: Wed, 18 Sep 2024 00:37:02 -0700
In-Reply-To: <20240918064122.202586-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000032c10906225fdfaf@google.com>
Subject: Re: [syzbot] [mm?] KCSAN: data-race in generic_fillattr / shmem_mknod (2)
From: syzbot <syzbot+702361cf7e3d95758761@syzkaller.appspotmail.com>
To: aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

fs/ext4/super.c:319:4: error: cannot take the address of an rvalue of type 'ext4_fsblk_t' (aka 'unsigned long long')
fs/ext4/super.c:327:4: error: cannot take the address of an rvalue of type 'ext4_fsblk_t' (aka 'unsigned long long')
fs/ext4/super.c:335:4: error: cannot take the address of an rvalue of type 'ext4_fsblk_t' (aka 'unsigned long long')
fs/ext4/super.c:343:4: error: cannot take the address of an rvalue of type '__u32' (aka 'unsigned int')
fs/ext4/super.c:351:4: error: cannot take the address of an rvalue of type '__u32' (aka 'unsigned int')
fs/ext4/super.c:359:4: error: cannot take the address of an rvalue of type '__u32' (aka 'unsigned int')
fs/ext4/super.c:367:4: error: cannot take the address of an rvalue of type '__u32' (aka 'unsigned int')


Tested on:

commit:         2f27fce6 Merge tag 'sound-6.12-rc1' of git://git.kerne..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=31b069fcee8f481d
dashboard link: https://syzkaller.appspot.com/bug?extid=702361cf7e3d95758761
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1084c69f980000


