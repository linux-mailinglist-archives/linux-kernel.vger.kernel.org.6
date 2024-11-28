Return-Path: <linux-kernel+bounces-425054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E31139DBCE8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 21:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D78A281F77
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 20:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6841C1F1D;
	Thu, 28 Nov 2024 20:31:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2D112C7FD
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 20:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732825865; cv=none; b=CFLn6srp3Ek9u7te5A2WS5znA+KZD5GV1pgUbLR3/wFMYO+xSzvTg+galLg7dO3COuUVjJqz9uH4Hq9dr8pnMPtYc2ZucDI0ZfpZo/fHvHS8aGRtwH0Udrdd9tTN7IPjGw6MDkB8kw0yU3reAX8ihvi+H8k8IqwUnq31EpA2kD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732825865; c=relaxed/simple;
	bh=N/SCqG3oaowPARmBy+KSZdU8wHvFA82RtV1GiIC83k4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ZFvtd0g4rtmvslF1PNKRYozinxaifjpYUOVpR+m/8ZBbvEyV6E2yUQRn4CZX6QAMn7NgSPeoljze3cW1mNFZtcagJC1MvUPTKelf/luihHDnl6vIoky2dyUFyAch/gSIe+D5xSLDfkD48wD88wn3M7ZCLpTpQOfmCXaQfcJKhvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-843e86e0b3fso105734539f.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 12:31:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732825862; x=1733430662;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CRW9Tz36EMY7oODUw/Vejl4j/oP4fYNugsPJHZOotx0=;
        b=RUU9mfESUN7V5fmyHtzk6UZwvTD0ENMyCOTkoTnXDTHW444H7QK26XDTx0EDy9LCJ8
         yLOXeOLl3pACx34I/x+pRO9eK+a4BCdP1Qa5tOHEVtEDgPYNbQsy4bnFXbNUNN5W738W
         m/owgGirrJ6kNmAJgFjTuTDpRfMPSd8+8Ls+TvsFFbdTlxurYW2yXyWEA4KA72QBQgCC
         aB6KvKab+YwtFcWggzrKG0rMY/xgWBbAxU8WsU+sqmsU6LaBUHP4N3K0FMpGv9j6vckf
         eKnUflU+ylEzOUU6hQTOb2PNYhcZVj8dfGI08+F9advcOVPoNFkyvlh5EdLsFNOZNHLc
         3JPg==
X-Gm-Message-State: AOJu0YzvJaIUMmMZhB44xZsmh1ArIXVki1RBxzZX10/WwRSqXbTU0d1g
	dvkGRViGMNli50VtzCXuBsg1vYe4hTnb4cgHE557Ov9NrYQMpP3WTEk21OYuGUE5vbbkMxBFEIv
	ZuwC2RSIb05EWecQS1vBWnhrSHSkPv+Ay1ZryGtlE/k5ku89qDxlLZp4=
X-Google-Smtp-Source: AGHT+IESQE1w+IHt4pNDve6kDJp/BlaqVsU7v5IpwIMHLVqYe8QeId4HZ5BZ+zHysHnRDSm1cKPlXYN37covO0VF4rtiwjMPSR1g
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:144c:b0:3a7:81d6:c177 with SMTP id
 e9e14a558f8ab-3a7c5581f26mr93248645ab.14.1732825862119; Thu, 28 Nov 2024
 12:31:02 -0800 (PST)
Date: Thu, 28 Nov 2024 12:31:02 -0800
In-Reply-To: <67483ca4.050a0220.253251.007d.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6748d306.050a0220.253251.008e.GAE@google.com>
Subject: Re: [syzbot] 
From: syzbot <syzbot+64e6509c7f777aec3a24@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: 
Author: kent.overstreet@linux.dev

#syz fix: bcachefs: struct bkey_validate_context

