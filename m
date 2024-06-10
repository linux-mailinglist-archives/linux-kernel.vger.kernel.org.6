Return-Path: <linux-kernel+bounces-208876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE806902A22
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 22:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94BC81F203F8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 20:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023FA1514D3;
	Mon, 10 Jun 2024 20:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MSbeq8nz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09266F2FD
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 20:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718052424; cv=none; b=qCBeeu/j0E4P25y4JxDj9/ywgExTbGpbwslqYaPP6J6zP9u03srMfo4na6X9v8iVRqb/eM72epVjbgAFpS3q1NWeIQu6RpQXxsJEyutxNqJqU5EPPduO2toWaGxOo5LlcWx0meiafI0FCmMR27ny+9MorUXm6yiKtuDns35IhrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718052424; c=relaxed/simple;
	bh=hmr/nmEFUE7SPqQJeyyfPQSSwzYNqDpKNtuMcCl1Yo0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oMNpJU9l47VuIfG6sW9zfIrxK56VjdC5FbCaUQ2TfHZsNLFottMzOSJ0FpGQHXPC1Ik/Fbt2WSB/zVzX6CW5ICQ9+JFG6Pm3xQuoo+Z2pqv5SpUrsczpgRYpytqFVANxodjz7yVgv3yYzLgXJMm/JXlcXoWtHK4JGRWAiEP8V4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MSbeq8nz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718052421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LxiNEvx2Od2nkRp3Ia5+BRC8R4WpmCSdFEiRdP/JyGs=;
	b=MSbeq8nzpcliAto1XM/xhG5A/+w5uO493fmnGuqTIfrOS2HrB1DF9nUDa/E3d+WB7clz/d
	JGniABajE827HeRWN6Pp1RpuxAc+Rz9pXPjVdkgKmyKlSQGrRFsxfTIEAbXVbgW15dBoEb
	2eLpbnKCn7x1rJAhlmIf70/tAcx5lf0=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-B2Zls3E5PiiM24Kqw7eJEg-1; Mon, 10 Jun 2024 16:46:59 -0400
X-MC-Unique: B2Zls3E5PiiM24Kqw7eJEg-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2ebd7ad3476so2133031fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 13:46:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718052418; x=1718657218;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LxiNEvx2Od2nkRp3Ia5+BRC8R4WpmCSdFEiRdP/JyGs=;
        b=EGmbepDGrxM1zTgxgiJIuZ3ZIvRaca8GXqMlAeDAFe1SxPjWN0re+z9YMayHVy1hny
         /8TJafqdwYqNqp4W6UAFk4TgnNg5rrf20ruIncCla5TayJUpYjm21G6Hgweg/kfN8nWT
         Omtb9LCU4tkn0zgQbYTIJ21a0yI2pIlJwoMtRgbtElPcYdWTDXs0zLXaZGwmkzIaYXrE
         YLPXngA0/kHNCbDQVOrWg7ixaSZgdKPvbPKOa/xcJfxhBt1bktWA3HHjaqZFDXezUSre
         Ctb01B42Iz7+Bl7WE+4xm24XpzpjpuqNL6rdsBPJbKHwMNha4PbnbWIjzO156PKexGOa
         M0Tw==
X-Forwarded-Encrypted: i=1; AJvYcCXK6Rv2WUVDJ9hnf2Js3YbY10axCztOlaAV+zFYfQOUyJ1f9KlGbjBudZ0jagNbzYRV+oWrcnVM6fNUNj+t8HwbK9VVuc/xy2T5OhNl
X-Gm-Message-State: AOJu0YxHU6viY/LIoBwHrnBg1DRfgHCDZ81nDFnl5yU3XGsO3xHDbrRU
	YbFZuGhTy4Woxq3eYicIVU8sGS3DVQVwlDMMq9vOAqwbdkx3wf1ITf8qYyM0GsjefXmeOisBPDS
	iS0ZOlC684tmDR65RWZc8dZpPEuCXlge+c6cESbXlqyiTs9hdyrfkFhxmhr+iTg==
X-Received: by 2002:a2e:a7c8:0:b0:2eb:e505:ebd5 with SMTP id 38308e7fff4ca-2ebe505ee5emr34276231fa.3.1718052418258;
        Mon, 10 Jun 2024 13:46:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLAjsaXc5BdwEtJmjiyy6QV5OH60ABPwmHSupwxu8PY7u/HPHzdfQDvJCtikV8xZ3ymgDwNw==
X-Received: by 2002:a2e:a7c8:0:b0:2eb:e505:ebd5 with SMTP id 38308e7fff4ca-2ebe505ee5emr34276171fa.3.1718052417814;
        Mon, 10 Jun 2024 13:46:57 -0700 (PDT)
Received: from [192.168.1.146] (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ebdcbff7fasm10900121fa.78.2024.06.10.13.46.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 13:46:57 -0700 (PDT)
Message-ID: <882a4ba5-b0ef-4c21-8167-e2949424912c@redhat.com>
Date: Mon, 10 Jun 2024 23:46:55 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/4] rust: add abstraction for `struct page`
To: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
 Matthew Wilcox <willy@infradead.org>, Al Viro <viro@zeniv.linux.org.uk>,
 Andrew Morton <akpm@linux-foundation.org>, Kees Cook <keescook@chromium.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng
 <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@samsung.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
 Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
 Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas
 <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>,
 Arnd Bergmann <arnd@arndb.de>, Trevor Gross <tmgross@umich.edu>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
 Danilo Krummrich <dakr@redhat.com>
References: <20240528-alice-mm-v7-0-78222c31b8f4@google.com>
 <20240528-alice-mm-v7-4-78222c31b8f4@google.com>
Content-Language: en-US
From: Abdiel Janulgue <abdiel@redhat.com>
In-Reply-To: <20240528-alice-mm-v7-4-78222c31b8f4@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 28/05/2024 17:58, Alice Ryhl wrote:
> Adds a new struct called `Page` that wraps a pointer to `struct page`.
> This struct is assumed to hold ownership over the page, so that Rust
> code can allocate and manage pages directly.
> 
> +
> +impl Drop for Page {
> +    fn drop(&mut self) {
> +        // SAFETY: By the type invariants, we have ownership of the page and can free it.
> +        unsafe { bindings::__free_pages(self.page.as_ptr(), 0) };
> +    }
> +}
> 

What about cases where the struct page pointer is not owned or allocated 
by this wrapper? For example, pages returned vmalloc_to_page()?
Any thoughts about exposing a provision to avoid freeing those pages 
during Drop?

We've been experimenting in adapting this Page wrapper in advance for 
page management within the Nova DRM driver.

/Abdiel


