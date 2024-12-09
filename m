Return-Path: <linux-kernel+bounces-438536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B70A89EA268
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 00:05:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6E081884A9A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 23:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0AC719F103;
	Mon,  9 Dec 2024 23:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XvLtqUXn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CBF19D092
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 23:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733785524; cv=none; b=foTYHTnzrwXJer75U8qpS3QuVI92hpb7fRrghjmXlaHR3yTYlP/XWrtDIcXBnRyb70t872iWpUwnZlV6ps7j3sm4hy05tDjismgUDo2moJ7/4h1t3sAG65P6Ctk0WKREzXV2mOsRUAeKVtFxH/0hFWT/8gYPAEl+pi4uG4zvTFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733785524; c=relaxed/simple;
	bh=E2wMVt4XnzSAoCFwFJpocVejZtumHBk9+rnpvzMGxW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VfujxVlJ2L22ekYcpVFFkBaBzjVta5EpsuIlpfR9Sp6tuCrsqXgHRJKDP0/KdLecwPp35Yoa3VOE/7aIKddmqEIprAxvWHpifYuLcvSWtDSOz2Xu0qDxvKv7ckm2IpHuvAhNxDHXMW8TGmyZ4BYE0+4i/C3+uh+AMOPJC58Ua7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XvLtqUXn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733785520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rtXPjJ/UW99vVDZpFTpb2RZPeH7PKMqMj5zaKL4gx1k=;
	b=XvLtqUXn6BjsXb+cYRbcitxs0LFn/xinknuw7IsVp4XjBxhv3KlJahOtrZxBklKqeaVhm3
	+OFkm/ol080fqQ7zaRZUsASXyOSKXzujafIdQdu3+k3UWHQnFmjcQmQdIjknYnS6XhPwMO
	RlGTmrtwUyX2y6kDSN9kamruYHc2DOU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-5Qd1UnynNSG2n6iOiLw9kg-1; Mon, 09 Dec 2024 18:05:17 -0500
X-MC-Unique: 5Qd1UnynNSG2n6iOiLw9kg-1
X-Mimecast-MFC-AGG-ID: 5Qd1UnynNSG2n6iOiLw9kg
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-434fa6d522bso6976435e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 15:05:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733785515; x=1734390315;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rtXPjJ/UW99vVDZpFTpb2RZPeH7PKMqMj5zaKL4gx1k=;
        b=E4R5HEJ50WD+muUECku71VD05QhVu58IMRkhK+mvbr51kLRfO6Jz682stUzv6LwMJ2
         yeWVFpylHr/WrZe0OMHgakm/LBydR0Tl4hhFwmJQJEjSilESkzRPH6ctRhktEfOMxvbf
         UScMAf6oH59BbkOLW7Ox/a0jjkzwqnsRL2ydT9XA0oOiGC6NWjvkXrl4cLvWBlR8ENn8
         ai/C/l86EyCRVMEbazvZnrCeVpBldeVo2NnvO2XnDtG2gb/Z902bQVnGcWoJvGUXTBty
         eY+bTtC53vZ5WVUTYeCssnh/QTgJA2AHUBoVubDydr/0iOAm9PU9BnEm4kWtPwBI22rT
         /Wfw==
X-Forwarded-Encrypted: i=1; AJvYcCWiLzINS8tUcBujpkGhHY21Wsg+nlZ+HosnJ+iISKdNOm3BUH5G0VaMHGaitG6OCypuj86+Ck0YVlzudX0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwzYLH17cK9qrEZ6lUOUsydVMKo4Rav5QBmvd9vitv/F7VtK53
	hOjaMqMIUIkjWnTRt6q15QlpjtMncKpP2YyHpIHVcdYfV+wXep7yEslZSsYiA7j6C0hS1b43yfp
	BqBrCAeq1UGEAd7rqK1F+FbemDpQPx2QPiHWZbgEIPCf9UNao1SC6bo24kDxSnA==
X-Gm-Gg: ASbGncvvA6IJ3dTzIaGvMKkvKvMR4a2YAasxFezujVXh61cX4nNHMWvSlb37wcyMbpZ
	Lj0YocJz1ivSkFRO8G1k0ormc/MQ85Rf24LMRzQaSGt4qDFqAkWEK1Sg9QitIHbbucsfH4ufuvY
	yFkDhys8vIp/PUx5ARTUj8QzWqWNLOf7Afhpf/wmP7jxew7od5zGEEA5Y8WbcC8tCsf2O0U5K0i
	Jlb4Bl72gEzbiCmyEQBU9tu3wwUQ5rl9NLwu0YvkA6M1HxMwgjWuOHQkBcoVCOsDMOKYMZmkuWs
	PmzmfVbR/6ELb6Amjw==
X-Received: by 2002:a05:600c:18a6:b0:434:ea1a:e30c with SMTP id 5b1f17b1804b1-435021d9c95mr8234805e9.13.1733785515311;
        Mon, 09 Dec 2024 15:05:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IErGKM+mO4OjrHPaFMSgaVoG1GHOIII5oaFReyZQhrk1MzggllJFKQWOp6TcUYxwWwXNWck1A==
X-Received: by 2002:a05:600c:18a6:b0:434:ea1a:e30c with SMTP id 5b1f17b1804b1-435021d9c95mr8234565e9.13.1733785514969;
        Mon, 09 Dec 2024 15:05:14 -0800 (PST)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38636e05568sm8337911f8f.39.2024.12.09.15.05.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 15:05:13 -0800 (PST)
Message-ID: <e544c1c7-8b00-46d4-8d13-1303fd88dca3@redhat.com>
Date: Tue, 10 Dec 2024 00:05:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/panic: remove spurious empty line to clean warning
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 patches@lists.linux.dev, stable@vger.kernel.org
References: <20241125233332.697497-1-ojeda@kernel.org>
 <fe2a253c-4b2f-4cb3-b58d-66192044555f@redhat.com>
 <CANiq72=PB=r5UV_ekNGV+yewa7tHic8Gs9RTQo=YcB-Lu_nzNQ@mail.gmail.com>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <CANiq72=PB=r5UV_ekNGV+yewa7tHic8Gs9RTQo=YcB-Lu_nzNQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 09/12/2024 22:05, Miguel Ojeda wrote:
> On Tue, Nov 26, 2024 at 10:04 AM Jocelyn Falempe <jfalempe@redhat.com> wrote:
>>
>> Thanks for this patch, it looks good to me.
>>
>> Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>
> 
> Thanks Jocelyn. I thought DRM would pick this one -- should I pick it
> through rust-fixes?

You can merge it through rust-fixes. I have another patch [1] under 
review that touches this file, but it shouldn't conflict, as the changes 
are far from this line.

How do you test clippy, so I can check I won't introduce another warning 
with this series?

[1]: https://patchwork.freedesktop.org/series/142175/

Best regards,

> 
> Cheers,
> Miguel
> 


