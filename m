Return-Path: <linux-kernel+bounces-275295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C76E09482E7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 22:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B88A1F22259
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 20:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A8E16BE33;
	Mon,  5 Aug 2024 20:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="av5hP0Ys"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0211684A4
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 20:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722888392; cv=none; b=c2+g4MS1i2wqiDqUfv/NlLZ1mEFVCorYBYPPb+3sVxSO6w7dkGw7XWFren32b1NfTR/+8N31MA9BOzyi3PC4Ur4hw3/VCF59VQPGKRUHpLIQE2/xbMoQevlCjC3FlpfNbsK/DVRzVhg2G1nZA/wcFFdvumkfYH6aSJI6HAceuFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722888392; c=relaxed/simple;
	bh=QPS5MERpj4YLNq+nPXXVohHHtIBMO9B7/+NR6ZxyZHQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rtU/LdXpqva8pm+w+vjJuVw/NzR0lMDVidltTgq4i0586bQ/N4gyxTlXss9tNVvC1v0Qg/1uKo2ZT9ixlMY63n5Xxp2Ry9FKNtaxKJ9uOouesDD1Lvutf7HqzTucboObQ+Y2Bb+FlRL+kuNW2eqKNrJKU8bjd0iRQN5HT679wPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=av5hP0Ys; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7b0c9bbddb4so41262a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 13:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722888390; x=1723493190; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AhhwNjysRV1ApJpRrTYi20sRokbUvK79VIcbcb1hQIU=;
        b=av5hP0YschcAAhEaMk+g7AcLlgfqRb/Ij/1aUA09tbhEhzfYrHVr6PQ/mXDxSGyYiq
         Jj8bXHjmJNZ8MvpZnHNXWzsVJxqnO5eFn2xFlNbAQk8I61j5GEJwcfsTsACoBWf1zSvO
         P/r05Djh/KM/vfcZ3sy0M0A7dUaqI0qmzoe2F+DKwZzJu8Mh7bAMcntnaVdotVocgmaa
         KD7QbM5FWTELt+09/SJpVc5QDiHFOGMm3SPwCKKZtYTC+8JmPJ+yKs9BM4e0Tic8DyXP
         4spoEGmrwdRTh8fe/FA4foe6Ti/Nfm0K/4h/qmPUn/oo0pA6WJ8/5Y8aeNhFIZ46Csfq
         h2Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722888390; x=1723493190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AhhwNjysRV1ApJpRrTYi20sRokbUvK79VIcbcb1hQIU=;
        b=Xb9M0LzlDQcDYts+D2ho8dGDuFHfOfDIEb6MFoMsJyen5FRxu9xZanTKWQHhterbKU
         ubUK4Ibnju75+9V0ERzgHiBBx4C9mNDNWc/j8jS6f7EEJ03bX8Sp5+PA3WFF0P9hp3iY
         EKAF4eLmWzYVuqOXURKtsXVghJim0alnTyRK1f6A9epDDPECxXlVZdNZiPxsqm87hdc7
         xXm6FZBC4tdPjqi1K+1mOuJ5GIYBeyTFJFaYa3IS9KZ09FR7L/DpBpX0YFbCL0EBhGUV
         za9AQspcl/6KF8nn+GcQWD2Asux4xXJS7463Z8V+ZYaNoq5gL9mz/3bLLycoZtIiD50K
         2B9w==
X-Forwarded-Encrypted: i=1; AJvYcCXIdE6g4kU/yC8ERuGycW0GcmvPsymcaikD3E6kZMJTleLGaaMeKyEgVK2CQIBqGoInG7khV6iDhwjaGK86jmrTrDj3QBQAl4DB6xlR
X-Gm-Message-State: AOJu0Yz+0RQRTI/758BteOBiiM+/ZVMmDrN3qRaoiXqoEQJHNvFvjTMh
	hc4oF1L84dJ5rwwnbrDX2UQfJI+ARE3VkViVu/hqHJc7Sq5Wmb/7lGqQxRUAHZJ9I0o+g6V2xQ1
	BguYbgHUpG/797bS5LuD8yboSDG8=
X-Google-Smtp-Source: AGHT+IFRPNtDJR1LFejyrg8XiakZOiGzS9Uk+4UHp48b7BTue3j4pJ6Q3mck8pz/FbAcnuik1/mUBeAEwTKahh5lHOQ=
X-Received: by 2002:a17:90a:a417:b0:2c9:6f5e:f5c1 with SMTP id
 98e67ed59e1d1-2cff93fe5c5mr12697459a91.10.1722888389853; Mon, 05 Aug 2024
 13:06:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1722778722.git.tjakobi@math.uni-bielefeld.de>
In-Reply-To: <cover.1722778722.git.tjakobi@math.uni-bielefeld.de>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 5 Aug 2024 16:06:17 -0400
Message-ID: <CADnq5_Oeh-pzGQG55xv9u_fYjrdWrcCBy5-rFxX+X8mW5sBYeQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] drm/amd: some trivial fixes
To: tjakobi@math.uni-bielefeld.de
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied the series.  Thanks!

Alex

On Sun, Aug 4, 2024 at 10:14=E2=80=AFAM <tjakobi@math.uni-bielefeld.de> wro=
te:
>
> From: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
>
> Nothing serious here, just some bits I noticed when reading code.
>
> Tobias Jakobi (3):
>   drm/amd: Make amd_ip_funcs static for SDMA v5.0
>   drm/amd: Make amd_ip_funcs static for SDMA v5.2
>   drm/amdgpu/swsmu: fix SMU11 typos (memlk -> memclk)
>
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c                  | 2 +-
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_0.h                  | 1 -
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c                  | 2 +-
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.h                  | 1 -
>  drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c         | 4 ++--
>  drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 4 ++--
>  6 files changed, 6 insertions(+), 8 deletions(-)
>
> --
> 2.44.2
>

