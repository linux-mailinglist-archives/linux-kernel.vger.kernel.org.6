Return-Path: <linux-kernel+bounces-207353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30BBA90160A
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 13:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBE571F215EF
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 11:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351673A29A;
	Sun,  9 Jun 2024 11:56:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8032233A
	for <linux-kernel@vger.kernel.org>; Sun,  9 Jun 2024 11:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717934164; cv=none; b=Cz9ai4vl2prFrX/gfECvOIj6iLKxRZHY0wZ1D9JfxJPzVbDf8G6QhssL6lRUSXTxVU/h9TS3cF7rDuDLvKDU0gcAE/WveXsYQEFaanLwZRqXrFjsvo+DMlD+ZDDxulVKtZos2dI34eHTNRS09cgFhvxHm90uwl88uSUO5EiVPmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717934164; c=relaxed/simple;
	bh=0wthAHWWXg8VRJ5D8GCyNjy6NqCRsMXmZ/TXbbb9RPs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Ire1UCHmkuCVPi2RzyapEarJXviaxbeGXiVzw7IW68c0Uq1NW6d2ottqKIKFarccvEjZcIGyirVu8PLdffw5SlwjJvEsDea0Bof9IiP2XweXS5zEVYkYPNmdNyJtUJtFIaOSLm/7116SuPz2mfk2dstJBGOrEtVbeMlReTmr6CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7eb73f0683cso122804539f.2
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2024 04:56:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717934162; x=1718538962;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qYXn/mt2Wh9gdlczMx1OhQNOOM+vEMkaX4d7adxLSww=;
        b=UwcinjZdDvOeENQzLiMKYlcevrQFq5k5KwsxPgiVDsyWfg4sQ6CT4qHtaR7uZ7qUVl
         6I6hwuzumuGO6RemtTSDivT1dW8K2yoJ48tcMN2kRvVrplyIzbLaRm0iu9uQJUYMUYq+
         8RMG8bCbSEn58wBgqjkXpP/2GE2EK0QqmoXTI56sy/4UfSIGYZ+T1OycFuTxm2LRyE0F
         RvxL6S18bXmfnE1kUO+Sg/q4q+YuIKzBdE1rzVUw1rBkmeYGN9UIuktPHZi/G9G7gSxN
         kw8WqDyJ1Hwii6pyn0r2fDkSA57sA2b1iPJf1vTwyNpa2KUHjYID/X40QRXMnoDmHV7X
         d6BQ==
X-Gm-Message-State: AOJu0Yxaly4MP/YxH0Bh993Jjs94ZFMg8d8HAf44GyncDhNiFmsMOAtk
	cTZ/3F17nXhVgyhERbaY0o5x8ISLUsBKLM0heqd/GB47M6FlS0WHwwxuWS/MNcOnCTKRFcvtu/2
	uuuv54gRuVa7CEkhV3bwEaazQ/vCPkib/YM+xAFeqNrqIYKaWBb45FcU=
X-Google-Smtp-Source: AGHT+IFuadi2xH4gzB5xIYG5Xv61QU3YQ5k/pkBFq4YcQbT4BahLHJIwtaboSZD5doSmrCn/qFAEDBksu67RE0zgnNNWfnXmO16s
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2594:b0:487:100b:9212 with SMTP id
 8926c6da1cb9f-4b7b12edfdbmr372444173.3.1717934162515; Sun, 09 Jun 2024
 04:56:02 -0700 (PDT)
Date: Sun, 09 Jun 2024 04:56:02 -0700
In-Reply-To: <20240609111914.3620-1-n.zhandarovich@fintech.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008160d7061a73b7fc@google.com>
Subject: Re: [syzbot] [usb?] WARNING in cxacru_cm/usb_submit_urb
From: syzbot <syzbot+00c18ee8497dd3be6ade@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, n.zhandarovich@fintech.ru, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+00c18ee8497dd3be6ade@syzkaller.appspotmail.com

Tested on:

commit:         771ed661 Merge tag 'clk-fixes-for-linus' of git://git...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=14a0c3fc980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=67ede96756900c7c
dashboard link: https://syzkaller.appspot.com/bug?extid=00c18ee8497dd3be6ade
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1371f0ca980000

Note: testing is done by a robot and is best-effort only.

