Return-Path: <linux-kernel+bounces-248687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2995992E0A0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 09:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C42328155F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 07:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C17D130A47;
	Thu, 11 Jul 2024 07:16:20 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A9883CC8
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 07:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720682180; cv=none; b=pTnMH0lljW6Ei/ulu2PNAlXGs+cpAmQoThnRHp/Gg6FG9OLYsiUe5QQfm+qtu/w+Mom5Uv+sNo2krEoih/QvQcMEzemEvTsL3o4zbRzqIl0xyoM5M3K9Zntgz6jMeXQXQQ/CWf8DpE8sZT5e4OTCduPfmQ3Oe6azA38xTtktdRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720682180; c=relaxed/simple;
	bh=e4CUmfHkyHFShreHo7XGOS6MwgJhiOHLwRVd6LZDkEk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jylZLC8OlsYc6stwQTK7rMm7wruawJM+7kqy0kJwXdCB4a0s7r5ltYKLH6ZdTfuBlsPdMgsUh4TzHQ8JBVwckAbVLnWsCTHKMcnaHxamHdiaM4BBSAKiTYYsGomjF6MrQSyhxBDUTB78J3kRwc+fKr3gNCgs7EQw2IREMUcKb5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7f6530b381bso68312039f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 00:16:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720682178; x=1721286978;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e4CUmfHkyHFShreHo7XGOS6MwgJhiOHLwRVd6LZDkEk=;
        b=fsPNWy7zV5vGAXEH8N2ogq+NzOGQ1yhZjlBN+P8jY8DRz9vgYO7gRGwf5+s1Q4BlZW
         KQ140VOz8b2XTprdu2aRQk72mzzhaySqB1ttsbPlQHLrlSaxqvpOkh8l7bnxvNu8mduW
         KvpcbEay0vf+HUk/JT4Jc+3BSiNeIyZ/Mg6KNIIYbxxd90Tob2Ddfaa1a9+L/ZHn7sRa
         2pR2CkRnbOaHF2s6xUe/TMjxghqioXTj8k+t3fFwn+s0wJe0hZXLAx8Uf1Ly7DbLaVpK
         tuezIEX7+NQeXBShXnw7kHdHrkkz6B1HZa3PYljlG2qbkr9eWfVOSS2w1w0VaGQUN/lR
         8Vvw==
X-Gm-Message-State: AOJu0YxwFNw0LCz/R8cs3fgfxjR3ykQ8tQuqzjBXVp4TGvcLND6CJ6tQ
	zaRqA8qcpXRVKtOBWk232fHugyayJBZpUbY7tem/Ww7Nf1qj0MzV98jzpWPu8UUzGlR84vj3Tgx
	XRfNlqMzsE3sCBC92KfS+qJzxxDSmgtruIAKuWCzw1gzBMSgHMFtE4Rg=
X-Google-Smtp-Source: AGHT+IGGvEszqloyp4QSeAcHt3/2Rp+ilrx6bU3i4vwKeaMLM1gZWOvnWy6gb/cC7Opj3sspGP6uBzd1bGB6zM1ZxP6b9wnxSCnB
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:840f:b0:4c0:9a05:44d0 with SMTP id
 8926c6da1cb9f-4c0b2869dd6mr563732173.1.1720682178115; Thu, 11 Jul 2024
 00:16:18 -0700 (PDT)
Date: Thu, 11 Jul 2024 00:16:18 -0700
In-Reply-To: <00000000000012d4ed0610537e34@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ff8f50061cf3892e@google.com>
Subject: Re: [syzbot] slab-out-of-bounds Read in mi_enum_attr
From: syzbot <syzbot+a426cde6dee8c2884b0b@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: slab-out-of-bounds Read in mi_enum_attr
Author: almaz.alexandrovich@paragon-software.com

#syz test

