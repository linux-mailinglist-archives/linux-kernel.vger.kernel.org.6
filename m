Return-Path: <linux-kernel+bounces-364639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BB599D747
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 21:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5B211C21229
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 19:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106871CDA08;
	Mon, 14 Oct 2024 19:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IjRDkj3b"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98571CCB55
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 19:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728933819; cv=none; b=O5RjzYrhTi1Ylc8nEwVIGO3o3vPMUCSrNMERKKfYqjzNM99dskT6to1ieaYjrhnDohS/IqQsS7V89P29eh2T0WDx5lVwEbI2JHQqijvWXFTSHiqmNH/lXcARacxZbOINCjeCHYB2E9Eff/DV6zuvIU3Kc1gy46bv6Pez6HF2Mks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728933819; c=relaxed/simple;
	bh=XH0MSHzPKf/M1bjTm3mZJ/wFW21nCER+QGjM4lbcr+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Le53MASqjuxD5BMuR9qByTAoJeCqvlQtsDPXeeFbDW7ZBp9aY/ZtZcZxnkkg1NiJqNFbYcsJWUABpwLSCxQ/eDDnyVYrUl07dNNnx637M1VEFK13n28wE4PMZmGm8Q4nKB6/MgnsLZQfPuuraOWdNxzqnxItQh4duKQP+jP3CoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IjRDkj3b; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728933817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pr8kBiDDyEnpolDm4TeW3ziQndwc2QwIlDCytPXA2jo=;
	b=IjRDkj3bUEMKhnB4Ojw48lXgdyKvXyIM/d87qHJiAenmlLfSDk//3Wo+q70+W4b5RJwod7
	dWSDM2TE2/KDIhJ6WBveaxz+UML0phB7kQPoTYp1EPYzqrwfSnaOa/XJl7BeBKBePdO3LC
	M0VeAG/cQdfKcFVjw1uL2BRiURHMdd8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-CzUexcnbP4e5QEfGxsvN7g-1; Mon, 14 Oct 2024 15:23:35 -0400
X-MC-Unique: CzUexcnbP4e5QEfGxsvN7g-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-431159f2864so24026805e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 12:23:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728933813; x=1729538613;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pr8kBiDDyEnpolDm4TeW3ziQndwc2QwIlDCytPXA2jo=;
        b=LxU/u8D52m/5JY/p0HNN0Cdq8rzAb1Vxhg/A+gQ7gcaVJUQBqoA+qraGjoepcvl6Oc
         soB9N2yRndFfpZHYKVufm69a/0AOn3vPnY4ATuWNMRjm98lenKIX1lXMev/AwyV+ZB2x
         crURrPCOx4suzixe6jqs/bEkP0ToAlii4wfNSl08Q486RT7urrUAUWHP/CvX/XH2dHuR
         a/jbW87FweGRMviqv69vXPd4KqhuhtY97VWV/mZSb3rXuIyDLYayitKD/KlsV5BIhMyp
         cky8a24KPUs0E7Yrbb1/1ymW9DqO5iXTN0gQH1AYlY0b/ZP7CqMNbWxCA1XR60Xrtl1c
         cBhw==
X-Forwarded-Encrypted: i=1; AJvYcCVyBtCs4gUYN8ysPf8zD4lwNVe8aJZ2A2iFkMUsxIWMT+QMs4sSBcb9/PIbmsmiEaTwKltUPiUTNxDFPZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA2bK//MBJCpEsVQQ3iFCL+g72L7qequyyS9qV3oMrtXE/ysR7
	g8M8iYbD5YIA+/aeZ9VKiKey8pmpV539z33AdigPgidtPslOO/jMCF2uxQYgCrHLKBasHWSWN0O
	1WDugdJgfhTC2tiJlO8ytMG7W30i+SmKPoBuHAeOGiM/DRx2MsCwaPn1Im9k63A==
X-Received: by 2002:a05:600c:1e88:b0:426:5e91:3920 with SMTP id 5b1f17b1804b1-4311df5875fmr105232465e9.29.1728933812982;
        Mon, 14 Oct 2024 12:23:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbTqTqdJ+uV85hzvy4tOJlJO5ZFnRlJoc3kwSn95A8eOaOkt0awKgBPBHzu+zMwf2VvN13PQ==
X-Received: by 2002:a05:600c:1e88:b0:426:5e91:3920 with SMTP id 5b1f17b1804b1-4311df5875fmr105232285e9.29.1728933812596;
        Mon, 14 Oct 2024 12:23:32 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431182d794asm129792535e9.1.2024.10.14.12.23.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 12:23:31 -0700 (PDT)
Message-ID: <2e5e6280-eaa2-480f-b89c-c9b832328d07@redhat.com>
Date: Mon, 14 Oct 2024 21:23:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] drm/panic: allow verbose boolean for clarity
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: =?UTF-8?Q?Thomas_B=C3=B6hler?= <witcher@wiredspace.de>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20241012075312.16342-1-witcher@wiredspace.de>
 <20241012075312.16342-6-witcher@wiredspace.de>
 <13f6f904-bd2c-4b0a-914e-0715d22a7ff5@redhat.com>
 <CANiq72kE0QtiC6OjyV32r_0V2KxhtPk+-8mQGkCvtexif+04vg@mail.gmail.com>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <CANiq72kE0QtiC6OjyV32r_0V2KxhtPk+-8mQGkCvtexif+04vg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 14/10/2024 18:59, Miguel Ojeda wrote:
> On Mon, Oct 14, 2024 at 10:54 AM Jocelyn Falempe <jfalempe@redhat.com> wrote:
>>
>> With the suggestions from Alice Ryhl to not introduce a return, and use
>> expect:
> 
> +1 to both.
> 
> `expect` (here and the other ones I suggested) require `rust-next`, so
> if this goes through DRM, then we can clean this up later. Otherwise,
> if you prefer `rust-next`, we can change them to `expect` already.

I don't plan to touch drm_panic_qr.rs, so I think it's better if this 
series goes through rust-next, to avoid an extra cleanup step later.

-- 

Jocelyn

> 
> Thanks!
> 
> Cheers,
> Miguel
> 


