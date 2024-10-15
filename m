Return-Path: <linux-kernel+bounces-365276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CAD99DFC4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 09:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86F7B283165
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 07:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80DB1AB6D4;
	Tue, 15 Oct 2024 07:53:58 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E70B1AB6FC
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 07:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728978838; cv=none; b=ZmLMPRQBKTkRVJ6XPHGE/YJr13Drx/diWIKm/KNdA/fa33ugX11YPpXQeX3HogI+GoWFy+orCdtdsskaFi5IMKSyYxPdSRQvYF6ANnsBgBWIaH14Z2fFCglGO7/yblq/u4sbxQk3L4qbmdRDRUGQJm2DIU2/9tOFYSUEquqrAIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728978838; c=relaxed/simple;
	bh=ZcfKFozj5A0/57/WhbKZy9Yr1dFkdha+raCdvCwqvlQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gba/oI5wriXsVVN9K6ewOK3oz5vvx6X9+RKgv5ivkbjExEMiA1gP51ud+AiTvmiq3+GnmmHEfGeeWT5/MyHU2CUErjNEZKBSXhHiZpju91CgWKH9vrTy3KD+B5F057jKEK1b/CFXuW7I9MrndfyYx7XJ+F3Lz2+y3shDIfZIJOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43117ed8adbso56399425e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 00:53:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728978835; x=1729583635;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g47IJH+hI8mbv7kdof2gb9NW6g0mhepAa9tayvwmab4=;
        b=JiEgBfidPoesrGTe1Y4AgyMJESNjAedc+Vbo1zsiZXjokptrf4f6FYfEM8pabyfMQb
         Wdwfs0aUnXxDeGyTtZO3xaDaZ4FqppWLwdv07A57Y5TLsTcyFHv4v2fKcaOlgU/oWM62
         NiLJv9dcuHUmTvoi7o5s3h/INeSz/M0RZhQ317ttGGSX+tAStxRKWxxMkWLcAmRHSHdK
         rz7/Ua360l8XM6mlLu+PDsSW2ang965MQbpOQra8wEjqjW9AGOdIwmq8DRw9f9kKk+wX
         DbcFp9po5VAQBWmd4Aw/dxT7gjjoAmMiS3a7g8cV/y+e7T4Oyl+ImONB0EBl0bBFQ2eU
         olOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfRujHhSEUzyX7A1qTFZxSwfQR6wi7c9wBx84na3rKRNVVy0D6LF2cDFIIGNFg2Um6lnxduYVhr2j4lyk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIu0hGsDL9lXi72oOQ8eiLGvu9Jd7kzyZCUZU9prhqO0AXxYD9
	yLD0vIsZtRyWdqTE+1OZrFBMsi6xU6jfuMTwNMJqjUMGqQFdH7idYR/Fcfh9
X-Google-Smtp-Source: AGHT+IE7d+FSqaYVMVikGRfA2dLi+0C9qws7r2pkpI2NEMncGJlXR6cfbFoa4gCeEvL3RwSP02liVw==
X-Received: by 2002:a05:600c:444f:b0:42c:b62c:9f0d with SMTP id 5b1f17b1804b1-431255e03d0mr134337875e9.17.1728978834859;
        Tue, 15 Oct 2024 00:53:54 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4313f56a5eesm9796315e9.19.2024.10.15.00.53.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 00:53:53 -0700 (PDT)
Message-ID: <7f723486-237f-47d2-b9c1-e5312876dfb5@kernel.org>
Date: Tue, 15 Oct 2024 09:53:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kfifo: don't include dma-mapping.h in kfifo.h
To: Christoph Hellwig <hch@lst.de>
Cc: stefani@seibold.net, jassisinghbrar@gmail.com,
 linux-kernel@vger.kernel.org
References: <20241014144643.51917-1-hch@lst.de>
 <2861f304-c8d9-4e56-8a91-9ddf6d7b05a5@kernel.org>
 <20241015074043.GB24501@lst.de>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20241015074043.GB24501@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15. 10. 24, 9:40, Christoph Hellwig wrote:
> On Tue, Oct 15, 2024 at 09:38:24AM +0200, Jiri Slaby wrote:
>> On 14. 10. 24, 16:46, Christoph Hellwig wrote:
>>> Nothing in kfifo.h needs dma-mapping.h.  Drop the include to
>>> reduce include bloat.
>>
>> Except DMA_MAPPING_ERROR.
> 
> DMA_MAPPING_ERROR is never used by kfifo.h itself.  It is used
> by user of the header that instanciate one of the macros that use
> it.

Well, I don't understand. Looking at:
#define kfifo_dma_in_prepare(fifo, sgl, nents, len) \
         kfifo_dma_in_prepare_mapped(fifo, sgl, nents, len, 
DMA_MAPPING_ERROR)

You'd have to include dma-mapping.h if you used this macro. Even though 
you do not explicitly use any other def from the dma header.

I know one will very likely include dma-mapping.h when using the macro. 
But that might not be a rule.

>> The header should stay self-contained.
> 
> It does with this patch.  You can include it as the only header
> in a source file and will work fine.  I've actually tried that.

Well, this is not a definition of self-containment. If you use every 
macro from a header and it does not need any other include, then it is 
self-contained.

-- 
js
suse labs


