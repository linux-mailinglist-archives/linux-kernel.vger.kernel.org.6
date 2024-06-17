Return-Path: <linux-kernel+bounces-217573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A97890B1AD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 16:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E3511C22804
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 14:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725FE199EA8;
	Mon, 17 Jun 2024 13:33:14 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9D1194A43
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 13:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718631194; cv=none; b=pTNh1Rij8OPlGc751FvYcg803GCnl0NqF65v5gdzndof/8HfjB3VUq3X8+L2C4USnDF0mz/FPRRyQqUyBql8ZruNmtS3FqFCKthLnxW0OMhTQV7Nk2oRERMhXaYh7YzOlrZA4qKkgG8O0S7z/SsgJaxPXF+0rstVaIG2Ivrka8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718631194; c=relaxed/simple;
	bh=SmyG6Eoc//AkzX1uumr7PmduUREuFi7OxTGIbkmXVBY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=hL9z6i16T0LQco9TT/v9aG42X3IG+HFf0Gs3UG/xVuoRjGlMLA7PN1B3+lKr9OY/MMfRJNtIaqzogF2r9dXSa/bgDDEGju5oyLLwpaV4oQ7URQiB6e5ocR7KFSecypVW724YAIGxpRX7R8PPXZR/RQOFuk4b6PyPGBr4hSl/I0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-375ea274166so29700505ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 06:33:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718631192; x=1719235992;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SmyG6Eoc//AkzX1uumr7PmduUREuFi7OxTGIbkmXVBY=;
        b=CgTR+CCGZueJEZrYXNgUV7DUp2Xs/gihcHtK3eZCeO3Ne2H2g3/M6bxpysgmfjK+/I
         BrVln6Z7MBmiFHnhGwAEnkiZ7MrRaZAivVyzq5ZpUEwav6C/TdZ1kVuGfKt9eXZoJmzL
         UlUFdLX3lU/LGOvkGCgVKf3Ll0XxKmnttUaZGBiXKwTfODA1P5R/8IuS6So8N6/NoHID
         AeuTTyyOBCu39TpO/yVkwGEjk4qkhOyluE8nbPNYWRD4u+eHyOdksWLRCG+NLnxQ1irE
         wNYFvDH3heijO8f/txeHBV4ssqX56cFCh8buZYloWGXCjI437QtNOXxNy0oIfwPWOJWc
         gxVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqwrc8P2sHHdEZnE23plyC9o5EiU3nwtszr3XI5e1+DvRZX3bJJNZ0SaptpEk+47rwPOTHtIJj7v4PEoRVcHLnglV8G37kBzkq279v
X-Gm-Message-State: AOJu0YxZ7XTofO/mebuNeyTdHwbryzHsC9sD40w757Oz60IEgJUB8YRP
	LIbz2MpXuJQcuxSLiRO/j4coksYuSeGt4aKbjagsRKtz7Gwgj/BpduAO5r2d5M4ro6r178MfYaO
	qeY5UiBzUsp4jrQRFqMck0QIxx6BVdSRTl1B7y0Xuhzggp4CVAxJ9wOU=
X-Google-Smtp-Source: AGHT+IGX9zfHpzk56r67iN/P61ob8v67anACI84pSuiDqzQ9F8vk7vIQ58lj4OrW4BRfbYZj/Cu0bgQ4H7QYhM6b7u71+5UrCV/R
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1e0d:b0:375:8af5:8d15 with SMTP id
 e9e14a558f8ab-375e0fe2df1mr5603295ab.5.1718631191882; Mon, 17 Jun 2024
 06:33:11 -0700 (PDT)
Date: Mon, 17 Jun 2024 06:33:11 -0700
In-Reply-To: <0000000000007de0cf06140124c0@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b14275061b160102@google.com>
Subject: Re: [syzbot] WARNING in unmap_page_range (3)
From: syzbot <syzbot+e145145f0c83d4deb8fa@syzkaller.appspotmail.com>
To: Liam.Howlett@oracle.com, akpm@linux-foundation.org, david@redhat.com, 
	liam.howlett@oracle.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	lstoakes@gmail.com, syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"

This bug is marked as fixed by commit:
mm/memory: Fix missing pte marker for !page on pte zaps

But I can't find it in the tested trees[1] for more than 90 days.
Is it a correct commit? Please update it by replying:

#syz fix: exact-commit-title

Until then the bug is still considered open and new crashes with
the same signature are ignored.

Kernel: Linux
Dashboard link: https://syzkaller.appspot.com/bug?extid=e145145f0c83d4deb8fa

---
[1] I expect the commit to be present in:

1. for-kernelci branch of
git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git

2. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git

3. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git

4. main branch of
git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git

The full list of 10 trees can be found at
https://syzkaller.appspot.com/upstream/repos

