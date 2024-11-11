Return-Path: <linux-kernel+bounces-404221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9418D9C4103
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 15:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 447BF1F2373E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 14:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2555019F104;
	Mon, 11 Nov 2024 14:34:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF5B19E7F7
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 14:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731335644; cv=none; b=gt0gjw95FsnueYo38KrGxBQrM+QqBmO5Bvyx6W42LExEKUpA6+IBSNVLfzD3yKTUvMUA29ALSkEFAld1YCate9cYXMr50WRU1GmbY8VvxBKb2qB4uE2yGNOEnfNL32Kk+ABFagx8y1n6yDJ4rSSdJC8YR32c2OqECCVCtDsztcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731335644; c=relaxed/simple;
	bh=qVh/1jyiJl0qCPyE5jmMBodi6154i4qU4P1hjHgwids=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jStklX5d/6RcQjzu+apwf57fzthr3uP+uhgrVTIwT7R9Lm51AORE9Bybtybyp4VmFb+KlP/4r7qTgc/6wfAXqLiAyvl1WiW/djdJznYpDOx6J+qmJoXQ/IAoesiROwpGwey1XeEVUUb6vvEOPQjQujyHSRmmQKL9+DVIO0svTtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-83dff8bc954so395512239f.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 06:34:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731335642; x=1731940442;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jQs6eYmklB/bHxyHQMxr6RdSnEGF3AKvVeJtW0c9JAI=;
        b=htA4GoItws5fmSZiPUI7byYpjGnFaJkAESvP1youmMmvHVogfwZhhpk2htVuLJyN6v
         Ghocdv51/yYOuDoJj6a/jmOH5KQD2s8GVIm41QtihI462CwCR3U0QKSy7LPI6AY79HXo
         xxH8ChKjkNjybKkBLADtyUD8R6fAiDTKWO/H+l7OO7a9xnlGqtZnq7oueOUrGxiEGESx
         E4EwHoB/QkS2jvnE4IKU0NrmAiq11udN8k1NrVnSwMWxMnCbGsneKK3mMju96f8Uh6C7
         hLLhzF2tCSb2VbUU5iWIgKhluwfKKoaMtzl+kaYvSOhrFEhG1n8ArxounpVqNcfYjS4N
         ns/g==
X-Forwarded-Encrypted: i=1; AJvYcCWcNqCEQlx6qO4uetTVVxqMRFrZLtgZRRpnvQDMlsOnCJd7z5dg+uIVa+nKg6HjCQWF+NMaxLrEh833InE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzkvVw3VEmjiQmmH6t4vmaBRdsxzCz58zWYjacOZOIEqZBIox2
	y19dtmqsMUe88jCgWUH61iW504r530EjLV2bhnS7AuJkYO9RDg24q2N1WB3KhMjay6wgNkZ3VH2
	dh9ESfq0WZ0a8dFotBk3K/ojEhGRFPGD8kUgfh49yB8diinZWZl/TnFc=
X-Google-Smtp-Source: AGHT+IFgtEuadfZyf35o2zxEyo6J4SJaxSMk3ocmv71u78GxoTDxOMZUE7kTCKQu3nAPpcPSZBOjM8AfDMpv+2oj+UtiJqqBeYxa
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:178c:b0:3a6:c27a:6383 with SMTP id
 e9e14a558f8ab-3a6f1a21ea2mr143329295ab.19.1731335642363; Mon, 11 Nov 2024
 06:34:02 -0800 (PST)
Date: Mon, 11 Nov 2024 06:34:02 -0800
In-Reply-To: <dd56ff53-672b-47c6-b831-78f1c4b22e17@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <673215da.050a0220.138bd5.0087.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] KMSAN: uninit-value in bch2_copygc
From: syzbot <syzbot+8689d10f1894eedf774d@syzkaller.appspotmail.com>
To: gianf.trad@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+8689d10f1894eedf774d@syzkaller.appspotmail.com
Tested-by: syzbot+8689d10f1894eedf774d@syzkaller.appspotmail.com

Tested on:

commit:         2d5404ca Linux 6.12-rc7
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1724b4e8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dcca673786a14715
dashboard link: https://syzkaller.appspot.com/bug?extid=8689d10f1894eedf774d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=131d3ea7980000

Note: testing is done by a robot and is best-effort only.

