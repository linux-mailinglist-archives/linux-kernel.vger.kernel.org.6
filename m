Return-Path: <linux-kernel+bounces-519098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D47A39819
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 11:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 269813B8314
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472D5233D69;
	Tue, 18 Feb 2025 09:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GvUsczMz"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3966232792;
	Tue, 18 Feb 2025 09:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739872719; cv=none; b=bhhA78WK3XEExMTcL/zsureOgP3tTIu2XCirdeRDaN7UJ36s663Tw05tlV9LxkcoyNLzmyWlp3hz9PkK7JBGkAj1qmkhZkaShSIsQOiN3tp1L7UOx4Qg4jNTHw8YjMcWoa9DI7vaEGe6GIVOFOjhjCJbcmNX9zjK/Im5gOgCstY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739872719; c=relaxed/simple;
	bh=6cooqqHCoA6P1atL6E2YmZn6GVJWVgjv5JafkIvyAbI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a0pkbeL53ZgY2Yl/SiQFosWzRmssJQj5jyH+M/6I+CiIITalK2mDfKICg4hCbQh/LvoxzS/iytxgoFdji7tYfHuMl4KqlRrFl20YVFO9BbdNPmm1wGKQiMx+dBa03M5b6e59sueoknCksBE/NgaFckxY36vmpYKhTV+2FXYJC1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GvUsczMz; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-545fed4642aso2505587e87.0;
        Tue, 18 Feb 2025 01:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739872716; x=1740477516; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lmts2CcKs4nwISoE8RyWH4djGtBRCn0gg8bpEKNfluA=;
        b=GvUsczMzokWbBz6nDDNHcgePYCB7OpPCZXZvUyt7pQLwVQofMRPOxBt7jhbf8aSaGR
         KIOnhGPAkMSGqqor9iNYE3/Athm/WUVS56movIxXBKPWyI6MdMA7zg/pc63dAu18+wnY
         kxIat9W6wLOV0A6bZWAyFvKHTkMJsjHaqMq1BIrKYzmJI75iDZhe65CvHx5wPt7t5/RT
         3t4NaQhiWVU7IbnqFOH/SS5483lyVPuo6oXOAMBFd1yK31PjoDg26OcV9VBzVgubs7Mf
         puEGXCaFfqX5TGMhmEpSFAVpkZVQisCwUY9Qodduk2HlVDSaFstJ6wGTgU8StNfh+lxf
         MrPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739872716; x=1740477516;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lmts2CcKs4nwISoE8RyWH4djGtBRCn0gg8bpEKNfluA=;
        b=l8swpZdZzyqpSvL0nc8JmfnlPLxl9oen9go218Xp3ZqJRcOxSe+HuD4+hg/nBOSCQO
         k8GVDv9Ckl9RuFWqELDh1K3mhftBqM2XC7Geij5w3KQL4y3cpdzquo+j5NMH25bnRJO3
         mUTbUxHsaZA7H8FpsBAy2hYflnDWCgChQ4WNWj1yoTfOF4BKJXSQwPpRej3JS4Uf5c2w
         oiLpbBN3jrvT+6V+MDg+M1zAfAgy68LkMI0+HJPLpmYyb6cw77XMInQHLlOnOwOYiLMH
         6AkNvF4M04ZIzC2QkDKVVyxtEAydp0a9e8+F4rjjlnqXqU08AzYioErT9w/O1YGpxtSD
         kO3A==
X-Forwarded-Encrypted: i=1; AJvYcCXwXnaS1xDVHr/U5sJypZenTIuxqVUuqY05gZyXlDE+uPIzBqe3e4ImgE/UI0/DAH99QOlL+BJMMNJwaJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoQN66p21hl/Leg0bW00qwxolp+BVNu9QWRetYdFFe/sEQJZWn
	W1Oq3CvYYX3+gD2jykY1zWh984N02Vr6d3AAk9CY+kSUmuJXRr1M
X-Gm-Gg: ASbGncsB5UVVccjs1hlLDk8n1HDuvY+gF3Rf7Pc/Z8LpPVjVUO5EISoCjUlAOrukOFN
	MXhUmU+AWcuqkfw164CIwTxp5647SMmrYd2oqW1eybQ5LiUBSrlDRUDeBas4R80zbGBnnLKjPyc
	3IiTUg+4FlxVq6o7go+wUgmhFji0E6CJVEK4/GykFuY9NDrbT2HJJOB5cR9bSzyfhfdSHRv8mCy
	qsawz8q9RM52pa4V5Y+VUAJhRAuiaYQBXrRhk942Dr7tmr5DwU9EfU1ZH+6/0/Ed185QtgLMgzU
	3B5j9oxcohe9VJqNPP1o1RErzG4NMgVNpp4pF37EaHxYW4XFQvDetal7GTPbaQ==
X-Google-Smtp-Source: AGHT+IFSgaLtcnavys5mJwrcFVSSqID4HA2Wxm607QSTsSZJ468RX9mWtnC6yEKMzbHenx1fdpwcuA==
X-Received: by 2002:a05:6512:2398:b0:545:b89:309b with SMTP id 2adb3069b0e04-5452fe955efmr5596497e87.44.1739872715711;
        Tue, 18 Feb 2025 01:58:35 -0800 (PST)
Received: from [192.168.1.146] (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30931b895e5sm11078211fa.113.2025.02.18.01.58.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 01:58:35 -0800 (PST)
Message-ID: <2b019479-2d32-433f-af78-c3378dee4e2b@gmail.com>
Date: Tue, 18 Feb 2025 11:58:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 2/3] rust: add dma coherent allocator abstraction.
To: Robin Murphy <robin.murphy@arm.com>,
 Daniel Almeida <daniel.almeida@collabora.com>
Cc: rust-for-linux@vger.kernel.org, dakr@kernel.org, aliceryhl@google.com,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 Valentin Obst <kernel@valentinobst.de>,
 open list <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
References: <20250123104333.1340512-1-abdiel.janulgue@gmail.com>
 <20250123104333.1340512-3-abdiel.janulgue@gmail.com>
 <633274AD-E55C-4A90-AB72-33D3E176176F@collabora.com>
 <dd57c3ba-246e-414d-a9c1-eb2cff032d83@arm.com>
Content-Language: en-US
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
In-Reply-To: <dd57c3ba-246e-414d-a9c1-eb2cff032d83@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Robin,

On 17/02/2025 15:52, Robin Murphy wrote:
> FWIW we've been wanting to steer away from relying on the default mask 
> in new code, so it would be quite neat to actually enforce that 
> allocations fail if dma_coherent_mask hasn't been explicitly set 
> (assuming it's sufficiently cheap to keep a flag in the Device handle or 
> something like that - it's not the end of the world if it isn't practical).

I just had a quick look on how to possible approach this and indeed 
would refactor the Device binding a bit. If it is okay with you this 
could go in a follow-up patch? I was hoping to upstream the initial 
support first - at least with the dma_set_mask/dma_set_coherent_mask put 
in place already.

Thanks!
/Abdiel

