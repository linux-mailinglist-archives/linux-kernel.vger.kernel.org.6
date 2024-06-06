Return-Path: <linux-kernel+bounces-203640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6602B8FDE83
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 08:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D24C1C21DE4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 06:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBAAE40BF2;
	Thu,  6 Jun 2024 06:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cRhxxbMO"
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69562576B
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 06:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717654404; cv=none; b=u1b3n+yUi/Pmgg7xQuLSGwRnUEGxupukpDthiGzfchMo1R2qBatObYpAnsFh5Bp/9q0W7qgX6rXc8XjqDGv8VX0+MEflySBoJ59oM3TiO0+BlTHxRTlrYrKJR1ade6zONwFhhh0YWHrcmlEXT5TYjdd+L0dU92ZBEmfd96saEFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717654404; c=relaxed/simple;
	bh=r75guN+BnCzlQbFq5diJqJ88aH62k44AS+UwMn1GXYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BBE5y5RxtP/GQ8kSZ2sTbP2jHHFTuKQ9wchz6gz3HtS194UXfYk19Vkws4sEGICR2YOftGeE7rKfg2oBs5DcHs7JvZU/7BP5sc73dyHP3Qpi2lbQIeU0ezYDXKR4xFfdjhuz03QvqIBopmGe5B3Fe1kDvxkPFbd6rNomjgOCkRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cRhxxbMO; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-42147970772so3785475e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 23:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1717654400; x=1718259200; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oWm+nHGRVZmn5pKnEf1Ct3kDjGKfvwPGZdqr9mJxN1g=;
        b=cRhxxbMO0WNWkjJ3PZ3n66jgbjK53ZAYcCNHn25EPQocqSmD72L5wNyWt91X+G8tUw
         KS5d9oOD9K5Eb6fQO6ZEVN7DkKyA0nDlebVHgTPq+/QEy7ewb7b+/RF22NB3eIoigOWy
         cO6IXQN22T491HUT6WF4dnZ1zJgvV+7kyxOWRgIgbZWmVwZS4AQicYGyenFssYN5Nxhx
         dilGsMXObMTrZOOjHPXF8qT8oxVLmw137hBhELmWAuYj9qUGeFLi7UBhidqWYq/ig8q9
         uDigG39+Kp3N3qYJz32t4TRcyqXpqgyG/1SIxL8AjHGZEaQC/HJEGX5AXubSFOS30JwE
         Yxdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717654400; x=1718259200;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oWm+nHGRVZmn5pKnEf1Ct3kDjGKfvwPGZdqr9mJxN1g=;
        b=UPJXtns6HGD2a1yQOyWO4m8Qn06xznxldn/PN5RHfxBMAYD+reka1xj864kQbWIj4c
         /JS5hlENQz9f6lafIli/qobteWV+G816lblKe88Z6fS41rybb80ObqiSY3coj2Rr7d2W
         JiUS+zfVxz8+c2WlK0KrxiQ3ooZAz4nJDkWMyg8BAjh+LYaV9jEBNANmtrY6f8EW5aao
         IXspR8T6CnX5QJGiqELehl0x440HWlS9DguN2IIEaRc2H32/F+HZZ5/za7mnluLl8v4X
         5pAwHjHzRHUtzmacR2pdunHwXUjZLcUy0YXMUQOVs6ITbTe+YS4BH/U+1qCgs1qkkBEF
         l9WA==
X-Forwarded-Encrypted: i=1; AJvYcCW9WcEGgmSqzlNmYHa7L6j8oBlxrUwezhxQm10SSNYvsbss1xlhKd/Cxni/KtjGcoxJMy3ngJzyIXtRPJFL9iwibSxfxud6FkVvruwa
X-Gm-Message-State: AOJu0YwcdYczxnWa3nd6mqPOYlIgjyAwtbVRAg7AskLnhF53SN5vFoQn
	I51UyoaAwyw0xNnjd8EIceirhYPMBQzcSiyGKB502pGmorq9CldlE/Q/U5GvAg==
X-Google-Smtp-Source: AGHT+IEdYO6AfXamDYAKvZ4Ohq1sOCgsXjLiUQvXLMa15nBjHTkZ3AhSkmWVtColqKowDCX+kK1Bwg==
X-Received: by 2002:a05:600c:3152:b0:420:1f0f:fe19 with SMTP id 5b1f17b1804b1-421562dd344mr35474245e9.13.1717654399816;
        Wed, 05 Jun 2024 23:13:19 -0700 (PDT)
Received: from [172.31.7.231] ([62.28.210.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215c19e572sm9924525e9.10.2024.06.05.23.13.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jun 2024 23:13:19 -0700 (PDT)
Message-ID: <eaa90c1a-ae96-4506-90dd-146ce85d311c@suse.com>
Date: Thu, 6 Jun 2024 08:13:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: x86: WARNING: at mm/memblock.c:1339 memblock_set_node - Usage of
 MAX_NUMNODES is deprecated. Use NUMA_NO_NODE instead
To: paulmck@kernel.org
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>,
 open list <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
 lkft-triage@lists.linaro.org, Andrew Morton <akpm@linux-foundation.org>,
 Mike Rapoport <rppt@kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>,
 Arnd Bergmann <arnd@arndb.de>
References: <CA+G9fYsGFerOtoxwpKLOYcRtyJkmgjdP=qg4Y5iP5q-4Lt17Lg@mail.gmail.com>
 <315d6873-d618-4126-b67a-de62502d7ee2@paulmck-laptop>
 <7d55b65e-331a-4ce2-8f72-d3c5c9e6eae0@suse.com>
 <e220910c-da6e-40ab-895f-87fd43c1de3f@paulmck-laptop>
Content-Language: en-US
From: Jan Beulich <jbeulich@suse.com>
In-Reply-To: <e220910c-da6e-40ab-895f-87fd43c1de3f@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05.06.2024 22:48, Paul E. McKenney wrote:
> On Wed, Jun 05, 2024 at 09:46:37PM +0200, Jan Beulich wrote:
>> On 05.06.2024 21:07, Paul E. McKenney wrote:
>>> On Mon, Jun 03, 2024 at 07:19:21PM +0530, Naresh Kamboju wrote:
>>>> The following kernel warnings are noticed on x86 devices while booting
>>>> the Linux next-20240603 tag and looks like it is expected to warn users to
>>>> use NUMA_NO_NODE instead.
>>>>
>>>> Usage of MAX_NUMNODES is deprecated. Use NUMA_NO_NODE instead
>>>>
>>>> The following config is enabled
>>>> CONFIG_NUMA=y
>>>
>>> I am seeing this as well.  Is the following commit premature?
>>>
>>> e0eec24e2e19 ("memblock: make memblock_set_node() also warn about use of MAX_NUMNODES")
>>>
>>> Maybe old ACPI tables and device trees need to catch up?
>>>
>>> Left to myself, I would simply remove the WARN_ON_ONCE() from the above
>>> commit, but I would guess that there is a better way.
>>
>> Well, the warning is issued precisely to make clear that call
>> sites need to change. A patch to do so for the two instances
>> on x86 that I'm aware of is already pending maintainer approval.
> 
> Could you please point me at that patch so that I can stop repeatedly
> reproducing those two particular issues?

https://lore.kernel.org/lkml/abadb736-a239-49e4-ab42-ace7acdd4278@suse.com/

Jan


