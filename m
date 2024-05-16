Return-Path: <linux-kernel+bounces-181351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC968C7AD9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 19:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BCC51C217C0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 17:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5721514E1;
	Thu, 16 May 2024 17:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KBoMMkAl"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1249614D705
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 17:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715879368; cv=none; b=M8ujXbA+qYENcBaOsUno2wmO0wNwVT4QQaGTX9X2msDU4V+J849H5d46sH9YO7A+0Xf0Z6cf0DVs7tQsBExOcsvLLWAT98A3I25GuTI7extBYTaBNTFp6CJiAVrBEcYm97BUBUguyPE42XOt/rcfh1enEV67vSKIkR0A4c2kjK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715879368; c=relaxed/simple;
	bh=55h9b3IC20GecaCz/OvRLDtJH28fiugxeARLWfB0kFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JhQkejdM91v2xhDRrDBZIwWWf6uiUPnG0Cs87ETwpV0ykHMe9CEuDDBrHqEubNtJqTx+vIxQf+t6OMhsF3v4oZTv0eCVl92lclssb+InAALSY4iMCO19WJWs7vIsItK+xEJwVCZ5G53+3gzGqkU+lExcbdcgfatfF+XMIHU3JJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KBoMMkAl; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-420107286ecso5155e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 10:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715879365; x=1716484165; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qQzIVlQ1gpgjynAxQQJO0srkRwgd45+RmoC324lNlhs=;
        b=KBoMMkAlysRfd/b+F0Yd31eBhqq0gaX46rIxNgoYmxHH0M4SUTj5Q5jHd0arZ66wOC
         GFCk6SM76/5KX7fuBbgnF1SUZnpXDD4DkyA0kAkenXlJcA6zoO2EeKwqQ7Dd8ZOQ5feV
         G9p44HXoxrYQwgzQNoi4HQeS87jBtiVRcuwVjRAMO2x7cT3cYygoAPMmcRv7SBJtFNO7
         M6FNi6jahlM3GcCNgsVKSONW9LHDWPVGenPbHk8oDQGl+3/lmzwbYFlfHTd+LrwLprf+
         bnL5EbXApfV3my1NpDxkj+9ZM4h4vM/LaPTctiA3ZzLP5UeYcff3moWU7Snjt8UDjZc0
         nbDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715879365; x=1716484165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qQzIVlQ1gpgjynAxQQJO0srkRwgd45+RmoC324lNlhs=;
        b=pI0B/clLvyOH4cgxhXT0x40WIy8NFHrADB1QYInFz7DVDjtOV4Qob40E8FVhRYaJCt
         q1qFVR02uykYes5PRUq11Axaqf9FuCpaU/Y/Y8P/07n6Lu+xbq+fNeVVB/42UkRwsUbc
         TrbGBOjUCyJNf2uXWwX8GTby+yZkHYLXUUt5hoDa5rbpUNc2mpdcmb9nQpOwKI4989ii
         H7SNMF2FUbLjswjejB2I2m6dudQeN4vI08quHeQDabWuxRnHlnXJrpd7vaLkivqBzkyj
         yuuvFixMzZibmxL3M0R/I1Lfuhg7pqtE+WAIHp2yHG7pYYHMpZBLDu6/XMnUxfUt89Eo
         3sXg==
X-Forwarded-Encrypted: i=1; AJvYcCXeE3QkS74AwHvNED9RgkuhZ1+2/lAy5hgeSb25P3QP0AarEEnVzVCGKlDZqoPqMdBoivSN3yNCmPvlGlOdqEyUO7nf3lAeV+saqXOs
X-Gm-Message-State: AOJu0YzO24awwMU+dWjUnhc5KENTyUwHb6RIPxsiPrfqgYG/oXtyX064
	eztuxNCme3jS/VZnN0TL+DgAaEx0SAbAmP/3rNs03AT6CsPvWUfSC8/ljXxC8BoNjZ4xkjJWnJD
	bDDoIqqSoTS+BhrA8lWbOboWSfLQZbVBgg3Q=
X-Google-Smtp-Source: AGHT+IEbIHaPpQUwsM2bGOORaLwAAJk/9w7y7+ELgEsY9rlNpgazkzZDH+eXj4VRQX5ZsmyvpnueMFsMKYjhmj/eslA=
X-Received: by 2002:a05:600c:5024:b0:41b:4c6a:de7a with SMTP id
 5b1f17b1804b1-4200f8bbe7bmr11807905e9.3.1715879365312; Thu, 16 May 2024
 10:09:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240515-dma-buf-ecc-heap-v1-0-54cbbd049511@kernel.org>
 <CANDhNCoOKwtpstFE2VDcUvzdXUWkZ-Zx+fz6xrdPWTyciVXMXQ@mail.gmail.com> <20240516-truthful-fair-kudu-adb6df@penduick>
In-Reply-To: <20240516-truthful-fair-kudu-adb6df@penduick>
From: John Stultz <jstultz@google.com>
Date: Thu, 16 May 2024 10:09:13 -0700
Message-ID: <CANDhNCqyh2ZKsOyb9rLBpUZZ+VTU8M70XBQC3aC2=G_v8LqciA@mail.gmail.com>
Subject: Re: [PATCH 0/8] dma-buf: heaps: Support carved-out heaps and ECC related-flags
To: Maxime Ripard <mripard@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
	Sumit Semwal <sumit.semwal@linaro.org>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, 
	"T.J. Mercier" <tjmercier@google.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Mattijs Korpershoek <mkorpershoek@baylibre.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2024 at 5:22=E2=80=AFAM Maxime Ripard <mripard@kernel.org> =
wrote:
> On Wed, May 15, 2024 at 11:42:58AM -0700, John Stultz wrote:
> > I apologize as my worry is mostly born out of seeing vendors really
> > push opaque feature flags in their old ion heaps, so in providing a
> > flags argument, it was mostly intended as an escape hatch for
> > obviously common attributes. So having the first be something that
> > seems reasonable, but isn't actually that common makes me fret some.
> >
> > So again, not an objection, just something for folks to stew on to
> > make sure this is really the right approach.
>
> I understand your hesitation and concern :) Is there anything we could
> provide that would help moving the discussion forward?
>

Mostly I just want to make sure it's discussed, which is why I raise
it as a concern.

Getting APIs right is hard, and I know I've made my share of mistakes
(for instance, a situation that very much echoes this current
question: the *_ALARM clockids probably should have used a flag). So
I've found highlighting the trade-offs and getting other folk's
perspectives useful to avoid such issues.  But I also don't intend to
needlessly delay things.

> > Another thing to discuss, that I didn't see in your mail: Do we have
> > an open-source user of this new flag?
>
> Not at the moment. I guess it would be one of the things that would
> reduce your concerns, but is it a requirement?

So I'd defer to Sima on this. There have been a number of heap
releated changes that have had to be held out of tree on this
requirement, but I'm hoping recent efforts on upstream device support
will eventually unblock those.

thanks
-john

