Return-Path: <linux-kernel+bounces-180120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A28C68C6A55
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 18:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D48851C21234
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 16:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32192156675;
	Wed, 15 May 2024 16:13:21 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6590715624B
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 16:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715789600; cv=none; b=DSOR/HrDduq8AueDOo2R7ooOcGKGwO/+Eb7W72SZSD512xy2OEjYRLAc3V617qDfeIUwSsScG72ray8OsEFOWOJ1ngVyxily1MIr9Dq6UnCzSMVenRq+tZDCYAjxW8d6jzQvDGbg2drGUNHT0UkOkY/Rf4RX9Dj8Y1WoefOPsAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715789600; c=relaxed/simple;
	bh=t0Mk3nKAEE1cLuIRjfdcpsTNbeHzdncxmWNweD36IOU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=OzR0VHzgAg18mYJ6QRZWJdgSSEd1H7RSlARoy5HRWBVP5k7lXYF6c0aJj41SSGsK+Wgttw4Op2TDXWNmWFGPx8y+Q8DcCkR6l6ti3Sj5+po3hhd3iUtPjdrpQQEChkPZJk/4zIs52p3GfpurFdlH9Gxpo0n3UHauL6jlzS64wVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7e20341b122so167401639f.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 09:13:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715789598; x=1716394398;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vvsLw4l0vqKGby5/Tujji+uOTjNgc4o/TW7Xk81Qv2Q=;
        b=OwgMyxqlI0JOdHO/Cdqz/M9o5z7r+IHvla5ubnSWNe1hzjTZclcfDSU8lGA164UTDx
         IocwcXjWnRbLy0VYzPl06BqhJtVguWqLo/OYFrE7bJEb5/U55/Q7EeXIZDDwAniOExEk
         9IDBzYLOErYuStuhb+IW3KtIg1T/F3zUSEd3ShF1QYyHScsVnrZboHW3Q3gS4+uODdL8
         rAiW4wIkNPGvVIqc8rnAcRS5ns0PMlnuKY9jEntUxKTh2gNycYUQCZA8KVZhQIQn/e1c
         8lhS+P1JebECEJWlqtECKX6ZXXgjA+76TAmo/MwZw6gySQHbY4XvNbk4BjLAIgJeEwdC
         RQtA==
X-Forwarded-Encrypted: i=1; AJvYcCU5XJhdb26piZWCrana0rhl5a40eRpRz74E5OnveLncNr+qmdYTQ9JGFSS1j+ZlzkzyxW7VtiMoXriee1kpov14EN1lUptdk9LVrnu4
X-Gm-Message-State: AOJu0YyIJqWT/tMrZI3Mj/IEE56QMUHi2NH7aEFONYRTxfJ6MgKQ1wij
	rMhXOCtkGO2qj0mGrUO9p08q7Z8T6Ie2AiKpEXReFcBb5fBOn2u+jBcZQmk6x4V6FT97A0Gj9+z
	a5L0r0zstEg1S9DTDJVDs9oq/hkO0uinhiQUSU5aZp2+2L8+OZrRdUVg=
X-Google-Smtp-Source: AGHT+IG21YtExwT6/8ORt63x787W3Mh4x4nB2gggaQgJDKZHrwW7a5QBWjtJE2RURHC+qTbP8LJ+RwCnWEbVR0vWoc+wr7/Kg6jp
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6c11:b0:7de:e1c6:c72b with SMTP id
 ca18e2360f4ac-7e1b51991admr57736939f.1.1715789597061; Wed, 15 May 2024
 09:13:17 -0700 (PDT)
Date: Wed, 15 May 2024 09:13:17 -0700
In-Reply-To: <20240515161314.GO4449@twin.jikos.cz>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007147c206188065ca@google.com>
Subject: Re: kernel BUG at fs/inode.c:LINE! (2)
From: syzbot <syzbot+c92c93d1f1aaaacdb9db@syzkaller.appspotmail.com>
To: dsterba@suse.cz
Cc: axboe@kernel.dk, dsterba@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, maz@kernel.org, oleg@redhat.com, 
	peterz@infradead.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

> On Fri, Aug 28, 2020 at 06:18:17AM -0700, syzbot wrote:
>> Hello,
>> 
>> syzbot found the following issue on:
>> 
>> HEAD commit:    d012a719 Linux 5.9-rc2
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=15aa650e900000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=891ca5711a9f1650
>> dashboard link: https://syzkaller.appspot.com/bug?extid=c92c93d1f1aaaacdb9db
>> compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12ecb939900000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=140a19a9900000
>> 
>> The issue was bisected to:
>> 
>> commit a9ed4a6560b8562b7e2e2bed9527e88001f7b682
>> Author: Marc Zyngier <maz@kernel.org>
>> Date:   Wed Aug 19 16:12:17 2020 +0000
>> 
>>     epoll: Keep a reference on files added to the check list
>> 
>> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16a50519900000
>> final oops:     https://syzkaller.appspot.com/x/report.txt?x=15a50519900000
>> console output: https://syzkaller.appspot.com/x/log.txt?x=11a50519900000
>> 
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+c92c93d1f1aaaacdb9db@syzkaller.appspotmail.com
>> Fixes: a9ed4a6560b8 ("epoll: Keep a reference on files added to the check list")
>> 
>> ------------[ cut here ]------------
>> kernel BUG at fs/inode.c:1668!
>
> #syz set subsystem: fs

The specified label "subsystem" is unknown.
Please use one of the supported labels.

The following labels are suported:
missing-backport, no-reminders, prio: {low, normal, high}, subsystems: {.. see below ..}
The list of subsystems: https://syzkaller.appspot.com/upstream/subsystems?all=true

>
> This has been among btrfs bugs but this is is 'fs' and probably with a
> fix but I was not able to identify it among all the changes in
> eventpoll.c

