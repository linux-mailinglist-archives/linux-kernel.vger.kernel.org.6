Return-Path: <linux-kernel+bounces-426100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 674F09DEEEF
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 05:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 275AE2822F9
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 04:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6E313C67E;
	Sat, 30 Nov 2024 04:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CYfmZo9p"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E51B3FC2
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 04:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732940890; cv=none; b=DY4fULe9iNsa0IWqq0H2i0uqBVpkgx7m9AQMcYfbxxl8rpl4wAMQ876PXNT+7BQgtG2vL2JFtoflFEzTcnO/8JDzjYyYYRjGDidHUVvRqVjWAGBKQJccLKdHvFGAGOmtoaG0Gkqeg3uOpVA+3duaZjUbvQzXYe9GdBTzZFYsVMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732940890; c=relaxed/simple;
	bh=3fVPjAMLcPc8W9XHxCKejFdtJstDJyDr5I/dm5BmSG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nogc+WmI0UghXGMTVwcM6zT+RfWATCQE0z7QMSXIumEs0ZhpMVrUKpED+y53xA1shodombloRvlpNlhOrvg36tJMCkl4M4TIPhUrDC01NYVIRSue41/xrws1ioHRV/MjTCixSF0VlgI/c6Jx20hTi6/w0fbPcitI3Y/sLZQtanU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CYfmZo9p; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-385deda28b3so828796f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 20:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1732940886; x=1733545686; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=59D7wKw+lCrKikwTGg+Ep/tt5Aq7umJy0reSeHNByL4=;
        b=CYfmZo9pn7t2p0Du+sUkwzlE8cxodAvbflPB+PziTqhEVWAk5GSYSlGTNyNwHfy8bt
         oaRLxUR6xOOjPPjndw/TefADj5RaxYJsVIKK0QLYOAltcOW/2eGoqZgLBHyuzDSGWSP9
         dy2GV9JnZDLxsGzKmpseSKg9lH2jRTvMXljUWF+aZeqmQzzH18LAxX/FG2MoABIg2ymT
         8i4rVFrfjWgZnq/sNxlFQtxb3RgYMw2t2Yddne0W1NBR2jjE6TqsU9loZ6S6QCz5LmZ4
         6sL8GONVSLwVGa5mL/Me3Co35t18Yxm+bVi7VqaP1TM0EWcRKazWH3LREfQRh/8PmW7U
         ALbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732940886; x=1733545686;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=59D7wKw+lCrKikwTGg+Ep/tt5Aq7umJy0reSeHNByL4=;
        b=verUKfHTqTNwUWF805EeKbGTH9aBcn8Xa9oAeLIkjnIJVyiHQPc0dXgcjtzmaIm+AQ
         RPbarKtXRAH7B+9Fm5h9jPZWOLf6oDE+ZpcYAD2z07MqfHnysIo+SIOVq217AE7DIp5b
         Wl4SI1Qs3/T6ri2ZE1XSSd8XI0WjcYk3jCVz1/RyICNkHqixXYSjOa3uPDTsXkPv11PF
         ezoYl0a+3fmcmM3owwnBYot0yTjPHxLwrPoJDxMMtdLGTxY2xTxgsfyyIvbZeSvRyd6N
         YwS8AzNfPd9STZ1FHAYf6TGrDNxhOKXeJqehFzs+gz7gMyddRTwwZZIHqPkbdRHSEm7G
         VQ+A==
X-Forwarded-Encrypted: i=1; AJvYcCVDkUQfsfcxC1sTP3/I647Zvy/2qYQ2jK6D9doWuDSgAeb0PPpqievTet2c2Ybm1Zionyet51eRZ8YgDyc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxti5Ddq0eJPyYBnDwwRDDdS5IC4o6qibR3DoMqqkekAb/2jJQm
	nWtGuz96rJpRkaugrc+9149nr/xEqisMcJcfTA/p/VEJV/WTul1lP553JAy4PcY=
X-Gm-Gg: ASbGncuIvBJFc3xvkRbLZ/Fpxm+EQcOFM0RVjpMfmpKLaSeGEItz45A2j2AtNz2pOgF
	3zNnCBKHPGtwm321QC2xGIsshkkDUp0fTYNrjPx96LnEZiGv+Sj7ebiDJqNfNus7pwMLkeqEZN6
	D6wksQJ3XMkwjuEm577PMkTBijbOaLffNt2aIv/zrThDGKA3yO0rUNs6mOhSZr0DCsUjs3vIWrm
	wzVKfsuhR+0CxXINhLJDQlzBlYMWZjdA8T4QriMqNbsELoKHxHJATyz9NLaRpDwdFbS1DtwpmjU
	4w==
X-Google-Smtp-Source: AGHT+IFIR4lZurAZoQSAFf9RPCbGkRc4iM4JBekXOV1R5tl1fM/SR9MYYfnBI8F2iWQTnPk9eayFBw==
X-Received: by 2002:a05:6000:1448:b0:382:41ad:d8f0 with SMTP id ffacd0b85a97d-385c6ec0e2emr12419437f8f.34.1732940885462;
        Fri, 29 Nov 2024 20:28:05 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215478976e3sm17340845ad.58.2024.11.29.20.28.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2024 20:28:04 -0800 (PST)
Message-ID: <15a3a0ec-78fa-4992-a98f-6b82b5a387a5@suse.com>
Date: Sat, 30 Nov 2024 14:57:59 +1030
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [btrfs?] kernel BUG in __folio_start_writeback
To: syzbot <syzbot+aac7bff85be224de5156@syzkaller.appspotmail.com>,
 akpm@linux-foundation.org, clm@fb.com, dsterba@suse.com,
 josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, syzkaller-bugs@googlegroups.com, willy@infradead.org
References: <674a6f87.050a0220.253251.00d5.GAE@google.com>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXVgBQkQ/lqxAAoJEMI9kfOh
 Jf6o+jIH/2KhFmyOw4XWAYbnnijuYqb/obGae8HhcJO2KIGcxbsinK+KQFTSZnkFxnbsQ+VY
 fvtWBHGt8WfHcNmfjdejmy9si2jyy8smQV2jiB60a8iqQXGmsrkuR+AM2V360oEbMF3gVvim
 2VSX2IiW9KERuhifjseNV1HLk0SHw5NnXiWh1THTqtvFFY+CwnLN2GqiMaSLF6gATW05/sEd
 V17MdI1z4+WSk7D57FlLjp50F3ow2WJtXwG8yG8d6S40dytZpH9iFuk12Sbg7lrtQxPPOIEU
 rpmZLfCNJJoZj603613w/M8EiZw6MohzikTWcFc55RLYJPBWQ+9puZtx1DopW2jOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXWBBQkQ/lrSAAoJEMI9kfOhJf6o
 cakH+QHwDszsoYvmrNq36MFGgvAHRjdlrHRBa4A1V1kzd4kOUokongcrOOgHY9yfglcvZqlJ
 qfa4l+1oxs1BvCi29psteQTtw+memmcGruKi+YHD7793zNCMtAtYidDmQ2pWaLfqSaryjlzR
 /3tBWMyvIeWZKURnZbBzWRREB7iWxEbZ014B3gICqZPDRwwitHpH8Om3eZr7ygZck6bBa4MU
 o1XgbZcspyCGqu1xF/bMAY2iCDcq6ULKQceuKkbeQ8qxvt9hVxJC2W3lHq8dlK1pkHPDg9wO
 JoAXek8MF37R8gpLoGWl41FIUb3hFiu3zhDDvslYM4BmzI18QgQTQnotJH8=
In-Reply-To: <674a6f87.050a0220.253251.00d5.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/11/30 12:21, syzbot 写道:
> Hello,
> 
> syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> BUG: MAX_LOCKDEP_KEYS too low!
> 
> BUG: MAX_LOCKDEP_KEYS too low!

Hi Syzbot guys,

Syzbot is great, but I'm wondering if it's possible to disable lockdep 
for this particular test?
Or just let it re-run the test again?

If the test doesn't crash with my fix, but only lockdep warnings on 
certain too low values, I'd call it fixed.

BTW, I'm not seeing where I can changed the MAX_LCKDEP_KEYS values in 
the kernel...

Thanks,
Qu

> turning off the locking correctness validator.
> CPU: 1 UID: 0 PID: 11728 Comm: kworker/u8:10 Not tainted 6.12.0-rc7-syzkaller-00133-g17a4e91a431b #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> Workqueue: btrfs-cache btrfs_work_helper
> Call Trace:
>   <TASK>
>   __dump_stack lib/dump_stack.c:94 [inline]
>   dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>   register_lock_class+0x827/0x980 kernel/locking/lockdep.c:1328
>   __lock_acquire+0xf3/0x2100 kernel/locking/lockdep.c:5077
>   lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5825
>   process_one_work kernel/workqueue.c:3204 [inline]
>   process_scheduled_works+0x950/0x1850 kernel/workqueue.c:3310
>   worker_thread+0x870/0xd30 kernel/workqueue.c:3391
>   kthread+0x2f0/0x390 kernel/kthread.c:389
>   ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>   </TASK>
> 
> 
> Tested on:
> 
> commit:         17a4e91a btrfs: test if we need to wait the writeback ..
> git tree:       https://github.com/adam900710/linux.git writeback_fix
> console output: https://syzkaller.appspot.com/x/log.txt?x=12c5ad30580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=fa4954ad2c62b915
> dashboard link: https://syzkaller.appspot.com/bug?extid=aac7bff85be224de5156
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 
> Note: no patches were applied.


