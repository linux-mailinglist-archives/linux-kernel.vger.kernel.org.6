Return-Path: <linux-kernel+bounces-403589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 319C99C379A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 05:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E094728174E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 04:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D9A8249F;
	Mon, 11 Nov 2024 04:46:22 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1D736B
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 04:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731300382; cv=none; b=lwcKjX8f9L1xvGwEZHUxqO9EPiy6Cc5Ct4M4VhOQiCcmpwknNQBtK93j7LUvpl3S0jB7Nt5XTKNx7EVJoDnB3jnGublXt5+KpcTM79865sKN9DDO0xxUcllCJMiuXVAbAlzBEqxlPKRa7CyCMmlFK0Z6SkmIccFqMinqv2qCJcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731300382; c=relaxed/simple;
	bh=DMvGmfEDvtElgqHmXKOgpSbLud9yAAR8K01mbx3UyNo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=OZK23NSL2oULX/S6hZzQAsNPo/holJxIzhLsLHPLmk6IIIXMLZ3ngEciNuW0xzJEkxOt9RXQlP/gtcY08ZnTbvOONIQUjDEOieNJZ9olzuLz2n1GGEXeRHfYcDLNpdn4ZQ0EPveQngsVdb0qYT3dOPmk+eGGFOFdq6wwAN2vHxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a6c01d8df2so38132065ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 20:46:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731300380; x=1731905180;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vlFBqFKm0gW3F5gYh+mJb1nrd1ShSOYEgH021LpBOnI=;
        b=KqOjX17h7xvyQq9oQ/jFP812jhDzFhPm8cKHCXOecfjNcRQnIju6aMsCrXJNZql6qh
         fvmjV20EaQUu6uIN/XFQf3jbO0maWAw6D2gMXF0Uu53KE8K8A5CN8t/+hRNZ8RZ7+W90
         wIpQoWYp0mPe+i1Lpo9c3cOSRYAAKJBjKgdmecUwNmkYJHY60SbLxMvAiAplQwwbbeUZ
         8DyBmRRB8gfPDavspMHYD2JLa8tKkiJzkhaFBMfEzfW+3FkHGpNhcSj3HbBR0919vuIH
         kJLcC+gxza4p7KU8dzIXR3zsDbEWvUcn21A6Qhp8gJVZSHQ5sBWD+39BEBWxE1de5lte
         yhPQ==
X-Gm-Message-State: AOJu0YwTOa8Ai1NQNlsWMvKA/tIC1htPnSU19XMut9yvUFekkTyNTQ9i
	vZTuabHHS++h+d4pZRd+frxBeO+jtqojlaQTNhYIe9+qgTLF2U6J/MkxuwcqplvK7JWLq18vW/R
	a7V33kLE+LqY2IC2q0g7J0zJpEWQPw9fi+OgNTDbIo5vmqWVznfvaehk=
X-Google-Smtp-Source: AGHT+IGZcxxwwm1VdpL74trmt1Be2YGxRjC9vGpILfD/1Ck+y2XplQjGyt8k9OtBx+wkk0qtLqmNeYYv1zXGDbwLvZJBA6hMtZt+
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca49:0:b0:3a6:c000:4490 with SMTP id
 e9e14a558f8ab-3a6f249dc6cmr97340625ab.1.1731300380005; Sun, 10 Nov 2024
 20:46:20 -0800 (PST)
Date: Sun, 10 Nov 2024 20:46:19 -0800
In-Reply-To: <67121037.050a0220.10f4f4.000e.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67318c1b.050a0220.1fb99c.0142.GAE@google.com>
Subject: Re: [syzbot] 
From: syzbot <syzbot+4deac4f47f33e16f82b7@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: 
Author: kent.overstreet@linux.dev

#syz fix: bcachefs: bch2_btree_write_buffer_flush_going_ro()

