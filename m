Return-Path: <linux-kernel+bounces-336104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC6397EF40
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 18:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB9AD282101
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 16:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F8619F111;
	Mon, 23 Sep 2024 16:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bZlMc4PX"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DF419D885
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 16:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727108933; cv=none; b=c9jICSJoqyc8+lOP8twcd/pdUsE3J+TCmsuqjHwgRcmrXZolNV8HCkf24AO3PUnheYbplBhzlfpMLXS/tkS5ALO7qhEtMRHwn86Hpxd1zToRabdSr8uEZ/R7UIIprPA77qaBRhuxvRoxeinscv7AVSySAtd6GXot20X/hSwVP4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727108933; c=relaxed/simple;
	bh=+T8OHCsnl0xm/aiwQxXYggnb8lS4bf/DjsuSlEb3Jmk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KhMw/n5+/aLIjSeHyAlYj2HYLCiAy8nD0v8GD0susiV9mwwf3YhE59cd3g6O2B64xF2VoU9oDclnsfLEV6OLOz8Uf1kYF28DAkY74m3pshIWu/y8yGTryp1ovQl/LndGgl/jgKZg4JOnBSVw3sG4OiXdrLxi2z3rzJX6SQ8LuTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bZlMc4PX; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a8d13b83511so557594766b.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 09:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1727108930; x=1727713730; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=D6O4DcTTpjoMkUJHje/dzaoACgQ68Lelk+k9yz/L1L4=;
        b=bZlMc4PX6m8Uum2k3gFhbTaK0zUoz8Z03/a8+1oxOHudVPEGQ1eDzOv08lVQg+c7Bu
         sGutE9EjmTkAmxN70IiaRINzGFN9QQGpgXjVigMlcliItnk06lKBxxO6789KB04mArdY
         l7oB3rYrRro4xMxI1G5MeCO+D5ovGcM9IL708=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727108930; x=1727713730;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D6O4DcTTpjoMkUJHje/dzaoACgQ68Lelk+k9yz/L1L4=;
        b=jDbZ2gBai/Q9BL7301Owk/CfE01LDYbm9j+GkIts6L3WPPnEe3VTLnIFUhJmtn4zdW
         AxdFhsjzhNsQUm9Z7n9FajbzDGFLpM7mkJlWgDxmagvgeaTFNXZuQN02zYCLGhum+xlF
         cEVqusneW19NjzP4VTdgTF6VrQy/rSJFONmE41+vrw1W/QMMoH7eoi0o2KF+hljaAdFs
         goIHJ9CMFEWsP4E7juMHlp4HFd3iy6aJE4OYghRLWYibcEM/S9tUNLnjm4G3tX2BzrcG
         1ft3fA0vWr5xfG5sjSdJKzsO3h3pp5mP0Yx492QpDHgC1NobrTbffTv2pV2EDhAlw6wp
         +ccg==
X-Forwarded-Encrypted: i=1; AJvYcCVeMV5GIoPyQIp0xxJcHA38GmZFb6q1DNuy5JuaU0obMv+OyoKqoXixfbiDp0EieLRhxVf9kC1x2P/uNdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9Qt/jmfB/plD3f15rH99H6OeHIKajCDeRGlX3BHgM42/FK/os
	/dc06xzY7bPD16IpFaiYSW6RwLqQkyIlOYA04V4GEFY7+BsSXwirg87SgD/Zj4hjUQSu0SGv6PB
	N9jY=
X-Google-Smtp-Source: AGHT+IEvIEd+DMxKDbnylibpD3IZbzJyGhdSe3FaU3phwAKZw96ZaKcY6sEhhnzJu2hLXoKTXeNoKA==
X-Received: by 2002:a17:906:c116:b0:a8a:792c:4116 with SMTP id a640c23a62f3a-a90d5925d30mr1303615266b.40.1727108929598;
        Mon, 23 Sep 2024 09:28:49 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90612b39a2sm1245852266b.106.2024.09.23.09.28.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2024 09:28:48 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a90188ae58eso570998566b.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 09:28:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVSU2+p8vXgbmVTB3YpkCKBF80ys33x6zg5pW1kpj5V/5tW6uS5PcqCbpsKvPZyPu1HUDxIfix+oCCicKY=@vger.kernel.org
X-Received: by 2002:a17:907:25c2:b0:a8a:780f:4faf with SMTP id
 a640c23a62f3a-a90d5925392mr1037193466b.47.1727108928289; Mon, 23 Sep 2024
 09:28:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912-seq_optimize-v3-1-8ee25e04dffa@gentwo.org>
 <20240917071246.GA27290@willie-the-truck> <4b546151-d5e1-22a3-a6d5-167a82c5724d@gentwo.org>
 <CAHk-=wgw3UErQuBuUOOfjzejGek6Cao1sSW4AosR9WPZ1dfyZg@mail.gmail.com>
In-Reply-To: <CAHk-=wgw3UErQuBuUOOfjzejGek6Cao1sSW4AosR9WPZ1dfyZg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 23 Sep 2024 09:28:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjdOX0t45a7aHerVPv_WBM3AmMi3sEp8xb19jpLFnk0dA@mail.gmail.com>
Message-ID: <CAHk-=wjdOX0t45a7aHerVPv_WBM3AmMi3sEp8xb19jpLFnk0dA@mail.gmail.com>
Subject: Re: [PATCH v3] Avoid memory barrier in read_seqcount() through load acquire
To: "Christoph Lameter (Ampere)" <cl@gentwo.org>
Cc: Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Catalin Marinas <catalin.marinas@arm.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 18 Sept 2024 at 08:22, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, 18 Sept 2024 at 13:15, Christoph Lameter (Ampere) <cl@gentwo.org> wrote:
> >
> > Other arches do not have acquire / release and will create additional
> > barriers in the fallback implementation of smp_load_acquire. So it needs
> > to be an arch config option.
>
> Actually, I looked at a few cases, and it doesn't really seem to be true.

Bah. I ended up just committing the minimal version of this all. I
gave Christoph credit for the commit, because I stole his commit
message, and he did most of the work, I just ended up going "simplify,
simplify, simplify".

I doubt anybody will notice, and smp_load_acquire() is the future. Any
architecture that does badly on it just doesn't matter (and, as
mentioned, I don't think they even exist - "smp_rmb()" is generally at
least as expensive).

                 Linus

