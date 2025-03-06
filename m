Return-Path: <linux-kernel+bounces-548946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54751A54B3C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 13:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A642A1896D47
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 12:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24351FF5FF;
	Thu,  6 Mar 2025 12:54:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098F41F5FD
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 12:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741265646; cv=none; b=pm6dpR9F0vjWPxplIdU+ynFCgSqULo+BcZE3BTR6B/QAtfwLd9ua8o1pzWYU0q301IHi677wWH2nQ53XdbixI+BrNgM4BcTGDXuYh9cGNvCHSSYMaU7dcvcS93iYIGrh9wEOe05LeeL2EybJMSrNs7M2A38Hn6bzd9DssKaIt2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741265646; c=relaxed/simple;
	bh=ty5L/uryJDvHGbVrQm+/VIO4X0GS68Pg5bNdkh6lsVE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=nmw0QQcDsxp14vy7hXDEvU0t4Y/aJePHkVMtwm5qbQBVx8zcexuuZo0f5b565y0h2ffakIuKo3qvXUYd1M7l7kCNdq4aJp8KE9O+9p1eP4Ot5k2Wqlx9xKfKctSob4YsVcQ6bbTegFmBlQEo3fZFBAr8x7tdyiFG3Yz5HK7ZPh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3d3decc7b4cso4652825ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 04:54:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741265644; x=1741870444;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cqc7rplTKmQV7uqrftINjNhQmisaZdXxhTgKBl8N+9g=;
        b=gR4UC6NYvOymnCd9xUR/4lBEKmmI+QkQS/BIkFCNWf7BgfoI1RsvbaKM4THsdDdBtT
         8SOfY6Sfg5+rIz4JZM2Q/V/E6OFF0gFrNREdIO13btz4/lQyTFMfR6kkgomWxDpB9b6I
         5CYxcIh1FXFuKRqb6ACYgdwl1KCo0NLaecNaqT4Jwy/ZICH/RZ++Jexktelrpe20ZLrR
         L2NAqSOu7akXcGSpgx0Sl69I1GxNxsRxLUszYzjKC5YeWSsPWlajEBvjISDPnyw09hCR
         HL5FlyOT0AggY6DFfSHAueviQiwVIyqmfAKlUzL9PCDU411q6WgQj/ynzOWTCQewhwqK
         rMkA==
X-Forwarded-Encrypted: i=1; AJvYcCVjg9xSe0fL/q09GAglcbdpgu35/91xOZxrbv6EDBnpErLJkQn3ZcbHwzJi7F5+BNeyTBcdmc09LioSbik=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPxTGYSStUwISHy5E8yNJJQcwH9G99+eOetiWGJenBohszcjmj
	8l47UAmHqHw6gKuwIWEdJO2u5DEU+UqbHv6l27ScRYEV9xNanpWmLZZKJHHwBNFKj7v6rGW/njP
	vzVCqC1ag16kuslgMSC3ca4u15rHPg+lM3VrK49KV+2+N/P4q29Q8Bw8=
X-Google-Smtp-Source: AGHT+IFSm/FYnBsLSX8C4pZouDKXSN6EhP+0Ax7VsFkuzJzxBXxKjODS9u4XWXMXms/8YKxRgoBoCVa2fqah7NAmu5d67v839CrS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:160a:b0:3d4:3fbf:967d with SMTP id
 e9e14a558f8ab-3d43fcedbc4mr5200905ab.7.1741265644174; Thu, 06 Mar 2025
 04:54:04 -0800 (PST)
Date: Thu, 06 Mar 2025 04:54:04 -0800
In-Reply-To: <tencent_B91EEF32CDAC780A6FF82FD56DE49590EB0A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67c99aec.050a0220.15b4b9.0034.GAE@google.com>
Subject: Re: [syzbot] [xfs?] [mm?] WARNING: bad unlock balance in __mm_populate
From: syzbot <syzbot+8f9f411152c9539f4e59@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/for-kernelci: failed to run ["git" "fetch" "--force" "433dfd5a8a5d80bbf0669b14e9ed908911a52dd6" "for-kernelci"]: exit status 128
fatal: read error: Connection reset by peer



Tested on:

commit:         [unknown 
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
kernel config:  https://syzkaller.appspot.com/x/.config?x=d6b7e15dc5b5e776
dashboard link: https://syzkaller.appspot.com/bug?extid=8f9f411152c9539f4e59
compiler:       
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17774a54580000


