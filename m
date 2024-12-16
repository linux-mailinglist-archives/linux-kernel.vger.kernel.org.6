Return-Path: <linux-kernel+bounces-447500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F19AD9F3371
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 15:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1926C162444
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 14:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE63206268;
	Mon, 16 Dec 2024 14:45:07 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52CA205E07
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 14:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734360307; cv=none; b=d4w5NKaGhyuAcDuT9mVqg656IPjcpwf0YtR6sQNn9pqmPZdEjCIh6lXgwBdC1IcsArlCgWwX8gRfkJzIw4OGiRp4+1ZbMXhwm0obrjHcwmj0I9ZK36Zrf7BviZk7gJiRbnPv/WCDVxxK1jNdDw7bcipE8KOtsaHgo38R4Z6x9zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734360307; c=relaxed/simple;
	bh=MeHEuhQepoxNaqynlADtqkvSSL+SjPmEfOBq6GjP3DE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jqHmQ7WRu6oFy7fy/aKa2fRqY6NWFhDgrDPpti1PGn9ox8yX7GJ33572CpY9MLsYh3dPgjrjQhVyxGk0/bYvOZA7mVP2MZJEPe+8+rE98ZIeshjc9RpV/50xeUT6NMuQr3umh/+uhKINWTjcGkFTjBwa9qTZAfonIHG4ZGy0Jrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a7e0d7b804so42301675ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 06:45:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734360305; x=1734965105;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zsTY+6Eei+Wj6dlOGvdUNtY0A/7RtEMnbX2YjoXbN7I=;
        b=SfZzexex/Fb9WC2zFcI0yDnLuFXVtjH+07GuwmfG6UDrdXfrTtNTzmIL8xjYhaXbfO
         2tLQm/Tu6ybGVlI2BQhbAJTSgqjdgnfHeTHEMQ/Og+JYjekSLvetBiqLETYW2NgbtNcJ
         Y0sbPeMCcNieJGtD0/952E7D/nyqykrMmDmIm7am7kCkDd3XR42PBFThWRZHuvTNnUDZ
         Ngxf7Fo09XHCbdUY8kdBnLYkFYPubuIXSIr3wqo2GVlybO3F4Y5Jh9emaa0W8cGh1RZS
         Vgluiso0zIKjQcVqfOtfTGbZVQjRAb3/s1jfUwQ9g0K1ZCEXbm/f4jqoJGw88115lRl6
         66qg==
X-Forwarded-Encrypted: i=1; AJvYcCWuvViN1jUJHKtr8Nfd/6Ufmadj+N67Br87g/5vGCwufO/eafzgVVw3MKvhdqIv8tefOA89uvazsBF7e2w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMtTwN7hEbW1FBjWG1/ymaC8xWsqwJUGSoNvdO7HZmpQQWVD+y
	yVDGiVFE4/V1TwgqK297zp2zBOmSqwd9Rl/5s0z8y4UBi0Mt4AT/0X4+ELiTVw31hTTooeK36fe
	BoNaPYV0zU4l+uiISyqSvIHyXZSAF/kyjII+1M/nh+P0esbTlEILfmUc=
X-Google-Smtp-Source: AGHT+IF+UEjDFsp7npLxCsuXN/ec8UhLBIe6e/EQ9T9WYCsDmh6sYALsBrNOF3IeziPj+SKtBLxcPNt/tIA/Wy5xvzAr1mREg27B
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d03:b0:3a7:c3aa:a82b with SMTP id
 e9e14a558f8ab-3aff62132bcmr147523785ab.1.1734360305048; Mon, 16 Dec 2024
 06:45:05 -0800 (PST)
Date: Mon, 16 Dec 2024 06:45:05 -0800
In-Reply-To: <20241216105219.nV527%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67603cf1.050a0220.37aaf.0133.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] kernel BUG in ocfs2_commit_truncate
From: syzbot <syzbot+c16daba279a1161acfb0@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

drivers/gpu/drm/i915/gt/intel_rc6.c:139:19: error: static assertion expression is not an integral constant expression
drivers/gpu/drm/i915/gt/intel_rc6.c:140:12: error: static assertion expression is not an integral constant expression


Tested on:

commit:         e25c8d66 Add linux-next specific files for 20241216
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=76f158395f6f15fd
dashboard link: https://syzkaller.appspot.com/bug?extid=c16daba279a1161acfb0
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11bc34f8580000


