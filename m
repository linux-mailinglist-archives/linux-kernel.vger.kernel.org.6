Return-Path: <linux-kernel+bounces-447189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E63DA9F2EA8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 11:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30F00165E41
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 10:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0602203D7F;
	Mon, 16 Dec 2024 10:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DLm+FoYv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B9B203D6B
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 10:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734346786; cv=none; b=EA42VLJnOEODd6PypIPn8nvcnLELf7FDgPkZ2G8C8YA3KSfm8qNpsKz/LXFAFiLFs70ybD+KOJ91zXdRqmP5iH3zCMK2ySNeETxBd1VUiKwpZr5RqStMv22E0YW/LGIiDz+kt32WhoIx9xoWPmOV0wH0ICTwm9uKBL8Hc9woxls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734346786; c=relaxed/simple;
	bh=yBvmuJHxGdYp+tJhvPZmdOYEwYg1/CT90/9AHFL64TU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YFbyDRjgY2PHKU8dBEy+ntHgCvvPnMjPosohKyehgHrbBN39AO9BCOL1jzEkTuQEnVqEx25+kZAu9VOSXQlIAEtAjXYw/IAjpSikgha8ptwzM73BrPkRuTfhVUqBHUVfBsAl/EDTaqvIau1SRu2Givk9HUiT2Agp5Ywa5zQ6zVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DLm+FoYv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734346783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ET+4LC1lRpSQI5oDJVEZ6zfASp/veSaGbCbuwxEhMK4=;
	b=DLm+FoYvWzQyg8rukEc0GPfNaM8PgcvL6/2aI5LEy71rXE2tuAoV4BopJCirzAXlHZmt82
	Ec6x+UyRSfpNLr6AMeBXFXAaqyXGHOtuKdxco4eWUQThu7OqwfbPmWI3QajoEY32qTxZN7
	geKWJW/0X8VT8k7SXn45Seyorr66LdM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-M9R-SMbjPx-a6xwBFyyZlA-1; Mon, 16 Dec 2024 05:59:41 -0500
X-MC-Unique: M9R-SMbjPx-a6xwBFyyZlA-1
X-Mimecast-MFC-AGG-ID: M9R-SMbjPx-a6xwBFyyZlA
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43621907030so36872135e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 02:59:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734346780; x=1734951580;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ET+4LC1lRpSQI5oDJVEZ6zfASp/veSaGbCbuwxEhMK4=;
        b=d7/S4f7+OQAUNX0CNGjWYmjSxjvecJCP0hgWw8LDHWbO3gc/9EFuB5BZZULMUZ+Ho5
         jMzWPO8M2NPkhwUilVl382VraOsgrFTgKy2eqi3IJ3lrLPTQBQimhnR41+Mi/xnoyFEh
         RRoNcyu6+I3MFEHID3d1XR07CU3IhmlsuWm/dV+rk+tFU24vrmaB3p8N25XjOZ3jdD6f
         hWIYi7IW56D3Lmkt4sXFjh8qRC9hVpKG9rkuPFwT8zWjT/r1dyLAozRq+ltPWK7/cOrv
         8UV9zeEaxCpWrvNuHeASR4+CN7c/I2dXx2tdjAfedsnyntV/8AN2TJy6KjkHTc1CYsFF
         TD0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWfCKoUCur1HbePdeLNEzguXIiygGaQlWo7CXkdR40lSzQmvgFTjBDhpLAHpTMSZ24Qbf4NhFvNPaEjlu4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhAPZJ1LP7Bh7QqPnHXI/Ca8m3HPYmyXcDkHqV1hAVZ9VDhNTx
	iSlepMDwfIP3CiEtTMA+zAOiTdnk8km89Pl/j/QtBIya9n5gM68snFThsmNPlQ7EdgIwPAeVHxT
	z6sjZp41pXr3haNfwUy9XhuHhoro46uT7e73ET7BuxeCTZvytQCeLjVAJht8NLw==
X-Gm-Gg: ASbGncsODVxnyZytwDkKA3MzHwMxM0bZS6mq4/1Z5GAfpGtj7FToGcWNUzeqZ2ujzoy
	RdWMsztaE4xIEMjELIOPx6ubxmeGWhJr+eTnSS4gCimXIdDnpO0Vfs/q/HVYQ+aX95bTj8y2Hxc
	I8zQsZe+SyVwzKhhT/Q5Zs3UXqNgMAo6oDXmHMQzcgS2Bqaj8kf8FZ1L7RH0fnx79+F9TR5oQIa
	6sS2WnU/4oBlQj5MFEOHkMlU4dcoLECMndsMAQlt0q8jXHul6H18TJTc35Q4XxKwjRR37M/mLSV
	eDt4kssXQpISqShfY/Cn
X-Received: by 2002:a05:600c:cc7:b0:434:f4fa:83c4 with SMTP id 5b1f17b1804b1-4362aaa65a2mr110051525e9.29.1734346780598;
        Mon, 16 Dec 2024 02:59:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH12tSjpOPD1I6PvmmOZpZWL6gGgB/dyLypyfBTtOlnHeU0szVqDhIq83EhWOUlppYtGSt7CQ==
X-Received: by 2002:a05:600c:cc7:b0:434:f4fa:83c4 with SMTP id 5b1f17b1804b1-4362aaa65a2mr110051295e9.29.1734346780239;
        Mon, 16 Dec 2024 02:59:40 -0800 (PST)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4362527ecc3sm139852465e9.0.2024.12.16.02.59.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2024 02:59:39 -0800 (PST)
Message-ID: <06f34e34-116d-48de-88f2-c029877f41e8@redhat.com>
Date: Mon, 16 Dec 2024 11:59:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: build failure after merge of the rust tree
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20241216162512.064724b9@canb.auug.org.au>
 <CANiq72kv-bjeHtnom2xLqMD92xfogd1hm6yFGg16wpqjhJWMGw@mail.gmail.com>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <CANiq72kv-bjeHtnom2xLqMD92xfogd1hm6yFGg16wpqjhJWMGw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 16/12/2024 11:31, Miguel Ojeda wrote:
> On Mon, Dec 16, 2024 at 6:25 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>
>> After merging the rust tree, today's linux-next build (x86_64
>> allmodconfig) failed like this:
> 
> Apologies, fixed now, thanks!
> 
> Jocelyn: we are performing the remapping via the new `ffi` crate in
> this cycle. I had to add a change to `drm_panic_qr.rs` to take
> `c_char` instead of `i8` in `drm_panic_qr_generate`, so that types
> match both before and after the remapping. I think this signature
> would have been better anyway, but please let me know if you disagree!
> 
>      https://github.com/Rust-for-Linux/linux/commit/e1157aee5f038c2c91af269cd48653133e99f3fb
> 
> (Diff copied below too)

Yes, I'm fine with that change, thanks for the fix!

Best regards,

-- 

Jocelyn

> 
> Thanks!
> 
> Cheers,
> Miguel
> 
> [1]
> 
> diff --git a/drivers/gpu/drm/drm_panic_qr.rs b/drivers/gpu/drm/drm_panic_qr.rs
> index ef2d490965ba..bcf248f69252 100644
> --- a/drivers/gpu/drm/drm_panic_qr.rs
> +++ b/drivers/gpu/drm/drm_panic_qr.rs
> @@ -931,7 +931,7 @@ fn draw_all(&mut self, data: impl Iterator<Item = u8>) {
>   /// They must remain valid for the duration of the function call.
>   #[no_mangle]
>   pub unsafe extern "C" fn drm_panic_qr_generate(
> -    url: *const i8,
> +    url: *const kernel::ffi::c_char,
>       data: *mut u8,
>       data_len: usize,
>       data_size: usize,
> 


