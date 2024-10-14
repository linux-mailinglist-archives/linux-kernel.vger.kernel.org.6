Return-Path: <linux-kernel+bounces-363578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B55E599C435
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 10:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A1F5280EE5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 08:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12B6153824;
	Mon, 14 Oct 2024 08:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sg5G8LD8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBEF231CB2
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 08:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728896141; cv=none; b=pQTgR8+2CV0YsAIfs+mnrK/uDHTfmybQS665EY25ABuaPeamWcXQ74IHvN+dyFvCEN3bCSbVkNfBU1U4HptMt53WeGnPHhvXztN3MBxTBAySWetCUhuqoCUwjnKUdoPOm4VzkQh+QEuju4unOQg8Evo8nh4nfNimdj1hZkXHFK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728896141; c=relaxed/simple;
	bh=q5AtrCSAA7vrYMLlA/eP1eHpMODMlqvnRe1smcyIJKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WQQVJ49y2LDC12zeYrA90gh4sAxsLIx+04DCjrG+25q6wNnn6YXpcQy7qni+YSZRSvaY+UEbO3LoE4Fk3jbpJHpnZc0JMh+eZ65Ws1oFMl3Hg6xcVaSv5RAZSrc/5gTNQp3gnVOKFzAF815GG+b43Zeb56HU8CfucBQAxlK7a/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sg5G8LD8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728896138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SZZV3eCjwH17+qwXquSijSlOfzm3AowdcidnwQs1e80=;
	b=Sg5G8LD87p2BeFY6YnDMa+m0YT+eZ/ZBUydGUrB5ioau3Zz8kf7OaHT28g8GTAhXTjEUe3
	Kel7jpyJdJoaGXiPr1TsllNmG7IzApcOtGvoeuUQ/cVB7irQJJSnAVpuy3RAIkaacvlkTA
	5XdUfC9DZunLXBhOD1SMhBLPvjSLdp0=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-ArBvDpstPlKuiMQziAik3A-1; Mon, 14 Oct 2024 04:55:37 -0400
X-MC-Unique: ArBvDpstPlKuiMQziAik3A-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-539ea0fcd4bso981609e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 01:55:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728896135; x=1729500935;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SZZV3eCjwH17+qwXquSijSlOfzm3AowdcidnwQs1e80=;
        b=G0wWdmMkGSLd87HmmVcxmno4NVLUcoOVTSgKhF8vNZ4nimUYZrW2hfwSj43LUUUOmB
         U3xRkOhwnLgDDlqRlZw7C4STPjnXk42KjANOig9naQ0Q6tiTKYGdlaoQxGwwbvlEFLTQ
         28DYpD720OhT9GaTvDhOREXgBft1uiURmAar2xfZ/aA+NJoquH7wrU5N7FdfeCg2NO9C
         6YCke5AgN1X2S3siF5hO1ZAyjS1v9NDh3Q8kBExAdrT8hJ3bhUBKJ27ZCoJFkTetEFn6
         R2Phv3vLidrdyt0sZc0MnEf41+xZB3fNEoPCkqovq6yrzaeJg2mafmeBHoW988KM4XAJ
         NKLw==
X-Forwarded-Encrypted: i=1; AJvYcCUwIA74c+dHb2LRVEHXZVZB7fuW0kOioGgWmtAmR/omjinz2En7AgIVYY1uUrvEd7oI+rwNT2EH8D//XD8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIJnD/nCCynZ5O06x9Vu9CHkirgN5lsLUVlsvSt8LE5U6UYhTH
	Eup1fpfHztIYlizVZTCbX5a52eoAxI+KC0jafsWZ/WYZ65x+LXx3hHWO5bf2fG5qSrUxedRvM7I
	h1hGRExd7EkA+L3zGDmbZ+0+sRUGByQD9inhKCdihyuiPQH/0I2Q4RuNgG20HQw==
X-Received: by 2002:a05:6512:3196:b0:539:89f7:3187 with SMTP id 2adb3069b0e04-539da583db0mr4542265e87.47.1728896135544;
        Mon, 14 Oct 2024 01:55:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsnAdyTUOwoRixLAd99Kcrm/Heu2DZ1kp3SFQWf3sDK6kM96X3+KpLcEanEEOaqVXM5IPHrw==
X-Received: by 2002:a05:6512:3196:b0:539:89f7:3187 with SMTP id 2adb3069b0e04-539da583db0mr4542248e87.47.1728896135047;
        Mon, 14 Oct 2024 01:55:35 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b9190f7sm10761253f8f.114.2024.10.14.01.55.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 01:55:34 -0700 (PDT)
Message-ID: <8d1c8667-e032-4d9f-bc8c-f12d71070a11@redhat.com>
Date: Mon, 14 Oct 2024 10:55:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] drm/panic: allow verbose version check
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
 <20241012075312.16342-7-witcher@wiredspace.de>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20241012075312.16342-7-witcher@wiredspace.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/10/2024 09:52, Thomas Böhler wrote:
> Clippy warns about a reimplementation of `RangeInclusive::contains`:
> 
>      error: manual `!RangeInclusive::contains` implementation
>         --> drivers/gpu/drm/drm_panic_qr.rs:986:8
>          |
>      986 |     if version < 1 || version > 40 {
>          |        ^^^^^^^^^^^^^^^^^^^^^^^^^^^ help: use: `!(1..=40).contains(&version)`
>          |
>          = help: for further information visit https://rust-lang.github.io/rust-clippy/master/index.html#manual_range_contains
>          = note: `-D clippy::manual-range-contains` implied by `-D warnings`
>          = help: to override `-D warnings` add `#[allow(clippy::manual_range_contains)]`
> 
> Ignore this and keep the current implementation as that makes it easier
> to read.

Thanks, it looks good to me.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>

> 
> Reported-by: Miguel Ojeda <ojeda@kernel.org>
> Closes: https://github.com/Rust-for-Linux/linux/issues/1123
> Signed-off-by: Thomas Böhler <witcher@wiredspace.de>
> ---
>   drivers/gpu/drm/drm_panic_qr.rs | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/drm_panic_qr.rs b/drivers/gpu/drm/drm_panic_qr.rs
> index 226107c02679..fe842466d8d6 100644
> --- a/drivers/gpu/drm/drm_panic_qr.rs
> +++ b/drivers/gpu/drm/drm_panic_qr.rs
> @@ -981,6 +981,7 @@ fn draw_all(&mut self, data: impl Iterator<Item = u8>) {
>   /// * If `url_len` = 0, only removes 3 bytes for 1 binary segment.
>   #[no_mangle]
>   pub extern "C" fn drm_panic_qr_max_data_size(version: u8, url_len: usize) -> usize {
> +    #[allow(clippy::manual_range_contains)]
>       if version < 1 || version > 40 {
>           return 0;
>       }


