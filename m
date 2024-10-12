Return-Path: <linux-kernel+bounces-362100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E86EC99B112
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 07:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 402391F230B2
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 05:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9136D137750;
	Sat, 12 Oct 2024 05:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GI39MUvR"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B61B67A;
	Sat, 12 Oct 2024 05:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728711002; cv=none; b=ruGY8XDHcly2MsgdWqvhaxE/CHPDFUz5xf7/otLsbVYUD0v/OcpM8SXIuGWH+OwoX5rna/oCCKXMksk332Gj/t2sNMQWjkzni1AzmlCOQU7IGTQ5ukFOQXOHJXMCsocPXuZguZ+S+8xns91IZF+p5SaUlh2as0J7KiLq3Rx5quc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728711002; c=relaxed/simple;
	bh=OPt7fIctfqI+7wLn2jbpl74nQtbjxpgKpI5tOjNS8d4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RbbHYiLIvt29dh9mtskvQ6vE3+sfEwyLyXZdsGLV75Y+sjmKclGrboNGEsXWz649GL/UB5pXQM87dt6Ks9wXuNNDBRSEnvS4mSoj+04FQve3hbDO9RxY4CpZrKC1rMS+p+LcgXMD1Aul9u0eyRtDwkrf7H0iHmpeUVyX9H87ly0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GI39MUvR; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a99388e3009so360419666b.3;
        Fri, 11 Oct 2024 22:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728710998; x=1729315798; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tymw2sNE4Ea4ARYbRwO2NdxK761NUNbBl9SQkfgAh0g=;
        b=GI39MUvRKRo2jxY40hUCKhxF939s0b0RRCjGQOK2FYAClr5Ua1m7BQNayK+O9vok6V
         yHfwQFfkrdRN3N50g4+Gj7i5I17HmyX3nI7BY0RwE2LVeZQmd5z1oSeaEf950Cw+BElS
         vIH+ZmsTwg0kbMqYVFnCIN8B7h1VkimbqkuAAkzEYB6R91ZvqhBxdclHFUCxGpz9gU39
         GfHhL6HQXT+vZ2U3NgDGvXpZs1iBp9/CAhriOff3CcR62J1KHp8PHA6CI0CMtjPchgvF
         /HT4iLB1GJeigHSaO0/y6GrXfY2tS5cLk3HkUqcOx5Gfpje14Z8OfSqZ0VitwzDug0X3
         UphQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728710998; x=1729315798;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tymw2sNE4Ea4ARYbRwO2NdxK761NUNbBl9SQkfgAh0g=;
        b=mNZ9vXTZhxIIi8eCJvxzXEzfEuHuPQCrk+D+8uL/wMKM7osGgIyiSMAeqFvqWPiaF2
         EzI2nQQATmEnOPslfTPzAB/ibuBz879tpA8GinvqZkgLDQ/kiFxA9gq3nL3T03Raf8du
         ue74NYPywTbjc+JQomWsmHHQk6NbOLxbh5m6ksepg8AuAfg7KMWuEFVFLJrD33il5yJo
         RAJAAzM9P9Xw+qCWRVt4VMlBhdZsieSCa0WYDu5r45lXzOffy39p1uvJ30DOLFAYeQlS
         GkPU9WnlETD0SxlqyUiWbij8YZYmls1YH1ui4l5IxgGH0/eXG9URs6IjBHPUSN70Qd4N
         5nXA==
X-Forwarded-Encrypted: i=1; AJvYcCUvwpQ1p/BwF3MRVsg9eV1+ssJcR1TAiDc1NhPqIzOyoTWwx6sV03fh6rhx1OgON1LWq5JrHhDN5ZNwVDw=@vger.kernel.org, AJvYcCWi+4ivN8WZdbZLt7is3/tKDflfpu2FEafOBAYum+ba7o8yTfU/89b2IbzXKM/Z2rz9RkiVJT8sF3OatmPF0q8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoQrw2PZI/sE28sLwNE4UOY4AggqNJGynAfLWXcrq3pqRx71BX
	B2nmJyQOkW2PZzTXF8dURrsq0xiC16GoKaQWDOcnAZwOJcoWMNad
X-Google-Smtp-Source: AGHT+IEWtqUXJoySnT6/Tk2kgdO9OsK8tBc+CVcKtle0zlVkwBwN87AIrEeDiZkBPZWMDUwjC6M9Vw==
X-Received: by 2002:a17:907:6eac:b0:a99:529d:8199 with SMTP id a640c23a62f3a-a99b9754a81mr347328766b.62.1728710998319;
        Fri, 11 Oct 2024 22:29:58 -0700 (PDT)
Received: from ?IPV6:2003:df:bf0d:b400:7350:36ae:6e0c:c598? (p200300dfbf0db400735036ae6e0cc598.dip0.t-ipconnect.de. [2003:df:bf0d:b400:7350:36ae:6e0c:c598])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99ec5aeceasm36343866b.224.2024.10.11.22.29.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2024 22:29:58 -0700 (PDT)
Message-ID: <aef35907-b92a-4f56-a330-b4be06f11984@gmail.com>
Date: Sat, 12 Oct 2024 07:29:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/3] rust: Add irq abstraction, SpinLockIrq
To: Lyude Paul <lyude@redhat.com>, rust-for-linux@vger.kernel.org
Cc: Danilo Krummrich <dakr@redhat.com>, airlied@redhat.com,
 Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
 Waiman Long <longman@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng
 <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl
 <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>
References: <20240916213025.477225-1-lyude@redhat.com>
Content-Language: de-AT-frami
From: Dirk Behme <dirk.behme@gmail.com>
In-Reply-To: <20240916213025.477225-1-lyude@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Lyude,

On 16.09.24 23:28, Lyude Paul wrote:
> This adds a simple interface for disabling and enabling CPUs, along with
> the ability to mark a function as expecting interrupts be disabled -
> along with adding bindings for spin_lock_irqsave/spin_lock_irqrestore().
> 
> Current example usecase (very much WIP driver) in rvkms:
> 
> https://gitlab.freedesktop.org/lyudess/linux/-/commits/rvkms-example-08012024
> 
> specifically drivers/gpu/drm/rvkms/crtc.rs
> 
> This series depends on
> https://lore.kernel.org/rust-for-linux/ZuKNszXSw-LbgW1e@boqun-archlinux/
> 
> Lyude Paul (3):
>    rust: Introduce irq module
>    rust: sync: Introduce lock::Backend::Context
>    rust: sync: Add SpinLockIrq


To have it in this thread as well I just want to mention the discussion in

https://lore.kernel.org/rust-for-linux/87a5falmjy.fsf@kernel.org/

which results in the impression that this patch series needs to update 
`CondVar::wait` to support waiting with irq disabled.

Best regards

Dirk


>   rust/helpers/helpers.c            |   1 +
>   rust/helpers/irq.c                |  22 +++++++
>   rust/kernel/irq.rs                |  96 +++++++++++++++++++++++++++
>   rust/kernel/lib.rs                |   1 +
>   rust/kernel/sync.rs               |   2 +-
>   rust/kernel/sync/lock.rs          |  17 ++++-
>   rust/kernel/sync/lock/mutex.rs    |   1 +
>   rust/kernel/sync/lock/spinlock.rs | 105 ++++++++++++++++++++++++++++++
>   8 files changed, 242 insertions(+), 3 deletions(-)
>   create mode 100644 rust/helpers/irq.c
>   create mode 100644 rust/kernel/irq.rs
> 
> 
> base-commit: a2f11547052001bd448ccec81dd1e68409078fbb
> prerequisite-patch-id: 926565461e47df321ce1bed92894cc1f265896ef


