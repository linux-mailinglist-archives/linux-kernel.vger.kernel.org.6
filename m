Return-Path: <linux-kernel+bounces-420503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2F79D7BC1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 07:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F801282277
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 06:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38465185954;
	Mon, 25 Nov 2024 06:54:27 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656831E517
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 06:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732517666; cv=none; b=ki0DnQ/rX1+ciSEUfa9+5P6FzYmDsEFH/AnqT2QJ246xj02ymoYHYYOcRnFeL16wbMH3uta5M2aP7ytE/VOUnWBKKIseW3/IKfaIqi9BDAwq/wdNGAanMyJ5z6eJWlk7Vfkb1b3TKDyQdz7KiwBlXwP4ixYIQb1GJBMF5Trtgy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732517666; c=relaxed/simple;
	bh=nwklXlPtxjjRC+hESVBVAI1WCMmITCDtcPs9zasAYjk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=TQYkzVZGzyzdRDoNQY3tPlJ2P1f44q2mAw+B5deImEVwciQCT8f8l06p5Y68UNUcJA3XYcLVReNxTZCLuu/mAAq8Q3f8DvWLE6TIacFC0YrK9Eyd8TuFaUIhrTeWN2WqMPUdc/hssEuf2Sz7hM5uRgCHM6hPyKY4AcJPthstHCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a76ee0008cso50757175ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 22:54:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732517664; x=1733122464;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tBYPeSQNpN2BBjym9ByX4TxpwOS5M0F7XW7Gso/dEbc=;
        b=siCYAjwW2ZqfT+vko/Ugxn1nquT6DrFcIthNG142WvT98bN6laO44ZARKKOPqfw0z5
         FcqdftFkuUlumrqAZRjutUsmYN6iXpfqnEjsIV7n/LlPQqLTxUDyAd6tqhOHr6fLjg6V
         P48uechDbkFJ6hRpivhsi8N3vm1Yo9DyASuZp7/ySXcByBiyEjm6iTF9qI5Ryw4FoZ9O
         MnEIN6DX7dl5txtFp/ajvKSMC09imyYuhVtn+0EEurqRmJrsFa4nwdbECp8OY9ZY4WOA
         mC38ZC0dfoylt2S7xEeYlhk5WgoiC+ybeMH1kOGGoRLntdZ/9VnbF7+LqHq50m7pCNCe
         oM6g==
X-Gm-Message-State: AOJu0Ywmx7DB0p2eDzKq69EStO5/njEm2D2pfbHNlpGNeq3BtlvgYa5z
	dZJJcBge50U5QNCBJmFRgjwZYu6nrNLhD3El+rpl4nh6VL+faEMfEGq/8np9wmxxb3kkmnwgZSJ
	DPQro+L4mW4wdMWiSoxZKymNIiphO0MRahrTjuF+hV7056ZtagopALOM=
X-Google-Smtp-Source: AGHT+IFzl4nfo20ttNnkgDYTzbx/8dPcBv1cBKweESLb8BNLs1DUgm0Bl5VU8rdiWHdqRTA/OyBx0yCvmGnA4S4KT/h4QedeMX2p
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:156c:b0:3a7:8149:6aa with SMTP id
 e9e14a558f8ab-3a79af95b70mr98365255ab.24.1732517664626; Sun, 24 Nov 2024
 22:54:24 -0800 (PST)
Date: Sun, 24 Nov 2024 22:54:24 -0800
In-Reply-To: <673bb48a.050a0220.87769.005e.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67441f20.050a0220.1cc393.0066.GAE@google.com>
Subject: Re: [syzbot] 
From: syzbot <syzbot+592425844580a6598410@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: 
Author: kent.overstreet@linux.dev

#syz fix: bcachefs: Kill bch2_bucket_alloc_new_fs()

