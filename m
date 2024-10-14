Return-Path: <linux-kernel+bounces-364022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE4099CA01
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 14:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 712A0283090
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 12:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C29A19E961;
	Mon, 14 Oct 2024 12:24:04 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D889C7E574
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 12:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728908644; cv=none; b=Q4zVPHnbA0KA3fhMA7a/GS5aBofTWP0/RrogkOZg08YjM7IH7aMVhg320o7XLixz233XP7cIUhuzclur8tkrhRomgODVC8Vbb7A6PTwmF4R7I1xzTbWSRmbPFGo5MZK7Ch5kqHkFiN/EZMayD9W5yd4GjGLLGbmPAG77sXSFqWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728908644; c=relaxed/simple;
	bh=4uo1yrIKZRlZBhNcFPhEdGxh2rozWeponJyUN09cGPo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MSD77Ebn/21yVlP82oF8z9McT4ShNd1TwCYC9HpBtW7Dk2ktVsfxlYsECli0qjnkmp6tQmHE2IOkzKGHSkXjwXcx0xdV9ktEb38kZwtk5PWBsA7+CFrwENDQRqZ1CgpkPfcymCbmiiQ6DOpsog5R6Rmkef7MLflaiRyIU1Fpq4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3a6afd01eso32004515ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 05:24:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728908642; x=1729513442;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1RB3MG0tXgK4yNbGMLIpzHlvd8r6IXM/6IENmhQbfx0=;
        b=rMg+2GHy5j11i60KwQHIAFZ9iaJ9IWKvRNpAekWdyryUsiW8Qlm6qxdZYkZKAGEFYL
         UET3jYlwNVggnK5uTsLcb4GzwRiYCOIXBbq7u4dKtwn6BhkpTqx065i4jGPJA2SI/bpD
         v2A1NMQ0arq7BU4fCr2pi0pKeCntT4xgFAtLQlvwbW3SC4W2XWG3o0eeeFAb8AO4rZcG
         g2AxWiQ0R9GdWQNvJyiKezDNiAZmOHa0N/UIdgjibO/PNoWqKuOxzJNx2yG/l/vwen11
         XhyJOazmb2KmhGGwW55EJ6iers0Qr/Pf5VGpyU/PCyvPQHkYVir8jA0pXUBd4qd38n3c
         8gbw==
X-Forwarded-Encrypted: i=1; AJvYcCULaP7uErlODAceSvyjl6Fs3nfV1R3vvH5GqhCez5ZAmTpPRJO765QXYXfaBbLgVpchu2KUMmA+qwkvLMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSevKZjgvELC6JJ0+1p4PXv/UvDNPUqGRy0ymS+WCFKLTSMzDE
	CL/25SWmHJktN+BMyZCpMHH9Gqt2VWhMER9/qx91trVKyIsnxGGfMOKCJU4JazIznBwQrRf0w07
	SrrvYsdH1oM/wfuK41AqxwQoCaHDD5jdMdSCd3OxhfwOZyN6kGDUCo7M=
X-Google-Smtp-Source: AGHT+IGxoGj8a67YFnUIJmALzL/ACJqsQ8w6PShHANxjqQvnFcbbipN6ft8JXniI7L9waVO51xsn1PRh+ed+T0u4h9JdoP0t53tr
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1e07:b0:3a0:a80a:997c with SMTP id
 e9e14a558f8ab-3a3b5fb085cmr76536545ab.19.1728908642037; Mon, 14 Oct 2024
 05:24:02 -0700 (PDT)
Date: Mon, 14 Oct 2024 05:24:02 -0700
In-Reply-To: <tencent_C8EA75F1764366383C3F373A972436904A09@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670d0d62.050a0220.3e960.005e.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] kernel BUG in ocfs2_read_virt_blocks
From: syzbot <syzbot+797d4829dafe3f11dce7@syzkaller.appspotmail.com>
To: eadavis@qq.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com, 
	linux-kernel@vger.kernel.org, mark@fasheh.com, ocfs2-devel@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+797d4829dafe3f11dce7@syzkaller.appspotmail.com
Tested-by: syzbot+797d4829dafe3f11dce7@syzkaller.appspotmail.com

Tested on:

commit:         6485cf5e Merge tag 'hid-for-linus-2024101301' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17186887980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=164d2822debd8b0d
dashboard link: https://syzkaller.appspot.com/bug?extid=797d4829dafe3f11dce7
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14cb0030580000

Note: testing is done by a robot and is best-effort only.

