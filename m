Return-Path: <linux-kernel+bounces-418231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E40079D5EE8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 13:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5374283183
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 12:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1703A1DE8B8;
	Fri, 22 Nov 2024 12:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hnn8X4TG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DC8171088
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 12:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732279102; cv=none; b=UiYQIe9cXCpzr2S+p6rYMR/NpwMul70H4OzwJi5Tt6LypX4h8zG+YU6hCDwVWGb5NMAcoq0+xgWKWlQHS90NMvKjE1/+Ezm2Uy5I4LrpiBDC+WW+Sxxs3o4HB5dbP/vb8vt+cWp9yem/NeN9+KYYRmS3/kQNL0U8UJpgG5/iVnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732279102; c=relaxed/simple;
	bh=z+0k8yZqi/mNxVXu1dU5o5o/DA8lTNTOMBUuV0SYUug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M8uY5+0+bK7fO12wXs/BtJJODnEMYrgHW2Fbf/PL5oj+7wet4BI39TfWlFfUTzx9AqT+/FgSFtB9XDic4mBZBaTuFrGyoyo5afnnEIi0u7SLtkaS5oxs/TrTjbX4yzIf83vOOPzByMBr9zxlV10tdQd/at5SSfVyqaas59nM57E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hnn8X4TG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732279099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=AOkxIt1AHITD8TmVq6RWJQXe+1uYkCgTbrbFwt/v6nM=;
	b=hnn8X4TGMTiwbxxwnH+uboR0TbyWrUe0FBTgRk85aETg+TE12FUve54JyN8F7Fs2pnS0uO
	IH8wp27AfRba/12fGRQhrPlC8HfooQ3wQFDBJuI0NnmuuQCYa/XKjnNNpPLsFx523SXtvE
	kWHWN8+8sm+3JkXYBXKQF21Ym6JAc0c=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-1vjowQkCOHOlolrKF40YhQ-1; Fri, 22 Nov 2024 07:38:18 -0500
X-MC-Unique: 1vjowQkCOHOlolrKF40YhQ-1
X-Mimecast-MFC-AGG-ID: 1vjowQkCOHOlolrKF40YhQ
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-382428c2564so1236749f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 04:38:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732279097; x=1732883897;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AOkxIt1AHITD8TmVq6RWJQXe+1uYkCgTbrbFwt/v6nM=;
        b=wLar3s35xrRAgc90O65nsqs0gwnGHrnu7GYzRcnhP6MRAW4YqEDtFm07q7Sd2EmOwD
         er9wGfE5FAZDmBXn8dO8ZAhg+ytKhAciSjFjk+sAnnJt8OvEPwvc5d7GhMoVkRnbsyFJ
         G6LyEcjkJBnohIy+W2kjkZcDLqYmg2alp+F15tk0+dEezU3paBGGJWo01cGcbyCZrVnk
         bagS24vDRGDLeJ0qoxRY4Rs+6fERYC38XTWWTEc37M5ibGroMqvUloubThzdhpp+fmL4
         SKU9FbCCUF4yLaOeZfH7QrTdVObqQyutSxkaq+gKFdlnqpH/FY1l6JIIFePT4RaB7MAs
         IsSg==
X-Forwarded-Encrypted: i=1; AJvYcCXXs+STPOle0GwTeOTHIHfvi/b1tG+JHGGxJE6JE2SIRW/JD+LS5m7Dj2pMtDnPWykv+dfcVY8LH63xrFE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKjWTYSlrzhD/kFIeyohAQ7I41fq8HJN5KXjhJ3Gob42t20W2C
	7d+uhobRgkI6LVeLjnjwkL0IPvUIIn55D/lgYoXUl1yomujafZnO425fxEdxZHAAeLUXlVijA9t
	/CtjFQoZjrH9nCSSk/k3wvSlHzox1s2Jo+ujTtzN+4vtfZHaYnNxCRvhdFAP23A==
X-Gm-Gg: ASbGncuwlADywHDh1/qXPAQ0V2HnfoSsHC5eenPAnxJRpXxCEV2ODNR8y1So05W5vNy
	ihm3XX0612H0gobjZbIo98Bum/v8o0iKQNGXa3X8wpjCqKfh/qyQTMCAe4AQM+igEfswGoTdmE2
	FvYcE3FuhR1YKCo9O888P26+a6zxSqlu2l6IxeMoG3N0jK/vEopJyLTeYCB5v0dbLiTtpsEGOWX
	tr9M2v0ElBbL4bERZ687TFcztp/LUgc2qishX2ke5gaHWBQPDGJBMA=
X-Received: by 2002:a05:6000:4007:b0:382:5295:b350 with SMTP id ffacd0b85a97d-38260b46ceamr2594943f8f.5.1732279097097;
        Fri, 22 Nov 2024 04:38:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGEZInS/V+C95z8kX3djBHqB5SHFPy2/nAlMRTVT5yKTTrnAME7eptwqsuW4/RdXQz74jgt5A==
X-Received: by 2002:a05:6000:4007:b0:382:5295:b350 with SMTP id ffacd0b85a97d-38260b46ceamr2594923f8f.5.1732279096712;
        Fri, 22 Nov 2024 04:38:16 -0800 (PST)
Received: from [192.168.10.28] ([151.49.204.250])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3825fbf2b29sm2283601f8f.107.2024.11.22.04.38.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 04:38:16 -0800 (PST)
Message-ID: <f5d11fd7-6909-4a9f-b041-e6e59c221e05@redhat.com>
Date: Fri, 22 Nov 2024 13:37:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] rust: page: Add support for existing struct page
 mappings
To: David Airlie <airlied@redhat.com>, Matthew Wilcox <willy@infradead.org>
Cc: Abdiel Janulgue <abdiel.janulgue@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Alice Ryhl <aliceryhl@google.com>,
 rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Wedson Almeida Filho
 <wedsonaf@gmail.com>, Valentin Obst <kernel@valentinobst.de>,
 open list <linux-kernel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
 Kairui Song <ryncsn@gmail.com>
References: <Zz4MQO79vVFhgfJZ@tardis.local>
 <Zz4WFnyTWUDPsH4m@casper.infradead.org> <Zz4boXyYpdx4q35I@tardis.local>
 <98a46b27-c4bb-4540-8f75-f176c3f2fae1@gmail.com>
 <Zz59qgqKruqnouTl@tardis.local>
 <650846e4-b6a0-472d-a14e-4357d20faadb@gmail.com>
 <Zz-FtcjNm0TVH5v9@tardis.local> <Zz-GHlkhrz35w2YN@tardis.local>
 <Zz-ts0s3jHsNP73f@casper.infradead.org>
 <0195fb77-c55a-40d5-8fe2-5844158f4f63@gmail.com>
 <Zz_dPsVZOMdkLjMA@casper.infradead.org>
 <CAMwc25pC_jU-bZEBWZB6TQKfFFJs4R+Ero1mA=X=0FBWNFeMXg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <CAMwc25pC_jU-bZEBWZB6TQKfFFJs4R+Ero1mA=X=0FBWNFeMXg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/22/24 07:58, David Airlie wrote:
> On Fri, Nov 22, 2024 at 11:24 AM Matthew Wilcox <willy@infradead.org> wrote:
>>
>> On Fri, Nov 22, 2024 at 01:18:28AM +0200, Abdiel Janulgue wrote:
>>> We need an abstraction of struct page to construct a scatterlist which is
>>> needed for an internal firmware structure. Now most of pages needed there
>>> come from vmalloc_to_page() which, unlike the current rust Page abstraction,
>>> not allocated on demand but is an existing mapping.
>>>
>>> Hope that clears things up!
>>
>> That's very helpful!  So the lifetime of the scatterllist must not
>> outlive the lifetime of the vmalloc allocation.  That means you can call
>> kmap_local_page() on the page in the scatterlist without worrying about
>> the refcount of the struct page.  BTW, you can't call page_address() on
>> vmalloc memory because vmalloc can allocate pages from HIGHMEM.  Unless
>> you're willing to disable support for 32-bit systems with highmem ...
>>
> 
> https://elixir.bootlin.com/linux/v6.11.5/source/drivers/gpu/drm/nouveau/nvkm/core/firmware.c#L266
> 
> This is the C code we want to rustify.

I don't think you want to increase/decrease the refcount there.  Instead 
you tie the lifetime of the returned page to the lifetime of the thing 
that provides the page, which would be some kind of NvkmFirmware struct.

pub enum NvkmFirmwareData {
     Ram(KBox<[PageSlice]>,
     Dma(CoherentAllocation<PageSlice>,
     Sgt(VBox<[PageSlice]>,
}

pub struct NvkmFirmware {
     ...,
     img: NvkmFirmwareData,
}

pub struct NvkmFirmwarePages<'a> {
     fw: &'a NvkmFirmware,
     sgt: SgTable,
}

impl NvkmFirmware {
     fn get_sgl(&self) -> NvkmFirmwarePages { ... }
}


Perhaps a trait that is implemented by both {K,V,KV}Vec<PageSlice> and 
{K,V,KV}Box<[PageSlice]>, like

trait ToComponentPage {
     fn to_component_page(&self, i: usize) -> &Page;
}

impl ToComponentPage for KVec<PageSlice> { // same for KBox<[PageSlice]>
     fn to_component_page(&self, i: usize) -> &Page {
         let base = &self[i << PAGE_SHIFT..];
         bindings::virt_to_page(base.as_ptr())
     }
}

impl ToComponentPage for VVec<PageSlice> { // same for VBox<[PageSlice]>
     fn to_component_page(&self, i: usize) -> &Page {
         let base = &self[i << PAGE_SHIFT..];
         bindings::vmalloc_to_page(base.as_ptr())
     }
}

?  And possibly also

trait ToComponentPageMut {
     fn to_component_page_mut(&mut self, i: usize) -> &Page;
}

which would be implemented by the Box types, but not by the Vec types 
because their data is not pinned.

Paolo


