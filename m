Return-Path: <linux-kernel+bounces-216186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9FA909C70
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 10:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BCAB28171A
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 08:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1CB6184122;
	Sun, 16 Jun 2024 08:12:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D14944F
	for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 08:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718525525; cv=none; b=rR7ErpPbvWfU6Hvs1WE0AtoH2jTmya6aXTuhCaYzayZJYG5As7SoW9udG2E4xA6tPQrsDAKBIq+daI0tWfSaMwvIOqn5qGCXvjkZa94UbEKjea9PB0vbpakT6pG6VRcrYYongE8vZ7l+m495zpGkpPzy6SYJ5hmfEKUeSJEdRuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718525525; c=relaxed/simple;
	bh=jhW8qEONCVshEHx0xZO74hdsuVgHxCX7+H7nSeODnsQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=andGDcKpZ2mrVbZ3vLE6PJwRES5kXV7JYq7UVxiCVheotBFieAMu+2C2z/yZMsZyQPdm/arvnUomw2c8z/ijYdgWuZKvNYoAcdlwd9u3B6IkjZpXcOEX+FqM9sQh5ubtTieYvTS0/Ckhb7m/HAEDSSgZs847fkKnA+/iP4BkJ0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-36db3bbf931so35960125ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 01:12:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718525523; x=1719130323;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TzQqLJe0Pb714R8KL4j6bCvLuBW+f/b6nT9prX185Ao=;
        b=HYnorwVoOvyBuO8E2UJmYMiHH/LzFPBeB8tmTPVS4ycGIzK3rXZORtlLUGC6knTYN/
         gv+dzT6hNyqkskppJf+e67ypAxDj027YDG3jLsP3eHuLR5BODla9pmkylhfWfQnaey1G
         bEuSzgXhXD3MgMHVw+57USwHs35tcZSfCazxKwGzhS38uneb1B29s8fZCO3gsq+LOZxy
         N7d0zAMHC0JPYDZ82PuvIvECubO71puvS0/0pgNM4FNaaZkq+47hOqVxa9sbyWQlVxft
         MoaRVoyQDVqBEkTVgmvw0VCyegN464xy90oJs0qEWbKm7Gi0orLbwJBnxqJV53y2Mmbo
         ad/w==
X-Forwarded-Encrypted: i=1; AJvYcCVrCnKoQAXmgOcsyYbMiJE9ofqm1N80f8NbxIzKiNNHZXa16/Wec2F2SpDCnEF1ZNlR2G+SH+/mpCuI9czzwFeGQTNPZLT2QQQJNwLA
X-Gm-Message-State: AOJu0Yx4nIQgIARXP3zkzu0lsYSi6KWIUgsTeIaobGEYH3+j/3HgUoC1
	B+UfwQTnroRssxfD+2SeqoKoCcQ2fZvL/LFhdVh6Oq6gi/Rvm+5DyUkhv7oihoR2aZmLk8YAgGE
	n4Ess5UU14HEZDIwNEcJ+y1Q9hr2Pzb/7fRzyaIvZ1eibosskmoKA8iA=
X-Google-Smtp-Source: AGHT+IF+yM+e9N2hcdB6WmQAsasQnp5hjg9t+OFsRgOdAMFja/LPflsCdNNg2QE+cNPGnvuazWB4+RlrLnq1mV0LvkUTDj3OIKDM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20ec:b0:36c:5c1b:2051 with SMTP id
 e9e14a558f8ab-375e10b24a8mr5388435ab.6.1718525522957; Sun, 16 Jun 2024
 01:12:02 -0700 (PDT)
Date: Sun, 16 Jun 2024 01:12:02 -0700
In-Reply-To: <20240616063256.1356-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005566b3061afd6778@google.com>
Subject: Re: [syzbot] [ntfs3?] KASAN: slab-use-after-free Read in chrdev_open
From: syzbot <syzbot+5d34cc6474499a5ff516@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

fs/open.c:955:23: error: call to undeclared function 'real_mount'; ISO C99 and later do not support implicit function declarations [-Werror,-Wimplicit-function-declaration]
fs/open.c:955:17: error: incompatible integer to pointer conversion initializing 'struct mount *' with an expression of type 'int' [-Wint-conversion]
fs/open.c:957:10: error: incomplete definition of type 'struct mount'
fs/open.c:959:7: error: call to undeclared function 'mnt_get_count'; ISO C99 and later do not support implicit function declarations [-Werror,-Wimplicit-function-declaration]


Tested on:

commit:         83a7eefe Linux 6.10-rc3
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=5a05c230e142f2bc
dashboard link: https://syzkaller.appspot.com/bug?extid=5d34cc6474499a5ff516
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14863bca980000


