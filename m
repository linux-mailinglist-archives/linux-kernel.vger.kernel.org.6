Return-Path: <linux-kernel+bounces-420533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D24C9D7C0E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 08:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5255F281F7E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 07:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735861885B8;
	Mon, 25 Nov 2024 07:39:04 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B98F17557C
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 07:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732520344; cv=none; b=ZIGgLjfIK50DpL1qUnDwuUtXAEmPHhJu0vUUoP+dF5hqeSTOwrnux1xLVho4m2bv1XRQ/cfpXnJG/xzuwKDby8DW3BP0qD0pcQqLsPEbi9IBsL8E1X8zToLzzhjts6Q9CUt4yLrr7TZTfRTsY0OtIOpHOInEIUPB+V6Gnes2fwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732520344; c=relaxed/simple;
	bh=6+hTZx611cwepXDuMRugYLmt8RK8/c4mWUmn3VPMFXU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=bEFUb+6ky+UefwxiilcT/9/QTL0X+gbsMhNSPUA/xp15jW5HzLSaByAJmN2k9pFzRrpxuCd2X4JCBud5V1G1N5x0ooTfZUEz7pIP7B6i4TYuypX1YYSTwBbbX1vaub+tesa6hE3r2FLr5rwLB69AODU2+M+EZie5WSFPFx/P+UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a743d76ed9so46466805ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 23:39:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732520342; x=1733125142;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/ZC8Lq7irH+WOTsZuCENKiP5kS96TFwYhdOh6IX1UW4=;
        b=PxqIpz1qu9TQXIDfI5XjkTyyIXwCs+CSP3fm6QLxN3atNeh1ft5QdenNBkVNhpTX90
         Bpmzk4v7GSgESN23f72REEC1OGqrX3t38hLoQFMjsfPlVbO3WmRUPGZcvL+fPGXS77Y+
         70qVWFqCr74XPhIM4dQMnkh6+O7oD04ZLOV39aVHIO/HFUQ9nvD7WzurmqgANlB4yMop
         KOP/gVLngXJ0Q6vHHTgwdfljZUQoUHNk7XxQOEi6n5T/CPmd7SU9PtNjrk38uvkO0fCz
         wVdopZkP3HVa1l6rUqUZHGUIhWE3V988p7k0G5zDmSs22NSGGyyAuNSqKW+YxhhHJ2Hu
         lfhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuGYkJlKXXeyZJ4lNqap+YfYnZndgiUzDuCS2VblQ62Yh3Ga62hhoUzO/R9znqYqXdZaVNShz0+zeEiC8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtwHNGDQFykzqiD33o8ceEkQ5jZ/EC/e3WlmgHDb84Gd0z54Rm
	6g5PSdpB8G8kO8Pwqk/yDthuJmxJ6yOA5csG4Vtj2CeOwobaEnwgg+dx7+/q22OF2GixMCk7clk
	T5AlWUXokgIzkoH65m6HQacL9daAFiY/W5NWZcP5ldAk+Saaveoc4WEM=
X-Google-Smtp-Source: AGHT+IFP2V/HH7geGTK/SLDU+mRkKynqboKTfkXQ/jQfwJY9OfvWtcz51ygHJ7QZ3cA2j4feHK+uE7HcolBPARU74XTESy9mXcbX
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1487:b0:3a7:abdb:4a37 with SMTP id
 e9e14a558f8ab-3a7abdb50aemr45617855ab.8.1732520341902; Sun, 24 Nov 2024
 23:39:01 -0800 (PST)
Date: Sun, 24 Nov 2024 23:39:01 -0800
In-Reply-To: <CAHiZj8iT3F2NqkDd3XqLoO5mwU4VKHTa_1mJ_f23BmKmiL=T0g@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67442995.050a0220.1cc393.006c.GAE@google.com>
Subject: Re: [syzbot] [mm?] kernel BUG in const_folio_flags (2)
From: syzbot <syzbot+9f9a7f73fb079b2387a6@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, surajsonawane0215@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

./include/linux/page-flags.h:309:29: error: implicit declaration of function 'folio_nr_pages'; did you mean 'folio_page'? [-Werror=implicit-function-declaration]
./include/linux/mm.h:2056:20: error: conflicting types for 'folio_nr_pages'; have 'long int(const struct folio *)'


Tested on:

commit:         9f16d5e6 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=c4515f1b6a4e50b7
dashboard link: https://syzkaller.appspot.com/bug?extid=9f9a7f73fb079b2387a6
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=130c2778580000


