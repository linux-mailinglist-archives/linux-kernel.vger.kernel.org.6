Return-Path: <linux-kernel+bounces-412403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 865789D088A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 06:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 237B11F21747
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 05:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB5213B79F;
	Mon, 18 Nov 2024 05:04:04 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA67126C1C
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 05:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731906244; cv=none; b=UAk09juZNDUUSPRLRLvktAML+4Pz/QzgCjvWeZnUNN6yqo5InbJH1fZNMPFDxDQJrdAthfxO5jHy1wLCJ17NNVY4oFOLWxkoPLWS/aW6yptFOjhFeHwa2Yf3SzglyE2pKZoHXh6a0HRQ+uMLYeG9tD/u052o5yWtE/e9CBiu6O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731906244; c=relaxed/simple;
	bh=3YOsRP3535+0Y4kUZId6zpIW7I7975DuiI78pDu4lGc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=pFydyjWufpOCVLfdQSb1Octx/aaVFGg4fk8emoLBEW5VfEXqo9rcRilXvotPQJDD3KTafYxbYehGODfi2vgJAkohoXsvy23Bmj/v59QSdX2MVyK0T+WBnn+QWE7bz9LheykcUWp3rHGm+gk8Linw1vakfyQmxI5ZDRXwlli/RXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3c3ecaaabso52617645ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 21:04:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731906242; x=1732511042;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b3ro98oDhRnExM3S6tvjei/zjm6ZMmrDlEfXEj06Nb4=;
        b=s6/USVgv7AunQS7MP8Dd+8dLkxAp8ffjXNnk/3Bu8O0kqAukg7Isxrn1w1ueWiaMxn
         ZfP1rBXqLa9DZ/Vxsd6J7py+tzOaJwvGqxICcVNP9CNpCf1nca3OHqOkKvSgHg4DSK46
         u4sts+KiWY9hKY4rSWJ3wq0kji6yBOg+CgzAoXxW5BMy4K2e0WJnRu+9wLfu6azlLbEw
         +ow/Sj4OV2qixDkBd2IS62FHKQ+VSxJczkzQjxwSymnhYJe5XHfWd7Pem4ol+FDXmGJu
         GYcnQxQlbpAOpg5NSWjzkQ8kw1sEv6A8Hc7XnMbv3wze3vmMITEIa+wE3PXvAFq9jmhO
         5W6g==
X-Forwarded-Encrypted: i=1; AJvYcCWcj7mBCIjNyuBzr8J7yiLc/bqcPkEIjNY6a8b6crAwpGlGQ5iLgx8lLRuytzFxU9AZueHJiovu5/vtXSs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+SolKNGZ5qG6Zqwvx65XjS5QXoNm+jz9k/25EhkHMFnFezJ2n
	DGOIFoMvZ5c64swTz5zBdWczR5SPVwO52T7KRogTmZDRik9xnFqZymjBtKFfmdlhDL/CLKdmS0g
	z+mpBTD+TSgxHqRUxi2ng+Z3tALrT1MhgJynPu0zlI8b1CGQNNSNHbBU=
X-Google-Smtp-Source: AGHT+IHNreP0tF1+EJ3nqWa3Gs2L0lOvZF68Lfh1gVnR0YrcX5/Q/iKhwpjRFmMgGsUdd9GS4jIEXoVdTjlI7CbJAhiEPv07DrAp
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:d950:0:b0:3a7:5ce9:dbdb with SMTP id
 e9e14a558f8ab-3a75ce9df7cmr33072795ab.14.1731906242037; Sun, 17 Nov 2024
 21:04:02 -0800 (PST)
Date: Sun, 17 Nov 2024 21:04:02 -0800
In-Reply-To: <maoud64nlrod22uir5u4los72fclf4fc7qqp6fry464gzwq6uy@5yntfhds7nj5>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <673acac2.050a0220.87769.0020.GAE@google.com>
Subject: Re: [syzbot] [mm?] general protection fault in mas_store_prealloc
From: syzbot <syzbot+bc6bfc25a68b7a020ee1@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, jannh@google.com, liam.howlett@oracle.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+bc6bfc25a68b7a020ee1@syzkaller.appspotmail.com
Tested-by: syzbot+bc6bfc25a68b7a020ee1@syzkaller.appspotmail.com

Tested on:

commit:         83dc9151 mm/mmap: fix __mmap_region() error handling i..
git tree:       git://git.infradead.org/users/jedix/linux-maple.git arm64_kernelci_20241117
console output: https://syzkaller.appspot.com/x/log.txt?x=14533b5f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a1eb85a42cb8ccec
dashboard link: https://syzkaller.appspot.com/bug?extid=bc6bfc25a68b7a020ee1
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

