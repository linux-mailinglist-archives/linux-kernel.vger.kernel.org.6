Return-Path: <linux-kernel+bounces-177834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A874F8C451F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 18:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4787C1F223D9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 16:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF3E17565;
	Mon, 13 May 2024 16:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZlZlX32c"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAE115B3
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 16:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715617878; cv=none; b=lk3qt8YE4icn+7L56MWleBEfzJbL5RJSCBMBo83RNd5NevFhe8gFVHT4W1eJYyan1KGIzDBeRte+k7ev9mv0TNkdJ2RItUFUMAqLj/C8LxTRpXdbkUzJvJFPlMP3O+scZLuppTYUBfoxUB+ApvKXSJNF25tzj9vpGCLoUgNtHA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715617878; c=relaxed/simple;
	bh=+m+CXIE9sGy1r9jEfg/hFVmdEoITFgHJ1cRdt1wM/1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YIQUTVFr1PKs3S01d+OrAtGkSb1BlSsU5WBiJQbf1Vq5JccxdQhd1IY4ZCgTLe3LaAimKrDQmbeGDq0pxb9bGIgTxo1PN5pvQy0J0P+lLuvqq7/xTto2SlNbRKGfVyIOwrSJrqs9G9HIMejEdnh7My3JTReAwxIDFDjWtqvmeCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZlZlX32c; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-de462979e00so4884937276.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 09:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715617876; x=1716222676; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O2xhJAEkTSmP71hWkBPFZsj3mOBJ8dSMKP4uS1UBEYI=;
        b=ZlZlX32cWpJNjXCKEnGj7vxUMIzCErbMkwULXtKxUnd+SKoZ7bHMlzFDB8jpSi9Evt
         vUYgK9e/7JZBcVq3T/HPZDZPVhbevQWL5Ue67aEymo84dYiOLlVkH0TUXJfwtRuQCqNq
         onIJMAZU8H8uxj4zU720QRLemSvE5uGbzDneSMes8AfLSeeZqWllnSH4e/btUlWQuyvT
         i7eiF4MOM46CGTgbVfxV4N01D/eY0uiGl/OLqlXcYdTmdQOkW2UMKSPO6hgNQTNNlwPX
         XLZuErRh7zmVC35qVY3Slg9Zl5OVSe5sfNrZHz7HnqOoM8r/qUJvP+bkfuiRfq3LkBLn
         6CTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715617876; x=1716222676;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O2xhJAEkTSmP71hWkBPFZsj3mOBJ8dSMKP4uS1UBEYI=;
        b=sS7jFP7MKunboW75IFwwwadHVUsq8MYIbLRCVgy/LqDr1IlJ9BWBuU0C3YZonsnVjp
         H2kGQPdIxkvPa6xlxLCGkaniYb1dodUAIrP0pJfUNAUMDJvw6n5Q3qbgc6bL80lQeU0w
         g0hr3xh57T4u1sDqIrMiV0ZB5+M2DOb5JAsxmzQZ4sgXVQdCYwFU8OT2pNHzWv37H2G9
         Asrtu4kMI3KJG/8JgwaFr4Jd9lef3cVqy6oLElWtqrEDW1tZJV50HlFDhQOdKhs11ZaW
         PxJzoVbjOsOlTePIpq/wBVGO/qKpHUuaki3i54duxkTo7LidsIDHL0i/cZzvBzXBvG9S
         d2aw==
X-Forwarded-Encrypted: i=1; AJvYcCX3Hk68ymEUGPFZ8A28JaWizgOvQFBiAaI515fZeY3gsNaC4//75TPTKwIso+OXJ6kBR5pD+zZGx9x0s81RFqwXmIhntlOKQUPkI0Hz
X-Gm-Message-State: AOJu0Yz3mMrn0QOwjGdde0yU3aZREdTjiSy2nfvQrXVyCo3JqbMfl/3H
	fCwV1kwAXpa+SjfBe7z0mCb+o9uTPzWHZUw5lwV8yOAXZylAiIrO
X-Google-Smtp-Source: AGHT+IFcsRRloJlbVynBBYQVQaDvuQS2qMTkUamQXOcHmsWwvGu/Oycbu9I3hU6xajVwWZwT3oRQww==
X-Received: by 2002:a5b:64a:0:b0:de5:9c4b:dd5c with SMTP id 3f1490d57ef6-dee4f31ad2bmr9493278276.23.1715617875877;
        Mon, 13 May 2024 09:31:15 -0700 (PDT)
Received: from localhost ([2601:344:8301:57f0:8acf:1c06:973:d499])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-debd3827c9asm2134665276.50.2024.05.13.09.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 09:31:15 -0700 (PDT)
Date: Mon, 13 May 2024 09:31:14 -0700
From: Yury Norov <yury.norov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Cc: Kyle Meyer <kyle.meyer@hpe.com>, Kuan-Wei Chiu <visitorckw@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [GIT PULL] bitmap changes for 6.10
Message-ID: <ZkJAUsIl07c+dsCc@yury-ThinkPad>
References: <ZkI/qHXm0x+8MSLR@yury-ThinkPad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZkI/qHXm0x+8MSLR@yury-ThinkPad>

+ linux-kernel@vger.kernel.org

On Mon, May 13, 2024 at 09:28:25AM -0700, Yury Norov wrote:
> The following changes since commit 678e14c772130d3a83225ed56fb9860a40bca38b:
> 
>   Merge tag 'soc-fixes-6.9-1' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc (2024-04-12 13:02:27 -0700)
> 
> are available in the Git repository at:
> 
>   https://github.com:/norov/linux.git tags/bitmap-for-6.10
> 
> for you to fetch changes up to c3052c2f53d3546a53f05165a62a2d31abab0e27:
> 
>   usercopy: Don't use "proxy" headers (2024-05-09 09:25:09 -0700)
> 
> ----------------------------------------------------------------
> bitmap patches for 6.10
> 
> Hi Linus,
> 
> Please pull patches for 6.10. This includes:
>  - topology_span_sane() optimization from Kyle Meyer;
>  - fns() rework from Kuan-Wei Chiu and me (used in
>    cpumask_local_spread() and other places); and
>  - headers cleanup from Andy.
> 
> This also adds a MAINTAINERS record for bitops API as it's unattended,
> and I'd like to follow it closer.
> 
> Thanks,
> Yury
> 
> ----------------------------------------------------------------
> Andy Shevchenko (2):
>       bitops: Move aligned_byte_mask() to wordpart.h
>       usercopy: Don't use "proxy" headers
> 
> Kuan-Wei Chiu (2):
>       lib/test_bitops: Add benchmark test for fns()
>       bitops: Optimize fns() for improved performance
> 
> Kyle Meyer (2):
>       cpumask: Add for_each_cpu_from()
>       sched/topology: Optimize topology_span_sane()
> 
> Yury Norov (5):
>       Compiler Attributes: Add __always_used macro
>       lib: make test_bitops compilable into the kernel image
>       bitmap: relax find_nth_bit() limitation on return value
>       bitops: squeeze even more out of fns()
>       MAINTAINERS: add BITOPS API record
> 
>  MAINTAINERS                         | 14 ++++++++++
>  include/linux/bitops.h              | 55 +++++++++++++++++++++++++------------
>  include/linux/compiler_attributes.h | 13 +++++++++
>  include/linux/cpumask.h             | 10 +++++++
>  include/linux/find.h                |  2 +-
>  include/linux/wordpart.h            |  7 +++++
>  kernel/sched/topology.c             |  6 ++--
>  lib/Kconfig.debug                   |  1 -
>  lib/find_bit.c                      |  2 +-
>  lib/test_bitmap.c                   |  4 +--
>  lib/test_bitops.c                   | 28 +++++++++++++++++++
>  lib/usercopy.c                      |  9 ++++--
>  12 files changed, 122 insertions(+), 29 deletions(-)

