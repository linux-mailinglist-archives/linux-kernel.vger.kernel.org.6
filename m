Return-Path: <linux-kernel+bounces-224309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9814291208B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 11:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 429D31F24BAA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 09:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5983916E886;
	Fri, 21 Jun 2024 09:28:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833FE16E86B
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 09:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718962085; cv=none; b=GBmOQzmIkL/hTzh9SUKutK60oB/aajx/sirLXgI4fuhZHWbGCCeSdqMFK/cirB0KViD3Ba+zkDtAtkXGSK0fRkFQsOKePUwzqklD0Ch3dnQeyjD1OyAK57miTUIdm95hf5WAngXIcwN3+8s0p0AHp8D3MQJ74ElIJPncVImICo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718962085; c=relaxed/simple;
	bh=chcLdnudVw3VBTNwebjZ2XSpX2O5cHNSqetyp483ZBQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NNBtnQlp24dw3a2RRDvfwL8NFtZwNHeUiwvm65fBSKAeQeMgm6lMoGuw4dtVwAXh+ONUzdH96gP3naFK0pQGS/19YtugnbHmM7L7YoOAg9YV/L+IRqBEsbAnx+Ngyn+VeZudd8WLY3obTb5345Mh+9KV6NKz3KmYF4Xdf0j8t8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7ebcbef22c8so198646539f.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 02:28:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718962083; x=1719566883;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uF1pUIXuAQfHqmWTRvGI4AsCP+HoZBBkyKWCWWPcvtM=;
        b=oISiiXu82dHZVNizjT+GfzLrgVJ83ZTF8lghxZCi/HbG72JN+/oxEO3diZ2xLRxEGC
         ULW7HqzWkOLV8lhkqmaxrWhyS/W0GBTnGQzLuART8ybRFpEKN2H/nJ5kNpjhvg4OcMrx
         v9fltOYDNQAZVx+nx78lmeay0iboj1pDivzKNpVZt3uUKExiXSzdonXX7dgq6oX+EViU
         vKgV8CyuuZlPtvUhRo/V75PGoJAWlWBelH+XBT8sk7WUXfU9lqjkttbg7b0d9cmeV+Pe
         cbRA8EcYAH0tRnRsq4tUEUfdmW/rea4CBIufkmKojNr95vFHJMktc010NloTnoFvPBXu
         KTIg==
X-Gm-Message-State: AOJu0YzkMLYfKuUNZ7wQTTvMKS/Htphz8YgDDO6TzV6dG0KbV4Qcda8e
	RM+3Zzjnoazg9D4rbv6gNfBGRl0/9/s/zPo5r5DqY/MNI0NUNkiyVLiZToGwOFDe16XDdBHEmVn
	k9s8a9276z69eJl890dUR17XZZ2KymcaGwmxnGSwtiuW1ZbFubXAVF8U=
X-Google-Smtp-Source: AGHT+IECIiUv1rXoxW5gipcCJCX5neVtzJL1bq42ETtKDSPQ2tBzw3h/v8L0+M4kjLQTcmV++Woqhxmwg/ZGQf663xLoeVIg1Ytn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:871a:b0:4b9:23bf:6fd5 with SMTP id
 8926c6da1cb9f-4b9abff3e2amr220463173.6.1718962083674; Fri, 21 Jun 2024
 02:28:03 -0700 (PDT)
Date: Fri, 21 Jun 2024 02:28:03 -0700
In-Reply-To: <20240621085812.1588215-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000614a36061b630ce2@google.com>
Subject: Re: [syzbot] [bcachefs?] possible deadlock in bch2_gc_mark_key
From: syzbot <syzbot+050e797ad21ccc3f5d1a@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+050e797ad21ccc3f5d1a@syzkaller.appspotmail.com

Tested on:

commit:         50736169 Merge tag 'for-6.10-rc4-tag' of git://git.ker..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=10f1c341980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=12f98862a3c0c799
dashboard link: https://syzkaller.appspot.com/bug?extid=050e797ad21ccc3f5d1a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1001c201980000

Note: testing is done by a robot and is best-effort only.

