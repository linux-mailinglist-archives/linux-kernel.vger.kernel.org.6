Return-Path: <linux-kernel+bounces-358068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6155C9979E1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 02:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D163EB21551
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 00:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6453E17C9E;
	Thu, 10 Oct 2024 00:54:07 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72A615E81
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 00:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728521647; cv=none; b=SFH/KjGS34Xlvy5UPC0C13Gi5OJFvHy/ev8djzTScbDbg8SJFUmGGsGtFj1ETC3xhmFoUm1yGbPYqJERP8A2mrNf6lJhcrQEWBEW57f12A/j0H8qIjcoErBnf13a+7aluVOV/VJKBqjJD+zxlKbQx7wIBaeuVANU1V2+Sw8kAIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728521647; c=relaxed/simple;
	bh=ZEf+mRMIEtHoQBvWHnPNgW50SBSsa4ahNYSUgssG85s=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=hJF+aRWKW49ILeBo+pyhRtUEipjaJsB/vE6LUpMg5yYGY6O9OIVIkd8V+Kza51Cn5ddDEgBXvuKdzJtJJteelVNBqNUgMQL8Nxydeybl/6TPAuNAAN7OZA2VuQUlVXLWuvGJdt4tMCUohGc6ng/1SkYvTNd2J8L5SO1AkB+XH4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a392e9a8a4so5559945ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 17:54:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728521644; x=1729126444;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iDd3dVTeMocyMGKsdPEvyYiDAGldatYVwSJW2aFtTDc=;
        b=sQPRV1m2P0ooz0JyS0guhTrAjiuOCyxKQ3fcdWQoQ6kV3k+/qXV9WnxxwxkPB0MedB
         Lcfb1S/VRwm7t8J7gV3J1DKrgH3kVpnqjAP15rrW95Cj96eCb2WJIYM612HsJWw22bLM
         KU18Kjc0pdta1AYqWORkuhcrKmBwvUfsZEnzZ47FquV259sJdtZKWAsLsQ334BH0iF0D
         edXcD9i4A1/ekvn5LWO0T09ujyJApvcdAClVGSsVFHXBgFBG1ybD/KD935HmDimyrbvB
         FNSWID4I7KRo/FjrrzyEPofdeX7WJwo3usb5qiiNiNMXhEs8l9MvzaKYJi4mSy1h2ECg
         uYSA==
X-Forwarded-Encrypted: i=1; AJvYcCUNjtS0gfljDNCmwhskWP+U+IkdRgLZ5MIYppT+l9RS09R4U4wZeOPxqrrsxmpvu82PF+Fi62BCzLs4JNY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhkmCYqD/b0+lcdeM/nEEGsb6rfz4ZNAriJ3RkdWDSPy8KhvGm
	n6zbomZJbRCGOXL70aeTMBaKSRuve32CSkGH2VNlkDEHyRSXzH991/91rodQELMu9p5FKHdo1JO
	mjzdknH6Nb3mdjQcl4vMKfe52V/KpazaFZhZCT/diYsXdYMsf2cQ7iwM=
X-Google-Smtp-Source: AGHT+IHEynNFo0ccOZYNcQe1Z/JSsKyZamtEH62XfeNT8qGFQcToW7ZsSSUJBRUZaU358R3SSgLv2XvVLOS4Ht2aT2zy+9yMdjPF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1561:b0:3a0:98b2:8f3b with SMTP id
 e9e14a558f8ab-3a397cfa93cmr48447805ab.7.1728521643780; Wed, 09 Oct 2024
 17:54:03 -0700 (PDT)
Date: Wed, 09 Oct 2024 17:54:03 -0700
In-Reply-To: <5278c962-8f78-499d-9723-38a3d6520e19@gmx.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670725ab.050a0220.1139e6.0015.GAE@google.com>
Subject: Re: [syzbot] [btrfs?] BUG: sleeping function called from invalid
 context in getname_kernel
From: syzbot <syzbot+02a127be2df04bdc5df0@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	quwenruo.btrfs@gmx.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+02a127be2df04bdc5df0@syzkaller.appspotmail.com
Tested-by: syzbot+02a127be2df04bdc5df0@syzkaller.appspotmail.com

Tested on:

commit:         964c2da7 btrfs: make buffered write to copy one page a..
git tree:       https://github.com/adam900710/linux.git subpage_read
console output: https://syzkaller.appspot.com/x/log.txt?x=115d8f07980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3ec5955a0d4f6ede
dashboard link: https://syzkaller.appspot.com/bug?extid=02a127be2df04bdc5df0
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

