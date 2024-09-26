Return-Path: <linux-kernel+bounces-340444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB6D987380
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 14:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9EFC283291
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 12:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4889017799F;
	Thu, 26 Sep 2024 12:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YAkxGYQA"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2116D176ADF
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 12:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727353389; cv=none; b=JjLCMz2Np0dphCIbCoag4kex4JFM+fQK6Fcy2kHKFMEoUZj/LUFXvhx7POPrjiuUWG2I2uNrFlqrmGpN0PkI26YYGQdNkXT/VPT7L11+J9HoftFhxPKuH+CAhKJtQV3LSKyGHJ/Q9l8EJdtdGsqykAql2SV6ZyEzmsQWTYl0QEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727353389; c=relaxed/simple;
	bh=epnQDLbxKMM02W75YmUnm6Rh7M3jGgN2mMkawj0gCf8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DrDGo0bRJmkH75b2cPNoCWgBgIKdFwAbbBKcy9PU+R0wWnmZCiTzf51xLPi2xRBjgjXlUp79IPScbS2cftc3Go+PHn6321DjeZbmtnSq4EOoDCE5tU/747ml8mm1woOQPYI7gPiuxib+QoKDKvGn9VenO1ZcXEBhJ7ID+OLXT/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YAkxGYQA; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c40aea5c40so1703484a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 05:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727353386; x=1727958186; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OOtAdGSLmtU0Tl9JOnUIzkV8dLA7+CwP/jLQK5eAiLU=;
        b=YAkxGYQABkadWmVxflNZRCNvWRIFuG1WLlu9PZfkKccPNT5fRwDD7bMR2myWDPysTA
         6R5tZ07TV71IdGJOLpPqPe9utywTI2pM4qT14UvQy6fwqiegQjpq4t3t5VBCO+2vNxEH
         PtaftTFJkW3gavE/YNZ380rQDXdUzKByR28nOI+HZjpuuMXPweX78IlyKmOf8nnO4arS
         0qWShkR76jD95ddEO24ThV0rSdKY1b0hCq6T8WJd8aBKiiIVtsWy+ZVjjmLu7mtFJM7z
         xNRAsWoc++YO8M/F0X2kPaV1hro3DhvwoEgrmmmC82K0XS+d1LdX/gsElYyKbCQOftYC
         gOvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727353386; x=1727958186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OOtAdGSLmtU0Tl9JOnUIzkV8dLA7+CwP/jLQK5eAiLU=;
        b=USu8neAQiyJyj41fWENlYwpvQuik6btej/Mr3xjIZai7Qbw4CVNXgr7jzQp23ouIEA
         MVzt2UFYm0UBk2QDqW9BesTA5SkuEZ9FJL8m3nUKFmN5A7F4WcKhXUZjhiYWyq3l59Y5
         kRRYCkX1oPif7SjrJ7U4Y97Cl5kFVQb3zwgR3Y5FYAuR4ecwzDSzVIsowmU5O+TdPTZ1
         MEjfFdJGR7920lqH8XsAQTW3/J1wgeBaa0haz6zyjItYujQ9TpQLkv+e2UZYaEVAJARM
         2ftZ4Bwez9bijy6YWoePDsQTNB7xrYkI5uCqhF1PTGWuu3ihT4ukuK1h/6JzhH4mlnI+
         nRpg==
X-Forwarded-Encrypted: i=1; AJvYcCXiCFbY6oEifRllzjAkh2jPL4l3wT0m8g0PcVVDCMKd3c2DfaWoFUV7Yas8O2Eh0f+B1FZcAvyDne6l4sE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy24KLtTmQSiKk1/WKAituq2PuUAsHiq57ajAAari+YlttKkETn
	ZIcVkb5cbab6yl0prFgW57VGJ1l16xJlZnoxCMJwrryKHVWWfQrNMRrm31DROKscIKX9sJzOsGF
	oicCUnm4f5rlkB3G+rksGTRqqIM8=
X-Google-Smtp-Source: AGHT+IER0I/Mcrqs3P0SR1Afg5c32qaZvfGnypuc9N4ejqf4RJMfQxSgsS2aY5Ti4IQH0claNSiUXpiO6MeuC7PgVaw=
X-Received: by 2002:a05:6402:40d2:b0:5c7:2209:dedb with SMTP id
 4fb4d7f45d1cf-5c8777b59c1mr3107804a12.8.1727353385705; Thu, 26 Sep 2024
 05:23:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925134732.24431-1-ahuang12@lenovo.com> <20240925134706.2a0c2717a41a338d938581ff@linux-foundation.org>
In-Reply-To: <20240925134706.2a0c2717a41a338d938581ff@linux-foundation.org>
From: Huang Adrian <adrianhuang0701@gmail.com>
Date: Thu, 26 Sep 2024 20:22:54 +0800
Message-ID: <CAHKZfL0D6UXvhuiq_GQgCwdKZAQ7CEkajJPpZJ40_e+ZfvHvcw@mail.gmail.com>
Subject: Re: [PATCH 1/1] kasan, vmalloc: avoid lock contention when
 depopulating vmalloc
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Uladzislau Rezki <urezki@gmail.com>, kasan-dev@googlegroups.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Adrian Huang <ahuang12@lenovo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 4:47=E2=80=AFAM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Wed, 25 Sep 2024 21:47:32 +0800 Adrian Huang <adrianhuang0701@gmail.co=
m> wrote:
>
> >
> > ...
> >
> > From: Adrian Huang <ahuang12@lenovo.com>
> > After re-visiting code path about setting the kasan ptep (pte pointer),
> > it's unlikely that a kasan ptep is set and cleared simultaneously by
> > different CPUs. So, use ptep_get_and_clear() to get rid of the spinlock
> > operation.
>
> "unlikely" isn't particularly comforting.  We'd prefer to never corrupt
> pte's!
>
> I'm suspecting we need a more thorough solution here.
>
> btw, for a lame fix, did you try moving the spin_lock() into
> kasan_release_vmalloc(), around the apply_to_existing_page_range()
> call?  That would at least reduce locking frequency a lot.  Some
> mitigation might be needed to avoid excessive hold times.

I did try it before. That didn't help. In this case, each iteration in
kasan_release_vmalloc_node() only needs to clear one pte. However,
vn->purge_list is the long list under the heavy load: 128 cores (128
vmap_nodes) execute kasan_release_vmalloc_node() to clear the corresponding
pte(s) while other cores allocate vmalloc space (populate the page table
of the vmalloc address) and populate vmalloc shadow page table. Lots of
cores contend init_mm.page_table_lock.

For a lame fix, adding cond_resched() in the loop of
kasan_release_vmalloc_node() is an option.

Any suggestions and comments about this issue?

Thanks.

-- Adrian

