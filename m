Return-Path: <linux-kernel+bounces-541288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5152CA4BAFB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 10:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C67D818927A4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 09:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997041F0E5B;
	Mon,  3 Mar 2025 09:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FT4+r8Sf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D841D63C0
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 09:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740994907; cv=none; b=Fa6r18CRZkzrKzdor+x4kQIBQ5bAbn0wZldfhPh+76ZcgIAUeOPWdjKDNhVPgnlgpbQvmYfGm6CzhwvvukQjN1eFzz3h//PS7hwqPdL/+TV1dzrXkNRt/jkT8GHx0LZRyY5xDg7fvo5un2v4Asm9bCglh1UPBGr6/xSywInmHSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740994907; c=relaxed/simple;
	bh=kGP9kieYy3EZ0kvFmMM0hh/2O/yfpgHUuO7Mb3OLz+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QAP18MHuJ8V3H018aTHSRKIfialwwrg34tqxHXXjmv2fUfdquxC9CoLsGe6CZWeHlca+zSs02xWmpZSpU8ugyzn4TBxb6qTfArRoGy1Fm64gGHKZrIt9MO9n/1meX5wwAuT8K9yrUXTsp2z2uUezco04AQhCpkMzmaMITN6thQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FT4+r8Sf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740994905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LbnZQEekEL5+7VJfe+tKFsSed1V7olIdl++NfvcMfSE=;
	b=FT4+r8SfETadyZT/B7V4HPSUTD5fy9hXFO2K9/8OPY8XM1+h8zFvxvoXEkJUXWCPh0R6BM
	azmer92AQsV5uo4BsIEnOGH1V6TNE5fIGl1dllCuSmvM0CsJiEN0uwIgumOcly98Gh+c1V
	P+ibXJxVpxJX3JEhHgYVnuR33DhjiDo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-6tLhfodcPgGjrPs1CBoUQQ-1; Mon, 03 Mar 2025 04:41:43 -0500
X-MC-Unique: 6tLhfodcPgGjrPs1CBoUQQ-1
X-Mimecast-MFC-AGG-ID: 6tLhfodcPgGjrPs1CBoUQQ_1740994903
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-390de58dc4eso3908379f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 01:41:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740994903; x=1741599703;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LbnZQEekEL5+7VJfe+tKFsSed1V7olIdl++NfvcMfSE=;
        b=is+WdJbNPAkhj8z2PX+Zpeo30ds2sBw9W8bAHTSdE9iQHky25Xl5T0aIajr7g1+sFm
         K4AMLHktFjkzKWgltcl4OI5u7xhF8OjVFtDQx1pc0LVu1jNMpXvBzvynCiO0CxkLCj17
         m8kgKSz5ees2OFfRWe4HBff7PIgmMsXcrgXqMnHtPfwFYAIUX+NwhDUYJo8Q6Ii0c5AD
         uh3n3v6DGrb4FeD/Y+It7KMtHDnDvDkB4OPdVB1fzXF/YcNq9QPeNdLu6F7ANVBe8LX5
         7g810Vv/TQ/oGldV0BeGUsrF1rXuj5sKG32sW9m/AsKBk/RpW34sPJhkPCkwiiZ9EXhU
         INYA==
X-Forwarded-Encrypted: i=1; AJvYcCVS+O5WZisQlHjGcex4+s3u5MolMILLkg1b9/MUQSXqmxYJWL/q9+MaZNyhfeX8Po35BqrZReXghhuXTjA=@vger.kernel.org
X-Gm-Message-State: AOJu0YznVz6K+sT4+Bk1a2XBDEV8hw3hWORIUAZyN+vnHw41XBxbZZRv
	WTxB/K0Ej8mhd2WHbRYuaIKyrWxrlhbVmzubq+HZfRlvJfr9bNJdrAGG+79MOXZRjOO7CDQU2sA
	eqcycYdVu8STjEpB884rYEUZHcXNVCJKbeUMEXyZ6Qt9MDa47AZoLB6/L+6n8oQ==
X-Gm-Gg: ASbGnctPXi+797959ILg9D+MfjQ5eDLEGVPdbaCxJleoDgGz+qYraV8255A6gTdfyS/
	qt8wRphtvEfKkW5n3QNBDJTW9WXKDvk2b+HIie7rjiOAKlw54OVfMTJo3bQyoq+ClcmwYs8eTns
	FyQoYcnImUQ8wkjyod43RYeOx0NHBE/dRkvzwXYsxqlmyxV8SqxQKo1P4f264m/XkmplylE6u27
	cDs8ZJjzNg7HGygiz+d+hIxmvUxGEelDvI6TfV/gym++Saqmug0YScPNfgiiEleXQ694JnEFNsb
	ny1xjTpUvag8SjPiBI3M+Ap7tDcsZROFubgKYxELUklXvVHr8OssTh8=
X-Received: by 2002:a5d:61cd:0:b0:38c:3f12:64be with SMTP id ffacd0b85a97d-390eca06cdemr10490968f8f.35.1740994902689;
        Mon, 03 Mar 2025 01:41:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFVizEggt0+gnRtA0jge53v3XHkF35Zs1QmzZY9VyL57FFl+Hjzngtfu34rhJup5F7TcFTjTg==
X-Received: by 2002:a5d:61cd:0:b0:38c:3f12:64be with SMTP id ffacd0b85a97d-390eca06cdemr10490932f8f.35.1740994902233;
        Mon, 03 Mar 2025 01:41:42 -0800 (PST)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e4844a16sm13917054f8f.79.2025.03.03.01.41.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 01:41:41 -0800 (PST)
Message-ID: <eecf227f-8f79-4572-95ae-7370f907579d@redhat.com>
Date: Mon, 3 Mar 2025 10:41:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/panic: fix overindented list items in
 documentation
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
 <20250301231602.917580-2-ojeda@kernel.org>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20250301231602.917580-2-ojeda@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/03/2025 00:16, Miguel Ojeda wrote:
> Starting with the upcoming Rust 1.86.0 (to be released 2025-04-03),
> Clippy warns:
> 
>      error: doc list item overindented
>         --> drivers/gpu/drm/drm_panic_qr.rs:914:5
>          |
>      914 | ///    will be encoded as binary segment, otherwise it will be encoded
>          |     ^^^ help: try using `  ` (2 spaces)
>          |
>          = help: for further information visit https://rust-lang.github.io/rust-clippy/master/index.html#doc_overindented_list_items
> 
> The overindentation is slightly hard to notice, since all the items
> start with a backquote that makes it look OK, but it is there.
> 
> Thus fix it.

Thanks, it looks good to me.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>

> 
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
>   drivers/gpu/drm/drm_panic_qr.rs | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_panic_qr.rs b/drivers/gpu/drm/drm_panic_qr.rs
> index 8bb5e52d75cc..6903e2010cb9 100644
> --- a/drivers/gpu/drm/drm_panic_qr.rs
> +++ b/drivers/gpu/drm/drm_panic_qr.rs
> @@ -911,16 +911,16 @@ fn draw_all(&mut self, data: impl Iterator<Item = u8>) {
>   ///
>   /// * `url`: The base URL of the QR code. It will be encoded as Binary segment.
>   /// * `data`: A pointer to the binary data, to be encoded. if URL is NULL, it
> -///    will be encoded as binary segment, otherwise it will be encoded
> -///    efficiently as a numeric segment, and appended to the URL.
> +///   will be encoded as binary segment, otherwise it will be encoded
> +///   efficiently as a numeric segment, and appended to the URL.
>   /// * `data_len`: Length of the data, that needs to be encoded, must be less
> -///    than data_size.
> +///   than data_size.
>   /// * `data_size`: Size of data buffer, it should be at least 4071 bytes to hold
> -///    a V40 QR code. It will then be overwritten with the QR code image.
> +///   a V40 QR code. It will then be overwritten with the QR code image.
>   /// * `tmp`: A temporary buffer that the QR code encoder will use, to write the
> -///    segments and ECC.
> +///   segments and ECC.
>   /// * `tmp_size`: Size of the temporary buffer, it must be at least 3706 bytes
> -///    long for V40.
> +///   long for V40.
>   ///
>   /// # Safety
>   ///


