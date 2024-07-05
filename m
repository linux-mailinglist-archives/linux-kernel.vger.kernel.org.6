Return-Path: <linux-kernel+bounces-242304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC91928679
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 12:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBBC31F23C6F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 10:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C360B14601D;
	Fri,  5 Jul 2024 10:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2kECq8+"
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B891060DFA
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 10:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720174382; cv=none; b=e79phj1RPGg77xMzdDKXN22OGqA3XSx3YLb/bGK65btB5KGjR0GZwWnWxWgDtTTs4YQrruuZf/0OMpSB1BSHsmQv+7Dzn3vDqmgyeCIaU4rRH6MvFvwckOul3Pww2MNwKwDkKGnMBz9Lnb3XHGSdhZ/3biaSkLB+ufyJOxhFQb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720174382; c=relaxed/simple;
	bh=MYbibVkubJZKoSCzi69jCr8Eoc3dWPn384U4jjblosY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hqZlRXPpa8GgzXwnfhJ6ziqABHi7yfFyeJrsyNVKIoB5IyYHKa3XCAn5Jl+5sg+uFVWGkBRF+Z2VrC8q79Rj+DgCKPaBGqRXSGqWcPARs8VsEccIhoHHIisPH7bzHBenaCMkJlOa9rEKU1FOyLnb70a9iLN7kPcxPjimUHvucnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H2kECq8+; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-810197638fcso411363241.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 03:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720174379; x=1720779179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ffIBOnbAtE0Ds0Y0ZfHWukYmzyfflqKoxCL+XXIWOw=;
        b=H2kECq8+Ic3r7eXGJHaUsd20XwijDgJIx+WEQ8Ov3kdSBxMnWOiAAOA7dq+/nN5wcZ
         M3Y4BgouPLVYWLtK/HwshzjZR2MxPwoy7EWFSvnIt8IlQRo4sjRizwc/8r+93utDKrVi
         OeXoTY3WnLoFn2W75PdCqTn3zXdHJkPWLSLPm1ovKkVYmNuaVLQUYiD04dtXjLxLE3zL
         uCc1j8nAD1valP/gwNhVxKJBat8cuJrlxJB3EsC5nfT6idaTxoEUn6iZQiiwtvgnRIwL
         kmk6gbKGIiaRFCte58nrprC+YewnZVFpY3tQdS/6UUZXI2/RO2gmeUaTl5XcQNG99AhA
         DyHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720174379; x=1720779179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ffIBOnbAtE0Ds0Y0ZfHWukYmzyfflqKoxCL+XXIWOw=;
        b=UI+6i1pxxMtFv4D2rXcTetHojyjZ/CZ3ONvcrDG0yezB5ILb+nAGQZ3ecNbBxRL0yS
         BkWJ4ihCZNy5ZMlOjB3dsTWtc18hg/dzm7gF1FhwXY55z+Ts/Z0bxVKMn/yRo96FTNd3
         Lmyl8uTYw7pj9fyVSivZ8RbJpoLuyCAA/f9LFCCS8vxpwiMx7zs/httIO0Bi7W/TsC72
         48zj3opHY+EOZGv3XeDxQH373rw8tjxypOXlJFKFgAhW/1Q1tUXIiv9q9vdsylvqzRsy
         1hJBWUi7fFkHPlRdnFR7qk7uSBpzKC36FZkHqjPzTLo3KxJDty7uwqZXKvGpQ0Ldpelh
         n//A==
X-Forwarded-Encrypted: i=1; AJvYcCVPwukAFU1/8fZHXYBab79JIRXeYb33FHxJE428BdO8onBKvDkIh0GS4NHzgwhIX9mSDXQcJLIckICBT2ZY6nmRaAxKyowhgLUVkl4U
X-Gm-Message-State: AOJu0Yx6Qz9nf91Tam1Pt7ryoX8W79E50y7vMQeiJpN+RHQXck8ispNb
	W7nWX9JDM/E8psRtPHMLFCqSqcxDD5vSIydBwjEKNtTt3KoeLLWB7/xNQHSz39d7/fUtQvzlxSX
	2Du5NLyB9GDrMuPk1XlGbvIBZm1o=
X-Google-Smtp-Source: AGHT+IF0QIqCtQqTz52Y1BoLh1Nja6AliTHdHDR9hySC0rEEiDpsO+4lWZqTpEpJHgf9lSAUAvjgQfO1I8OQz8b0Bks=
X-Received: by 2002:a05:6122:2885:b0:4ef:65fe:7ee3 with SMTP id
 71dfb90a1353d-4f2f3e5f688mr4962547e0c.5.1720174379458; Fri, 05 Jul 2024
 03:12:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704012905.42971-1-ioworker0@gmail.com> <20240704012905.42971-2-ioworker0@gmail.com>
 <677fc803-0bb9-48dc-a1ff-3ca1fb0dea15@redhat.com>
In-Reply-To: <677fc803-0bb9-48dc-a1ff-3ca1fb0dea15@redhat.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 5 Jul 2024 22:12:48 +1200
Message-ID: <CAGsJ_4xX1cqKHU0eEsT=k0YDYKPs2m82bCkggdJyA1iwG4vXrg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] mm: add per-order mTHP split counters
To: David Hildenbrand <david@redhat.com>
Cc: Lance Yang <ioworker0@gmail.com>, akpm@linux-foundation.org, dj456119@gmail.com, 
	ryan.roberts@arm.com, shy828301@gmail.com, ziy@nvidia.com, 
	libang.li@antgroup.com, baolin.wang@linux.alibaba.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Mingzhe Yang <mingzhe.yang@ly.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 5, 2024 at 9:08=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
>
> > @@ -3253,8 +3259,9 @@ int split_huge_page_to_list_to_order(struct page =
*page, struct list_head *list,
> >               i_mmap_unlock_read(mapping);
> >   out:
> >       xas_destroy(&xas);
> > -     if (is_thp)
> > +     if (order >=3D HPAGE_PMD_ORDER)
>
> We likely should be using "=3D=3D HPAGE_PMD_ORDER" here, to be safe for t=
he
> future.

I feel this might need to be separate since all other places are using
folio_test_pmd_mappable() ?

>
> Acked-by: David Hildenbrand <david@redhat.com>
>
> --
> Cheers,
>
> David / dhildenb
>

