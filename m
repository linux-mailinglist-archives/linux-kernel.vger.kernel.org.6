Return-Path: <linux-kernel+bounces-516858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCDE9A37893
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 00:22:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C301166623
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 23:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02451A3A8A;
	Sun, 16 Feb 2025 23:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EvYPcjF7"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75F418C03A
	for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 23:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739748157; cv=none; b=uSG2L0O1pITIMtZDd3SZpsWyNa+K2unmInHdJg591pSRDwQffeLQz87HSzt+TZ5Pt5018R3X2ocXym1/U6PQ02jBScEq/jwqddLaqmjYhbYPlaAD0EN1hwSlWnNF0hahHNs89Mmzmwiu8QrztlZ30P5SSSt12e+LE31UKW/O6sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739748157; c=relaxed/simple;
	bh=O/LB/cGzJHLa6ECkMx6rE6ZSxHn6zdjGYsIO44Aus54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hA0XpgnwPh2CIoUbCaxc6imLsvo5sSVMvCRWKQGoBtLXhMRm/anP8/tHzCipcI0KoQyNk53dlaQ0jIlHAGiJofBYRWxCqJYPhDS5NNTLnxu+QmcIPuyJngeFj5SDOdKxLPQHIJpoWo8o9EUBebuAFjTaIktALGmBnblkl+L/Ftg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EvYPcjF7; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-47180c199ebso250591cf.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 15:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739748154; x=1740352954; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YynGZg6cxhCFGGZEppb0fFoNfE9HksRCiDOsoeL4FEc=;
        b=EvYPcjF70+f5GBVMwuFfZqnWaKpxz5oO08VKw8YzqwTIpC7kDnwZkSv0g/k96j5EUn
         F9+7AUp+GpsqoY76ycCAwFwlx7qLUFSZyg2ql5pnMjmhG7gPWozahCXN/9EMyoWseq+R
         jhX2QpAoCgl5hh1MKLhvM2BEZEMLLGns94OceKvRbScL8qhHC2UQYKjWUlS56ecW70t7
         itXjDTULw+VZ769G0Gjjq8S4qMhvJ951Sh1MObzBmygC8OaJK4/pj2g6QTLy/tTHPXHk
         dhYfGj0vs6p29W/rJ/B6tcNXn07Z4N2SSbGeCjxQ292QXS3DJ4Y4rz+/jpv1mOQ/Nkl9
         +o0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739748154; x=1740352954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YynGZg6cxhCFGGZEppb0fFoNfE9HksRCiDOsoeL4FEc=;
        b=Nkewa0anoVaEkERijhfzh8C7KCTl58an59xHmghzqly8TKe0/wHk8fVpVH6+KHOAlL
         pQZ8Oi8SiNALh5CJX6DXsuNIDL7BvBonFdeCycjsM/t8G7RKzBxCpI7GW0CG406AaefX
         ZzxrPZrn/PKNZVQGZwbGLjavSMXvwhRFrPRcoicSiD4Z6ag0ywMTaRLq7/yttlpyl1xN
         qsWB3siAf8+qBuBO77ANzJDLcocqFv36CvaIzaULBzWTUbb6rOUVMaiO3YZrsVwuuSjj
         baUKZZgr962dVpCUHOBl7IJ02/MTyN+vB56dzxwSvFO1nPg/WEFFarueBWWswNs/vTkW
         4i2A==
X-Forwarded-Encrypted: i=1; AJvYcCW+Pu0QvWz/EOaboewaEuj/dIvRy/UQGEt6mcgcguCdM0PzIw9Rz4l/int8lLdjj4jR2uo8YhTSG+Se3p4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2+wzz8NwAI7rID3mPWmB49x7AzC0xjzErrIFJx6NZKVC3JUwK
	eXq4mtgmu4ZKpGYPDijOSx3l3jkngzz8cEojcUAJpjxXH8CfvUcqfFVC0QaOHKKoeGTovkxzcRC
	tNmNI6WQJs72WHnU8nRb/aHoYrXMH1lQImgLa
X-Gm-Gg: ASbGncsAkHc1lsSoyWTyHN6Lj+styJzyufhzVzlRIVgUS5BMCARDSQ43AvVLXBwl+/f
	XOujiBj+NDGd9vWvTcuRUFKY3tVL02yI5ipCjXn7ZGthk6optAk1Wl6QHlv0I4vXTfPs4bMjr
X-Google-Smtp-Source: AGHT+IFUrXQzMWLJ/pBRAra1I+405imEOBnC4CBLfg+P+i/ZYt0VDANhlJRR/kopznf79ZpQ/VPA8pjqMP0pqU8mchU=
X-Received: by 2002:ac8:5d41:0:b0:471:9ece:b13b with SMTP id
 d75a77b69052e-471dde5f658mr3826191cf.1.1739748154189; Sun, 16 Feb 2025
 15:22:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217101453.34720e6f@canb.auug.org.au>
In-Reply-To: <20250217101453.34720e6f@canb.auug.org.au>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 16 Feb 2025 15:22:23 -0800
X-Gm-Features: AWEUYZkYMAGgtHMgzOku0vJzKVRI3tVt78Kb1S3kAwmg0kTzWVRLQqQ0Fu6-qjo
Message-ID: <CAJuCfpEXqT-aHU39XMTtf-omJJUcQXtNF6RHmZ2bddqcVN0G=A@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the mm tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 16, 2025 at 3:14=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.org=
.au> wrote:
>
> Hi all,
>
> After merging the mm tree, today's linux-next build (powerpc native perf)
> failed like this:
>
> In file included from threadmap.c:4:
> tools/include/linux/refcount.h: In function 'refcount_set_release':
> tools/include/linux/refcount.h:65:9: error: implicit declaration of funct=
ion 'atomic_set_release'; did you mean 'refcount_set_release'? [-Wimplicit-=
function-declaration]
>    65 |         atomic_set_release(&r->refs, n);
>       |         ^~~~~~~~~~~~~~~~~~
>       |         refcount_set_release
> tools/include/linux/refcount.h:65:9: error: nested extern declaration of =
'atomic_set_release' [-Werror=3Dnested-externs]
> cc1: all warnings being treated as errors
>
> (and several more similar)
>
> Caused by commit
>
>   1465347e498f ("mm: make vma cache SLAB_TYPESAFE_BY_RCU")
>
> from the mm-unstable branch of the mm tree.
>
> I have reverted that commit for today.

Thanks! I'll see if I can fix it quickly. I must be missing this
function under tools/ in some specific config.

>
> --
> Cheers,
> Stephen Rothwell

