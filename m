Return-Path: <linux-kernel+bounces-203541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D1A78FDCD9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 04:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28C771F2504D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 02:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B283A1C68D;
	Thu,  6 Jun 2024 02:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L0SLFfvD"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A88C18C38
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 02:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717641447; cv=none; b=ER+KaEULokxGmJbZSiomLOxymObDJJFPI2zMq8tE9T3V2SR+1c7oRvKpAo+rM8b7z25Lc6QnOk8DYf3lFGInX4jV2YvDeoUTGkOjL7AU33e3J8wpx3W0P7y5E3glzpyPEWSrzdY0p+pkOAGJgP4w32tZUv26wG+0Ss9ufNvRPOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717641447; c=relaxed/simple;
	bh=oiY2aWMnh4Ts+LK48PEMYffGEi+9hRB5M6zGjjCh3a0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V1mADsWC+jra+HC/Kfre4u0utz9jkC7oED65Mtfs0/8iG4L1iP7idtmH2VvzPzVCgGj6C7sIxuQ/QW/UdgdmwbIddg+7DX/5G6PLV9QwLB3ll7KRXmNAGpoNgNxN7wtXQOs0U5VQhCUWWLoi7qBYCKZoeM1+k0M28keYG//HZf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L0SLFfvD; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4214a7c14c1so26685e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 19:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717641444; x=1718246244; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xDq/ZYiqvUMpGmnfFROlIKqAnO6GO+2iuQr9cMLLamE=;
        b=L0SLFfvDdAn5BfnPnrkagX4mb1eb0pi7fM9zhBh2BpaauKh2ji5vASNo0F3Umm5g75
         uFVejtGoOAxGZoL6FnoD/lGVfSMSkkUtwxv/3irQKOrhcCpjo09U+s8FqUOR7qL2nA/h
         Hh9B4DvWHBhXbzndEH/z0gxMNNwr7Do50Oei0qr8GCMgq+HEPTMZmjjwnJIhJZCWNOTE
         xE2vxd18DtsTpMi627sN7mira/40hhY6q3Q9TCt7kr0HF/m+6n4OSjGUOVlbwVTMJnBs
         0GZYpWgM/OgXqYvqD15Ba/zYCFp1fVS5sj62B+IemznZplQQzdN6DQEUvuByfg3uSner
         4uWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717641444; x=1718246244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xDq/ZYiqvUMpGmnfFROlIKqAnO6GO+2iuQr9cMLLamE=;
        b=Ibk/B5PyHNn/vRNMCDa3my0uF0M9z+3vuwOJ0mWqeIjCdrCNpYxi5eeco5s0brwzja
         Jj1zVQ5DOevtzbgApsix2hcjuTn07WyHh0aTxUBNfzpZ19p+wJHfrl9CTASMPIedzx1O
         Jn5qOoZXU1cViNMYzFIqD2Ls7MceTYoJZRQMZCSE2lrYgil/eE5YVHgVgu/QXk+iPNDt
         NRTPxUEMoUkPZV2MuRmAFr/SAChmdZ2yWkcrIRgjCGBQQsPSsPucBOMznKyi1Z/Zelo4
         va48nkhqx0DaHRCYqLi4O+7ptSqmkDMvMD3i7w2TU/KPuSyquCZ7v6UNdWHu8w805sev
         QewQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDRdkVs/gK3/T132eXtsTmNWBFmWAEbRBIRD/Q7YZ0PLG0pofPztyHgCG7EYFMElABCkKPTwTxu9JNVfsSRVEwFDzRWUhI6sOB0Ie/
X-Gm-Message-State: AOJu0YyEoVxYjk62eo0HYqjUuhjZpIF7/hcZU9IxQtUkdXJiQqZAjzLX
	XYRFGbC7ACh6TgesiwFLh4UBoVkaxP1wB2yWp/rGCjXBk9LembVDDKyisH2Yb2055hhryTX+Gfv
	4ThiKxsoWe82KqVwGJCNgWNt0fJ/luckFy8Y=
X-Google-Smtp-Source: AGHT+IHaMob5QkMPplPJnTDM+qZg7pZsoKZ3tUHMJRiC4H1J40L0Caw6VHQuvDnoIsS+ROt+MN9cjAZbJk4mBEgVeG0=
X-Received: by 2002:a05:600c:3b1c:b0:41b:e55c:8dca with SMTP id
 5b1f17b1804b1-4215c34b2f8mr642165e9.7.1717641443632; Wed, 05 Jun 2024
 19:37:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606020213.49854-1-21cnbao@gmail.com>
In-Reply-To: <20240606020213.49854-1-21cnbao@gmail.com>
From: John Stultz <jstultz@google.com>
Date: Wed, 5 Jun 2024 19:37:11 -0700
Message-ID: <CANDhNCpFXKs-z5Ymy=61fTqU3aXj4sM9RTD5_sEB0937CrVJBw@mail.gmail.com>
Subject: Re: [PATCH] dma-buf/heaps: Correct the types of fd_flags and heap_flags
To: Barry Song <21cnbao@gmail.com>
Cc: linaro-mm-sig@lists.linaro.org, linux-media@vger.kernel.org, 
	sumit.semwal@linaro.org, Brian.Starkey@arm.com, 
	benjamin.gaignard@collabora.com, christian.koenig@amd.com, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	tjmercier@google.com, v-songbaohua@oppo.com, hailong.liu@oppo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 5, 2024 at 7:02=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrote=
:
>
> From: Barry Song <v-songbaohua@oppo.com>
>
> dma_heap_allocation_data defines the UAPI as follows:
>
>  struct dma_heap_allocation_data {
>         __u64 len;
>         __u32 fd;
>         __u32 fd_flags;
>         __u64 heap_flags;
>  };
>
> But dma heaps are casting both fd_flags and heap_flags into
> unsigned long. This patch makes dma heaps - cma heap and
> system heap have consistent types with UAPI.
>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>

Thanks for submitting this additional cleanup!

Acked-by: John Stultz <jstultz@google.com>

