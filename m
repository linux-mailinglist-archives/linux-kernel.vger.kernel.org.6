Return-Path: <linux-kernel+bounces-220206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 146E390DE0D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 23:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C09941F249E3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 21:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A14A13BC30;
	Tue, 18 Jun 2024 21:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h2nG7ESl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1AC14D6FC
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 21:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718745338; cv=none; b=rcUAuTRKemnG3ydmEl/x/QmIWuNyEL+H8qB8iiIruh8OZbGU9QufKwCn83PRzv6twnVhla+PP47QdOrQXsMtWEoH7FGEbYYz9GH6O6ncgl0cesWMY8YaSCpH7HwHLRa9HpUp/9XtiD2F93r+2weXlePJb++tYK1n3/RMEFl5i00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718745338; c=relaxed/simple;
	bh=sf4Kk8xdQqZve48iGjYcOf7KxledJ7m6ar/8nEH3AHA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kjoz7RHNgnnGmyp/GIHwcmedT77fCjC4JDfzebxpPgg2goapk/6Zo5UccDNd/zYdUL8+DbDKMOki8sA00UGAEVNKIbAlornjoF/nPW+UZ7J0ConIhEQaYWdkYliN78kYACz7oztF438scxCBdVMzDqBoKISmFSrl0a/lhDQYbDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h2nG7ESl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718745336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=96nBoDElHbTtsoCtF5N08Hdwjkz7BYhf+kPf44yoMq8=;
	b=h2nG7ESlqTSdZoAf8sTL8LCJ2N3ewGGbsnXupktCssENx1Qxp4xd9PGHKjUJchmKqfcJXH
	bzD+spesbMC4WIrGmKcAql+9Q7lMMotzRrJUus006Fr6ZeG3OQ7GOPLr2TkunwVcExlT2m
	Qub6DYt/tdDcIDY7la5mtpy+dNcwmAQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-115-s3sOmFj5O5GwlcDCoqr4gQ-1; Tue, 18 Jun 2024 17:15:34 -0400
X-MC-Unique: s3sOmFj5O5GwlcDCoqr4gQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4217f941ca8so38372965e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 14:15:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718745333; x=1719350133;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=96nBoDElHbTtsoCtF5N08Hdwjkz7BYhf+kPf44yoMq8=;
        b=Ij4etr4JtIb+bNV4mc/rFTRTEQuCCoRzz9weIuitRKx5TBhIw3ATcpaE8SGNFvN7pY
         CYkxcJU8Q46q7MVL4uPzWJDoNWF8NLB9O0g7TN526b4o/1hGRqOsvBunoyrxhTsrQRpl
         5UMQoSreuzLqKcWZW5TSbjTRTEVfaACXJH2gOoW02c/WUZub9T7rwibhSDFLks7yOoiB
         meCPs+crY4krDCye7LVJ5ToK6vwBP6f8o2sl4190XulU4J2oZRdLswVhLTRVypz7PouG
         CiAdAyZimZ8+eHa+F0LuI9UHf2KJjLK0djBDEl7HjEkMR3KNaFIA903N5Y6F/IQfRaZa
         tVng==
X-Forwarded-Encrypted: i=1; AJvYcCXywttxSJ0abfqiuWOPqBDsUMO0b4Y+iVIAEz4YSZ7EoQqIURvxgF1eqeV53b6yhPOI7oKywCA/PMN6waBxAfwSzrMiLBz2Jny+f4cq
X-Gm-Message-State: AOJu0YzMYgZAVvGrvChOPvs3wr9GEWPEaa+OwtoL7QGIIpSUGFaBuo33
	LIoz++hQrPIqc+hEkK6/72I9l3s7k+4llnLYYOH1pNfrPo8pR3H9eTLHt8HFsvKVZAzvfZ/x/u7
	djY+ylDHprwn0eMmKhe28rM2BN819qqyiInQOltaifXmat8AAD8MSAaDxwoxO3w==
X-Received: by 2002:a05:600c:214c:b0:422:6e65:a4bb with SMTP id 5b1f17b1804b1-4247507a10cmr3164135e9.5.1718745333712;
        Tue, 18 Jun 2024 14:15:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmkvm6Wpg+T20KkbVracoP2lwhqgErIro0Zt5eKTCJ6OBKJ/cZuGS4YIJx2hS2d1tS9Nt4pQ==
X-Received: by 2002:a05:600c:214c:b0:422:6e65:a4bb with SMTP id 5b1f17b1804b1-4247507a10cmr3163985e9.5.1718745333366;
        Tue, 18 Jun 2024 14:15:33 -0700 (PDT)
Received: from ?IPV6:2a02:810d:4b3f:ee94:abf:b8ff:feee:998b? ([2a02:810d:4b3f:ee94:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42286fe91f7sm239240225e9.16.2024.06.18.14.15.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 14:15:32 -0700 (PDT)
Message-ID: <175e7744-1234-44c0-b031-24ac42524b44@redhat.com>
Date: Tue, 18 Jun 2024 23:15:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] rust: add firmware abstractions
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, russ.weight@linux.dev,
 ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
 boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 benno.lossin@proton.me, a.hindborg@samsung.com, aliceryhl@google.com,
 airlied@gmail.com, fujita.tomonori@gmail.com, pstanner@redhat.com,
 ajanulgu@redhat.com, lyude@redhat.com, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240617203010.101452-1-dakr@redhat.com>
 <20240617203010.101452-3-dakr@redhat.com>
 <ZnHkQpyiX4UKdLEt@bombadil.infradead.org>
Content-Language: en-US
From: Danilo Krummrich <dakr@redhat.com>
Organization: RedHat
In-Reply-To: <ZnHkQpyiX4UKdLEt@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Luis,

On 6/18/24 21:47, Luis Chamberlain wrote:
> On Mon, Jun 17, 2024 at 10:29:41PM +0200, Danilo Krummrich wrote:
>> Add an abstraction around the kernels firmware API to request firmware
>> images. The abstraction provides functions to access the firmware's size
>> and backing buffer.
>>
>> The firmware is released once the abstraction instance is dropped.
>>
>> Signed-off-by: Danilo Krummrich <dakr@redhat.com>
> 
> I don't speak Rust, so if we're gonna add this, I'd just ask you also
> become a firmware loader maintainer, willing to spend time to help
> review both C and Rust code. Is that too much to ask?

That is fine, I'm happy to help out. I think Greg applied the patch already.
But I can send a separate one adding the corresponding entry later on.

- Danilo

> 
>    Luis
> 


