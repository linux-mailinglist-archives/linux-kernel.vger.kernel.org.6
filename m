Return-Path: <linux-kernel+bounces-374457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBDD9A6A87
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 15:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7C1DB26378
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 13:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F391F819A;
	Mon, 21 Oct 2024 13:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="btYc6JmQ"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6EC1F130A
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 13:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729517874; cv=none; b=FuIbDY6AIMjiu5W6W6rJxw9klkqaFVYW0tqUYw8u+hoPw4tu0OHFTJG1XxB+zP5tNLi3cuGKMXF4S/muxJKtymKQ8ux2FkO2e+GdvCX6U9LR2Sd7UMdDvhZK6tTxjtJ0+0C5NkqI71dKTe51swQiSgn5o08lBfHuW6edK+bGbOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729517874; c=relaxed/simple;
	bh=n6X/0/W+M7OgMRfLkaxcrvDPRmAh9uAqLDVZJJMEoY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pj31BL25oDYa9m8STW9RMGMZX+HSIji9Mgkp8vm1hKT/wlDJy0bD4l+kyTpfa18DPLipmLfeBbCr7vdW8tt/EhL4uweheDCPZ1NDejAxJcKs0QZXKWo5qMj77Yj7+Xxcp8OndeBrMoaIkhUkHXV/psR3jqgt27Ga7Os+JS7Fsyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=btYc6JmQ; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7ac83a98e5eso359198385a.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 06:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1729517871; x=1730122671; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YWEbsxsm53Lx9ILIr9ES9qF+72+igaeoLguBxIwGlnE=;
        b=btYc6JmQYGVjd0pizSwHJKaQfJ8TOEymOhwGob6FrX9uGZaZdEU8atP4lhWinwV2GF
         5JkJB/W9svY5HfszAqHwaCnBnNQ0uI7I/62fANx8rmVEIdz7Mx7bwGXy21+SemH2BmDh
         3kBa4TmuM09mwOaUSCm2YRtAaanOFMAnMBlRoVggxJKrZ+qRn3bNuoPlRC2u6IAiSn6h
         VHfsxnTGDZQbLO7DXk52I48GL6V24asPCNI3L1BKlCZzIWD1qt2qScvuQf6O7eyeVyEZ
         Ct/reHZuPyvDQmG+EVx7QLgZYq07vVqj3HDFF1uDXNn2N+57RSFxRfjDo0irYq5PajIK
         rpIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729517871; x=1730122671;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YWEbsxsm53Lx9ILIr9ES9qF+72+igaeoLguBxIwGlnE=;
        b=e5LDKe7dCLrUUXaTQVr0tGA0kuUfcc95xe8w5Z6D3ARgf56ZZxK2W7ePEpafTUbUcT
         c6RRRcZXxiHf60veCPGfW0HqyP8qR9mLFCPHiDPU/3JFNEKoBQYWa8vU7LD1gOlpqAEq
         a6ZiImHeIUOm2iKZP165hLnM0lIPBlCa7GGryeodBO1aVOYJl0tPHxGUnqKJ46eRyv82
         CzIo9UbHLW3FhdZnEoUhJ/+yJldNqRwUF4CPUTLZi/9OQkLMMZD5ISfntvkh9g5/fZtl
         HNZXzO8CSTrKsTjGNinaTQpwmOJwXeAy7JtOCKsBA6EK9qDt7nGOIb7mqmHMdVBY69yo
         10Ew==
X-Forwarded-Encrypted: i=1; AJvYcCUXRM6DDJ+nnmN4DifY6jQstAQFqJABn9hkMz+GqZL1xCGbAOf4T9J98J4ZQZXLm/rt2J86/N6x04o6BOc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI71+Oa6D2RHwZEm44pD3QCohSJk3i+KjhbON7NmuCKpUYAbMB
	mGOQPnKWP36SIXe5M/hTzak4Zjg26flLFmVe5d8FhQgsufFEhSzV1jzS4onifdPE4Py796guhbQ
	=
X-Google-Smtp-Source: AGHT+IHVugA7rEA0S5MRO0aQ9bm5te9cXooKX14KNYGIWCX37+E15VSBV1ORs5uVp4vT1+W9FeqDMw==
X-Received: by 2002:a05:620a:2448:b0:7ae:310a:75de with SMTP id af79cd13be357-7b1576dc231mr1880845185a.25.1729517871288;
        Mon, 21 Oct 2024 06:37:51 -0700 (PDT)
Received: from rowland.harvard.edu (ool-18bba9aa.dyn.optonline.net. [24.187.169.170])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ce00999c52sm17193516d6.95.2024.10.21.06.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 06:37:50 -0700 (PDT)
Date: Mon, 21 Oct 2024 09:37:48 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Oliver Neukum <oneukum@suse.com>
Cc: syzbot <syzbot+f342ea16c9d06d80b585@syzkaller.appspotmail.com>,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, sylv@sylv.io,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [usb?] INFO: task hung in usb_port_suspend
Message-ID: <b5093db9-8f4e-484d-bed5-cef08f69eecb@rowland.harvard.edu>
References: <67153205.050a0220.1e4b4d.0048.GAE@google.com>
 <0abd3cbd-0e8a-43b2-8cb0-6556297aa7c9@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0abd3cbd-0e8a-43b2-8cb0-6556297aa7c9@suse.com>

On Mon, Oct 21, 2024 at 10:04:52AM +0200, Oliver Neukum wrote:
> On 20.10.24 18:38, syzbot wrote:
> > INFO: task kworker/0:0:8 blocked for more than 143 seconds.
> >        Not tainted 6.12.0-rc3-syzkaller-00051-g07b887f8236e #0
> > "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > task:kworker/0:0     state:D stack:24544 pid:8     tgid:8     ppid:2      flags:0x00004000
> > Workqueue: pm pm_runtime_work
> > Call Trace:
> >   <TASK>
> >   context_switch kernel/sched/core.c:5322 [inline]
> >   __schedule+0x105f/0x34b0 kernel/sched/core.c:6682
> >   __schedule_loop kernel/sched/core.c:6759 [inline]
> >   schedule+0xe7/0x350 kernel/sched/core.c:6774
> 
> And this sleeps forever. This must not happen.
> >   usb_kill_urb.part.0+0x1ca/0x250 drivers/usb/core/urb.c:713
> >   usb_kill_urb+0x83/0xa0 drivers/usb/core/urb.c:702
> 
> We are changing our mind, presumably due to a timeout
> >   usb_start_wait_urb+0x255/0x4c0 drivers/usb/core/message.c:65
> 
> We are sending a control message, presumably to enable
> remote wakeup
> >   usb_internal_control_msg drivers/usb/core/message.c:103 [inline]
> >   usb_control_msg+0x327/0x4b0 drivers/usb/core/message.c:154
> >   usb_enable_remote_wakeup drivers/usb/core/hub.c:3365 [inline]
> >   usb_port_suspend+0x339/0xf10 drivers/usb/core/hub.c:3472
> 
> Suspending ...
> >   usb_generic_driver_suspend+0xeb/0x1d0 drivers/usb/core/generic.c:302
> >   usb_suspend_device drivers/usb/core/driver.c:1272 [inline]
> >   usb_suspend_both+0x66d/0x9c0 drivers/usb/core/driver.c:1443
> >   usb_runtime_suspend+0x49/0x180 drivers/usb/core/driver.c:1968
> 
> This very much looks like the HC driver used to run these tests
> can hand in unlink. If that happens there is nothing usbcore
> or a driver can do.
> As this is now reproducible I would suggest a bisection. Brute force,
> but I see no good alternative.
> 
> Syzbot is an important tool and if the HC driver it uses is unreliable,
> the whole thing becomes unreliable and that is most undesirable.

This issue should be fixed by commit 5189df7b8088 ("USB: gadget: 
dummy-hcd: Fix "task hung" problem").

Alan Stern

