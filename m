Return-Path: <linux-kernel+bounces-282076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E236094DF68
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 02:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10F1D1C20B41
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 00:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EAD65234;
	Sun, 11 Aug 2024 00:46:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A59A28F7
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 00:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723337164; cv=none; b=o3OxgxzDcM4mLlg4K3M253UG0aZmq1zO6VUve3Sz9M9QpPhzfouwilxZpM6hSWyJp52aHSSCSaHfrS5ex7v5lnzgNUaU5al+rbh8tzlGlh8KrmSQN54IlnX6z64Zt7R0yYkds+z9UCaq59HviZKpo6npv3SOoHXDT8KzBPYV9tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723337164; c=relaxed/simple;
	bh=897uIeFFV5dZGMHEvIg0IuuG7l6HrGV7LvIwPEeTo4o=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=lZJj3pKLUg5W7D5o/F8aFXu+Hi2JF2d7a9IHGBv66UqP5H8TWtmW9T5JAbrXt+F1JNhepoq4i2umsRvAtgCDBhdnhQv1p11TGrDVdl7EhF66t9IikxOFIErpmkPnNkjzbRlE8f4+3u4wYjN9SS9vFOaCEo/oV+AZXUvFL+Xn3N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-81f8e43f0c1so398414739f.3
        for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2024 17:46:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723337162; x=1723941962;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QN9qeL+BrW8qv8gKK4Qqo/zsU3RpoUzp6IhqWYrYGJY=;
        b=mjRb4g8LUpWsmiv8ssl3QrDlV7WvkNzKi5iS2pZSZ9wzgsdHTO5c44Y+YeE+WjxUCa
         ZN+kwYQoukhh5yMLI0t5/JGXdPbffbMqXZPeTjVD0SA77par2dloyhBMYwE6hiDcDyf7
         Thwk1r8oOESXhdWdlAxwW2ha1X5CVp8l+t2BvcBb+TJUoclVePkQi3dv/Saw5AUAhPGW
         MAu+kcAkpegeRUCdOdf0uiHwtM6H/VOw+sLpglh5toeg4hjt26L8is1LejhF/G0QDmYz
         lgJIPuslNtSsxOhpcOwHowliLyf8POWEQanIUQBhpB38tU9ineDyH2aVSL4RR2iBRdfj
         oNNQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3hnXoCwLuBIyK6/oCoZh3AY3SQjUj/VuHJAlfZtV3b+siJQ5F3jcRh5XHq1ox+bHdZD6fRcvo6IvyvWHBuHK2DOhxxjxEuLhb/5y4
X-Gm-Message-State: AOJu0YwzOhVbgbY2itCaV1R21m6DD/d809rotRMiAi/BZ1j9KORbPAGs
	phFJG7fN+KJX/+kzHr5U8PuSdsyHENzJ3dq6lesrwIySTivyUKtACTg4JuOgLRNtMQTZtDFOgHb
	DFoYG4QDqiqKl9/2ht+p8AVEixv2rd/F87RB3fvqATU1bj3CGMs0fWkI=
X-Google-Smtp-Source: AGHT+IGOvR9NQo8eoWunEi+4FH7GnueNngKbPlSDmAta6aB0v3IqodX+MTBokKUb7UOjn2LNrX5UDu4VflLAk5o98sv7deiLcgAG
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8401:b0:4c0:896c:515d with SMTP id
 8926c6da1cb9f-4ca6edc9cd5mr364043173.5.1723337162524; Sat, 10 Aug 2024
 17:46:02 -0700 (PDT)
Date: Sat, 10 Aug 2024 17:46:02 -0700
In-Reply-To: <20240811001341.2890-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000669deb061f5db34e@google.com>
Subject: Re: [syzbot] [net?] [virt?] BUG: stack guard page was hit in vsock_bpf_recvmsg
From: syzbot <syzbot+bdb4bd87b5e22058e2a4@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+bdb4bd87b5e22058e2a4@syzkaller.appspotmail.com
Tested-by: syzbot+bdb4bd87b5e22058e2a4@syzkaller.appspotmail.com

Tested on:

commit:         eb3ab13d net: ti: icssg_prueth: populate netdev of_node
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=116b1113980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e8a2eef9745ade09
dashboard link: https://syzkaller.appspot.com/bug?extid=bdb4bd87b5e22058e2a4
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10c70dd9980000

Note: testing is done by a robot and is best-effort only.

