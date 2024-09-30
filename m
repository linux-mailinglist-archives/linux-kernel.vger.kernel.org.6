Return-Path: <linux-kernel+bounces-343254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DAEAB9898A3
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 02:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 969E4B217AA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 00:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B242CC13B;
	Mon, 30 Sep 2024 00:02:04 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E8D6FB6
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 00:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727654524; cv=none; b=i3nfIaQDy6FAZDdLVTVAQGuUfsyxwG2pvvdRCIYvop4uqIn1mzb88Rlomxx43t5DGSwdBc3Q2Xz1+fkcrXnY8hUDSgZXqD+0Wo4zlQ+9mCGuXjj4/rM5nCB7Y0daY8eun/LaPoMWp6f7HMc8nVnet/77Vs6hyhByU0d0Vri+dQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727654524; c=relaxed/simple;
	bh=9WigQ89RfPBnQxVrMhhSMc5sdbcvJrNbIPGEqhszeS0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=QDKGD9yLWx0jTy9r8277ixbrvJh4Mm7ysyFv6jo/ajFGOQ4JsfVnbI7K/VR+K6gPDbd7PcWBeQLwb3N5tq5XmknT9GbtxlSe2OgZ3aet7/Eks33iXXGoD43yaSHWXNBlK9bNLVJqSEdUJN8v82WzzA1h/lgU2luDPl3HYQPHB9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-82cdb4971b9so369282739f.2
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 17:02:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727654522; x=1728259322;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GqkcY2vcsdnQYJ9bZVRXIIUqjDw8dV5GMcukPhkbAUQ=;
        b=VrSO3a6iawQKOAn3N5SG92X8dQwktcfsG+k9af3UX7LKQR/22AiEdKdFG2UVwKEe9N
         3wZe9+LFXOq7Heu5marQ69Uvrwkx0NCFVc9wx2sETlTY2qYdF0XWey8PVzvOUIQlP/yT
         f6PnOohMJGO7JvMwerLpYoV7Zi8356oniEEmIraLVIrwq6svMKNDbJogsp1nJqSKBqk6
         vjfiSVdvEIqEHNlIQycCa2VJEq/2LInFwMTcPQgf//kwEgGoKUO9weFt9FO88JcCGigE
         kdTqMOS0NZ76Nr233G/jCQOJKGaq6vUQ2kHoBQ1etzeNthXsoS/1sqe2zMLhdXsIbQYB
         1Jxw==
X-Forwarded-Encrypted: i=1; AJvYcCUJ447oNJQLQs5uaFlUVrdVA3UrPFMJeSB3jizaY2jO84YgtaO7rTO4+af9aBu0sf5yuEnbTMVWLU49pxo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCFYuUgVG2pM2mhkOfk18xePfAj3ifw5jcEamVoDXMYkVp/KPo
	hy3i3TqdR/QZgpVn+3xhQTzQMxZMcahyy+fsOU366kMSVVLE8Hf1IjBHUJIJTwL6jAQ5eiPMmeB
	Lfws99e9WtcBSvq0HeRsg62mqQGGjfVgX3Jdfp22YEE9B2An3sHvxJSw=
X-Google-Smtp-Source: AGHT+IGb3O22JtuXscIgXzC3Wg7b0AcaIhd1YxRgWtwh6ExSsXK4oTCZfN3REuKytKWCRWmYtT49O25v1gezLPf69aWHzH9yQMWq
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c83:b0:3a0:8c83:91fb with SMTP id
 e9e14a558f8ab-3a3451bc001mr74619555ab.20.1727654522095; Sun, 29 Sep 2024
 17:02:02 -0700 (PDT)
Date: Sun, 29 Sep 2024 17:02:02 -0700
In-Reply-To: <000000000000341f5f061d8d6bcb@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f9ea7a.050a0220.aab67.0023.GAE@google.com>
Subject: Re: [syzbot] [mm?] BUG: Bad page map (8)
From: syzbot <syzbot+ec4b7d82bb051330f15a@syzkaller.appspotmail.com>
To: Liam.Howlett@Oracle.com, Liam.Howlett@oracle.com, 
	akpm@linux-foundation.org, david@redhat.com, hdanton@sina.com, 
	hughd@google.com, liam.howlett@oracle.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	syzkaller-bugs@googlegroups.com, vbabka@suse.cz, vivek.kasireddy@intel.com, 
	willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit f8d112a4e657c65c888e6b8a8435ef61a66e4ab8
Author: Liam R. Howlett <Liam.Howlett@Oracle.com>
Date:   Fri Aug 30 04:00:54 2024 +0000

    mm/mmap: avoid zeroing vma tree in mmap_region()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13a44127980000
start commit:   3efc57369a0c Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10644127980000
console output: https://syzkaller.appspot.com/x/log.txt?x=17a44127980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a4fcb065287cdb84
dashboard link: https://syzkaller.appspot.com/bug?extid=ec4b7d82bb051330f15a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=113acd9f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14cc0127980000

Reported-by: syzbot+ec4b7d82bb051330f15a@syzkaller.appspotmail.com
Fixes: f8d112a4e657 ("mm/mmap: avoid zeroing vma tree in mmap_region()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

