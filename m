Return-Path: <linux-kernel+bounces-573066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29973A6D293
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 01:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E61118939E3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 00:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB181487BF;
	Mon, 24 Mar 2025 00:31:08 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0C22E3386
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 00:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742776268; cv=none; b=pPiUGegDUksQ7aUB0gvnxKOh0Xkd7CQvTIShBiSnmPGnfOytz7Vtn32AivpVxYEvG2qdEekEeX81NKI0CjadOsNOtqe64LMpvOM0RWKdHhd1oonhJ5h+ez/raFlhe2DoyLwk4G7TLNy/p0O8l9ENhqx9yC4xjViiqcYK8QNVaa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742776268; c=relaxed/simple;
	bh=ZZEJRetsSYRXvdD/ivrCsbne0ANlP04c1DghXTUhIcw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=OgDHhfHvvcoe0lKODHMutCRojq/ZF5UyRqgs6sxBSPmtEt42JQYyHqVREnih5bJg9KDN/jj++wefY1i1pt3bsBYTrmXBTe48mxBqsfox1MDQPoHKVl8pmPVo6CnN3MbM1STe6PRA6vp3kmX5rUPY7k+eLqS2cynK2XgQoBeizH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3d2a379bbf0so75408905ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 17:31:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742776266; x=1743381066;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LS72qWgWj+AieE3Cg63R48oi6lwfgcL4tERE82Brtso=;
        b=tZVm+6ZD2yq5vjAKA5LurHVhQBWv2lr6ij480POWr5ECFiqwGR2GAUtFUJnvDSH86B
         LM3zC3Y9PDJbiq4/Pd/7+h4+EsM9qc1z1mCYAQv0chucAu/tgkEIz3kLTZCgJNd8nRGr
         nPv9hLEoWipXO7stkHbiEsdXkaU9k51WKNIib1gWiBdi0GdYyDpM6tzC8Gv4r8LN8XJR
         ds8mz2gwQ8C/a98Nm9WbwSl4mf623V6cEL+WUHWeOhB5vo0zjtZTsXjkJ6AapHxbIMa6
         KgN3gPLEDEBgpSgnQFUKGLE3/9vuNZlaUYesFuvq7kfbpGrpjgqCAVTrBmQVhMNyfHQJ
         v4mw==
X-Forwarded-Encrypted: i=1; AJvYcCXNngyPW5pCX09eTt92t25dKyGyCyVo/3iK6FOUXnr/O2isSYe9Lpz9a6JmR7sFAIvU7i9g9ZgLtTLqmKo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLB8WqktatHemBYDU7H1FQ8BXPuHExONcnEMVpzt4VEBSbN3EU
	xYr6CaSqa4IRjilUPggbQDDJHIPXbx6QgyArUI7lxO1TgH06A5eOTDyfKFIWVZ860DfsrYiDGkL
	ee1iAKdiITwGZu6vp5ai03WcuJsTDj8Y/ayKBCM3CxxY9EBiw8ZXqc0A=
X-Google-Smtp-Source: AGHT+IEHgdVuUC/z1a/LkA5OKjqqL4Sx8PnCwKyASjI355x3Gc98kioyAfDs1ucUCdQjnGFAFDasJGkRpzG3nfYRVBgem6jRV2y3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3f91:b0:3d3:de8a:630e with SMTP id
 e9e14a558f8ab-3d5961b11a9mr108469995ab.16.1742776266165; Sun, 23 Mar 2025
 17:31:06 -0700 (PDT)
Date: Sun, 23 Mar 2025 17:31:06 -0700
In-Reply-To: <67dc67f0.050a0220.25ae54.001e.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67e0a7ca.050a0220.21942d.000a.GAE@google.com>
Subject: Re: [syzbot] [mm?] BUG: unable to handle kernel paging request in vma_merge_existing_range
From: syzbot <syzbot+20ed41006cf9d842c2b5@syzkaller.appspotmail.com>
To: Liam.Howlett@oracle.com, akpm@linux-foundation.org, 
	brad.spengler@opensrcsec.com, jannh@google.com, liam.howlett@oracle.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	pfalcato@suse.de, syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 47b16d0462a460000b8f05dfb1292377ac48f3ca
Author: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date:   Sat Feb 22 16:19:52 2025 +0000

    mm: abort vma_modify() on merge out of memory failure

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1415fe98580000
start commit:   586de92313fc Merge tag 'i2c-for-6.14-rc8' of git://git.ker..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1615fe98580000
console output: https://syzkaller.appspot.com/x/log.txt?x=1215fe98580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2e330e9768b5b8ff
dashboard link: https://syzkaller.appspot.com/bug?extid=20ed41006cf9d842c2b5
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1196f3b0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17d3dc4c580000

Reported-by: syzbot+20ed41006cf9d842c2b5@syzkaller.appspotmail.com
Fixes: 47b16d0462a4 ("mm: abort vma_modify() on merge out of memory failure")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

