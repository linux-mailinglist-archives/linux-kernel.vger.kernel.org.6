Return-Path: <linux-kernel+bounces-293197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E819B957BEF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 05:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18C8C1C2382A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 03:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409B64D8BF;
	Tue, 20 Aug 2024 03:35:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9B94120B
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 03:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724124904; cv=none; b=T06wZexn8Z7+ccchoptT6h4dxKqgkbQD1EZW/61N/cJAC2GMthTUYBY+sz7l55j+HIM+n7meBbdB2JpNVp8nsct7lsWr5qv+NvY49zF4EfQ/XblD5IDndzsLZTQxFyr2yWqae+lDelkN1j35ZZkZCjPnzrClyZrBQeT+NnbMslI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724124904; c=relaxed/simple;
	bh=y5kYLtAXf+RlfsnoS8e176zZVIsWbvn2ptvXBGCsSzA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=R9JoRG8iLzv4HGaflI5bAzN0W94ah5zcUk/ZsHvZU2YMupo7pM1ehbhzRuL4VubJj+5WxDh2Ah1h5eew9jtxc0Yt+KVmzhKBBTUnamzF4hiX3FbrQ0W2gj1BB4gLlb97iCremjMphM6imvG2NsUueeYK1Q46IhkTi96iZq4d2i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-81f9053ac4dso518844339f.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 20:35:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724124902; x=1724729702;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/szJs6BoRGzdYBJbNBrmgpisVXSz4Pmj1YRvwy99puk=;
        b=qmS1MD7NTj3vkD8grR06ZaIUfA6RZp51KPiICGzr9TnKrQ8qju24+aoBC73bz56S61
         228TTbQf3faZo6U40oQ367JOIzLXpaOkpURyuUkMxG0mZtlFRSyQUnFenEMP3OX1VXbP
         3BmOkXUQLWYXN9Yt09zYdmFewigtAiXD1CTXu492CKDxMA7yVROr22RlkKzAzFY/UZHR
         lb7C2aDnr3f8r78e1QeAGmiDmHytbrnUSLxyLqPG0gMh9ktWyWn8oPuGvoqMzXy7oz5O
         S+Zgzm/AHDtpNUVP7fg4OM9njEo35L71VboHlfHr4vq+Q6gcFvMH/qYmV6uMXRRpm88B
         +LdA==
X-Forwarded-Encrypted: i=1; AJvYcCVnvWV76VGrTMUnbKUVc0JGq9d2VFOzreFWbrQOanK9HxWlolBTmGudjxx/K5rTe+A26iXiRPV/bSUwYn2aKsskHV4hBxPIYJqOnJve
X-Gm-Message-State: AOJu0YwdTj7v3I2rkJwttsATdYEasMAV05vX5YcNc+hP6dSCpjWMxWs7
	bgc/62NFa8Z8N2HfHMnMDRapsImzqsGNMdCAounoJvGNZ4vY2xLZDmMAJrJ7r8bCgHPCjPdgm0G
	7QENBhcX9FSdaZUf+oU/p6YTlrodtphGR1FBkaBw9fbv9iLFQ43+EhRE=
X-Google-Smtp-Source: AGHT+IFAzfh5u9rnDgZSyp28jQLeKvgtkrbnO3MFuyCAlcjGdo7+9j4Cip3O8ALNq2lhaC17t5oGvZKsIUBswygEzIVZJvdJMfmf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3fcf:b0:808:f0f7:c8d9 with SMTP id
 ca18e2360f4ac-824f26f185dmr34746139f.4.1724124902409; Mon, 19 Aug 2024
 20:35:02 -0700 (PDT)
Date: Mon, 19 Aug 2024 20:35:02 -0700
In-Reply-To: <0000000000002ec51a061cea9292@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005b56630620151ca4@google.com>
Subject: Re: [syzbot] [bcachefs?] kernel BUG in bch2_bio_compress
From: syzbot <syzbot+cf190b6276e5bd33a108@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 2744e5c9eb1a1090b5f61c955e934c70bfe6b04c
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Wed Dec 27 23:31:46 2023 +0000

    bcachefs: KEY_TYPE_accounting

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1120e9f5980000
start commit:   34afb82a3c67 Merge tag '6.10-rc6-smb3-server-fixes' of git..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=42a432cfd0e579e0
dashboard link: https://syzkaller.appspot.com/bug?extid=cf190b6276e5bd33a108
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14109821980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1235f47e980000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: bcachefs: KEY_TYPE_accounting

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

