Return-Path: <linux-kernel+bounces-269523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F769433CE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 18:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24F59283275
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 16:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2AE1B5824;
	Wed, 31 Jul 2024 16:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JkY8w3kc"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48385171AF
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 16:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722441887; cv=none; b=WM7f7iknBpPbxAKtXmi4/4Db/yz1tEjRRviJbW2TwjNAiSZ6/Zz9aSbs+m7zF+GeEm4dibmByYHL/QP96qck+ds+1CVfetEjFIk1TIWEn4A2t7P5F7a3D9moo21Lwayp0+ZIE2oW37Xk0euc+VF+bJB88uzqQXhiLbz+OSgRFHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722441887; c=relaxed/simple;
	bh=/bLeVpK+e0dmd5q9ldXdqMghU9aFz30yulU+T5Q5OOo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gy0mAOsZtnwtIugDvuDBRFk0sxamS29UwITziMfc5zae4zi5G/e0mfeo5cjilCju75Y3Eg8Vn83bVNemWa+JbbM95rmHVze0lqe6+2Yx1PL8efSSIZwn0gwHfLbJYIWd+NHIiO84QaCGWQCHS0yMd+hF2pkQCyyvHkDXArRWjOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JkY8w3kc; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5a2ffc346ceso8373660a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 09:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722441883; x=1723046683; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+yaKOV8TmQ0VNaMsLmwJtsrXt1HeOlVVbSAymsrtRf0=;
        b=JkY8w3kcyaRiuhu84THBkby+5Dsg9vhnqRlnvz7fIAXAdyGDZRJL8ix5D8TKQ2GXYg
         7F/dBmRVc+ip4heqd5hqiQlEYd97yQ61czTW+45yQd2eA+F9Qor3hfYQkzAEPQDKSvPk
         MduIqCqsUgyw1FuC2EEnfBbrCQ16iR96d3+PU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722441883; x=1723046683;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+yaKOV8TmQ0VNaMsLmwJtsrXt1HeOlVVbSAymsrtRf0=;
        b=PE2yiCHguQbhnTK+b4hScHvLQg+J//iKnN4epNiLZMtbiL89KdQadEAr7VEAAsk0Vu
         zxUx5yakXRnkbzn48NR9G83AXDEIc2Pi2uUA3BIqv5nx/ks+2Znmnd1/2bAbuwnoUbJh
         2vndsqtf6yYCt3/R1gtq3XxZ/ePj0Ny0dqXMtFbopeZy2yLpDReVVnQV9heCmsgIeWcF
         1Qfw39HYQelSqSMnkorgn4wZYr8OiyMT8kH9BomaqguTboGAxbzEqkq1k3jwTHQ5y3An
         ClaYFCeKM4DjoaOFDqwDqL97Zta7i3PO2ntQkcEuw3M/qHWfSLzFHbQMPwiBu2DpmV/v
         6g1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVrkL43E6/PJpFGAa+7gHS3YQcRYCnHXY5ACiDQLeB2bJs//xxHRW6iWJc0PzdbtR/CasVSo55N7tMesVfgNgFLzy4tL6Afw6pp9s0b
X-Gm-Message-State: AOJu0YzNMqX1Eg79lb8Setyy+iu64zOM4iX3xy6RKMwuOz+Td4vkHytY
	ac+Q5WaMy+Yv/jGzGpxEp7Bv02dz3WHFsrQiwIxiiSaBhWn9DZz4Gts+QXKHcii/niXvKsRbjJe
	DXUdJzA==
X-Google-Smtp-Source: AGHT+IGvKBKI66dU224PTMDVzdXaqxRLcGENBmeGc7Xk1NuoS/MTU29Tyd8gIMPDRCQpxcxSp2p1NQ==
X-Received: by 2002:a17:907:3e1a:b0:a75:23bb:6087 with SMTP id a640c23a62f3a-a7d40095f19mr987090666b.29.1722441882774;
        Wed, 31 Jul 2024 09:04:42 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acadb9d9asm787399766b.219.2024.07.31.09.04.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 09:04:41 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-59589a9be92so8834635a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 09:04:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV4CaICp/4JrR0+fNAATJ8ZRRbYu7v9H5YYOGn91QX92A/Dz0mdWu7nn2QEmorOkut8aA1x6yQFfH/xPl6klBmPaBf1JJr0N7n/OK+a
X-Received: by 2002:a05:6402:34cc:b0:5a0:e61c:edfd with SMTP id
 4fb4d7f45d1cf-5b0207cb548mr11807179a12.14.1722441880993; Wed, 31 Jul 2024
 09:04:40 -0700 (PDT)
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
 <f88a19d1-c374-43d1-a905-1e973fb6ce5a@app.fastmail.com> <8111159a-c571-4c71-b731-184af56b5cb1@app.fastmail.com>
 <CAHk-=wgLsFdNert_OfCmRon7Y9+ETnjxkz_UA5mv0=1RB71kww@mail.gmail.com>
 <CAHk-=widciTZs3CCoi7X2+4SnVWrKu1Jv2uOV9+oewXGen7Q9A@mail.gmail.com>
 <73d65e2553e543069f9969ccec4ea9b3@AcuMS.aculab.com> <CAHk-=wgP+Fm=O2tYtS=3fDB7Vh+=rSYCC1mjqxcTQ=024G0qYw@mail.gmail.com>
 <CAHk-=whNTuPVeOSB6bG7YRXeYym9anS2QawRHEKRJe2MQuOPPA@mail.gmail.com>
 <0549691a6a3d4f7a9e77003b70fcf6fe@AcuMS.aculab.com> <CAHk-=whwrXgtOrr6AKQTSYSG5V820cSsMcUjRhapnoqCh+Ciog@mail.gmail.com>
 <fbdf2df07e7140dbb96dcda48d4da270@AcuMS.aculab.com>
In-Reply-To: <fbdf2df07e7140dbb96dcda48d4da270@AcuMS.aculab.com>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Wed, 31 Jul 2024 09:04:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=whwmV+gWoSLBT4w1UabxCwaS9rXkgPsTnC3Di=5nfe_Vw@mail.gmail.com>
Message-ID: <CAHk-=whwmV+gWoSLBT4w1UabxCwaS9rXkgPsTnC3Di=5nfe_Vw@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] minmax: Put all the clamp() definitions together
To: David Laight <David.Laight@aculab.com>
Cc: Arnd Bergmann <arnd@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, "Jason A . Donenfeld" <Jason@zx2c4.com>, 
	"pedro.falcato@gmail.com" <pedro.falcato@gmail.com>, Mateusz Guzik <mjguzik@gmail.com>, 
	"linux-mm@kvack.org" <linux-mm@kvack.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 31 Jul 2024 at 08:57, David Laight <David.Laight@aculab.com> wrote:
>
> Perhaps something like:
> #define do_foo(x, uniq) ({ \
>         __auto_type _x_##uniq = z; \

I  like it.

Not quite enough to do it now, though.

But I did commit my min3/max3 patch, because when I looked at it a bit
more, I realized that the old min3/max3 implementation was actually
completely and fundamentally broken, and has been for a decade since
it was rewritten in 2014.

I don't think anybody has actually hit the bug in practice (it will
cast away significant bits if you use it with just the right types),
but when I looked at it again I was like "Really? We've had that
horror for a decade?"

       Linus

