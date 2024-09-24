Return-Path: <linux-kernel+bounces-337669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34996984D49
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 00:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E87D228182C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 22:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24102146D57;
	Tue, 24 Sep 2024 22:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b="djbVBHLr"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C495913DBBC
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 22:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727215389; cv=none; b=YGkugNv3sbT3DfCxwJGfUblJcvXuBZ0gBJ606DQiJf7GqYgFMS9JqyBOaYqsZ6xZ1wnHH6Ft2+Xj8NSeDpoiyZL3eZtkMqpyfPwPkfcgAZ8pzefYo/wXrcOcxZ+eteS6AbeQssFyX5Xhjo7J1HQBW8Wfog9PV57ExboYQ/g9i3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727215389; c=relaxed/simple;
	bh=NsZrdsG+uwrLVvS5FWIhBRuHHog4+l/Yf5EAxQLtzhs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WVYlZ9j0JkzdFu8797qrJtDB+KgNqcfF54t1ax24uqxoqrD9Ww8/ozCG9ZdSvBQQTxyCDe9ASdzEeBlmP7ZKq0djFQyV0StZtn1KKf0rxkU7F5/WjqSo/AEmncpF/3idcu68t3yjW3s/rWloqm7KyiysG9Vl8TSN8+So7Gd9rHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org; spf=pass smtp.mailfrom=fooishbar.org; dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b=djbVBHLr; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fooishbar.org
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7a99a46af10so627244785a.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 15:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar.org; s=google; t=1727215386; x=1727820186; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NsZrdsG+uwrLVvS5FWIhBRuHHog4+l/Yf5EAxQLtzhs=;
        b=djbVBHLrcuojBXGYJbM/DhCPfqFxPFaWJW7Bq8aGqE0nekN5bf/AH5bvrMb80X0vMi
         jPV23fsa3AdGutjCpwkvGnOhl94/LlXfRN7JdCn6LpvE0sEw6pCHr2M8ZZesOOXMxsS3
         nl7ZbdJgxlYhh16lOjd1NUokMbgEOqWhXNikdCbKpN64zyCBkk64G4kW5zcf55nAJrsK
         57YNvHPmZP/GWLmEQDtx4Co2smjvuZjjS/mY5xYkxM0tbuqG/G86Qvpje6OWF3C6Kxop
         xIpsJMnBt1jiyaySttZFx5YeY61nIsE5poxNyRhwg9Dze+Mlk8ggciBnkJMOjku6gozp
         kPpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727215386; x=1727820186;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NsZrdsG+uwrLVvS5FWIhBRuHHog4+l/Yf5EAxQLtzhs=;
        b=XwEAFsbsa6k/agtRuKcTh3FaSU1Zo039DE1FKfXv9PfIJjgNuvuFI5aft37JTSmsz0
         Y/HMydhYwgwT1xareQGB9myD6WqXHteY/zsWu0dW/RIfz+G10bk7/LaGJTkEjFJtQDLU
         AVKP4OTC6eNhmVYip4Vf6UajPcLHLVR/G4X+dwXkHXnWAGeH2QzUAA27Yfv2n/4/TZjt
         H92l0T7ReJ40hUKzGBdDTPd2Yv5mxxtIhf9gOr/s8npgnZ9lKj65v5lE2hQwlPR2+tMw
         sV6FDm+A9bTuz0TPXk5yS7LiToid/NA42Smr62fAef0rcNhAbgaYh7H5vRYTRgeJmKxR
         FACQ==
X-Gm-Message-State: AOJu0YwHxYqGmH/0UE8oIHMXuJOMhALzPtfM/EQuufw69odhppnyOZao
	X+SMnMDBR6lPc6mxMuCgG7+YUAmK17UbGii3yAqWWbtLRivpq2UX5vErOxIirycUB+SCRjiz+Vp
	QmHvgpxCoeyLy/tbdxVG7Uo73e2IMRyCLcj3pjeRe0YbAC9+/7x8=
X-Google-Smtp-Source: AGHT+IElqfXPuPng8AojlDDF2C6GLMgjgq9uYfkfDW9uAzUUN373GhIZBRXCnSZ4eftp7Scr+RM/AU3bO+2aPn4itIQ=
X-Received: by 2002:a05:620a:179e:b0:7a9:be7a:9220 with SMTP id
 af79cd13be357-7ace745d94emr87761585a.60.1727215386507; Tue, 24 Sep 2024
 15:03:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830070351.2855919-1-jens.wiklander@linaro.org>
In-Reply-To: <20240830070351.2855919-1-jens.wiklander@linaro.org>
From: Daniel Stone <daniel@fooishbar.org>
Date: Tue, 24 Sep 2024 23:02:54 +0100
Message-ID: <CAPj87rM5LSBEdMECyh0WTkjWWySDv2_eyqj7ew_qU7xQ5LEdgA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] Linaro restricted heap
To: Jens Wiklander <jens.wiklander@linaro.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, op-tee@lists.trustedfirmware.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	Olivier Masse <olivier.masse@nxp.com>, Thierry Reding <thierry.reding@gmail.com>, 
	Yong Wu <yong.wu@mediatek.com>, Sumit Semwal <sumit.semwal@linaro.org>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, 
	John Stultz <jstultz@google.com>, "T . J . Mercier" <tjmercier@google.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Sumit Garg <sumit.garg@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Jens,

On Fri, 30 Aug 2024 at 08:04, Jens Wiklander <jens.wiklander@linaro.org> wrote:
> This patch set is based on top of Yong Wu's restricted heap patch set [1].
> It's also a continuation on Olivier's Add dma-buf secure-heap patch set [2].
>
> The Linaro restricted heap uses genalloc in the kernel to manage the heap
> carvout. This is a difference from the Mediatek restricted heap which
> relies on the secure world to manage the carveout.

Calling this the 'genalloc heap' would be much more clear.

Cheers,
Daniel

