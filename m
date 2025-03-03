Return-Path: <linux-kernel+bounces-541286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E83A4BAF5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 10:41:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B0DE3B2089
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 09:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0F01F0E57;
	Mon,  3 Mar 2025 09:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ey2MvA4m"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A82E1F0E4B
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 09:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740994881; cv=none; b=oyMP3UCjEwy2E/TJUPqudpNtgae4kK4uVIV3AgvnjW4Z4JRaDykaCdwiemLRv8nhxl0XxXtI/ZSqRVu6t0xJdaJO0BxJQNYuby+gkchZdwLk6EbBtEoQa3hjPBUqZEH6lMcrdypPTOkO89gQuU9y4tusFfMGmWsYMlyyg93tLjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740994881; c=relaxed/simple;
	bh=dQLYc6BsEprEKBA6DtRFuQ16bOaLXoXn6GQNmtYK31k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HSkOZFwhKSglhmEu31yJqLYGj5tko5A19fp9aakieJN7cbbzP8/cTvphuWRLLn+BofdGh5rQDbHrjYn7JDHngL+Z2NAHC6rs6nJVh9ubEkp0u0MgSk5jhOdlEHE8vmMuP3i3Rj7aFCs/13BZPkh4a+KOKVwJMyxKZDyj0lwylU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ey2MvA4m; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740994878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D46wI1otbQqaNSu8WnEzDU27WQjj8NKTR6dNsZngyNk=;
	b=ey2MvA4m+LItBRVSWiAE5gglusrbXjVr7A9sqyn5wOQx/TbSDwS1meWGbeM2Wy01KM3JXK
	Dos7lch4cP7WgqcoEahWYOAjaO2XVfR4foXVONzFLAF9AnXLS+TX4wLQmlAut2GAsbwhOx
	mwFutwJRlgLfxt/L7QVAIcgfCsyjd2Y=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-3-dmpDMpOcPcad8ChEORuWmg-1; Mon, 03 Mar 2025 04:41:02 -0500
X-MC-Unique: dmpDMpOcPcad8ChEORuWmg-1
X-Mimecast-MFC-AGG-ID: dmpDMpOcPcad8ChEORuWmg_1740994861
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-39101511442so455789f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 01:41:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740994861; x=1741599661;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D46wI1otbQqaNSu8WnEzDU27WQjj8NKTR6dNsZngyNk=;
        b=aMVOMrxD8HyL3GGuyPCHLxRgBILz7whceBdSGY4+PuVDMOO2uhYSjMYSmD3/RLq/eV
         WKdJ/FIGnSksKktPY5NlnT8dS1THgPuFSobr6yj/WGhgZBqteNZHp5uZMwiPZWyz56uF
         WC7DRemRbig+7ykbHOpNnVdYSKhnclW2JaSaUby0jn2TFnhK439zAofwjKivET84/GB8
         BfvS5d6168d8QGEVtN8SK0JUA8NFY7E9fq82vDjbaHVOKDuj8Yw3D5JGMFAg0bcT9qGE
         9hdI4xn3pbLjeBRkKKVx7RFNREH8Bx9Nw7KaWsci8gccUo4p4mezGKM6ehZ8mCaUqwqP
         sUIw==
X-Forwarded-Encrypted: i=1; AJvYcCWj83LzFLmfAnd2uVlBjkQnPP+gCfRNgYJvGwQcUVft7qN4N77vdmVTpZ9QGsmjo3vaL/IQDc2+tJ//Fos=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+dm/MdlKtDfjCK5KfAPKccCSgieRgjvAOD/itbtg/ZXsn+Twx
	Vf9j2GRu5K44plzyEQ64MvP7mHxxMowr/T0aWAAJlGn9SzhdN7j12Agf8oTVQp57q+hLem3EXUa
	Aem4i5XYhmZaFGhKV87Q0Pbb+2XIWnyXD6P4t1skY1aoaO+I1SjrwnTzI/yB5uQ==
X-Gm-Gg: ASbGncuAawRSwz/BPQP4c3Lw+iRcYMLUzjISNtpvZ4bdY64pip+8MeH/D+ShDzt3Mzn
	HRQhRkHaPHVoku9uRfUOY8q3Ut1r1ISJaL3vDjgHqEtS2BSjij2zqOVdqaqqamiy3FKw7k9/2jj
	yjTihBIb5PyKsEuHmF0HnJfxTUJaBZYWyu7KKxUm9SsOl7W3Fjp7ZIA/XsE8t1tSqGDA2JGExej
	Zfh2uv/phkjL9A5oIG94DLnbrxpxj9MUQq+DpsK9bOOuK1CMdCtn6Oo70kqBPjNYwUcpn55RXvD
	jw2L7Sa6ZfLJT7VJVK5KvaDIeNlGFyssXZBlLSCOEkfdzHEQcNXzJUQ=
X-Received: by 2002:a5d:47af:0:b0:391:a74:d7e2 with SMTP id ffacd0b85a97d-3910a74d9dfmr2504788f8f.26.1740994861455;
        Mon, 03 Mar 2025 01:41:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG1de8HYVkepPP08FYSHZESNB6/TmqfVP389HdGHarD00Xh+lNows9m8q7gT93iwcJAAY8o5A==
X-Received: by 2002:a5d:47af:0:b0:391:a74:d7e2 with SMTP id ffacd0b85a97d-3910a74d9dfmr2504754f8f.26.1740994861034;
        Mon, 03 Mar 2025 01:41:01 -0800 (PST)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bc63bcaafsm13675235e9.28.2025.03.03.01.40.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 01:41:00 -0800 (PST)
Message-ID: <b0dcc390-6e12-43ff-972d-1aca96fa374c@redhat.com>
Date: Mon, 3 Mar 2025 10:40:59 +0100
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

Thanks, so that's the DIV_ROUND_UP equivalent I was looking for.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>

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


