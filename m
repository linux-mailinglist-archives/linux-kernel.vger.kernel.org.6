Return-Path: <linux-kernel+bounces-396282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0A39BCABF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 11:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64A90B2259F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 10:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934931D2B10;
	Tue,  5 Nov 2024 10:45:21 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24F81D0950
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 10:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730803521; cv=none; b=Nq/5xW878ep2HuPCOY5DltKj06w2uO7RNBmRYpYphGSGx00D24JLp3/7js/VgUE/d4JJAiCZtLaqGChQusxavYvtbIh2GOtu0JKeSEPraGYdLMzajiyiyFQbgvTgY0qJYD5oqqfGDKTUqUg7LkSVS84xFNZZ3edyiaxoxp1uvXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730803521; c=relaxed/simple;
	bh=zrTsAV5vLe0uxXcWRVClt59ESYnXvbZWodrvo9fD7k8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=nPvhxx3o1dPlGt7jXMd5sBwd9OjRjFZc9l8NeSZ1pMMGt+QBCksaDmlH/G0lHmrkaBFlZUUQHo5iAusVMU+6OMdim6FTEH51O4AWcmA5AFn0TWfJ32JQ/Y2IWHSLeI/8Gu+Eiy+1c9oR3BI4Q02Q3ckC4EVDYKCB6MhEoLjAnzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a6bf539ceaso24392055ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 02:45:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730803518; x=1731408318;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IZ2ZEmKkEGBah3IP5OP7lq/If4Hy9itJVErTmZIj6i4=;
        b=iYYfTSKMLG8UvSrzd0q5L74XDQlqONGAKBt6GAyqU2uXOGyEeFpbtm55o0QacSuI6f
         HzC7J27JvJkfGJz5j5DbcC19BbCKpXSZIbjBKTtEhXOQvGuZBtiWDz++MSHuQ4K+LWmU
         csXLoftlh2KztjWaXnac2ioH1AqYmb7UswNj0ymf7KHCoh2O+X2mul93b6Oc4i4+TNyY
         t0wkJrDtcmpBH68CWTkfpwD8IF6CDqDFTNc3iSKipyRXLoUxkqjzfj3Fc4f5c0G1pe3U
         PvFmgod0lAFKjPxwesxgrWqiQa+GiCdiVq6bfA7ZyZBI0q86q4gOFMFKM4c23noJ64cX
         cL6w==
X-Forwarded-Encrypted: i=1; AJvYcCVuxrbAA9GzQrjhpeWG46U41qG3bWTdG0LqDFksmppzzaH3NkCWU4hIqDzdl4sKdEBZdLIXgY2N8/sIrPg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy71pXSD0kETVwTFVJg64yIstozFhDLSuZ4icL57KClyeJHxYNr
	OMSZSBn6QEkAsY11JVmFMlnN0FEo/CQMfJNLWDyU+nSiQbutaAtnOUEj5NREUws5JCC/KQ3pB79
	beKT1juTM5D1ndQTSPim7NgOSYq5tTA1fHgFE1ZNqunYdBAVJq5TTeKc=
X-Google-Smtp-Source: AGHT+IHIyUl8wEuF87GVyfMyb85wK2asPyPlVhLNel0fxdN9Kt82s0JhOnd+4caVjZopihN3r+FwBAEypo6gyTI9neMOrXkADoxn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3886:b0:3a3:a639:a594 with SMTP id
 e9e14a558f8ab-3a6a94a162dmr133746925ab.4.1730803517848; Tue, 05 Nov 2024
 02:45:17 -0800 (PST)
Date: Tue, 05 Nov 2024 02:45:17 -0800
In-Reply-To: <20241105104500.3206-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6729f73d.050a0220.2edce.1509.GAE@google.com>
Subject: Re: [syzbot] [block?] possible deadlock in __submit_bio
From: syzbot <syzbot+949ae54e95a2fab4cbb4@syzkaller.appspotmail.com>
To: hdanton@sina.com
Cc: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> On Sun, 03 Nov 2024 14:19:28 -0800
>> syzbot found the following issue on:
>> 
>> HEAD commit:    f9f24ca362a4 Add linux-next specific files for 20241031
>> git tree:       linux-next
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16749340580000
>
> #syz test linux-nex f9f24ca362a4

"linux-nex" does not look like a valid git repo address.

>
> --- x/block/blk.h
> +++ y/block/blk.h
> @@ -72,8 +72,6 @@ static inline int bio_queue_enter(struct
>  	struct request_queue *q = bdev_get_queue(bio->bi_bdev);
>  
>  	if (blk_try_enter_queue(q, false)) {
> -		rwsem_acquire_read(&q->io_lockdep_map, 0, 0, _RET_IP_);
> -		rwsem_release(&q->io_lockdep_map, _RET_IP_);
>  		return 0;
>  	}
>  	return __bio_queue_enter(q, bio);
> --- x/block/blk-core.c
> +++ y/block/blk-core.c
> @@ -358,8 +358,6 @@ int __bio_queue_enter(struct request_que
>  			goto dead;
>  	}
>  
> -	rwsem_acquire_read(&q->io_lockdep_map, 0, 0, _RET_IP_);
> -	rwsem_release(&q->io_lockdep_map, _RET_IP_);
>  	return 0;
>  dead:
>  	bio_io_error(bio);
> --

