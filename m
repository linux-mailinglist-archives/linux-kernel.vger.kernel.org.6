Return-Path: <linux-kernel+bounces-574615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A462A6E7AF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 01:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8045175912
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 00:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43CB13632B;
	Tue, 25 Mar 2025 00:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4LmqwpgL"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628FA81732
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 00:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742863310; cv=none; b=PdpxAdd8CAh12CGMg7eIxSf2lqA+T23ZKK45ILi3ve0lkhhcGgYkCCkpIAfqxFtNP919TvtmI3CpwpwTOSI0MzMaOGcPxuRVKGbEAlCSTBWY3a+D8uv36TRfInh9M/K+hncl9uJoullIPxONzdzfvDq68w6IwR7CGceREAAeKuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742863310; c=relaxed/simple;
	bh=+0v8c88hHUKAdfPSvi/lO5oJpNO6isqOUB5e9pqIkFc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s/CaGd3zzfyzyl13xS2FDEmzAwlO2KMD018onY7LHd2lauVUD7XjkV6zxiiptC6tekOTs9jxR5ULFVq5aruKsX+uF+CLdGhSGccd3qZfvRxKUx6+zTK0nH/QmPIiEQ/Q/dU3OJa479mTqJpDjO6hErQHpIIb1j605WvI/aLKQtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4LmqwpgL; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2254e0b4b79so86621065ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 17:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742863308; x=1743468108; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OKlQB5zNndRwK6mdWsbl2eQsoyQxOuzVcxATD6Q6BK4=;
        b=4LmqwpgLN65N6SN0ykDj4vch1G+PKU+NjJ3BFCxcywkbHpXElh7z5Sq1I2YkuC0Tdq
         SHJ5Lq+OHBau0r/GLHjlJJBxhy+M+rAblCxlPoiukxOYHv7JXIfSEzScvp50I1m7eMoO
         XOqm6Utrf00h4bZPJSMFGy40Hj4EesUfI+wnRlVC6jb72SSO/rkwiLG+XFQpyPyGFstH
         wBAeMYiAmxAa1ouEqz1UsjZvkpuhmbfBpF8lfd7hDh2SDMouJM3TGA4mOGtqBdcAQT7d
         +ashw3oedJJZWyxd4hjRBLLsxqMLmCHD9eUPLZLENJzMJF6dBEw8Wk/tjpG2K0tJHN2N
         QtUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742863308; x=1743468108;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OKlQB5zNndRwK6mdWsbl2eQsoyQxOuzVcxATD6Q6BK4=;
        b=jKZkMgWh3kOKCKJZkrrcXBUejNhCx3nc9qkuqjQTTyALjHljn1ZllYa557CEqQkLB7
         DFzvKioQfgQBP2Uxs8Y9xilltS2vLiEPgGqEV1+R59JNTwoTTsZhl+HLDLwrKAyg8SyE
         LRcC/PwyucrLqXlLzJXUlv4Xa2mI1X6wgzB3+VNTE8PI60kcq/xP9bJuMOR5AndCF7WI
         P5RRGC3+gxxhBO7xyVWC2GQ9O6TdS76Zx4zXjHjFLXTF49IIRYjf0unk8B2NbtFcMDln
         aLuhIqA5gFhZuXb0ISW5cUZckI6nvESocO2D84lyr7IWlz47xu7LNuicnJoKbluQt7ii
         llrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWl9DamWaXRvHiAdsk8j+CqFqMX7G2XgukF56Sd/qELxrigEGhkfs6gYpZfo4CgPSXKTi0OgMLf2DCjBKM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUPF54l/njwB+FklERvrIKYfon7v7F/rr5DFG/ZJW8neICvViJ
	BUCOJ13FVW2SE08xru65FZGZuCLb8WQy+4bedJNeM+xEhRIjajNIdLAR6M/eLw==
X-Gm-Gg: ASbGncv1FguW2O0FM3hEHbe3Ryx/8MeABLSD544yubrLctvMCqH9gyIquL+ModcleaG
	7xAOt3dy8ljZ1ZTTYmqe2GBeIO1voPAS1+Vt2E/bD6rGRR9gLQQXWWP8t/6fxYoT46mWb7DW1jb
	g6benX3FclUZpHESPN7AMbewQ2uUR4W9mqrF6Xy5LimlsHZtbI6fauR3hF0cMx2ivN0BaB1jUpN
	YxCcUd7Rv7DkecREO6QmHGx8XeVnDk2m/9Dg1VEj/CuJJ1ZRpHI/BCfP7/1w9YCGbFOymr5ZIAG
	ttuTVR2xAgiquVVh46DBP0Z+Rn1bM3aGycWXojjr4nMV+ikVEOFlTKR+Df0o3pdvzC6B265ekxw
	fypSMx7LEmIK8kN0ztJk9KBVzdDlm2uiIdrY3akAEtbs=
X-Google-Smtp-Source: AGHT+IEOaESVFrfdqBBAazmbaqteJwqdlLgtXuT4kFsbGYynhTXz8pOmC0dsrgFQDK8O7M+xekb2pw==
X-Received: by 2002:a05:6a00:8d5:b0:736:73ad:365b with SMTP id d2e1a72fcca58-739059b681fmr21442643b3a.14.1742863308181;
        Mon, 24 Mar 2025 17:41:48 -0700 (PDT)
Received: from ynaffit-start.c.googlers.com (255.176.125.34.bc.googleusercontent.com. [34.125.176.255])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73905fd5f76sm8977409b3a.66.2025.03.24.17.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 17:41:47 -0700 (PDT)
From: "Tiffany Y. Yang" <ynaffit@google.com>
To: Carlos Llamas <cmllamas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,  Arve =?utf-8?B?SGo=?=
 =?utf-8?B?w7hubmV2w6Vn?=
 <arve@android.com>,  Todd Kjos <tkjos@android.com>,  Martijn Coenen
 <maco@android.com>,  Joel Fernandes <joel@joelfernandes.org>,  Christian
 Brauner <brauner@kernel.org>,  Suren Baghdasaryan <surenb@google.com>,
  linux-kernel@vger.kernel.org,  kernel-team@android.com
Subject: Re: [PATCH v2] binder: use buffer offsets in debug logs
In-Reply-To: <Z-Go6qOLxT0ZfxyD@google.com> (Carlos Llamas's message of "Mon,
	24 Mar 2025 18:48:10 +0000")
References: <20250324180716.1012478-3-ynaffit@google.com>
	<Z-Go6qOLxT0ZfxyD@google.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 25 Mar 2025 00:41:39 +0000
Message-ID: <dbx8v7ryym9o.fsf@ynaffit-start.c.googlers.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Carlos Llamas <cmllamas@google.com> writes:

> On Mon, Mar 24, 2025 at 06:07:18PM +0000, Tiffany Y. Yang wrote:
>> Identify buffer addresses using vma offsets instead of full user
>> addresses in debug logs.
>> 
>> Signed-off-by: Tiffany Y. Yang <ynaffit@google.com>
>> ---
>>  drivers/android/binder.c | 31 ++++++++++++++++---------------
>>  1 file changed, 16 insertions(+), 15 deletions(-)
>> 
>> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
>> index d1aa6d24450a..994ae205aa07 100644
>> --- a/drivers/android/binder.c
>> +++ b/drivers/android/binder.c
>> @@ -3261,20 +3261,20 @@ static void binder_transaction(struct binder_proc *proc,
>>  
>>  	if (reply)
>>  		binder_debug(BINDER_DEBUG_TRANSACTION,
>> -			     "%d:%d BC_REPLY %d -> %d:%d, data %016llx-%016llx size %lld-%lld-%lld\n",
>> +			     "%d:%d BC_REPLY %d -> %d:%d, buffer offset %lx-%lx size %lld-%lld-%lld\n",
>>  			     proc->pid, thread->pid, t->debug_id,
>>  			     target_proc->pid, target_thread->pid,
>> -			     (u64)tr->data.ptr.buffer,
>> -			     (u64)tr->data.ptr.offsets,
>> +			     (unsigned long)tr->data.ptr.buffer - proc->alloc.buffer,
>> +			     (unsigned long)tr->data.ptr.offsets - proc->alloc.buffer,
>
> These could be pointers to anywhere in user memory, not necessarily the
> alloc->buffer. So there will be cases where this substraction doesn't
> make sense. However, you are correct that we shouldn't log these addrs
> so maybe just don't? wdyt?
>

Ah, in that case I think it makes sense to remove them here. What
do you think about printing the full buffer and offsets values in cases
where we would print a binder_user_error or binder_transaction_error
instead. Ideally, I would try to limit this to cases when the data or
offsets ptr is invalid / copy would fail. Ostensibly this wouldn't
reveal dangerous information about the user address space because the
print statements would only happen when the data wasn't where it was
supposed to be and it would help with debugging, but I'm not sure if
this line of thought makes sense...

>>  			     (u64)tr->data_size, (u64)tr->offsets_size,
>>  			     (u64)extra_buffers_size);
>>  	else
>>  		binder_debug(BINDER_DEBUG_TRANSACTION,
>> -			     "%d:%d BC_TRANSACTION %d -> %d - node %d, data %016llx-%016llx size %lld-%lld-%lld\n",
>> +			     "%d:%d BC_TRANSACTION %d -> %d - node %d, buffer offset %lx-%lx size %lld-%lld-%lld\n",
>>  			     proc->pid, thread->pid, t->debug_id,
>>  			     target_proc->pid, target_node->debug_id,
>> -			     (u64)tr->data.ptr.buffer,
>> -			     (u64)tr->data.ptr.offsets,
>> +			     (unsigned long)tr->data.ptr.buffer - proc->alloc.buffer,
>> +			     (unsigned long)tr->data.ptr.offsets - proc->alloc.buffer,
> same here.
>
> Regards,

