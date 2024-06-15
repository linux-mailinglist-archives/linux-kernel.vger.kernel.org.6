Return-Path: <linux-kernel+bounces-215749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBF290969A
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 09:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 040BB1C21BC8
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 07:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3846C17BCA;
	Sat, 15 Jun 2024 07:42:06 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7849460
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 07:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718437325; cv=none; b=AmIK81E7mn5UOsTgfCKp6i4/2MuLYE/BXDyGv1xdVYfbO8De1WZc7Zs1Ukk3WPqq0sfWHnK8JuokX2BqZFSiErOlHAeg9TcHLH/mFXUhLM60KyHhk6iqHZF6/3EkTgNN5l8A62mNuLSvTlSQuF6XhaOrSss3+MukbuR5y+AqSkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718437325; c=relaxed/simple;
	bh=vKbR3YmV5HKjnPOzT8z+Bv1zytBUg88OP1fqBO9y4aI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=OSEtUaFEUVzUpDI6/CTyD8akXH635unv65rZUzcxodRYRiUFNVSI3qK8qBil4gtGRMivYQxnajS1YIh7rPM+syohuuU9bGp3dOKpezqfhPzcAWE4EdMwSOImhOfVDzhW62ugOhpRSiT4QeOxJL/cm7zD7GNQDHTah1+jSWQvBSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7eb6fd69f7cso321161239f.2
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 00:42:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718437323; x=1719042123;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5GG0pZmANriFts1n0ieKEUFKhMov+dueEB8KSrCui0Y=;
        b=jKMBUazob823G9s9puAH0AEXzqBpAdRgkDAqQy330reWAZrjwMgMJai5cex/tIfUA5
         0PA4Wl7JJHkRQyJKFyHPM93UGAeghXenPUtCYk4MD0VQBXGBkkpBkDzMOFji0i4EnxgE
         6VKQPnXWqGdtlLhQe2rIBMyxiShY6vK813XkoCeZBZNiyDFiEdtMdWpsk7FMDo/LfDQ9
         0Im4HbtLSi4W3Dj74AVH0/KczFJOtXCzTbgBwtijSDOt3ne+juE6kzeYJfZZSli3m7lg
         VQGVZ6MDgkLNxzl+g84v2yAhVFBSe5lCtIjStM0j0ec0YMfoHWuuZ93G7pCLw0VLl1+I
         5s5Q==
X-Gm-Message-State: AOJu0Yw+K2UhuXarsOMDZPn4iPeC6SI9JwGm6r5XYuKVXenWIielw8dt
	oE+hRPlp4Sg/oNK4OGPb0PrJfhW5+zSdTVHSl9YSJKi0ORYBgNdvLRfy5XOMDvdcVfpd/tu3/81
	RiGR9BHHzhoCsx2K5amH0/ndHh5+rQFmEkg6MtmbKODd+9CwK4izdmKQ=
X-Google-Smtp-Source: AGHT+IEegqMH2DnsRBc96Jd8x3v0QFS1YItrzMKxt3XRgwT/EN8Oa69TJHwZuiWybDlqcD+YNfY91/0aOWrUwKFoXZFsjqTx0KkT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1607:b0:7eb:8ba3:2b87 with SMTP id
 ca18e2360f4ac-7ebeb628d35mr10921439f.2.1718437323634; Sat, 15 Jun 2024
 00:42:03 -0700 (PDT)
Date: Sat, 15 Jun 2024 00:42:03 -0700
In-Reply-To: <20240614120103.27422-1-wojciech.gladysz@infogain.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003e95b0061ae8ded7@google.com>
Subject: Re: [syzbot] [net?] [bpf?] KMSAN: uninit-value in sock_hash_delete_elem
From: syzbot <syzbot+c33bff5d5da1391df027@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	wojciech.gladysz@infogain.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+c33bff5d5da1391df027@syzkaller.appspotmail.com

Tested on:

commit:         e478cf26 Merge branch 'bpf-fix-a-couple-of-test-failur..
git tree:       https://linux.googlesource.com/linux/kernel/git/torvalds/linux
console output: https://syzkaller.appspot.com/x/log.txt?x=140ab12e980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e2599baf258ef795
dashboard link: https://syzkaller.appspot.com/bug?extid=c33bff5d5da1391df027
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=168670b6980000

Note: testing is done by a robot and is best-effort only.

