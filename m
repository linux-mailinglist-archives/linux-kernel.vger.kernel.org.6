Return-Path: <linux-kernel+bounces-526675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DDAEA401E4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 22:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55AE316A3F0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 21:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87D9253F22;
	Fri, 21 Feb 2025 21:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="DggnDjAl"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976DE253B7E
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 21:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740172463; cv=none; b=hu5pvjVdh84yk+axICNpFMmYBJ9sSB9oH9zkILYCf11GUJyjZmQPSRcBCbLVS5OQ/HswY08L1MtFZnCP1GCc/98xDsfdm7i02b18yszj+hI9n+PD7rXaoqzIhEI4KsfthZeQHCzJUienz3NHvWVSXzC7tSj0xkOPNr0F2vcymgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740172463; c=relaxed/simple;
	bh=LUST0WfY2YYH8MixRvQVt0HfCogiQFfD5LD4HDRjTGs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nMPbP0CBAk7KO8vpy6T8d4pfLrFRVhMqaskh5w/g9oN9Ngn+rzfylQEzO3TBc8pCqthTpldkafdSWJz3zwi9c/3bDKJF2c9g6Sv114zur+WtvToEtMbWDEc+ustM/LYrUIzK9xlNCyVdBk9tPkOjEKOT5b+XR+6Lip400S4wFgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=DggnDjAl; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3d19e40a891so8026055ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 13:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1740172460; x=1740777260; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cl2P2JOYJNBx1mtaYBayROisqQOMPgvFm8FiItSAUM8=;
        b=DggnDjAl6GpDqoVT7yu5rvRJunyrlidW2SMS+sWDipW3UsaZSHTJ/VA+o82jx0dK3u
         gU4JLW2db0a5ooygz1bMYEJ7WKhEmi5PEOlRKNwLKp6j+nJa3+Pz0oGNV27FKH9AZOtP
         nXho8bWRQl8P8FG5iNYjLW77Vrp2LSWcw+Eria77FOmCCS02P7AxYAP9d87QNiFrGyR1
         AB3gIxiMB81VaXP7WbpAV8CNuipxbWupn9U6PcWVJUS1oPb4b3FYHl0YAT1NxssRkJy3
         cxa8AmfPxvKq2mVx4C8eo5oCV1u+WyCpnoDmFivCXMbfyeDqSPk1lyh7syNre35pubeo
         hnNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740172460; x=1740777260;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cl2P2JOYJNBx1mtaYBayROisqQOMPgvFm8FiItSAUM8=;
        b=vH9rogtHI69e8lQnR33bYC/vwZ8bPh6j+i9uaRLlZulJMHNMulMPvho4CnRegpsUVK
         eQUau4CTyi/Hkqq+MhF/boNYyixv8hLrx2HbuP8OswzowLelGsw39EkilBhh5uZrdoxh
         e9u4Opoy5pnSjr9GWfMU2Ux+S1B729n4gnhyDBzAJxkjMWcacNbXs9zpuVW7K4bWA6hC
         TKTRKdDQtqx2GLj+1ol88Kp/+MHd2VGP+pw/8+Ew6h2VSjxy40MuOpY0/aCUpPXG2WF2
         SnfIbIs/s2dVe35epOlAkq4qYn78HHeBIlld4SIF6A35MJi5CyTqRZ7tZ8ZR3wlCKIvw
         lZww==
X-Forwarded-Encrypted: i=1; AJvYcCXQ5AGchS+rThRhkdx5L83T0uGi4fguQ7ToaZqiq9VDfI1fk1qP7TFpISJHtp5TA38y18mlEQNBaxntBSE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyZMYWkg0sE86pNU/8jQZl2NbSksYU4PP1ZQKe+hJuaVWQsmJA
	kVxUda94iIwCI/kLsMJdHJpGiVc25bum1ixvuhOI/HXkea32LTFvm9AQ6bpVu+Y=
X-Gm-Gg: ASbGnctaAa9f7lb25LM33vp1PPK2wNDeAGVF/Kxv+c6+GFVU9g/PozVdAE8c1i5G/Db
	mWzy1SfgJzRMDppCrC1NCIdBsWm+oY1o4fFPvcxnHIo1QFgFVYZ9rA+R856S6aUufAAi07pnsWN
	HvFjvvPups03SFO7U32Fk3+KFs2G8LTw9nDMU6lLPD6NGMQwoqlNMZEf43n3ujbXjGdDAY400TL
	4CZc6WBzkQLiUZENFqNFzcWS5DH4e4SIemAh5bMGyzII32uuqCHH4GMqxfHOOLH8oK+LBVTxWt5
	WwAN7cdknXqUSF/iMcs2Am8=
X-Google-Smtp-Source: AGHT+IHGUx3T72p6QUiwnKjXxwo0LmjfmkSlf2+w+lCN8J9EyU2JybXz1K2UEwewJnnNAq4zeENvnA==
X-Received: by 2002:a05:6e02:156e:b0:3d0:4ba1:adf1 with SMTP id e9e14a558f8ab-3d2caf1a20emr50626825ab.22.1740172460685;
        Fri, 21 Feb 2025 13:14:20 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d18f9c5a21sm40521905ab.21.2025.02.21.13.14.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 13:14:20 -0800 (PST)
Message-ID: <3a3644d2-1762-4504-938a-6776c137aab8@kernel.dk>
Date: Fri, 21 Feb 2025 14:14:18 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 0/3] rust: xarray: Add a minimal abstraction for
 XArray
To: Tamir Duberstein <tamird@gmail.com>, Danilo Krummrich <dakr@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Matthew Wilcox <willy@infradead.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>,
 "Rob Herring (Arm)" <robh@kernel.org>
Cc: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Asahi Lina <lina@asahilina.net>, rust-for-linux@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20250221-rust-xarray-bindings-v18-0-cbabe5ddfc32@gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <20250221-rust-xarray-bindings-v18-0-cbabe5ddfc32@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Please have (at least) a 24h cool down between versions, spamming
versions within hours of the last one is not productive for (or
conducive to) review.

-- 
Jens Axboe

