Return-Path: <linux-kernel+bounces-273238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D157494663C
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 01:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E08EB218AD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 23:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3331213A879;
	Fri,  2 Aug 2024 23:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VNBRRwkX"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C1A4D8B1
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 23:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722642394; cv=none; b=KvbIwXfp7by+HER5IFuC2aQNvFdFPeyBuxZN+bI+2C8fFqsi3BF20bNJKhVBXh0hAlBn2l7PHkgQYqY2+NbIqUqfaieugir0jfWJhnovHAzH14WyWcVvBhssGd92mR8D8OI1jxPicHcpgVV60gzgZYRAb7i8S8gXtBnsA5K2/bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722642394; c=relaxed/simple;
	bh=p0VO9AAFOYlOn1ibdSbRR29b7NvmxqsvTypHdjJuU74=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iYfJ2iWJroQ4NG1gwccHnHGgy4eG22x8jfE4AWGBEH/LmDsgVa8G8VFuTV1jP5drm2Cv0Koh7mlqAdRlx/98ID7w1PpAirj3IlMT28/+GFA/RXKe34Zrr2OLndLpEt7HXdtnkDt/BHpwsvagAwHfnEim3QmoKvD/JZw6h8Uu5ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VNBRRwkX; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6b796667348so33869486d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 16:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722642392; x=1723247192; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p0VO9AAFOYlOn1ibdSbRR29b7NvmxqsvTypHdjJuU74=;
        b=VNBRRwkXTIcMFnfQCunqastGEUJOQOfj4SI5aYug0DuTtqnGhz8WP5pbyKWj0g6opr
         p7Rb8OR0hggV+EBZwmRoRzVPeZUHCxgDc92dBc72KrYkhZvqhm5w7zRyzZ9m7mevuVvO
         J7eMDTCYoB+JE7Vu035FDxv8YPvTsIhvCbZUPJ7lN7qbSds87MI8WM3SxossS2u2gXgY
         /K29nNz5h15B/itnNgmh6A3NmhgQJtaY9f7z70GW1A60hvR3hza94cgUq0Ntt4I11Zkd
         TpmshTHyq6vuWrWQR8WuLpINMWAVuXwEHW8k8wQLVkcqHQpvdbnPmT7gzY9gc1IAmo+l
         0qSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722642392; x=1723247192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p0VO9AAFOYlOn1ibdSbRR29b7NvmxqsvTypHdjJuU74=;
        b=RYQD6URrVh/71Gr9RtA07sS3Y8tTGYaQvIyrqU8/x7KUp0yY+uX5K3BDZ9vE2lJaSG
         War3Kr0Z1SE0ttfWOL+EWNBD57ftb7V4c2/k8qsglMlIq08+LJbEE3jSh5qrxeRgan24
         Bh0Yz1s6TGGfbGkHLFAtBgmTnxf6rZiL7kUKZeK181fcP2cfGVW2MvANxSGaGu5JCn0n
         ugrShfX8xHkbeMarMAbMB+7j9B9LXXf0xbCP4NBVJ9VnQjfEbXUDrLr4e4x4TGD2vN5c
         kzjGuqvQMsEKReJFn4RmzWgj2CzqT34n42Twck+DsS3lfgcDwtsx8Et60w6v8p3Fo/WD
         Es1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXfMTjkVCts3P34V4vwdzV4p4uqKpmiGCe6l+G1aEZwUchEU5dCVnm8wDX05sKryzzh/CYhlSAp/pQQmaBDbwH1LeBdGrhvXUIhp0+P
X-Gm-Message-State: AOJu0YwhtGIWFs21N/qi6UbdNlv3A7WhGoiHdsVhB5eowY1UtKDTsr0H
	OvOWPHdfoioTnp59okpkT3UJSMa8RsY1XpaySFFe/JNVUWB/GDjco+OteOAW4bONeYHCbz5urrT
	C4lL4f9GyquALetXIpR/zyhqcdvk=
X-Google-Smtp-Source: AGHT+IFwMz3O8xmawpkf8NI21HuJZvxuz4Wja2a9+ySclVPYbM7KegxgC6/pV7sIOXHUT8helne+EdXuWok7C9+RK8M=
X-Received: by 2002:a05:6214:418c:b0:6b5:82e1:f89e with SMTP id
 6a1803df08f44-6bb986d510fmr99842366d6.9.1722642391786; Fri, 02 Aug 2024
 16:46:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730222707.2324536-1-nphamcs@gmail.com> <20240730222707.2324536-3-nphamcs@gmail.com>
 <CAJD7tkbQMB1RBr1mDb_Ye+wvk97mD1D-+uFAxOEw0ZRLZp1yRQ@mail.gmail.com>
In-Reply-To: <CAJD7tkbQMB1RBr1mDb_Ye+wvk97mD1D-+uFAxOEw0ZRLZp1yRQ@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Fri, 2 Aug 2024 16:46:21 -0700
Message-ID: <CAKEwX=PZy8FdBajsW3ai4CSrXfNzR5zAq28KwUVt92V4KgYtag@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] zswap: increment swapin count for non-pivot
 swapped in pages
To: Yosry Ahmed <yosryahmed@google.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, shakeel.butt@linux.dev, 
	linux-mm@kvack.org, kernel-team@meta.com, linux-kernel@vger.kernel.org, 
	flintglass@gmail.com, chengming.zhou@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 1:02=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com> =
wrote:
>
>
> Hmm, but there is a chance that these pages are not actually needed,
> in which case we will unnecessarily increase the zswap protection.
> Does the readahead window self-correct if the pages were not used?

Hmm yeah it's kinda hard to predict if a swapped in page is strictly
necessary in this context. We don't have this information at the time
of the read.

That said, I think erring on the side of safety is OK here - my
understanding that readahead, while predictive in nature, only gets
progressively more aggressive if we get signals that it's helpful (i.e
the memory access patterns display sequential behavior).

I think we also accept this slight inaccuracy (i.e for pages in the
readahead window that might not necessarily be needed) the in
workingset refault handling behavior. Could you fact check me,
Johannes?


>
> > are also incrementing when the pages are read from the zswap pool, whic=
h
> > is inaccurate.
>
> I feel like this is the more important part. It should be the focus of
> the commit log with more details (i.e. why is it wrong to increment
> the zswap protection in this case).

Yeah this is pretty important too :) Maybe I should make it clearer in
the patch commit.

>
> Do we need a Fixes and cc:stable for this one? Maybe it can be moved
> first to make backports easy.

Hmm.

*Technically*, this is broken in older versions of the shrinker as
well, but it's more of an optimization than a bug that can crash the
kernel, so I don't know if it qualifies for a Fixes tag?

Another factor is, under the old scheme, this does not move the needle
much - at least in my benchmarks. This is because the decaying
behavior is so aggressive that incrementing the counter in a couple
places does not matter, when it will be rapidly divided by half later.
This fix only shows clear improvements when applied on top of the new
second chance scheme.

I don't have a strong opinion here, but it doesn't seem worth it to
backport IMHO :)

