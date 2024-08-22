Return-Path: <linux-kernel+bounces-298012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A6495C06B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 23:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71532B21892
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 21:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737981D1740;
	Thu, 22 Aug 2024 21:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jo2zT9/y"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF63A933
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 21:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724363208; cv=none; b=M/cGGQP7RUsVF2HGBxnp4WevwvvgeyuiSTHZY1+KTU5GO1b1oO8ZV69oD89sBcAIm2PTOWJolDgF5dIgSsduSnAhErFPVxsPlNudYzsTdv6Ge9gHqfNK62QFy8y5V46rAVGG3JYH8NEEr4gzKw4DqVJHBBpNcRzJxmjy8dlr7Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724363208; c=relaxed/simple;
	bh=2ObMnDIQZlaNLUtvENvNnRW6RrF/I2xgEC9S7H+saKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BaXMdo9ozRhRkFSAMqE06o6ryrjEYqUlIP8p6fX1tmWS3BpshD2XLtjacnJ6Qt/nW//BdEXLfeve8l8JSMf+HlV1dJ+NVsYfXWpYkAEI+zk3DJP12CR+pZq+diNNsQUAu6V1poHGhidTWEImc7PYZ4pAhiuAFPqiCRn706BU9K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jo2zT9/y; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4280bca3960so9276215e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 14:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724363205; x=1724968005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ObMnDIQZlaNLUtvENvNnRW6RrF/I2xgEC9S7H+saKg=;
        b=jo2zT9/ySnVhuamBU6jGEmXDijbBEtHrgXHiCchDfx/uMq73kdVi5XSXX2XmSTJ/Uf
         vS/SLSayDpyEX09AStaF/jLfjAcVFA14UdujMJusZyxaPXi9MPZc+gqYqLLL9UY4gYk9
         7q8PSngUkE2ppLUIV6dKsN0y+99V0lhO1FiCONftDLOfGWwey58WUbCsmWnUpEuQg6hm
         TIBqrpKoPhGORwBxNJOIauKD6+w0e+Txghr8UUj7reTuYW9hma+SSsTNO7P9qNt9YsMa
         HPY/nZbQBMULR3dezPyzp6f+IumdLi6Xn1jt/kvtZ4mhiYNwNfT7WIRWQ3NY82MtyJqX
         Wvvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724363205; x=1724968005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ObMnDIQZlaNLUtvENvNnRW6RrF/I2xgEC9S7H+saKg=;
        b=S2jwZ038/5yAN51/IrRcT9inJGZmoL1BUAesGKq12PAmH1W3XoSlXpCe0ovrrU7DGj
         3ypD/nh0wtZDp2vweTTS3p4ASD3Qoi638VJi/W3LEmYLDnA8qfpFSUxE4/mrcu8+n3Gl
         GujINt77pdA6+7nxOiWolmpt+r9Pnk0MgB3nFIizUgwlpIIjKiaqeAqHS6x2HW6D1lOz
         xKbXzf7HagrYWWHGet+QadCwPOH6eNiFZOs2bfLYF8DcTH10x/gQZ5PqTwtXQhhOp/Po
         sat/AwN690XQXmAHoLugEeqVbnwKz9MNWHjH70Cn9qvr1/nZIRvoU+bhZxhQheogbuax
         mpeA==
X-Forwarded-Encrypted: i=1; AJvYcCV2K6jGgjigy3tfAIQE8xmxnCJpiAkQyh6pBg6uzesY8qtNogidxZrCaR5P3rin5GUOviS+PABVzZR+Lm8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk4jkpKM4k88JeCcQ4dDwoelqfV37mFuXDrLOJ2Bgdb1A0qSUM
	ujmnB8+ZQbU2SE128HB0qq3bvgiA1Sf/nMgfYfr/8m0cr9xCWrjhATrx0+3soVWK3+PQDfTOQrU
	7Hkcouxb5zVZuIFhAtsxEwpBHoLI=
X-Google-Smtp-Source: AGHT+IE5ZG51q5aQTxFlFyKW6RddTpr1z4HSCEspsxdoq5oIegCSLiJ4/rs7Ct5ZxTCIN6NplrmjqMWejQ3LtCfXL70=
X-Received: by 2002:a5d:63cc:0:b0:371:7c71:9ab2 with SMTP id
 ffacd0b85a97d-373118e2f0fmr82331f8f.52.1724363205185; Thu, 22 Aug 2024
 14:46:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814161052.10374-1-andrey.konovalov@linux.dev> <CANpmjNM7p8-U1eh7m4vCh5M7pKODHExzw0EVtOXQRu-udb7qaA@mail.gmail.com>
In-Reply-To: <CANpmjNM7p8-U1eh7m4vCh5M7pKODHExzw0EVtOXQRu-udb7qaA@mail.gmail.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Thu, 22 Aug 2024 23:46:34 +0200
Message-ID: <CA+fCnZegmsUGgnwqtvJKyz9QxHHquGEwGbUKwQDo63srsJao5A@mail.gmail.com>
Subject: Re: [PATCH v2] kasan: simplify and clarify Makefile
To: Marco Elver <elver@google.com>
Cc: andrey.konovalov@linux.dev, Matthew Maurer <mmaurer@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, kasan-dev@googlegroups.com, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 3:49=E2=80=AFPM Marco Elver <elver@google.com> wrot=
e:
>
> On Wed, 14 Aug 2024 at 18:11, <andrey.konovalov@linux.dev> wrote:
> >
> > From: Andrey Konovalov <andreyknvl@gmail.com>
> >
> > When KASAN support was being added to the Linux kernel, GCC did not yet
> > support all of the KASAN-related compiler options. Thus, the KASAN
> > Makefile had to probe the compiler for supported options.
> >
> > Nowadays, the Linux kernel GCC version requirement is 5.1+, and thus we
> > don't need the probing of the -fasan-shadow-offset parameter: it exists=
 in
> > all 5.1+ GCCs.
> >
> > Simplify the KASAN Makefile to drop CFLAGS_KASAN_MINIMAL.
> >
> > Also add a few more comments and unify the indentation.
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@gmail.com>
>
> Acked-by: Marco Elver <elver@google.com>
>
> Just in case, did you test SW and HW tags modes as well?

HW_TAGS doesn't rely on Makefile.kasan, and for SW_TAGS, this change
is a no-op. But I did just test them just in case - everything works.
Thanks!

