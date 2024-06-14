Return-Path: <linux-kernel+bounces-215036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A75908D88
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 16:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AC0228D38E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 14:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D6AEAF0;
	Fri, 14 Jun 2024 14:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uahsnf8I"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEAA61FEA
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 14:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718375619; cv=none; b=nYpeY5/iNNCUm2PJ0wooaNJInCcyGRfelkyHEu/PpSRCDYXVEzgooelP3MxA1nAqIDGE9uLGJSVo9kasFBm09kwj1FXNmAZ8JEt559VIgvMJR4f6IQy9X70GycEiqPO31S4VG1mWCSOo16zi46v6io/mjKnwUIerkRTzKZHFs+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718375619; c=relaxed/simple;
	bh=B+tN6RHfXKiHus8eyH21GesugJVvgcyhoJB9y21e43Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kw3VgoZ4NxCRFrNUuSpSU6MycGYFe9R5cb/+dW+Redwy08GywV+eW29q/110OiTfFCR4SGqoz/2oIdnMfZgnVlGbgU4isIN4QzqHe0NpkVwpwSE58y+J6cJGLRvboyxReZbfkgLK/yOnVvYsRAhRvayLrGwTthg127xGx7lZRIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uahsnf8I; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3608545debbso392390f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 07:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718375616; x=1718980416; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B+tN6RHfXKiHus8eyH21GesugJVvgcyhoJB9y21e43Y=;
        b=Uahsnf8IhuTYdyrS6q21UMzEPBReSwX+XMzDHGqV/rNjIgu5h0cmlQ1crXypWLMLpH
         o2bwDBFuTzNrw6Ew6tjYRRTfGM0X7RXAbYOCj57tXdj+xBsjpxndVE052kdBc2gzBgXE
         tlcPCqMDF4/M/yuTM7IwzcSZgGvtJi38nusQUcIwkbWNrtoq5d8mQ7YnJQoexOF3liS5
         QwL12ztOFLePWnCU4r7miFD6I+7cRNi+DGP6iMZ5upP2zcoukbTIMIO8AQYUKjKJckvr
         sLgy57U+kGr6mTqL//XHlQzy/PAH5+XDgbjh6LB4oZrIpK9kxfQOrb3lP2LFzHrQqZr3
         r/9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718375616; x=1718980416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B+tN6RHfXKiHus8eyH21GesugJVvgcyhoJB9y21e43Y=;
        b=Zyy3sJobB15ZvG2SW71mBPhnSRfRcNe4lH6zFgmxmjwFedVQnqTBdG8tf37CeepFCB
         PIpHa3ogo72HkxKVdwCHWcp1FdTbm8np3FyvG54vblwffPoSt9iO8eqfXcEjTPySv/wi
         rlYMb2NtXoCMZgSZfQkNxQc+ECdmywd1qwOQbmhsLlSJjkTxEtCGUA41Buk9y0chrOa0
         X0LZK+lTg2CLmS+PDARGmZkltrNsgbrosH4sRIhwKdXdUq4dwO05xWh71+uq13IULUk5
         dWstU6SAEnyI2LAu00Htz36wDqAqhmLfWow5sD9+sPxUpk5QnIYyEct7Lvv3Gmu5Vh18
         wLZA==
X-Forwarded-Encrypted: i=1; AJvYcCXHzifwBVhBQJllfPdtxfAbS16eNbgI3uTAJ3baWGXfmdtBYa07Uv67AgjZ24WM83XpCFYUYSGNdpvqUCfkdS1fWRSAYQoIm4O5Vti7
X-Gm-Message-State: AOJu0Yywvd6gTk/XPK7bwFrsUxad9yUPXbao7ktGZYyty9g684OFD3c7
	3B2uV1IIALzRevlX943EwlKRISbCENY5bFoUdnPRwgXsuIZHSv74LY0MO3PYq7dnTG05i1cppZf
	stjwGarfljrJtO8B5QTSKkv84pQo=
X-Google-Smtp-Source: AGHT+IHLTfsa1o4oIdSRq796Vw/8PgqjkD8Q4hdj+2BQ10tH3MSeZzdxAB0UATHcSuVlfNsfr0ktHmC0cbX9VZwHtvA=
X-Received: by 2002:a5d:43c2:0:b0:35f:444:8711 with SMTP id
 ffacd0b85a97d-3607a75eac1mr2347244f8f.42.1718375616322; Fri, 14 Jun 2024
 07:33:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614141640.59324-1-andrey.konovalov@linux.dev> <CANpmjNO0T-sooJYs2ZCAzFUs6NVkV7iacY=hzB0JtGAyKhEmzw@mail.gmail.com>
In-Reply-To: <CANpmjNO0T-sooJYs2ZCAzFUs6NVkV7iacY=hzB0JtGAyKhEmzw@mail.gmail.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Fri, 14 Jun 2024 16:33:25 +0200
Message-ID: <CA+fCnZfRtGNYw953NMm9s3JTsv6gNQJSbREcnbcUe6Zsgeh_6Q@mail.gmail.com>
Subject: Re: [PATCH] kasan: fix bad call to unpoison_slab_object
To: Marco Elver <elver@google.com>
Cc: andrey.konovalov@linux.dev, Andrew Morton <akpm@linux-foundation.org>, 
	Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	Brad Spengler <spender@grsecurity.net>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024 at 4:29=E2=80=AFPM Marco Elver <elver@google.com> wrot=
e:
>
> On Fri, 14 Jun 2024 at 16:16, <andrey.konovalov@linux.dev> wrote:
> >
> > From: Andrey Konovalov <andreyknvl@gmail.com>
> >
> > Commit 29d7355a9d05 ("kasan: save alloc stack traces for mempool") mess=
ed
> > up one of the calls to unpoison_slab_object: the last two arguments are
> > supposed to be GFP flags and whether to init the object memory.
> >
> > Fix the call.
> >
> > Without this fix, unpoison_slab_object provides the object's size as
> > GFP flags to unpoison_slab_object, which can cause LOCKDEP reports
> > (and probably other issues).
> >
> > Fixes: 29d7355a9d05 ("kasan: save alloc stack traces for mempool")
> > Reported-by: Brad Spengler <spender@grsecurity.net>
> > Signed-off-by: Andrey Konovalov <andreyknvl@gmail.com>
>
> Oof.
>
> Acked-by: Marco Elver <elver@google.com>
>
> mm needs explicit Cc: stable, right? If so, we better add Cc: stable as w=
ell.

Makes sense, sent v2 with CC stable and a commit message fix.

Thanks!

