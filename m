Return-Path: <linux-kernel+bounces-331357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6315F97ABC6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 09:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95ACF1C21791
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 07:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93BA138490;
	Tue, 17 Sep 2024 07:02:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74FA4C66
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 07:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726556526; cv=none; b=ZfPagVEZWfe3N3JwGkloRhEuvXEJkgjMBiom+n7HwpBlTb9q1ZTJCX+Q4zqNrsujytsKPt1NURN/g4RbJ1ugFxRIpXxt9fHyARR+rhFhw4TYRiX1M/CoA+suP+Dp+gCnfTkW/YyMvrKcgS/MkXTLh5fxC/G9wgFWPRU8Cz9/NC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726556526; c=relaxed/simple;
	bh=jiybRIMyi8xGvF1bSjHqzTbAmdYr5V3NPK3GciYGaXM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=uwLemTq1t+q28aKzRkqlJ24LnbxtrsTJG83yox9GMt1ARmXU7J0hNQ8+GfqbKRfdAaK9B4tNl4/rhy8XbIMLk4dxA1/DoVJyk9xJLjoWcpmusOhxa4yiLvlxAUa3Q9VgxYrl4uigQb+7vFcFtyyBGRYT3R9OUnqF4pSSO7aMvOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a04c2472f6so78847445ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 00:02:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726556524; x=1727161324;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0HSv32HeGpYbI3uL9CkUI9gRqEnD6C5ndl4yRdjzD7Q=;
        b=CrfBzvFK80CmJ1ozkHAt9+BlJ2pI/dLfPEpy0EWyFkcUSwafYZKkoHjNDqyDjSwFnS
         qTxoftyXK7yZFpY0dOa8R7JGiRqATvWIGcz1Xw7cJyPE0kZVuMomo9Z5nKBxUMm+CJlw
         iJ7OADV1e9zWoQkcwQDNqT3B9E50i4312uEGfS1zqzXjO5M6YLBu4c2+GmICgCKKVYta
         RdTLi27d8+7oMwE/BmAZh5ldup8Tlzf/Gm0CsTXpF4W7UlDuE1C1obvmX5u3nleHBMxK
         fAArx8U68gF3nIqaUcgPaERuwpVdmX0id9Saqfq2u/XlGmdM2uLUbe+rm/mAASSva8Ze
         kLLw==
X-Forwarded-Encrypted: i=1; AJvYcCU5Xnupp8B/o7YOw2bu+h3swrInpoUW05SupjjD/G8T8w8GnE2g1dF9WMnzrSjum9ZFA9FUiBICgQvjVoA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYz0GDaZHsV6VD9COFX6SL1Wok2d3g1ojU/3r3/JS/bmK0UXNu
	+DUOjaKZAHaeqy8qQJjE7aYrZSS27iW10DM7NbCAV6FAPX6UBNS1uGugxs+5ovBaZ2Tz3HW92ae
	AVbR58+aO4UVcnXaOdc0nE5s4nXPS7oKJ4xcJzhfPYcm517xklNjawEE=
X-Google-Smtp-Source: AGHT+IGw8MIimOumCcBH/mbb+XShL8ROcJkfpG6tiQ4cOqJf4vE+Ssk3Q/tTlw6EZZn4NTFoq+T7ItW8chy/Sbh4o0NPuCpCuNcj
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b4c:b0:3a0:4c4e:2e53 with SMTP id
 e9e14a558f8ab-3a08b6f86c2mr132203285ab.5.1726556524044; Tue, 17 Sep 2024
 00:02:04 -0700 (PDT)
Date: Tue, 17 Sep 2024 00:02:04 -0700
In-Reply-To: <f58a6956-5029-4764-962c-ffc02602a755@linux.alibaba.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66e9296c.050a0220.252d9a.0005.GAE@google.com>
Subject: Re: [syzbot] [erofs?] [mm?] BUG: unable to handle kernel NULL pointer
 dereference in filemap_read_folio (3)
From: syzbot <syzbot+001306cd9c92ce0df23f@syzkaller.appspotmail.com>
To: hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com, xiang@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+001306cd9c92ce0df23f@syzkaller.appspotmail.com
Tested-by: syzbot+001306cd9c92ce0df23f@syzkaller.appspotmail.com

Tested on:

commit:         2830df2e erofs: ensure regular inodes for file-backed ..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
console output: https://syzkaller.appspot.com/x/log.txt?x=11b168a9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a43f85ec3262ab75
dashboard link: https://syzkaller.appspot.com/bug?extid=001306cd9c92ce0df23f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

