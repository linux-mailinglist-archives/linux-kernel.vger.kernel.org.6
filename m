Return-Path: <linux-kernel+bounces-170131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F878BD238
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 18:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D2431F237A2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 16:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FFB3156238;
	Mon,  6 May 2024 16:14:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8CA155A5C
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 16:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715012045; cv=none; b=j5Cy3F5mYbgt38Mw+A4UKvNb/cp0OnMuECvVZi9Mj3+zmkI+l6q97fxvVm36QCY8fxzgHRUIPgwWwtk8SzU4NV/xCkRr4TZnZTRVt403yCSsOro20bxp7Y3H5vVnOTMSzjNFD5HxDcKTlGqmNViYAe1hFR7sr6rLsSjujST2ZM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715012045; c=relaxed/simple;
	bh=BY9JsAoht7mmHoYih+jIMwCwYIwSSvVTzIKTAuQvSj4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=S7vAtiZ+ti5OL5k4NIqgfgeVEjmU7r2peER2bT/SJ2xnscKkkIZg5KglYx94PCgOxtGGMY8mW6wG6oX/g+BPXeM72YS+W+TXPt2iW8PtL8viDXFmF4v+fyLU21ZylrnEt6ldBW8Q8ILyLk9nI0Xxcw0uIjGaPG8+1T5Sr41y2lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-36c602d713eso25823445ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 09:14:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715012044; x=1715616844;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JDyv5ylTMOTj8BjgVNbgI2llj6hv7/ifg+PovlFAma0=;
        b=jUrIFZ+RkhzG1nqOfrzXqYvVxd5aaFIH+OgyJ9YqA8LEHUCgENDo5nRL3vBCROJ0O9
         xXqWmX6CDGQrc8wB5CBYqMhKSIIKWhgHQFIMoS2wZkYdcD1NhCQ217cjcNsCeOjE/yMr
         s8cKZh7lgA54dHzQidM0u2kSyjU71dS2M5tjYKoIFZu/lmNG/6MGE7NtjMeOhpRr3da0
         QdnHCBxDmTahHmFmKoKVWTJ1gXhhxP3seefyv7KT89D8QRvbgyl5Sww81dGmTb3gLVJL
         vCJj6+KWeGUm7fglUn8NNAtry1kMuT/3NpsLEN5sbk3o8z813PSBl8wEKM96qNnv9OWO
         QOuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFU4ZUz4g+IFPwo43/hztaahee9N9nRc0WOJECjbWKe5S7f6Nf9TYzmgLlX2EuqxR0z0tSzlkqrtNr1PitUcDOs3QLtkiM1s5rieCN
X-Gm-Message-State: AOJu0Yx3NECYjl5cR348lGjKAvCZWuw/k/flNtEiOKf88pl0b/KvpKW1
	Zf1MsOMSMmHfK4E9axRQU30+arIH9js6OyjpE1lIqf6+DZO2O4zXwwty+vCEPKwcB0eaz6zqJrI
	5va2prItT//9QCJk1tBQPnJ+hYZgucECzwZ7SZEZMjjaMko4pEgXrE9U=
X-Google-Smtp-Source: AGHT+IEPpwXwqyDVJ42zLoK/cjm20dXbCCvicn3NPIp4P+XCJKhXUwfB1wnVweKc8Fu3PY/N7phv1M51YXhqAlE3pG47624DFBtp
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20c3:b0:36c:1004:9aa1 with SMTP id
 3-20020a056e0220c300b0036c10049aa1mr509536ilq.3.1715012043817; Mon, 06 May
 2024 09:14:03 -0700 (PDT)
Date: Mon, 06 May 2024 09:14:03 -0700
In-Reply-To: <af1a4b81-22f3-4955-8c44-95bede13a7bb@redhat.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a85db50617cb5b3e@google.com>
Subject: Re: [syzbot] [mm?] [io-uring?] WARNING in hpage_collapse_scan_pmd (2)
From: syzbot <syzbot+5ea2845f44caa77f5543@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, axboe@kernel.dk, david@redhat.com, 
	io-uring@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	peterx@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+5ea2845f44caa77f5543@syzkaller.appspotmail.com

Tested on:

commit:         5f8be0ef mailmap: add entry for John Garry
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-hotfixes-unstable
console output: https://syzkaller.appspot.com/x/log.txt?x=1511f1c0980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=85dbe39cf8e4f599
dashboard link: https://syzkaller.appspot.com/bug?extid=5ea2845f44caa77f5543
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

