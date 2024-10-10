Return-Path: <linux-kernel+bounces-358277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBAB4997C81
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 07:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65736B2388D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 05:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868CA19E7D3;
	Thu, 10 Oct 2024 05:37:07 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6CF3D66
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 05:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728538627; cv=none; b=KJ8ev3tSjhO9BzvJZo53qc/Qz72K0dKtypI3p80idPlA9oqB83t9LkWzWKNZ+GYmVINdHyHcwH6KYp41AhsvklJFEKrR1vjfAGWFDbfRmQ4KRRsWHA8PXMSNvvGjOqVMm4Z/HaYcwJKHgn9mGD5SyQOZG/2J0N8SNzND0fW13uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728538627; c=relaxed/simple;
	bh=Jnl/OQ1rRIOqKUWNHM6TsEabuhK8+F//bx41FgkJUnI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NFlGadaGbkkcAprEB21eZS5ttIi4EwzukvSzZLEF3XNc7ix0rLpjhUVKyHbY4YDtde1xOyKIhcMpbzlYySUudDfYrFSVclB0H4Ze9rU4/y7MG2tnkKkqsJ37IAfHCz5bzTQu3STkYYDhh2O7Fgcdz/OmIqT+Oi57RWcc9oBtAqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3a5f6cb13so5211535ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 22:37:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728538625; x=1729143425;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=13+TCXOZJgpkTIZELqQ1FRw3caQGG2FXhMWfnnNpML0=;
        b=bLX9CBUzAKK+uw7SSTLT2mrJw0Xw+AP5htpnzeKdhoE52YVEpHidjGGFDerULf8VMF
         6CuNsSn8VPpDPSAkOANa+CqYCbJqto6a8O8NIUakpZKLgvIvF79JLN24NXhIG3yDeVSz
         uW3QTNum5jSb6fBbs8bFJaHJ13hwJq1+qljgxqnjbAzRuO/LGhbjtZbz15Ei+QLZrnK+
         Eg/ZDWmUrXVk65ZAJjaAcP83JZhtOC7eCQGSD4G5nY4jYGTmkpUYhwpyJPn91k4w9MLo
         wmAZcQ9kh3dG6cgIF121hTn9nTa3eK/h4ERaZxO9lAaX6rDtwe1wLqiGIVo0EIzq+GGL
         FhlA==
X-Forwarded-Encrypted: i=1; AJvYcCWacTpxz9ebLB3dW0AJ/UMkRyHATCb24tThMB5o7rC+qgt8UdpFwzcFkb6FRv3c6B8tfe329dfmOMiMX+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHaQswjDd2O/qO+tmVsf72rbvURCwx6LlM6EpMEqXCjG1fS0VS
	5P9UNqO69sOdSUyHwf4lzMKPo7UXugc/QnayYpAc/M56SgHhzgma1xdt0/cg+qHYGwPILL62261
	ix0u1t2vr1ZxyMgBCiSS94Mu4dcfTO497wqTiPnZ+Kpap7XooxCzaQzc=
X-Google-Smtp-Source: AGHT+IG/zjyw3r8RmefzyIS7bS5pAsSoHNOSt0eqhJNlJtv8lxsc4iq8NEx1S8qydkxyqSL6SrF01ly9D2v9HIf/cOMa/a23RYLi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:5a8:b0:3a3:a7bf:7f85 with SMTP id
 e9e14a558f8ab-3a3a7bf80c4mr10407115ab.5.1728538624670; Wed, 09 Oct 2024
 22:37:04 -0700 (PDT)
Date: Wed, 09 Oct 2024 22:37:04 -0700
In-Reply-To: <e60dc0b7-4288-4f8a-9307-9020ab663170@gmx.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67076800.050a0220.1139e6.0018.GAE@google.com>
Subject: Re: [syzbot] [btrfs?] general protection fault in getname_kernel (2)
From: syzbot <syzbot+cee29f5a48caf10cd475@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, eadavis@qq.com, fdmanana@suse.com, 
	josef@toxicpanda.com, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, quwenruo.btrfs@gmx.com, 
	syzkaller-bugs@googlegroups.com, wqu@suse.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+cee29f5a48caf10cd475@syzkaller.appspotmail.com
Tested-by: syzbot+cee29f5a48caf10cd475@syzkaller.appspotmail.com

Tested on:

commit:         5e61ad52 btrfs: convert btrfs_buffered_write() to use ..
git tree:       https://github.com/adam900710/linux.git subpage_read
console output: https://syzkaller.appspot.com/x/log.txt?x=17f24b27980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3ec5955a0d4f6ede
dashboard link: https://syzkaller.appspot.com/bug?extid=cee29f5a48caf10cd475
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

