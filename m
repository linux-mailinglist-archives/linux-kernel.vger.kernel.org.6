Return-Path: <linux-kernel+bounces-444455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 894959F0721
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 10:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1974188B544
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 09:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235021AD3F6;
	Fri, 13 Dec 2024 09:02:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AB1187849
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 09:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734080525; cv=none; b=gaPTTsLyAloo+KLSAXSbianI0ngyg8jwC0zVFS6TFK6Ss3mcBPk1Fk7XVjr15p1n6GS1zWVUc/ZaY1mzXwVdX87wvGwKki40m4vTSDG2M2VT1MACwcqWtAPU4DPb2+X/z1cKfZxpe6ZcLsK2XgYt+u1lfF8xAA9cBF3RjWA2wFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734080525; c=relaxed/simple;
	bh=2+V0gwWPQz1NuPbnIpZtwwiE9CPyu8+0woDQ4WTzKLc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qTdSEKC6zzMSAghiMw4Xw9/VLj/Ujz6ElChBPViXhlusje22NVvVQ9OZWv0Ao0c7uuAWFSqiu411P9RGMj20zpNCctfUN4fbUwr7DpJTwbNa3xMV7hDwjAf6nKiraX0OxodRs5cJI+Ft3T4s6+VazPjJ6DS+J5mCdse5S5tS3oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a7d85ab308so13117275ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 01:02:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734080523; x=1734685323;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qkdsc3kIvIfyL5IYCelomfyRla5cY9l9wN20S750FlA=;
        b=gPJNHNh32opEFhXiOw6bkhiKMizuwcNPDd00gI4SJuKXv0jJiONLYowuhHXm785C/p
         LjpHkNbVNqHBfqMVoxdH7MpsWoGdoxAVMZ/uXOw7G3HL5CE4wN4sWQKsReVftfMkT2Qb
         bdZzOuntazRm5SQlgO7+hCNbYROSlHcdy9Y/SNtVc/3mkLZr+AFaOJ21pAGILEGK+fZZ
         PZwCVIXFTmYQU8wuaTQojhd93vY8C6oA5vi0+LQiZToaBhXtNvt+/jZYFpc2XFQYEjQJ
         0SAFYoeTwUM8Gugy2V3db5W0cjHxgihkm5f7WEIU76wZ6UvLgG/FERM4TlI5RA3rXr9H
         Phlg==
X-Gm-Message-State: AOJu0Yzv3PccAFi/p7URkYTcQTngR8TSJhimVuU6xUO+PRzv8l12lJHe
	q0d2I16dg9gxmSLzppCJJlyTOcuUXMFqEFL0myt7t5ohYlJQqiNM3MoxbESv09cL5xgD4U8NpKF
	TJMTqE5ijEdyNdPGuWjd6rq/aFnyPOwrLUAOGZ+gy0CzPbjuOMe/NCXE=
X-Google-Smtp-Source: AGHT+IF2qUcbbm68o92Ttfbo7+Pnc1lhW5apPea3WZELCarrAYJPAZJssbIeXM/djN+1dv0jbkR5EPyd97VoOk2XQojROeBy501l
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a25:b0:3a7:e528:6ee6 with SMTP id
 e9e14a558f8ab-3aff039a554mr20837315ab.13.1734080523354; Fri, 13 Dec 2024
 01:02:03 -0800 (PST)
Date: Fri, 13 Dec 2024 01:02:03 -0800
In-Reply-To: <20241213082402.1808426-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675bf80b.050a0220.1a2d0d.0005.GAE@google.com>
Subject: Re: [syzbot] [ntfs3?] possible deadlock in mark_as_free_ex (2)
From: syzbot <syzbot+8df514c431bd240c5644@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+8df514c431bd240c5644@syzkaller.appspotmail.com
Tested-by: syzbot+8df514c431bd240c5644@syzkaller.appspotmail.com

Tested on:

commit:         f932fb9b Merge tag 'v6.13-rc2-ksmbd-server-fixes' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=174dc4f8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c7c9f223bfe8924e
dashboard link: https://syzkaller.appspot.com/bug?extid=8df514c431bd240c5644
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=156f6a0f980000

Note: testing is done by a robot and is best-effort only.

