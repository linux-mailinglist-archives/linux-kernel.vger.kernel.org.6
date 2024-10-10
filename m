Return-Path: <linux-kernel+bounces-360198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77AC89995C8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 01:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AED61F23FAC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 23:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D0E1E6DC9;
	Thu, 10 Oct 2024 23:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U4KV2+bi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5D01E3DE0
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 23:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728603546; cv=none; b=GCXQc+d25PjJWRmjJA545dz8K1K9GyrxObzD3Okv7OKwdGMupXf13xqUSPNULUTyjxEner3aoRLczUg3qzUgq0S6Fa99ET6lx1/k11YILDj8wsvsYPHTeiUJFq+6wHsmoOOEadFmySGSwo5Iy/1Jep43/tUA3ZVxPrOugAShABU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728603546; c=relaxed/simple;
	bh=hLJ/nuu+e/kYftnMp0Xu8vELVP9UiW+uc+RJveAYGHg=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=WAfB81AGDl5O5EHHXGWrue1E1hauziJnx/Hza+6zY40FmQ/sg0z0Iud9AzAoqup1IzFvBIguUVj6emD9XcTU/qDDAQsLiNsU693zHOYq4AuK0/BIMDswOqglrdTK25iCXWI6PbT9nzMP/xjFJsQJYx73viqzRI/ipDF2d8aYnOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U4KV2+bi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728603543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hq4tIVYIrFf+uv60bjHeN5mVGBheuCaoP2yaOubwHck=;
	b=U4KV2+bioooCzbPwMjdYu0fvj20IYF6Zm1eXXs7QSRTMbriKLl30T1HfwCNWGVFbAFLudw
	54YWX1ujFpFa3hOm50ftINBv7ZY1zGfoqxFyWIZ/AmjNGGoYETtU66ocpVvt4CJoKiKe78
	Oyz/53Y+P06VizjqOH/5j/1QsShBB+s=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-YDRNTYUcNyibxuihowq6Ow-1; Thu, 10 Oct 2024 19:38:59 -0400
X-MC-Unique: YDRNTYUcNyibxuihowq6Ow-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6c58e9bf10bso28170586d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 16:38:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728603539; x=1729208339;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hq4tIVYIrFf+uv60bjHeN5mVGBheuCaoP2yaOubwHck=;
        b=KGZycikEYJPC80n528MTJR3Hdr1n6F64aDfyVNmtI+UqmFpb7YZ63V7dLM3XepXFQr
         oU7iQ2+WLrMZtZeGEbscqzy+tPfEHXMkE8O4aEFKqXhoIPwzncsrR/F3J3uGEM9SmQdm
         ErlUPWNVbcCkIuNQ8jWTAEYbGOEtNJLl9z8mQPynQbiED5WbEaVohqAu4QclmZRFp4Fe
         1PEb3VqtZA3Edhap+JUYPTIms1Ntv53/X8/+ZHXdT+kB6rpcfIIQHBzWxWP0SrsZh6Ox
         e70e3CrDvuwnUpWSAoHTX9fEnYkYJcKRayHJCpD1qm2SlQsxYS/IEbDA4Yp4WduKCaKV
         YqpA==
X-Forwarded-Encrypted: i=1; AJvYcCUM+GtW//TVrqok7VB/2/E7p+K1T1D5tmNSh0vOTZ/wLcN2zGzulrx/uigr5P68hJ45TT7o9zZs8+wtCbo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOOrY0f7GVyXPsh9jXlrLiExBhkvDZSebvCjmPHzlPLEs2Uyem
	n4dKfqZC5I+ZZGYrDbzjzl/5WjUPL7QhOcoIFzPJkz0CRcgX7bqRsvU8OiuohKtRAF6KYLl4bht
	WYa1W1KYu0rGSicqQnZO5Iy5V5lCXbsqdR26L5OGOigYral6PswLaSbmZ4Miomg==
X-Received: by 2002:a05:6214:4b04:b0:6cb:eea5:69e0 with SMTP id 6a1803df08f44-6cbeff63b34mr15649326d6.27.1728603538914;
        Thu, 10 Oct 2024 16:38:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZpZWpZap2tQ+Z51Yq7nYooWi4T1Z8Lu6q+/zGL84YO5WhCID5pVpVkBBgi64YaE6i39Q1Lg==
X-Received: by 2002:a05:6214:4b04:b0:6cb:eea5:69e0 with SMTP id 6a1803df08f44-6cbeff63b34mr15649016d6.27.1728603538541;
        Thu, 10 Oct 2024 16:38:58 -0700 (PDT)
Received: from ?IPV6:2601:188:ca00:a00:f844:fad5:7984:7bd7? ([2601:188:ca00:a00:f844:fad5:7984:7bd7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cbe85d8591sm10213546d6.69.2024.10.10.16.38.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 16:38:58 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <35b3889b-904a-4d26-981f-c8aa1557a7c7@redhat.com>
Date: Thu, 10 Oct 2024 19:38:57 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] sched_ext: Don't hold scx_tasks_lock for too long
To: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>
Cc: kernel-team@meta.com, linux-kernel@vger.kernel.org, sched-ext@meta.com
References: <20241009214411.681233-1-tj@kernel.org>
 <20241009214411.681233-7-tj@kernel.org> <20241010191237.GF28209@maniforge>
 <ZwhJZaXC2xKQlD3D@slm.duckdns.org>
Content-Language: en-US
In-Reply-To: <ZwhJZaXC2xKQlD3D@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/10/24 5:38 PM, Tejun Heo wrote:
> Hello,
>
> On Thu, Oct 10, 2024 at 02:12:37PM -0500, David Vernet wrote:
> ...
>>>   static struct task_struct *scx_task_iter_next(struct scx_task_iter *iter)
>>>   {
>>>   	struct list_head *cursor = &iter->cursor.tasks_node;
>>>   	struct sched_ext_entity *pos;
>>>   
>>> -	lockdep_assert_held(&scx_tasks_lock);
>>> +	if (!(++iter->cnt % SCX_OPS_TASK_ITER_BATCH)) {
>>> +		scx_task_iter_unlock(iter);
>>> +		cpu_relax();
>> Could you explain why we need this cpu_relax()? I thought it was only
>> necessary for busy-wait loops.
> I don't think we need them with the current queued spinlock implementation
> but back when the spinlocks were dumb, just unlocking and relocking could
> still starve out others.
>
> cc'ing Waiman who should know a lot better than me. Waiman, what's the
> current state? When releasing a spinlock to give others a chance, can we
> just do unlock/lock or is cpu_relax() still useful in some cases?

I agree with David that cpu_relax() isn't needed here. Queued spinlock 
is a fair lock. If there is a pending waiter, the current task will have 
to wait in the wait queue even if it attempts to acquire the lock again 
immediately  after an unlock.

A cpu_relax() is only useful in a spin loop in order to reduce the 
frequency of pounding the same cacheline again and again.

Cheers,
Longman


