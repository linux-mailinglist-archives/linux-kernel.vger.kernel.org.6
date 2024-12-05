Return-Path: <linux-kernel+bounces-432924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7BFD9E51E2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:15:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7824B167E3F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE411DF73A;
	Thu,  5 Dec 2024 10:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M8Ny08zT"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C009E1DF25F;
	Thu,  5 Dec 2024 10:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733393731; cv=none; b=Amtv4qppLL+x/pCdtqKmoF4eMZD49Qq3Ydyi+SFOIHJ6uZ4LL9kk+2i/40k2oxoR77G7jJkHbAowkI6MAnmgwMPKaQ7q2DdHsukw+wGDAGI8Ht44eSv8K71UW1XYt+9Ki+aDFPMAXdNTWSDE7BllYHNeu2LrLIOhN3IfZVsBX+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733393731; c=relaxed/simple;
	bh=YIH+i4hon9OeIABlByObQcoJuEqAEQRyrmg//TWxt9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=giBrfj+pew0SoZD73Mf2eIUlpGjqEHTVIXwEct+GKNQ3rSFf/TZRVdfQUo0yCqu8mz0EnWVblvIvMpzk+XyenNC4Pvua6IK3aj4vgFCSZvh5j6/dd+a9NmJhCrHX24A+zrZoPEj28x9dG4SQjUgND84PC6zl+BueTVU1iSQgMdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M8Ny08zT; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53df80eeeedso804688e87.2;
        Thu, 05 Dec 2024 02:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733393727; x=1733998527; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4Bla2k6xsSNv8Akp73rgxD6m3gZJB5hhrIHZs9PXF0E=;
        b=M8Ny08zTeuERAor2n+7yf3B/RuAYaDAcIz/Dw3MKgxSpQaF+UXoJWsVS6zQi+LAu2j
         CL8EEARiIRz9eW9AVK/eKAXzDSLxbS/fOr4FehDF1p4weoWKXwZ5t5X4ILzY6YDgW/B+
         xCxBHBwxHfD14Fii2E5WjEPIxS22+xAkoHxeU95RtU9LnkYD986Lt6B5Z9Fj3X9JTuPV
         qO4zhTQyyPFsoka6c14P3SECVu6hrvrJSb7F/LN6k35/M2CHpB+G4EBV0//29zgXMyfr
         y3Z6Ii/AMCQKui9Ml9BmjKfiNuV6jpSoS1vy7p4RvhOfdv+2vQ1kxi7YjXbE8Q+CJlfV
         W0UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733393727; x=1733998527;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Bla2k6xsSNv8Akp73rgxD6m3gZJB5hhrIHZs9PXF0E=;
        b=Dqt2egCz4ofcb4DIQY3spzxPC/srNLBKSKx/HLY+cgkaP5M6f/joNnmx8BAXU+xNdQ
         deAF8z+naD7uUINKGjhtO1R7KoA3/oAdFOP2SoEwsDKVs8GcbFPv9q2BrneU1YudNpBd
         zoAzob6wLk3qWvm0rpJ36r63PusarLIBD43+6RdX0//cinxrbeOMgbd381flje9Ja+9W
         ycdhIIiYm8PQnyObUAzq5tqKvme1c+ZfEMVVf8O+zWHtGAheFXiLs+0n9aOlWy7eAzpy
         IvkBVjdmQwh+xr3TcFccGbv/MeY9QetdLtjb3d9PPcmiaW8KcdJ7Ci14uqqh8PDnStvY
         BLCg==
X-Forwarded-Encrypted: i=1; AJvYcCXYLGtE5WRcaWcgG5p+ReJbEM3GbBEGIC7fgWf1uwhwEW+BrnIGc+PoMq1bgswP5XDkGA0a8/jdQ74qnM8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvWBzEQg5BumXsAj3sxzv5F2tUtCWmVS7WKwc5LkDQHEbLO+z/
	mpd9H11HUy+57LmK13s4JnORpHaosFVrpNo6YJkA8LoojKVAlfNJ
X-Gm-Gg: ASbGncvLuNyZ5UMbslcoagJdf+4NXFT/3RqINejOQ96qHvjmylH32ahcMHxyAggmkO8
	a6pRFSK1vS9CsQ9gM9iEPRt0tbeZgqmZ9LMt1E/LlNETB1IBw8wARvFUMeb2fU3O23smASurJ1D
	f7gvuCu/cavb0UPHth1p+9+ZvLYB4HZXGCgpl1hTl7ELqc6DnQgn0ORcte3SPzuzN/Xj68+0sE8
	5rx1KBCBADqsw5zmOpR09gccEwkaT1j13wnx1qm4CbmaxKGHsDKrHvt7NsN0MRoFf5YE91KtAsl
	2uVvw/atkJVuDLewuUSG
X-Google-Smtp-Source: AGHT+IHp7Dxl+Jd/Hyw9W2xFaZ4ccKDM4H/1DrGPwTqKtAYK+lO/In2P/+jMlCzQXYJqAI5hPFajMQ==
X-Received: by 2002:a05:6512:3ba8:b0:53d:a4f9:6141 with SMTP id 2adb3069b0e04-53e129ff45fmr3925636e87.14.1733393726909;
        Thu, 05 Dec 2024 02:15:26 -0800 (PST)
Received: from [192.168.1.146] (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e229ba814sm189644e87.120.2024.12.05.02.15.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 02:15:25 -0800 (PST)
Message-ID: <c3e1def7-0ab8-4fc3-8b37-257a29c1235f@gmail.com>
Date: Thu, 5 Dec 2024 12:15:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] rust: add dma coherent allocator abstraction.
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Wedson Almeida Filho <wedsonaf@google.com>,
 Valentin Obst <kernel@valentinobst.de>,
 open list <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, airlied@redhat.com,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
References: <20241203170752.1834271-1-abdiel.janulgue@gmail.com>
 <20241203170752.1834271-3-abdiel.janulgue@gmail.com>
 <AFCEFEB8-3FB1-44E2-A31E-93863E11BF87@collabora.com>
Content-Language: en-US
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
In-Reply-To: <AFCEFEB8-3FB1-44E2-A31E-93863E11BF87@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 04/12/2024 21:08, Daniel Almeida wrote:

>>
> 
> 
> By the way, I tested this using a slightly modified version of the sample Rust platform driver
> from Danilo’s v3 submission. It’s working as intended :)
> 
> With the change above, you can add:

Will do. Thanks for the review!

Regards,
Abdiel

> 
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> Tested-by: Daniel Almeida <daniel.almeida@collabora.com>
> 
> — Daniel
> 


