Return-Path: <linux-kernel+bounces-433443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8279E5877
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 15:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9032916AC49
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 14:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254CC21C16A;
	Thu,  5 Dec 2024 14:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jOuW3ByD"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD8921A43F;
	Thu,  5 Dec 2024 14:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733408758; cv=none; b=STLtyC0ZG9RzsRVOlY3cU/4UMi0aesprf00GaA2tqmsDtQPofR1AR6of8t7dmcoxOjcKmERe4QCkwQlS8NJs01lzyeqSl/ryYgUeIAu9jU1qDWxMRhhFYy/RWQk9IKEhH4hIYz22jlz+xnV/ns0KUdmz9PYU+GP5iO3KYGplo5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733408758; c=relaxed/simple;
	bh=0qWPKNY/t9iR/pOsdFpN8VpUFDmeBzeQfCckYttTZnw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=isp/VxKtXw6zPecYF3CfPYNpcuwCsqJ2erF17VsxfZmPPY+4v5nYxHKwOVgY+W9i48YxPEHNhRdxOaVSLOwwLdMgL1/SmLCU0mGUm6D0WIKZdk1fxx+qYbcxbLfPC8MtdI/vqasqkAW4fj3eBn+7cUxQR1PNp1J6Vq7rkrbiKqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jOuW3ByD; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53dd668c5easo1114801e87.1;
        Thu, 05 Dec 2024 06:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733408755; x=1734013555; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ECr3j+PJPfH3u1FCY8Jwj8p+fy3HgSStYnz6KYhRzjc=;
        b=jOuW3ByD+E1TOf142TMN17nFPVNYLqhEflcICPw4AZOrMEk5B6r4n6Y1Y18xHTPC8I
         C3Ji+Icja5SlyCLYGkiM5w5aoPyFqMc8VuPsFn0RuMoZq/vATINW2aJ6ADOTyRq/8aQC
         Kyg8mEsJIK1r44Iwq0eMJFJh+CY1l26A5SoEsQ7Prw20hX2K4Z4SPYfF98+sxp/IQ4bC
         aMQc4W7uk/U9ainPs3H4f27dtaqvVnx667UEayL5sQrtC3f9hiPTssKXHPdDTqv7DaIT
         nsI97E5ImL+bc2Kure4C/4/bt3wX3Z4Xd0yFjK1z0sqG8yYiwDbnYZKsqckEd0OeKmU2
         owBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733408755; x=1734013555;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ECr3j+PJPfH3u1FCY8Jwj8p+fy3HgSStYnz6KYhRzjc=;
        b=tOFCQsyIWYE5xUTyR9LPaQqM07bXGSC2XddERVODtQ8yOeEFVgJDb7lNT2Kd7mzzeH
         bsUjKvXWgj1FfbKi8oWRYnbTkvRyNsOsSNxg1aFtmgi/DImPweLPsoK/xHqRl31HijGE
         kYTHdnPsJiZ9BsLRGEJyYrKOjXtAv8KaKOyGxGAfDc5FhzX8ROiWEyuIPd/4iJcuClol
         Z90GD82HdKCzvjl2wjMi4yCLOevdmWJXogkQmyDwHlyiwbUCsCYt4cf1MikDcNOAY/sY
         hdOMQdG3WDHShMeLVH3vPKrqVYUyocFnd3r2qtej6vjAgx3fxC9OaUd7aDVZ9DlU5u5/
         O9pA==
X-Forwarded-Encrypted: i=1; AJvYcCVnQiwOT3+RjKx142r+lNaAzMMfwnOeFNoHZbmWty+Eh+XZU2UQ5VFq5siEQ116/ef5Xvm7Adu1BXnQ9rxYKWQ=@vger.kernel.org, AJvYcCXPCQ+5fh1kqM6Hz7aON9CwZeIKruWjlKxNlbwAojOBD6LeGSHt8rOTSYVsTxPK78W61pS0+ECfnrd6kG8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjwXEaNXi6wZ02W7ZLUZmP7dp9I+0hn4XNzwn2dTmeeNuSiXbs
	hLAvBcPpwIYmLCN6GzjPNGToCH5tc37wvV4YYzgB7SKHGb0yrgeM9YdmpA==
X-Gm-Gg: ASbGnctovAIWX1uNq8VKjpb7AvksHTjDMZ5CPmjP7m8ybwvX0eJQ9gruuMJcaxOXVhS
	HQgr5DiE0KVu5tnmziC5DdwT48cw5hJmInV+RDyzhPt9UrRXxLDgvx6/hz1mBVb3tkYy04aRnoS
	ct6S4X+QwsCwN6YRVTlpBbpVswK3q2C90pA6yOdQ4eFamAGLBL5D53+x0aKVmDZ7/KToRor1IuZ
	AvpGeugOoibFFtYOy/i5nnLAofY28RvF9f2uVyZz8rBgl/7sylbbjN6G8UQ4sKk/S7J2eOxb6c7
	Eb1CeofwGTV6IkmHCajM
X-Google-Smtp-Source: AGHT+IFzlJ/ndqgl+nEbM84hx+ZYeslhN+ABZV1lIYxXxfYOelqjUzikzeWd4ZSkjTOWIlPz8RbBWA==
X-Received: by 2002:a05:6512:10cd:b0:53d:f63a:e428 with SMTP id 2adb3069b0e04-53e2192c603mr1207101e87.27.1733408754721;
        Thu, 05 Dec 2024 06:25:54 -0800 (PST)
Received: from [192.168.1.146] (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e229c1edcsm261651e87.187.2024.12.05.06.25.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 06:25:54 -0800 (PST)
Message-ID: <c9baa4bb-81db-42ae-98be-d8cb7d57f237@gmail.com>
Date: Thu, 5 Dec 2024 16:25:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] rust: add dma coherent allocator abstraction.
To: Robin Murphy <robin.murphy@arm.com>, daniel.almeida@collabora.com
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Valentin Obst <kernel@valentinobst.de>,
 "open list:RUST" <rust-for-linux@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
References: <20241205113234.2021442-1-abdiel.janulgue@gmail.com>
 <20241205113234.2021442-2-abdiel.janulgue@gmail.com>
 <1c13843f-6929-4bc6-8564-0ec2d964c41d@arm.com>
Content-Language: en-US
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
In-Reply-To: <1c13843f-6929-4bc6-8564-0ec2d964c41d@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05/12/2024 15:07, Robin Murphy wrote:
>> +    pub fn alloc_coherent(
>> +        dev: &Device,
>> +        count: usize,
>> +        flags: kernel::alloc::Flags,
> 
> Might it be worth adding at least a placeholder type and argument for 
> "attrs" as well, so there's less churn involved in coming back and 
> adding it later? Or is the intention to have a separate 
> dma_alloc_attrs() constructor for such users?
> 

It certainly is possible to include attrs in the constructor using Option:
```
     pub fn alloc_coherent(
         dev: &Device,
         count: usize,
         flags: kernel::alloc::Flags,
         attrs: Option<u64>,
     ) -> Result<CoherentAllocation<T>> {

<cut>
         let ret = unsafe {
             bindings::dma_alloc_attrs(
                 dev.as_raw(),
                 size,
                 &mut dma_handle, flags.as_raw(),
                 attrs.unwrap_or(0),
             )
         };
<cut>
     }

```
So the signature of the constructor could be:

let c = CoherentAllocation::alloc_coherent(dev, 4, GFP_KERNEL, None)?;

Andreas, Miguel, Daniel, any thoughts?

Regards,
Abdiel


