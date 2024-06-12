Return-Path: <linux-kernel+bounces-211160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6268C904DDF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 10:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 087991F22999
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 08:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B1116C869;
	Wed, 12 Jun 2024 08:16:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B1116C847
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 08:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718180165; cv=none; b=goEpptGDNhDkQSqGlbVxAZsH4hobWKItW5D4bQW2mjnJmNzbkKJqhRneQv3FcxeF33ndvLz6hDbXjFZMFlbC2UNAdGQbVpLL+ZwR3yIrn3uFje0ejB6Es2tQHn6IwrQTMoJ5OXTwwCV5W43QcyZBeuJQtVJ7gIzoATr21Pr1Njg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718180165; c=relaxed/simple;
	bh=pPrvKPgkDZlWmW3RWQ3jPwaKR+JarvmNteOJQkBEhfo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=OCkP2VE8s/qpi1FA3IKeYKBkVp3vjIkdNaF+Lpj7kZQE4fD9mv/MkaP9eNie87yUP8f15Rb0BzeQhoLd8WU0178sGv/dOoShehv9vdmi6C6CuNLKceZuJgzo8WxiavWtR+HhbOnnCc25v3wmn27b6c+yQS6HcYkHiB/WtdxlVZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7eb5f83ae57so53263439f.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 01:16:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718180163; x=1718784963;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y1f5rG0GED7hvT8RoLEV2fCcFFtkEFl6Mt4qV1QJ6eU=;
        b=G9Z83Q7jFXv6o+t9Nb9i18MypLk8WqVp7mbboPBGJLgjmzE3NKqTfWHw36kFcJPYC5
         N2x2XPPjheS4BKk/P1u8zCdtnQGpxXg40X6B9SsYGjl8GBoTFb6U6FSCzXMHxxBVGLfX
         IzoAWvZUXDGUrwtupOjt5mzxoPGe5sgL1SLkZ9tteSK49Byh+r+PcanCJlLTBHnn1t0v
         aLilIowdnVBIGWSsGAs4CB/B/dVCp0vDp35QpGqREzQc0pTBMNciRywMlyE/iJiyHYtr
         5PQGX0bRU5jDDZSFJR9ldGyeJs25rSlKKUfWn6tsB9A3qmEezlNtm/EVPj8rtx5sIRfT
         Misg==
X-Forwarded-Encrypted: i=1; AJvYcCVOe0GomgXk4qorA290yQl0pFK326uyKdr7Zsys3aoEWgCijA/CnHUe4hStDIlzgRqaocoU6EjOQuV1cca1ZfnVSqkcgP4eg2h/x7Kh
X-Gm-Message-State: AOJu0Yxh9vC9SRV7xHtnbGTARAlS0b+GAl+D0/CwiWlQ6HIEsCtEckqg
	uq/ycEAlIc/D2BEAt8zF1bmBXdf7rJ4beBVU/yWg6510nHaGvvCpcAvumAkiQEVi8qPryi49cno
	vN3ANE9oBIoeM7xESH9aBxOxw8YDxGzZCaDH0G1PLnxaT3MqyNAbk+8o=
X-Google-Smtp-Source: AGHT+IH1pmZW+aPomxFxxM8K+Ihu/XmrpFC1QDfZ61+kNLWyxohZU4bRxTOt55XTXCfWFxlqQnTC7UfkBnJnWl3awsnXbdjTkcIq
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c509:0:b0:375:a55e:f614 with SMTP id
 e9e14a558f8ab-375b30c7b51mr809405ab.0.1718180163076; Wed, 12 Jun 2024
 01:16:03 -0700 (PDT)
Date: Wed, 12 Jun 2024 01:16:03 -0700
In-Reply-To: <ZmlSXfFAw-gWfJIG@localhost.localdomain>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000047d686061aacfee0@google.com>
Subject: Re: [syzbot] [mm?] general protection fault in dequeue_hugetlb_folio_nodemask
 (2)
From: syzbot <syzbot+569ed13f4054f271087b@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, muchun.song@linux.dev, osalvador@suse.de, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+569ed13f4054f271087b@syzkaller.appspotmail.com

Tested on:

commit:         f2a50aed mm/hugetlb: Guard dequeue_hugetlb_folio_nodem..
git tree:       https://github.com/leberus/linux hugetlb-dequeue-numa
console output: https://syzkaller.appspot.com/x/log.txt?x=1089406c980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa0ce06dcc735711
dashboard link: https://syzkaller.appspot.com/bug?extid=569ed13f4054f271087b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

