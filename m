Return-Path: <linux-kernel+bounces-420502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 306C09D7BBF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 07:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C13612823DC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 06:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997BC17E00B;
	Mon, 25 Nov 2024 06:53:26 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99A61E517
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 06:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732517606; cv=none; b=WM3uQcJ+hH/zE4UJ0205s5ZnDebOZMMJEkeLLaa7z14T5t5+bsuyFFSGYF+gSwXGjj7F0140hRWwmsnIOtPLaLUMHLPi7/TJZDfiZ5jwoqBSEXgpIwZg54Gr//Byb8Ic/uvg8mKqjtbQeikMu434NB/SaVTxSG76lOIvfnbUV4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732517606; c=relaxed/simple;
	bh=nwklXlPtxjjRC+hESVBVAI1WCMmITCDtcPs9zasAYjk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=UuptCJ3TQS+t2fkuvXsMyEcNmsbqB+fgfsndvlYz2QWQIadGd/SH10icaC5gGWEunXXXIj7IAV8bJkVVeoHY17JmMwJIa+7P3iiEYBk/Sk6eQsOrcISBN1djYopZXu0Hpr9IeiAgKdIW1KIYcjrWTp3T2O3OBZnOL+W8yMjFGj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-8419aa81d6aso52304239f.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 22:53:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732517604; x=1733122404;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tBYPeSQNpN2BBjym9ByX4TxpwOS5M0F7XW7Gso/dEbc=;
        b=cqXgo90hdjCfzFFuJPqGWsXL09AWRSXdZrJ1LF2d1xPpj+SaOzRLDnSKr0JTuh11Sj
         8b0sfxThfGMG5qS8Qlk59i5Jz8dhcpzaSZQlcsoAHYTqhi+tOcxptF8jAV/saJ0LFHam
         rLU0rye+aahT+tILyio8SAY11hL6ox4cJtvJ7BRK1s4Vi5Psf2zK+V8Ej44J4qEi2l9E
         S9TUn9WcNiPqOqpRFQUGpJtLjdCchvX6qgs1mU579736yrUR+EFcLxQ5yDaJ3uLbnxgX
         t8160b5+FoD0yVGaLAkwohadZkP2qzRj2EapBPNZbNlhQfMkkF+wHR0zHZIkRUMIOtml
         RYdg==
X-Gm-Message-State: AOJu0Yz92NrJDvZDeTAZQWB02Eayk7B9Y7u7V9tZO0UJmozvo9Tqd3Pu
	WZBwRdjm3OsF+GajpyCEleB9kLIgbvWcMohn3gyWKBM6rTElSIFpEt3/h46pAfmGXYkXgWzsKWf
	Nzl/FwDpO/piJVam0Ojse/tGy/S/UOakGZL3uTnYVkM0+jf6lgDUcXlc=
X-Google-Smtp-Source: AGHT+IEh/RDRxzse0zi6rOfHaHCUi2d0ykeII++oFYy4tf34XqJqtbCcFr/pTFbm1LZu1ekEsPgUZdCJLw13cZ61gtOev3LtgW5m
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:168c:b0:3a7:8cdd:c0d2 with SMTP id
 e9e14a558f8ab-3a79ab76051mr120581755ab.0.1732517604072; Sun, 24 Nov 2024
 22:53:24 -0800 (PST)
Date: Sun, 24 Nov 2024 22:53:24 -0800
In-Reply-To: <6740a00c.050a0220.363a1b.0145.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67441ee4.050a0220.1cc393.0065.GAE@google.com>
Subject: Re: [syzbot] 
From: syzbot <syzbot+c4b76ec6c2d45b06ec1e@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: 
Author: kent.overstreet@linux.dev

#syz fix: bcachefs: Kill bch2_bucket_alloc_new_fs()

