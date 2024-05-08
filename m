Return-Path: <linux-kernel+bounces-173680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 199FD8C03ED
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 19:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE3431F22E80
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 17:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5099912C53A;
	Wed,  8 May 2024 17:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RnI+CcNR"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA6F12B175
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 17:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715191097; cv=none; b=DdKAotGfDOiJb7v9ORS9YB5DZqAxEPz+WaAV4qb9ujkEBvpdytWijySpCb8VI9YJxU1KrNeUull3fIspu4907ozPUym9IKdfMtxHueUBKGtIFr/LAtYD0wZud2/vaOnEq6ibna1ST+LuUbSJQeH6uBcfzv6X5QlXAY4IVuf1Bmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715191097; c=relaxed/simple;
	bh=oAnkyw2u1tuMRwEGqoFF3kYVfQ2VW+JexMoHwifcZPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E183ItDctMio0jYlObRiNR7u0Ygw6wSe9W1CXX8r5xttTW7sgldRiJeJvQbeiOdEOqFb7yYEeMnyMas//fJwI1rJXMb75FSj1Ul2T2gQCvJUpW9UwIF4YgypBaw+rRIQ1nQj9wIgSsNG3/Pj0/P141BPcdoYLfXelw2ddVsfBCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RnI+CcNR; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-41b48daaaf4so11935e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 10:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715191094; x=1715795894; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tP92gBeKM0g50NbvJEhINxvEskd9JEwX7VJMOuk1fdM=;
        b=RnI+CcNR3EeBdqeQT9+euerupYSipUgIBJSpUeLuBruhqkxqJw5NvIpZCPSvjibO6X
         PaRL0X93vsuOUxZ1+gzjwtbFssTLWS/z2kloBrCYGcy3Gba+Hhg2c++X1Hp0oCUcN+Ln
         Q5DPmkXW3kOk5RLqKVbY+ZG/eeHQUdB4rE9ziy6ISyqf/RFZb2NM427Z0omGOAMoGf2V
         Xl0glvlcASemYufSNIoQGEJwBhHlSK0iXVt07vz58zCGufrJ9Wi/ZWNSFBg9RrW5xGjX
         Or6KMMXQqFqXK0LemyoosCkwp6QYJCPYFDD6JS95j73C0YCTxEqwi6fUwXhMpEd+Ftbj
         969g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715191094; x=1715795894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tP92gBeKM0g50NbvJEhINxvEskd9JEwX7VJMOuk1fdM=;
        b=mTDEnPvNyHTK3wpINXDYeRMuLE+TkNT3qmY2lvQ0eko2FAYEYpObPCSrH9EFMPnXG+
         RTMJfEsNZ/Mlp9aLvw2COhcLiLFS/5MgPtlk427RFNYgCvV+Fm8clWwk0KVUHIsALsgw
         3649MOXsFwKUCV8Qrwy29vGapTTpIvdL1qhCm2iyW/C+yoIO8hjYB9923Osqg6ty0hFA
         Jyqbrsw9O/h5gPZEW7GLbHH4mJ8hx9f+TgtoPQkDKLKfVtQ8Oyizl5aOQe4/Ip53mmt8
         FDNPcRgdvwL4WAnNVlqBOGL0x4r9NYdQQyP1QZtHGqHaztk1QCJNjGZRLVBI2RA9zwGZ
         G6+A==
X-Forwarded-Encrypted: i=1; AJvYcCUA85rgDmnahqW6N86NjztyqC1jtgEW58JJ5iGakNtRsMXB4EkSAkDzcjJ/9bNUrH1ycKfE6GvkF8BCACrcZv/kmIbHZDZHZms07hsv
X-Gm-Message-State: AOJu0YzVebyu6dkiS1LWgGyqWjEXzEV0pV8gj/d5RkLXkNgTZQIx2o2/
	egs2hZZL2CryUkqMP/SLmXA3RdYNmCGIq3qoK6QLyBABO1Sn4W5IhZctg2sXuQhj5XXzH2KB6gQ
	lYxZylppG19mnrjkDZl4gdLJUX1YExG1/NUZT
X-Google-Smtp-Source: AGHT+IFjj1yUgxdvjtSgv3LgyXpcI3FLi4pwx211hiAyqt7zaZ3U1fvnHgUlzN4XkjFuzQVfOZTRgr50QjxapUmY190=
X-Received: by 2002:a7b:ce98:0:b0:41c:a1b:2476 with SMTP id
 5b1f17b1804b1-41fc38608b1mr95865e9.6.1715191094177; Wed, 08 May 2024 10:58:14
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507063534.4191447-1-tao1.su@linux.intel.com>
 <20240507100651.8faca09c7af34de28f830f03@linux-foundation.org>
 <ZjrpieLKXFhklVwR@linux.bj.intel.com> <20240508070003.2acdf9b4@kernel.org>
In-Reply-To: <20240508070003.2acdf9b4@kernel.org>
From: Edward Liaw <edliaw@google.com>
Date: Wed, 8 May 2024 10:57:47 -0700
Message-ID: <CAG4es9Xdo8fBEpZLWGFHodi7=+ZYLvrE-kQYt=YfCeEHWYxaXg@mail.gmail.com>
Subject: Re: [PATCH] selftests: Add _GNU_SOURCE definition when including kselftest_harness.h
To: Jakub Kicinski <kuba@kernel.org>
Cc: Tao Su <tao1.su@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-sound@vger.kernel.org, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-rtc@vger.kernel.org, linux-sgx@vger.kernel.org, 
	ivan.orlov0322@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, 
	shuah@kernel.org, seanjc@google.com, pbonzini@redhat.com, 
	bongsu.jeon@samsung.com, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, alexandre.belloni@bootlin.com, jarkko@kernel.org, 
	dave.hansen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 8, 2024 at 7:00=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Wed, 8 May 2024 10:55:05 +0800 Tao Su wrote:
> > Back to commit 38c957f07038, I don't see any advantage in using LINE_MA=
X.
> > Can we use a fixed value instead of LINE_MAX? E.g., 1024, 2048. Then we
> > just need to revert commit 809216233555.
>
> SGTM, FWIW. The print is printing a test summary line, printing more
> than 1k seems rather unreasonable. Other facilities, like TH_LOG(),
> should be used for displaying longer info.

I also submitted some patches to fix the _GNU_SOURCE issues here:
https://lore.kernel.org/linux-kselftest/20240507214254.2787305-1-edliaw@goo=
gle.com/

I'm fine with this approach.  It's aligned to what Sean suggested
there, since it's causing a lot of troubles for the release cycle.

