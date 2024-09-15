Return-Path: <linux-kernel+bounces-330024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F23979890
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 21:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E59B3B2210C
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 19:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB84B1CB316;
	Sun, 15 Sep 2024 19:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="XHZ4JL2B"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E24C1C9DE5
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 19:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726429720; cv=none; b=gUP+e1YCXLq/wEciIda340QS6nZCNBY10ATYx47RD8vFhCWn3tpCqCiGR71j7mduAmFrwEct6fYOpJKkBENhNRdd68G+N/U2TNAgsepJYLeCqUjUqDesA4DaOT0SZPyv8KKG5Fv9+6wfc8zPDMEK87X2KatzO3GF64P229jhb7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726429720; c=relaxed/simple;
	bh=MRhzl9kpuCHu74clIdzWjSROzs8qD6POOF2vur5Iqeg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YbTyZLI6eB7enVazNkNyFEXxDAf2GkbDPF+pTOpmG3tusSghOSd+33b02kRUTEeP0WISKi+q0I3oINmVS0E5/RKglKKozlduzwo3R4zS3vI7olhAFtbaY+MrwEvtltYMiTy0Y/9OOapof2kd7NTmlJZWsuwQzFvkVgM+RUd36XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=XHZ4JL2B; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20543fdb7acso17432035ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 12:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1726429718; x=1727034518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SNp5/hnkOy9FrJ592XEPwxvQOfrqTwTwJ+m8OyrqXK0=;
        b=XHZ4JL2BWrDWa0INYH/0+J9hDTt5HGc5rkpUodSn9B7azAag0j5aaQPl29QUjk8Wo9
         i8yOIIBOXaHT7SrCSvZLiTWK5m6tk2VEWdIb4hzpo2A0IRSVwQOLSf8e+lVKkNIQ+7RG
         EcZLZxJEi0n9kqVazwke4czQ1Vz3BImNzqivyMYvC+kKiuLflkqvzyQjx5GwsC0Rybj8
         A94F6rp4lIpQed764AMj4dZ7Q2a50sPLUV1VMEZknZZmr6MIWCm3YOHF+ddLSulYUyLm
         Zu2C1GRRowvuhIVfD0A0NaT7jc3u4O49glduaBtK0Zmb+BQi7KGDTjs/1sMZBlgYYU+K
         MO3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726429718; x=1727034518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SNp5/hnkOy9FrJ592XEPwxvQOfrqTwTwJ+m8OyrqXK0=;
        b=jz4PXx30N+pRiSDFDhncpjStEj/HnHPtGeDVCf2u1DujR/BVF61DNJ33tgYwEqONeF
         hDJRWHN/hhbpZik8zAowyuj2eTwGf0K935ACYcAkNYE2qkE4p7o88JQqZEz5uNf0ipqf
         1l1EzakwL4ThQFbyy+qncyzmBx5T8NWOOOwrR5dtgv/lsxYVPR7uRQcNJ4KUnO3E+vmz
         SoKQ7d0bNZvSB9hj+zWSvFDOHQY4rzN90eVLYknklgCXCyQFbKhr8bql52CNPjX7vNKi
         Igjqnr2jG2sOfYkgpRvD02uCM+kqfvLv9J8fVDPS5POPqguQdldNys2RT64iv0Mc751A
         4bmw==
X-Forwarded-Encrypted: i=1; AJvYcCVpzAh31nIljzhlT8AO9ASOE6wNY/IwwXQtvFEHfhk4WU3G5BiNM8Wlh6zxjmawZhaupf7co9ukqL7W0kM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw4J/Y4rEDLe8W17UX/HxZtnVwIkS1LY+m5PO/DEjze3TIt8cr
	L1apxg/JH74XV5JUWJbS1jc+BXXKvNP2DktXZD2cI4KA2fqmDmm8SzDE1ggiLwerKX4WUK2NF5Q
	O
X-Google-Smtp-Source: AGHT+IEIwQjnGlDPb3oEceDakpD1b1PWW6LbBCx4i0kZt1Rli+HqyHRriIrHVS++Yfgo5DfOZzymmg==
X-Received: by 2002:a17:903:32c9:b0:206:ae39:9f4 with SMTP id d9443c01a7336-20781d5f6fcmr138044405ad.20.1726429717591;
        Sun, 15 Sep 2024 12:48:37 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20794735719sm24738385ad.275.2024.09.15.12.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2024 12:48:37 -0700 (PDT)
Date: Sun, 15 Sep 2024 12:48:35 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Jason Wang <jasowang@redhat.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Shuah
 Khan <shuah@kernel.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org,
 Yuri Benditovich <yuri.benditovich@daynix.com>, Andrew Melnychenko
 <andrew@daynix.com>
Subject: Re: [PATCH RFC v3 0/9] tun: Introduce virtio-net hashing feature
Message-ID: <20240915124835.456676f0@hermes.local>
In-Reply-To: <20240915-rss-v3-0-c630015db082@daynix.com>
References: <20240915-rss-v3-0-c630015db082@daynix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 15 Sep 2024 10:17:39 +0900
Akihiko Odaki <akihiko.odaki@daynix.com> wrote:

> virtio-net have two usage of hashes: one is RSS and another is hash
> reporting. Conventionally the hash calculation was done by the VMM.
> However, computing the hash after the queue was chosen defeats the
> purpose of RSS.
> 
> Another approach is to use eBPF steering program. This approach has
> another downside: it cannot report the calculated hash due to the
> restrictive nature of eBPF.
> 
> Introduce the code to compute hashes to the kernel in order to overcome
> thse challenges.
> 
> An alternative solution is to extend the eBPF steering program so that it
> will be able to report to the userspace, but it is based on context
> rewrites, which is in feature freeze. We can adopt kfuncs, but they will
> not be UAPIs. We opt to ioctl to align with other relevant UAPIs (KVM
> and vhost_net).

This will be useful for DPDK. But there still are cases where custom
flow rules are needed. I.e the RSS happens after other TC rules.
It would be a good if skbedit supported RSS as an option.

