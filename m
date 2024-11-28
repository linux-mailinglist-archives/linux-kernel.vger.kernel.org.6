Return-Path: <linux-kernel+bounces-424175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BFF59DB149
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 02:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0531163170
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 01:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC3D38FA6;
	Thu, 28 Nov 2024 01:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A/ycsrXY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2F88467
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 01:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732758935; cv=none; b=rO2cHwqo2ykQIcE6vM2k/gd9zvxlnbcGLyhdpXXY2WTqC7oY1qp7hyPSygp3izSGU+X3RDAXJDDBK5dG+da0ebW4DV0n2ZxpOFJwjAeaMBObakbrM1TIsnLG8/qdKpPTaFRHVq6VLtfYsd/uGazUl41Rb7YX7hCP9tY0uELTZOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732758935; c=relaxed/simple;
	bh=+lMbtx1tFi7sfzPnTRMaKCnwCdvjvH9av+TEvheS3wk=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=PK0Ud/zxno0EP/RnlZg4AzlZHyowfU81MEr75Y7wHVUOlZZ20r8LrWGxdG4I7+bw1qWIu3/FN0s9OF3S8rmJNLAQD7Ba3+jXgLyjwXK4dxjE/lnBHf/eSs53AGYdyEjDLVXIC31+3Y+cKiZqx/O26i0+UfP3Z+1QwjhawlAIF0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A/ycsrXY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732758928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pt1xoTsh4Jb2fg+vNFVLxj4Xr1q9iTUZq5l4MXLHBNI=;
	b=A/ycsrXYOV+Y1tYOelF1jMGZGxl3dPdxskAhXfIW9U1dRzjCe1jWBxJss+p89DZpB8lOzX
	EvKhCMqBvu1gEuyywGDRapRr2brOZSZBsjuYFBdn/OWoiotsDEuJK6I5Pb76L77qyLVaKw
	AjVpLMginVLeylXj1/A9p+ytNCFwHoE=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-DHV4vAJgMfy26lE3f_QN1A-1; Wed, 27 Nov 2024 20:55:26 -0500
X-MC-Unique: DHV4vAJgMfy26lE3f_QN1A-1
X-Mimecast-MFC-AGG-ID: DHV4vAJgMfy26lE3f_QN1A
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7b66f8fb697so47187785a.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 17:55:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732758924; x=1733363724;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pt1xoTsh4Jb2fg+vNFVLxj4Xr1q9iTUZq5l4MXLHBNI=;
        b=S9F4iNfLjYTCrFyGs0i6pqHzWWnB8p3eA8ccQFLp7DGutCaWEs8k8z1C+cpbqIcrJ4
         RZeDYhjKgQcKT7tDZai/4uP2MNwsj0Jp24Q5QHxFRzELFBDEVPailDMycAqSHO+h4K+y
         5bz57ZMeM82Rhnrt2PO5JnTsPBvb6+JhMPPAy15tI8dDw/RQMSai/3yuYRHZom0ydsJx
         KjrYn13ip7kJsQycqSbwiXAuKm+UMhzLZDVeL1O+nAZcLhVh0kCA02p2y2w39P5Qi7nh
         wNVYxPn7lJHAAfBonZSoAgdQzECxUTvZrjK2qYOYvB0bbBEdpz3AjrPOjeSeFGEEwu0y
         D/jA==
X-Forwarded-Encrypted: i=1; AJvYcCV3wZCXecDdk4guR6u18mwMYGtWb5k+0MjRJ281+PCqq7E14deT2GphzgUlwA4Luauv5kBYzjek8uqH7YQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5IUVtpaEoU+htsQmqnnmD/cH93iiQHTe3kh9fZFSqo2hoGkiq
	+pgwDOl2fshXWbRgyGhXUF5a1NJnfXaI/CfbxKxBUXEvEMDE6PUozLhro8aDbDCtplJlkeVrpxV
	zeqKfDxEJN3mqlf49p62AQ2tNwfj2S+OMceoRwZQWzaf/p2wCR6WzBOkUpyLLDITdf1QfXQ==
X-Gm-Gg: ASbGncua8HuTq3N7xBN/vS6RCpXa0IBxNDNxY8yOGFWRggRcPSpj9R29wkMKMt5MjNs
	q+KBGseYxGSZU5kSUDaNswT7JYOY9IuNe68yzAUOh1ZkkyBMGYdVwoVIonuFJqgfGQSYSpF40Cf
	6QsgwLtElnu6Kd1XmIuxTxzDjEelt1HPyNYlnh1UTv1sYZ9vuXWOeLJSL7ZCBKVA6o8hKw0upcI
	Q6u/NqlwHPbCsxfzwxXHyAS2eKZCJ30llZRff2Ew1gKR+KlMAAQF0MJPAz9LW+r+8HBg7qzayk7
	2Pv3jGCXPi+wJhDBc/WE
X-Received: by 2002:a05:620a:178d:b0:7b6:7653:ee07 with SMTP id af79cd13be357-7b67c2ceca3mr707435085a.30.1732758924613;
        Wed, 27 Nov 2024 17:55:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFx2LUdpqc02lSn2Y8MLvZ4OqE1eHnalk/fgIqtR9eVAjWVi6pHvscP1L3unwF4laM4geXhUw==
X-Received: by 2002:a05:620a:178d:b0:7b6:7653:ee07 with SMTP id af79cd13be357-7b67c2ceca3mr707432685a.30.1732758924240;
        Wed, 27 Nov 2024 17:55:24 -0800 (PST)
Received: from ?IPV6:2601:408:c180:2530:d041:4c25:86b8:e76a? ([2601:408:c180:2530:d041:4c25:86b8:e76a])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6849aad39sm16655585a.80.2024.11.27.17.55.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2024 17:55:23 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <f6667d73-231c-481a-9b55-b75ea845421e@redhat.com>
Date: Wed, 27 Nov 2024 20:55:22 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sparc/pci: Make pci_poke_lock a raw_spinlock_t.
To: Guenter Roeck <linux@roeck-us.net>, Waiman Long <llong@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Andreas Larsson <andreas@gaisler.com>, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
 "David S. Miller" <davem@davemloft.net>
References: <20241125181231.XpOsxxHx@linutronix.de>
 <72991b83-173e-492e-a4aa-5049304c1bd0@roeck-us.net>
 <5d269249-afd1-44f5-8faf-9ac11d9a3beb@redhat.com>
 <dea92bd5-65e5-4c5c-bc93-5bef547c935e@roeck-us.net>
 <2a940822-b4d4-43ea-b4f7-4294043b76ea@roeck-us.net>
 <88f47cea-baba-4673-9bd7-7b7c3f421008@redhat.com>
 <20241126112000.UkTwR0Iv@linutronix.de>
 <48b9d642-9739-4333-b4b9-319df8a85e2d@redhat.com>
 <b698d599-ef4e-4966-92fb-1f84d7a0df75@gaisler.com>
 <4eb7bb8e-c2aa-4ce5-9f15-3086fccf4e46@roeck-us.net>
 <20241127165356.hnkqmgcc@linutronix.de>
 <bf7bd668-974f-481d-9526-94964455a250@roeck-us.net>
 <c029c2fd-8bac-4913-b98f-f09acd7d28e1@redhat.com>
 <93c5b695-4c98-4b3d-99d7-592d949750be@roeck-us.net>
 <6279e38a-9a3c-46ba-9161-5bc61f62d6d2@redhat.com>
 <b59961b6-2026-4f7a-8b72-9b94adfff310@roeck-us.net>
Content-Language: en-US
In-Reply-To: <b59961b6-2026-4f7a-8b72-9b94adfff310@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/27/24 8:17 PM, Guenter Roeck wrote:
> On 11/27/24 16:31, Waiman Long wrote:
>>
>> On 11/27/24 7:08 PM, Guenter Roeck wrote:
>>> On 11/27/24 15:47, Waiman Long wrote:
>>>> On 11/27/24 12:44 PM, Guenter Roeck wrote:
>>>>> On 11/27/24 08:53, Sebastian Andrzej Siewior wrote:
>>>>>> On 2024-11-27 08:02:50 [-0800], Guenter Roeck wrote:
>>>>>>> On 11/27/24 07:39, Andreas Larsson wrote:
>>>>>>>> Even though this is for sparc64, there is work being done 
>>>>>>>> looking into
>>>>>>>> enabling RT for sparc32. If the amount of fixes needed to keep
>>>>>>>> PROVE_RAW_LOCK_NESTING enabled is quite small at the moment I'd 
>>>>>>>> rather
>>>>>>>> see it enabled for sparc rather than risking it becoming worse 
>>>>>>>> in the
>>>>>>>> future.
>>>>>>
>>>>>> Okay. So you seem to be in favour of fixing the sparc64 splats 
>>>>>> Guenter
>>>>>> reported?
>>>>>>
>>>>>>>> I don't know what the situation is for other architectures that 
>>>>>>>> does not
>>>>>>>> support RT.
>>>>>>>>
>>>>>>>
>>>>>>> For my part I still don't understand why PROVE_RAW_LOCK_NESTING 
>>>>>>> is no longer
>>>>>>> a configurable option, or in other words why it is mandated even 
>>>>>>> for architectures
>>>>>>> not supporting RT. To me this means that I'll either have to 
>>>>>>> disable PROVE_LOCKING
>>>>>>> for sparc or live with endless warning backtraces. The latter 
>>>>>>> obscures real
>>>>>>> problems, so it is a no-go.
>>>>>>
>>>>>> It is documented in Documentation/locking/locktypes.rst how the 
>>>>>> locks
>>>>>> should nest. It is just nobody enabled it on sparc64 and tested. The
>>>>>> option was meant temporary until the big read blocks are cleared.
>>>>>>
>>>>>
>>>>> That doesn't explain why PROVE_RAW_LOCK_NESTING is now mandatory if
>>>>> PROVE_LOCKING is enabled, even on architectures where is was not 
>>>>> tested.
>>>>> I am all for testing, but that doesn't include making it mandatory
>>>>> even where it is known to fail. Enabling it by default, sure, no 
>>>>> problem.
>>>>> Dropping the option entirely after it is proven to no longer needed,
>>>>> also no problem. But force-enabling it even where untested or, worse,
>>>>> known to fail, is two steps too far.
>>>>
>>>> The main reason for enforcing PROVE_RAW_LOCK_NESTING with 
>>>> PROVE_LOCKING is due to the fact that PREEMPT_RT kernel is much 
>>>> less tested than the non-RT kernel. I do agree that we shouldn't 
>>>> force this on arches that don't support PREEMPT_RT. However, once 
>>>> an arch decides to support PREEMPT_RT, they have to fix all these 
>>>> raw_spinlock nesting problems.
>>>>
>>>
>>> config PROVE_RAW_LOCK_NESTING
>>> -       bool
>>> +       bool "Enable raw_spinlock - spinlock nesting checks" if 
>>> ARCH_SUPPORTS_RT=n
>>>         depends on PROVE_LOCKING
>>> -       default y
>>> +       default y if ARCH_SUPPORTS_RT
>>>
>>> would have accomplished that while at the same time making it optional
>>> for non-RT architectures.
>>
>> I had actually thought about doing exactly that, but decide to keep 
>> the current mode for forcing  PROVE_RAW_LOCK_NESTING for arches that 
>> support PREEMPT_RT. I won't mind doing this alternative if others agree.
>>
>
> Forcing PROVE_RAW_LOCK_NESTING for arches that support PREEMPT_RT is 
> exactly
> what the above does.
>
>     bool "Enable raw_spinlock - spinlock nesting checks" if 
> ARCH_SUPPORTS_RT=n
>
> makes the flag visible (only) if ARCH_SUPPORTS_RT=n, and
>
>     default y if ARCH_SUPPORTS_RT
>
> (force-)enables it if ARCH_SUPPORTS_RT=y.

OK, I missed the "if" part after the string. Yes, that do force 
PREEMPT_RT supporting arches to set PROVE_RAW_LOCK_NESTING while 
enabling arches that do not support PREEMPT_RT to optionally set it. I 
will post a v2 patch with that change.

Thanks,
Longman


