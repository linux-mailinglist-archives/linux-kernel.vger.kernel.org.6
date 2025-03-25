Return-Path: <linux-kernel+bounces-574965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E336A6EC11
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 10:02:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9856116BC6B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 09:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2DC21E9B06;
	Tue, 25 Mar 2025 09:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hJKOv3x9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9AA18A6A8
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 09:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742893349; cv=none; b=ju1H17ql0alpTsb0VO+IQJxjElJyUDCsF65QbZK9apg9vpmrDEDTWUnUcj9S8U8WAoJZocjaDW5ew8Ouri2Xbpj0UuquobCdVZ3ykYOlAvy3hVOfFUqjXl8H18h0pDlxKu/rUfgRfyy68q9+BSlJtfkuNPH1y+o632WwgoLLL1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742893349; c=relaxed/simple;
	bh=wcSRVHryt2bmCq50gGdWBD1baQzrF0iPIIeTmkanllw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X7IR5kxpxv+WYQG/JynH1qL70LhHXLzQeRq4sbpZMQODt+raD9HlosHGT+bSk8RF6aW5DuyXMB/fuuhLVtmRea/niSZTDK8AAiHjqih/93DhJaKcjI6O4YwzNCPcCWSYD/wV7gSAwNwC5wov/OqSm3PDkhqaPUvgf6D8NTGCaEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hJKOv3x9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742893346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wj1IChreYTEW7S1AiPXdgyUmHcauFp5NeY4Eqtc9FGw=;
	b=hJKOv3x9LSrXF23YoQlw2ngGe9MmiGZu3lzlPMCmDQtt4SEmI2bqnr7KK84hA+g2WhFlY6
	nNT7pKOAQiDO8jmglkRG5o2w1gdLRCtPP1nhqk+mksE3LIE1cGWWfECUSSFRIhF4wiElMf
	CpZNR1eSdCQEyi8IhG0EvOLeDpRzzAk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-UeTRfxTSN9ujlyFVMwkV4Q-1; Tue, 25 Mar 2025 05:02:25 -0400
X-MC-Unique: UeTRfxTSN9ujlyFVMwkV4Q-1
X-Mimecast-MFC-AGG-ID: UeTRfxTSN9ujlyFVMwkV4Q_1742893344
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43d08915f61so32610075e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 02:02:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742893344; x=1743498144;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wj1IChreYTEW7S1AiPXdgyUmHcauFp5NeY4Eqtc9FGw=;
        b=N/cI4QZKZwH7ZT0iNnFY/UMBZEZbSPq4UBvfQWyzPN3CXvhPO3tIq7ID0kcg8brNd9
         vi/luM0kgm/2DxdFgqKK0VNWeyAJWjiB+IvKlIxd4mmpR7X2WWgo/fMlaJOvFtFboM1z
         PH3g2sHgiSc36seKU5EgX0QSKlW5fxBdU20SYKZsn2fts2Z1s3Zs62ISn4T5xcVFFSLO
         f8YclCLAjAkZkyRsqbrZ9VpJtowkTCw93X0CI4vFrs/auol78cZab95EbVd9FkYrsYmR
         /+4tutNkQcZGb2UrFvHG+UvYuy+gwBK3os1AozDeneiQipKROv/2oW3PTZ8LMYBi7H8v
         GdTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUonBkzQ5T/ApA7e4yxY0dMrLuBGitCpeFXd90Ckl85fP0x3lCnirbJNGM+TVEM54H66GilasrgN78iam0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRRAKo6YFjPhzt6nfBJls2bOWTW7dHWYdzKvHm7NvjYPewE2fy
	Hk4U3EDDwQFxuw2kMq0yqYir6muvvXC5lEqQlX0e5nJWgbAVSd4+DByZzHbvpo1AE5ToE3umUMO
	/j2fcZg7h9QVtGvClHHbH6lUOLYwsNBBN6oaZmzVQUidiY23ie8IJAcTwu/2JPg==
X-Gm-Gg: ASbGncs1VkUzK5iV4cXKqYRvjRbJdG+bsovAbknN3YD7RnhmFgsw8r8IFn3P+LKFfhE
	qmhoCh7ff8hPWoaQpIPvmaDOGoBgo530CdKj/tFbxIPF/3GTcZ7pEV2ZBb4zR+eCwF2XSuO4orT
	vrjZRM/7U7kezm3CxmKu1Mn6PfCxpbq1BYEGInm3U+bvKgv8LBdIsdtX2Z5AF2dHJSnq/N1yoX/
	LvM/7dm4wtAjMyaCL2GDwUJ2y2Jrh7+VcvxdlCG185Pg1od+GMhwx8ztWjV9NqKiUwAvobIzmk0
	qYlmMpkIbdJOuIA9xNGQnzGRtJ7hNiVU8tjkmhTgdl6z0t/qBy8K5YE=
X-Received: by 2002:a05:6000:410a:b0:390:e8d4:6517 with SMTP id ffacd0b85a97d-3997f8ff121mr13033029f8f.21.1742893344032;
        Tue, 25 Mar 2025 02:02:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmIfLZm7khPWjwEcKM+sZzsNS9/OV7LqARaa/EFUtim00jKs/LTQtUTCr53eUD4BnsaUPNvA==
X-Received: by 2002:a05:6000:410a:b0:390:e8d4:6517 with SMTP id ffacd0b85a97d-3997f8ff121mr13032888f8f.21.1742893342596;
        Tue, 25 Mar 2025 02:02:22 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9b409fsm13375318f8f.50.2025.03.25.02.02.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 02:02:22 -0700 (PDT)
Message-ID: <2628502d-5b43-41da-978f-66a68623889d@redhat.com>
Date: Tue, 25 Mar 2025 10:02:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] drm/panic: add missing space
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 patches@lists.linux.dev,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org
References: <20250324210359.1199574-1-ojeda@kernel.org>
 <20250324210359.1199574-2-ojeda@kernel.org>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20250324210359.1199574-2-ojeda@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/03/2025 22:03, Miguel Ojeda wrote:
> Add missing space in sentence.
> 
> This was found using the Clippy `doc_markdown` lint, which we may want
> to enable.

Thanks, it looks good to me.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>

> 
> Fixes: cb5164ac43d0 ("drm/panic: Add a QR code panic screen")
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
>   drivers/gpu/drm/drm_panic_qr.rs | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_panic_qr.rs b/drivers/gpu/drm/drm_panic_qr.rs
> index ecd87e8ffe05..9bd4d131f033 100644
> --- a/drivers/gpu/drm/drm_panic_qr.rs
> +++ b/drivers/gpu/drm/drm_panic_qr.rs
> @@ -5,7 +5,7 @@
>   //! It is called from a panic handler, so it should't allocate memory and
>   //! does all the work on the stack or on the provided buffers. For
>   //! simplification, it only supports low error correction, and applies the
> -//! first mask (checkerboard). It will draw the smallest QRcode that can
> +//! first mask (checkerboard). It will draw the smallest QR code that can
>   //! contain the string passed as parameter. To get the most compact
>   //! QR code, the start of the URL is encoded as binary, and the
>   //! compressed kmsg is encoded as numeric.


