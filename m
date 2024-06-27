Return-Path: <linux-kernel+bounces-232303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD6991A68A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 14:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FDFD284857
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 12:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA292158DC4;
	Thu, 27 Jun 2024 12:29:04 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E325513A276
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 12:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719491344; cv=none; b=QPFl9otU1oppfzaIMqsGMYIObyrPtoukOs0livdoeqGIiX0EnG9xdfIDexGSv7uN1ENPK5hoe/j8XqAXji1rWqg2jv04p7JOHqMZ/znNTvhf3NecAT9nSPAE2qYDm3bJNfMUW8sxcV8FNk9nn1vfGA6viES682fiS/eYz2zMz0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719491344; c=relaxed/simple;
	bh=18ao98/t2ko5i5TC8i/CF5ZQhXejA/4uzrEmwIARCsc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Ho4tZlk7L5qxJA7y2OibaCGO90llPjnwOaqG/QQ2OozvWJf7Gq5LqJ0YgYhoDYGxI2LR4vWZpDqZEwFy/e9LmaHBu9aVfMvHsuTMW+xJTv2a0eqQbLB7Pm2H1UImRNRl0KUc+uxaDWQ3D45/DdaI75fJRiZNqqOBKFP8eUy+TkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3737b3ee909so110401475ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 05:29:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719491342; x=1720096142;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RIDvAROiZOUs/BZdmEdog04QPf2B1LRp4mm3b4yhysk=;
        b=vWiWfXjqR+sFBAadafxVaZkCINxUmTtRa7NLxCfU/Zv8DPkuXQsiCnzpKVq+/5tXX6
         MhkJ2amoOZbufzQfLo7v5SsIKjmeGUgXayCrRuQ3vE+5NFNhtPtKoYMiB3XBdx6JLV6L
         C61s9u27Sv8IvsOzoC+1n6GW4iddh/kZT/jrTCJlEv2/UsOpCk8/31Nnd5CITiAR0fRu
         mZEWG0oIAPDeT5IoJ6cA1lwSnjHOZFtteJtPYS3S24aS1iE9Z4PFzumCvfDtIOqHrZT0
         THAKdmgVXORzogTVjwNhybrXeLnH24JCS8q7bNrKNDzqJBgRgriuwiZFoRXEp+oKQRVi
         mW4w==
X-Forwarded-Encrypted: i=1; AJvYcCXnG6yDm//GnYQGuYnDXVibInzhut3Skk/QbkCpf3CJPPdnUm8saI8p9axWDFkgpyOCaiEs0ggp/LcYfMdz3iujhWYIJwRI3+ll+6be
X-Gm-Message-State: AOJu0YzPMrhCxStIuctikoadMDWcbkUyIpckcFT/n4uygUDiN+/oTeIt
	kjVXhzKVPDYncaPfsrRXucbtK79sncC46irR17+pJZqYpmvtiKZ9NNA8JhRr6nSitCcQjU1qJxc
	nIxj9DsnaoD+SkbWX3Uo08eYWffWViF/IvK0PX+lzQ3xVw9KeZNtBqfM=
X-Google-Smtp-Source: AGHT+IGVTE222tFGHm9wTkBV2VPnoknAkfGBkNWEboDWTYhUK970XuByVMQY/9Lq/td9XgmWVCr+Y3gUceoCx41n77WgnAGeZxqj
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2190:b0:375:e04f:55d0 with SMTP id
 e9e14a558f8ab-3763b0b6d82mr11880135ab.2.1719491341971; Thu, 27 Jun 2024
 05:29:01 -0700 (PDT)
Date: Thu, 27 Jun 2024 05:29:01 -0700
In-Reply-To: <20240627120502.2200-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a20256061bde46c2@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Write in l2tp_session_delete
From: syzbot <syzbot+c041b4ce3a6dfd1e63e2@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+c041b4ce3a6dfd1e63e2@syzkaller.appspotmail.com

Tested on:

commit:         185d7211 net: xilinx: axienet: Enable multicast by def..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=15fb2299980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e78fc116033e0ab7
dashboard link: https://syzkaller.appspot.com/bug?extid=c041b4ce3a6dfd1e63e2
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13856f3e980000

Note: testing is done by a robot and is best-effort only.

