Return-Path: <linux-kernel+bounces-220386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B48390E0F5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 02:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6F0CB21EB3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 00:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3834A00;
	Wed, 19 Jun 2024 00:39:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711003D8E
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 00:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718757545; cv=none; b=OKlmANQ6nc3IN94c/tGEfTKu32E5r/fDTQNyl46BGqE38S6+HQ8SUcW8QuhvHaDBDU84TXK6YXgAiRbixbnCNvUXM+GQNky39Qkl6AaByoSPG1761J/By7U3XMgl+ytHah1OLzVfC5zF2C3+WKZOYpHFdwNaq9Ah/1uk+t0PSsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718757545; c=relaxed/simple;
	bh=R/ujZUQ0yfzYCIKlxlKXisffFJc8OyuiasracCE7gxU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mGN5ozO/R65oRHo/YpMJedI/50caOf8vxSzEntZXNLfLuD358P1tcQlopVgaVg6cO5ph4egBDqismUjCY4Zdup/mnXRYMRAt5vNmL0urTBCB14OHn3OKBlqpaCd9y75xyVQ8UZVUx7qmKoOCGelr6F9wskvuA7Has5p3YmJnpaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-37613924eefso10680335ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 17:39:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718757543; x=1719362343;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TiP19JjO96y9gnNqxRh6FYjLm0cNcebKrqoyPEOJlLE=;
        b=A0tdV5AP76RJEDA1ukvbPkOnwl8rJlizyp+b4xOSEaFxcVpJDcVOb9Y82pOF4mpecA
         95QKcZ+RBXLoDmcJQH31WwHNLuIGwmNXTXvXlAmbslrE8WlJb8ByjqflA1cWHW9VKU6A
         +3MXqMx9Svb9EJeV/6W/IxTQZcCGWmgXDWMzSxyMqO2bb0EjQtVspSX1sDq1oeXY/C95
         DSjKWuZMmgl2L/YDw/1qQM2NeB9i6FCDnsi27LzuxQLbqAVeaUmTAXTwi/D5i0giDYs4
         2SVsfLI3zbY/vItk2fsPKB+QaY6tdqYmwFuT9kJy1Zb4h0H8ButdiGkKw2DDIOu+q3UX
         JN6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWtFmV/UeIVvmVXbMOVZsqaMW1D3/jsglL4dsYOBkPwibEsCM7YWJLlsixhEPI8PyI1IkgXJ7U0sW+oGi0tMhJzHj89opqMgE8xBeLi
X-Gm-Message-State: AOJu0Ywl6Idv8KAr10t6/5Osy1l6TXdGoPRyzMzTPuPAMpOzuNmVPmnX
	MYYTnbA4uW+Nr9dCL4ifF0c9w+C5NxG0cLn5YBa7KPRitjZBqWQGdMFpR8VCGNfUa+gixnQL/n3
	ahxiXMr/sZHK3yGw//YYiVOcBdc6G1A7MkmynthJZs8NUtZlo4ba/ntE=
X-Google-Smtp-Source: AGHT+IGcZdBGqWhV8Uos4C00EwNZ4XyMf80/bobEn0z/4yQQuvKmNqF2PyqldnZdxG0SY9WQhezVSqBQUAv/q5Z5GugM/IK8Dc2R
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:178a:b0:374:9a34:a0a with SMTP id
 e9e14a558f8ab-3761d78d33dmr745805ab.6.1718757543527; Tue, 18 Jun 2024
 17:39:03 -0700 (PDT)
Date: Tue, 18 Jun 2024 17:39:03 -0700
In-Reply-To: <tencent_000DE025D70D8E120A5DA8DDBD19064FAD07@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d65521061b336c06@google.com>
Subject: Re: [syzbot] [wireless?] BUG: soft lockup in mac80211_hwsim_beacon (2)
From: syzbot <syzbot+7e51ea277ea81fe6935d@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+7e51ea277ea81fe6935d@syzkaller.appspotmail.com

Tested on:

commit:         2ccbdf43 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=12421bca980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa0ce06dcc735711
dashboard link: https://syzkaller.appspot.com/bug?extid=7e51ea277ea81fe6935d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10b5bbe2980000

Note: testing is done by a robot and is best-effort only.

