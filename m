Return-Path: <linux-kernel+bounces-267907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 789AE941B6F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 18:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 364FBB24A7F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 16:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FCD18801A;
	Tue, 30 Jul 2024 16:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MbMDpxGn"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C051A6166
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 16:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722357987; cv=none; b=pLDTGNUmmw56tFgzvc4eO2WsOSmOF5fpR7AI1W3jziP7YjIMNJbwum1HhPWK6me9xswgWnecWVgMDYSWS5NwidiXl7qvbQodU+dGoqQTiB2rZFgXHClrvx9EAWrPETnrVRqus1AvCcN29NVmmyavFGA5ttxGELXGUnv4/+vZnsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722357987; c=relaxed/simple;
	bh=EUzjD7lluQBrScZj0xcLKjmygOzz2eSVOsNt8rcYogQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GQzPKR4pJITQ+U/O9J2kI7DJYG9UOJGPLAhb17C4runDqVqyk9jm/mmQ7m8+EAVdg9RHgaqWtE/G4WLtOBg+LLTWlh21/XSNktG2kbGx5LkMfoTJ422TRxUW9OvLpinb8anACWotTg+Oceft/14C4MHWNmbYuEPy4wATITWVqQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MbMDpxGn; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ef248ab2aeso73038861fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 09:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722357984; x=1722962784; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pVxBYu/bR4J+MlOGhpmIDPdDtiBGD9YiOgaA/MSe6DM=;
        b=MbMDpxGnbPfWosku3/wBFBN20u5gO9tRJCE1V2wH0JTjvVJBifDSBBygxaRTmd0n/D
         aJZiL2OhfpbRAP75r7IFn1kLqsPTCp58FuDpWCaQds/6Z1u1p4gsXSl3/RUYamfjFWKV
         6k3Z1tgVKbosK+c06bRbjNKR+SU1SD36BIqBY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722357984; x=1722962784;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pVxBYu/bR4J+MlOGhpmIDPdDtiBGD9YiOgaA/MSe6DM=;
        b=AQ1bGlDFEHe5S7Exp4KfGeRjSRTdMCifcpfihixl6iXXh9upnfG1Z5MKBu69pKW+JH
         MP/nFBVK3uo3lw0MXz540/n09jGOM2EYIng2GUOfC4wvsOvk0Lk5tR8JNLEpmm74nSnQ
         zGf7m07t+KtLBiq/sztB/lJeFloWXElggBcb4kGrrqR9nUWzjN9RPLrIiE6f22i/BPOo
         PI7TRivXNsFyrI/BGU4h4XVw59Quy3Sz/UmyRQ5immooWKjg98CEX+0pVrj39Szzbzm6
         vRLeHk4+/OQEorwk8I6pzDljtMh32sAG481A6FfBR54AvqdenJzYmBFmzTynnqWyIo8c
         QKoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWH21z6A5aJ8SNgQxZoEwegx4ofE/fh06lOggkY/zdob046AmHMCroLJLhrjBo+DurNiMvzBTNlgW83YOaGR4pvIMgQzuPjLVPZpFL
X-Gm-Message-State: AOJu0YwuMrO97Ybj80knW6BsRi2WIhPx184A2S8pPHi6IrR/k3Tnl8FB
	RnnnsKTr8nb1a29o8hazeRelvMoJgcz7eRYaoo1vEQDdJzMZDs4WbBVsKRQHHzBtSZCtWZ83bO0
	W8gZgwA==
X-Google-Smtp-Source: AGHT+IGiTTQ51LAo8SJTQnSzv3reyDi+TQkN04iNtRp1R5flhTQzQ874Y6wmDXIo0uaofHJEdy4PoA==
X-Received: by 2002:a2e:3003:0:b0:2ef:2dfd:15db with SMTP id 38308e7fff4ca-2f12ee12eb4mr105650791fa.19.1722357984108;
        Tue, 30 Jul 2024 09:46:24 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab4f7aesm665892566b.53.2024.07.30.09.46.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 09:46:22 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a7d638a1f27so186887466b.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 09:46:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU5xJDDAsN/hCLr2erKe8/ZKSVOjuSSJoXhFkhie65nSfLT1dCJs0nFJBhPhQprreN1jiyMU1S38Bzt2Y1P1eeYQUXYD1xd4rmj8wQu
X-Received: by 2002:a05:6402:40c2:b0:5a3:d140:1a57 with SMTP id
 4fb4d7f45d1cf-5b021285123mr11406715a12.1.1722357981871; Tue, 30 Jul 2024
 09:46:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <402c3c617c29465c898b1af55e3c6095@AcuMS.aculab.com>
 <5cd3e11780df40b0b771da5548966ebd@AcuMS.aculab.com> <CAHk-=wj=Zv+mMuqJQJptH9zGFhPXqku9YKyR7Vo4f0O0HEcbxw@mail.gmail.com>
 <b47fad1d0cf8449886ad148f8c013dae@AcuMS.aculab.com> <CAHk-=wgH0oETG1eY9WS79aKrPqYZZzfOYxjtgmyr7jH52c8vsg@mail.gmail.com>
 <e718056c1999497ebf8726af49475701@AcuMS.aculab.com> <CAHk-=wj900Q3FtEWJFGADQ0EbmYwBHW8cWzB0p0nvFck=0+y6A@mail.gmail.com>
 <e946e002-8ca8-4a09-a800-d117c89b39d3@app.fastmail.com> <CAHk-=whCvSUpbOawsbj4A6EUT7jO8562FG+vqiLQvW0CBBZZzA@mail.gmail.com>
 <CAHk-=wgRDupSBzUX_N_Qo_eaYyDfOH=VTihhikN36cGxCc+jvg@mail.gmail.com>
 <f88a19d1-c374-43d1-a905-1e973fb6ce5a@app.fastmail.com> <CAHk-=wg4ETks+pGUco4gDrRxT+1UBbFGQtpOqSxLSzvVAWpm5w@mail.gmail.com>
In-Reply-To: <CAHk-=wg4ETks+pGUco4gDrRxT+1UBbFGQtpOqSxLSzvVAWpm5w@mail.gmail.com>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Tue, 30 Jul 2024 09:46:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=whUjRyKL_+Zq2_wJNw4PaNT2uMW+eCg_PxPBmmAqSxLYA@mail.gmail.com>
Message-ID: <CAHk-=whUjRyKL_+Zq2_wJNw4PaNT2uMW+eCg_PxPBmmAqSxLYA@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] minmax: Put all the clamp() definitions together
To: Arnd Bergmann <arnd@kernel.org>
Cc: David Laight <David.Laight@aculab.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, "Jason A . Donenfeld" <Jason@zx2c4.com>, 
	"pedro.falcato@gmail.com" <pedro.falcato@gmail.com>, Mateusz Guzik <mjguzik@gmail.com>, 
	"linux-mm@kvack.org" <linux-mm@kvack.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Jul 2024 at 09:35, Linus Torvalds
<torvalds@linuxfoundation.org> wrote:
>
> So here *locally*, source_min and source_max can't be ordered, but
> what I think has happened is that we had that earlier
>
>         WARN_ON(source_min > source_max);
>
> and then gcc sees the "statically_true(ulo > uhi)" test, and will do
> CSE on the variables and on the test condition and the conditional,
> and basically have turned all of this into
>
>         if (source_min > source_max) {
>                 WARN(..)
>                 source_val = clamp(source_val, source_min, source_max);
>         } else {
>                 source_val = clamp(source_val, source_min, source_max);
>         }

Confirmed with your .config - removing the WARN_ON() removes the
clamping range error, because then there is no "move code into shared
conditional section" case any more.

That's slightly annoying. The new clamp() logic is not only a much
cleaner macro expansion, it's also *much* smarter and would find real
problems when the limits have been passed as arguments to inline
functions etc.

But obviously this "it's statically wrong in one path when the code
has been duplicated by the compiler" means that it's just too smart
for its own good in this case.

If the WARN_ON() had a "return error", it would all work out
beautifully. But now we literally have code that says "I just tested
for this error condition, and then I went ahead and did the error case
anyway", and that just makes my nice new sanity check unhappy.

Darn.

                Linus

