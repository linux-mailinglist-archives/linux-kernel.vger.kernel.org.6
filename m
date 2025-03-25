Return-Path: <linux-kernel+bounces-574968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1676EA6EC1C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 10:05:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25EC23AD8BC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 09:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533CE1F63D9;
	Tue, 25 Mar 2025 09:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KcxwqmKB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF30C1DB924
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 09:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742893522; cv=none; b=BaV2wd5tURQpml9rHmVfWpFxvJe0hCENUSm7iwiBemK6XR3t5Mjue8Q5ewY0teA9FJiSYnVTEEoPfwYEvfpj+XcFn+Z25PaFSMh1mXfmjQZ5REmFhmC4dzdwtdW1mEmQCsqQn8bnsE9S5cXp2xIQu1HaIeUtUYYLjcLfi9MsG5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742893522; c=relaxed/simple;
	bh=mKJ++G7wNhJzW9MVSALnmcUFApSRdiNlAhwjAt23yKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o27VzphykuiJRO8XdpKD7EeFlqhv76NpUVsBF1MdrImPUKhfkPi6AbbT3h/GjM8sgPGfmEg9EEU6u+/4oFh8NpuqhPwwyx7uOIThJsQF0iLrqBc/zrclzou7FMsjBGGFT9nKGTMkOZFICOCHtwLqygE/9VcMJeqMoGSdNdczYPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KcxwqmKB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742893519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PrC6whXEB8tIJZm3Od4OEZVDDngb94gqrtSVDSXgtaI=;
	b=KcxwqmKBavatPD1sMsk30qZBb+d/+bkdCl9uXpc4dDOqzwIuvyls17bVVSqA+mvq0fjp8W
	gjdWLJikCR+eSkK0tV48+Gu4wsnCUdtn3+wCX/CqGiAuk/FxJmo2+AhQdc5htEPlyEu9By
	piaUc0XveDP3+GyeWVqks52T5eFKBd8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-1r6T9FyOPkWigZeOIL4-iQ-1; Tue, 25 Mar 2025 05:05:18 -0400
X-MC-Unique: 1r6T9FyOPkWigZeOIL4-iQ-1
X-Mimecast-MFC-AGG-ID: 1r6T9FyOPkWigZeOIL4-iQ_1742893517
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-39123912ff0so2335793f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 02:05:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742893517; x=1743498317;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PrC6whXEB8tIJZm3Od4OEZVDDngb94gqrtSVDSXgtaI=;
        b=YIjolP76SHpjuYrS7rabCx1NiQrOPVcQ4+cvcUM6kjnrItjTq66W39k16QwwXDo3oP
         qVGbVIWdsVNAJrQqoTcf/UAMEvVQud2FA60BQDbVqX1xWk4wwHlEX77mxMcfh3A5eJuc
         nQuckxP3qQRtF9Q5d+lBNxuqKfpQmlf/RtiKaadeCIqw0u5B2+r54DTD7rw779k4D6ad
         PpvaK2bhWriPiezSLtlBIOPDTEPmyMVFVct1jrjm6koFG6VRJFZmOTkbOrXQ8PtK+5WU
         oDU1/OUMM9duA+3HTcR/akFD9vSi5Gjy45BqqnONBmR1++M7fRP63ZTxm3OrQB04sGTT
         QIuw==
X-Forwarded-Encrypted: i=1; AJvYcCUzOHPxlG7+GXdCIzqo75Pzy644yIVVY4uQLSTGQ2S8w8OfrFGhd5Q4527vy2eN3zwlO3nvv62+Sujioac=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJJtHx04Wsvsm4Y1ewBBF4Ot0KpzyqBzKm3VhTwWZR+i4Aya0f
	6H1qpxmpDz5vL+PosDp73JGvJvjiz4jzpAyeVqz6FznIl8+y3dFvWLT/uS6LUakYzP/8xtvbkBE
	S+IkdHS/8oAGoEX+DsWn0Xh6Akqh+gg1k0tJCOjDl2YLhkqHRYdnC0rHhc/HRFg==
X-Gm-Gg: ASbGncuHs52qPvbdEAZeS7+XKXv/Uq/M6zZ3Jeyk/JTH3CjcOMcgkfo0ybX9N+w17Sn
	bSe6ZEdc2e1AUl6YeLWNnqJhgnJFnk84yfMES7J46R2E1GwMxQv2dijkY4HSWuKESWjHxvAsCxk
	IVt4FxrpDD0KtHGFbq697eJPrOqB9jc41vvBNKE6bB3bvJd/LBhF7bnkKJDOMlQ9PUPQCBTZOiR
	zVqiC03CWgin4SVvcwcDuqMj565bxATMilplk6KtdOctvK/tZjfV7y1VZbbVcjFE4zGnO9ps0n1
	j7zz8LqvjdOBb05+Gcrn82kGftRXrotlCRjUTxMbzI+olsjsp+92Ry4=
X-Received: by 2002:a05:6000:2a4:b0:391:ba6:c066 with SMTP id ffacd0b85a97d-3997f932dc7mr15340760f8f.35.1742893516847;
        Tue, 25 Mar 2025 02:05:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTBT9UgEXQQoZOQCZf+geD9eCV4pZV+LkpuIAC9M/oAzFE2WYScIhUIhi8NX1J2SaBNujAOg==
X-Received: by 2002:a05:6000:2a4:b0:391:ba6:c066 with SMTP id ffacd0b85a97d-3997f932dc7mr15340713f8f.35.1742893516379;
        Tue, 25 Mar 2025 02:05:16 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fcea6ecsm145624925e9.5.2025.03.25.02.05.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 02:05:14 -0700 (PDT)
Message-ID: <dd1616d5-4808-46be-9167-6fbfe76e0c73@redhat.com>
Date: Tue, 25 Mar 2025 10:05:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] drm/panic: add missing Markdown code span
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
 <20250324210359.1199574-3-ojeda@kernel.org>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20250324210359.1199574-3-ojeda@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/03/2025 22:03, Miguel Ojeda wrote:
> Add missing Markdown code span.
> 
> This was found using the Clippy `doc_markdown` lint, which we may want
> to enable.

Thanks, it looks good to me.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>

You want to take the whole series in the rust tree?

Otherwise I can push the patch 1-2 to drm-misc-next if needed.

-- 

Jocelyn

> 
> Fixes: cb5164ac43d0 ("drm/panic: Add a QR code panic screen")
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
>   drivers/gpu/drm/drm_panic_qr.rs | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_panic_qr.rs b/drivers/gpu/drm/drm_panic_qr.rs
> index 9bd4d131f033..a8f832598c70 100644
> --- a/drivers/gpu/drm/drm_panic_qr.rs
> +++ b/drivers/gpu/drm/drm_panic_qr.rs
> @@ -914,7 +914,7 @@ fn draw_all(&mut self, data: impl Iterator<Item = u8>) {
>   ///    will be encoded as binary segment, otherwise it will be encoded
>   ///    efficiently as a numeric segment, and appended to the URL.
>   /// * `data_len`: Length of the data, that needs to be encoded, must be less
> -///    than data_size.
> +///    than `data_size`.
>   /// * `data_size`: Size of data buffer, it should be at least 4071 bytes to hold
>   ///    a V40 QR code. It will then be overwritten with the QR code image.
>   /// * `tmp`: A temporary buffer that the QR code encoder will use, to write the


