Return-Path: <linux-kernel+bounces-447160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB4D9F2E2A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 11:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 188A51883306
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 10:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE811203707;
	Mon, 16 Dec 2024 10:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HpRxVujJ"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A845FBA49;
	Mon, 16 Dec 2024 10:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734344898; cv=none; b=RPngOno5f6CwMA/FRUYYDV54/r5Mybzx4ncrdTjti/TQlwyiDqhtncgZVgIAZsibWVc1IWL4wT9Ny6Q+Ix+iS5bZzFRaNieBxhiWIBCBiKNcD0Wqp7tYTbxx6YYVqpKT96d6QFGL+h5sNyaK82gfzv7xO44SUlMOWG9gUn5D6yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734344898; c=relaxed/simple;
	bh=I6SS3jrfUdbjQxbfuV3zgKgJ1lGXHpGlboZOPNu8/w8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QipuQ3j3j9e4UY2yJXnu/HY17+sA3pDQBFrauX097hyBEdrJTY8JbQjKtUFejEB7eaSAUM3xoRcb7VK03o+kZ764sPH0N3i+lcNW3PLxcq4UJUX/LqmNDWIxcGKOosV19lgTrLGX329zgfGfPc09tt0gpzOLFTzgepIZYUhRjDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HpRxVujJ; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53e3a5fa6aaso5267235e87.0;
        Mon, 16 Dec 2024 02:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734344895; x=1734949695; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qo4gtspC0QWz1YSfHZwlyzeb7x8qKi22+rub3ebtAOs=;
        b=HpRxVujJYKBn+sVWeWIDzkClSd90f2y/PJR83HkRS5h31Acka/NwSYOrvesaCKC52k
         LxoUF5osFBCfEOm/RrFaoEqG4O4HwDe9XASquG4PgYHbav7r5db36kvPi5Uv0Ariih70
         DWmjYb3MNX0zk1Yn/IAZtQHG5WEYQo6oFgOU1G/xQlVgppLNo4vKCGa3H4GxRP4plcwV
         oI2iwTB9PfzcU/0OhWzoHYnAOI3Ex8GeNkdHLCe4SnzcCm/Z5BUv4utOTJ8FOy0XXSYn
         bx4nT+0fg1wcusx4c92IZo98eUqY7SWNJIyGnaunQMwBy1/rWmSqABLdwq3o3r35Wp6s
         ASMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734344895; x=1734949695;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qo4gtspC0QWz1YSfHZwlyzeb7x8qKi22+rub3ebtAOs=;
        b=OKAzlElGSfqjKcQHKpnrWATI6QAykh4+CfJeQeSc6d40DBlw2CJXZZW89XnwCW8cKH
         oOPJgFlJod2VB9soWdO0ZL75QdQ7HOVtDIkhfhgUdDXEnh12mUTCJV7611EekYWC3V+x
         98J2gHn0wggyv7GDxby93fEQjBNfju26qSx/cLtpWWQHILJAbNf4D5a7LqGHLJi/dJgq
         tHP9NGzqJJiH0uqw2W3MXAZlsfOHBpQwNy34RAM+p/RSMs0LI+N1JD60uDZMREb/tA7+
         gZkfoumw4XuRfTXbJAMOb4sVznVn2DromeSITHKzXDVY/D+R+RT4h0vSq1Infap1hcRj
         76qA==
X-Forwarded-Encrypted: i=1; AJvYcCX5jv4S4CPy1NhP9fYbMmEcC0UI4fJw7AvhDQvAiCpfRxkbY6uNzNSRPi+u2OJJrJ8B0OwbGvReU07oFgg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3n3ZC7uFBAM3ckR9KH1gnwfCMlgZIDKGsSZPgioLkO4lGimFH
	qzQtyhcNe/IfE+0Et+dWaOxcgPFbcSWMTgy+cTOTUk44VeavLw0E
X-Gm-Gg: ASbGnctkxqY+pQYO5cJ3l5mZE65UTSGQvjlPCUbhX0MasZtWeB+Dzggoo2cVMY5DKdF
	0p4UQ+7vXAHosd3k2VIB1dbBHfy7hCAq5ifJ1HcZMa4X8by9ZIXfCRMGXHYdILjXjnYzKX7dXZd
	H0qlDjPkkkYG9QV5Xqb/aCP/SE2YClEIyMPXMj0i3HB0lbd8EKfMlJR8oe6rtDg6BNaKcMWeUiC
	W8jzbfLg1bwyGOLjrOjh6zFlr2rR7BH2Z2vEiDoe6uyy8W9cmBrpW42uMoYkT8Th754ngOZf+TL
	ICo+Ke+SKzGTo7X19/D4tfQgv8M=
X-Google-Smtp-Source: AGHT+IHKteDfC2OCM7+VId/zWFwdJEzRXp9u+arJZpLS+qjCfcM0xdomEsTAyrePdyrGdWJsG8L7tg==
X-Received: by 2002:a05:6512:3c82:b0:540:3579:c647 with SMTP id 2adb3069b0e04-5403579c673mr3819124e87.6.1734344894673;
        Mon, 16 Dec 2024 02:28:14 -0800 (PST)
Received: from [192.168.1.146] (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54120c13c3asm783129e87.210.2024.12.16.02.28.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2024 02:28:13 -0800 (PST)
Message-ID: <b877f4dd-08a7-4298-80d4-be3570c8fe93@gmail.com>
Date: Mon, 16 Dec 2024 12:28:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/2] rust: add dma coherent allocator abstraction.
To: Alice Ryhl <aliceryhl@google.com>
Cc: rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Valentin Obst <kernel@valentinobst.de>,
 open list <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, airlied@redhat.com,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
 Daniel Almeida <daniel.almeida@collabora.com>
References: <20241210221603.3174929-1-abdiel.janulgue@gmail.com>
 <20241210221603.3174929-3-abdiel.janulgue@gmail.com>
 <CAH5fLgjO-GbB85dDdxLSSWY74cUn8-Lt-yaRGkUVxb-E8YaO2Q@mail.gmail.com>
Content-Language: en-US
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
In-Reply-To: <CAH5fLgjO-GbB85dDdxLSSWY74cUn8-Lt-yaRGkUVxb-E8YaO2Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/12/2024 16:27, Alice Ryhl wrote:
> 
>> +    /// Returns the base address to the allocated region and the dma handle. The caller takes
>> +    /// ownership of the returned resources.
>> +    pub fn into_parts(self) -> (usize, bindings::dma_addr_t) {
>> +        let ret = (self.cpu_addr as _, self.dma_handle);
>> +        core::mem::forget(self);
>> +        ret
>> +    }
> 
> Not only does this skip the destructor of `dma_free_attrs`. It also
> skips the destructor of fields including the `dev` field. Did you
> intend to leave the refcount on `struct device` without decrementing
> it?
> 

Good catch. Yeah dev should be decremented here as well.
Will incorporate fix into next revision.

Regards,
Abdiel


