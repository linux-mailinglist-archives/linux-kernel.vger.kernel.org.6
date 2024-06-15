Return-Path: <linux-kernel+bounces-215925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 351799098E8
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 17:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C50ED283412
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 15:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ECAD49651;
	Sat, 15 Jun 2024 15:25:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A714964F
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 15:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718465104; cv=none; b=LaY+ehTTXDhaiUW6Et55xzytTDqXrh0N9JTs528I7PacxyZGJLnOz5LJJsqi4gMCOXTV8+woxFf2bKBe5x/9cddddVaONGM0HWFTRkBepa/lD/Fzmht/cf9AV0rCELNylvtJn+uHv1Aq1pSu1wb54vswpXoPO08faDVGiPPfIpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718465104; c=relaxed/simple;
	bh=cnW4B7mbDjk6hIbBfCRVS3xZoHynTXERACd29rkKW2Y=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=eQJ+IHxbvoTqAKXECliqZNDxP/XEYo/UsQympJIIz3/mRsDksXivJFZUJC4qNYcokGIZbz90TJWgsKUv6Uqm6xQShyfIDUU/BwTbN0L6C+kb0wbmCY292fy+DsCObGtmocM7t9WXBwqaWiGbr5qSE/8jXbjVfgQZM7IsA00lYY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-375a1820034so29422775ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 08:25:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718465102; x=1719069902;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8X+/uE/OiCeFGpbGY8IRnC0qauwK67bfUI5GLX6vY7Q=;
        b=ScQvVd9Qx+pvRW9h7Ley9A4Pfw9byEIlqEpHkk+MNv78eTqYoJIjKzroysNrBsx82y
         zWGrws5dxYcL+yWVOXFmnGvn02C1EgCrp0L0GvAWhLEzY3QN671AK5EG2TqiL8igpCTK
         PnV5+oUHg9TYvE7pwPnm95wnT0RBCQjXhVJKi7OvccjeseVmQ093gGBpjN3xeUvhD5R7
         SUzabgZrKFCV/FvDImjxJN9nHt/kiPb+q7BQRA9cb4378+rL/eVx5B+37cNyaORLplwm
         wKMojsWwi/g7wKvOQV1cM/Km9IHIcE0r+UNq+PAhBmOoOSoor1kilBO6ftcEbZ8hqZDj
         A5zQ==
X-Forwarded-Encrypted: i=1; AJvYcCUP4S1zipQqeuTQuiMbI/qd2V8u1S4Rb9HeQtqJJx5njONmNpaey8zltkmTmPbBRymUNadD7yeypua8qQx2jqnlG4y1/l41CCZI58nc
X-Gm-Message-State: AOJu0YxILKCZuumQ6xyQc9MK1vpHZ8ZY016TlKsP5h3SL4sPQt38JP0H
	5H1T4nL++HUKlTsQ4goRZzpV0FVMRSQfMIH92wTLt1ZihWjRQ9mHWE7zcMi4cY6fJ+v+QBggYAe
	uMMDuwBOoNxc78owapQ//EtTx7L+LeZvYypBJ1+dkJEb6HY3ATrc+rRU=
X-Google-Smtp-Source: AGHT+IE8myWKCIqi77HLxHCTYWUG61sJiBrxv+8CFI9momLEnkqdkHx6s9TnonudR64GBIbN3/S1DnYCHCeC77G5jn2q31zyqoSX
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c246:0:b0:374:9af0:5f5a with SMTP id
 e9e14a558f8ab-375e10bbc63mr3367595ab.6.1718465102695; Sat, 15 Jun 2024
 08:25:02 -0700 (PDT)
Date: Sat, 15 Jun 2024 08:25:02 -0700
In-Reply-To: <tencent_7C660A3DDB361896D036564A16742F776B09@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000162aa061aef567a@google.com>
Subject: Re: [syzbot] [bluetooth?] general protection fault in l2cap_sock_recv_cb
From: syzbot <syzbot+b7f6f8c9303466e16c8a@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+b7f6f8c9303466e16c8a@syzkaller.appspotmail.com

Tested on:

commit:         cc8ed4d0 Merge tag 'drm-fixes-2024-06-01' of https://g..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=12cd11de980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=47d282ddffae809f
dashboard link: https://syzkaller.appspot.com/bug?extid=b7f6f8c9303466e16c8a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1572de56980000

Note: testing is done by a robot and is best-effort only.

