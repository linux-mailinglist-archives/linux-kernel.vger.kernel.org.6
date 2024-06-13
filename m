Return-Path: <linux-kernel+bounces-213511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4540A907642
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 17:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 514271C21F85
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 15:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FC51494CC;
	Thu, 13 Jun 2024 15:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rhhb8UeS"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6AF145FE2;
	Thu, 13 Jun 2024 15:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718291605; cv=none; b=BQcWvnNjK5YHgxw0wlAPJqCRBEEubD5Za9z3SuVLH/PZt1gVGTUiLk79NXbRJuI1oJ/4rtpiVRAvxWpSqH/uvY+xVlgMg2CbTxR/aUxJfXQtd8F8tLlon+1K+nQxuc5+wMmRTMi32nyXvhkUC1baunhN/jaUTjh2NbP119BSnHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718291605; c=relaxed/simple;
	bh=9H+YgTYmKGS5O+3bHXS0T2zCyE2mUBQG7mMq+T/+KDY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SD3ksbtNgy/4agKDefjYJXJ7HVnlNzMhzNsyJM/roiOZhY8/DebP8pcCwaXfh6CEQgqDE2OJM2sIUQAEVNnAftVn6+yb5NTDWJN7GoDSSDdqk1QEylvvOAGQw8+sIlumgEdmiKseKG6Hs5wQyaxxYNC6ZANch+gvvCJ782B8nUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rhhb8UeS; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6b08d661dbaso20559466d6.0;
        Thu, 13 Jun 2024 08:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718291603; x=1718896403; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tD51o0Y1ksGPreKO2RCSDyc0HAD564QL05nYWkEYiaE=;
        b=Rhhb8UeS/F8142gK3yBwxQS3q8EKL5XBH4pZLTtMPdRAnuCHOg6qLEyGwOB1n+vp3R
         o67CjEGKc7Czmyn/m6rFmgxHpnMXM8Nv3JrxSk1G8BROf6T75BG4EmnyI3CJPCJ9ix1u
         9umLF1h38iJCvg9H3w19YBsR/OJEXrrQE2Vl76Fbpufr85BKukBnVC7Z6+cI5p5i768i
         7nEfp+ye0b5OHnB3FiJZglqG9nyxoM9u16wUz9OP/O86LMuluHO+b7dWQQ2bplTxvVvq
         N2u7dFvwBcwE4AX5nakZ8QAxZyvi7Wg4EgsFDh30Sy+E2vFdngC56zXAMsME7eRybzHs
         HFRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718291603; x=1718896403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tD51o0Y1ksGPreKO2RCSDyc0HAD564QL05nYWkEYiaE=;
        b=ffVtc4YA7sRle42qgQU9rAl4TseL8dfIQJX9VH+rE17u9t2rZHPJKDv/fOhNSZoAmb
         0N3VATVYud2UJ9BrGewCOpGMbyD7hgOJtCacmqi5/kIBnZO4trkpxDMA/VwpU/ZUxyIy
         K6sbkCqHaHfh6cCsnNwCNkvuTX+N7LwUJHgmMDLlem9N3SuPFPtTiJpn9hqmFQ6Nms16
         sOaftPAw+O7HCgn+K5EoCkIqU8qlXkA2JJHeSWhqBiHi9P6fjWvlCWmLfTpg4DgSkIjo
         AqoC+c5NO/ty0P+LuHiVkEbri9dIZEklQpJT18YNUlJqVuu0huG3MjYe4hNgmgXfFX6d
         RPEg==
X-Forwarded-Encrypted: i=1; AJvYcCV543eJq4InAz1QgzjWnVya7LKOygmnQFgDPOS7u1KYivcz0c5fkwDGAya7MgkTP8XDZI90QQUh+29f343Laa4j6yYtGDgzPyVb+St13fQHnpN44Hew0MGufKDXgAmWQmeAr3oz2iuy
X-Gm-Message-State: AOJu0Yy1CAvvmRYSJ6oTWGAhCOHKEVWkagSExr+gPaeawE7yWqM40P31
	ZnF0iCNOqQIQBEsE+xUJN7Oq4d6Iz/i1z/UBj9LgYUPZ+a9DB8dB8Br0LZCKaEIKB8mHyaF4lN9
	woRMNffiUNWoMIhikNbOFSowMO0U=
X-Google-Smtp-Source: AGHT+IGW6rnw+BQabFawV0pm/2GpvLPrBzbXMkIgKzqD4lNHr4ky/rvWXSuj65jR7lHLZQPMM59NAef8eQa9ZzeUTRI=
X-Received: by 2002:a05:6214:130d:b0:6ad:753d:45cb with SMTP id
 6a1803df08f44-6b2a343d2b7mr49824026d6.20.1718291603122; Thu, 13 Jun 2024
 08:13:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608155316.451600-1-flintglass@gmail.com> <20240608155316.451600-4-flintglass@gmail.com>
In-Reply-To: <20240608155316.451600-4-flintglass@gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 13 Jun 2024 08:13:11 -0700
Message-ID: <CAKEwX=M4pKhWs_d9ZGvvG7N3g2RFggFj5DEidyzjHe2pivr5UA@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] mm: zswap: proactive shrinking before pool size
 limit is hit
To: Takero Funaki <flintglass@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 8, 2024 at 8:53=E2=80=AFAM Takero Funaki <flintglass@gmail.com>=
 wrote:
>
> This patch implements proactive shrinking of zswap pool before the max
> pool size limit is reached. This also changes zswap to accept new pages
> while the shrinker is running.
>
> To prevent zswap from rejecting new pages and incurring latency when
> zswap is full, this patch queues the global shrinker by a pool usage
> threshold between 100% and accept_thr_percent, instead of the max pool
> size.  The pool size will be controlled between 90% to 91% for the
> default accept_thr_percent=3D90.  Since the current global shrinker
> continues to shrink until accept_thr_percent, we do not need to maintain
> the hysteresis variable tracking the pool limit overage in
> zswap_store().
>
> Before this patch, zswap rejected pages while the shrinker is running
> without incrementing zswap_pool_limit_hit counter. It could be a reason
> why zswap writethrough new pages before writeback old pages.  With this
> patch, zswap accepts new pages while shrinking, and zswap increments
> the counter when and only when zswap rejects pages by the max pool size.
>
> Now, reclaims smaller than the proactive shrinking amount finish
> instantly and trigger background shrinking.  Admins can check if new
> pages are buffered by zswap by monitoring the pool_limit_hit counter.
>
> The name of sysfs tunable accept_thr_percent is unchanged as it is still
> the stop condition of the shrinker.
> The respective documentation is updated to describe the new behavior.
>
> Signed-off-by: Takero Funaki <flintglass@gmail.com>

Taking a step back, could you benchmark and include relevant
userspace-visible metrics to show:

a) This is a problem happening in realistic-ish workloads.
b) The solution shows improvements over the status quo.

before we justify any extra complexity? This goes for pretty much the
whole series (i.e why are we fixing this), but for this patch
specifically, since we are optimizing things.

