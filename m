Return-Path: <linux-kernel+bounces-266703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC5C940596
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 05:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 175FCB213FD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 03:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B877FBD1;
	Tue, 30 Jul 2024 03:03:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A060933E8
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 03:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722308586; cv=none; b=k51t7r+bYq3hxNt7UJEuLH1VDOxN/Y5B9KyxM6kqnF4WFgX0F62ppjweP4xk0KtmVWZ5mz2yGDkOM72lnc8Vkr587AvNPrwAi4lZhEVdUlTkFXHpHKVQ7+nJ6cXbB36s8uNGE7q8/zE37OdrLXgPET9v+1HGxBPoen0PoBOHHNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722308586; c=relaxed/simple;
	bh=NpyqljaOvpFdHFDt+c4ojHKkj19Ogky1R9Zd7IGb7EA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=HXBZrqaXbmgeaybiD2nFjQzRzZNhV77Hv5nq1xeLWZzpeS4mxnxsxb4UIe6cJvW04V8s3+KCDHYG1DvgVei/cN384qLBvW1lde1eSYkGacTwa3Sv+g2nc5wQVrSP6oQAJMVfF2GbVG5U16ru4jkPJBS8B97762OTjNpnGJro8gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-81fa44764bbso333043239f.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 20:03:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722308584; x=1722913384;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xJF8fNiX+fEwOeb6daqLS/WayYFFALyzPSai1klZsjM=;
        b=UMYPQfPVfp3AVjtFT/iN51n0BFh8dhGVIORyW6cShfbvmDyhvyYtQ8xGM7LkuZOku0
         2TTfWWmIYiknnr2dblk9JIgb1dgKYRk2m9QrulqQn4Dqwvemrg3LUAt1dDrSLf3haCEK
         jwlz9myxHhX9gYe2+6bLYni1Zd7SDCXhPzBc+/O2HW/ZqbXXaMgYPckXgm9bOatGcOpH
         TLO/Dr+9+aQP8IHU3m2DKaIomgIk96ky05kpvgKwvIpTgEKxbfnClBZhskHCjcTTg8jr
         5m8i5SGIhn8VwLfL8qVjuSbUpsLSqzQC5B3SfiseurZn8wWGURcbVbyH3HqglcW0lFlF
         xz3w==
X-Forwarded-Encrypted: i=1; AJvYcCVr2gjWsci0v5WtasANbI432j9Ekhx8tnJYHL+rWJpy7Rt5MnaKE5eaf05W4vjqbYJIEShEpfDQSfprdq89gd/Fa6Pr0MytMm7qHC0E
X-Gm-Message-State: AOJu0YwZltVId0v/GNuBHx9xkZ2SnILKfIzQz2p9RHVSE/IYKAElVZD+
	CyvyN/UO0ohGITdd/O7ywaw1iMaUnRjBQMQkgRGQwlT3TflrNPVF4MSJ+JBWKqOyNKvXn7il/du
	SlLlcOg/j0gbevtw9BFvxdoILKxwolst2TJkbrFKzv4oxhrgylXsDwtU=
X-Google-Smtp-Source: AGHT+IHMl7ZB1zCdlPFtgEeVRI0wvSZd6lEaz87UvCdW0BZJzQgHKLxC89ps1B2s+GnjXc6XIIImF2R/tSukPiNJLjS/ZemQ6pa0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2dc8:b0:7fb:ff2b:5116 with SMTP id
 ca18e2360f4ac-81f95c391f0mr41337139f.4.1722308583809; Mon, 29 Jul 2024
 20:03:03 -0700 (PDT)
Date: Mon, 29 Jul 2024 20:03:03 -0700
In-Reply-To: <tencent_DAEC5ACEE079366E9C2C516E6C9568E9AA0A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000054f2ec061e6e379f@google.com>
Subject: Re: [syzbot] [bcachefs?] KASAN: slab-out-of-bounds Read in journal_entry_dev_usage_to_text
From: syzbot <syzbot+05d7520be047c9be86e0@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+05d7520be047c9be86e0@syzkaller.appspotmail.com
Tested-by: syzbot+05d7520be047c9be86e0@syzkaller.appspotmail.com

Tested on:

commit:         1722389b Merge tag 'net-6.11-rc1' of git://git.kernel...
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=155741c9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b698a1b2fcd7ef5f
dashboard link: https://syzkaller.appspot.com/bug?extid=05d7520be047c9be86e0
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1492a303980000

Note: testing is done by a robot and is best-effort only.

