Return-Path: <linux-kernel+bounces-215128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38702908E6E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 17:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D04CD1F26FB0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 15:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D294C19EEAA;
	Fri, 14 Jun 2024 15:12:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0270A1591E8
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 15:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718377926; cv=none; b=i9GLJBKVF/c6af2iYu5Zm63iBqjuV4AZp4wzHBrTnD21hhwJpZDriIcWQkQ6SX5ZZ3gt/z3PoJr0VwbmlqaeXOXiz7UupjWpseb8qZxPri+wn5zvB2ll+RsQteJjvNUmTHR/q6ALhwMwTMW9LOxcaVnt5IAsNqrDMn+KkdmuLOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718377926; c=relaxed/simple;
	bh=WA9eF4aFUmGOn2/rAqgJw81QSpgFX3j3W6TwJr3/tso=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=t86eWebQzbJVG3scHdXZeP0QNZiPJGEL5QVSx0phDqLAJj2ksBho7WsVHFpfGQ85D1uY20p5o8cL+p2oezLgYmCbISIHxuDddZrZ5N38ESjGSr6gPTW4gfP1j5vah41RA7J8ZXOUYx16heyTBbhkf9o9ZSRyUw9SncZa/eAXzCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7eb01189491so234707639f.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 08:12:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718377924; x=1718982724;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3aMWb7tECFGDpAPMNvFeIdKXjLME0w11YsrHUd/lwd0=;
        b=hwsYdGnPY8rzR6DNZZKGfVcgdREy7uvC9FjoLg6pdIccr/s/jz5GQrr11GGW7CvnjY
         1q4yyaVvbUfw0J9w9IcSFcicN1LJyr6txMvKnYeiRmayoBC3b8vSii1fveEAqWH3Jt4R
         QxiyOQXPALzzOAxliBOBCejGonwFmffuSYaaJP2j4yRY77weNXzIdI+0grAvGHLDbc4u
         lGj7/UaCHOpM1XxbGgPbc/95l/3uTAvnInZeL5KNVTXFjTLhSckOMLcLaOj5SN0wIFLB
         61ir5YI7YrdwUR03KmkXABHwsHl2xHFecJRPyapHBRKRIw2wyWnefO3+jmHY+iz80EW5
         MeKg==
X-Forwarded-Encrypted: i=1; AJvYcCXaJhVYfhz6xpok/BDT0fwv1x1zQDsY49/HuSV8/2VZRLBFFBTpnCYwjOQOG5KoDDnyANZ/S0nLtYcBzy3BEW2rv0vzaMa4aHefHGB5
X-Gm-Message-State: AOJu0YwebhVdgezC6UM11BXB+PPFhxdNmce1RCGIPQqhSjZSgKZfUbY5
	VCfbpl1KlKUf8YGni+OoDQYlOiifcx0iG009JIedIvAPARFfq6LmIG5fd33vUpCM0n6dohSV2i3
	USaoWhrwXSx7FEnoJPT3kJVaJZJSowR98CarjAESeLvebYExByURmQIo=
X-Google-Smtp-Source: AGHT+IEV6durysYl/+UjBHd7ObDBjcTOq+0cFhAipbBhJsV1ZV6SahubxF5z52T5uJzDeRW/hAA+jaUlEyJqUgTagdQl6GfTbAe3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:14c6:b0:4b9:32f8:574f with SMTP id
 8926c6da1cb9f-4b9640dbfcamr91887173.5.1718377924176; Fri, 14 Jun 2024
 08:12:04 -0700 (PDT)
Date: Fri, 14 Jun 2024 08:12:04 -0700
In-Reply-To: <0000000000007a211706185338b0@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c2c1fd061adb09d1@google.com>
Subject: Re: [syzbot] BUG: Bad rss-counter state (5)
From: syzbot <syzbot+f2bbbb592debc978d46d@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, baolin.wang@linux.alibaba.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 1c05047ad01693ad92bdf8347fad3b5c2b25e8bb
Author: Baolin Wang <baolin.wang@linux.alibaba.com>
Date:   Tue Jun 4 10:17:45 2024 +0000

    mm: memory: extend finish_fault() to support large folio

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=106e8e56980000
start commit:   d35b2284e966 Add linux-next specific files for 20240607
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=126e8e56980000
console output: https://syzkaller.appspot.com/x/log.txt?x=146e8e56980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d8bf5cd6bcca7343
dashboard link: https://syzkaller.appspot.com/bug?extid=f2bbbb592debc978d46d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17f57a36980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10a57696980000

Reported-by: syzbot+f2bbbb592debc978d46d@syzkaller.appspotmail.com
Fixes: 1c05047ad016 ("mm: memory: extend finish_fault() to support large folio")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

