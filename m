Return-Path: <linux-kernel+bounces-553915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE035A5908E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 11:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04A5816C326
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A27225414;
	Mon, 10 Mar 2025 10:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RZ2RO//6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47293224B01
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 09:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741600799; cv=none; b=V05ADAq0RPXSoRupYAz5r1XqJSCsjmr5d+/rpQ0Ehb8o4f9ciEhftFuACR0bS0Xgos3q+oiZYzHJS5O9llRxrbwQ31MKqlr2svQzuZVpMPWj3CFeRSX/NXFd6eSMODZ1wNGwm09sMWJ+fTYu4RHauKqlvaJ45ncxA5aj2XbdVk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741600799; c=relaxed/simple;
	bh=V/WiqkuxA4YwLXvuQpcmscx/6nwwjOByTFAnW3PVYWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H5oG2MxYsnPQ392UItA/oUjYhIzUt26me8UU5jBUCTooqTjeNs1QJjjgt4dOGCceRvBDEifGQ2gKIafDk9OHiCy8yWWMd6kU4SQs3B9TD+uOI5B7B476mqhY+YPF3ae8+9LWxGApTr2lFb2mG7GVlWH0YvgPFyEgkMhofOFApcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RZ2RO//6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741600796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AQ+pSa8sIsuU2xtscwDYe98bcGEdRUw/0m+Fk+VSrb8=;
	b=RZ2RO//6RxQogMA7wAoYUgNmZb8FWUcNzFWqnqozw8PmUg6DF8aubLv5bwDy2BczAxBt7S
	m/Dfp0LiRXTzZ5pJoWscdSGSoK0271mi1r2029jCstZIEnwDx7/o2WCeR5lTtLxM+2lwnK
	nDol/79+OfO+PTzJxCGG6Nl6Hoasuz0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-eeLPU1MWPXq5c7fDY9rvfw-1; Mon, 10 Mar 2025 05:59:55 -0400
X-MC-Unique: eeLPU1MWPXq5c7fDY9rvfw-1
X-Mimecast-MFC-AGG-ID: eeLPU1MWPXq5c7fDY9rvfw_1741600794
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-39135d31ca4so1241886f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 02:59:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741600794; x=1742205594;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AQ+pSa8sIsuU2xtscwDYe98bcGEdRUw/0m+Fk+VSrb8=;
        b=Aj7gvrsRm0k73gcMvFc0aNCV6brm853rOXjiiHaafG//LUctvrF6owAJSihqGPU4NW
         wZjub6OlOIMYkme0unqSHKEdqf2JXwFNGt8bMtXTfhg5lbCsNsj6CquE0unr4qeBQUnL
         J0MPzFKMmk4LuBcXWlZnf3dBNs2vmXPb3yOrTMH4TVRNdw0mz0Wh2Fr4lss2PSawJzd9
         nx9qcQyyJ5jAm6vewG3sImws6CiMxox0eppMQQPeg+TM360jY2s7g5qojiKUgCbjkLb+
         aowCU8GEbImz/2+4W4r3jui4zxSySEb2iOku1+neFwKNU1vnOKEjSeH0Pg4BEvZA5BrB
         HLVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLhZvSgvnLZ6EG63HFZChM2ov329x33s9qQvl6o9VJssOnr5KeDencLQWC8hz3Px4fEQdNn0rXMm1gaOU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1DEhyNpSZe85LL1kswCW2X5aoDHO6xf52n7x4vRv/k7yeAlTf
	HNlJAivnxRkgQEl2Z66gLzSLUM51RSLeGuBTTxWVCBN4WKUFvnndswq3Tw1usIrQ6GZdiZ0Npl2
	IUcPN4pJdyoFNrn+FVE4WUB/qa/rVBlJkHD76zUAyylebNhyuUgEDEtSTOxUW/g==
X-Gm-Gg: ASbGncuEG+GVDsAjoAqcJQEZYxVuIaFjmSb7PrDXgbNzliy1ppmw27DCGbK/nM0Q6Da
	1rnES9RS07YLwacH3dUOxu6HuzH5TAmseU5Ylhk5JfWEbKBYhf1DgZxqSNur6rjvKUMhpDFkxiI
	NcaRpm1qfjN5ziawdgEr6Ro9Go2cb7ofI2ql3BQcp7H/GfolhUr2vuVYJdxU1fgyRmzsfaGVYyg
	IgrwuDKvmp2XcFdTdaPES7D/hE/mEqdPvPwi5I9BzHW405XdG0FH8EVdn8++ebn9Qm794ov2rXM
	me32u64pPf73U5N9lg74/Vsr7PYoA8jNZP3bAccASfjSoYXSHEyd8SM=
X-Received: by 2002:a05:6000:184b:b0:38f:23c4:208c with SMTP id ffacd0b85a97d-3913af2e472mr5013410f8f.18.1741600793709;
        Mon, 10 Mar 2025 02:59:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGX9wDZkgqzcXWNadk7lA63fXqzI59Xv6gjXmdznaOhUQyAtcnnGk1X47jRovjSDv9uACyJBg==
X-Received: by 2002:a05:6000:184b:b0:38f:23c4:208c with SMTP id ffacd0b85a97d-3913af2e472mr5013370f8f.18.1741600793351;
        Mon, 10 Mar 2025 02:59:53 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfdfa52sm14018794f8f.21.2025.03.10.02.59.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 02:59:52 -0700 (PDT)
Message-ID: <ca830ba6-5e02-446e-87d8-4e120c357312@redhat.com>
Date: Mon, 10 Mar 2025 10:59:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/panic: clean Clippy warning
To: Miguel Ojeda <ojeda@kernel.org>, =?UTF-8?Q?Thomas_B=C3=B6hler?=
 <witcher@wiredspace.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Alex Gaynor <alex.gaynor@gmail.com>
Cc: dri-devel@lists.freedesktop.org, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, patches@lists.linux.dev
References: <20250303093242.1011790-1-ojeda@kernel.org>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20250303093242.1011790-1-ojeda@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/03/2025 10:32, Miguel Ojeda wrote:
> Clippy warns:
> 
>      error: manual implementation of an assign operation
>         --> drivers/gpu/drm/drm_panic_qr.rs:418:25
>          |
>      418 |                         self.carry = self.carry % pow;
>          |                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ help: replace it with: `self.carry %= pow`
>          |
>          = help: for further information visit https://rust-lang.github.io/rust-clippy/master/index.html#assign_op_pattern
> 
> Thus clean it up.

Applied to drm-misc-next (because dbed4a797e00 is only present in this 
branch).

Thanks for your contribution.

-- 

Jocelyn

> 
> Fixes: dbed4a797e00 ("drm/panic: Better binary encoding in QR code")
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
>   drivers/gpu/drm/drm_panic_qr.rs | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_panic_qr.rs b/drivers/gpu/drm/drm_panic_qr.rs
> index 62cb8a162483..3b0dd59781d4 100644
> --- a/drivers/gpu/drm/drm_panic_qr.rs
> +++ b/drivers/gpu/drm/drm_panic_qr.rs
> @@ -415,7 +415,7 @@ fn next(&mut self) -> Option<Self::Item> {
>                           self.carry_len -= out_len;
>                           let pow = u64::pow(10, self.carry_len as u32);
>                           let out = (self.carry / pow) as u16;
> -                        self.carry = self.carry % pow;
> +                        self.carry %= pow;
>                           Some((out, NUM_CHARS_BITS[out_len]))
>                       }
>                   }
> 
> base-commit: c0eb65494e59d9834af7cbad983629e9017b25a1


