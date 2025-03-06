Return-Path: <linux-kernel+bounces-549723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C69FA55677
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 20:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F4853B3E94
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 19:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB5F1A262D;
	Thu,  6 Mar 2025 19:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L4kWAhzG"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4B626AA99
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 19:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741289016; cv=none; b=BGoMZOxfVzZgkDcn17zoZAV3POgKYNHs+ZYT21mZuTq2h6s0VH0kuJbhXUUd01e9CmyU7rrsLhE1hzeE6JkWJ1Cfz9H3B6Gqum5O/wWHaMkv0OL2s0e/DC5uCQXFh+gkbEoVeYjcGNapQbqr5mfpgWCnT961Bo+pjg1xyXD6DFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741289016; c=relaxed/simple;
	bh=B77bWisLZ7UW6vvnhicyFNus8y2Sl/Cule/1ukFqj0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ncn5d8af7EvkAYZZ/zq2siJBCmHYjm/dkErczyuOt+689GjzzcQVhDMvy8Ll+QkwV5gvyXmzWDH/sRQ4c5Ql5lb49RpbPkjsibIudjQglBUgm1ZgTf7DGAA4aF40dgjQM/YhXAGSnFf9s+13iNaJowMW7Wr80kxme4x2twpMVLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L4kWAhzG; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43bd5644de8so12684115e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 11:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741289013; x=1741893813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2gAQrvIr+bYNNhdqGRLhQ0xcRRUcFE+Gf6NthGuhegU=;
        b=L4kWAhzGTeZ2hQLpgWE7woxDnYLrerg4VCbsD4neTsfrHQgKGLHzWfuuNtaCyZvnu1
         +OwSc1epSycz78g/VzhZY56VTKYXYiDAoFdI+Xw6H6LTZ3bJFT2uo+tlAR2PCLTb9OrZ
         RTT9lYdagrmRtrUYs2re3VHIuQmanKeRFPRBLKj0wJsz9cLYEYARk3lkD5aIqfT1EgZL
         BavVdazLZqos2w9mLE51/eMSxT5R4dl+tQ0Hy+VSdnBWk52P2CSYCjgMJBcGgvD/YURP
         F/f3kjSrc+nLfCHhYjdNBUy0hC9tjU7zKqnGU14yn7yrB+kn+avnxPvBR1wOXb7zgtw1
         wuCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741289013; x=1741893813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2gAQrvIr+bYNNhdqGRLhQ0xcRRUcFE+Gf6NthGuhegU=;
        b=vaIf+vBqyyb0CHgz+PMuivVQKJK/6dr3rpqaNHgHDvrM5TnJAWKl0pp+mzjmv7KRoY
         H9/j4ff9IbA1WgSHqfE/HVfw6pqjYVQB9EAWQsmRszziFadYbKkBXjs9NLxtxjIIDlMV
         lmTFi9h9ofpe8dHmatmBzBMDRmA9LbddYG/9gZXzvOewGfNiLsBeGQ8EvwACJLBg3g3S
         wayo1UdrQPpIXHI9lSrCHHjoETNiz7CcAxCvdl0AX7rQAqUDoc1/xQfMbi1agB45Dp8f
         bQncPsrgauHJh5mpDmHF3xhRFXq6yhL3y4Jrt2V2VXFoe/on1c5Ci3u/Ouu613y5yZ4u
         Phiw==
X-Forwarded-Encrypted: i=1; AJvYcCWSP1l14Z7qBIymy98MDcKV4hQ7+WsIO0xJND4otuBiaOscEOSeOmqW0jcl0cRFyXrDOH1piGaoX1JKVa8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaRF2hk5gb1GwDxovCqGAm8GXzCzGsGX1OMt8emm2+43QKF4R/
	6mCcFG9rgnJxJ7THnPvQMxqysPNb26/zQHRcEaa4JWu6sSdYEsK1
X-Gm-Gg: ASbGncualRAtXdHyqi3DVnO37HzvRKjj37MUER9q+tgLnNeP5RJxy2zpIL+lTSEwY84
	rv9k6jWfRkQBv8FhhgBQYe0GWVOI+S/XHDHVHKufVBE4l2EY377isURGXwwQt8yNNhma58gtkLT
	XCwB8Vi0cKX7x0/zl+ObgoUfwJ499NTxub8qoloUR+/oQRsSXVgMB20pLl944d6ZoQRpgu2mcxQ
	QpYyaprfWFBamvDgsAgxNmz+clZA8l+sOduoCv6IyyB65vx5MnnRPOr42qZiy/7Z/Djlh8YMDXt
	hmhpp7/tHv3ufadxYqsUEGjzSXQP79IMqVHT//2CRePbQGkyghXILCVoSdqF4bouQHFM9l7g8CU
	xe7Iw8is=
X-Google-Smtp-Source: AGHT+IEjP2oFiUTRz96RC4nx2g0wy0+9rXiWkANqHn6bl8Asnp3/eQk8qG4py/lYov8jfs94jM5f1g==
X-Received: by 2002:a05:600c:1910:b0:43b:c97f:2679 with SMTP id 5b1f17b1804b1-43c601d07ffmr7269805e9.17.1741289013121;
        Thu, 06 Mar 2025 11:23:33 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd41c7cc7sm62259775e9.0.2025.03.06.11.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 11:23:32 -0800 (PST)
Date: Thu, 6 Mar 2025 19:23:31 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Vincent Mailhol via B4 Relay
 <devnull+mailhol.vincent.wanadoo.fr@kernel.org>
Cc: mailhol.vincent@wanadoo.fr, Yury Norov <yury.norov@gmail.com>, Lucas De
 Marchi <lucas.demarchi@intel.com>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Andrew Morton
 <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, Andi
 Shyti <andi.shyti@linux.intel.com>, David Laight <David.Laight@ACULAB.COM>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v5 1/7] bits: split the definition of the asm and
 non-asm GENMASK()
Message-ID: <20250306192331.2701a029@pumpkin>
In-Reply-To: <20250306-fixed-type-genmasks-v5-1-b443e9dcba63@wanadoo.fr>
References: <20250306-fixed-type-genmasks-v5-0-b443e9dcba63@wanadoo.fr>
	<20250306-fixed-type-genmasks-v5-1-b443e9dcba63@wanadoo.fr>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 06 Mar 2025 20:29:52 +0900
Vincent Mailhol via B4 Relay <devnull+mailhol.vincent.wanadoo.fr@kernel.org> wrote:

> From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> 
> In an upcoming change, GENMASK() and its friends will indirectly
> depend on sizeof() which is not available in asm.
> 
> Instead of adding further complexity to __GENMASK() to make it work
> for both asm and non asm, just split the definition of the two
> variants.
...
> +#else /* defined(__ASSEMBLY__) */
> +
> +#define GENMASK(h, l)		__GENMASK(h, l)
> +#define GENMASK_ULL(h, l)	__GENMASK_ULL(h, l)

What do those actually expand to now?
As I've said a few times both UL(0) and ULL(0) are just (0) for __ASSEMBLY__
so the expansions of __GENMASK() and __GENMASK_ULL() contained the
same numeric constants.
This means they should be generating the same values.
I don't know the correct 'sizeof (int_type)' for the shift right of ~0.
My suspicion is that a 32bit assembler used 32bit signed integers and a
64bit one 64bit signed integers (but a 32bit asm on a 64bit host might
be 64bit).
So the asm versions need to avoid the right shift and only do left shifts.

Which probably means they need to be enirely separate from the C versions.
And then the C ones can have all the ULL() removed.

	David

> +
> +#endif /* !defined(__ASSEMBLY__) */
>  
>  #endif	/* __LINUX_BITS_H */
> 


