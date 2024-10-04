Return-Path: <linux-kernel+bounces-350853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 844A5990A85
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 20:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BF041F22C07
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 18:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD47C1C3044;
	Fri,  4 Oct 2024 18:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Eq9SHr+4"
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C8747F5F
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 18:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728064816; cv=none; b=r2xgFhqLDmRuCXVpR8NmuHyhPQO+JfjbayPJvsJ6WCZQaVO1QL7rrugo18gkJqSUclHaVBxCDN6BN8rjSabLE3xpHXpJElNyUzhfad1PdY2CHJDyNNpDuJen79U1WzW+OxecXi1rYD/aU5W7zWpNOImo7KYLm2PA+Y04Lz6eytk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728064816; c=relaxed/simple;
	bh=PMOM/qjJaiv5NGfVvQQtJMlId91TctdxelpJsDxocLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JM49T9h+TRDQwSP+JP5xTmIb/SdR1Yr3KsTV+kcsY+3TESkuPtMLpEEf06mhViRktHmGF/ndMlFjWA+FA6LtljFFWpRfeJ/ocIZORT+AuZ6dGwOdT3w2TBO3vzdcjn3uyzp4IgUwcz9igPl6shO9MEyuY4/D2ygXVqBbCiiOJ5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Eq9SHr+4; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-277e42a451dso119246fac.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 11:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728064813; x=1728669613; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OmLcbw3dTY3w/Owkai0ppDRQaaYIubHSutnZXhKguwE=;
        b=Eq9SHr+4qUPHIzc8DhfY+DnGvB4FwWhvTkcJXiRvfVVenpN1CnUl81H9jr6t9Pu7+x
         H1cCxma8PriJQN7v6oXmKpkFG5kpfr22D3GiHXrI93NO9knN8+U1qx20aEc/I3Tru+nm
         ZhQr7pSVXZWL5oQKap4hjwRUZFh3htCtza+nc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728064813; x=1728669613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OmLcbw3dTY3w/Owkai0ppDRQaaYIubHSutnZXhKguwE=;
        b=oKnXpwtZrKTWUap+bYF1KHy2rQPCP0ERNg8kUYf7W7uIn1kSKAPDN+EYvUrGvuU6cD
         ji7tSAzpZ+ZcLytN96AR/REMJcAWCJIAUTljacGxRkuxiaIDbUk91EspOIS4i4BhwHFn
         n0+PWRlzAGyz5yuY13ZLS2AYR8ShkPF3j42/oxy8nMCbHYnG+GScbnKD/Fuhcr4BI1w7
         AiHmy45a9nBMF0+hz6dsZuQaIHp4wlu2tNGvqPLah/vwJDIJVoeHtJT34t/c94M+ieaa
         1d27z+xVJ4US2CSzA0WuLpQn18hfhGGhPku8iCcbxuTphoLTiI+4GEh8nDnGmjAH99Lh
         sP2w==
X-Forwarded-Encrypted: i=1; AJvYcCXE50cr7bcE7ZijKjK8kdHYe1cOGwsn+7lQP5BjEHjeiMjBtAZnr5wHQsOcpGUwz7UVIM5rOQNvzjvY0nc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHqWZQ97ep2xR2uJntMdHnN36P/FCKlhM9XxXK8+QweoO4l/zn
	nX8VZ4l2M351er/d+rtlpa00f94JlQs4quFO5xGLLFnm7/354zA5SPWWVtmyxzCNcX4hfPno+5X
	2yhvF7s/Ux2pFTRu80PF2XYvQOH1Q8Wsvo4lr
X-Google-Smtp-Source: AGHT+IG1zOkPi9cSpKoSowBdUikBePmdVz5SvwucHk6LYufziJDiV0GIln1NM20ppD8iWK+zVkJ9Tq1c8Kj3vOZeY5g=
X-Received: by 2002:a05:6870:89a3:b0:286:f523:4d76 with SMTP id
 586e51a60fabf-287c1e16b7dmr727983fac.6.1728064813669; Fri, 04 Oct 2024
 11:00:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <zghnfw2vvrvlxenzx3oi55hzznxbx2nhcuwfk5zpe42bm4dxzv@zknjtfa2fu7n> <20240925152509.87152-1-faresx@amazon.de>
In-Reply-To: <20240925152509.87152-1-faresx@amazon.de>
From: Jeff Xu <jeffxu@chromium.org>
Date: Fri, 4 Oct 2024 11:00:00 -0700
Message-ID: <CABi2SkWrQOdxdai7YLoYKKc6GAwxue=jc+bH1=CgE-bKRO-GhA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/7] mseal: expose interface to seal / unseal user
 memory ranges
To: Fares Mehanna <faresx@amazon.de>, Kees Cook <keescook@chromium.org>
Cc: liam.howlett@oracle.com, akpm@linux-foundation.org, ardb@kernel.org, 
	arnd@arndb.de, bhelgaas@google.com, broonie@kernel.org, 
	catalin.marinas@arm.com, david@redhat.com, james.morse@arm.com, 
	javierm@redhat.com, jean-philippe@linaro.org, joey.gouly@arm.com, 
	kristina.martsenko@arm.com, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, mark.rutland@arm.com, maz@kernel.org, 
	nh-open-source@amazon.com, oliver.upton@linux.dev, ptosi@google.com, 
	rdunlap@infradead.org, rkagan@amazon.de, rppt@kernel.org, 
	shikemeng@huaweicloud.com, suzuki.poulose@arm.com, tabba@google.com, 
	will@kernel.org, yuzenghui@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Fares,

Please add me to this series and I'm interested in everything related
to mseal :-)

I also added Kees, since mseal is a security feature, and kees is CCed
on security matters.

On Wed, Sep 25, 2024 at 8:25=E2=80=AFAM Fares Mehanna <faresx@amazon.de> wr=
ote:
>
> Hi,
>
> Thanks for taking a look and apologies for my delayed response.
>
> > It is not clear from the change log above or the cover letter as to why
> > you need to go this route instead of using the mmap lock.
>
> In the current form of the patches I use memfd_secret() to allocate the p=
ages
> and remove them from kernel linear address. [1]
>
> This allocate pages, map them in user virtual addresses and track them in=
 a VMA.
>
> Before flipping the permissions on those pages to be used by the kernel, =
I need
> to make sure that those virtual addresses and this VMA is off-limits to t=
he
> owning process.
>
> memfd_secret() pages are locked by default, so they won't swap out. I nee=
d to
> seal the VMA to make sure the owner process can't unmap/remap/... or chan=
ge the
> protection of this VMA.
>
> So before changing the permissions on the secret pages, I make sure the p=
ages
> are faulted in, locked and sealed. So userspace can't influence this mapp=
ing.
>
> > We can't use the mseal feature for this; it is supposed to be a one way
> > transition.
>
> For this approach, I need the unseal operation when releasing the memory =
range.
>
> The kernel can be done with the secret pages in one of two scenarios:
> 1. During lifecycle of the process.
> 2. When the process terminates.
>
> For the first case, I need to unmap the VMA so it can be reused by the ow=
ning
> process later, so I need the unseal operation. For the second case howeve=
r we
> don't need that since the process mm is already destructed or just about =
to be
> destructed anyway, regardless of sealed/unsealed VMAs. [1]
>
> I didn't expose the unseal operation to userspace.
>
In general, we should avoid having do_unseal, even though the
operation is restricted to the kernel itself.

However, from what you have described, without looking at your code,
the case is closer to mseal, except that you need to unmap it within
the kernel code.

For this, there might be two options that I can think of now, post
here for discussion:

1> Add a new flag in vm_flags, to allow unmap while sealed. However,
this will not prevent user space from unmap the area.

2> pass a flag in do_vmi_align_munmap() to skip sealing checks for
your particular call. The do_vmi_align_munmap() already has a flag
such as unlock.

will the above work for your case ? or I  miss-understood the requirement.

Thanks
-Jeff



> [1] https://lore.kernel.org/linux-arm-kernel/20240911143421.85612-3-fares=
x@amazon.de/
>
> Thanks!
> Fares.
>
>
>
> Amazon Web Services Development Center Germany GmbH
> Krausenstr. 38
> 10117 Berlin
> Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
> Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
> Sitz: Berlin
> Ust-ID: DE 365 538 597
>
>

