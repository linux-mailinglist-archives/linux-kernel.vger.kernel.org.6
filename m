Return-Path: <linux-kernel+bounces-422047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6A29D93C6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 10:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B3ACB2610D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 09:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A99C1ABEBF;
	Tue, 26 Nov 2024 09:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VurHXpDa"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB0728FF
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 09:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732611847; cv=none; b=DauOKnIOoFc0n9bdzFs+PeQf/UFlWxsiPBqb1J9WT9zb6BhGbnQe4VsuJzMpqryq2SFnDk8GO9XKeYbJD4O2647BYX6ZHyRHDA05SX6rGgkaGrOTHQoRe5tl3zEeJl6wcT7pKCkH3s7cpwQPj5hJ2crIwLxU7+jO1/DTAuBOSC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732611847; c=relaxed/simple;
	bh=ZWmrGQ6M26BhXo9m6RKEZU+fsqbwL7LzDsPFnAheZho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H0s9Wqcy1uX5n3Gah732N8pa00KCc4DfMPjDxgTooTzq/voxuG6/NeBeQBwQYkG6kKvVCjQv87Jdc4+K/jbQoW9u/Ck6jUGPD6tOrxfdN9gdmnTrwBF7PK98TaZrpuMYaik4vwabhHWQ8OEY8VQu/Vmbb/qAuzwBxLDrQ3M4Lu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VurHXpDa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732611845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=im/8o06WdRL6AvUGxWnBVgqT+amoAsT42x2YeIRHNPI=;
	b=VurHXpDaRTtY46UE8xiir02F4tL7Fn5/zAePHR1iaHClCa09mihb7dSI4uhdKCWSVbqZuB
	FTs+FNlONUoZDtNNtp+2HLqudraSF732F1o5xftAkoPqDMcMaO4Vt8C1xOaI2qKu2MPOdQ
	e2ocHcjrGAANHoNVRn1GttucCMZc5jk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-8tjGj6zUOmulrYcsQzg3FA-1; Tue, 26 Nov 2024 04:04:02 -0500
X-MC-Unique: 8tjGj6zUOmulrYcsQzg3FA-1
X-Mimecast-MFC-AGG-ID: 8tjGj6zUOmulrYcsQzg3FA
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4349df2d87dso21264055e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 01:04:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732611841; x=1733216641;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=im/8o06WdRL6AvUGxWnBVgqT+amoAsT42x2YeIRHNPI=;
        b=HMNvZhra3L9W2MQ9+vOh7wI2mDzfyR1oHPRMGkREhw2A6znLET6mee0qYz5nikp4sM
         rw1MbfbcF0NHGgKHu/LJ1voNmcifECIe+6AuOWArSUPaxS9z6OfxocfHN4T2jpcLs2hC
         JkKE1uOQQg7oYvqxC3r8mmkBycM2yqeXYs8KnKENraqrbRCUYGCnFLByhrT8rJaVLXGS
         x/tIMlTFa4ooxjhxb82tFOTcFgFIhwvPSvu0vuc1PnX7pdDF5PUfswEcUPI4jmKB9dDD
         UUb24GEdGu6d54LjeGU8yCXzhO7qUSDl8uVVo9w/F2ScCGud9fsgfCDx/Hce8tKF+Lh4
         1xJg==
X-Forwarded-Encrypted: i=1; AJvYcCXz/PgvQYe9I9AAMbIsAN+5cybM9rFq4csOTgXDcyInMXwVBSO5i6LT3TMzxRfcAclKWMd4+lRlQqOzkaA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj1gqPO4Nk+RjO8kRVXA1HET8Jn6F7RWtYg2hZpIXAKngIAoyH
	RES+RKUnmDPtb+9Vaw8+ZCDE1NFZBguT8JOtf/4lTm0rtH2aSPBd2rZXjDTP4ehKng/qvOVZmX7
	xu9L3MYq1vLe95DIRYQQqHG7CQrTvrnjc0ufemJmUPLxqvDNKYRAN7r/ncuQkfg==
X-Gm-Gg: ASbGncuia4Hp7VYa/C8vt5uzrEJB5W5AKwazlKs69O0Lx8ilStFQ5Ra8Eh4bClUSkFb
	EZGlwzxGf7fD8Fc1gZKm1SvbaB46UZtRtLiwwkibTI98v1S5MeMzV8oydO9WZGLaN2sm94lx1KF
	xjqOSa0idbC8brhm+tzZ0RaFbbvTMpOCFbFuWvA8UM+wQQag53kdkyQBx1eq+IY2d3KbrXsbR/5
	fAWaxtu7RYHB9jLCmcjl/1BDJzp0+2X9vPfHT6V718s08guUVhJHX1FNBEzPvi/MSPx1+u5Edyh
	UcLWcbc1YqmkSw==
X-Received: by 2002:a05:600c:a49:b0:431:4f29:9539 with SMTP id 5b1f17b1804b1-433ce4af26bmr148804045e9.32.1732611840677;
        Tue, 26 Nov 2024 01:04:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHqku7owNzsRW4AuiyjR+T5rbYPu8TV/N4RKw6ZJEgH4GkTL9H/M9yM3mzoUSyueykAQvBQkA==
X-Received: by 2002:a05:600c:a49:b0:431:4f29:9539 with SMTP id 5b1f17b1804b1-433ce4af26bmr148803685e9.32.1732611840280;
        Tue, 26 Nov 2024 01:04:00 -0800 (PST)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fafeceesm12715211f8f.37.2024.11.26.01.03.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 01:03:59 -0800 (PST)
Message-ID: <fe2a253c-4b2f-4cb3-b58d-66192044555f@redhat.com>
Date: Tue, 26 Nov 2024 10:03:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/panic: remove spurious empty line to clean warning
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 patches@lists.linux.dev, stable@vger.kernel.org
References: <20241125233332.697497-1-ojeda@kernel.org>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20241125233332.697497-1-ojeda@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/11/2024 00:33, Miguel Ojeda wrote:
> Clippy in the upcoming Rust 1.83.0 spots a spurious empty line since the
> `clippy::empty_line_after_doc_comments` warning is now enabled by default
> given it is part of the `suspicious` group [1]:
> 
>      error: empty line after doc comment
>         --> drivers/gpu/drm/drm_panic_qr.rs:931:1
>          |
>      931 | / /// They must remain valid for the duration of the function call.
>      932 | |
>          | |_
>      933 |   #[no_mangle]
>      934 | / pub unsafe extern "C" fn drm_panic_qr_generate(
>      935 | |     url: *const i8,
>      936 | |     data: *mut u8,
>      937 | |     data_len: usize,
>      ...   |
>      940 | |     tmp_size: usize,
>      941 | | ) -> u8 {
>          | |_______- the comment documents this function
>          |
>          = help: for further information visit https://rust-lang.github.io/rust-clippy/master/index.html#empty_line_after_doc_comments
>          = note: `-D clippy::empty-line-after-doc-comments` implied by `-D warnings`
>          = help: to override `-D warnings` add `#[allow(clippy::empty_line_after_doc_comments)]`
>          = help: if the empty line is unintentional remove it
> 
> Thus remove the empty line.

Thanks for this patch, it looks good to me.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>

> 
> Cc: stable@vger.kernel.org
> Fixes: cb5164ac43d0 ("drm/panic: Add a QR code panic screen")
> Link: https://github.com/rust-lang/rust-clippy/pull/13091 [1]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
> I added the Fixes and stable tags since it would be nice to keep the 6.12 LTS
> Clippy-clean (since that one is the first that supports several Rust compilers).
> 
>   drivers/gpu/drm/drm_panic_qr.rs | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_panic_qr.rs b/drivers/gpu/drm/drm_panic_qr.rs
> index 09500cddc009..ef2d490965ba 100644
> --- a/drivers/gpu/drm/drm_panic_qr.rs
> +++ b/drivers/gpu/drm/drm_panic_qr.rs
> @@ -929,7 +929,6 @@ fn draw_all(&mut self, data: impl Iterator<Item = u8>) {
>   /// * `tmp` must be valid for reading and writing for `tmp_size` bytes.
>   ///
>   /// They must remain valid for the duration of the function call.
> -
>   #[no_mangle]
>   pub unsafe extern "C" fn drm_panic_qr_generate(
>       url: *const i8,
> 
> base-commit: b7ed2b6f4e8d7f64649795e76ee9db67300de8eb
> --
> 2.47.0
> 


