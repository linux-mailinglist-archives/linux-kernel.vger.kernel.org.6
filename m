Return-Path: <linux-kernel+bounces-554660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 371EEA59B10
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D3F47A65C1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50132309AD;
	Mon, 10 Mar 2025 16:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="dN650yOg"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFD022FF24
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 16:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741624299; cv=none; b=aFo1CzX13IqmHm8PkPL+Ugq7tEjHLtlhgZON3q0jYYT50EHwpgQCLq7W1SerEivpLS3lFvzh3yYswk2qNki1TxnJhMUk/A53s5BuGwDA0TZv+QbjN5vK9Ddf7HkPHi8GA08jzjXZeI+fkYdBmhRGNxO6lLpnYh95XuOAm0yB5TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741624299; c=relaxed/simple;
	bh=EOzJGti6xtE/KS0s/r8JB1JyrUcLNSuZkkzVMvKg/uA=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Subject:
	 References:In-Reply-To; b=nvNdYMPct5caA/HMKql5Wqyv6GxoxIH7RMTNuf9tgvyYexBnym0wIlEbUOMUTDb3SYUC94gPJ+E+JgiSshldrcSTyd0X1AGIapBP8Xyzw81/BnAo3iKzcuiGIHlj6kWnia5m1C3WQT9Q57FWgXyN9ugQqZhHmlxwwjfUH8YQtmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=dN650yOg; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-46fcbb96ba9so58910131cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 09:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1741624295; x=1742229095; darn=vger.kernel.org;
        h=in-reply-to:references:subject:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K+rvxu2VtO7t9hS1BcwolfWYrJhJIsb4fGcBMA3gsjI=;
        b=dN650yOgLkW1MLoBZYEBHGx5/s6s5eakefzMlmnu962JPwhfd6GjTKiL3ftoSz9OKQ
         8NiGNIiFWFybSC6g5vwBTg/SY9oAOs67Kcg1/p9J61/h7jI5O2i9H+6YcMABjhvC9LHn
         /vuSKDlasEt0EZQ/FDL6PF10s3BppbQLDQ8i71ITG14j96Xq0sUXhh/TIiwewO0diVOc
         15m8Q81PTy52dr+kyV02zc4SBnCMtAGVhqv2K6WrbQW2s9/Gyfhap2RBtM9bGgdvUttC
         LqLFINudK8XhgLltE1LAJPLIEWnZQ4IK/AlNxn7X5vQ6HOiotplzZK4Kkhif6iB01KHH
         TDFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741624295; x=1742229095;
        h=in-reply-to:references:subject:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=K+rvxu2VtO7t9hS1BcwolfWYrJhJIsb4fGcBMA3gsjI=;
        b=EOpofc+XDDKSM6ULCOIQsJ4QRJAGcd3cU9Veon4EJULqBLHTai4f+nndOfH4NNsAGh
         JdHH1N9zmlfeAq65KK53Pa7J5vis408Nk9J3e6M0TP7GzT1mNvKlNFKCIQw3s4Ixh5xE
         1FNE0le31urPffAmy9Lrs1GWL/D27T4eLqKB7p4m6ld2w9RUTj4lN9upxSzcTAT8s+3k
         1nmHm1eZ0OTjYxy+NMj9TnSPxp+KGPnAL4dwm9BN+JaQcCgWwbDJOxJ5F0bDkIXb52le
         6wAi24jh1fo9YnE5gj/DqeMrxfve6uUk6RI3vq2HU27RVajETNqbKrlZN8026naGyOLZ
         2nWA==
X-Forwarded-Encrypted: i=1; AJvYcCWteGJbhUAAIUEMQM0N1m/XhWNE1UdqgoIalMnpcJyrloCXzaDM1xVYmhUuxCiAq/rnSv7SqnbJUGcKSf8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFhzrKLSMhV94qoZ4EIaI2sT4pn4ybzRTksuihhCB7OfYe06hL
	FzP/AQYiBTtKsitPULd4sNd5+nPevS5sFuv53D5F9CeJppirOPptBUNqSecLyQ==
X-Gm-Gg: ASbGnctWDTt0mmOnGObvXagzxAF1AgI0XMXdW4zmFrtOZy7ePfvTUwuFjVxOr45D6GK
	cJiN9a+UYMpZFx5UHal5LcLmUuvnxBnThXtTMsZHJnfExoVWksFas2zvAcjrsgNplTd9h8gRR7O
	gmA5iVUA6otqCYnrh+rxRrRF2dTBzkOfEcvbiFYkvF4qbV0aJAh1wOnCQhox8nqNuOeNs2lUrc8
	pdrnvjPKCbabwWuOXDgADwIraPR66PH0rEXeWXfkQr+eJVdSj+oYAjOBb1QLexQSalcHX2X3p4y
	IWTg/yCnjId6RhlsmHF4MA0OnGg5gRv84uUFQOn3xrWrPjFgO+jCR5Wy/p49Ae0g2byREmUceCh
	PKolKx5eyC64Ji5GtHM7KMDpK
X-Google-Smtp-Source: AGHT+IHlZT3bIAT3WS2IFI/YedPMfsOmKAgmF62kbG0sEZfn6Fzjq1oKL8J7czbvA3wYWZrIG85mUw==
X-Received: by 2002:a05:622a:ca:b0:475:486:2fa7 with SMTP id d75a77b69052e-476109bc959mr190733101cf.26.1741624295266;
        Mon, 10 Mar 2025 09:31:35 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4768cf1ec2dsm15915861cf.31.2025.03.10.09.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 09:31:34 -0700 (PDT)
Date: Mon, 10 Mar 2025 12:31:34 -0400
Message-ID: <2101885775982b2b6310298ae96a3278@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250310_1216/pstg-lib:20250310_1216/pstg-pwork:20250310_1216
From: Paul Moore <paul@paul-moore.com>
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Xu Kuohai <xukuohai@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, bpf@vger.kernel.org, 
	selinux@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v6 1/2] security: Propagate caller information in bpf hooks
References: <20250308013314.719150-2-bboscaccy@linux.microsoft.com>
In-Reply-To: <20250308013314.719150-2-bboscaccy@linux.microsoft.com>

On Mar  7, 2025 Blaise Boscaccy <bboscaccy@linux.microsoft.com> wrote:
> 
> Certain bpf syscall subcommands are available for usage from both
> userspace and the kernel. LSM modules or eBPF gatekeeper programs may
> need to take a different course of action depending on whether or not
> a BPF syscall originated from the kernel or userspace.
> 
> Additionally, some of the bpf_attr struct fields contain pointers to
> arbitrary memory. Currently the functionality to determine whether or
> not a pointer refers to kernel memory or userspace memory is exposed
> to the bpf verifier, but that information is missing from various LSM
> hooks.
> 
> Here we augment the LSM hooks to provide this data, by simply passing
> a boolean flag indicating whether or not the call originated in the
> kernel, in any hook that contains a bpf_attr struct that corresponds
> to a subcommand that may be called from the kernel.
> 
> Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
> Acked-by: Song Liu <song@kernel.org>
> Acked-by: Paul Moore <paul@paul-moore.com>
> ---
>  include/linux/lsm_hook_defs.h                     |  6 +++---
>  include/linux/security.h                          | 12 ++++++------
>  kernel/bpf/syscall.c                              | 10 +++++-----
>  security/security.c                               | 15 +++++++++------
>  security/selinux/hooks.c                          |  6 +++---
>  tools/testing/selftests/bpf/progs/rcu_read_lock.c |  3 ++-
>  .../selftests/bpf/progs/test_cgroup1_hierarchy.c  |  4 ++--
>  .../selftests/bpf/progs/test_kfunc_dynptr_param.c |  6 +++---
>  .../testing/selftests/bpf/progs/test_lookup_key.c |  2 +-
>  .../selftests/bpf/progs/test_ptr_untrusted.c      |  2 +-
>  .../selftests/bpf/progs/test_task_under_cgroup.c  |  2 +-
>  .../selftests/bpf/progs/test_verify_pkcs7_sig.c   |  2 +-
>  12 files changed, 37 insertions(+), 33 deletions(-)

This still looks good to me (ACK already present), are the BPF folks
still on track to merge this into their tree?  It would be good to get
this into linux-next sooner rather than later if we want to send this
up to Linus during the next merge window.

--
paul-moore.com

