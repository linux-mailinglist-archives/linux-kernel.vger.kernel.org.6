Return-Path: <linux-kernel+bounces-176696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2C58C3367
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 21:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA67D280F9E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 19:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4884208D7;
	Sat, 11 May 2024 19:20:07 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7A01F945
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 19:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715455207; cv=none; b=eWKk3efI3gsFLbm5s5guYIEnbrzxW8OPR3NUJaM8lbyg5xtLOKkkVkX4xS70OhfcKKDFkA3e6MXVjRk0Wn0OV6NmhVh8wQEmM2821OJAI7p/IkjHDpttVVqqMrVKFyN6UMVn+J/tLRa8KG3j6+1ayHUX9WR4JCol2Pa9gG51Jn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715455207; c=relaxed/simple;
	bh=+qv5reRo74cVbtPewf0lBZ2jqRG2ETEiX81GoJk+c40=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=EgTrGFCMw3QNHvCiD+ravj5mZBMrlMZFJBwzDl16fYFiC1iA4HIsmswe1PxIIkpi6bBz3D+9E7+To/40EeqtewjTZpvFI2cApIjHrN031lehXeUGU/vPCXYn5nz09NUN5mnMuvQGwjRYTQQR/HGsmdpmyqL6BF20zrG2ndd+Enk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7e1be009e6eso219623639f.2
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 12:20:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715455205; x=1716060005;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TU8kylx5Gi7UfPvHnXW2cq5h56a8jRhWapkflJkHeLA=;
        b=lyCQ9VJpu1y0yfS6T3/D9iAW/+fXOJsCbc2Kuzs0FasZP1tJY/r5hrWdqI3p7iWNmv
         NKRMfKIyiQymEXt4htwaECGTQ7Dt3jzQlge6QO7M3Ti6gz0hsIrTOuynoJFNzPeLBbpI
         nI81Jx1egv80tGadbxt/OLJxKiwqwKMNriPwi2oLcom8e6j+KzNOlNqnS3V5IJPwRNyA
         fL3wSDHGXUczrSJjZ4v7js/T8OvC/fF0ijgCwuzBo2ya70GUUkd3TozNgsi0MOEELRkT
         vPVvaz5mnfmOShpF9NehY0f1W73JxqIYeBP+4J9QRqo/S4Ox65wubVfIMfnwwQuEjfSO
         Bomw==
X-Forwarded-Encrypted: i=1; AJvYcCVB1DZy0bjJ1fZ8YAow31m3M3poIMWFGxXswamzJDHSjEeZedcCdOLdbh4zTWdCi9J8qwbrldkMcMFoDfDVRMR8q4uqTCNbUV36FAp7
X-Gm-Message-State: AOJu0YzzkAO54OHy3R4Khl/up2+qhPOAs4YyUMb4f8xj31IIm1swuGlE
	cguhbfD9eR4GIyGkbkQ39TCnzHvF3VS+99C1YepZMKCKGor/kIlALQvk0wGAijQGpaAhlw58N1K
	/uX46MX821Oa4X6+yjZLNNhBaWwchgj2FTs+rpL2bjV6tbeipcKsvJzo=
X-Google-Smtp-Source: AGHT+IFQoLKTR0PomMsJmuoyW7oc8rG6EF2EtPkrDu6jPAscIBpu+Im9GhsGHH7rjpezK+/RJ84N2PgFrVl1yUwIXBxs170Q4cH4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8305:b0:488:e81f:845d with SMTP id
 8926c6da1cb9f-48958e18e34mr397992173.4.1715455205110; Sat, 11 May 2024
 12:20:05 -0700 (PDT)
Date: Sat, 11 May 2024 12:20:05 -0700
In-Reply-To: <000000000000bc3c710617da7605@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002104c60618328a78@google.com>
Subject: Re: [syzbot] [bcachefs?] WARNING in bch2_fs_usage_read_one
From: syzbot <syzbot+b68fa126ff948672f1fd@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 03ef80b469d5d83530ce1ce15be78a40e5300f9b
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Sat Sep 23 22:41:51 2023 +0000

    bcachefs: Ignore unknown mount options

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=154e823f180000
start commit:   2b84edefcad1 Add linux-next specific files for 20240506
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=174e823f180000
console output: https://syzkaller.appspot.com/x/log.txt?x=134e823f180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b499929e4aaba1af
dashboard link: https://syzkaller.appspot.com/bug?extid=b68fa126ff948672f1fd
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=155c109f180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=136e52b8980000

Reported-by: syzbot+b68fa126ff948672f1fd@syzkaller.appspotmail.com
Fixes: 03ef80b469d5 ("bcachefs: Ignore unknown mount options")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

