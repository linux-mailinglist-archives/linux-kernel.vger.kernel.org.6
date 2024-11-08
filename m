Return-Path: <linux-kernel+bounces-401234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9519C177A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 09:08:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6B401F2340C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 08:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECD51DB55C;
	Fri,  8 Nov 2024 08:08:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7091D8A14
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 08:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731053285; cv=none; b=ge3K3z2BYIA0BcoDAzSDTC3vcUcLTJwD0a0BumRsZfkF2m9JxKo7skwpLid6pDYJkcY2WmEUw/crrjieWcRRCZ3QkCgOhMqlWjLp7DMGxgKCiAPaSha/+GwRGqAeviKDWH5tju0JpPDNmPzplEdsT6NK5idegkYOjAQmUrzwEKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731053285; c=relaxed/simple;
	bh=IFKGbZ6NQ8o31hKHbydY9xhlggoiqGBEQtjHqDJITNQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=fQkBD37o85z/3bjPaFzHUBeiD+ebxaauxeRVzxPPp2RVD/rKZxw1/u//p/0ed7Os9KcXuNqdIHBVBFpSGpdtuA06WE3Uiz0ufSXXh06aQldhXs33PZMtWq0EwGu1MtE0a83gx4tGiHovPly/icVyCdpkEZrsgs7NkRKtXn4fOYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3c90919a2so23502955ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 00:08:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731053283; x=1731658083;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bPX21AvoB38r72ZusRtlmFW8WZUUug2T8xpKswPTebs=;
        b=PwBLznDv4CltjAhb1A+154omS6naFbVsbEx7gCivNoQgiSFe09xUurpiGiyBWZSEfM
         f6udKZkEQ4nvmTi8XCQWCbHdmNEpFTCVFAKcr5fJqUDR4gcjrXBlmZwIMwD9qgGoZhYK
         BkSIumPv5kDhmHxXWvBW9sbWSO/hcIUxmMn5ib77xlQcnSZFaHivTSOzw7uHkvs5iwh7
         yU8HYVfuowoMDUpZBfNUwFgVgvlX/FomV1RzXREL1owYaOGoX02l+Kpe0BIi9KtoUYcd
         F+VhfJdm6x4lW47/UgOuaX+xXVlzYOzyozm4qPHU+kGK8+8NxH2wXzHV/CofcY6G9BiE
         eQww==
X-Gm-Message-State: AOJu0YxwGlqRCGddDM63NcR87pQJ2eiMwviMdAd+saF3Dbp0GpwkQorX
	o2cO6bk+hgbwmiYXHdCNTBrSXCFApVLiQ7M8BQbU3r614y4P5kX2yWjrdjui4CBm2ee77spxP+L
	hcC4HVYLKayUNgcCZOeLPkgV7m5ZgBDEz914O0vCAayuDFNXycILhvqI=
X-Google-Smtp-Source: AGHT+IGZ8hypBxT9zZtQzB3J2M6XWzHiiYBZRCF+a4wa/t28n9lrcMYM8InPwi/AYrMaFIqlbzPOzqNaTfRhTcYpw41sOr6BYh/u
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c0b:b0:3a6:ca38:6862 with SMTP id
 e9e14a558f8ab-3a6f1a48ca2mr26659885ab.19.1731053283489; Fri, 08 Nov 2024
 00:08:03 -0800 (PST)
Date: Fri, 08 Nov 2024 00:08:03 -0800
In-Reply-To: <20241108071750.839852-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672dc6e3.050a0220.69327.0004.GAE@google.com>
Subject: Re: [syzbot] [wpan?] [usb?] BUG: corrupted list in ieee802154_if_remove
From: syzbot <syzbot+985f827280dc3a6e7e92@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+985f827280dc3a6e7e92@syzkaller.appspotmail.com
Tested-by: syzbot+985f827280dc3a6e7e92@syzkaller.appspotmail.com

Tested on:

commit:         906bd684 Merge tag 'spi-fix-v6.12-rc6' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1306dd87980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=347f0ef7656eeb41
dashboard link: https://syzkaller.appspot.com/bug?extid=985f827280dc3a6e7e92
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1422c0c0580000

Note: testing is done by a robot and is best-effort only.

