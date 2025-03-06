Return-Path: <linux-kernel+bounces-548167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB5EA5410D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 04:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4707D7A31AE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 03:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CFF1192D86;
	Thu,  6 Mar 2025 03:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CN4puNBf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4272A18DB3C
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 03:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741230622; cv=none; b=oHAE6h2DisB5xzGfKyUBoI5yBHhUWzUwlyffoFUERD6IHyby+reieECTXLiB5WWYF4bpQrQNKygIfziDcCiyGYnNicNfO68xZIG+PToBRjRTPXXBjpS5sR4rLcJpysXK+VXiol5ZSuAk23d21nXCG01/arUmOQ3RACygdMiTyW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741230622; c=relaxed/simple;
	bh=IQ7y2QmrjzWsFAq8lK26tRoKlk/0Lc6KsgxiAzpDYHA=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=goAyiDmVCnADNBHvRnIE7UowE6e72gqtAc0UBy1lXoP1I8D9s6x05b1agdBBWsXS090WLAuGOQ7KKRZYkjKJyeKUySkrDU6PBqASobGaynQM8baAj1To1v9V6GUeQiNhaq8gIwPDfdJUktYO6Oncq3zcP1thlFiFyUHzZdHtHJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CN4puNBf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741230619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7l5kkkm2A6O8p7efBFndsWQIHjztP61j8KYSJ+fyXVs=;
	b=CN4puNBfd11V81h5D+liH5094GN46MHgyqh/8o5wsOqk+0Rv7NxHznhKd8xxOG9kx866pX
	cjyg0+i8d4yy461gErDmdi78+WoaCo1VE2VFplWyaWrF5ez1WaYiQGt3TvrG111gnuma3M
	adkDgWX6/X6pfdPU8YOQhy/knbmYAlw=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532-evpVCDmtMjK_HYnRn6n6Ww-1; Wed, 05 Mar 2025 22:10:13 -0500
X-MC-Unique: evpVCDmtMjK_HYnRn6n6Ww-1
X-Mimecast-MFC-AGG-ID: evpVCDmtMjK_HYnRn6n6Ww_1741230613
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6e8f4367446so4062876d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 19:10:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741230613; x=1741835413;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7l5kkkm2A6O8p7efBFndsWQIHjztP61j8KYSJ+fyXVs=;
        b=Ci1e/ZKGz6uyjwPK4d9jddn1ww1N097ZO3Jsz/64Q1hBoUs9v+uImbGraqpK+cVT3y
         5lEx831C+1GfdkW/IluFzKMfveILqqxdtksQrlzQzhE0Y96o2SX04QeR4mb2B9vdjUsF
         tsD7niQw0/tdHR4YjQFkS63pLXO1FaFU5GAA91eoKHJjxldZz+XArmYiT8Y9+JbWwCsr
         oIqjVBHh3sPvDeuh0e1t/8+zTpyGmcoLxDcT3dLDFIsGEgd08SfW5cRev6NYld/98OhR
         pSQ29eVUw/2S5ScA8s1ZScX2GEsjDCWd6Vzx95WaD5bob8FE/BxFn/CBYg6GNWLlNQK/
         RS7A==
X-Forwarded-Encrypted: i=1; AJvYcCXJeZQQmn6+gPwFiOEY+aEwzh2/ks/aUqIpn/l3BtwDPZNpi+byNn/aEz1T5DvtYWzPUSzHqWReBuHzx3s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfX1/BEe6vNmspPMTleutJq1yX9XZ9xMmpsUSoBA6uL/O2uobz
	z71PJ83NWNQt6xlXZWL3PWnY38+jdOzhm9XnJu0O06Pj3Q9nGW6tvZ6FTbOgJV6yLzN9wXyLd9t
	kaih0w89tpEnG8dNlxonkUWkmRDarAHNIuimjkBv01A2jwcJeNb9ON68Qbjg7sw==
X-Gm-Gg: ASbGncuBctWteGDbj5ko6OUCIC8GYn0zH/Ctxl1ywE44XOQ3baWfLGbWmkMRkteGkGQ
	aGFAQp7zdB3j+MJB7pNlqYfYfeW+5vke5w51e98QbwF2dUpZBR531p7qywj+l17XcY7/X/vsG94
	9V5XK7VbMiR+b+9nz5XXmIBHe/qgokmAhl/hwLG73GNpTp1Nx5gEQcVmS8dIVdrJDOXBgGQQpEs
	5s8lfjtnsKIaVprAUX+/dS/JRQTZqIhLx9gnYIMECLJIO/A+kChBFvSjvy07jPw+2NDqbYM1B2/
	ZhY6jjAYL+0ETYvba+iOgrOLnwGqCh8T18ULCc6FJALhvOXP6iazIV0GefE=
X-Received: by 2002:a05:6214:27c9:b0:6d8:9d81:2107 with SMTP id 6a1803df08f44-6e8e6cef872mr88105696d6.20.1741230613102;
        Wed, 05 Mar 2025 19:10:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGVdHI31z05iCKFEFnT6s00T+bkMZvLip1MoT1GcKpHyTPnqy3kyfqxISRwqyDot8s6DeFWog==
X-Received: by 2002:a05:6214:27c9:b0:6d8:9d81:2107 with SMTP id 6a1803df08f44-6e8e6cef872mr88105436d6.20.1741230612835;
        Wed, 05 Mar 2025 19:10:12 -0800 (PST)
Received: from ?IPV6:2601:188:c100:5710:627d:9ff:fe85:9ade? ([2601:188:c100:5710:627d:9ff:fe85:9ade])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f707c3dfsm2259236d6.7.2025.03.05.19.10.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 19:10:12 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <e4b69082-bd23-4447-82f8-cb2a86c47690@redhat.com>
Date: Wed, 5 Mar 2025 22:10:10 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] hung_task: Show the blocker task if the task is
 hung on mutex
To: Waiman Long <llong@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, Joel Granados <joel.granados@kernel.org>,
 Anna Schumaker <anna.schumaker@oracle.com>, Lance Yang
 <ioworker0@gmail.com>, Kent Overstreet <kent.overstreet@linux.dev>,
 Yongliang Gao <leonylgao@tencent.com>, Steven Rostedt <rostedt@goodmis.org>,
 Tomasz Figa <tfiga@chromium.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>, linux-kernel@vger.kernel.org,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
References: <174046694331.2194069.15472952050240807469.stgit@mhiramat.tok.corp.google.com>
 <174046695384.2194069.16796289525958195643.stgit@mhiramat.tok.corp.google.com>
 <21a692ce-3fa4-48f2-8d1c-5542c1cfb15c@redhat.com>
 <20250306113236.aa39a5928c8106c13144df4d@kernel.org>
 <5f7bc403-be75-4ae3-b6ff-5ff0673847f9@redhat.com>
Content-Language: en-US
In-Reply-To: <5f7bc403-be75-4ae3-b6ff-5ff0673847f9@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/5/25 10:07 PM, Waiman Long wrote:
>
>
> On 3/5/25 9:32 PM, Masami Hiramatsu (Google) wrote:
>>>> +config DETECT_HUNG_TASK_BLOCKER
>>>> +	bool "Dump Hung Tasks Blocker"
>>>> +	depends on DETECT_HUNG_TASK
>>>> +	depends on !PREEMPT_RT
>>>> +	default y
>>>> +	help
>>>> +	  Say Y here to show the blocker task's stacktrace who acquires
>>>> +	  the mutex lock which "hung tasks" are waiting.
>>>> +	  This will add overhead a bit but shows suspicious tasks and
>>>> +	  call trace if it comes from waiting a mutex.
>>>> +
>>>>    config WQ_WATCHDOG
>>>>    	bool "Detect Workqueue Stalls"
>>>>    	depends on DEBUG_KERNEL
>>>>
>>> Reviewed-by: Waiman Long<longman@redhat.com>
>>>
>> Thanks Waiman! BTW, who will pick this patch?
>> Andrew, could you pick this series?
>
> Peter, do you mind routing this patch via Andrew?
>
Resend as plain text.

Regards,
Longman


