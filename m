Return-Path: <linux-kernel+bounces-405482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B23C9C51EF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 10:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3B341F252BB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 09:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1412620D4F5;
	Tue, 12 Nov 2024 09:27:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5390D20ADF7
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 09:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731403625; cv=none; b=dEKpqDUiRwNRKdPgGZAPyNrQxN1E1+IgfagHObMHQNg6qVW0aLe4Ydlqwhndl9bOwjMfPTnghEDCDWwvEgywfda/Di+ugha2nqEvFRTNocFE042UFnzkQzqfGw0Jny9HCsDFwxtAbIsAKXvbVCxonkuypd2S7ZGHJ8+8wfv5nQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731403625; c=relaxed/simple;
	bh=w+X74amanGMF9/gAnXqBIjC+4aGYnL7254O3ycVdopo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=PsPUh7jvgF/GC9SWmBhMUwWbrgqt1v5CZPvNPezjSaT1mOPFtXTu/riD3JIurrbiGJgC8j+PzCRKWXT9YWU9peE5QnxAJzBuLcrnr5H60vLArs5EWcEco2199Cp6whyXnB0tD+rU9oFgfZSAX21QZu/y5U/EGHoZyrZqdQ3l9iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a6c355b3f5so62233705ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 01:27:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731403623; x=1732008423;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nCfnoruo4doolQHp1lAwf+3efWtE18izd/R+7bj9TZs=;
        b=KFFBjCFfGd6zffkKvP73l+0iNsuiifRCwd0+eSPdaLWviJ7J/DiJIgEOtE6TtOHV+B
         J9j1MZ2Z6xu5Y7PzWUXocVQSKnPLbgGymqZGWB2Xtm1WXbBlqjCgOsxm5DMFRoegkZgy
         lyM9qOwPtQjLNztBM/qMI3lt5lpJ2LT8uLfXKpv5IIB3qPZA4EFvA2uiXqAVJmqz4Q1k
         OOABkL329TRp8mcCPka//bXrHyWkp3jKJ7n5k/BeIb8euD5ng+P5eBJEkiISUC+ptcBU
         WobR8zmmNEbXwOnmgs0/EN3YkSoRPMqYGI8gP+d7AP/qjedw9Xv6aSfZnXZVpp4or5GS
         HjNg==
X-Forwarded-Encrypted: i=1; AJvYcCUDJSENiJNvdGWTKj6fuqU76C4QE9obu9a4oICO7h1nqClcDlbO0aFwsgVWCp/Vuo/F2gq93mrPIh4/0cM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy/ajdD9h+SahPkh0xQhfL5ZBSm9EmO0DUJ1UbWbYgsAUnef6Y
	2dP0BINMQlRgVC1h4p+FFWTvMrOKzPprg0M90gPk4MfYqp05bYN7vmIj3rhG3HsIz9jRjJbKjkx
	dZOfeWjqf9KBWEBj847Vv73Nr0ZCej9IsXBu9oy9StuQ1P8Aq8lmxae0=
X-Google-Smtp-Source: AGHT+IElsoWabF/0QQv82QY+XPfWIHJETQBe2x+K46MH0oGcev6HBJYG1xig5dUNGsy8jTu8sTC18DO2bISeo8lVN9V79dowjJgi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c26d:0:b0:3a5:e1f5:157c with SMTP id
 e9e14a558f8ab-3a6f1a21eadmr163420115ab.15.1731403623592; Tue, 12 Nov 2024
 01:27:03 -0800 (PST)
Date: Tue, 12 Nov 2024 01:27:03 -0800
In-Reply-To: <tencent_3DDDF3704370896A63A8845A977C3767A605@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67331f67.050a0220.5088e.000d.GAE@google.com>
Subject: Re: [syzbot] [netfilter?] KASAN: slab-out-of-bounds Read in
 bitmap_ip_add (2)
From: syzbot <syzbot+58c872f7790a4d2ac951@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

net/netfilter/ipset/ip_set_bitmap_ip.c:186:125: error: use of undeclared identifier 'ei'


Tested on:

commit:         2d5404ca Linux 6.12-rc7
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=64aa0d9945bd5c1
dashboard link: https://syzkaller.appspot.com/bug?extid=58c872f7790a4d2ac951
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=128178c0580000


