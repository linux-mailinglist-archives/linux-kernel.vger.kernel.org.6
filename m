Return-Path: <linux-kernel+bounces-432489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 251A59E4C15
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 02:59:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 786EF285CFB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 01:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC1D41C69;
	Thu,  5 Dec 2024 01:59:00 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3446D81720
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 01:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733363939; cv=none; b=UECZH4ldSAYJhlgY5bUrFJpxHvTURXf2i7UWDMIcCZP8NmANvsJAVqPd6LPxFW+eGM6iPSps7qaBneIfWPPjfhk6RCesy6zzhOuaRhydvx1fBHrHJ2fcFvR2L0U67Stx4Doq32PQa/XBWzTBl+fh6rCfAUFd2JW7dUWmNe02V6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733363939; c=relaxed/simple;
	bh=jmOfGx8i6WqW/9e9eV0esQhvVw6dNrC2SZ1/lyEA2QA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=LMXpnA7m9mlM79dG7lfFgw2VvKLaq4Zc5AYE9oZAuRLrRmps2w01+Z5JMpxcSrOXLYjcOnXe7Y8hL3Y7KeNUFrKQxN83y39KROnKV8dxmSKl4P3qeZ2a+H9oTwa5+UoAyRycpdfjDyHibuyO01ytHwuphO8WF/hBY8tH+ytJMMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a78e952858so3192715ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 17:58:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733363937; x=1733968737;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bicnoxgy/OVG1OfhR8q3/VJAcXZClP4+JgLbGeU2LYg=;
        b=wfvglUkR3GeQ1k5B1ThPESxc2vG28fDIS/CfPCYz3o//sNTX++bcTyJs87dn25M4Xa
         t+6S3uzMKGvTyUZvMTj19MQkzf9IQD1K63TVMy2l1ghnYKowk+ThyKpuvPW6N4hV8NyF
         N8fn2T+0YVkPS2l3M9s38A/x0WUzRlD+mm7dzL/y6InRfZJSV7FjIEFckS8CwgHZZeYJ
         +2E4uLRQD3CPQZCqSbiTEjIrCU5pRSqBRXogKNvP4dWyYzipdSTMdz4Es3Z1Oi6HjpEM
         75EC8JoPTwvQZV3p7qZwbdXvvpJTnetw4mhzuYmBZnKZUOXHYLkfohXG8+dS46c+FbKU
         na3w==
X-Gm-Message-State: AOJu0Yzqo1gl887THcOlcWOrxNFlKwzz1vN6YKIEfiRbyPHiDTVNO9NS
	K8hjgjRW5Kj5Rc4Twxw0UzSkz4ztGjX6AdFeT5/LoTUTZhmoxi/5AMUBVDHkubkjnPPl5DddSbt
	BvOi94F5c9H3E6ejt6EzqXslIum1eGcHI3ebXUoJgEG7gMbN4hgWzak4=
X-Google-Smtp-Source: AGHT+IF0NxiUY9/ulFeBSNw5fCCbNFGPgSbkle+X3p/7MD1cQFZYHmeX8Y0I48KKISDfXOiHdpgrOOrwvOX6VnXN6D49Nv60ukwt
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:19c9:b0:3a7:d672:652d with SMTP id
 e9e14a558f8ab-3a7f9a9f8f9mr113095425ab.16.1733363937336; Wed, 04 Dec 2024
 17:58:57 -0800 (PST)
Date: Wed, 04 Dec 2024 17:58:57 -0800
In-Reply-To: <00000000000069859c061dfa7e91@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675108e1.050a0220.17bd51.0082.GAE@google.com>
Subject: Re: [syzbot] 
From: syzbot <syzbot+479aff51bb361ef5aa18@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: 
Author: mazin@getstate.dev

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

