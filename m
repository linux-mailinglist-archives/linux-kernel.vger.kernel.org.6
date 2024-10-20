Return-Path: <linux-kernel+bounces-373354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D749A55B1
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 20:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C34BB212F5
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 18:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810E619581F;
	Sun, 20 Oct 2024 18:12:07 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8841946B8
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 18:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729447927; cv=none; b=XuJuLg2oejBR7/6SBLNlJ8uq6rS3QBXfOFRaiDNCgxby1sVq0PLOxeoAoOJ3KRcbglqBgXrTdygM50eHPmCcMNfBdOY4XT4H9f4RxPRwiyhHOEe59+tzTgGKdLY74Aby6QG2JSJNzS0r+GE2+cF3olMNHEMtXae+LANm3/1G3s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729447927; c=relaxed/simple;
	bh=0kdGTm27vaQn2TkIRItbudHFnl/kmcbl+QDOl2Jg11E=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=B2nmNes0s1PEZz+ZP3WACAFzYyCqRcL+FHA2y6nQH2s/Jq6B5+DTtNHH3gRUnoeqfVHNbS/GbK+4lUtb+oZMNHJ5GjPe6pQ67eHBkI03YPTFEjXoigdaKejdicBLz6dmGRHiYfdOUjj2TTe2wYnSnBkQszLsxfkD4ppaQcugEFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3bf44b0f5so21444275ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 11:12:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729447924; x=1730052724;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z8QAZccqRwz7JcdERXlsfYo5Amz76jomyg/R0CbjXGM=;
        b=ott7HAXQX/xaenB/gcE4oVBCrC5B3vN5FK1g2sslsS0yEqZdNslvtL7sOuV8JIh3bd
         OF/vgPOuufKxz0pAB8SxPNRXfiVn/fS9Nlm4KU9y042GXVqrG2WvbK+Yta6J6gEwcA3p
         HClm4n7k7xl3Kooiz4YOjJsW2BWxoH/1SVyvhumufi6O5Ass1TJrx4JDI8lju9tG8ock
         zwA42RqC3opEBnLEsVYPaiRnrX0rCSzv/d5XgYYBJQW1XjHhzdxSRUC0AjhpaoiGIW2u
         CjFRHLBmp68oNCns/zW9Mi/7HJoQlujMa8RxrI8lbVa0hnu2wnK5h6PadcXNruN8/16e
         E1hw==
X-Forwarded-Encrypted: i=1; AJvYcCWFjbi7YALxX0PdMOtY22ZSjyoOxBphzvx/bB4oVa4jjmOiYP0yyhfF2TuEroRdC/0uTHGOMX2ZF/QIMbk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3dOByNF+E355vtGuJp8kolZUft+rP+iIzKZOhfBthSxgZDJhZ
	fENVfZHNPW33aKYMkcDWbK+hsx/0vnLDelY+CQxWkeOVnXkMgweK/T208hprrmuYcSDZepCBH1H
	t3U3vF+wwBYFFxYEPa5FqrkJ2tZDR/JyQe6zQg2kXCnIuLpB31v+VzDc=
X-Google-Smtp-Source: AGHT+IHxFULUh2WfaDEzwwv3dhCh4UHvJD1yb+hBECZ/uvFS08R7wFelVAdOjp7rgFfJ88saFCbLT4YCwdT6Hpdhbl+B6Y7JcSh4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c6:b0:3a0:4a91:224f with SMTP id
 e9e14a558f8ab-3a3f40474d0mr67332645ab.1.1729447924296; Sun, 20 Oct 2024
 11:12:04 -0700 (PDT)
Date: Sun, 20 Oct 2024 11:12:04 -0700
In-Reply-To: <000000000000ade4f305fc36868f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <671547f4.050a0220.1e4b4d.0049.GAE@google.com>
Subject: Re: [syzbot] [usb] kernel BUG in __page_table_check_zero
From: syzbot <syzbot+7a9bbb158a7a1071eb27@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, jannh@google.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-usb@vger.kernel.org, pasha.tatashin@soleen.com, 
	syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org, 
	yuran.pereira@hotmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 79a61cc3fc0466ad2b7b89618a6157785f0293b3
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu Sep 12 00:11:23 2024 +0000

    mm: avoid leaving partial pfn mappings around in error case

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11f76c87980000
start commit:   cbf3a2cb156a Merge tag 'nfs-for-6.6-3' of git://git.linux-..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=57da1ac039c4c78a
dashboard link: https://syzkaller.appspot.com/bug?extid=7a9bbb158a7a1071eb27
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15394721680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=152b7af6680000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: mm: avoid leaving partial pfn mappings around in error case

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

