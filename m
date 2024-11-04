Return-Path: <linux-kernel+bounces-395105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 508659BB89C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 16:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4C29B2378C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 15:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A991BDABE;
	Mon,  4 Nov 2024 15:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="aTFlEPDO"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612BF1BD018
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 15:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730732911; cv=none; b=IBcs2nE6YKfA9O9jEDeMWROnrVD66L0hKBxx5x9VYEGbUC9VyE+lToU4iwiKAlUkKbwd0baiU1bc+wLaR0aYod4yJsfjNDCbPYxFCozg0A8M1QLiLazEUNvgomIZrEfkYK9SKQcCaj+ZqSvqZCGlbBRIhXwBtGjtkC2fSx5GkLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730732911; c=relaxed/simple;
	bh=0okJolI+3u+H6AyLn0dUVhA+PvbYVJC2JYACRMFf7K4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VPhvZOkH+3kvr6Hb1wvytpjoZayj4vZQPmyFRqjxdonZmLD9WYFFwNlcqykTsD3xCyhdlPr52pRd7Ki2fTllioErCdh8cwS/rmTWlTwZMmN3e1+q1CtrCGH7thJkjOCAlqN/tiRKaC02xJYY6TMgQz31g4n3oKC/9hgdONi0JAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=aTFlEPDO; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-83ab5b4b048so203759639f.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 07:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1730732907; x=1731337707; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R5hbyR4HgcG/h6N+KF/CfSJlYRWEx4uL0iA5dLnxVNk=;
        b=aTFlEPDO+PPabydDMSTmrJLsto9ZIcUXYUYQZiL4N4N+Xz4/0qvY2YXx/FQVNIKwMY
         E++uD4EEBfho0HkDquSs/5jNBIPGwLQHwyF2a60Wskl6aZ1nErW9KAY5e7m+NUcK70qM
         NwWp3rSFmcePBrGqMRUQjtrEGst4gCRiheXYE7xNr97uuIQGxWs0FPL7LiiIEGGXtRxI
         jyf0VcMuKj5FmnYbf8OCevsngMzCwLyQ6OabQSzG8rG+lze/GevFcKuERIF/n+0KWEZa
         xcu8AgrvL/wTC5v90oBpjChs/h/wIjTHThWL0z1Va/N5UtkIz/eBr6srqrogjDJG6cVO
         DcNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730732907; x=1731337707;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R5hbyR4HgcG/h6N+KF/CfSJlYRWEx4uL0iA5dLnxVNk=;
        b=CpFewQbhxchoDThahQOaYMWhy9i2V9IbAo5E1aIVfwOpK6hp5IDBCRMbxA9HBMXbtV
         5XRQg83bLmETr7Ti+ooFhew8M3qvz2b01XTNwgMQ7VlwCS0+RWIrasYAtSlbcwj331sT
         eYnkdOcr2gGKlqinN6TPUvlVWvtEmy3/x3WenuB13yd1ipzkTFDVCLcOBjZThm+c+Maq
         8V68JIRuMW2R71eS3z9TixOic2tuOVXYQGqfWLWBWfh9Wj+JT3zA0VL0JejmQJeLWpdj
         lebqnm+VL8RtxuDcJNR+zd3njcYCppyvD7pl3k/r/GiYWUGHfJvHBoV60WVJl3YW8Tun
         MQqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSfuAgekmnFulLC5E5sCxrjMcABFi+g8upGErFN8Dyo02bCzemFc25Q/9hubcaOL+NubGySfkYtuj3bY8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz89PtpsT22t6OXmlpxQny/L1APHc8PEcIyVhsnir+dSqeQSzTI
	iKn0NeWinkFV63s0sBku9LzEv/xl5thynGG+d/ss8KuxjQrQUQRD0xaSDI9Nk7w=
X-Google-Smtp-Source: AGHT+IE1M40BFmOXwjOwOEtq4B8wpMssMFuDDE7DRCvyikF5mFcU9Yjz9UpHrLMo9U43l+nSetxOLQ==
X-Received: by 2002:a05:6602:2cd0:b0:83a:7a19:1de0 with SMTP id ca18e2360f4ac-83b1c5cd847mr3851257039f.14.1730732907001;
        Mon, 04 Nov 2024 07:08:27 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-83b67b2b669sm217599539f.19.2024.11.04.07.08.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2024 07:08:26 -0800 (PST)
Message-ID: <b29d2635-d640-4b8e-ad43-1aa25c20d7c8@kernel.dk>
Date: Mon, 4 Nov 2024 08:08:24 -0700
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
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <13da163a-d088-4b4d-8ad1-dbf609b03228@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/4/24 6:13 AM, Pavel Begunkov wrote:
> On 11/4/24 11:31, syzbot wrote:
>> syzbot has bisected this issue to:
>>
>> commit 3f1a546444738b21a8c312a4b49dc168b65c8706
>> Author: Jens Axboe <axboe@kernel.dk>
>> Date:   Sat Oct 26 01:27:39 2024 +0000
>>
>>      io_uring/rsrc: get rid of per-ring io_rsrc_node list
>>
>> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15aaa1f7980000
>> start commit:   c88416ba074a Add linux-next specific files for 20241101
>> git tree:       linux-next
>> final oops:     https://syzkaller.appspot.com/x/report.txt?x=17aaa1f7980000
>> console output: https://syzkaller.appspot.com/x/log.txt?x=13aaa1f7980000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=704b6be2ac2f205f
>> dashboard link: https://syzkaller.appspot.com/bug?extid=e333341d3d985e5173b2
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16ec06a7980000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12c04740580000
>>
>> Reported-by: syzbot+e333341d3d985e5173b2@syzkaller.appspotmail.com
>> Fixes: 3f1a54644473 ("io_uring/rsrc: get rid of per-ring io_rsrc_node list")
>>
>> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> 
> Previously all puts were done by requests, which in case of an exiting
> ring were fallback'ed to normal tw. Now, the unregister path posts CQEs,
> while the original task is still alive. Should be fine in general because
> at this point there could be no requests posting in parallel and all
> is synchronised, so it's a false positive, but we need to change the assert
> or something else.

Maybe something ala the below? Also changes these triggers to be
_once(), no point spamming them.

diff --git a/io_uring/io_uring.h b/io_uring/io_uring.h
index 00409505bf07..7792ed91469b 100644
--- a/io_uring/io_uring.h
+++ b/io_uring/io_uring.h
@@ -137,10 +137,11 @@ static inline void io_lockdep_assert_cq_locked(struct io_ring_ctx *ctx)
 		 * Not from an SQE, as those cannot be submitted, but via
 		 * updating tagged resources.
 		 */
-		if (ctx->submitter_task->flags & PF_EXITING)
-			lockdep_assert(current_work());
+		if (ctx->submitter_task->flags & PF_EXITING ||
+		    percpu_ref_is_dying(&ctx->refs))
+			lockdep_assert_once(current_work());
 		else
-			lockdep_assert(current == ctx->submitter_task);
+			lockdep_assert_once(current == ctx->submitter_task);
 	}
 #endif
 }

-- 
Jens Axboe

