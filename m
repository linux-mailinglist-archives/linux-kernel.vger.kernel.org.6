Return-Path: <linux-kernel+bounces-403846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 161E39C3BAF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 11:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 982C32825C3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 10:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F801176240;
	Mon, 11 Nov 2024 10:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tvfl304a"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D996149C4D
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 10:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731319674; cv=none; b=A62RgxrFgIUjTB2uuGQicVYVtB6oEHGFfJSkNHqt6U4AxXYubaxsk3+mqdaTMgv0aBQrV3Ez+KcVftsrGcsHHkv28NvtqwiePfAym0B1mvDs/ZuoBbnKhtz6WM0zk5lY1HMi2S4R9d8kFBfvNSXPJGUn0N3LifBmvgsTDDRUajU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731319674; c=relaxed/simple;
	bh=EDylGzCINTlcMYhzXXjs1IH58DJ8JzXAdgUHQqn70ho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e3833YLVcDWJEQWHMu2HBX8aQyZKdTZXvCobjat1u2sr1vmFmJzXtJlPxb8QY+3SAQAyKszg0ao2V5t7q60ywVd8bwquJrtQEOa3DXIKppAkmzRAWYCRb3LFtHNO9Sm2Su5BFoB8uZbvGLMuQQ9vY0aFuPq/ffusIBDOTxU2DVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tvfl304a; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731319672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yezwXuy1oqB/Mlke0JXcT/QliEzB4XcNQBVIjSWzpa8=;
	b=Tvfl304azIRJQIJ9HliptWSfVvFVuULPEMjSRj/x2gEt8WM/0i+hRXEUQsVcNdL598q+Ge
	OqQs/ffLfjtsUR+pcnOdprtFvgEXFaBP1Xn3qLI3gaKFgwDV8n5XGwR0AeJIao5u/yUS9M
	tgGBWeuBK7u9CMVGwqTO57CCBt4mqHA=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-IAN4fUWaPsyRLyBOYgpatQ-1; Mon, 11 Nov 2024 05:07:50 -0500
X-MC-Unique: IAN4fUWaPsyRLyBOYgpatQ-1
X-Mimecast-MFC-AGG-ID: IAN4fUWaPsyRLyBOYgpatQ
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2e9b723c384so2774913a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 02:07:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731319669; x=1731924469;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yezwXuy1oqB/Mlke0JXcT/QliEzB4XcNQBVIjSWzpa8=;
        b=B2AFIZiii7Yh3IFYqgKTaInnVKfeZHnUP082zP0n/Sh80Opuj6A8HMOBhvI28eEhaa
         VaPqLDsG5K/FxfvLMzIWDJutlsL5nF1NBqGKYEoOXlJfkQwybDrXsAsKOISdamlpYU2Q
         9ycgdkvZ60rbMKI9ex/UcHoDeq7nta+XqfxiwVa1/DiSF+3OZThVjp9ALA2Vw46bhSSp
         ftJd223+WFDkB5Mr3qOBtKDEgVdcYSMB1bwVSpH+zbxV/NhS3sa0yDXviWGdLKJMTaCC
         4Ti2JCbJkBpkO3/OkYvSCdRqUpRNguu0Ifmh+85b3jxKJBWUnfPzzimCDZhSL34roy59
         o9jQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtCe4M2L9V0ypIauc33DEn4gAh+YKhKbMRuTB6Zpstu9R/utZjeNz+/8Ycp6ovEhV7ndk2EqRK3MS5oZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHmj9/pJtWqOSkJ41kGBwMOlJNHCwmw7tC9jckWwQpqOB0lN14
	SnMcIsZ8q2Up+9A9UROnM96bxLpcQHWyOGTgzBUB3i6EQuB31lmRxxZkbrP0P0LJZPrPve/muo7
	qAESPqed0v8fmQlD4YRoVx8BPV87o+nXPBfffJiUT0Xt4dx4X4bUjdY+7KI4OLgaR+viK7uGf
X-Received: by 2002:a17:90b:4d0f:b0:2e2:e91b:f0d3 with SMTP id 98e67ed59e1d1-2e9b17730f0mr15948436a91.29.1731319669093;
        Mon, 11 Nov 2024 02:07:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGQkNwwiHyh2arF/dEtQ9CoiCRLtC7ejiIPDEIh4JQE97bKk655Gfxfl4GXdPX+ZWkfZBB+LQ==
X-Received: by 2002:a17:90b:4d0f:b0:2e2:e91b:f0d3 with SMTP id 98e67ed59e1d1-2e9b17730f0mr15948419a91.29.1731319668715;
        Mon, 11 Nov 2024 02:07:48 -0800 (PST)
Received: from [192.168.68.55] ([180.233.125.129])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e6a06asm72304995ad.235.2024.11.11.02.07.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 02:07:48 -0800 (PST)
Message-ID: <dad7496b-265e-4910-986e-98cefea1b4d0@redhat.com>
Date: Mon, 11 Nov 2024 20:07:42 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64/mm: Change protval as 'pteval_t' in map_range()
To: Anshuman Khandual <anshuman.khandual@arm.com>,
 linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
 Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org
References: <20241111075249.609493-1-anshuman.khandual@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20241111075249.609493-1-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/11/24 5:52 PM, Anshuman Khandual wrote:
> pgprot_t has been defined as an encapsulated structure with pteval_t as its
> element. Hence it is prudent to use pteval_t as the type instead of via the
> size based u64. Besides pteval_t type might be different size later on with
> FEAT_D128.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> This applies on v6.12-rc7
> 
>   arch/arm64/kernel/pi/map_range.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


