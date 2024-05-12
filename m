Return-Path: <linux-kernel+bounces-176926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C935C8C372A
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 17:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27551B20D83
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 15:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D104044374;
	Sun, 12 May 2024 15:53:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C13C18E1C
	for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 15:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715529185; cv=none; b=V8tjKGQahm4TBAJFWyVGWMTuY6IFwdZ8GSpFiWMRC8U+TuNcJnwzqkm0XkG2E+HKLYgk+y+KqV/vGqWtSNmxjJktjE46s5vwTELPMQRGFeqlO4zrA7wVJmjpi6lYI9iJMa6I+0NWZd4JgMe55uOCtIOKwtJddjPcDCol0AR6O2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715529185; c=relaxed/simple;
	bh=MR7RgR5zzXCSjbmAiGE0W8O5HPIEFj1M8jAo+fD3A1s=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=sLZAfC5QxUTQYPLmMIO+vTVoXUvowOUhnDUJvdfKLjopRWaQP51ivRsbGvyqkknc5K9ZnIKNNJgNQzKCh0Q7cbZafCSGLky9pgebkVGtsR4G7a/XanpTdO0shhPQ1Dy/wJuAOxYYSFkbGuu3mlcQ0DFFP0tjy/v5P58cHpSZ58Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-36c9d7ad3feso40030495ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 08:53:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715529183; x=1716133983;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nIK1oBGA+zLeKkYi75NEBl7+sN0EIivbXtwrb4tjuMU=;
        b=py/pqhdDr2xV8pDtAy7LQdElPC1Fd/r49qNDLI/fH0929k1sIqDnBTPUbO0OXkk91C
         2y+1d3s5YTmqxHVolfH2UB/r/A5eV9j8/qrx4sOzYCqgw70Pie7L1tb2z2Gt90eK3dJg
         7p6KEO3pGIWZIJfqK0t30+fkSaLx7tOm0rFfTinxljceRNVSa5hm4rfK/zZvqeBwFN6f
         bBWMCtPuUWywpSILF7JuZEHOgh8pGC/9NUgOvhI96L+MEkcNgTbDNlFlQ1kwQeNZH0eu
         Vlz1Elhq2A3H2XZOr7A7UOlzIWCSsqQJqMJKK0SVLVpbjdi9eIQkc3zTxLjpzkePWUkA
         QbFg==
X-Gm-Message-State: AOJu0YxGMmJ9JBuHHBsDYGFZONuiCrOW/M7Sd4WDDzYmg5kfyzS+YFwq
	RDo5q8QZbMQn6EFRWRgPoQk9M6gvC4qG9UAja3oMzpSY5WqU9vsNWUGU8o/c5BpuVe9G0i4qk58
	3YA3hXhPbLdKHHpDBm9y3bNAl38dRGNYhcXYjZgYUZYLMjWH0VGfpBYA=
X-Google-Smtp-Source: AGHT+IGM4sVMtRUzv6trVZFqnPrkdPvL52TVHN9+Rsrhdu2XFjA9zWGMmBDz45KFMPargnhTChoqlcCaygpIZhWloOsGMgHVncAi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:d70c:0:b0:36c:4d81:8656 with SMTP id
 e9e14a558f8ab-36cc13802camr2298845ab.0.1715529183328; Sun, 12 May 2024
 08:53:03 -0700 (PDT)
Date: Sun, 12 May 2024 08:53:03 -0700
In-Reply-To: <20240513.002105.2169199038258803822.syoshida@redhat.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000930fc7061843c364@google.com>
Subject: Re: [syzbot] [can?] KMSAN: kernel-infoleak in raw_recvmsg
From: syzbot <syzbot+5681e40d297b30f5b513@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syoshida@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+5681e40d297b30f5b513@syzkaller.appspotmail.com

Tested on:

commit:         cf87f46f Merge tag 'drm-fixes-2024-05-11' of https://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15a15c20980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=617171361dd3cd47
dashboard link: https://syzkaller.appspot.com/bug?extid=5681e40d297b30f5b513
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16e15cd0980000

Note: testing is done by a robot and is best-effort only.

