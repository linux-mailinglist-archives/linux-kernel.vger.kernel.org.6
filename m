Return-Path: <linux-kernel+bounces-425996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 548249DED98
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 00:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DEF8B21765
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 23:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C5D1A2C21;
	Fri, 29 Nov 2024 23:23:46 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EE638FAD
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 23:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732922626; cv=none; b=gt0nGjvPw/6pRyYop4w2SQyoDdQ+Lt/l0KpSHDPKnvhrGmKxHu3bxqeYnjHkBVMiGQ1TBbe3zAcNwOyGn8R/h8Sq2pVJ8NH6n3IkGVqUyOe/V0aduLeDlZir8QUn3w74Eu/r5LsT/JNR6fe7KMMnsXgFPFVfAjo5ae90pb9DeHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732922626; c=relaxed/simple;
	bh=xqq9+YO6rrkxyDevE8iK8koX8jXZf3TJAci0T4rD068=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=EDFMPpx3+LFmJZZXHoe0gUPMbZommySZNOUs17zhZ/UXADyRY4IqGswolRQZucrTDFipUqwIxvXR5UPvxnsp1+kiKdKiWmV8Usu9HY4tZJYZ210ynZwJbwzbLBc0r0dJcWIRwugUx8Zs0s6+oxc7UTr1xeaZ/KqpX5iWxZ7H5Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a7e1e6d83fso6292585ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 15:23:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732922623; x=1733527423;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P5fZyehtNpUgHHlACVplsP57vcviYvifugJncV3rDt4=;
        b=k8BCbK/hcyHT3no0eyzheIR4sOTf08or6BkDGzbYskRXQHQ+JwY3eL19XaSpRix8VH
         TycvLobyu8oXWqu6m1x4e8/sfFD75RUJ6sanrCcwWy5POyZ7aDg9nGdc70QlGq3ybHiW
         PlTxnQmS7+1VYk+LifShR+j0VN0NPeDdmMV/b6g9tUAjvbJVBQ5qgtZO8jV/mtyxPr6D
         R1H5rG1ueLPBtSnaZBbobsDiRKP1QAS3T4QXpKw5Mq5JwekZ96Cm6AMZOilbTrLIm4f1
         6cUumYfOo8Y5bZd9t/Z8e9d/ln7tHPVqZA+vsqFPQxfePk/gOMQgMRn9bY/nBaOfz+Lq
         OF/w==
X-Forwarded-Encrypted: i=1; AJvYcCVDp+ZJR57Mg0a+R3SsmeJv8da/h4tA5HJJk0unU+9zSpqEPP8y31u0pJutAbT0+1iGCwsgHGewbQLw0WE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzdukZgtfrGaEtybBW2SYr42eEVv4oaXykjASObV3gQ0aNDdpX
	18fNIsvOZigTYIsMLgtHJsCThyATJk6OvU/WBuFpzJz1tRW66NpLVTESvawXFC6ilDNidAReqM2
	JEJDrsx63GJz/MrjPIz+YcRH8yFAGkDO8Qba0kax3UnpbMt2SdKewa8g=
X-Google-Smtp-Source: AGHT+IGLtU6cJpRtNvcV62Rl8Y7ph51NONkiRM2lfW14Be6Lc+3VRgo2DuujWXOTdXuUbkHIL3z10CTjA+G6HVKd+pdsIVFfy6iD
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c88:b0:3a7:70a4:6877 with SMTP id
 e9e14a558f8ab-3a7c554589fmr108756235ab.7.1732922623663; Fri, 29 Nov 2024
 15:23:43 -0800 (PST)
Date: Fri, 29 Nov 2024 15:23:43 -0800
In-Reply-To: <20241129232325.2100-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674a4cff.050a0220.253251.00cf.GAE@google.com>
Subject: Re: [syzbot] [netfs?] WARNING in netfs_retry_reads
From: syzbot <syzbot+fe139f9822abd9855970@syzkaller.appspotmail.com>
To: hdanton@sina.com
Cc: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> On Thu, Nov 28, 2024 at 11:27:24PM -0800, syzbot wrote:
>> syzbot found the following issue on:
>> 
>> HEAD commit:    85a2dd7d7c81 Add linux-next specific files for 20241125
>> git tree:       linux-next
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14e3a5c0580000
>
> #syz test

This bug is already marked as invalid. No point in testing.

>
> --- x/fs/netfs/read_collect.c
> +++ y/fs/netfs/read_collect.c
> @@ -619,8 +619,7 @@ ssize_t netfs_wait_for_read(struct netfs
>  
>  	for (;;) {
>  		trace_netfs_rreq(rreq, netfs_rreq_trace_wait_queue);
> -		prepare_to_wait(&rreq->waitq, &myself, TASK_UNINTERRUPTIBLE);
> -
> +		smp_mb();
>  		subreq = list_first_entry_or_null(&stream->subrequests,
>  						  struct netfs_io_subrequest, rreq_link);
>  		if (subreq &&
> @@ -628,6 +627,7 @@ ssize_t netfs_wait_for_read(struct netfs
>  		     test_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->flags)))
>  			netfs_read_collection(rreq);
>  
> +		prepare_to_wait(&rreq->waitq, &myself, TASK_UNINTERRUPTIBLE);
>  		if (!test_bit(NETFS_RREQ_IN_PROGRESS, &rreq->flags))
>  			break;
>  
> --

