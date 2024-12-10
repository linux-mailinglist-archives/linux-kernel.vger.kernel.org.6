Return-Path: <linux-kernel+bounces-439519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B37199EB070
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 13:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A80CD283D69
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 12:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7701A239B;
	Tue, 10 Dec 2024 12:06:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646761A255A
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 12:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733832364; cv=none; b=J8uEYVWnbPTqlFG94F9Sxz019u2GNlzQ/o2bFpmm1V/BXNbpFT5prHDfFlh8KL6j1esPf9y99gf/ktP2XAtxOXmdQ3HpgfmC2cze9nX0NEu/nzMBZPILT2iLCIlysOvyfcfj3muQx3LQnrplFJNxmRwPl3ZUr4nY/O37y264bmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733832364; c=relaxed/simple;
	bh=RKi9jb1sviAnO0EVFaeeanZb7ZqLexrxVo7v5Qqwebw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=G2imIIrbbQISwLV9FzRyVZu4Rurlmi11BTRAMMA6mxFNKq0cVB8xDbWFW8cVgQxm+zpommx6LDLcP2FXqyTa4t5F7Aw7jtqZ07hrNeYRld7r+vKxM3PrvumgUiaDxdmFGK7w4lPE8FPVHHTtv+AAn+5ON6ydnQnnfs4oIufoN1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a812f562bbso72065995ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 04:06:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733832362; x=1734437162;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OjVFgK00CIwn+MzSIuunJm1zGgkub98K881v/Fsy2nc=;
        b=SlHPnHQOFVHVeih87mMH94sBgyLMnCHCzh80waJ5o1FRXfoCL6vr2pfGS8b3gk9/Qz
         sJn+ov2kTOowIH/BCVPdNpxC/kbPhXhkTOKhfqROsNTwardSvUQaqW2k4gDXx8+L7OFD
         guQ2oy80G5T4ij4Z5SybN8ycLqeMAdt2ZsKf51ZWTuaTSX0mM7dQdXZOkthIjQs5pTGd
         ScTDML3FvYOhxSO3GB0ybt7Tl6wXw3tz1KpiJBOAWy2vpt+bCwEQcNQgcl62qZb5wCs+
         39DGvvxxy9nV0DL4TGUUbnh5iWut4iXQjOt1uuWuBsKfn/KFwqYuLQ80mFmoNSgewsJP
         fV1w==
X-Forwarded-Encrypted: i=1; AJvYcCWzFUTiHbjLVjgd2YjFXkPlvaQFcjOaFXFrtvL48lJBz/1ahZZ362E7fUcTo0a4RtC55LGH1hAkWAYKmDk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjf9WcHU9E930y7g3QuQtGBv14PV9UVtQEg1Rep7C5c5nphRJr
	oHolbq4IMp1lHhIZKuT98lPQDSXhvBF6Kqr2D8SgdU4QxJ79QKpRzVH+oAaT9iEW/TxYDzRSI9H
	Lg61UJKmttQFv75Ltv1U2UQkCHy5BjH6orhjguEIvkM6KnPaQDyt+exY=
X-Google-Smtp-Source: AGHT+IEwv/FucONmwEe/44HBa08PTW+mJJxR4RgBStQp/Qn2nM82cv/2LRYzQ1GqnAgZdNwBF/lIGmQoeZZqqkxL7/Pfz4WAj8X1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c89:b0:3a7:e452:db4 with SMTP id
 e9e14a558f8ab-3a811e001famr165884715ab.16.1733832362513; Tue, 10 Dec 2024
 04:06:02 -0800 (PST)
Date: Tue, 10 Dec 2024 04:06:02 -0800
In-Reply-To: <20241210112732.8xyF9%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67582eaa.050a0220.a30f1.01cf.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] KASAN: use-after-free Read in ocfs2_search_extent_list
From: syzbot <syzbot+2313dda4dc4885c93578@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+2313dda4dc4885c93578@syzkaller.appspotmail.com
Tested-by: syzbot+2313dda4dc4885c93578@syzkaller.appspotmail.com

Tested on:

commit:         7cb1b466 Merge tag 'locking_urgent_for_v6.13_rc3' of g..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=138953e8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fee25f93665c89ac
dashboard link: https://syzkaller.appspot.com/bug?extid=2313dda4dc4885c93578
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=150153e8580000

Note: testing is done by a robot and is best-effort only.

