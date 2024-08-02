Return-Path: <linux-kernel+bounces-272521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B503D945D6A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 13:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B171B2119B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 11:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6BA1DF67E;
	Fri,  2 Aug 2024 11:51:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457E01E2868
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 11:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722599465; cv=none; b=rBa8ucLhelPArQgnn/Cd5JQELxYmY5zTOzhna0JQFlJlsa3L65cYf7LOyggXoRmBImV/6yzy4W0oWWWAkQVFPiOFgiTh+E4aBxuEosdjkHvzGZAqfdzZvZNKpPqV2l2ZnQbzoM0deIR1rE98TpbRJQ+/Qu4QxrxRQn90h4a9+WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722599465; c=relaxed/simple;
	bh=L1JaWKOtk5z441B4Pi0QfddjrAjU9N2jbnYwBDfi+lo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=aeqfDLSLYRmPGWV1NEtbTkML5jH+ZyjzDixW+/s5uN2bhaZ8WUqVDYJHUzZyfbg81MbQuZIc4HQDnTLx7NxhID8yyx/8+D/stnJL3A73GFjEu5xnTRn/1+wAOgWQwglvXbfCGBSLPujw/Gtvr+0nNe3KtOBxjFxyRUtVGB0zApQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39a1ba36524so137460055ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 04:51:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722599463; x=1723204263;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FCCR+UNFf7STLcys3f3Y57PngW0t97MWfuPZDEr9fGc=;
        b=BFZZLGKxNjfJIMW6WKmmovcy6ZUvextdbpp9fVHBTpHb8+gY3G4fnXrUXIxFBUhLEj
         yGnzd3MH28DZoTELPM8GZB5QIrXj4rBSKMpYKtnn6vSWjjpLRGB3Q3N+pc7iiMUmYlXC
         SFwfllZB7G9MZsrByU+t3GbwT0Q3OzyBbuDAX2a6H4v0UWVGgoXHohhiFGg22HVKi8Al
         LHpkiG1W8Lq4xA33xNWOCFZ2ZedMivP0KHzRjkNshc1tAeEsSBPIUrPdY+DhXfvwU4vk
         3da2s1bjNCBr5EjPeSvMV2gkd+4d3ljAWLNAXoCsVoV5SkeS4qHMMUDYrxA+/Ajj4d/P
         M5kA==
X-Forwarded-Encrypted: i=1; AJvYcCU2ZblW2nksF++AE0W5KgpmpY54v+PmPfjj4WHtqWg1cyz/ue6MfkzdKLUOwnNRj5vvRwRpqFigxQCfd4KIqw8kutpmFJ5Y5aTssZPO
X-Gm-Message-State: AOJu0YxYhMXTFD+MqFN4+E0rltEa1BrANGjEBczJ06P6UyW8fdOJzLic
	6W15Jx5rHgxYMXtewV5ZPjn3Sdu9BI1zdvMty+MI91s9nuJQwQmroeEGkOI4H3ri6AL4V/eDBBs
	RIZZCw/ucgw4RjMrdlWjJ10B00F8cOGqCBy1ywW+YfEkScuEf6TLxf4s=
X-Google-Smtp-Source: AGHT+IEXfkLIW9BSZnRO2RA0rfmtoAUckwbsCA6QF3AxrI3t8MRxiXaSRwMSBmPo70XtZtaVK/eqwvV8aIMKOuS6TAxOHKWfhQf5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1523:b0:395:fa9a:318e with SMTP id
 e9e14a558f8ab-39b1f79d20amr2867965ab.0.1722599463509; Fri, 02 Aug 2024
 04:51:03 -0700 (PDT)
Date: Fri, 02 Aug 2024 04:51:03 -0700
In-Reply-To: <tencent_F0F725A60DFF92165D88DDBB9960CF878D07@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001cf2f6061eb1f171@google.com>
Subject: Re: [syzbot] [btrfs?] WARNING: bad unlock balance in btrfs_direct_write
From: syzbot <syzbot+7dbbb74af6291b5a5a8b@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+7dbbb74af6291b5a5a8b@syzkaller.appspotmail.com
Tested-by: syzbot+7dbbb74af6291b5a5a8b@syzkaller.appspotmail.com

Tested on:

commit:         e4fc196f Merge tag 'for-6.11-rc1-tag' of git://git.ker..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=123da623980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2258b49cd9b339fa
dashboard link: https://syzkaller.appspot.com/bug?extid=7dbbb74af6291b5a5a8b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1367c69d980000

Note: testing is done by a robot and is best-effort only.

