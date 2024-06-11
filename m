Return-Path: <linux-kernel+bounces-209844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 493FD903BC1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 14:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E74341F223FE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 12:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A17917C201;
	Tue, 11 Jun 2024 12:20:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4621B17623D
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 12:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718108405; cv=none; b=ZR5IbFO/wef3svqC8eADCvrQ2X6Vw41LOEDXOe4ACYk7qpct/gfYBML+D70tD3H+iIKgsUnSV45Qlblh2mdPxNwjtF9+8donRNM0LqcwUn/7PVIVP/43i7wbvVZx4paIMwwZ0hbIi5Shc9LQoBpubDQIT1L6h4gaA+5sBHo/GJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718108405; c=relaxed/simple;
	bh=RHebsD0mFvsRcaGTPqrsz3Be+1bxdlKbVifT5PqSU5M=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mbzw+pazEQWSr57SXPvh90B31qeJC0d/mTcuzbO8F2gUC2pcUjcnomhMvAeXpQd6xw9ZkhyE4S+3sZxUgRvCQ0tNwd3Bq5UQGUaxlkHPHgy16qD/XGwSCO6Ulty+2ynfjT1Ubd14YR8vs3tD7m+nRIUTfvUhjhKRbSGwZtoP/Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7e91ad684e4so666735639f.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 05:20:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718108403; x=1718713203;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1TfcCaSE/ogErZoWPNrnwWRHpinHJbDMpYZOTWsQh04=;
        b=ZcPGUadu5e/3ij/nWZkS1Y4uqKgvSbcfb/LyQeIcqr5rkjjBO974sTbfZ9uUeeCXIy
         TtigHpI8ztwWAymeI9by5xjcV35PmFHQN8BbqHhLRcUqBlb+xhIJhUvRI1tgZFLV1iv4
         pubAX8bQTAUeMB4ywnijwGl/6yw45D1rj8SeqnYfkUSNlHbUN7VSzoAcVLj6WJ1lDEL4
         layLjqQLqAZsCioR2AbWEeBuJ3f+k8Cm8atEl0WAc3g+/aSSvZeRGolTNfdCYRqYLGph
         ZIjH+wC6fb87sog1LQc5lT7Qtp0Nylxmyojt48hEa1PJWjh37GZKEH6zcj2Eq0uPM11v
         YxmQ==
X-Gm-Message-State: AOJu0YwPTuGWtXCynyKrfsj9UYBov1oQ6+ZMagI0vOBLuz9d9DkvwQiC
	g+VE45oygQFhC8Sb6dyj6HcXqjHIvbKz6f/CgEzPV+yh0vIzL+3K5npiqsF1/CGkBWlqokZOmew
	JtVfGwGzxQRrnwE+Gr9O9Xm+B1MHnAEHeEc+MBCCe0Y/4nRWzXn57Jwc=
X-Google-Smtp-Source: AGHT+IGXybltEAgSli/DggOZ0SkWQ9DRe8VRvCjlzzKJpp2WEfM6oEJRJypYAQWcoIrTOeAJEcOSwCxH0BTdwuSrtlfjvAhTGrGD
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:134f:b0:4b9:1d81:c216 with SMTP id
 8926c6da1cb9f-4b91d81fb64mr218222173.2.1718108403379; Tue, 11 Jun 2024
 05:20:03 -0700 (PDT)
Date: Tue, 11 Jun 2024 05:20:03 -0700
In-Reply-To: <PN2PR01MB48916CB3DD64BB8C5C73ECD4FCC72@PN2PR01MB4891.INDPRD01.PROD.OUTLOOK.COM>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000011c075061a9c491f@google.com>
Subject: Re: [syzbot] [bpf?] KMSAN: uninit-value in htab_lru_percpu_map_lookup_percpu_elem
From: syzbot <syzbot+1971e47e5210c718db3c@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	wojciech.gladysz@infogain.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+1971e47e5210c718db3c@syzkaller.appspotmail.com

Tested on:

commit:         f2d3b30c kernel/bpf: KMSAN: uninit-value in htab_lru_p..
git tree:       https://linux.googlesource.com/linux/kernel/git/torvalds/linux
console output: https://syzkaller.appspot.com/x/log.txt?x=149221ca980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b5bc506ebba90cbf
dashboard link: https://syzkaller.appspot.com/bug?extid=1971e47e5210c718db3c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

