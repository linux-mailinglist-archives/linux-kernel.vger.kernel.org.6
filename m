Return-Path: <linux-kernel+bounces-358170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F102E997AFA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 05:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4AE2B23C49
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 03:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0D3189918;
	Thu, 10 Oct 2024 03:02:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46542AEFC
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 03:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728529326; cv=none; b=p/JEn67DFS+8tYAxgeBTI3tBoqfDBdaiB/+0SOim/2JOKJ7X8fHonrrK5k9YfOrWFw2HxMCXsmkRv0qLrOkAAGtNRqxgQeoq5iAFUEpVvtTZ3t8rRm8kH2dA6o44Z6W9ZbNqX7Fy2qWMziMrAvbqImEOoIzlWOvxL58QWsLvOtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728529326; c=relaxed/simple;
	bh=7WCL9cwe+iSQbzMO8XzBhZ1W03SLA5HXprr9Py3FweM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=X5vzl/H6zmsX1eguqwX1DBLJerDxVrXsIIBLBfOYlU+LORk6Fd+RglmvypSrbKNf2c+MCKAQ6Am+PgGvSMLGRtWuO0+FStjIFIv8gVgZNmJEd1eHSschLwgM7WtWmrzT41p5egVhxdpBPiZU58MmCXSUYYg1gvqqHaCDtZmuo/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a34eef9ec9so4709595ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 20:02:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728529324; x=1729134124;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F9sJIKQWOb1Tdfi+vU5X7QaetO8KWr48ZJIV+n0gWeI=;
        b=HgPoBtGqGV1KdvY6eq9ZlHk9CHX7j6DJpl3WmXYFafU6yzBrBsPMyuanfbBd3Uo+qU
         V/wrk0HfLUeyUZd9fgUIDBztGOiohJ856msbDI1J3xqbTd7JV3GJtOeSbwTRzRe/d6r3
         39X6lVVy52X20uAJSfJdkXJG6eWI4wC55Yu1O5D2oMALr9USlBahzWcRXBDOrMaZgyF5
         xsCLJmBby9NiOPtwWZja2kMIAd4qPfCYhT8jZ3Z8rgq3Lz+wZX4QRi8BsnK58hXZ53ph
         Cawsg+HlPVCdU+lHaWtshwv5gwWmJG646ZKOF4sbcQsL/TM3fx0XnEUZNRUSGq9nENIc
         PwVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWx4kCUft6L8gR9hRrQJ3In/CORLi9FfZBnfHpDTeR398OGAtRChaUHuquxsnp1UcUNvFVKL10SBxxUk+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiDQxZ8vv2YIg4MSWezqPTkm6IDAOvyoJ5dToW4VVFZ3AvCAOh
	06ZqKs7dy/q01aapsEsjOa9iPPGWOEGjXUmPtPSPll25R65jo92mW8ZMR1/UzcXI6o2zz3RUAib
	C1Un1yiOAbFThtHtmotu8FKwb3IlOiyGstzwFdCAOgrjW58Q1NrCuit4=
X-Google-Smtp-Source: AGHT+IG8UynhjpDyM1sDvMbSwrFver1lRXwHCTzQ0carTWHfsBrgCJ5gvvlld5hbYbTN3xhP2anmLw8dKeQfjfwJ+QTNRP/PQptz
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:138a:b0:3a0:9f85:d74f with SMTP id
 e9e14a558f8ab-3a397d0fc3emr40497795ab.16.1728529324060; Wed, 09 Oct 2024
 20:02:04 -0700 (PDT)
Date: Wed, 09 Oct 2024 20:02:04 -0700
In-Reply-To: <11876ca8-6104-4f67-a7ac-c1dd7e9a39e0@gmx.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670743ac.050a0220.1139e6.0016.GAE@google.com>
Subject: Re: [syzbot] [btrfs?] general protection fault in getname_kernel (2)
From: syzbot <syzbot+cee29f5a48caf10cd475@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	quwenruo.btrfs@gmx.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
lost connection to test machine



Tested on:

commit:         330f0214 btrfs: handle NULL as device path for btrfs_s..
git tree:       https://github.com/adam900710/linux.git subpage_read
console output: https://syzkaller.appspot.com/x/log.txt?x=122384bb980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3ec5955a0d4f6ede
dashboard link: https://syzkaller.appspot.com/bug?extid=cee29f5a48caf10cd475
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

