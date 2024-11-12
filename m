Return-Path: <linux-kernel+bounces-406117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7969C5B19
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 15:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0BED1F20EE3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 14:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7481D1FF7AF;
	Tue, 12 Nov 2024 14:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GCd4O53G"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBA01FF02B
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 14:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731423240; cv=none; b=arUf8nxNC78lADqpktUvme6ivQmMrcyCVLA/IVAtzV44VDoovtuWjSIwp4QgLI7ZEPjNccgGIK3VfCB8oWIviYXmixO72U08gRPJXbZ4jL4E0Iuf3pqZLus9F7XOflYtMNP1SJ66t0BTs27ERsCX+Jq8yR6H3BNvZPrXif18geU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731423240; c=relaxed/simple;
	bh=+1s99k/cpfhrXUMw6tGfR1ym940znbGAe5FgvS18W64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JjW6DQjvIAM0KWCfdKP/+9FvaEvo9xmoxpxfpdi2dNacyuKM6zA2vTDP/SzxV5A5bkd3LvYor8OXPsU1AcwR0YBgdEdBPEeLFbRk3LGf837KHU7LejYScJRomVluPiqQK/1CgvQAJrIoHer/2s+fvG/052Ix4F1GGbNDHYoty0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GCd4O53G; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731423238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=acCkvanFndXwymDQvk++ZDK48ORpzKN0IObwAr3p1/g=;
	b=GCd4O53GUBj9rm15iPSJT45Y1E9UaMW8xbSDa0jLsoi/PdWNQG/o9IlTdkA4w6KHOx3ufZ
	a1l8yCuCWy2uDzl5Za0y6TSs5/MAoz41kQFR1kEi4SXy63bguYBR4OH20dCt1HMFXlIy4S
	7bOufgZS2AE2mIwJRNnhpE7vsYJp/QQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-edCj9r0zNeiMe9QDyjJRAg-1; Tue, 12 Nov 2024 09:53:56 -0500
X-MC-Unique: edCj9r0zNeiMe9QDyjJRAg-1
X-Mimecast-MFC-AGG-ID: edCj9r0zNeiMe9QDyjJRAg
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-37d5016d21eso3201542f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 06:53:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731423235; x=1732028035;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=acCkvanFndXwymDQvk++ZDK48ORpzKN0IObwAr3p1/g=;
        b=mU+S31pdwYF2kU70VGGb0RyqWAskb/JbuAqiBioOwqUtJJz+7WXp7/+gsb5RKJHkvn
         jCawG5fluD8Gz2IGYB8kV3VWscgpmODT1QzPgSXVu/pOJiCZsRtxTtursBfabAlqeBdN
         K5wz84I+7hchVCAJzld9tq4A1V93mep3G2ys/v5n/RKekAvNrnAXeYQibpt9ZJWaD1JZ
         FJELXaTFbRVw94yB5DdHmBuuAcMkzWzJLwYU67ZvkvbDnFQVfjhg12NipL1RKVT74QJn
         028eqpvk1HUU4IrSp/5C/u0z+kTlu/Pyu2SGNED+rpbKK3hEeCo6FXqyUS5Vrg0jZEUX
         In2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXUln7GRVAUN/Cu9zc3EC/uy7vC1yrYBhDp3eHeSUatH+Flg5njN8g+gaphE9YgCSd9St0HjpJnIPSdQ6w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7qrSpUlYOUJUcOqPeMz3Z4LWmQNJ8ixjysZLfnntYvLYxDU1L
	H98Ecc0rwpkjUrj+ERV3ay+xUOtrQ1mdwaWO2t4bsJxGYVfDyb8NFCS5j2imt7mVT9uGUQVTSCo
	YaMdE9zVEx1K+3r7lOEVXnhpHOAx9d5qlyN1qh7dkdu2c6XgEFjFMvL7S6kVPxg==
X-Received: by 2002:a05:6000:784:b0:382:5af:e993 with SMTP id ffacd0b85a97d-38205afeb31mr3841226f8f.54.1731423234966;
        Tue, 12 Nov 2024 06:53:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFtZhLSNxDQ330wk1X6o5Zhnsxn8meeNjI4ffNFCGQ8jMMzhFDEiHneaBiWtayvUMENa6Zjtg==
X-Received: by 2002:a05:6000:784:b0:382:5af:e993 with SMTP id ffacd0b85a97d-38205afeb31mr3841204f8f.54.1731423234601;
        Tue, 12 Nov 2024 06:53:54 -0800 (PST)
Received: from ?IPV6:2003:cb:c739:8e00:7a46:1b8c:8b13:d3d? (p200300cbc7398e007a461b8c8b130d3d.dip0.t-ipconnect.de. [2003:cb:c739:8e00:7a46:1b8c:8b13:d3d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed970f68sm15719198f8f.11.2024.11.12.06.53.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 06:53:53 -0800 (PST)
Message-ID: <4eac810c-60e5-409d-a4a3-452461ace9bb@redhat.com>
Date: Tue, 12 Nov 2024 15:53:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/8] binder: concurrent page installation
To: Carlos Llamas <cmllamas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
 Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
 Joel Fernandes <joel@joelfernandes.org>,
 Christian Brauner <brauner@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, linux-kernel@vger.kernel.org,
 kernel-team@android.com, Barry Song <v-songbaohua@oppo.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>
References: <20241108191057.3288442-1-cmllamas@google.com>
 <20241108191057.3288442-3-cmllamas@google.com>
 <b0949317-9be5-49e4-9390-2ff1ca1b1ed9@redhat.com>
 <ZzNpe34A7Q4pTrpj@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZzNpe34A7Q4pTrpj@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.11.24 15:43, Carlos Llamas wrote:
> On Tue, Nov 12, 2024 at 12:10:20PM +0100, David Hildenbrand wrote:
>> On 08.11.24 20:10, Carlos Llamas wrote:
>>> +	ret = vm_insert_page(vma, addr, page);
>>> +	switch (ret) {
>>> +	case -EBUSY:
>>> +		/*
>>> +		 * EBUSY is ok. Someone installed the pte first but the
>>> +		 * lru_page->page_ptr has not been updated yet. Discard
>>> +		 * our page and look up the one already installed.
>>> +		 */
>>> +		ret = 0;
>>> +		__free_page(page);
>>> +		npages = get_user_pages_remote(alloc->mm, addr, 1, 0, &page, NULL);
>>
>> This will trigger a page fault if we don't find what we expect (are races
>> with e.g., MADV_DONTNEED possible?), is that really desired or not a
>> problem?
> 
> This is fine. As of now, binder blocks its page faults:
> 
> 	static vm_fault_t binder_vm_fault(struct vm_fault *vmf)
> 	{
> 		return VM_FAULT_SIGBUS;
> 	}
> 
> If we race with something like MADV_DONTNEED then we would just
> propagate the -EFAULT error. I could add FOLL_NOFAULT to the gup remote
> call to make it evident we don't care though.

Might make it clearer ... or at least adding a comment how this is 
supposed to work. :)

-- 
Cheers,

David / dhildenb


