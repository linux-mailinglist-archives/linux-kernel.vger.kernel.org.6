Return-Path: <linux-kernel+bounces-401052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA16F9C1572
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 05:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84CF8281DEB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 04:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643C61C4609;
	Fri,  8 Nov 2024 04:25:53 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96005199BC
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 04:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731039953; cv=none; b=Dv2xjns49+r28r9rupRHliz608zA6vmWYXhyyL8yzQe/rKnDkyBRe3yPZRogoPCJM4zq19Kd9PzYRkbZ5bwp8gFP1p4gSawYtp1FpKYE4qR4sSRLTVZi/PNs/pZulAfzo4H23VloCv9iGH5ncv7gN5bHErtlaH3jhPjPH1sMrhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731039953; c=relaxed/simple;
	bh=nimK38bH0/r7ATJU9fwNGkwLVo3XYvKNRekymMjQhvc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=dWTWZ5bhUwQyRBe1YqJM0i2+U3+gGAA+P0ZvlOPvhp8DSTbZa6Eqjq84vfp9LgSFOYNy8HKJl2j4ER+C+uM8ucuwW2PE8xJQ7j5scpNQkr5HJdSaiA8/UQpZCXFn0r7pWgt8INqrUXFiggy4s4jwuo9jjZEoZg9gFmUq7Dp8vAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a6b2581364so18231525ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 20:25:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731039951; x=1731644751;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zkt3Z8+JSeCPKCMn939p0oF5IFnzfd1LZVNcDLMvYyU=;
        b=pBul9CNHnrw1wE9tKIYhvG7OPTYbXCGEalHNvTf0eE+3qrBEeM2bIiI5sumlNoB49Z
         l6M1GJmfLKDHVjm0a0Dsjw3i82rACoOlawFDF5OxdGHe2ax/uPvoNV84z+SD85fqNfqL
         f/jXDhU1Bm262Txc+5ACn4izSY+plihnil2Urm4oDTIvRLalb6jQkOJ/uJMa0RuSRJqo
         IfxXfD8tRepIYHw+fz3wc0XiWbN9OrdXrxZBRUa5V7laPxoRbSbIybekW75LLb9h8CMO
         dQtEmkH/XImNg94ojaEliGQ+NW6lzhqquGawgKKEWGwcp59AnlPawYe2iBqmADt2RFG1
         0BmQ==
X-Gm-Message-State: AOJu0Yzn4xT040kGCEv1dDYM9z1vXZ3eMwzBCXVBU/HYVdQW6a0DQT92
	QNMs8xOzDo5n5bwEx0iAEL9/JbJWb2HbEFsTRnozulSA7iW/bz8yiUgPXLmIedpkrlEoS/d93zw
	u3/4WAXZjiLEXdEXIwNRJ4PZt7h2keeLDAmjPR7DYtqiply148792DcQ=
X-Google-Smtp-Source: AGHT+IEQDcolU5BdtJbu+ZUNPSUWi8jjnrDotUEiHGnYaNFU6PUmBV5N2cRLc2m6mdXw0uDr08h+nc3JMhYUOloLNHeOwS+XM0k2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a65:b0:3a6:ca38:6866 with SMTP id
 e9e14a558f8ab-3a6f18cd43cmr20344305ab.0.1731039950712; Thu, 07 Nov 2024
 20:25:50 -0800 (PST)
Date: Thu, 07 Nov 2024 20:25:50 -0800
In-Reply-To: <6716521c.050a0220.1e4b4d.005a.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672d92ce.050a0220.0db4.01bc.GAE@google.com>
Subject: Re: [syzbot] 
From: syzbot <syzbot+e8eff054face85d7ea41@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: 
Author: kent.overstreet@linux.dev

#syz fix: bcachefs: Fix bch_member.btree_bitmap_shift validation

