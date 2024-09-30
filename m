Return-Path: <linux-kernel+bounces-345019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EBE998B12C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 01:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A644B21297
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 23:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14196185B62;
	Mon, 30 Sep 2024 23:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="txauOom7"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D320E43155
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 23:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727740128; cv=none; b=SyO07dLLC9RK3JFSghLzLkjQHDP/sJCvKTkgY807fudAGzKx4kZV03xm+nLridxcF/Q1ckCWKmGC/K3D0k8VGPADKDxS6/vXVXv6xZ0fenAXKDfDYsL2x4jY0Cb9mB0PXWurM8dn0PdElKSi/X29GCJG8SsPybW35GnfoH+iSgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727740128; c=relaxed/simple;
	bh=iGGV61Auamlp0HVSZhyYT5kdcOc7Q+GNYTrHIwzXHGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rSF7UrE0G/ORzLGMcKp1donVFkYfjwqHWc34/OXSyox8QrtrKvDytcBP/Qb73HeuLe4b79gly+oxfEMJGixBZeKG7SvMBofcaPeinJTOchf6pRMOV4EFNMbal9zS4BwTx+SC9AFnpEV5Ow9dvI1vpAAeHEOE1l8rHA9Gzkw9loA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=txauOom7; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-536552fcc07so5598e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 16:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727740124; x=1728344924; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ij7egDArFBGIX3zN3oYUeZ8bEw9vjZjN4zpJ7d9t4E0=;
        b=txauOom7lVgwClOxwmF/55vIT9+blD0IHqU4MUuc0LtLl76+vrDyRAMFC1T9x/qyA6
         3qO/2MtWqGzqJihe9X3L0qNdSGyl1jctVit5ZxeAUkbVLdj1JAamuEITs5DP6tzFrIFw
         ouA9SGIhjNEWvwbAHjEJC1gpSt96H1YSzyKIyMuJwwBRWc2JRHT7FOrs4dr6kKG38WpF
         uRu9x152dDLjYEH3t5QTnAD1eJMhZyQZnoFg7CJtqcsTP+sKceVdBl7njYNj/F6NfewT
         9mV/IBQ8JToc0YjDXM7OawMlsgjGYqyryPGy25GC6osetJqu9kBlKb+wsPb88k+JjPiH
         DdqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727740124; x=1728344924;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ij7egDArFBGIX3zN3oYUeZ8bEw9vjZjN4zpJ7d9t4E0=;
        b=vkcsm15nqV+tluJOm0tZ5g4TSIxqpk9diDxCszBC5KT9d5v/fCjYUiut51XdkqhCkd
         AMPQbNvubT7piQ7P9bqEexyLDB8sLojX5z3SVdj/tlDBFFrdri/fsufw0cYND+/1L3EZ
         Bv9aUV5sRN4W1bp2g7Srj8q4z5X/NbhzSKE2FQZAsiuljVN7qBd9LA/WIIfwuV50O83L
         A+vHd7KgAjXpUBSQ2J8Shn9/mMbDAnZQmYoqAeiPdumHqSGLPimbLzUlQIX81xPbrfZm
         7SyvmisMYdXnnwTEQo9TN1tXOcOBkAoGIBGkKauJwvXqvFo0PUFZVMJgwImoqWbEElfD
         W3NA==
X-Gm-Message-State: AOJu0Yx4WInh/EH1934MWB0MKtWjNpucvtSJoy/dEm/MA8jnR6FHMxSt
	0YmmXIpCXeVeeAEGeBa5EjdxuLuRl3/p0ou/GkUyrB4VsmRpbn03mw3gqO46Nw==
X-Google-Smtp-Source: AGHT+IGmvj5gHf/Oqh86OjkD8szfvtXaWrJnzHw75IYTYE65Ro7KDjuRIrhWAA/nkeEG6MdU+UxYBg==
X-Received: by 2002:a05:6512:6d3:b0:536:52dc:291d with SMTP id 2adb3069b0e04-5399b7b2daamr104744e87.1.1727740123845;
        Mon, 30 Sep 2024 16:48:43 -0700 (PDT)
Received: from google.com (103.35.76.34.bc.googleusercontent.com. [34.76.35.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd564d029sm10748814f8f.7.2024.09.30.16.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 16:48:42 -0700 (PDT)
Date: Mon, 30 Sep 2024 23:48:42 +0000
From: Matthias =?utf-8?Q?M=C3=A4nnich?= <maennich@google.com>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com,
	peterz@infradead.org, void@manifault.com
Subject: Re: [PATCH] sched: fix include for task_cpu_possible
Message-ID: <Zvs42l4A9wvqnLFK@google.com>
References: <20240930164455.2060692-2-maennich@google.com>
 <ZvrZsQ-uXHFQsxII@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZvrZsQ-uXHFQsxII@slm.duckdns.org>

On Mon, Sep 30, 2024 at 07:02:41AM -1000, Tejun Heo wrote:
>Hello,
>
>On Mon, Sep 30, 2024 at 04:44:56PM +0000, Matthias Männich wrote:
>> From: Matthias Maennich <maennich@google.com>
>>
>> Commit 2c390dda9e03 ("sched_ext: Make task_can_run_on_remote_rq() use
>> common task_allowed_on_cpu()") moved the call for task_cpu_possible from
>> kernel/sched/core.c, but did not add an include of linux/mmu_context.h
>> where this symbol is defined. Fix that by adding the missing include.
>>
>> Fixes: 2c390dda9e03 ("sched_ext: Make task_can_run_on_remote_rq() use common task_allowed_on_cpu()")
>> Signed-off-by: Matthias Maennich <maennich@google.com>
>> ---
>>  kernel/sched/sched.h | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
>> index e2b7c5282f5d..a7832c53cc92 100644
>> --- a/kernel/sched/sched.h
>> +++ b/kernel/sched/sched.h
>> @@ -44,6 +44,7 @@
>>  #include <linux/lockdep.h>
>>  #include <linux/minmax.h>
>>  #include <linux/mm.h>
>> +#include <linux/mmu_context.h>
>
>Should the patch also remove mmu_context.h from kernel/sched/core.c?

kernel/sched/core.c has a call to switch_mm_irqs_off, which is defined
in linux/mmu_context.h as well. So, no, the original include needs to
remain.

Cheers,
Matthias

>
>Thanks.
>
>-- 
>tejun

