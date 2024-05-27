Return-Path: <linux-kernel+bounces-191463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53DB58D0F98
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 23:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85B091C2240C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 21:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6524F161B43;
	Mon, 27 May 2024 21:36:09 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943E917BA7
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 21:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716845769; cv=none; b=IbpCRQFHQHXj//A+RWLYpH+LhDQoLAkuwOX7UJQzttthLNGp7OBbKkRADNTgSIzDwpVq5lyk5hsbf4ycquD2oF1P64Qqw3WAZX7Okwqld91k4M2EfN2p768/IIGGUKI39HTZdXXjCYTzOmr8SdahFgmW60uRp27Guv/15SWB9co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716845769; c=relaxed/simple;
	bh=xg5p9I+oP40kmJhXADMlxZAPjvXHHTMarEVG/hmd09E=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=nxX+HqVCbpHvzDhL7bTQwX4Sh18bVRA0DYjSWgBN/k//u6itDMU7UM5uPe90nyLFKoM7IgsQhogE45gB0E85tpJmswusJdagna/FAtdzk9oygZ+ImYskQvOnsQIqtRir5xzm6OzIvDMiHwk07k0C/rsi9GDgNBFFDwLP4y5ERSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7e1eb98f144so19802339f.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 14:36:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716845766; x=1717450566;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qGnBPYhIToM5CvdNlwOkqkKSjA25/rvGdeWcOIlxVBw=;
        b=FbUR3KmhcSVlgRB/GcowyhzIOQ34mlOf7cmGqLf5L2QK4FCEPDt3m6X2lgoocaZmsW
         bdJrqtD1cps2WDDF1xtYbRDC9myU1DyzxQFQ7SWf1qLTGEihp/bwS0Immn3SuuFK9hYr
         szd1JF51VnGNJ5vi5cDMouTp81yFCm/CSYhoH++cvNmHeRnMCx91x5FCAHgBkD0Gu56W
         L4robgKFzD8YZkEX1gUUGIe2ASKHUflCd715qXs7LZpOpnkYAfjlNo3ObPoPJeVunzEU
         pZewlovODEY3YDg5Gr3XNnaox+t+bCSooNPOWFTWAkgxfBU/aCqqLfo4oRb4N7xf6Hty
         IMxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnDhhlbMObxRdH9kTHZAjMzD+9uTWtS9hCPsqz6J4hQ2oacwVxzdVQnrvoBbEBNGxWMDcdwsTqnQWpk1f7f6vCOJ48PfuBvVNAe4sW
X-Gm-Message-State: AOJu0YxsqhJknwMLC2Kn/W/k/Olbx1pKXAfHTB112azIrsAunTUIh1YM
	d2isy7O1wAoL6zWUROq3DPCNQLHjYR2VmLiAXHRxw8IAM2cuY4k1+2al+b7IThgFQi4SwBui6QF
	Z0I7rveste56LAtCM4nktf9oDBzaxaH6WI2OqVOMQo4EMEx0tgvVsW0o=
X-Google-Smtp-Source: AGHT+IGF5ftlSVDbRXoxRHrscozfUco3U5VmGiqRYnoCeclwuvAWs6L99ygLz4h+7bPaa9AKbhQaDw4qGRY1xtZYUovJp3h9Xpv1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1601:b0:7e2:b00:2239 with SMTP id
 ca18e2360f4ac-7e8c1adbc2amr32193639f.0.1716845765956; Mon, 27 May 2024
 14:36:05 -0700 (PDT)
Date: Mon, 27 May 2024 14:36:05 -0700
In-Reply-To: <CAJfpeguD5jSUd=fLaAGzuYU-01cKjSij6UbQWy72LDpqK1KQfw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000003a6e50619764eb4@google.com>
Subject: Re: [syzbot] [overlayfs] possible deadlock in ovl_copy_up_flags
From: syzbot <syzbot+85e58cdf5b3136471d4b@syzkaller.appspotmail.com>
To: amir73il@gmail.com, brauner@kernel.org, clm@fb.com, dsterba@suse.com, 
	jack@suse.cz, josef@toxicpanda.com, linux-btrfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, miklos@szeredi.hu, mszeredi@redhat.com, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+85e58cdf5b3136471d4b@syzkaller.appspotmail.com

Tested on:

commit:         f74ee925 ovl: tmpfile copy-up fix
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git
console output: https://syzkaller.appspot.com/x/log.txt?x=142c4e2c980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b9016f104992d69c
dashboard link: https://syzkaller.appspot.com/bug?extid=85e58cdf5b3136471d4b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

