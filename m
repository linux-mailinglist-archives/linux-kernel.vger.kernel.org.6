Return-Path: <linux-kernel+bounces-553674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 341CBA58D45
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 08:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A56E0188CFC6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 07:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05BC0221F3C;
	Mon, 10 Mar 2025 07:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oz+0SvF8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4401E25F8
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 07:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741592999; cv=none; b=rjccKNhwCXWViNqExF04mjrmE5Kt0WXAdqn6QYs1WowaqaOD2MASGTnUBfAPt5pUA7qj49WQo2MJOf77ZkNLX86QliXRwk4FVRhgaLlNcr+oY8K+6KGc5kVvKqI/H8nIUfNnMdI6rfOqz8IXpl6DxDAXvMSTlESKg7CDH2gbTYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741592999; c=relaxed/simple;
	bh=2taqIQQXceogYRxl+WbwaFPfpyiONZBcxtV+IJvWGc8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZD5DhtFIyMW0PlDp89Tbtn7EufwOBVZBH0VmswgTm5haTmeAgazr9P/lVSscgTWXCvgIlUIlJ/grkKAUKWqnp3ZaqDfBDGz/NvdFlwPkB1XIJHC5n7XWW2EdgMifajJaTd17R5UI0275y5E1mB+3trMqHqkaIM12HXH5YPlvWqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Oz+0SvF8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741592996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u5kIvy1af+TbHcL/hyxVpb8RVtEt62vD4Y3oqmjYEDE=;
	b=Oz+0SvF8Zduz9Qld7rX+A8zfwGhUBqHrglcYglyP3rS3xwPS0i0akW/qHDrqdBJk/Xp0o0
	BFxF+y1P5QpuedaO3z2pQtHLFDYgy2l/2XLsly8QmEtLc0KXjvxht6HgSHYrr2qA0RUGlc
	aJLgKgCPcIwVLEIsze7rFJ/CGFRp1BQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-Jsq9jWDiO-adsX0M7fDAGA-1; Mon, 10 Mar 2025 03:49:55 -0400
X-MC-Unique: Jsq9jWDiO-adsX0M7fDAGA-1
X-Mimecast-MFC-AGG-ID: Jsq9jWDiO-adsX0M7fDAGA_1741592994
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43cf5196c25so3408925e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 00:49:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741592994; x=1742197794;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u5kIvy1af+TbHcL/hyxVpb8RVtEt62vD4Y3oqmjYEDE=;
        b=c7rgblSlsevteIe5tkwAZ3Ixta4T8Vvx76KN86l8+HZLbILBoFD3b8KnnK0HRoO678
         W8wjoxR9GAEBEtkUzwJUBYiViRY+1kI0meHhTFDyCFvSdjU2G1dLZLpvQ+kmeqiF7fSw
         Fqg343kwrJQO32ocvKx2cXEa/YwgtXBRtFCO/dwjOpBpkouviKeoDPRxvuI2nj0HnXjx
         kpnJxcLcd0fymg6sFit/Bm+RAl7knn+norXbYVqrtUCDp+pIPrOYt8BcDsijl6MkHbf6
         d20mky0JmLYGmWdXRMKemFWvC2aP54TjI+Y2g/q0EFvOx3zQxWQJQsrX34onajRcN5g+
         TgNA==
X-Forwarded-Encrypted: i=1; AJvYcCXbXRAeeKvNIxW9PrKJXPmdDuDeyowpLfPQ2CR4sojbsEoRiTeefIWxPUgpCun/sobiiE/bSgTCvZRNKNU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrbMCfYdRwCkdmh2n6RK8YVEoCX4RCGjSRZ6OLn5ICRVLDWi0L
	Ol79enB+95ivhNu1Bi6d1j8BADh/TQS/gzqr+3+/fBmCDRB2eLwRFe+lcvDr1YrcPxagzuwezQ/
	91srk8RRae19Acni4xM/pld5myuI68gS3glI31K4Am0spTIHe9lkxuC9KBIosOQ==
X-Gm-Gg: ASbGncu3UVi8PYoyXZOV2E1ZR4rg0f3vO97ez21fD448o/+EMMbFHtR3dS6ZzE/96A/
	jZJFgVP10oIPnMEQnqNOlazqGG3GcCIOvNuAKUguowq4+/HbqskhQy+U7x0/4O5jEW333fU4hfQ
	GW+KwRdgu0miI+JokvFJv5AFCca4u5vmjgJtv/8UeYYMviApERQzyjn+JdR1IbXgpxM1aEk5fxx
	xqSbbuZgGpFb8U3S/WrO0+HT6oZLQBNm/AjFtANWQHLClRgYZWWxSD3sQoVp8vygbEtgryHx+lk
	YGWaHMAJqEfoNqaC5DLQCl7m+G2ijChbZllilqfrGzGMhGIO34wJScU=
X-Received: by 2002:a5d:6d09:0:b0:391:34:4fa9 with SMTP id ffacd0b85a97d-39132b56eccmr8992838f8f.0.1741592994105;
        Mon, 10 Mar 2025 00:49:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFGDJo2dCkSOhn/W3s56Mf4MrQ0JYSQmeOFCRJ3rj6SEOpkuthbr1LKEQhE5Wn257lq7BmQQ==
X-Received: by 2002:a5d:6d09:0:b0:391:34:4fa9 with SMTP id ffacd0b85a97d-39132b56eccmr8992816f8f.0.1741592993752;
        Mon, 10 Mar 2025 00:49:53 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c01cd31sm14138878f8f.52.2025.03.10.00.49.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 00:49:52 -0700 (PDT)
Message-ID: <7fa51125-3015-446a-93b1-57b07a7ee8f5@redhat.com>
Date: Mon, 10 Mar 2025 08:49:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/panic: use `div_ceil` to clean Clippy warning
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
References: <20250301231602.917580-1-ojeda@kernel.org>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20250301231602.917580-1-ojeda@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/03/2025 00:16, Miguel Ojeda wrote:
> Starting with the upcoming Rust 1.86.0 (to be released 2025-04-03),
> Clippy warns:
> 
>      error: manually reimplementing `div_ceil`
>         --> drivers/gpu/drm/drm_panic_qr.rs:548:26
>          |
>      548 |         let pad_offset = (offset + 7) / 8;
>          |                          ^^^^^^^^^^^^^^^^ help: consider using `.div_ceil()`: `offset.div_ceil(8)`
>          |
>          = help: for further information visit https://rust-lang.github.io/rust-clippy/master/index.html#manual_div_ceil
> 
> And similarly for `stride`. Thus apply the suggestion to both.
> 
> The behavior (and thus codegen) is not exactly equivalent [1][2], since
> `div_ceil()` returns the right value for the values that currently
> would overflow.

I pushed both patches to drm-misc-fixes, with the "Cc" tag added.

Thanks a lot for your contributions.

-- 

Jocelyn
> 
> Link: https://github.com/rust-lang/rust-clippy/issues/14333 [1]
> Link: https://godbolt.org/z/dPq6nGnv3 [2]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
>   drivers/gpu/drm/drm_panic_qr.rs | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_panic_qr.rs b/drivers/gpu/drm/drm_panic_qr.rs
> index bcf248f69252..8bb5e52d75cc 100644
> --- a/drivers/gpu/drm/drm_panic_qr.rs
> +++ b/drivers/gpu/drm/drm_panic_qr.rs
> @@ -545,7 +545,7 @@ fn add_segments(&mut self, segments: &[&Segment<'_>]) {
>           }
>           self.push(&mut offset, (MODE_STOP, 4));
>   
> -        let pad_offset = (offset + 7) / 8;
> +        let pad_offset = offset.div_ceil(8);
>           for i in pad_offset..self.version.max_data() {
>               self.data[i] = PADDING[(i & 1) ^ (pad_offset & 1)];
>           }
> @@ -659,7 +659,7 @@ struct QrImage<'a> {
>   impl QrImage<'_> {
>       fn new<'a, 'b>(em: &'b EncodedMsg<'b>, qrdata: &'a mut [u8]) -> QrImage<'a> {
>           let width = em.version.width();
> -        let stride = (width + 7) / 8;
> +        let stride = width.div_ceil(8);
>           let data = qrdata;
>   
>           let mut qr_image = QrImage {
> 
> base-commit: d082ecbc71e9e0bf49883ee4afd435a77a5101b6


