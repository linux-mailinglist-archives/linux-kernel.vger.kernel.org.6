Return-Path: <linux-kernel+bounces-218287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D2990BC1C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 22:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3452D283765
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 20:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452C51990AB;
	Mon, 17 Jun 2024 20:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="E7UVGwuX"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B929519005E
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 20:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718655844; cv=none; b=plk/+mFTvJqI9aXODZpccOlkF0m8eUbN8lmWgVp6s5rTPbS9KI/A6X5aY3Taz3FbRKVHixFxsb4ZsLvcOYVvrGGodtMd9N7r2LZrv01pZ83fG+S0OAFAT1+DxXK2viRgG+m7RVw2r318hN7Swb6ga4B0ddWoulzfrJO959GC6m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718655844; c=relaxed/simple;
	bh=zkHuXWx8sTa/oNFKVsylABjyDEiMRGafzuDbOPJQ5wY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=objaOZEAi/FAT3BE/9Y8t9iEytgDvEemFx11sGn4P6yigu+yJJCRghMTN37Uvf/UZ13NC5bREWNFATmqRb0WlsjCmu9dcS4KcxBKLPIgYjWYdKIML1CrIwCMk2YptcSXG4cvkvFPRALumCw2xlqtyhUCckWuCA82dKJYyI70/w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=E7UVGwuX; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-57ccd1111aeso2574716a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 13:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1718655841; x=1719260641; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=htUQv2quqma4VO2V330/QazjqgtbFEOYp5UR9RkEEGk=;
        b=E7UVGwuXeO17nlxTabAgDSAmM1Zcsk3Kyqprvi04Pqvbav1VlEQZsg8OGAOrCoYVUk
         Ux94QgQ57NGMoaJQb2n/gTb39kq1psHfFgzxGrpV6C0VGdWPDRGi6+L1FB2ZUvF8QlOr
         GZWgMMgU1TJRyGlQQr+NGWcx6VT78faj1MIOg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718655841; x=1719260641;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=htUQv2quqma4VO2V330/QazjqgtbFEOYp5UR9RkEEGk=;
        b=mCGplzt1aJ/2s6o8mqa1umiQeFNBHzj/onqqZjqWVqlu/Y2m//zThdoznrCpP4Uwkg
         4x7kck7WmaCUqtwPVLuWMWT0DkVU/hsGpWMEOKeaF8n9X1nLUiZskHqvrbQCxR1mou5/
         BIB3AmOAFvebQbWVvdu+s1FyQP4yJkycsv4qDGLVAjBls76Rbv+4YkULqiFc5hcD/4mb
         ATZ562Zhr1dedSKmJh+9Qxh9+HXcCxD2shHrNE6U2hzA50uYhlcK3VSPG65TVmB2ZiiK
         dMGcmu1qeJZ9sPwCIGLkvmYTI+aQmE3v7lONnrUajY4oSYsYQCkVXfpw/hr1zzq59My3
         GArw==
X-Forwarded-Encrypted: i=1; AJvYcCVrxg/u+I+4bM62KgGzwy334yr0LkPQwXkgV0eObrQUpKleLWF6SSFZ/thK3h1C6blHg+RxJOnvOijcVsSlN46Ai2k8RL9SwbycMYXn
X-Gm-Message-State: AOJu0YwyIz2lFvE1G6UydUiJlTDc6QM46d834ckN0v1GNh0jHF+nsK7y
	MmgOy0Pqc7eaRXcIZNzRrCO80cLI13g78MssuSguVhQi9E3hx4oe1+DM5EXI99HRwq9aEJ8dJu2
	ksmpFMw==
X-Google-Smtp-Source: AGHT+IE/hYABClOBrgsQE0CLfSmhtCAhiAqDoEyhi/4slhnVZc7N+4mBvhVSNSwXwTJs801VR9k+QQ==
X-Received: by 2002:a05:6402:8c9:b0:57c:cdb5:cd68 with SMTP id 4fb4d7f45d1cf-57ccdb5d22dmr5009378a12.10.1718655840767;
        Mon, 17 Jun 2024 13:24:00 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb72ce07esm6817386a12.12.2024.06.17.13.24.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jun 2024 13:24:00 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-57ccd1111aeso2574652a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 13:24:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUsy1stknyq8l23Kxd6IksBuYIWmfijeglMtASn4VotNZP/11P1ULaQFUnqBfBKzNOt0lpHpnzYO/IyJ0OFVX/XqnMLBJtL+Dvf47s9
X-Received: by 2002:a50:f699:0:b0:57c:6afc:d2b0 with SMTP id
 4fb4d7f45d1cf-57cbd64969amr8464309a12.1.1718655839701; Mon, 17 Jun 2024
 13:23:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617114712.45d4743f8bacb832dea4b5a9@linux-foundation.org>
 <CAHk-=wjiUzOHfHaWgUcByAygaG6w_BKOqbTN6EHrDHaXb_i+xA@mail.gmail.com> <ZnCZvOHqbp-itE_-@casper.infradead.org>
In-Reply-To: <ZnCZvOHqbp-itE_-@casper.infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 17 Jun 2024 13:23:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgEjJA7rNaDsmG_YUwr7Nw5BGP=tMaKK2=DPWm6r6hxKA@mail.gmail.com>
Message-ID: <CAHk-=wgEjJA7rNaDsmG_YUwr7Nw5BGP=tMaKK2=DPWm6r6hxKA@mail.gmail.com>
Subject: Re: [GIT PULL] hotfixes for 6.10-rc5
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Rafael Aquini <aquini@redhat.com>, 
	Jiri Slaby <jirislaby@kernel.org>, Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org, 
	mm-commits@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 17 Jun 2024 at 13:17, Matthew Wilcox <willy@infradead.org> wrote:
>
> This patch wasn't even cc'd to linux-mm, so I never saw it.  I would
> have NAKed it based on this already being fixed.

I actually cc'd y ou partly because you were part of that earlier fix,
but also because of the implicit question:

  "So it's very possible that the

        if (IS_ENABLED(CONFIG_32BIT) || in_compat_syscall())
                return 0;

   test in __thp_get_unmapped_area() should be extended to take requested
   address randomization into account"

and whether we maybe could do better?

For x86-64, the default for min compat bits is 28 - which is
presumably plenty - but maybe we have issues elsewhere?

               Linus

