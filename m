Return-Path: <linux-kernel+bounces-204863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 975618FF467
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 20:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A40801C214DB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 18:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815A11993A6;
	Thu,  6 Jun 2024 18:12:04 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC81D1991B5
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 18:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717697524; cv=none; b=aXHvF7SVoM0bvjkH0Rx+Pk93peD9PNxIh5/RL14LnuK2EJD9KLikkuV1fwTa+EyLYMY6aVlWDMTrLN1LzYgEvbhhdtXDLLozXqn4PpZtWH8icm/2JGef0I1C/UZlNRHz3DwnCcBKo2U3YQcyi4ATNDdflyvVfJhPOnxXaC39fGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717697524; c=relaxed/simple;
	bh=kLYzDmWA3pyQdK7Jqxoe6qobWlNGmt2GYRUgM8Acftk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=XTpCKegJZw/U/xCwDXEuJqyXBiQss7IkYYKPr5QKuN9xAUEHDPIz4/6mWqERXbwBWBS2CCI0qrsoD0jC+ELEPr298dbOonG6J+7C4dc/3K8w3aYsXVlJwkjYmJRsDYiKDi4AWMM7vsBpXQMW/wj0iBVUQ+FQ/5X0dp77cQip/P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7eb3978abc6so135520439f.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 11:12:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717697522; x=1718302322;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V2rWMF7FdfmFH841KzQGtKomeowBbSw4OlbWNTnW3+w=;
        b=R653AfS96a+1QdUdzQ2cm5v4aqKxQ8LNdbNWTNdVzI7eIvKdMRSiaDCbAwgigK9ca+
         whXwDCBEtZtE71w6m2IUKHGZnZSpp6BEWk+t8CJLa8HQKf9+2UquiWOvfc907g/bz3Xw
         MWHtX28WlKeV69TDKQa5UCak79iDQl4SbY6cSfc1MpKw/Ivhoqt1DVbiRyI+uKx1iLHI
         xPS4vFfnuHGO8RqINhYvXOoCOiZszET6Fn9ZukuA/i6z1wEH/Jp6bVWqKKEFMhXTkAqA
         KmZ+DpQX6eL4JXlbtvgqfvSgKv4jPkmUsux9sm9/QTRIEINgXhBW3rNQhj+2SmYOLe24
         GPpw==
X-Forwarded-Encrypted: i=1; AJvYcCVA3Ph89HLg0LzfbkVc16VDhHjssMC3xMYnltzCf4QwCy3YVHIR5spCJU53YlnNlVv3EBqvbfnW28hSeEN1Q4lQbPrdUtjIXOOXKA5a
X-Gm-Message-State: AOJu0YzPOurZ0Gu4MKkONfdXMTbFH24SLn8gnlHW0NxNMHKxsDsOWJwy
	43XzDEA6D9hrYLgQyV8gXjA1Dd9fr2wEJWetXJdHcQK5Hmr7u6LqSJrjCl028t5+k4ECAAexlOq
	2dsTcxerbUW5R9ItyXbnsLriDS778BxVhpkhdpQ6rkzBFpd7miGVJajg=
X-Google-Smtp-Source: AGHT+IFGDmcj0wx+kVc+721VYPwAJWApv5UjdfNQomzhQk27c2MwrVZ6VKmhSC0C4BXLfF0sU7CPtxrdwgX6u/8lRNfAOUrtmhtX
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c49:b0:374:a2db:d6b0 with SMTP id
 e9e14a558f8ab-375802fd4b9mr301405ab.2.1717697521927; Thu, 06 Jun 2024
 11:12:01 -0700 (PDT)
Date: Thu, 06 Jun 2024 11:12:01 -0700
In-Reply-To: <0000000000005221690619d26681@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a05a05061a3c9e19@google.com>
Subject: Re: [syzbot] [bcachefs?] kernel BUG in gc_bucket
From: syzbot <syzbot+246b47da27f8e7e7d6fb@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 228e1c91ae5ec44f38aa8852aa3953005badce82
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Wed Dec 27 23:31:46 2023 +0000

    bcachefs: KEY_TYPE_accounting

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16a17f16980000
start commit:   0e1980c40b6e Add linux-next specific files for 20240531
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=15a17f16980000
console output: https://syzkaller.appspot.com/x/log.txt?x=11a17f16980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d9c3ca4e54577b88
dashboard link: https://syzkaller.appspot.com/bug?extid=246b47da27f8e7e7d6fb
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11ca95fc980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12a49ef2980000

Reported-by: syzbot+246b47da27f8e7e7d6fb@syzkaller.appspotmail.com
Fixes: 228e1c91ae5e ("bcachefs: KEY_TYPE_accounting")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

