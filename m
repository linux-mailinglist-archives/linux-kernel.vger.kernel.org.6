Return-Path: <linux-kernel+bounces-329991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC2097983C
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 20:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 374D9281E5B
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 18:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC51F1C9DFB;
	Sun, 15 Sep 2024 18:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5HP4uRV"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFBA135A79
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 18:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726425878; cv=none; b=qjjUxYxhYb2R+JVLVqYn9H2fv5YrhDTmZY57xvm8389/5pSECgKAqM3Hi4kcgH1Coz9xxDhvGuhDUReTfKSrK0jyVDXw/Nq9pPd8T7onkya8KW+tjJSjd26rkAVJXe54KnCc79MkfiyW8VCotrXh81ac1/PhKJnYACWXIh1h3WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726425878; c=relaxed/simple;
	bh=cq4LifMhEybNxVRlKCV9j05G/X6giJWoliYjlTHamgY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ak/WJPeGAN5xTujmvUyOyPxazArY0tb2GdhTFrnEDYN7jNoCZ0Hpdiv5FESEhgGyqOtOCqDvM4F8EeuuOgpl9j/Ic+evPjcaHcYBiB5hQUlJY8+MC/NAfRpNPy6hOZSE52id077DxkcRyEzbFyVBVbMTadhSUrT1MFO/vDB9Vno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C5HP4uRV; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c26815e174so3426346a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 11:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726425874; x=1727030674; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ne7DfzRXmU3yWyMQPlVFvvskbZ8VOwFgJBJbqcnfEmg=;
        b=C5HP4uRV8OxXqU+mloQK837kwEbXrfPGDe4XfyvP7y/ABE2G8GCRFZzJwPgk550ZxF
         sBqF45AIoShaleFsqh5RQx+UHZt0w3PWT33bWhXItELKWJUU0iccz+kSqdx42uydUOrw
         I51tgmXcJ2b2dRv6k7IjoQK7sLgf/IzU4MUDHg6xFDdugURnnoIuMi0DmyqACXNT1j/E
         kMtjKSui4NZ1O0DEbYPZPavX58TmoyyXZ/CNbdNRXaTZvSJ012YMiyLMeLAliz5l+bQN
         bLfihjBIoZrb4+zto5OuYI95RpyNSrX3Nbwng+CFk/lAh1hcbQIxdIYznZwuHN9ekJh1
         KtLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726425874; x=1727030674;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ne7DfzRXmU3yWyMQPlVFvvskbZ8VOwFgJBJbqcnfEmg=;
        b=YZ9eomLFEDd2mxTP/1SHgWKW/m9Avrtix9X/rW28d5SEapdL8yavU8L+nwXfUL0vZG
         jISMTVXBDftC5CMeVq0Y/wy791ZRlWEeHlggReiW0xISvvId8pdLwDewFNmYOQKXdVjo
         aiyit0Epk1OAo+Xw47OW0ghMOsiI40xcjxYJW5K/8njp4Sp02BVG1PfreE2uHkNWBDW5
         OuUBbGFY1S/M28DpP7WL3OrG88oh8nWSpOgMPb22CSOnnnDO6pIsIZhaNB6EAQrJubSl
         q/auAivgzqeJPmBDnk8LLExUBrmfiW/AJ0G3mMBGFBxYPM50Nlw5vLIFhwZdi64p+4js
         IWGw==
X-Gm-Message-State: AOJu0YwAgO7bOtUY/Ffgz0Ho2lhqjn3Mc8/g76foWrW24O5iopuNJPOT
	66IH2Al+c5SyOGsEklKzUF3vKOisUY3QUEJPXQkSlE+N1kkFht8x
X-Google-Smtp-Source: AGHT+IE7w+P9iFqL8g1TrQqAPwiWUUwLjenoiovibKzlW/ngkRn5BhBdwFIxc8vL6VXxS6OZTQOVwg==
X-Received: by 2002:a05:6402:278b:b0:5c2:6d16:ad5e with SMTP id 4fb4d7f45d1cf-5c41e1906e8mr8279595a12.19.1726425873546;
        Sun, 15 Sep 2024 11:44:33 -0700 (PDT)
Received: from [192.168.1.100] ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bb89d44sm1870453a12.70.2024.09.15.11.44.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Sep 2024 11:44:32 -0700 (PDT)
Message-ID: <fd0e5627-b89c-d25b-bbf5-edc712642f85@gmail.com>
Date: Sun, 15 Sep 2024 20:44:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 3/4] locking/osq_lock: From x_osq_lock/unlock to
 numa-aware lock/unlock.
Content-Language: en-US
To: yongli-oc <yongli-oc@zhaoxin.com>, peterz@infradead.org,
 mingo@redhat.com, will@kernel.org, longman@redhat.com, boqun.feng@gmail.com
Cc: linux-kernel@vger.kernel.org, yongli@zhaoxin.com, louisqi@zhaoxin.com,
 cobechen@zhaoxin.com, jiangbowang@zhaoxin.com
References: <20240914085327.32912-1-yongli-oc@zhaoxin.com>
 <20240914085327.32912-4-yongli-oc@zhaoxin.com>
From: Uros Bizjak <ubizjak@gmail.com>
In-Reply-To: <20240914085327.32912-4-yongli-oc@zhaoxin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 14. 09. 24 10:53, yongli-oc wrote:
> According to the contention level, switches from x_osq_lock to
> numa-aware osq_lock.
> The numa-aware lock is a two level osq_lock.
> The Makefile for dynamic numa-aware osq lock.
> 
> Signed-off-by: yongli-oc <yongli-oc@zhaoxin.com>
> ---
>   kernel/locking/Makefile      |   1 +
>   kernel/locking/numa.h        |  98 ++++++++
>   kernel/locking/numa_osq.h    |  32 +++
>   kernel/locking/x_osq_lock.c  | 332 +++++++++++++++++++++++++++
>   kernel/locking/zx_numa_osq.c | 433 +++++++++++++++++++++++++++++++++++
>   5 files changed, 896 insertions(+)
>   create mode 100644 kernel/locking/numa.h
>   create mode 100644 kernel/locking/numa_osq.h
>   create mode 100644 kernel/locking/x_osq_lock.c
>   create mode 100644 kernel/locking/zx_numa_osq.c

...

> +	if (lock->numa_enable == OSQLOCKSTOPPING && old == OSQ_UNLOCKED_VAL)
> +		old = OSQ_LOCKED_VAL;
> +
> +	for (;;) {
> +		if (READ_ONCE(lock->tail16) == curr &&
> +		    cmpxchg(&lock->tail16, curr, old) == curr) {

I would like to ask if there is any benefit to read the location two 
times? cmpxchg() reads the location and skips the update when curr is 
different from the value at the location by itself. Using try_cmpxchg() 
can produce even more optimized code, since on x86 arch CMPXCHG also 
sets ZF flag when operand 2 is equal to the value at location (and 
update happens), and this flag can be used in a conditional jump.

The above condition could read:

if (try_cmpxchg(&lock->tail16, &curr, old)) {

with an optional temporary variable instead of curr, because 
try_cmpxchg() updates its second argument:

+	for (;;) {
+		u16 tmp = curr;
+		if (try_cmpxchg(&lock->tail16, &tmp, old)) {

Please note that the above form could produce slightly more optimized 
code also on non-x86 targets.

Uros.

