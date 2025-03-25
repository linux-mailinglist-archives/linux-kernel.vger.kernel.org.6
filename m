Return-Path: <linux-kernel+bounces-574633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4F1A6E7D3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 02:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DED63B3716
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 00:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D08145FE8;
	Tue, 25 Mar 2025 00:59:50 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA0F83A14
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 00:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742864390; cv=none; b=AoRa9w8UUk+ygOgUhtaQiUuEmX0/7w0f8UIbFNlYHagvMR4kxPuuwfapKymdgQNshRvg5EphbMpd5ubMdervkVJJSB2jNnbU93JUC9jNIxJKHaIAZpNlBWdv89YiGdCPlS8AeiKjDRemR6VOU/HH3RJiFBfNL/hZjwk7RqmMjRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742864390; c=relaxed/simple;
	bh=ycbYEm0+pu4LNd2cswasxb6AHpj8odW5DkvdcKVR4to=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=d3jp+gO+UM1BfWz7IergpzUdEQ9iogaDG3Op9ltL4lhFozWed4HDQxFmtAsOnE3ZGb8u7KgbmvzsB8+rMElbAWWxk1xAdFJVSnLVWtZggZ8P/MuhK8u2Ptocg9M2papXOMvv0wRMLOiXvEKobolggfgoIYp8PSScWXFXpRuMBvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3d4423d0c49so36994325ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 17:59:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742864388; x=1743469188;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=erPtxUxHdD1XJFTROCOyMM/CDJ5r0GxU4RG98Rui3fs=;
        b=K0XmBWPSXcT2eHy9Lw/qErvfvhT7HymJXYYv9a3LRh/LPV0z6y+KDbKJapLuxu3c6w
         NJR1HYl09tVliMAn1p4o5RGz8phsWIOoYrd8WyYlIDUfqUlsBRc/38mOoW/Eq14VkC+G
         emUnFJMKwIRbi1Hb2lWE8f5uk39QNeOPD8c5MWuFsayq7Sq/Pz6w6nWil2qAC7M7pVcb
         XQzCmsxcSDqp3V7G6fQCNLx8eP9a3uI/4LAGWd4IwooXGOCkW3Fq3YoQe4hh3lBiXbML
         koUibcwlw5C49pqiGiD5JeeltioWwS8hKJQS12wCmSQPlmIk5w3q2RrUVeYi4+P9KCTY
         XzTw==
X-Forwarded-Encrypted: i=1; AJvYcCViNJMcUMvNiJxLdKjKpyYSbN1dyFfaIE8FJ/C9kt4dOfR+FbbgL3SzhVUmJ92vY8rDcOZcA/xD46pY4uM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAM2dbSEuyVoFRgmfFoscU8NXir92OVpwtYEakh7y+zG/SXQtU
	UQkKWxEUnS02IATs9dnOA3amx2PO5WWjJfbvQFSqRUC57lh4Adr1X937aQe9yQQxtVlDimlAKvy
	YfBgwacqpkY8ZAvPX0ddIcilTf4BAK3e9OVSw7Zhu49mjEJjSIxmnXn4=
X-Google-Smtp-Source: AGHT+IEbUA40C664JBlGz6/2XhWKukMNm+eNIzPqMmETPqCttaIiQ0169K8xsHXdN/sdYGeUSvtDCrbS23J5+dAEvdeMI7/Gi+ls
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:216f:b0:3d3:fbf9:194b with SMTP id
 e9e14a558f8ab-3d596055c48mr135154085ab.0.1742864387599; Mon, 24 Mar 2025
 17:59:47 -0700 (PDT)
Date: Mon, 24 Mar 2025 17:59:47 -0700
In-Reply-To: <Z-H__dbcSB4htqUZ@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67e20003.050a0220.a7ebc.0034.GAE@google.com>
Subject: Re: [syzbot] [kernel?] KASAN: slab-use-after-free Write in binder_add_device
From: syzbot <syzbot+810b8555076779a07399@syzkaller.appspotmail.com>
To: cmllamas@google.com
Cc: arve@android.com, brauner@kernel.org, cmllamas@google.com, 
	gregkh@linuxfoundation.org, joel@joelfernandes.org, 
	linux-kernel@vger.kernel.org, maco@android.com, surenb@google.com, 
	syzkaller-bugs@googlegroups.com, tkjos@android.com
Content-Type: text/plain; charset="UTF-8"

> On Mon, Mar 24, 2025 at 05:49:53PM -0700, syzbot wrote:
>> > On Sun, Mar 16, 2025 at 03:51:27PM -0700, syzbot wrote:
>> >> Hello,
>> >> 
>> >> syzbot found the following issue on:
>> >> 
>> >> HEAD commit:    b7f94fcf5546 Merge tag 'sched_ext-for-6.14-rc6-fixes' of g..
>> >> git tree:       upstream
>> >> console output: https://syzkaller.appspot.com/x/log.txt?x=134f303f980000
>> >> kernel config:  https://syzkaller.appspot.com/x/.config?x=cdc24cb631dc9bc4
>> >> dashboard link: https://syzkaller.appspot.com/bug?extid=810b8555076779a07399
>> >> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
>> >
>> > #syz test
>> 
>> This crash does not have a reproducer. I cannot test it.
>
> This is likely another version of this report:
> https://syzkaller.appspot.com/bug?extid=353d7b75658a95aa955a
> where access to the binder_devices list is unprotected.
>
> #syz dup: slab-use-after-free Write in binderfs_evict_inode

can't find the dup bug


