Return-Path: <linux-kernel+bounces-298275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC3E95C508
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 07:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE3A3283674
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 05:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D7854720;
	Fri, 23 Aug 2024 05:53:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C6B55894
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 05:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724392385; cv=none; b=fu2L+R/GvaVKxidXxOO+/SbKPMxaTJ1lyHh+ZTta2pC4kbc7f5zJNAcAmXjFtbTPeAHrLgn9LLGciONLN/FAHTzk0wb5bHuYygRpLRKw0DGzaAqTShvxfeNvPjGnUzKikdqINjjEO3Xnt2NijGIDto6DFN2hNTfZIK9gupafJ7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724392385; c=relaxed/simple;
	bh=7fYojFIbsaHWi/MPrCeyJY7dOEwgt/wS6FavyyDB/os=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=IbwxwqAVzubCkXouTEUGBauv/SlmlK0FOGjLb/44elGRRuQEe/alC+3li7LA1lGQm81tMoWvuFwrBQru0Vu9BcKFfgAXhkxJZsoRQj5jnu9e0H/DenfjfwFBLT6sHuWPHP8sf4cXmFFwMH6yNMtC9PK3qA7F+CsjLJBWKG+pv8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-827878b991aso35450639f.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 22:53:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724392384; x=1724997184;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nufm0EeJmJrT9B+QzjrObr8K2T8pjUVPdDUNg1IooMk=;
        b=DNE7jkI/MmG0BbskQK9OTpSHHrpUV1o2NlgK25Z9ma8drkqBCHSdByMXrB3jqRcv74
         BkzCy5fCH4gi6XqAbUOOdRRfuwTTjiOPbzhSTJQQKVqYpMsCkSn9x65sFCAba8cP0nnc
         d8r0aGRvRSqv509gNtsl25Ce6g/tA+p/qJcYVQ+IfsTczZSMvYmL9xc4Bhrii7gXcNmc
         2234d/rFjfH4sMpqSR8HMlvI54hcIdn8Vfq2ilbu6eHo8CnK59houLMZzS1UNvQPgaJ+
         YMiAhOZkDoUwJn0/8/9s715DFZ0BVtMuXLKD7qMbtIZlVODDrMWfw7DVwOHCT1jZZApg
         9M0w==
X-Forwarded-Encrypted: i=1; AJvYcCVGavfj2+oKBUcRIX1dQnbKvBknKcRhjU899pQCo9MlCNtn67rGUv8wyItNq1H2+wvx7/fRb2kNNY62dzM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0Zhk+4oJn2MbNPEygOX4IHtjMv1Gf7VUWnTU29VxH37u7+TU+
	Nup60BiKcU2YnSmxqCcUvCu3NSOs6OzNoEyVu7ea/MYLLqDb+iyVcZmxHSwNrIYN7yTdjXn7+Ut
	J2EXHg7cY7Xxo2vBnHJKzWZwSD0fDZ2MLMYBpuJ60Afsm0sPpPP+gj48=
X-Google-Smtp-Source: AGHT+IFJuWCnmSeurqVLgjZeeBETebT4+t/ol63sSxNVGkmz6gWKfC/FvobnL82v6FTz6VO2Dj6DtydEs8XWdNeCbQPn5YFGlDCR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:862a:b0:4c2:9573:49af with SMTP id
 8926c6da1cb9f-4ce82b6b605mr55394173.6.1724392383741; Thu, 22 Aug 2024
 22:53:03 -0700 (PDT)
Date: Thu, 22 Aug 2024 22:53:03 -0700
In-Reply-To: <d6c8db71ce8d64d93c21811a0b7490cfc1abf16f.camel@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007c913906205363ee@google.com>
Subject: Re: [syzbot] [btrfs?] kernel BUG in clear_inode
From: syzbot <syzbot+67ba3c42bcbb4665d3ad@syzkaller.appspotmail.com>
To: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sunjunchao2870@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file fs/inode.c
Hunk #1 FAILED at 723.
1 out of 1 hunk FAILED



Tested on:

commit:         d30d0e49 Merge tag 'net-6.10-rc3' of git://git.kernel...
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=399230c250e8119c
dashboard link: https://syzkaller.appspot.com/bug?extid=67ba3c42bcbb4665d3ad
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1151ddd5980000


