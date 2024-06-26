Return-Path: <linux-kernel+bounces-229970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F111B9176AD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 05:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD4171F22E29
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 03:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F6F3AC16;
	Wed, 26 Jun 2024 03:15:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE83153E23
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 03:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719371706; cv=none; b=iXWc+hS/dYqk/8IHVUI/f3LEw8lGrivykWWqsUC+z6PEZFd49RkmjRP9GVzN2+ITChziV7HGf0ZQFN+COrzn3GotYWZ2J4j3rxv0FZXD7A2QMKsx2estKhg7PGGBGe0hFXjAdFsUX+MhEtqMtyqFUg6UtG0A/7D9Pbnwc+A7e/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719371706; c=relaxed/simple;
	bh=B/9kev/b+OPHJyKD+P/1RpUxfYUuBYu32+qtnZZrdJ4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=l+4c12XH/MG/ThjUwfqDvgPynjgE0JrfFRcDEWVDYeSvmWYAqhL+wKlDIJ/b8mb/HBhMYnBBgUbyrzBpCtpSN8gdn6kD7ZEYwWuOC8g8kWME2mbH01n3SLU+7j+Z66hzwKzc6XqAbrpoVTNz+abojFsjNFlg2sJYR39nSxOwkwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-375beb12e67so78047325ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 20:15:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719371704; x=1719976504;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eg+OVAYla1xqJxnAOOPnyXpOu7qZLXXRCUe1aFJ4Occ=;
        b=qlgwoOIATcneUlmygRKAtX0CKZkcHf0IUBLKp5+Izc3jT8wEFQit/bJUm6wGlIvoZv
         cq1MPHWSz1WyEo5G7HoL9GZHKlSquFHGuyfOP5Xntqe+40kjCNeKcVxC4o2wmhiMABwd
         DJCdu+WA15lY8t+ci9M/uwPhW6L+WjgbEOAqi+JXD7lPW9tSr3fzj49UAP6mkt/v324+
         dfW1mxx5aXiOYNP18CKJMH5vMwK/Wwx0B0WpYJbkaWnSh+Uup96mz6mx0GE2U92KJb/2
         ePGaWGDjLCUWBOKLa7cKUV9Q5ik+6Hu3FImiKHQIpMrO2DU4PZtVsDmj2g+pJWdovqhY
         AIvQ==
X-Gm-Message-State: AOJu0YyJFJ6hSEdiiv6winP0U0DH+9Pd9se/K02U/1naa8TbyKIaDbB0
	bAReZphrY8Mb46qxF7tMd9nSCkFa/L/6NkV7cDnJ9T/Ki42B0VWOu3vafMN7lfsJMCej/YDlqGt
	KrOdNsYKdmzP93PWX40OYBbkUEJtuQEf5t2Aec4Z2bDfeVawT1GkqCTk=
X-Google-Smtp-Source: AGHT+IFasCS1ybkmXz4Xb9X5tx9TnRJCLjpNQ641MCMnnaQvtWqqLkIqeWP0Q/nbgw6XO9YnTjvqtIQZTRoW8aSy0CtPtfiy+3nQ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:15c5:b0:375:da97:f21a with SMTP id
 e9e14a558f8ab-3763f6e1665mr10111325ab.3.1719371704013; Tue, 25 Jun 2024
 20:15:04 -0700 (PDT)
Date: Tue, 25 Jun 2024 20:15:03 -0700
In-Reply-To: <CAMc0M--Cxg2Om4Obb8Hv3vqzbrKs3ddHDcXKCxhP=ODH44S3iA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a7ac1a061bc26b73@google.com>
Subject: Re: [syzbot] [kvm?] WARNING in __kvm_gpc_refresh (2)
From: syzbot <syzbot+fd555292a1da3180fc82@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, peili.dev@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+fd555292a1da3180fc82@syzkaller.appspotmail.com

Tested on:

commit:         55027e68 Merge tag 'input-for-v6.10-rc5' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16ea803a980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e40800950091403a
dashboard link: https://syzkaller.appspot.com/bug?extid=fd555292a1da3180fc82
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16eeb53e980000

Note: testing is done by a robot and is best-effort only.

