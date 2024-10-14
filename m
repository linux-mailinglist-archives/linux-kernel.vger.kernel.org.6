Return-Path: <linux-kernel+bounces-363549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A7999C3E2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 10:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B5CCB25075
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 08:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529DE157A59;
	Mon, 14 Oct 2024 08:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dM/K99cj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8FE156F39
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 08:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728895509; cv=none; b=kqkV4W3QNEnmKg2fM19BQQlsNF8tuysqktTqaedylnd+Yckmljjw01kDmzUHRwsm8xq0pz6y/SSjMcEMhe0a1T9wieQRC8SFzwRAa4EUD4XwqvkhX2GwuzthxCO5P8eemxg7i0WHSSxGcDVOlKNIDFc5rQXzwdrGp59a5H4HQlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728895509; c=relaxed/simple;
	bh=CwuZER7CMm5JDCMH6v2vPK57MgMOmo4wMH1yhyCB1SY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B25JacbbUxsuxhSOOAziAFgrUh9CWTGybcBHL5/3+myDkADXHPETW+isaFHNzfRHY9LhYyu1v2dMe067ScGw6iTAo/doJY3hOqyQMi8MGLvhxrdZq+bgrrsW3MYlHTwat/t6Jy9+xr9yOaCV7/F1MUhSUNicdVlfI9j3p196zX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dM/K99cj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728895506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IwPdK057Cp2nQLCke3sfXHwalbY2C/QTU6X8kPub9I8=;
	b=dM/K99cjEMVLmtZD4IxuoQ4x2Bk5YNVTpiRwaaXW09F0LeT7/HI49t/8WGT7jMN/Uy0ze6
	KkIq6ll5MGB5j+lS6MIAVzOJRRdj54fLRPpcYSlBXCFaoQhduZ4bCViXx9LLOy6XMfm7/6
	UAoaR41QQ+NJBsVRZxGXg14cKth789s=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-JQRI6E2bOiurnoA3ic6oAA-1; Mon, 14 Oct 2024 04:45:05 -0400
X-MC-Unique: JQRI6E2bOiurnoA3ic6oAA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-37d5ca192b8so1225522f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 01:45:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728895504; x=1729500304;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IwPdK057Cp2nQLCke3sfXHwalbY2C/QTU6X8kPub9I8=;
        b=wVRqcCgnDCW/xcYWwNJEFfoaBK7cehTbqPJC0QJDTnM22UrkSqLx49N6unhMyEboXv
         J7T+H9Bin/Qc2k2iVoJFET1Ln5ZlsjbUcIB48OfKfL2LPi/BLTfcE3GusROrcWRsV6qt
         WVfO8fgsG9N3EOGfVsyWt4QYFHQPa+uzt2JxO1oQ4OiGcOPcnzpqzUC0ORtXI18QdB++
         a8Wb4UznsAYLWq8VDVQzOfG91MYbGOft6OLSp0RT5J4CfGO3ARh8dEsY7IhZ11Cr7/8q
         Z4hq/kpfPZm4k/FitX9hyPU3ZZMDodE22FSDlt8ir/q9MLDRywIFVu1TUr8Gy7jXFYIU
         +dHA==
X-Forwarded-Encrypted: i=1; AJvYcCVrG3zFGoakb0lorP0LlE0gPhcJyrp1P0jfePRwszEVzG72p8rBp5FjqpZ1WWO2ePucO7K+LeRohoYJgLA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXWrhJzof+GIDCvbkXLaWODgGsW3Y98NyJZsDjBZju5KmtVQsN
	EKp1tS5DtIxDHbErxrTriCp8fdAiuxFMWmFrQRbdVAWJZ8u8RSpys7MLTfD8Ie+nwSUQSzbkPCB
	VW4XQkLwZAJazBnbWxhAk180gSfETAatS9CuiMx7XVRZhiFgP6xzvZw50bSmm3w==
X-Received: by 2002:a05:6000:410b:b0:37d:5251:e5ad with SMTP id ffacd0b85a97d-37d5251e61emr10001920f8f.2.1728895503941;
        Mon, 14 Oct 2024 01:45:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGi2hL5R0Qzddqsq5A+5TzAAhKxmoPEGTna582tFhlN51HBFUK8Usw3/Lf3VB1BnJ+qqSmzBg==
X-Received: by 2002:a05:6000:410b:b0:37d:5251:e5ad with SMTP id ffacd0b85a97d-37d5251e61emr10001893f8f.2.1728895503470;
        Mon, 14 Oct 2024 01:45:03 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4311835d784sm113938295e9.46.2024.10.14.01.45.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 01:45:03 -0700 (PDT)
Message-ID: <89f24f92-de2d-4303-a189-9e5bc1eba02a@redhat.com>
Date: Mon, 14 Oct 2024 10:44:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] drm/panic: avoid reimplementing Iterator::find
To: =?UTF-8?Q?Thomas_B=C3=B6hler?= <witcher@wiredspace.de>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20241012075312.16342-1-witcher@wiredspace.de>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20241012075312.16342-1-witcher@wiredspace.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/10/2024 09:52, Thomas Böhler wrote:
> Rust's standard library's `std::iter::Iterator` trait provides a function
> `find` that finds the first element that satisfies a predicate.
> The function `Version::from_segments` is doing the same thing but is
> implementing the same logic itself.
> Clippy complains about this in the `manual_find` lint:
> 
>      error: manual implementation of `Iterator::find`
>         --> drivers/gpu/drm/drm_panic_qr.rs:212:9
>          |
>      212 | /         for v in (1..=40).map(|k| Version(k)) {
>      213 | |             if v.max_data() * 8 >= segments.iter().map(|s| s.total_size_bits(v)).sum() {
>      214 | |                 return Some(v);
>      215 | |             }
>      216 | |         }
>      217 | |         None
>          | |____________^ help: replace with an iterator: `(1..=40).map(|k| Version(k)).find(|&v| v.max_data() * 8 >= segments.iter().map(|s| s.total_size_bits(v)).sum())`
>          |
>          = help: for further information visit https://rust-lang.github.io/rust-clippy/master/index.html#manual_find
>          = note: `-D clippy::manual-find` implied by `-D warnings`
>          = help: to override `-D warnings` add `#[allow(clippy::manual_find)]`
> 
> Use `Iterator::find` instead to make the intention clearer.

Thanks for this patch, and the whole series.

It's a nice cleanup.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>

-- 

Jocelyn


> 
> Reported-by: Miguel Ojeda <ojeda@kernel.org>
> Closes: https://github.com/Rust-for-Linux/linux/issues/1123
> Signed-off-by: Thomas Böhler <witcher@wiredspace.de>
> ---
>   drivers/gpu/drm/drm_panic_qr.rs | 9 +++------
>   1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_panic_qr.rs b/drivers/gpu/drm/drm_panic_qr.rs
> index 1ef56cb07dfb..76decf49e678 100644
> --- a/drivers/gpu/drm/drm_panic_qr.rs
> +++ b/drivers/gpu/drm/drm_panic_qr.rs
> @@ -209,12 +209,9 @@
>   impl Version {
>       /// Returns the smallest QR version than can hold these segments.
>       fn from_segments(segments: &[&Segment<'_>]) -> Option<Version> {
> -        for v in (1..=40).map(|k| Version(k)) {
> -            if v.max_data() * 8 >= segments.iter().map(|s| s.total_size_bits(v)).sum() {
> -                return Some(v);
> -            }
> -        }
> -        None
> +        (1..=40)
> +            .map(Version)
> +            .find(|&v| v.max_data() * 8 >= segments.iter().map(|s| s.total_size_bits(v)).sum())
>       }
>   
>       fn width(&self) -> u8 {


