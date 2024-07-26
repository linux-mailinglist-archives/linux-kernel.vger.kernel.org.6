Return-Path: <linux-kernel+bounces-263737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E8D93D9F0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 22:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31F731C23257
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 20:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47311149E06;
	Fri, 26 Jul 2024 20:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UPq5iff2"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBFB50288
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 20:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722026533; cv=none; b=pKCCwYSS4AL6vHwKlRx3UFpfzyuYbgBFnenQic18HlA91Cl9z3tQVqqIDuIiP1w53Fvf6v8/qPT7yuD1xv5ueadJvvh8eQBexhBkEq3WMedYcv2aeBD/0w4U5mweKfZEfnlHBbX1pkPhwudQBBmplciH4PPAXfXMkp/kSLWZXMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722026533; c=relaxed/simple;
	bh=t0beOI4YuWGEuLDIrdVie6mCvEYrRY5/ns3HvaNLf9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JMjUw/eqEu9hHewGlxheoSfusFkhTAbnEoW1NeYdOIHvyAoHtLi/p0OMBlqwt9rW/o6s61Nz2zoiLMPfoVfCNXVJz1yGao4Ted3OjtWRBpHAt8Kx1N+fiZiGwAIO1LGkXN/zSqBHx3FwCre8nhwRS7nVsWepP5qAT9+4uZAF034=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UPq5iff2; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a7ac469e4c4so373852966b.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 13:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1722026530; x=1722631330; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7m/es8FvkQ+Tumyz0W2L27hwAKnWdEcZsbEldUvUHrA=;
        b=UPq5iff2SgbLd1mTwQt6pIK/DRg9hC4yntVyv2VxZZOKUMvRXAsA70FLWOWmeWVEYp
         iOLfdlYRNYbqdsZWhkhFzcaCFgXXTxs4nT1RcDbQCKSChTbpDjwYJhNkxwzteI/W7cUH
         NUs4HcBvLZjVhZ321zUkhghw/PGZ5VRCnMRd0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722026530; x=1722631330;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7m/es8FvkQ+Tumyz0W2L27hwAKnWdEcZsbEldUvUHrA=;
        b=OZ60b0ev+RiuPMIg4foq/oc1iJOAw3pXQ0QDPock6YiFxElmQqstAmj1902rbcjadQ
         2WhXC4ksVUff82Je9kb4lphYcS2Re2OHk9fLFCCIZ+OwQNJM2RVNcWqPrkuos4Derozm
         cWFmun0alpRsERGApW8YK8w2QGY/UpkkbI+Rvz4xeaoW4v9Zj+gbOuk8jRW5mhQKMnwK
         LN/+1QQcxIM4pp/E09600OxaTpWYqDZjECo5Gd0qdkXu9DdQcSHgI/i+p9ojS5vzoQil
         gJr40As13Q4Uv8TUg8cbsVIWTKykWqQoqj6TJJPQ3UHR22U3tctKGb40YB4OS1i2rycl
         bXjw==
X-Forwarded-Encrypted: i=1; AJvYcCWmeonVNdyZ/qrZJG7EaU0nO0FZ+y/N+ctbbiW9Zgt7BaeHv0R520PjD92gnwtHfzXK/9m8qhbsvlxZXgXQvloC94ZBq5wNRBoG7vqf
X-Gm-Message-State: AOJu0YxpeQKEQUvCKdzqQtBprUDjhysDUhpE88H8yB4uNwvfDFvy9j7I
	/XU1a0+jZt8ux6zYwc6navDcQSsIs7gYZUUxmqQfty3HDXfImQhPd9SMC4aqBRVmdztzptxFNc+
	o/X6yEQ==
X-Google-Smtp-Source: AGHT+IEoT0HOIDMrjEcQ0X8uylNX8lp+DWsKhsBDVCYdyu44rhx+PtsgZ7KeuRKo8Qy4cpv5BR/jdA==
X-Received: by 2002:a17:907:72d1:b0:a72:5967:b34 with SMTP id a640c23a62f3a-a7d3fa3f215mr57539266b.22.1722026529843;
        Fri, 26 Jul 2024 13:42:09 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab236f9sm216934266b.15.2024.07.26.13.42.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jul 2024 13:42:08 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-595856e2336so4050161a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 13:42:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWuUXO52L3xtk6/Ha8hdg7p3PmNlA+FL4xI9IhPAEg/MnMcf8dQ8IUqBkETqlSCYQ39l5R/YRC4f+nrZbG75Rkz1WylX6i2IATInddh
X-Received: by 2002:a50:d487:0:b0:59c:50c3:af65 with SMTP id
 4fb4d7f45d1cf-5b018be177amr553368a12.14.1722026528458; Fri, 26 Jul 2024
 13:42:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726195044.18004-1-sedat.dilek@gmail.com>
In-Reply-To: <20240726195044.18004-1-sedat.dilek@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 26 Jul 2024 13:41:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgEhoxDM7T+Ko-NgAC5X8etF0aL3fGsUXFeqnwggNXgCA@mail.gmail.com>
Message-ID: <CAHk-=wgEhoxDM7T+Ko-NgAC5X8etF0aL3fGsUXFeqnwggNXgCA@mail.gmail.com>
Subject: Re: [v2] arm64: Rename to KERNEL_IMAGE_COMPRESSED_INSTALL kconfig for
 compressed kernel image
To: Sedat Dilek <sedat.dilek@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Jul 2024 at 12:51, Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> The COMPRESSED_INSTALL does not sound very meaningful.

Why do you care? The question looks like this:

   Install compressed image by default (COMPRESSED_INSTALL) [N/y/?] (NEW)

which actually fits on a line and makes perfect sense.

Your patch seems to only make things worse for no real gain.

               Linus

