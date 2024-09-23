Return-Path: <linux-kernel+bounces-336103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5FC97EF37
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 18:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFE731F2275D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 16:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425C819F11C;
	Mon, 23 Sep 2024 16:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DtSIjWok"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED25E823AC
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 16:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727108731; cv=none; b=PAutpO/KmYoSbSsfXOKQt/3ctQfW/2Mq6GpeDhMYBx0whqH/BqCStmQ4Lq7Hp6heY1zKwv+Ai6SWLjfAM+JgNF94LDTS0vQGdeNyqTGbnRTwzHGlNem+AXwm1lnWvppYKaNXP2hxTyjGUGAL7VZH5zfGUiDeuLmXKVJXxq+mIzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727108731; c=relaxed/simple;
	bh=olY2hPs32QD2v+cZL2tGQtXVYEeBu4CrdKB/xQwiXiU=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=jy8LhCXnhwI0IzRDRICFOWli0Lqudors+gvcGp2QYCfZX4X2neO5zO29rHccFGFFZpqW1UksJJhhbEx01qkrpDbwfi/dncqKfj3AKho7VslUiE/Pyoy7J5XbEbOVHfi4p09LeYK8jXE1NRTTlqSXzrKzhu6w/giknBwx/r7sips=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DtSIjWok; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2054e22ce3fso44585355ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 09:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727108729; x=1727713529; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cs0s5lrtFOwnGhivDPsfttQ2i9x0D/nLoLwB+B5aKyo=;
        b=DtSIjWokWFFntrLjc/ovsGuWaqtfFWGHb32gEsXjblzFjxDRMmGFlKeBIPgfXrWyvF
         E2MkrniXpISJTnc/HJdYbah3hDW6EJoaU8KnvhKo6EzNBHrkLJt5zPyxpSvJ+rM+62hd
         m7RB6xAlsCShqcgYU6pB+zlDz4GtX6weJzAagJZ5YeUHohxGIYwxrhr8A31eWOgEwBYs
         EJIR3Ra8u2sspeNrXx0GtrkHNa5m8nHsWvfCLZpEkkerLOwDPIRoVDiS8QX73QXsa2NA
         w/nvI7pJ3C10bJK8KYuqisHjVDtfXNAQjVa6bw5ufqAzEcr1xaocRM+0qwrynHzAaEAh
         cAgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727108729; x=1727713529;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cs0s5lrtFOwnGhivDPsfttQ2i9x0D/nLoLwB+B5aKyo=;
        b=npNjO7CordfM0EQGoOJmQk9VDVkp+Wc4NPn2WHgseBP5Pp4g8irX3yKZ5AygWkFXHN
         pfmnJ389M70AYmtkQb3QApipl9GL02a9aYLRyXn6Oq/wzCsfrcRt0EHXQwotjS2XrInB
         PHkBpNHT18sJJjrpQkBi7ctmJ9MeADuW0AiRzFLxq/gIIkYiAo78z3btAKBMKj0YiJ78
         FDipUoBxLnBmoao8g5GjAwcO4SASywWp/YFHsa3E1vJ41TM8qMCD16ZJmOziI3HBuK5R
         4AUFXm44Uokj9bkkxXaVNcpSoCkKmJiuYLAhhPZaoCCOYFNQ6bkCg78+AXKoOWo7P2Kv
         BsNw==
X-Forwarded-Encrypted: i=1; AJvYcCWQH2kzZOopQB5rQ448HylEQpEqOho/9Gv8pjVRIqr9u8HzMF3OoRGSOzQyU2CBKb9ExFjRuxVI8Ev1zqE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBoj9k72UKtsH7uoB7twHXA+EVa4XXPkdFFRLoFzJnUVWgFprx
	z/8vrzz8/F6EZ5MnzZK/p5pJ4THyiDfyRD/Uaq2UUjXwYbgPbhRc
X-Google-Smtp-Source: AGHT+IG194RwtFKLrFV8XrdTnD9yXTI7dBs/6NXUsJuSsxAF04dBBS2aoA62kOyUptOvs1Nz0gJEdA==
X-Received: by 2002:a17:902:db09:b0:206:9640:e747 with SMTP id d9443c01a7336-208d83f0524mr162174605ad.43.1727108728681;
        Mon, 23 Sep 2024 09:25:28 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20794730629sm134693745ad.247.2024.09.23.09.25.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2024 09:25:27 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Content-Type: multipart/mixed; boundary="------------HJ9g7cFWBslM8abIIeZKCOzx"
Message-ID: <26cd9e7f-3a78-4863-8e56-29c0454098e6@roeck-us.net>
Date: Mon, 23 Sep 2024 09:25:25 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] resource, kunit: add dependency on SPARSEMEM
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 Huang Ying <ying.huang@intel.com>
References: <20240922225041.603186-1-linux@roeck-us.net>
 <CAMuHMdWAuQcFQaQNy2EP_u9vk13g2C3sb3FFBCMAUPyGMgZ+hg@mail.gmail.com>
 <435dc218-f7ea-4697-b3ef-6a786e8d1b2c@roeck-us.net>
 <CAMuHMdVZWWj8aLvRfX4xH_x1v0gMg34jaX24bqB2Qc4Q75ZFhQ@mail.gmail.com>
 <2ece7321-f6e8-4d4b-8092-8ff7d3dc760f@roeck-us.net>
 <CAMuHMdVLLnaGKzKFTXST1qgTtJvYqDg109Yv6n4MJtu_ifvuoQ@mail.gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <CAMuHMdVLLnaGKzKFTXST1qgTtJvYqDg109Yv6n4MJtu_ifvuoQ@mail.gmail.com>

This is a multi-part message in MIME format.
--------------HJ9g7cFWBslM8abIIeZKCOzx
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/23/24 09:01, Geert Uytterhoeven wrote:
> Hi Günter.
> 
> On Mon, Sep 23, 2024 at 4:55 PM Guenter Roeck <linux@roeck-us.net> wrote:
>> On 9/23/24 06:47, Geert Uytterhoeven wrote:
>>> On Mon, Sep 23, 2024 at 3:39 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>>> Interesting that you get that to boot. The q800 machine crashes for me
>>>> when trying to boot it in qemu with the latest upstream kernel, in function
>>>> __pte_offset_map_lock(). It bisects to commit 394290cba966 ("mm: turn
>>>> USE_SPLIT_PTE_PTLOCKS / USE_SPLIT_PTE_PTLOCKS into Kconfig options").
>>>> Reverting that patch fixes the crash for me. I guess you are not seeing that ?
>>>
>>> I never used qemu -M q800.
>>> I have just verified that -M virt boots fine?
>>
>> Not for me :-(
>>
>> Run /sbin/init as init process
>> Unable to handle kernel NULL pointer dereference at virtual address 00000014
>> Oops: 00000000
>> PC: [<000ca784>] __pte_offset_map_lock+0x36/0x7e
>>
>> This is with virt_defconfig.
> 
> Before, I was using my current development tree, which has lots of
> local patches. So I retried with commit 394290cba966.
> Boots fine into Debian:
> 

Interesting. I have a lot of debug and kunit test options enabled. Turns out
I can boot cleanly with an unmodified virt_defconfig, but the crash is seen
if I enable the various debug and test options. I attached the defconfig
I used for reference.

Guenter

--------------HJ9g7cFWBslM8abIIeZKCOzx
Content-Type: application/gzip; name="defconfig.debug.gz"
Content-Disposition: attachment; filename="defconfig.debug.gz"
Content-Transfer-Encoding: base64

H4sICKKV8WYAA2RlZmNvbmZpZy5kZWJ1ZwCFVz2PHDcM7fMrDk4dwECcg1240EicHXn0daK0
t+tGVQo3CRAfAuTfh5rdu5U0XLvYQu9xJJJ6pLjSu1kfivFSmCNE1N59fvfbv9/+eXn3i7xw
eMajDvLzf69A0hbKmp1OJQGmGyEP0eeAN2Ay6xUcjQrKBdQODVrhDozKih04R4CvEHe4gqOW
sINlyELKxlcnLGAQEgZ36fuiKbTYOAenALH59qjbVYhelkVE9Sxic3AQMelE+SxCHYWTbbTC
6oO4WTREElFzhBWSgydURWlcjZjANNYUwalgnphP0Bs6A8vp4yO3I13rqQbCbWuU5T6psIIp
H5pDsuMsq5QeP3bMrw9XTvtNEmWanx6+fX/46++Xh+9/vrwFqt1sUwEzs8qDE0iWQAph04rR
mEoUTnl7j613CG67pzevNospyxUSMm4pYdv4tiXrx4U5CqXiCAYO3Cx/sBNlckYWZD9y0ApW
1HA6kmJ3Chex8oWtqTJdGNdl8j7tK7tuF6L2LCGNQNSqP/xTGNdbibVbVHjIAxyTDV0Srkix
Prs2XluePJ8XUi4LR03NsAQ+GxEOVoQLtUOnrE0T3mtLMd6HPRpFI8ZLyJVrBCpR96ti9MR6
9bonMqdjHDZh0ntpnLjzp5NOxqn+Oky7kFPNOQLtMeJwZEDO/+txtKIO1fTR5flatjunVbTd
osxTDRZsNqLvO5W87n8I+YbP0+69QNJOk0EcFjsnFq2K+JBALj1GjXPVrseov8V4HrBziIDY
g/B1hcFOJ+iBFRxqd0h+OCSCiuIwolbL6NHPaYC9SxDbs+h2++s+LVKXRaoeBRb1LIrJk0cw
qEhgD/RquJyB16ovsz6lHIctjHZrMeJMldp/bK3sFlQT5FgvtWuN7/U+CUPF6nb4ptz2xUkf
Stt9NuAm7IYROXnqSq2xRv/p8fF9h33xRrd19ZWMWj6rubMfut+l9QWP9PIL2bza1E1bu215
164gyBx1ahRxHyki0FNuffwBxb/Kr1bGCxXaMnljzqId+t5gFDOQKtoXpNlMrso/u2LQ/oQu
IKLhIjLUaqrhDyj+xYBZZJNu1krIdo6Q8RySpzHOUSXEOlyJycBFKdxcUccpktzsSx0r5z/a
mSVPV75rcRdk+gIy4R2YvDPz6HfL11HoHlen/nh352cf13tclLksINQ9noZrGs+p8+fajEYr
C6Si8zaTt116TvUutoGfmm9qNbiNJYLe1tYsCKfl/r6W7Kh0BK5bfJ4q/Pf3+31uVrttqovU
TWxONIPu0oMk7l5O16B48zqGjljgQDyMiPNJz7q7oZp3eMJxNt+kXyc0lxq/hmnmovHty615
vAn5QlySV6XEiJf9axiyrfnjuK3DbxM4+jjiDKT9sT6HbddJFA1/8JVawJDM+CFw23Qlw+RP
jYp0onwaNWaGHnG5YrYjvghc7oyLNFNEyc+SNLLLZFhqywhH1JPS1j7YTFtFDyPPUS3JcOZH
fOoO+kD/fko635l7Pb2Xs/HPd/JM/ypqkbLsTLeoZ/5k1GGfu/8BWYH/4JgQAAA=

--------------HJ9g7cFWBslM8abIIeZKCOzx--

