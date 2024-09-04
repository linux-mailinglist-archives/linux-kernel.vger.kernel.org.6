Return-Path: <linux-kernel+bounces-314078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EDA96AEA7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 04:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEFAF1C23E49
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 02:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B3539AE3;
	Wed,  4 Sep 2024 02:33:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C131EB21
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 02:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725417185; cv=none; b=Douzr21/dAe5GaKnkXijYOdVuH2h7IB4+WPZdSZ88Lrj21sa0eMPVA/Vmf5SLGYfeoy6ijjqLNhRXmxWXzTM8MJzwXZIeylBGoMok/fcBvQU+ZA9IuhOd6RnFTwAEUVjdt4F9l/9CLdxRLs5Mlt5dnYgZVtp7rUkTWEKJaYPmDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725417185; c=relaxed/simple;
	bh=sz23cEya+ZwD9oFXQ7WSbSpm418i3RGeZcRfHgnPaO4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MjyyjHO5TbA0qyg95Ofe7KJov4fFlnMd0yFvHV3D/Uqh4AO2jbcT+PNrtt2CI6RWGEZzmaZdqkR47S9bOB22mCqiudT3yyQz11f4Ehy82akP2HzhNPuhrDLg3gxxC1uLUi+V2AGTHcbcbmYlK1+MnbyPhi6+2FojkzIQSsMGOJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39d4c745e31so80876995ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 19:33:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725417182; x=1726021982;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vJln4f7bXKVjTMFpQPEvF+uqszrB0matYtHnUyRSnJk=;
        b=vr6W8l8Rr0nEeGLr5rbqzLku0oQ3NlqDRqXum6W4uExo6LqU8Qomn1NmWgFGTWu1Kt
         xQwDcwa4auLpJ8OjZxfkCtpKCTy+DtSll80XTFteebTlBeXf5d8AII5kNu7laQT/LeTy
         paxT0It6wUP5cvMq9Q66n9OXV0G3MT97cHZ2oI2/SKlw05vIEzQCxuUwz1xpwKKH4N/f
         VDD14aCrQHg/R3HHk7Lf8muqFxGLNvkUbnAJYpy4VVSL/5hZ/CXeI8fQRuYz2WPS0eX2
         hZrZv1vTzZu1zFQspnMbDG5v71vj4xhNqCpBQICH3SRmWvkbvTW1Nz2QxAD+q9oJzMIa
         GUOw==
X-Forwarded-Encrypted: i=1; AJvYcCWT/4XienruapivyhlEGrIZUfWnDJfNQQv4cxR/eDrObsc//FzODglf8d6pPzQ/NXIRSx/y24YF+2TtuH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNTfX4pxZeDTFzQYSlLzpTMPXa5zD2dtwichhFHJhT4OIdTo4D
	1CClBQ36PL43lf+rxPJvsJ2HwVkNRNJr0CGiitzByCG6v0/+97TDhfeG8YBaKmIDiREUdGDbpzk
	Sajng9d0F8efy+ZYPv4B6j2qvc6re6ChPkfOVp1V3fo04qUFGn2lAlZY=
X-Google-Smtp-Source: AGHT+IHnFKzswE2THlEud7EGKwe6x3prsjxIhxhS4d0Wa9hXATAmsVolz27CESPb5ZFLfELCGLl3F5Wo64GdEQ31GGO0lv0yAA2z
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:174f:b0:397:5d37:61fa with SMTP id
 e9e14a558f8ab-39f40ef5677mr13317215ab.2.1725417182725; Tue, 03 Sep 2024
 19:33:02 -0700 (PDT)
Date: Tue, 03 Sep 2024 19:33:02 -0700
In-Reply-To: <CAG-BmodKru6u76C-14ThynNhzeBs-oY-t7YRFfpb32KcYr1Y_Q@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004417f5062141fe65@google.com>
Subject: Re: [syzbot] [btrfs?] general protection fault in btrfs_root_node
From: syzbot <syzbot+9c3e0cdfbfe351b0bc0e@syzkaller.appspotmail.com>
To: ghanshyam1898@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+9c3e0cdfbfe351b0bc0e@syzkaller.appspotmail.com
Tested-by: syzbot+9c3e0cdfbfe351b0bc0e@syzkaller.appspotmail.com

Tested on:

commit:         88fac175 Merge tag 'fuse-fixes-6.11-rc7' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=178609eb980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=660f6eb11f9c7dc5
dashboard link: https://syzkaller.appspot.com/bug?extid=9c3e0cdfbfe351b0bc0e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14e24deb980000

Note: testing is done by a robot and is best-effort only.

