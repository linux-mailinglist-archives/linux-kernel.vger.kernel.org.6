Return-Path: <linux-kernel+bounces-552349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41EB1A578D3
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 07:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3551188CFFD
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 06:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD71E19F120;
	Sat,  8 Mar 2025 06:49:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1A219CCF5
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 06:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741416546; cv=none; b=hRD2lDhzhoCPop4Cd5SV+N6c6YjFs7kl9dxCycIcPqQXXqnYamplhnVuywiWWisGTWkHlXBEs0k6yNZpvJtps+sRg4mJrPumzBgNVyNph1wl7KM2Nxtgf+MJjZurWl0i/qEd4n3huv9dzGnxZjyGERqRucH4qC8N8TLM7Fx6xvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741416546; c=relaxed/simple;
	bh=UdXct8Kw1cog1WNDyhopi/uZJsb5mzI8VGq94reyjyg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Wktx9okaLvLUsev9MBLyQOaCxDOy07DYkVR3AoJnxm3efgI4fFZAb3DTlo7fjX+2+8PVt6WK2iNHdqE9ZIjyOWXlCrJO6kom9JjpM/L7Rluh5BlrOfc3WARj0CSPHt0KQpwa3DLRnb8zPMKElKnYPyE9aMxGkEhV710zm2Ti3tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3d2a379bbf0so53345225ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 22:49:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741416544; x=1742021344;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UWyY4NWje7PpXQWqUJ01mBM4XnAMZnW6cIcxE47biDI=;
        b=iuh/wGqW5s+VNs6X6x+ArJrR7E0s/TqIxNIDXOkFyjRzIvJ8/I1vNVNDHOSAI/N/+s
         t85mQlWhbSWGNzDJ4ZdaQtrCvFbDSPmld3GEhudbhEKtfn7d7NNk92x5bs6xZEa3Pbng
         lbh20B+PpYFDYTH3c4QkPaWWW4De+OLLLn0tDgswlFQjuRbzix5UmJ5MY3VbqO9omD9t
         uoeVLY9/WK0nbQbybacAlAgDFk4bzW7VB4y7YbyRT7VKxrQK7SRZwcLznWkoTN3CZiHC
         gOJ6qlclMxTR8doqgEzB4gcAjpYN1wiERGNaTyty4QYvj0ztiHv2OFSY+cDtZjQJg63h
         IQYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWq5igjL7pdQWbRGw4JVsgoX4GUtjhk/cYr2SmMDqk6AgCB/HEMDPThKKqLBS99LM0z1uJwNoHWvdRk6tk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLT6Xs6YrkSPnAmVBgio0uzIHwAt6cm4BG9cpnmOHOWpw2OOGN
	TweNfc/jQkDXdjwa9FpgAlhBVAqcXU7GYMKGSwv/VLQYI//DwA6JHcG5bUvIKSfJXTOawzwPHYO
	rZ/T2nLm6aaC1azUO73OEb7MdLR+DP/LmGIYXkUQExCFQZQaY5xxbdkI=
X-Google-Smtp-Source: AGHT+IGKDdAElXFlhOxW382nEqDhnmu2Yqgs/FN6ZY6fE6kRaewecGBiU9hJZU10j20f2lSdxKcKdEC8OUb1FiVU9k4RZ/A4xEvl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a64:b0:3d0:618c:1b22 with SMTP id
 e9e14a558f8ab-3d441968a12mr54569035ab.11.1741416543918; Fri, 07 Mar 2025
 22:49:03 -0800 (PST)
Date: Fri, 07 Mar 2025 22:49:03 -0800
In-Reply-To: <675e8eec.050a0220.37aaf.00f4.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67cbe85f.050a0220.24a339.0000.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] KMSAN: uninit-value in bch2_checksum_update (2)
From: syzbot <syzbot+60ea31958b52b09e04af@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 03ef80b469d5d83530ce1ce15be78a40e5300f9b
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Sat Sep 23 22:41:51 2023 +0000

    bcachefs: Ignore unknown mount options

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14ec14b7980000
start commit:   00a7d39898c8 fs/pipe: add simpler helpers for common cases
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16ec14b7980000
console output: https://syzkaller.appspot.com/x/log.txt?x=12ec14b7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=523d3ff8e053340a
dashboard link: https://syzkaller.appspot.com/bug?extid=60ea31958b52b09e04af
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13c56a54580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1158e4b7980000

Reported-by: syzbot+60ea31958b52b09e04af@syzkaller.appspotmail.com
Fixes: 03ef80b469d5 ("bcachefs: Ignore unknown mount options")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

