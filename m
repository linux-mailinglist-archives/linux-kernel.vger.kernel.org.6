Return-Path: <linux-kernel+bounces-392212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D4C9B9114
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 13:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AEB1283211
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 12:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CF319D088;
	Fri,  1 Nov 2024 12:23:07 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C298C13C
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 12:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730463787; cv=none; b=BAVjRQDSah7P4q6gZsfeYkVMMuH9984CMYLIt8IG5oFzSh3m0sfaXAa0GR1+erFTZ9x2z19QKYaCW+QS+/z3Lv7DrFfUxWjm3xuHNugvRFWeBb0AMqG6xH8iLC+PU4LO5LucD6gwv/BdUvEaUbTBSlO9WmPsCBIj6o0G2z64iXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730463787; c=relaxed/simple;
	bh=NzGUTuC7dPg5eruSS6ieEOCoa0Zdoe8J51vaoNleIZo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=CJRn5QbVqulRpMQDjhEQFmrYKHw/ulsTiZgqkg2ijV5/6rKoJKaI/lLwB7wg2LNqJqc4Wl4gNoRHT9GhSvFnywNCsDH3Qp/f5Cs8n8P0o3zeAfgPqPBx79dCCgdeU8pfGvTn5CWrck7ILKAIz+uO/Y2bxKD7mibDV9iMjtPy7Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-83aa904b231so178663339f.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 05:23:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730463784; x=1731068584;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5CczRGD/3qqQwaTh5czxj1F7zQH/wFfjPTl4Rxheujs=;
        b=dexaI+IQFhDmI+JmeMCPO60ltD56joHimIRKA64Grv5iRufxE4T4X5hn+2IGrVlUGk
         zgqbjUjbg1jnSksPutDKamoRKaS00JbOAUdVMQuqfB05N3opUWhQ+IB6fSEg/zf1HBnx
         Uh1mF0Lv35imqr7IvKU1LE/LMAvu8dJfHOwlsSS1rqfm55KMWC3iRLIPImtlSi9LLkdW
         2DKSbdhMVjK8Ip1dlvd9YGaDDQzTfBTgwONYIpqI6KQn22ysjIUr1VzzIo/Hy6jgooxP
         +8V6LhGMPDJqiIvrc/0NetY0JMKwTiBq65SvHJUvn/gFk7+PmztEwhvIWniZm+VKDPzC
         AM/g==
X-Forwarded-Encrypted: i=1; AJvYcCXoD6eHuphkjLC7C+rVBF8hkeYqU2hlhdZK331sDCZH6yedvABG4CJ4oaAjxMRN3ev4G5pc4Mou2px8ybM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNNMI9ZtNgmC2GGr/aV1NsrAY9IOQZUOS+AT8HM0BZDLEsO82G
	ikY0bTIyGj+KoayVgsYxNgRq/zZDXwG/UUX34YlM7Icygojm1jd6/pyUFye9LxSMP6EZQSvbFYd
	mR2zHbnRjsLuLT6B66Ka0RLmvre8SKH/ctsvtMTo3JFsZK64Sp3V5WJI=
X-Google-Smtp-Source: AGHT+IFM41bzrPKaWDwiV8Y5ngaaFglTm5iA9T8jxMBb7EvzL0U5tZ4pt+weoStplc6N9Q+pnzoEV5JeZicdMZN0ZllQAiiooXgm
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1e09:b0:3a4:eccc:aa5c with SMTP id
 e9e14a558f8ab-3a609a2afbfmr79437885ab.5.1730463784668; Fri, 01 Nov 2024
 05:23:04 -0700 (PDT)
Date: Fri, 01 Nov 2024 05:23:04 -0700
In-Reply-To: <20241101115715.e3eQ9%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6724c828.050a0220.35b515.0170.GAE@google.com>
Subject: Re: [syzbot] [pm?] KASAN: use-after-free Read in netdev_unregister_kobject
From: syzbot <syzbot+6cf5652d3df49fae2e3f@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+6cf5652d3df49fae2e3f@syzkaller.appspotmail.com
Tested-by: syzbot+6cf5652d3df49fae2e3f@syzkaller.appspotmail.com

Tested on:

commit:         6c52d4da Merge tag 'for-linus' of git://git.kernel.org..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=121e5340580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2cf68159adbdf217
dashboard link: https://syzkaller.appspot.com/bug?extid=6cf5652d3df49fae2e3f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=107fe6f7980000

Note: testing is done by a robot and is best-effort only.

