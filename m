Return-Path: <linux-kernel+bounces-402733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 491E39C2B47
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 09:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 717811C20F87
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 08:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F8B145A19;
	Sat,  9 Nov 2024 08:31:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77810647
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 08:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731141064; cv=none; b=FlzgNliVKGHuwDaqNVIF2fNQcJHAM6XZEop/6dpAcTVjZyDmYw0blm0417iXXhEj/Y59vR5nCN+Rgx5FVoKkL5GQi9o+PM00agTDKt3XKacUjCZ15IJEfzgTGKiFpTzSpZjZxhJS+DCa2dZCVdGfHqgT0npSLU5FW0pZ2TTZPpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731141064; c=relaxed/simple;
	bh=1D1xovnM0EMAFcuSF0pmt+0U7XeGSOPxADpUIgdsIQg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=HAQe85jFWUhbWRNHPfwGIMRqrwzCDZsb7Opehh6uGIjQumfF6Qk+bznMdQfC03mgx066wiC5NVd3KMGDwXkK2ScCWQ999oUh71WaDR2VBnN4QINXYI4ykfhtJZrwf54A5R5QyE+P6jZTZ7kmNrN05wwG3Fb+Ced0CBH8HCDqQSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a4e41e2732so36631055ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 09 Nov 2024 00:31:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731141062; x=1731745862;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OYVFRLpr35Jnu0CNYH9eEEbObvwHw3Y0l7EYQ4KbDpQ=;
        b=GGn1p+dUBxwF+5j3X7ipQSPZzXxTUhAk197QBS9NV6EhyBzRSMmiIpgRcl1a/ogkZW
         kvBzpQeiWTz/4WuKGvOqrwMrOw25OEASIOFOKBIghnXD99rOU9DO2fRZm+C7gA7koXdG
         Knc4VNKy2XFpZv/LAhpu1TtiJJtPbTZ7og4diMo8kxYGcEjqqrBBAmR7CwSMwGNCn1bE
         5oghBH2jblpgv9UqRiFopi7k7u9IrbKDfbrzr0qG9ZgNGF8BFbIwwVCi/MH/2nW4aNbC
         0cEoRAS9f17E6bIsF9ZqUN8FEtmL/gmyYwjbS+4HPSPGJ9ekR1XePprzwYi19/4VffZR
         vkmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKdH7o3Jns/JTd4nwCedg6Bg016byNrQoJgsp1xoY6kEtSgInx0xYvFMnP7R/mHBFtxErygAs24+xHrG0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuIhv54jXSAQjQH6WyJzdsq3CMeAabfz/SCJlIhSKIxsAWHcbE
	YVR/nCoYJyzjnB8vSEAQfYzA/kLaxtvSoLgpzzkWvZaYY0nI7UwsIyO37demilaH41pVkLnEgil
	3i1YXxTRU1QyOkFoZ+B6QhdbND0rE+OQN2TOiaCer4Maah0C6OMzJPBs=
X-Google-Smtp-Source: AGHT+IGumaAxr12HSrk3WMZeIvTdg85QNwAfY38l9VuHuXPLH3cBOYaCgbCt/TfwXfpZvNPy4DGVNbYZjn1IQ9TcG/OTI+wS0IlM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1706:b0:3a3:b4ec:b400 with SMTP id
 e9e14a558f8ab-3a6f1a48d05mr63137605ab.17.1731141062618; Sat, 09 Nov 2024
 00:31:02 -0800 (PST)
Date: Sat, 09 Nov 2024 00:31:02 -0800
In-Reply-To: <0000000000001a94c3061747fabd@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672f1dc6.050a0220.138bd5.003b.GAE@google.com>
Subject: Re: [syzbot] [ntfs3?] possible deadlock in ntfs_mark_rec_free (2)
From: syzbot <syzbot+016b09736213e65d106e@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, nathan@kernel.org, 
	ndesaulniers@google.com, ntfs3@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com, trix@redhat.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 5b2db723455a89dc96743d34d8bdaa23a402db2f
Author: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Date:   Mon Aug 19 13:26:22 2024 +0000

    fs/ntfs3: Fix warning possible deadlock in ntfs_set_state

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15a67d87980000
start commit:   ea5f6ad9ad96 Merge tag 'platform-drivers-x86-v6.10-1' of g..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=f59c50304274d557
dashboard link: https://syzkaller.appspot.com/bug?extid=016b09736213e65d106e
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=133fa268980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=142cb182980000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs/ntfs3: Fix warning possible deadlock in ntfs_set_state

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

