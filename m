Return-Path: <linux-kernel+bounces-261108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAFB493B2EF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 16:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44596B244FA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 14:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697BE15ADB1;
	Wed, 24 Jul 2024 14:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="1Mpj0540"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E260715AADB
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 14:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721832280; cv=none; b=cwkDNjM0AawUssZMPZtlpwyWOP8PFN1pmdSaRWkVMo9TWsgzfOVD78Svt9brbR7GsuqpuqYoirmvABHuGoC51Elk7g59yAgnYHb+m/eRrJDwWE53psNkABJIokXsk4Q+HzpPSKjPGzVrLsbyRno2HEmVKAi7Lp7r+5AYTDoEbe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721832280; c=relaxed/simple;
	bh=I7uEM51teCjbnW06i2qR8KgS0bs+PSUG3g2oBc/vI6s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BgG8CCBfV5tLS5iMnQn8eu74VEH0SgLfjxY2IcsQ/nZlyqSlHoNgneYrzhFQ88P/gdxKIWHuROpVBwvHUpvEpgQiz9nTyji5LxgbltHhCqNlUiJFcQM11bYQqx4fL150yieX2i3tGXSDRlEeDE5yvjim1QUaM0V3z5Kp6PAX2PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=1Mpj0540; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-447e57103d5so28384231cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 07:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1721832278; x=1722437078; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tD7q4blbll5tYjt9Gzyptna4uuXTsnpRgsFbRh6J6zc=;
        b=1Mpj0540i5yIEKtPgvq2hayPz0iimrph5yjJzwGeHTlxKhizkZZti6llWBHTRoOOhU
         j2CIai0MK/A6/04ATHuS4z1CqJPbaOoXNOARievilOna1nxJzZaT2jiNxk0KY/kkjqqG
         aRSlYk5Ta88x2i5LOjYfUHlndfXFvsqVIXhwY2Rt622sn0bDygMqNkx9ECmGKhQ0LNho
         qFx+md/Z+ua9EnA3M2WUU9Ts56hvQB4VcfnlawLsKPdduPCZ+VI6p4i9URuf6HvGyCoP
         fmP0JWzkUlaPvrFKzrHET7w5Uwpo8GGm4NQg7M8t7ybabv2Ve5f1dTXDZDZP75VIR9K3
         4jUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721832278; x=1722437078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tD7q4blbll5tYjt9Gzyptna4uuXTsnpRgsFbRh6J6zc=;
        b=ocpBgPiDy8xI6hV77/9Y74o5xVXl4kcyEBD5w/T8IEL71JhU1mASDG5M712QdW2tep
         JXM1wpLKCJ5r2dWo2ei1yMBha1HUj6FLa8srOGuTsHsIIb+PpLJCKYQ0h5bjJrr1rst8
         /HyNEloeMvBOla5OwV04n0d2Ch7zJ7hrlokL+UMqrZHbIrliDrPIYHHWybx78cnpiPNg
         bocFfJ2hJmJY4z4qrJMb9a7p5QR9U70lqA3Mdv4k2dkVQVmy5F2wIcmqe8yDkx0TDTqA
         UvsVp/NOFEDvYSAGAgrIguaoS9ul/x7hq+Okgcyts3ls397QWUiTkTGS8y9N1zZ30Edp
         bJZg==
X-Forwarded-Encrypted: i=1; AJvYcCVYjLkpH1CxqJ+wiqR8XNa6nE7S2atfN/0Q6btHEz0tHqs8+WIgGpzI43oiAFEvjvUb7MRvdaiQCON8/ITufy9oC75rgmifarVpJakY
X-Gm-Message-State: AOJu0YyxE0Yf1gRwmYF8Sqj87W/RZDPTaXsAk+dUzhKXvCKzquhWignZ
	hMvj4Okav8jTOQsyn0pT+muIqwxE/8UWeoxkbX6Tn8VWjsblu/VuldQteRHZJx7srbBLT9+t70D
	sYBEelcGx/gG1Go4I7K9ZuquobunmHAnR4L4BIg==
X-Google-Smtp-Source: AGHT+IFOo5v2gCv2PX+RdUyGaQBAua2+I57mJ1JpmFBMQL4D5cDPDjygDA0gX9IstRVpbEb/VqTA8cw+o2bGmAR1xJE=
X-Received: by 2002:a05:622a:1446:b0:447:d87e:7873 with SMTP id
 d75a77b69052e-44fa538f761mr162011641cf.64.1721832277575; Wed, 24 Jul 2024
 07:44:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718202611.1695164-1-pasha.tatashin@soleen.com> <20240723234600.d05817293ec1eb2d4ad87be7@linux-foundation.org>
In-Reply-To: <20240723234600.d05817293ec1eb2d4ad87be7@linux-foundation.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 24 Jul 2024 10:43:59 -0400
Message-ID: <CA+CK2bB2fiAGHpD5dsSdxCgPjx7OBra5K8Vn_a4wytPa2U6UjA@mail.gmail.com>
Subject: Re: [PATCH v4] vmstat: Kernel stack usage histogram
To: Andrew Morton <akpm@linux-foundation.org>
Cc: jpoimboe@kernel.org, kent.overstreet@linux.dev, peterz@infradead.org, 
	nphamcs@gmail.com, cerasuolodomenico@gmail.com, surenb@google.com, 
	lizhijian@fujitsu.com, willy@infradead.org, shakeel.butt@linux.dev, 
	vbabka@suse.cz, ziy@nvidia.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 2:46=E2=80=AFAM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Thu, 18 Jul 2024 20:26:11 +0000 Pasha Tatashin <pasha.tatashin@soleen.=
com> wrote:
>
> > As part of the dynamic kernel stack project, we need to know the amount
> > of data that can be saved by reducing the default kernel stack size [1]=
.
> >
> > Provide a kernel stack usage histogram to aid in optimizing kernel stac=
k
> > sizes and minimizing memory waste in large-scale environments. The
> > histogram divides stack usage into power-of-two buckets and reports the
> > results in /proc/vmstat. This information is especially valuable in
> > environments with millions of machines, where even small optimizations
> > can have a significant impact.
>
> x86_64 allmodconfig:
>
> In file included from <command-line>:
> In function 'init_memcg_events',
>     inlined from 'mem_cgroup_css_alloc' at mm/memcontrol.c:3616:3:
> ././include/linux/compiler_types.h:510:45: error: call to '__compiletime_=
assert_2305' declared with attribute error: BUILD_BUG_ON failed: NR_VM_EVEN=
T_ITEMS >=3D S8_MAX
>   510 |         _compiletime_assert(condition, msg, __compiletime_assert_=
, __COUNTER__)
>       |                                             ^
> ././include/linux/compiler_types.h:491:25: note: in definition of macro '=
__compiletime_assert'
>   491 |                         prefix ## suffix();                      =
       \
>       |                         ^~~~~~
> ././include/linux/compiler_types.h:510:9: note: in expansion of macro '_c=
ompiletime_assert'
>   510 |         _compiletime_assert(condition, msg, __compiletime_assert_=
, __COUNTER__)
>       |         ^~~~~~~~~~~~~~~~~~~
> ./include/linux/build_bug.h:39:37: note: in expansion of macro 'compileti=
me_assert'
>    39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), m=
sg)
>       |                                     ^~~~~~~~~~~~~~~~~~
> ./include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_=
ON_MSG'
>    50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #cond=
ition)
>       |         ^~~~~~~~~~~~~~~~
> mm/memcontrol.c:444:9: note: in expansion of macro 'BUILD_BUG_ON'
>   444 |         BUILD_BUG_ON(NR_VM_EVENT_ITEMS >=3D S8_MAX);
>       |         ^~~~~~~~~~~~
>
> This looks legitimate - is it time to switch to int16_t?

I am looking into this, and will also uninline stack_not_used() and
kstack_histogram() as discussed earlier in the thread.

Pasha

