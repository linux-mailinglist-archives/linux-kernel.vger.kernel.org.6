Return-Path: <linux-kernel+bounces-344238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F1A98A726
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 16:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 391941F23594
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 14:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12E51917E3;
	Mon, 30 Sep 2024 14:33:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7F4191F62
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 14:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727706786; cv=none; b=M1KgR6N1rXSTt918SJL0d5SDM53AVRopAYKLcC1VYdfuH4hAsX/ZYJrQdzr9px2fXenllB+bG4Kj9N0b5rwhk5mf7KhWJXzi07DB8BFvsw/fqCFE0Y9kdgCf/bcvKbuFNsd5ji0Gsukzxa+5rIHSqVkp1WwlrCaYSoFJyIFnTnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727706786; c=relaxed/simple;
	bh=vN7O15tK2BLESm50cAZM9T3gywE1I9dZ2aruNC5ZOIA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=o3nggQlOZIjiOO8OE4yyIbUHHlfcMb1aqzkJ1psnsgWmVzKcspl6fzK0BwMjdzO3xkC4BWHM3NroOJRMfaKliPiwlAoYGogZlzF+MgGWmpva1gHFWpFZVyfzqFqbKDOaVRXs3gIpaUl3FUsDOFmdO1BhwM5b1bdjfffCC9fQfnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a0cadb1536so51100765ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 07:33:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727706784; x=1728311584;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nZlWn4GQihalOzDF/9yzo68kjIpPrw334qaq0jlz824=;
        b=JRNPmDB7LhYzF0M7/lcAK619dt8YykoTj/ktuyGk18j0cZ69XewJOIX7Bm2o2XVa40
         EVSZIm1rHgvkeD8EE9xKDmpS3V8cW1iECx8LPPr+j8bgmvyg7/IaCLNrbNkaR2jFnP16
         911jCgh72TRdPiN0PmQV6D82HxCMI6dOkGPRmKHGXSe59H+oKS6V4QVs9SsJNOweIUgl
         lHWZcEo4AThr/MCpcOKDyBQczD9WyLZG3H+5/Q7UqrCcudOyzUMxCeYBnaDxIIcznc2U
         X3CErZSErRCgaVdYfq2+Q3bYSC9dX1QLjFVFSMp3z2VG2spxpC1IZI8uTBtnZ0Y1S3Kh
         Ib5g==
X-Forwarded-Encrypted: i=1; AJvYcCUPmHP3Xn9+PX9FvOkjsc5eMo5nclEie9+miSNfXV/6GBtWSNyVtlRW30p1Oz3zKuw5x/sO4r6JY/CrMmE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3w+yFpygpc66pLt6DnPas03l+yRqvDgksRxZuVKNhTb0sXzHu
	lpCj4bHg07fmH+fJVO10WzVnF/bUfqBC4Y78lHCgPrHSNDD3qLTon6qP9wu6hYjyVK+r3QfWen/
	fpAQLMAg4rtWPb6w85CiiiyNZdxazP9iVRrq/r8uhq/s8o9EG7LRuv9A=
X-Google-Smtp-Source: AGHT+IFsVdlV+j24mioSDDLUpfhbhtP1uetaTMEtW0ogCaUg5A/uJT3O8v/Tmgx/4CGpM3wuKnT+rEK/4pkTQE36lkSErnyMJRCh
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cd87:0:b0:3a3:3a5e:a337 with SMTP id
 e9e14a558f8ab-3a3451aee34mr107416245ab.16.1727706782697; Mon, 30 Sep 2024
 07:33:02 -0700 (PDT)
Date: Mon, 30 Sep 2024 07:33:02 -0700
In-Reply-To: <000000000000b7b11a061ab49122@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66fab69e.050a0220.6bad9.003d.GAE@google.com>
Subject: Re: [syzbot] [mm?] WARNING in __page_table_check_ptes_set (2)
From: syzbot <syzbot+0b56d6ed0d0c0c9a79dc@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, david@redhat.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, pasha.tatashin@soleen.com, peterx@redhat.com, 
	syzkaller-bugs@googlegroups.com, usama.anjum@collabora.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit a1b92a3f14984c96ace381f204b5d72c0805296e
Author: Muhammad Usama Anjum <usama.anjum@collabora.com>
Date:   Fri Feb 17 10:55:58 2023 +0000

    mm/userfaultfd: support WP on multiple VMAs

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15d9cea9980000
start commit:   3efc57369a0c Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17d9cea9980000
console output: https://syzkaller.appspot.com/x/log.txt?x=13d9cea9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a4fcb065287cdb84
dashboard link: https://syzkaller.appspot.com/bug?extid=0b56d6ed0d0c0c9a79dc
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17a7de80580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16b67507980000

Reported-by: syzbot+0b56d6ed0d0c0c9a79dc@syzkaller.appspotmail.com
Fixes: a1b92a3f1498 ("mm/userfaultfd: support WP on multiple VMAs")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

