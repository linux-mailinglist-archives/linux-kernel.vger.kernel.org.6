Return-Path: <linux-kernel+bounces-299731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3890795D95B
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 00:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A09D4B223D4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 22:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23291C8FB7;
	Fri, 23 Aug 2024 22:53:10 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23928195
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 22:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724453590; cv=none; b=b0nUNdwKYmnhEf6Z8NhexyH3UOnya3p/T3h5/kb9DN16HKHB9279aFiEVpE1NubzGUGiaPQQ1OnAU1a6VrUGOIXGcg14SVbdr5Ep6xWBE6GnRCjn2kDuwFt7DR2Qb/6QRYUEGQvOU7boewPUHjthOfC9nPk0UcTkdkBJaGn87LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724453590; c=relaxed/simple;
	bh=bN/KvVpTXSgWjzklXX+jjFI3J1qhmTzm6gcxnILoDmg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=kDtzqkEIptmz4+e7KK1cnjJvmV0Gr+qugTWq74xyNAth8GFap3i3O934Bmybb1vFYNfZHrqBurkw1piHZWRFhLg8x4J1orbGvniDMDDXlirv4kwhCAuv6/4t7lYq6mlhRJZ1hKv0Rr5B+oy5RgOEX6A41YxVi0vxOn+oSb21sX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39d5537a62dso28885045ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 15:53:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724453588; x=1725058388;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bN/KvVpTXSgWjzklXX+jjFI3J1qhmTzm6gcxnILoDmg=;
        b=rRkTEGW3Rs5wagFNCRq8h7vFZuzrKVxQNu1Xn5XCnhJ5U83lxY4fLP0ZVcaXBOtl6z
         8ESJQ3iNRsUv27N9ZJD2GyxGacbue3j9EB0bvVQzz4IHMDWEBwu/KTMBI2Zi+t6DiHdw
         TYCKJEv2R+t7YqYYuQCZklyLSkdxJG+d+LVcekM+J7gNX6IpOZ2ZxVLLjr188J9rb46k
         uLn4M+TMTuINQP+WVJW9wX+gBv3OdfQJXgsOoTujojxNNMmJutfqysgUUbwmXAT20CIa
         23Zf3Njf7FkZ+o9CUI5GFYa66poCK50jopRWzDh7iOuHspVWnV17Wnsy5UuLjFJPybel
         T44g==
X-Gm-Message-State: AOJu0Yw04EqKERtHrEK0NnSFoOH9Jd5E2aPsBjh9IDLzMj0bMWfjWai9
	hBLzjo0TQTCbSHIjiJkU2c7V3kh563DvV8ta4b7WsWrDp2WjjGspAziOhYCw9A7e7IMTRmpGrQ+
	BXoSQHLY9DcavL5z3KUs4b10CvKCQ2uVHtJJDRSNGJCiUrbMd6Z1cyE0=
X-Google-Smtp-Source: AGHT+IG9Tpw9R124PC3zJInwG6/CIBDchjIQD0BgWeNgDfjmBzlFNsNfyLALlK63zKxsH/0xpJUI6vyNFYStVpDqBs8q668p0YXX
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1522:b0:397:3a28:94f1 with SMTP id
 e9e14a558f8ab-39e3c9f100fmr2560955ab.3.1724453588267; Fri, 23 Aug 2024
 15:53:08 -0700 (PDT)
Date: Fri, 23 Aug 2024 15:53:08 -0700
In-Reply-To: <0000000000000d38460619fbfd92@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008f8947062061a3e7@google.com>
Subject: Re: [syzbot] possible deadlock in bch2_btree_roots_to_journal_entries
From: syzbot <syzbot+49f73403c9dd50916299@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: possible deadlock in bch2_btree_roots_to_journal_entries
Author: kent.overstreet@linux.dev

#syz fix: bcachefs: bch2_gc_btree() should not use btree_root_lock

