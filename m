Return-Path: <linux-kernel+bounces-226220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 295BB913BB1
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 16:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D4CB1C20358
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 14:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11CCA181BA4;
	Sun, 23 Jun 2024 14:16:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B0412FB09
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 14:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719152164; cv=none; b=Qoj0gbCA6v9/sbfjS35lTQMm0KtVdpmYidXV4fYdTiczOle8ByAo6a6KgrJ5qlgdVtkOqF63q1Lk/oICa8DHp49VR/L/eAZF4aMr87M8wKtP3amNBGxpLYzfzap+4oGLkd16sRf92w/XEjZm3XrPk+d9EBnLvMdckTZ1M7ks7jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719152164; c=relaxed/simple;
	bh=E2raSBiLlF6ZZrYJtu9CjAs3g1IwzOHuG0mhMVvUaew=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=WBc/n6N9+cYXR8hJj/ATqNwXsU9RXUS4y0GiQm9HjTk09RxS1opIS4RbjxM13rpp3ZXWpyuL8hxKc1runX40V0Xlbesvya6iCjX2KFMnES2OFtW9djWB5EkKi0dPuezzS6dEDtsrifP7mgqUXa1cOKdLHtYg4rR24N+COZIS9zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-37625537d64so47273835ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 07:16:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719152162; x=1719756962;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pel9CcDiejXovINpVpgIZJc7ZERUxuUiUUus/5uKjgk=;
        b=XO7ar7AEtL8gRcKqpMA6zcYSwQeE9U0++19fz8uZK1Kka5wcoLSqUTewQW9TIB0jRx
         U6IFn2Ny7kp9Dldtek/gzOZJsGDW9A3UkBUFStqPF2X162Hkby9I2qOo1XC6dRXqb8YS
         NoGvFyxiLfSSrw6ONbfOSSTRR7gQSXTdC+Gaw9yzjtdKoRF8yz8oP5JcqpR1kg0SZPj9
         xpxWLihdytS6QSfYK0JscfSVQbGV7tDbBwx7ucBdL75NjRyxQfXrEyill5j9nrGOcYRM
         gdmkb/zUhfL0qdG4FpVbUmek+vPpUwtZTpknbNbUCWUHskNrnlcY5ryKYDFYqtPHxx0B
         jN0g==
X-Forwarded-Encrypted: i=1; AJvYcCU2XScdgQYokIRle37x6s/EKUt8qfmUSky2aivJ5AFFXwtLONVzO61krsaAEVaKdiMZE0iuZRr/O1KFjS2oahJJY7wpctNRj13IeGcE
X-Gm-Message-State: AOJu0YwMv4BVj6A0zfMmphYkLVZ5JgB0TloIyy34qJmutf1WypEjD6dX
	WN5LWMFkR5yrW4l49XN/iMZ4XaQPUQxZLAkyYyvapWIJyTYrYtfHbKQKRfKdBY1J+0uStKzKNYf
	cPwL/llvfrnyQ+mkxqEF7rDKkyVPJlt/lK0BOnFD1Yr0/8FYI+JEB5jg=
X-Google-Smtp-Source: AGHT+IG8/bc0B1SxFcwIatsKxz3UzZ1OnvzxsTMhPSaXbMhL1/kzVyN1dXRGtpl7ExZxqsd3Cvg0TY9w7hNgt9TxoMo1UwOaBFU4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c9:b0:376:44f6:a998 with SMTP id
 e9e14a558f8ab-37644f6ab3fmr1174805ab.5.1719152162439; Sun, 23 Jun 2024
 07:16:02 -0700 (PDT)
Date: Sun, 23 Jun 2024 07:16:02 -0700
In-Reply-To: <0000000000006d96200611de3986@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f51641061b8f4d2c@google.com>
Subject: Re: [syzbot] [media?] INFO: task hung in cec_claim_log_addrs
From: syzbot <syzbot+116b65a23bc791ae49a6@syzkaller.appspotmail.com>
To: bryan.odonoghue@linaro.org, eadavis@qq.com, hdanton@sina.com, 
	hverkuil-cisco@xs4all.nl, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, mchehab@kernel.org, ribalda@chromium.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 2998b976300d087db739f044a105c88573f031d4
Author: Ricardo Ribalda <ribalda@chromium.org>
Date:   Mon Apr 29 15:04:52 2024 +0000

    media: common: saa7146: Use min macro

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17ba1dda980000
start commit:   45ec2f5f6ed3 Merge tag 'mtd/fixes-for-6.8-rc7' of git://gi..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=fad652894fc96962
dashboard link: https://syzkaller.appspot.com/bug?extid=116b65a23bc791ae49a6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11b2f122180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11fd704c180000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: media: common: saa7146: Use min macro

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

