Return-Path: <linux-kernel+bounces-192480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D70DC8D1DC5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 15:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D24B1F229F8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 13:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4838F16F293;
	Tue, 28 May 2024 13:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VMHF84Sz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346FB1DFEB
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 13:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716904723; cv=none; b=IQh500SNgJVdbQ39CC2/OWXx0FWwN4NwSb7O1PitQtXXm78oAF+teHNhYslsO2i/q0dPlkne6hCePQwtmsMsExaEJeMHJ20t9zM96vpxJzjpmBPvA+rxCvbjmlxhxBqAutql1aPMcD2ojdleq1FN4xCfhlcoI9h79rK0R6+lP+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716904723; c=relaxed/simple;
	bh=TKnCfkAVaoR5k11Y8L0f97Y9/r4L5dww9OcYJvQwv/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GDkLd+ZLR76ymBgkB1cJXyNyxUeAhDaAvKmqkcWElitzak7KMFxcJjzf+Pg7OKaJ5X5U+6+hC5TgVnYcbaqz9cyCfF2OSE4xIEJb059MxcrD3DxFgp+Kz4Qu/B3nkPuJORGB469/T9lUweTtTymyTh9xRYDsy92gQs0XSpHirRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VMHF84Sz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716904721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=54PHYlJ0PDEnDWhop/PaR+jnOIH2PsxLKNR7Lww/RKs=;
	b=VMHF84Szi7wSXjM9HU8RbBOhYLezt1AQtx5BkQ38lg+9tMI2fQJDpZ1faS/U8TqgKB35LY
	qbQbdgysOkeKafhStWvk8/qYtxNGrPy4Fw7jSI2Lil3pPLFC6B4oGjz4/uYY1kiSTQz9n9
	q+YXEGW4RINCI3HAkgfJZFUjwY/j55s=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-cwxxvzqoO5WZBMPCIuKVyA-1; Tue, 28 May 2024 09:58:39 -0400
X-MC-Unique: cwxxvzqoO5WZBMPCIuKVyA-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a635b551919so9999466b.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 06:58:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716904718; x=1717509518;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=54PHYlJ0PDEnDWhop/PaR+jnOIH2PsxLKNR7Lww/RKs=;
        b=jdALEGmi8IrU5AGV5ZvLj/s+rQTzQCADq3foaYCy9j/gxgC2SgR8gMQXROxTY2nl1m
         CCerM/y0ud7nN+VVocKPGTz3/1WJ5++mXx5TimQCHubzwjlSYmbVO6aNSVWA1LhnsBeb
         wkJwV5N6qFt0axcBjpYvh0P/43G5uPCrhLacHUJHNcRFDEjhmTgjmuSgKQkeBWKMCLJj
         vkDSBlm3mePGNuEtEZutCSdkIRqHSsbMupPvUAul1w7Aob6yGIdSqLf4suFtbH93/Dv2
         zk/bbsAPE6EiSfi4FUkDQjMym/KFnJzlBPf+EyfYN+t7aOkbCV87YsScb71ww1/dQZN1
         YNog==
X-Forwarded-Encrypted: i=1; AJvYcCXJh43C0gjEK5Q1p1KWTPzcdYASaRUed4GwAPJDcu/3FYoi8af1Lij5zSeEfSbnr85ENaK3sMEesu0K9ZyJwDTla1BExXSHg1kNEzUe
X-Gm-Message-State: AOJu0Yz4mwvvKgbGUHvsZ0n83g32wmY5OZwYtas2Lo5Pn88mgIQqZk1e
	9D8DJdVQVFdxVGX7QNIrV9b+6V/oDunlUovkiGLdB14UNSM1bV0JLc5nzypzovol3v8X4ZUvlL7
	Wn3l8yCuvcYcth8fPM6bcIBavnY7++cOWIe9I4JlXL5H5HXl8ePpRCj3YaNooLA==
X-Received: by 2002:a17:906:bc42:b0:a62:3c94:3bd2 with SMTP id a640c23a62f3a-a6265011270mr904384566b.73.1716904718483;
        Tue, 28 May 2024 06:58:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQIR74emKom8ATw+snuAUy13d6llophtQiniGptcCuWj8oFnstnUM6NEvnixIbkTAxpA1/sA==
X-Received: by 2002:a17:906:bc42:b0:a62:3c94:3bd2 with SMTP id a640c23a62f3a-a6265011270mr904382466b.73.1716904718020;
        Tue, 28 May 2024 06:58:38 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f28:4600:d3a7:6c26:54cf:e01e? (p200300d82f284600d3a76c2654cfe01e.dip0.t-ipconnect.de. [2003:d8:2f28:4600:d3a7:6c26:54cf:e01e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626c818362sm617978566b.34.2024.05.28.06.58.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 May 2024 06:58:37 -0700 (PDT)
Message-ID: <93ee4e04-bdc7-4ac6-b93b-b6cf1b3311af@redhat.com>
Date: Tue, 28 May 2024 15:58:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] udmabuf: add CONFIG_MMU dependency
To: Arnd Bergmann <arnd@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Dave Airlie <airlied@redhat.com>, Vivek Kasireddy
 <vivek.kasireddy@intel.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org
References: <20240528133138.2237237-1-arnd@kernel.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
In-Reply-To: <20240528133138.2237237-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 28.05.24 um 15:31 schrieb Arnd Bergmann:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> There is no !CONFIG_MMU version of vmf_insert_pfn():
> 
> arm-linux-gnueabi-ld: drivers/dma-buf/udmabuf.o: in function `udmabuf_vm_fault':
> udmabuf.c:(.text+0xaa): undefined reference to `vmf_insert_pfn'
> 
> Fixes: f7254e043ff1 ("udmabuf: use vmf_insert_pfn and VM_PFNMAP for handling mmap")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/dma-buf/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/dma-buf/Kconfig b/drivers/dma-buf/Kconfig
> index e4dc53a36428..b46eb8a552d7 100644
> --- a/drivers/dma-buf/Kconfig
> +++ b/drivers/dma-buf/Kconfig
> @@ -35,6 +35,7 @@ config UDMABUF
>   	default n
>   	depends on DMA_SHARED_BUFFER
>   	depends on MEMFD_CREATE || COMPILE_TEST
> +	depends on MMU
>   	help
>   	  A driver to let userspace turn memfd regions into dma-bufs.
>   	  Qemu can use this to create host dmabufs for guest framebuffers.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb


