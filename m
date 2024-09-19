Return-Path: <linux-kernel+bounces-333071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3D097C313
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 05:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24D191F22827
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 03:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF95F156E4;
	Thu, 19 Sep 2024 03:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RJ/sfF39"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8661097B
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 03:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726715602; cv=none; b=ZooDXxCpWwbt1jm5j57PCGZSe1/c/xacaGT2UpZ4hWlVCivv49oP3y2BIsvGMpdgQVQMDQuNRf9QvwxzFFIR9Sz2mBvL96U+KLzZvluNUyA0GpwX1PD5lgUSQCdgErqF3HRPJO9ZjLl5/eHAlF1VEPti3q57mEVex5KU9QmZs5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726715602; c=relaxed/simple;
	bh=9V2+zbwm8Yz+r58UL9q8WQFB/wy+TQMYxqZgi3T/d3g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hpmfXPyDHzpol9bWT5P211ebtD7exwdMIctpQUTo+HqAuihu5sVZKcVWjROoS2nYzuM+jvAvZPrygsAeI5qSwsf1NeOmOR6jP/LV0swdMITapQGqHCMVACsG+GoZwDVu/Ap4ByLQImmPuH8N3w5NErX7+lJ3Z3JECftxMOlHqjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=RJ/sfF39; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c26815e174so535097a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 20:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1726715598; x=1727320398; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wcLLwAFuhFyJrwjWn6iH7R74N7ls/NAjmWUt4uQ7SSo=;
        b=RJ/sfF39DaRUHCo5CBtUGZanSKrd6zH7j4mawltWbeSqSq1oFyP4E8kdISSMdIFqIF
         nGZHe1EuT4dzzeqdBy+mAFWfjI9j4sbE9nFKWCAzFhWerIVZveJCJ0OqBzdAgQ1dmges
         kzo/nLVPG015w+BKiTRS2o8DDiQLXggQNhQ+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726715598; x=1727320398;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wcLLwAFuhFyJrwjWn6iH7R74N7ls/NAjmWUt4uQ7SSo=;
        b=owJ7KiU/L026ycXvVophoxScAr2Ob49Rr0YunvPyKkda1MNkHl2O3iGIvjZMzv5e0U
         V16bekKy1U7GvCvHpv9isiFDvuxKFwcqISDgW84YXytsPeUOgb/Nf6WyuapnjlAxPqS8
         cuwwz7jNua/qQY/zVeUN+fVJcs5HwHmGsTy27GU1ov1LXKhdNPTNtm69uvvDZxLQFXIz
         PLBzT05oyiZQMem9XG/m8prag4bFxDs3hDpy7ozFtyeWYgl+dAG+XchJ/rk4SvFH0LYA
         jRMrfyv9xUAY8uiLJd8E9b4+Oq6ShHk3/CJp57j29i8OiiGDxRc/GdsfrUj1yHfqra9+
         TwlA==
X-Forwarded-Encrypted: i=1; AJvYcCUTuab1mbPKwUfnqxX+q7Er8KqVXA/xbIko9Hd4AVF1x5v9gBcdv1UiMcCPAupwFuWWCKxWeFVKvYNmdKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJpxsTgU/UTN3CP/5nnupzgGp66ZuoRzsWkiwBPY5e3BMtCDsu
	FZfZSH4nohyF+KMDiaRkB3OlG5t+2Mglor3ctKTck+i76rt1olFBpIRSA30NoTykw9t2qLfnSPX
	VUC9PIg==
X-Google-Smtp-Source: AGHT+IFHr4HVUyU81QiCYtThg4f2DwVZ87dCVnM3YzU5L/Zu7GsrD0L0xwhB4bPiF7rCdGzqCgFFSQ==
X-Received: by 2002:a05:6402:2803:b0:5c3:2440:8570 with SMTP id 4fb4d7f45d1cf-5c41e1acc7amr18421948a12.26.1726715597896;
        Wed, 18 Sep 2024 20:13:17 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bc8906fsm5843840a12.86.2024.09.18.20.13.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2024 20:13:16 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a8d2daa2262so34617966b.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 20:13:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXs8sbK/lWvCLd7IVI9slesofO0SKC+vrav5uDdeDdLhH7kjxhZZRhgca/hHxW0CLPNbJra5yw8jj/LqFE=@vger.kernel.org
X-Received: by 2002:a17:907:6e8b:b0:a89:f1b9:d391 with SMTP id
 a640c23a62f3a-a9047c9c504mr1768413466b.14.1726715595791; Wed, 18 Sep 2024
 20:13:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wh5LRp6Tb2oLKv1LrJWuXKOvxcucMfRMmYcT-npbo0=_A@mail.gmail.com>
 <Zud1EhTnoWIRFPa/@dread.disaster.area> <CAHk-=wgY-PVaVRBHem2qGnzpAQJheDOWKpqsteQxbRop6ey+fQ@mail.gmail.com>
 <74cceb67-2e71-455f-a4d4-6c5185ef775b@meta.com> <ZulMlPFKiiRe3iFd@casper.infradead.org>
 <52d45d22-e108-400e-a63f-f50ef1a0ae1a@meta.com> <ZumDPU7RDg5wV0Re@casper.infradead.org>
 <5bee194c-9cd3-47e7-919b-9f352441f855@kernel.dk> <459beb1c-defd-4836-952c-589203b7005c@meta.com>
 <ZurXAco1BKqf8I2E@casper.infradead.org> <ZuuBs762OrOk58zQ@dread.disaster.area>
 <CAHk-=wjsrwuU9uALfif4WhSg=kpwXqP2h1ZB+zmH_ORDsrLCnQ@mail.gmail.com>
In-Reply-To: <CAHk-=wjsrwuU9uALfif4WhSg=kpwXqP2h1ZB+zmH_ORDsrLCnQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 19 Sep 2024 05:12:59 +0200
X-Gmail-Original-Message-ID: <CAHk-=wgQ_OeAaNMA7A=icuf66r7Atz1-NNs9Qk8O=2gEjd=qTw@mail.gmail.com>
Message-ID: <CAHk-=wgQ_OeAaNMA7A=icuf66r7Atz1-NNs9Qk8O=2gEjd=qTw@mail.gmail.com>
Subject: Re: Known and unfixed active data loss bug in MM + XFS with large
 folios since Dec 2021 (any kernel from 6.1 upwards)
To: Dave Chinner <david@fromorbit.com>
Cc: Matthew Wilcox <willy@infradead.org>, Chris Mason <clm@meta.com>, Jens Axboe <axboe@kernel.dk>, 
	Christian Theune <ct@flyingcircus.io>, linux-mm@kvack.org, 
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Daniel Dao <dqminh@cloudflare.com>, 
	regressions@lists.linux.dev, regressions@leemhuis.info
Content-Type: text/plain; charset="UTF-8"

On Thu, 19 Sept 2024 at 05:03, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I think we should just do the simple one-liner of adding a
> "xas_reset()" to after doing xas_split_alloc() (or do it inside the
> xas_split_alloc()).

.. and obviously that should be actually *verified* to fix the issue
not just with the test-case that Chris and Jens have been using, but
on Christian's real PostgreSQL load.

Christian?

Note that the xas_reset() needs to be done after the check for errors
- or like Willy suggested, xas_split_alloc() needs to be re-organized.

So the simplest fix is probably to just add a

                        if (xas_error(&xas))
                                goto error;
                }
+               xas_reset(&xas);
                xas_lock_irq(&xas);
                xas_for_each_conflict(&xas, entry) {
                        old = entry;

in __filemap_add_folio() in mm/filemap.c

(The above is obviously a whitespace-damaged pseudo-patch for the
pre-6758c1128ceb state. I don't actually carry a stable tree around on
my laptop, but I hope it's clear enough what I'm rambling about)

               Linus

