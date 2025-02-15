Return-Path: <linux-kernel+bounces-516025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C62A36C29
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 06:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D95F171513
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 05:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC8F1714CF;
	Sat, 15 Feb 2025 05:38:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FE3C8E0
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 05:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739597886; cv=none; b=NOQzzEukhil/yHybnvk5IEOaY2HMWt6SKWCygBchQPw1GYKWWLg0GgKRoJ2ZWA0pox1mw4OvCi7a2PNBHqTpqIVL9eedK8sXpzGkeGPWHf7VXJ5sA5xTHOtppGZGhXRJFWFhgQI9djHtD8TuSplb0DJZCHRVoXmOttqGAfFLitU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739597886; c=relaxed/simple;
	bh=fnxAQ+MdB4DuLr9nNQJDAmcCNBONNj7VAZNtU8W4GFg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=cUHFKDyFP0fkn6JFQRixIXXtoLcSA7Ajg7e7pxaVsZQuF+t3Iaj+GVPG3XPis8HHcX6/duEfd2YZqr0Kc+AGiwycBo9XKvNwLoV/OX9O2lHfgrnjjkXEbjydZcubz3DmIyBOd2RkAejla5dQ9mYnjMIKgmp8UNJmtFkYLsFZqTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3d2858ce843so1018475ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 21:38:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739597884; x=1740202684;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=np8YyfLuF0z3hOpmxAPOYKyOl3Hl39AGi/B1uJhneLQ=;
        b=cnJeIWek6OLxGvPJSYEEZ0uzPxgpaLoLAG611+m2jpoPoARRRx47fuA1Yfx7CVVSIe
         uGaL3T5z4XUJR05J8m6YTeJRqkcQGF44ulEyvdXLRcWP5ii0+HfQYh3R2zSDoXMYluZP
         aLYcZcrSSAXgXbBYOb+kFvDBMbepJj31vbB6DrO/FE1JWTOBbEZ2NNPcwEZRU5sMjrnO
         5uMwlMeGTzpRkyljAllHTygEy9CAAODU7xcSrSDCYZRZxoAV3j6uDo64UY7V+e8wk6lE
         /26FQbmYSQ3FpbTu1GHMcNPD4HDv2KKyzGv5xpjxGMk3ttAeZE5Tk9SxZuYI8NEPYfTT
         ikfA==
X-Forwarded-Encrypted: i=1; AJvYcCUpPWwGvD60+tB34Psqm4g3/pi7hI7MXfa8wAyCRSnONz5QfK7+peppKbJUYaNDTTo0ay/KfAH0GFEWe1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YypSUSrS5ikrgLmDIDlLlJ6YHpHxrpbDFYG97M70wvP1VLlga/u
	Raibx7mSuzlS0XqYXN4Ky1dml0P4ACJE+pcBcXWc9jOXenZnl6VZ9l6YSRyKyTZw6tvOLa6zkdx
	0E40M4r7qII+9Pn5LDnm6GpQHwhZeUKdxwrvCQSAaWMonyG0RMhy7igQ=
X-Google-Smtp-Source: AGHT+IHltDVOjN0wN/m2+QsFxSASCD49OD+zcSUEdaLRbxjmFWdKY8nZVEw3ZEhs4qb9yfzTAIQvRwczTWhk8xLAKrNJYVmfGmuJ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3487:b0:3cf:b365:dcf0 with SMTP id
 e9e14a558f8ab-3d280970b44mr15155375ab.19.1739597883944; Fri, 14 Feb 2025
 21:38:03 -0800 (PST)
Date: Fri, 14 Feb 2025 21:38:03 -0800
In-Reply-To: <tencent_08922ECA6EE0CCB467D606C852E9464B0906@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b0283b.050a0220.21dd3.0068.GAE@google.com>
Subject: Re: [syzbot] [netfs?] KASAN: slab-use-after-free Write in io_submit_one
From: syzbot <syzbot+e1dc29a4daf3f8051130@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+e1dc29a4daf3f8051130@syzkaller.appspotmail.com
Tested-by: syzbot+e1dc29a4daf3f8051130@syzkaller.appspotmail.com

Tested on:

commit:         7ff71e6d Merge tag 'alpha-fixes-v6.14-rc2' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13abd9b0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c09dc55ba7f798e3
dashboard link: https://syzkaller.appspot.com/bug?extid=e1dc29a4daf3f8051130
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11924bf8580000

Note: testing is done by a robot and is best-effort only.

