Return-Path: <linux-kernel+bounces-363555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF65199C3F7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 10:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CE131F242D3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 08:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0F914F126;
	Mon, 14 Oct 2024 08:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Saq8aIYZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD231A270
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 08:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728895592; cv=none; b=phlIVUPk+XhFBlcRQKGzwUlCprfG+/M/BZjY6CHv/VexWm2ZTMu4H8+DTTZV4Az6Q4u4PioGjTRR6Nt477Yf75eLjBzXtkIO9arMM1x7XALHi2gZR3ave9Md4oz4mn+cqbtnUU5pkGV7Y227luvy9PoxbRVdqJCLbo+Gc5QBiIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728895592; c=relaxed/simple;
	bh=DTDHdgSuKlw8QItjw4pvFY6tXNSrdp9VJN+KOLQxrm8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eTqYz21Y++aw8zsXIWeMZUadsj/MRFH6se8iZP+Aiz6/PIKjpan3vnHxlHcbshZqFislS2FE8YcyCAdKobCtHUN9n5PQAbPNMDa9IiDRe+6nhobOTpiaokZgFokcVggIrHTKwEQgD+6W1Bqt/wIJQ2TvkZDew3FpKA7LFOwQWRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Saq8aIYZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728895590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8yMw1kZ4wSYjtEjMJHnAEl230IFSdVbMJQeMPPAW0b8=;
	b=Saq8aIYZwbX1e/J0WhCs0u/D4QK2nJa3ytnHvTuosdfKBiRdV2mJGq6pnXOj2hK9CswgNd
	E7+i73R4uorgp88KOpS729LIW9rXvMjrfYT1o+PDT35MxiEupAup9U/d+qyqM6yyEOCDu8
	OFZyrtaRwwezOvjB6jXRtFMpQLsTCgk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-JGVyQdwMMLG7xgA7TKH7Pg-1; Mon, 14 Oct 2024 04:46:28 -0400
X-MC-Unique: JGVyQdwMMLG7xgA7TKH7Pg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-37d4d51b4efso1520168f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 01:46:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728895588; x=1729500388;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8yMw1kZ4wSYjtEjMJHnAEl230IFSdVbMJQeMPPAW0b8=;
        b=hQuL/fq+AmI0SzwovZqpSuBGvTrZ/g8FNUeDpU+ugU/sZJ5sNwXy+bIE0txvC4E9hC
         AdGmEWBCJG4d5DdvOzoGXlCv8tRGp7c+qB72xEOq50zdWW8l+eFrs9r5a10CJA75k6NZ
         vQ7CyPh8ZcR8yCNvkDWIMuhGtCbseh5+Cumst/a7Ha5FSqsS5cSA1HLLMYXQGYRd9HlC
         M7odtR84Or92smOdh6MrYfPIgLkAGl+qA2wKuyuPNn1M1vfJAO7CpXuEvbhqu+dZmqct
         mIWFipV3TKlyEJb+ElDT1K4wFVhteAbVTlmZE/83lMMbYnf2ua6oozQZFJrCGgUMmdts
         LZAA==
X-Forwarded-Encrypted: i=1; AJvYcCUWBKB8B1G//T/r+jCfzNfaq2KC9Adjh/TW/bheG0PHz/FvOWtHv54M68sME7dtzaih8OpLKygSa3vY1oU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB6fIq5W24jl/5I2XrGpBqttRQ45jIcnK7L8GCqxUSSLiYrW9w
	LMP+T09GvdSwOPczLf7T9at8v+fkiHe3tHnyP9RUM2FMxmX3St/lDZsfuB2kMzgtnrc3UIejXcG
	I4KfhBAFCfV5W+E2pN0DTfgYtOduqwmCsCVbqCSckPrV8yt7NaYTQBY4gb6v/9A==
X-Received: by 2002:adf:b30c:0:b0:37d:39c1:4d3 with SMTP id ffacd0b85a97d-37d5518e694mr6473268f8f.6.1728895587690;
        Mon, 14 Oct 2024 01:46:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFLIWKqOZJqqYjX4EN/6TkBMgfY/lAKwXdtrnkKX4U6krTF6dTWMvOHBK9y+++vFukzWCiZg==
X-Received: by 2002:adf:b30c:0:b0:37d:39c1:4d3 with SMTP id ffacd0b85a97d-37d5518e694mr6473245f8f.6.1728895587279;
        Mon, 14 Oct 2024 01:46:27 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6d0071sm10661282f8f.62.2024.10.14.01.46.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 01:46:26 -0700 (PDT)
Message-ID: <567d7f67-291f-4483-921f-a03ecdf83c9d@redhat.com>
Date: Mon, 14 Oct 2024 10:46:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] drm/panic: prefer eliding lifetimes
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
 <20241012075312.16342-3-witcher@wiredspace.de>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20241012075312.16342-3-witcher@wiredspace.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/10/2024 09:52, Thomas Böhler wrote:
> Eliding lifetimes when possible instead of specifying them directly is
> both shorter and easier to read. Clippy notes this in the
> `needless_lifetimes` lint:
> 
>      error: the following explicit lifetimes could be elided: 'b
>         --> drivers/gpu/drm/drm_panic_qr.rs:479:16
>          |
>      479 |     fn new<'a, 'b>(segments: &[&Segment<'b>], data: &'a mut [u8]) -> Option<EncodedMsg<'a>> {
>          |                ^^                       ^^
>          |
>          = help: for further information visit https://rust-lang.github.io/rust-clippy/master/index.html#needless_lifetimes
>          = note: `-D clippy::needless-lifetimes` implied by `-D warnings`
>          = help: to override `-D warnings` add `#[allow(clippy::needless_lifetimes)]`
>      help: elide the lifetimes
>          |
>      479 -     fn new<'a, 'b>(segments: &[&Segment<'b>], data: &'a mut [u8]) -> Option<EncodedMsg<'a>> {
>      479 +     fn new<'a>(segments: &[&Segment<'_>], data: &'a mut [u8]) -> Option<EncodedMsg<'a>> {
>          |
> 
> Remove the explicit lifetime annotation in favour of an elided lifetime.
> 

Thanks, it looks good to me.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>

> Reported-by: Miguel Ojeda <ojeda@kernel.org>
> Closes: https://github.com/Rust-for-Linux/linux/issues/1123
> Signed-off-by: Thomas Böhler <witcher@wiredspace.de>
> ---
>   drivers/gpu/drm/drm_panic_qr.rs | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_panic_qr.rs b/drivers/gpu/drm/drm_panic_qr.rs
> index 7adfaa3d6222..767a8eb0acec 100644
> --- a/drivers/gpu/drm/drm_panic_qr.rs
> +++ b/drivers/gpu/drm/drm_panic_qr.rs
> @@ -476,7 +476,7 @@ struct EncodedMsg<'a> {
>   /// Data to be put in the QR code, with correct segment encoding, padding, and
>   /// Error Code Correction.
>   impl EncodedMsg<'_> {
> -    fn new<'a, 'b>(segments: &[&Segment<'b>], data: &'a mut [u8]) -> Option<EncodedMsg<'a>> {
> +    fn new<'a>(segments: &[&Segment<'_>], data: &'a mut [u8]) -> Option<EncodedMsg<'a>> {
>           let version = Version::from_segments(segments)?;
>           let ec_size = version.ec_size();
>           let g1_blocks = version.g1_blocks();


