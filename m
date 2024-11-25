Return-Path: <linux-kernel+bounces-420505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6339D7BC3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 07:58:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E70702823F8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 06:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AAE717E44A;
	Mon, 25 Nov 2024 06:58:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFE41E517
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 06:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732517884; cv=none; b=LT+6S5Cgu42bJVn06RKCbQVlu2XZlqmPb0yQIrZ19WtUd/lcW/AhpXIVSTRLBK+Y+uoKEHk2MMeRVnDPR0b6G1HTdCAXhJBJDwsf9GWquYrLqi258ope+8BPN3kspvT4x8GNWbBpvBBGjyeZ+7F6eRTI1sGDJbQ0ldNqj1B+nG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732517884; c=relaxed/simple;
	bh=bM9O6NfMc2muiofDE7H6gbXkq7iWmLc00A3pC19GLmQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=YzbGrtb+rXkTe0u3J0PAKKUOadCYVrmhU3xm3a8ZrH7B1uTlReN4S2LsC5dGvSb1F9do9w2FUbB4KfoDksEB6xQRoCTGQvjZNzYZdzYWzVr7tRr2TYQggcwR+FjufGsWSfv0wP0H6l8oKOKF6Qtt+BRmRSIVtztvwD4T51jkdbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-8419f8859f7so42030839f.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 22:58:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732517882; x=1733122682;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=//bWFNf01oJnDXBbdVmx63yFcgjvyeHUiVLy486bB4o=;
        b=O5wTTFRFujmQgHPnW86X/e75/LAu+ZffFQjKwlpE0YTstSE/uvJIXgEerfPQYtR/OH
         /OaOVP1dJUFjNStwGJDxDDR440nz0kyy1bUb+5VC1T8fv4/4KmBoABKYhLBL1aV5rlk5
         oenpJepFzZ+OEUv/WLbxVzfmyx1pRR968bf/Zv8sws4F/wNwSFMLuQoHBzJl8/ej95GE
         FK9GLCRk/cXTRTu0CBLN0kqLi6MFzRCQvMJFbLybiwX5Yn8VpElfILLcx5+t7PRASlZ1
         xx1TGNl6s1+sPbQG7h3kdgNU8ocfMBUm6QEOB5OyeWpsx/9iwYzMApolQ7AGxp4yEOiY
         otzg==
X-Forwarded-Encrypted: i=1; AJvYcCUf/R0IlkMntr4OD5O9MaES7188hOawEafFaznrMqVerm2iDdZBvFNvokO63YKcTZkGHD41dqK0BZ+EY5g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAsQtMAsx5QQngFuciHXJAbHqoNShkRRhc22YsMXvuaVL8zgCe
	TRzlMKDMTiosjhgwubXH6YPcyxnBZ4/6HkRjOZoe+PdtrdgazPwqDw0lZF5Dk7a9vv2Ie4/0TAq
	J2opClTdAr7icPMNKizD9e8DgZWgn1bcn3yO5KMpnZBVKlDIgcsoxejQ=
X-Google-Smtp-Source: AGHT+IFb6S/Iv80p8C6ZE7mLsbWUmSqQywLbpwmc6Bg+Xbr9ersICCfMOZQvuMIosvslp55qcKUSXspxcQWj27kNkHVG6D0O7Lid
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18c9:b0:3a7:8040:5962 with SMTP id
 e9e14a558f8ab-3a79ab8148bmr129197785ab.0.1732517882499; Sun, 24 Nov 2024
 22:58:02 -0800 (PST)
Date: Sun, 24 Nov 2024 22:58:02 -0800
In-Reply-To: <CAHiZj8j2EyaMeTCwOQNAx8zvaB=dLtO_FPB5zW==N-YqDo5=nQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67441ffa.050a0220.1cc393.0067.GAE@google.com>
Subject: Re: [syzbot] [mm?] kernel BUG in const_folio_flags (2)
From: syzbot <syzbot+9f9a7f73fb079b2387a6@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, surajsonawane0215@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

./include/linux/page-flags.h:310:18: error: implicit declaration of function 'folio_nr_pages'; did you mean 'folio_page'? [-Werror=implicit-function-declaration]
./include/linux/mm.h:2056:20: error: conflicting types for 'folio_nr_pages'; have 'long int(const struct folio *)'


Tested on:

commit:         9f16d5e6 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=c4515f1b6a4e50b7
dashboard link: https://syzkaller.appspot.com/bug?extid=9f9a7f73fb079b2387a6
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10e82778580000


