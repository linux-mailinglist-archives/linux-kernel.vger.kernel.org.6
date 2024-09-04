Return-Path: <linux-kernel+bounces-315575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B9A96C45D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 18:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 533CEB2223E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 16:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717901E0B97;
	Wed,  4 Sep 2024 16:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W+Oa/7eJ"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA951E0B8E
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 16:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725468376; cv=none; b=urvujFvqXi0j2BnJUHkzU2slipgMMHfc63ZuXK35c7xUpuSuIBRtA0qza0IVvGkf9TuF3xhtAaDpJjOq04dJSsMzXw+66OFhhIYJQyN+w3/poEVkPn5tiyJ3QkvNQxYGXZFTj7ica4KBMPPutCmv5QmYAf5H90h51l9TQVPpAg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725468376; c=relaxed/simple;
	bh=zMmn+hJ7Wt2ufTAFdE7RTszziALQXmUcV3ddNOfgT78=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oaibKcYGvE5+dzraETW+EfWvpaLa9aqfDL+lRaF5z/rwJeiKVaqVx+fQMCRk/DQ4bL0PbYKHsj/JjRuPYMDeA7or2b8x/tD05398UBMg3YIlioIXHvyeI+CmEaCPK8WHm58TbXKv5Qjh3lJwRVjQOvxEcv8xGu8SyZhzTJSpXHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=W+Oa/7eJ; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-82a2a035b59so53091739f.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 09:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1725468373; x=1726073173; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BdHA65WOHQ5Gh1en3zzxc2AsOdDD2XyQZ9VoTbjIlHQ=;
        b=W+Oa/7eJzibHU/5dhukzQxOKZ3J9HXTc0/vGNMEkNVHK9zEk0hVJ9s0Zs0i7WUI12v
         B0CAjw6qvihNV/aGVOE9kHUr3kzbcRZMBxB5d4vHbnrXxKOMlVQr+Y4ZVexiAtM7mfAD
         Bpk0ALN0/mqSVYYaJo2vWGTuOALu1SQbVeBow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725468373; x=1726073173;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BdHA65WOHQ5Gh1en3zzxc2AsOdDD2XyQZ9VoTbjIlHQ=;
        b=NLm5Pw4mx5z0aAkWWDeSp56jHKab59XSPG5E3SvqBLfNlBL4v8msCXjgCgDzJei7/z
         kbiGebMFQRaJMXFv+99ksBUFSisMjoM7Omy1gLXw2V6fDG8kqcv/v/sdUo6hJ6VJfZD/
         7FWY7XmfdqgLtqrvsmnAWsVOJV9/TTdKKt/+bZosFCXz7Lyyx2tSW7lvKDUF64bEtBmJ
         ib4JRGOtAezFWgUt/yj0K3DE3eg2bmsknEhlpmM7KAnpIj67K55yJploW3yTKQqR8PCg
         X8cqUC4D4XsCA6wfwzgIrodyATU3ospKpGKg9DHo/aKt0qbg+A+52iIpcBq9IoS2XyfI
         /RpQ==
X-Gm-Message-State: AOJu0YxNj9fhTKDNga/RqUmNHclxoI10gTSgR4F+dm1rCucHoE9nWMay
	q+dzKZhLW0zBXdKqnjnY4811I8WHSZ4xoYA2ZYT3oK7Vs7NqxJUQN3lPvCpQH8V8JhorpWhuyVs
	R
X-Google-Smtp-Source: AGHT+IHsCQvhDGuA8/Oo1o2XgZz6grmaWQ4QpdS8eymXWlZvjayAjbFLAhrCoKk0g6GOslFyAtMpDQ==
X-Received: by 2002:a05:6e02:1a85:b0:39f:5c5f:e487 with SMTP id e9e14a558f8ab-39f5c5fe651mr128278575ab.17.1725468373320;
        Wed, 04 Sep 2024 09:46:13 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39f4fefd4fbsm26646285ab.68.2024.09.04.09.46.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 09:46:12 -0700 (PDT)
Message-ID: <fe02f42b-7ba8-4a3b-a86c-2a4a7942fd3b@linuxfoundation.org>
Date: Wed, 4 Sep 2024 10:46:11 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/futex: Create test for robust list
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-dev@igalia.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20240903134033.816500-1-andrealmeid@igalia.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240903134033.816500-1-andrealmeid@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/3/24 07:40, André Almeida wrote:
> Create a test for the robust list mechanism.

What does this test - can you elaborate on the testing
details? It will help reviewers catch if any tests are
missed or not - be able to review the patch.

Include output from the test in the chane log.

> 
> Signed-off-by: André Almeida <andrealmeid@igalia.com>
> ---
> Changes from v1:
> - Change futex type from int to _Atomic(unsigned int)
> - Use old futex(FUTEX_WAIT) instead of the new sys_futex_wait()
> ---
>   .../selftests/futex/functional/.gitignore     |   1 +
>   .../selftests/futex/functional/Makefile       |   3 +-
>   .../selftests/futex/functional/robust_list.c  | 448 ++++++++++++++++++
>   3 files changed, 451 insertions(+), 1 deletion(-)
>   create mode 100644 tools/testing/selftests/futex/functional/robust_list.c
> 
> diff --git a/tools/testing/selftests/futex/functional/.gitignore b/tools/testing/selftests/futex/functional/.gitignore
> index fbcbdb6963b3..4726e1be7497 100644
> --- a/tools/testing/selftests/futex/functional/.gitignore
> +++ b/tools/testing/selftests/futex/functional/.gitignore
> @@ -9,3 +9,4 @@ futex_wait_wouldblock
>   futex_wait
>   futex_requeue
>   futex_waitv
> +robust_list
> diff --git a/tools/testing/selftests/futex/functional/Makefile b/tools/testing/selftests/futex/functional/Makefile
> index f79f9bac7918..b8635a1ac7f6 100644
> --- a/tools/testing/selftests/futex/functional/Makefile
> +++ b/tools/testing/selftests/futex/functional/Makefile
> @@ -17,7 +17,8 @@ TEST_GEN_PROGS := \
>   	futex_wait_private_mapped_file \
>   	futex_wait \
>   	futex_requeue \
> -	futex_waitv
> +	futex_waitv \
> +	robust_list
>   
>   TEST_PROGS := run.sh
>   
> diff --git a/tools/testing/selftests/futex/functional/robust_list.c b/tools/testing/selftests/futex/functional/robust_list.c
> new file mode 100644
> index 000000000000..9308eb189d48
> --- /dev/null
> +++ b/tools/testing/selftests/futex/functional/robust_list.c
> @@ -0,0 +1,448 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2024 Igalia S.L.
> + *
> + * Robust list test by André Almeida <andrealmeid@igalia.com>
> + *
> + * The robust list uAPI allows userspace to create "robust" locks, in the sense
> + * that if the lock holder thread dies, the remaining threads that are waiting
> + * for the lock won't block forever, waiting for a lock that will never be
> + * released.
> + *
> + * This is achieve by userspace setting a list where a thread can enter all the
> + * locks (futexes) that it is holding. The robust list is a linked list, and
> + * userspace register the start of the list with the syscall set_robust_list().
> + * If such thread eventually dies, the kernel will walk this list, waking up one
> + * thread waiting for each futex and marking the futex word with the flag
> + * FUTEX_OWNER_DIED.
> + *
> + * See also
> + *	man set_robust_list
> + *	Documententation/locking/robust-futex-ABI.rst
> + *	Documententation/locking/robust-futexes.rst
> + */
> +
> +#define _GNU_SOURCE
> +
> +#include "../../kselftest_harness.h"

futex test suite doesn't kselftest_harness at the moment.
Let's not mix and match the framework in the same test
suite. Keep it consistent.

thanks,
-- Shuah

