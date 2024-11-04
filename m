Return-Path: <linux-kernel+bounces-395149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 265A29BB93A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 16:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49C5D1C20F39
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 15:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8516C1C07E5;
	Mon,  4 Nov 2024 15:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="dqSnKWGN"
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655DB1B6D14
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 15:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730734992; cv=none; b=eYP2s5QF1/NHzrwNY8cRRZFIAvtx3JPeh9JlFgtfbbiSfLvFpK1AbP0R9i/gM/TIW2h1ZKpLxgF2ar5017QZ+OFsI0QEeI8ZxN7l+mxSrorf8efYGlHC6zLhVpsf6A05UlwGFedkLZWPXfMMC6iiHGM5u5/ZbjfoGto0eDgQ0RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730734992; c=relaxed/simple;
	bh=vq+NtXuVkkXOYKdE79BGYN6SgoBDPEAWM4UASDdmfxI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oxRnlq0Uo32PggEnZVyp298b7u0N016AQcyT3tDwCOgQMYIgcuKiDyLtaYACVDhp9wrSvTJ54XLHFFAfVZqCf/kelGkGXV90En0Jr+6rXUttKRDP+SR3iEfijsn6l1jy2W/7HEBSmUWD0lGvoAkA9wXeUiplERvSZfuBsrzUOKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=dqSnKWGN; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3a3b0247d67so15176625ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 07:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1730734988; x=1731339788; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TP/XhExEdt0zq2yXyp+ChPaIA0iZBpgf73+hywwHyJY=;
        b=dqSnKWGNY0WTVfEVYPPTKu/a2Q/6g5XMLl6yvkXpPsu7ViUVpRDrik8pYkzyajb1In
         NNaJqjtU3o2Vn0RD+WG3K0FKaSkOm5ZdkB1ZOH7yE7KpikbBBasgv1NTmAsQU5eNCVUK
         dc5Q8PsMesjqu+9KFQU4j77sFL7enc7Yv1skL5p5mDyeXofuDIYhRp3f67NcbTmm07Kv
         GJfnCP9LkXrC/Tfp6TLcs72zZcEAdX5XIhRkh9/xQvyyCpOM+J7pRohuhWyY7Xn20026
         YbOZhMCXBiAaxgBLoNWLk6iX2nGra8i70FtLrBSGjn/KYubsE8WkRGzZPnXI8w8FfF0x
         BzMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730734988; x=1731339788;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TP/XhExEdt0zq2yXyp+ChPaIA0iZBpgf73+hywwHyJY=;
        b=Ly/5TlI5/wSbazY1VCJ9E5Vl+/IBtsaX096cHgzy2XRow5nvySyC/F1MPrL8YT8C5g
         ox3+KDdSZBu7PC6VCJOlQUr+ZfOKWNy8jIkAqRN7fQKpI/jDr+0MpfndKpzOGzuhjwqs
         942WxAqapJxHJoKlrhl/F7aWIHnoDgd3aRjz0EkxIlQk7y6LnHkkR+hPEPJCrcy5C4mY
         YvQCe8NjGDiijVQMrm9gkLyYhdPyfn3jMx4Hm35/CL7+7pKH/SnvsJ04j89v/9mpjY2y
         X95gfn2fpkeom+63al01wevqcPMtID3IJ+ltcTm/3CU/SMmiJAj5iPj7DShkSu6h+klB
         zVDg==
X-Forwarded-Encrypted: i=1; AJvYcCUWOLNb+2EB25rWxr60LqtMwD7MCAAlOPYeXn23Q2oFYB856BG2GWcrod7B61SBHrM5AUm5DEdr98bdtaU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSTWgAHmGLc0RCFh53vg7DRauTREPapfTAKQA6xjoa7hJmBKsB
	jAshiXvWDY3pFITKqAvxKT6MnMj7ennlpxMp5EaFy3f7hiP+Hs0TkCCa64i1LyBb5MsmvLB3WjU
	E+A4=
X-Google-Smtp-Source: AGHT+IHv+cXn9m/laACsPdEgrBDR/LFCDcV4pIEcBEj+OIERN6ak/zjEx44Jlc32BszsT0k2Ab+DDw==
X-Received: by 2002:a05:6e02:20e6:b0:3a3:67b1:3080 with SMTP id e9e14a558f8ab-3a6b0251396mr127343925ab.7.1730734988445;
        Mon, 04 Nov 2024 07:43:08 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a6a99cbc09sm23302735ab.41.2024.11.04.07.43.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2024 07:43:07 -0800 (PST)
Message-ID: <e003c787-71b5-4373-ac53-c98b6b260e04@kernel.dk>
Date: Mon, 4 Nov 2024 08:43:06 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [io-uring?] [usb?] WARNING in io_get_cqe_overflow (2)
To: Pavel Begunkov <asml.silence@gmail.com>,
 syzbot <syzbot+e333341d3d985e5173b2@syzkaller.appspotmail.com>,
 io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <6728b077.050a0220.35b515.01ba.GAE@google.com>
 <13da163a-d088-4b4d-8ad1-dbf609b03228@gmail.com>
 <b29d2635-d640-4b8e-ad43-1aa25c20d7c8@kernel.dk>
 <965a473d-596a-4cf4-8ec2-a8626c4c73f6@gmail.com>
 <16f43422-91aa-4c6d-b36c-3e9cb52b1ff2@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <16f43422-91aa-4c6d-b36c-3e9cb52b1ff2@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/4/24 8:34 AM, Pavel Begunkov wrote:
> On 11/4/24 15:27, Pavel Begunkov wrote:
>> On 11/4/24 15:08, Jens Axboe wrote:
>>> On 11/4/24 6:13 AM, Pavel Begunkov wrote:
>>>> On 11/4/24 11:31, syzbot wrote:
>>>>> syzbot has bisected this issue to:
>>>>>
>>>>> commit 3f1a546444738b21a8c312a4b49dc168b65c8706
>>>>> Author: Jens Axboe <axboe@kernel.dk>
>>>>> Date:   Sat Oct 26 01:27:39 2024 +0000
>>>>>
>>>>>       io_uring/rsrc: get rid of per-ring io_rsrc_node list
>>>>>
>>>>> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15aaa1f7980000
>>>>> start commit:   c88416ba074a Add linux-next specific files for 20241101
>>>>> git tree:       linux-next
>>>>> final oops:     https://syzkaller.appspot.com/x/report.txt?x=17aaa1f7980000
>>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=13aaa1f7980000
>>>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=704b6be2ac2f205f
>>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=e333341d3d985e5173b2
>>>>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16ec06a7980000
>>>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12c04740580000
>>>>>
>>>>> Reported-by: syzbot+e333341d3d985e5173b2@syzkaller.appspotmail.com
>>>>> Fixes: 3f1a54644473 ("io_uring/rsrc: get rid of per-ring io_rsrc_node list")
>>>>>
>>>>> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
>>>>
>>>> Previously all puts were done by requests, which in case of an exiting
>>>> ring were fallback'ed to normal tw. Now, the unregister path posts CQEs,
>>>> while the original task is still alive. Should be fine in general because
>>>> at this point there could be no requests posting in parallel and all
>>>> is synchronised, so it's a false positive, but we need to change the assert
>>>> or something else.
>>>
>>> Maybe something ala the below? Also changes these triggers to be
>>> _once(), no point spamming them.
>>>
>>> diff --git a/io_uring/io_uring.h b/io_uring/io_uring.h
>>> index 00409505bf07..7792ed91469b 100644
>>> --- a/io_uring/io_uring.h
>>> +++ b/io_uring/io_uring.h
>>> @@ -137,10 +137,11 @@ static inline void io_lockdep_assert_cq_locked(struct io_ring_ctx *ctx)
>>>            * Not from an SQE, as those cannot be submitted, but via
>>>            * updating tagged resources.
>>>            */
>>> -        if (ctx->submitter_task->flags & PF_EXITING)
>>> -            lockdep_assert(current_work());
>>> +        if (ctx->submitter_task->flags & PF_EXITING ||
>>> +            percpu_ref_is_dying(&ctx->refs))
>>
>> io_move_task_work_from_local() executes requests with a normal
>> task_work of a possible alive task, which which will the check.
>>
>> I was thinking to kill the extra step as it doesn't make sense,
>> git garbage digging shows the patch below, but I don't remember
>> if it has ever been tested.
>>
>>
>> commit 65560732da185c85f472e9c94e6b8ff147fc4b96
>> Author: Pavel Begunkov <asml.silence@gmail.com>
>> Date:   Fri Jun 7 13:13:06 2024 +0100
>>
>>      io_uring: skip normal tw with DEFER_TASKRUN
>>      DEFER_TASKRUN execution first falls back to normal task_work and only
>>      then, when the task is dying, to workers. It's cleaner to remove the
>>      middle step and use workers as the only fallback. It also detaches
>>      DEFER_TASKRUN and normal task_work handling from each other.
>>      Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> 
> Not sure what spacing got broken here.
> 
> Regardless, the rule with sth like that should be simpler,
> i.e. a ctx is getting killed => everything is run from fallback/kthread.

I like it, and now there's another reason to do it. Can you out the
patch?

-- 
Jens Axboe

