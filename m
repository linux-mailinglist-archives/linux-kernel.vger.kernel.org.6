Return-Path: <linux-kernel+bounces-363981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C9999C943
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 13:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1237E1C21E99
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322E719E802;
	Mon, 14 Oct 2024 11:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CTKnMC0Z"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58EF619CD0B
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 11:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728906372; cv=none; b=C9cmsPwOl2EVw8sHx7x+MGJ6Od7oV5p4qJ/l7mZG01u37/xyMagrZxkxnXFRGywD7KeYt/TorfE0T5OWSmrTkohmarTKHoz80UKAA0NJ2cNmRlsLVVfOmrHALkfdDhql6ZFFIBPKD9z4AyOQNjZMousSrsIgB2gw+W6YE7zIEe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728906372; c=relaxed/simple;
	bh=nQs+cqM/TaBXPVSYcyMlhgYXouder6o3cNlvdrgf1vw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uD+2dlJGB5V0fP/MmTrVfq+4+qnhv9soW4LLNbImysmIHB0Z6NIWK7berKN4wVsu5/hmWrBGUD+Tr6VUxY9JZyGEkS+mg8dm0gPzJPmLD4sXEJXtxOeyeezaIsE1L7+/NQ3kWJKpFtJAuTi/vgTz8zn8F3dHXdaIXhHQKtOOqW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CTKnMC0Z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728906369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=gBjYzcRVvT12PEuEEui9pwXMfmtmAfZKGIhfMKjJ2K4=;
	b=CTKnMC0Z2bohhGUASi7wxzZLrUvxwku8+1do5QPWwmwM9IWhfXre5d8z8lDidf9zyHvChE
	VHQcuOjTQNGjK2haLWmU0DMpaJj8Va4eqdmKzRVAgRj7+7taR78vNBNOYIW/k1j9sWKS00
	6xDLrwY6kX7J75lq/qQvqWVaKLB8nfE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-dtfg7gApMMm9jUEl5lbWYQ-1; Mon, 14 Oct 2024 07:46:08 -0400
X-MC-Unique: dtfg7gApMMm9jUEl5lbWYQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-37d4cf04bcfso1366476f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 04:46:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728906367; x=1729511167;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gBjYzcRVvT12PEuEEui9pwXMfmtmAfZKGIhfMKjJ2K4=;
        b=XNEpw9uHAIGz+/3EeVl5Tnr9IsiNeOV+b5b8Viru5JbUJ1uqv3lfONXs0oV+k5aWfs
         dtFyRPdWe1tJZbSnFZIQwmQZEQ13U2HrnhwUbqcTj5cc096vB0HuzvCNc3JaTahAfQOO
         5oQnNdjUldXuR4lJcfd5u1Zbs8E+S7lrEMSalmVmFJxCMqsJgNzDyxxB99hDn6MAUYfK
         jYFXgD8kwS1QuiD1dVjisCisOmDyD+NvghBbzWZOHMW497Jbxdh4xKkfwi6gRXBJdGcT
         igW2VvUxjqAUY503qcST0C27AHUY9AG+p/hEpYirdHYEBRVSCmbd0rc1+h6d5cbZ7Jbl
         dNgg==
X-Forwarded-Encrypted: i=1; AJvYcCVKEyub02fU3FUulETAsyfsuCkg1BRBPMZ/aIl3i3R9newO/lPGvF08efxPhNGCgZcJv0Vlstllh4KtFkk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMaAp0djmJ5PlME+nAfSsPEUXlh8++e1rHdwqJCW9ooOpdPlOX
	7DYsxps64hBHOE0VPvLN/cWnpr6ePVhdv6xMg37TtjMQ9UNijFecDnU5eGlxdCD3UCQzHBLCdUJ
	wpskztGpgjy0hOYXpdDlKkYeuNYnfUPp4P6veno1ISga5LR8Vl8w0G44lC971pA==
X-Received: by 2002:a5d:4bc7:0:b0:37d:5257:41bd with SMTP id ffacd0b85a97d-37d5fe9563bmr5646863f8f.3.1728906366818;
        Mon, 14 Oct 2024 04:46:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGy4+eK7AI1hvF0chp44blw4HV74w/vDgNn4hR29csqzaMxakWWq4fE61CpHPmk22Wnjjh4wA==
X-Received: by 2002:a5d:4bc7:0:b0:37d:5257:41bd with SMTP id ffacd0b85a97d-37d5fe9563bmr5646848f8f.3.1728906366399;
        Mon, 14 Oct 2024 04:46:06 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b79f9a9sm11208067f8f.74.2024.10.14.04.46.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 04:46:05 -0700 (PDT)
Message-ID: <38b5649b-0e4b-460c-8097-04c530fbfa46@redhat.com>
Date: Mon, 14 Oct 2024 13:46:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kaslr: rename physmem_end and PHYSMEM_END to
 direct_map_physmem_end
To: John Hubbard <jhubbard@nvidia.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
 Alistair Popple <apopple@nvidia.com>, Jordan Niethe <jniethe@nvidia.com>,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org, linux-mm@kvack.org,
 LKML <linux-kernel@vger.kernel.org>
References: <20241009025024.89813-1-jhubbard@nvidia.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20241009025024.89813-1-jhubbard@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09.10.24 04:50, John Hubbard wrote:
> For clarity. It's increasingly hard to reason about the code, when KASLR
> is moving around the boundaries. In this case where KASLR is randomizing
> the location of the kernel image within physical memory, the maximum
> number of address bits for physical memory has not changed.
> 
> What has changed is the ending address of memory that is allowed to be
> directly mapped by the kernel.
> 
> Let's name the variable, and the associated macro accordingly.
> 
> Also, enhance the comment above the direct_map_physmem_end definition,
> to further clarify how this all works.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Alistair Popple <apopple@nvidia.com>
> Cc: Jordan Niethe <jniethe@nvidia.com>
> Cc: David Hildenbrand <david@redhat.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
> 
> David Hildenbrand, I recall you had an unanswered question in this
> vicinity [1] when tglx's recent kaslr fix was being reviewed. Maybe this
> will help with that.

Yes, that makes it clearer for me, thanks

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


