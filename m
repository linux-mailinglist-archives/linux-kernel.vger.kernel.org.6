Return-Path: <linux-kernel+bounces-349439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6509D98F62E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 20:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 835F01C218D1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 18:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73CE31A76C7;
	Thu,  3 Oct 2024 18:34:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D67BA41
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 18:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727980446; cv=none; b=A+knoX9ln6IyetAcj4gn08P/wHR6LDlXfpG6tL/WYvZOk6neeJ1alVC24Y3h9GwweEyDupryJT+zP3ZQ5JiqdjpnO+UjG97yqg+v+MLqr1zjTANlBaupXBF+XL+4DB3tt/luCzDXTmEDDVi2dADUjdOOZvxhP8YQ0HmJvzlpi6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727980446; c=relaxed/simple;
	bh=SKjDGfPac4oiMYpwWaQrt+nA2gBIqo3s9qy7TWicKIc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=eRjFHny43VaNXyymRe/B64G/1HAjpjuBYk/H+Eu2nlpXIix2fiBWuR7LmsOitzPKDxdDG9mptbmTveyCETdEgv8v2qz0fF+hCbnj8eX+luN0aBU65edBxWyp7Gg6FIjk4bjyPUyQxfSzoVGlG0iDf2KZjgIxO2Sm/DrCr5zvEV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a0ce4692a4so12999315ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 11:34:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727980444; x=1728585244;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z3LFadrrWWO78EB5v7iuFXQAmoZq5hQwY0NL9rTdmWI=;
        b=W0kqRcNg0QKW5evZOzuzYMVFmV7d3nljYNYnAZxECJnnmI9HvQeJp3UZxnKDQPHtmb
         KCZ03YzdQSCIugoYxlecqOSazrxUepkGton8obZ0PMLJRuoP93k7SVnA18q+V7R7pqWo
         q33OeqCD06nioTSIlyW2EqRT3Ky7O4k5TWlRCBOIQg6QzldxjT4OAcmY1J3lDaaYyhqx
         baraScs7UXX6bPgzmfkKQxg0/pE5U6/g8jKEu1UgkyQvCCS4oBk72FpwO5E6a5VBT9Ih
         4azesOrprsDcxGJ1QkSId3gbHLLLui9fMk5c9LFkU3vq5GZPKaSZzNssafmRqlctXnv1
         D7yg==
X-Forwarded-Encrypted: i=1; AJvYcCXz2ECMsWmmjtCl6fZhBl6jv9knUhqYtxU4lt5LhxrMGT5NQriFTJfv8+spK9EP86KgFaP9FMz+K48q0y8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO0ln/B1LRzbXDQj6Gc580ZjpXuUmBY/ozcqsnPmLV63L9H17O
	4fj91LhCs7Ic2IFxs20KyV5T8wlEEDqb2RAyH0hD6tBJTbtnxNn1he+RRun/edK7jbPYEFt11WG
	voCIVG+g4iqjxPecBydsKanmkjwYO+UfV/EeLy0gKfiIdUYDtSXDdIyI=
X-Google-Smtp-Source: AGHT+IEpZZhJ1NbfBX6qgr15s/jXeU8v2ry1YaAKkwJLK+KHxoHhwFH0MARsTgQIvMs+AFxnGG21yr11FziDUhGsqId/z6rBj7FA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c87:b0:39f:5def:a23d with SMTP id
 e9e14a558f8ab-3a36e22b492mr32342035ab.5.1727980443982; Thu, 03 Oct 2024
 11:34:03 -0700 (PDT)
Date: Thu, 03 Oct 2024 11:34:03 -0700
In-Reply-To: <20241003174929.GA20760@breakpoint.cc>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66fee39b.050a0220.9ec68.0056.GAE@google.com>
Subject: Re: [syzbot] [netfilter?] WARNING in xt_cluster_mt (2)
From: syzbot <syzbot+256c348558aa5cf611a9@syzkaller.appspotmail.com>
To: fw@strlen.de, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+256c348558aa5cf611a9@syzkaller.appspotmail.com
Tested-by: syzbot+256c348558aa5cf611a9@syzkaller.appspotmail.com

Tested on:

commit:         f3346fcf netfilter: xt_cluster: restrict to ip/ip6tables
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/fwestphal/nf xt_cluster_restrict
console output: https://syzkaller.appspot.com/x/log.txt?x=17f0d527980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b2d4fdf18a83ec0b
dashboard link: https://syzkaller.appspot.com/bug?extid=256c348558aa5cf611a9
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

