Return-Path: <linux-kernel+bounces-174746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 942BF8C145B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 19:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6A8F1C20D6D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 17:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0CB76F1D;
	Thu,  9 May 2024 17:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TTxlfAdS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5248E770E3
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 17:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715277054; cv=none; b=KK17hgE+n3MvmEmKOqaQ20vcXY7fT1w3Rv85tEzFNFfLy9m/cTDF2RGEOHZJiv93fL/bvDq03usWqGjGkz42B/juYTTKl67ntAk5GMc4jGvggV14s5kP3JqCzcqlHkAO8UX/DT6jT5lTzebDs2EIHc6Ujdsb24wWX7NolKlJpCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715277054; c=relaxed/simple;
	bh=AuIHXH0kmLRTBlETMNM8nhbdKJGDtolDee+2wU48afg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eNU470zRy127IG3Zh5yTNfbCwC85YJS5/tALzM6ZW18+hC1rskGuvAlA3JjsbV9YwcsnPu7j4PYE+3kARWpoFgpvIYNfBJ/yUv+g0BsWZQoZMP9/VmT1ZdLI8xc33j0pgY+iM2bCoH5pjYyIT2dSsk6Q07DuDsrHopg79kjwDBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TTxlfAdS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715277052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=h4lyeJxZNP6rRsBG/RwMIz9FaCWXE7ZXMgU1HQVLqJQ=;
	b=TTxlfAdS+DeFg41Qif6baiuRppdrCsLwzLg9RAxpAY6S5f1A6BXbEm9zXxetqpQ34HagGg
	Bs6SiU96GRa2can96+RSLmVSkwhA7+y132NHV5BFgp354hClKE0RCoYYJsWnmB+WTAJQG8
	hQGgADtXfS6nwoEb57Ebw0wUKr+FSJA=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-l1LkTnEtPTODSinxvVjgtg-1; Thu, 09 May 2024 13:50:50 -0400
X-MC-Unique: l1LkTnEtPTODSinxvVjgtg-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2e2035036f5so12244581fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 10:50:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715277049; x=1715881849;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=h4lyeJxZNP6rRsBG/RwMIz9FaCWXE7ZXMgU1HQVLqJQ=;
        b=VjQrSU9Ocx3aHzKfzJ+5Gtzs1lixOpOz+eqmIgFi2XtoxVT2Ri2O5r3wpXG8NkeARK
         /LAzpfbZJkb3cuuzU4pav+i8C8GWuqqLxSC4XL3ascN/Fm/m7XI2wkK8JSG9LUJtD1Gh
         3l25naCliLYAx5Ysi7xTARAxTejYWvNqnV6Yrq8XmOV+VhB6Ntdq3g9BjnJCD4nqQDDu
         DjtG9WO5bY5zCcwkF0nL2nWVer0tS/PcGqi5dktWjG1Avn/+rtDlxUZYvpmd50deFfAA
         Qa3A6+Wlh3FknPBhj08QglmRYhWuIh/7Wdtu/vyDm6h8W+YXjFJiBxZSQoRQe8ReW/Tp
         jNsQ==
X-Gm-Message-State: AOJu0YzDAh2uWeSuqI9ERHIaehJX09sRqhIYythUs47phOtN7w9KpMed
	WzcsvLcjck8wHo11cAIQrqOazIj+C9/jXIJYEPfW75BMKFjcGU+N8eHyoj3q7U3le8RzWFY2J5F
	LNa86o07xvhsiKCYwrNnQme45YvfndJv43q68PhVbta+iAjzSMnSFn6CibNUGO3Pt9j2Yiw==
X-Received: by 2002:a2e:b0db:0:b0:2d9:fb60:9afa with SMTP id 38308e7fff4ca-2e5203b41ecmr1414971fa.40.1715277049183;
        Thu, 09 May 2024 10:50:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7uCXu39bPVUe66dvyn+7wi4yVEmEfcVXB9UFtK53a2jWW0OU9CnRU0n1pOZHvuSe1PwNeDg==
X-Received: by 2002:a2e:b0db:0:b0:2d9:fb60:9afa with SMTP id 38308e7fff4ca-2e5203b41ecmr1414671fa.40.1715277048619;
        Thu, 09 May 2024 10:50:48 -0700 (PDT)
Received: from ?IPV6:2003:cb:c716:7600:ac6:a414:3c04:6f5a? (p200300cbc71676000ac6a4143c046f5a.dip0.t-ipconnect.de. [2003:cb:c716:7600:ac6:a414:3c04:6f5a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41f87c235e2sm67194785e9.12.2024.05.09.10.50.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 May 2024 10:50:48 -0700 (PDT)
Message-ID: <6b42ad9a-1f15-439a-8a42-34052fec017e@redhat.com>
Date: Thu, 9 May 2024 19:50:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 6.9/BUG: Bad page state in process kswapd0 pfn:d6e840
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 Linux Memory Management List <linux-mm@kvack.org>
References: <CABXGCsPktcHQOvKTbPaTwegMExije=Gpgci5NW=hqORo-s7diA@mail.gmail.com>
 <CABXGCsOC2Ji7y5Qfsa33QXQ37T3vzdNPsivGoMHcVnCGFi5vKg@mail.gmail.com>
 <0672f0b7-36f5-4322-80e6-2da0f24c101b@redhat.com>
 <CABXGCsN7LBynNk_XzaFm2eVkryVQ26BSzFkrxC2Zb5GEwTvc1g@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CABXGCsN7LBynNk_XzaFm2eVkryVQ26BSzFkrxC2Zb5GEwTvc1g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 09.05.24 13:59, Mikhail Gavrilov wrote:
> On Wed, May 8, 2024 at 10:45 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> "page dumped because: non-NULL mapping"
>>
>> Is the relevant bit. We are freeing a page, but page->mapping is not
>> NULL. IIUC, it might happen under memory pressure when reclaiming memory.
>>
>> It's weird that only you are seeing that, if it would be something
>> "obvious" I would expect multiple reports :/
>>
> 
> Maybe because the problem is really difficult to reproduce (rare
> combination of the kernel build option and workload). I even thought
> that the problem was fixed because it did not reproduce itself for a
> week.
> 
> But yesterday when it happened again with the kworker process, I
> stopped doubting that it was fixed.
> 
> Now I am concerned with the question of how to be as useful as
> possible when reproducing bug again?

Do you have the other stracktrace as well?

Maybe triggering memory reclaim (e.g., using "stress" or "memhog") could 
trigger it, that might be reasonable to trey. Once we have a reproducer 
we could at least bisect.

-- 
Cheers,

David / dhildenb


