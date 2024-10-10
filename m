Return-Path: <linux-kernel+bounces-358240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE045997BD7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 06:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 817FD1F248F1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 04:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352BC19DFA7;
	Thu, 10 Oct 2024 04:32:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E033839C
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 04:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728534725; cv=none; b=Miu7UTeog1PQh8cq6xsEJPI9KwF7wLceEo8c1KV3TyyJmLCuRUeFeusZ3QYO7aTGOyfqmNlz2MA29FrsPYIdVqmeMYuwwcjDczjhIf8AAX0AMMsI+gnyxR5AIJ0vSUtlynYpIWXeycmsKxDRMCl7k7nYvmNVSA59N+PDLHAeozo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728534725; c=relaxed/simple;
	bh=5sD1af4gith+Awmmh+0wJpTaScf7C5Zm8ofdPZIX8NU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=hj9BZ9WlODCrT+lC3XvfT/KTTmHGUr8/hUMRgULBC/GhluXM1nIV/hdQFfUzv3D+dUWiyLLUy6Yf+KTNx5ZvbgOnM7yMnDsU1ulU4Hxer3hw0YmYvlWEn/690W0tTTYXYQRId+loOLJ6jbJnIxuUuCRDUH86D3IqSuiUw+bqkqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3479460f4so5027545ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 21:32:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728534722; x=1729139522;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XMpDAUxgPVVo0KWf9TTglqsCqzidS2Z3dz80X3V+fAU=;
        b=jvZWO8l0iaRgSmT8pRQutZLnXWpcdSDm00V9cKb34D6vYjTPVSaUNSBa5YwxjZIOf0
         bztRgTMxgRlNpX5AJWZrgA9v2c+bZPzitMDhPIRvJ6sh0g8GXqv2z5yNocjDEOcbERug
         OOJGaIytNj2o7dmunxfiHUXG+Ey29wQStxdeV9zqy3hhlWWu5N+r/VwigDcQvGoCrsge
         pftRdhr+5ecgLX53r9s8Hj0I2BjgE56yBGcOz29V/LREOqM+qA91aSNk0A4/j4IUd4B+
         PmoVHRetXigG9G9I2VVDWqSxtGSJXB6RHC1wGBfk0+t5dW+mc0xVMYIYMzGmTAQb9p5m
         XlqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCgIemycm5yXL5sozWC4DdR1a3nyvvSncb5MnGMf1QPbFwtw4hJ4yAbxnSdzLZJSBmJWdZZWUVx7NMvd4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK5dKmvgwGqYuiTCjpNhtcM3OgVFg8jTbi3wq71dfDhrPEbZ5x
	p2bNg6vMoOw5/gFKg74J4UY4py7LZB059xldlT8kuJ9IXu0FBWPg+0L8TbLp9G6L1/WisI7zUMa
	XRR46veQMqNQcqABodi76GsiXHBmmVu6WzjZdQm/OgjANkPLMv2eFXkA=
X-Google-Smtp-Source: AGHT+IFistMOGGyGr6Z3Ds0d2bojp+sLNDzqS4U7jqigj9B87caqrsghgcRN5OpwYBqK1sLvc2+M2nl9C16/nocKgBjYPH2VY0kO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a69:b0:3a0:9954:a6fa with SMTP id
 e9e14a558f8ab-3a397ce58abmr37847415ab.9.1728534722587; Wed, 09 Oct 2024
 21:32:02 -0700 (PDT)
Date: Wed, 09 Oct 2024 21:32:02 -0700
In-Reply-To: <20241010040835.1648107-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670758c2.050a0220.67064.005a.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] KASAN: use-after-free Read in __ocfs2_find_path
From: syzbot <syzbot+66c146268dc88f4341fd@syzkaller.appspotmail.com>
To: jlbec@evilplan.org, joseph.qi@linux.alibaba.com, 
	linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, mark@fasheh.com, 
	ocfs2-devel@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+66c146268dc88f4341fd@syzkaller.appspotmail.com
Tested-by: syzbot+66c146268dc88f4341fd@syzkaller.appspotmail.com

Tested on:

commit:         d3d15566 Merge tag 'mm-hotfixes-stable-2024-10-09-15-4..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13f3ff9f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7a3fccdd0bb995
dashboard link: https://syzkaller.appspot.com/bug?extid=66c146268dc88f4341fd
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10784b27980000

Note: testing is done by a robot and is best-effort only.

