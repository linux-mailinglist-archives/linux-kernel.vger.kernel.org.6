Return-Path: <linux-kernel+bounces-311140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B13968551
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 12:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1BB52855A9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F2D13B5B6;
	Mon,  2 Sep 2024 10:53:07 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461C713AD18
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 10:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725274386; cv=none; b=kJaIe/b11JBfJp+IROUfdhRIIilzuQTrwLxvVO0STi8lbkw5/CQc/3tF6iz1fOLSXfGG65idUvk4rtkBNHhv2F+NhLNp/JFpMTMPYRprjeL7oxcaU16MaDl+wCSRQaYbQ8YjOJxffWtYdw/7cpuS4jLfPfJBsK8Nkuhq/SzA66g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725274386; c=relaxed/simple;
	bh=oWhd4Rf0zHHpbpst9n9x+vifq8Bnir5pNyheMKTt/fQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=rqFg2XvO7Q+ZwIHgS5aQnQM/H/DrogBEXOmy5Jn248gOZDaugVdcFp0mGTXp3kl8ZIQOqm0pSyhfTieY+KCY2DiPfLGi6AZX4g/3ykxWZPS/E900ekCpNwnStbiJS0IHJDj0IFCGruSaa8nlfIEe3h5G/ln3ULQQqx14rdRdX0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-82a2cd95bf7so357536039f.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 03:53:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725274384; x=1725879184;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KRPnLHsiu9UwQQIF05EoEjumpQG8FgwHNRyv/yjcl8I=;
        b=d7KOKLZuoNOA1K2e6D6UGs0qTdufc71iAOZG/0/hzfPUgvuhOE9UbR0g+iLtcRnXUw
         uNH3faDy7NXXCorNKGsCAqcfmWUb/oBQr0b2+WsJ4MoIXHosDW1i9mgSek/pzv2g8ubp
         E6zaLxNItbxmZhPQk1CriVLVzCo/wc3CIcyCVSmEa1mUcwFIt+BzZ2dscUmhDB4aT4Hr
         UQSi5R1ynzUzZwIpXY4YIiibxfKZZvPwBrbUHgnOHU31gI0a57ALUXVzJXYLMUWVVsCl
         OUU8TL2v2DZ4zKAEPAxDQPBIzWd1NJGcTLKJ1UmODJbF0Rrggie9mGN7o0Eu1xxJnhzT
         RO2g==
X-Forwarded-Encrypted: i=1; AJvYcCW+uNC/TTPjjKkfu2ZT9HVUz8q4ak6fmH2t2u/eQI9I0OMh6XvNqBVYN45Y2GY0OIInclAAgQUxqaGaaQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUuDC3bCv7hONyCwwigguFjU+E/D5Jt7gacZ7wCb/I4BUafrJD
	CCNHiaPh9JG/IRVUqkOGdqjSdjnHywH3Lv4CRjvkrbtO449F0MyoXqaVCoDy3v4hGtOkLa2B1Do
	mlOiS/jjzNhlA/0NO2cP5JlYK88VLUThDHyokBciBR3q0bnJSUpF1AD0=
X-Google-Smtp-Source: AGHT+IHZrX5x+ddAmSe22mb55IktNZwUNEVFFkWhX/k6jYUcdMLP4AIIqXZgJiGhfVkY/uP4CjKDxwJZ4R27HzDpYzvkC1APeXZu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1489:b0:397:ca8e:d377 with SMTP id
 e9e14a558f8ab-39f40e1f884mr10470655ab.0.1725274384455; Mon, 02 Sep 2024
 03:53:04 -0700 (PDT)
Date: Mon, 02 Sep 2024 03:53:04 -0700
In-Reply-To: <0000000000004169f9061ceadd8a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d369bd062120bed7@google.com>
Subject: Re: [syzbot] [bcachefs?] kernel BUG in bch2_journal_noflush_seq
From: syzbot <syzbot+85700120f75fc10d4e18@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 2744e5c9eb1a1090b5f61c955e934c70bfe6b04c
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Wed Dec 27 23:31:46 2023 +0000

    bcachefs: KEY_TYPE_accounting

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10761263980000
start commit:   1dd28064d416 Merge tag 'integrity-v6.10-fix' of ssh://ra.k..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=1ace69f521989b1f
dashboard link: https://syzkaller.appspot.com/bug?extid=85700120f75fc10d4e18
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=120f9c9e980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=158b8d69980000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: bcachefs: KEY_TYPE_accounting

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

