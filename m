Return-Path: <linux-kernel+bounces-425355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 84ADC9DC0EF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 09:58:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30274B21502
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 08:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A09E15C13F;
	Fri, 29 Nov 2024 08:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iWoHO7GC"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6EA15CD41
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 08:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732870722; cv=none; b=av9FUldLP1qyFa2mzeE+AbvOO0/MUMRHOq5VzWBbEV1UmhQEQ4JojC0GFILpSe7Snp1JberSq3Hzob5E0GxK4ZyiRbn1T2RO9tanD/cL6jBIf+YWGhgyo7DeLokcq0EkYXkNmixd+vA9weY5Pbdlw2RiXvoUeFIAJ2MUJhw9M/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732870722; c=relaxed/simple;
	bh=usawajAMIv/TKzX/mVdfakUPPxK+NBwUIhH7uAqGE9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ogLSFIWfNlBE5yX0By0ba+Rzlf7YZlGMm+ITvMSr9rTRvdl+bwTWYiwPmxGtv/QpM1fX1jFEQhSnd3Q6ToauT17Z4hh4AH9qnICDnEOboje8JZrMP3u9VxQeNjReBhpV76KgGNVJXthXex3dOm4/0VwBDqgSbFAxXi5I8+eEuN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iWoHO7GC; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-385dbf79881so354906f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 00:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732870719; x=1733475519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RiMRUUT2M7xVzatty0ZrzXrnlDpHODfPfP79MfeCsvw=;
        b=iWoHO7GCTe6m3o+lu/72RF4jX1bMDfuimwUTvfgD20INREmtNVwKuwz8AXtHfd8+z/
         escQU+D5rzBMXDoe/Ak+3cNG1sJ5rTa3Bfer6VKuAUcUoTP2nmshdrwQn8D0mCzvo1dN
         rKk2Dqoe3bs135RNAmuJ6J35CYSwW9xBLmZ/AHPv9Y4pDQ+pCWKjQREktJir1LcNB6Dw
         rlE9IzWCP4YLD8JJUJ8n+92ysozYdrVqoR799WTQErduVGSEtWsufLu9BvA43Yd6F3LO
         TdlrqTnGPddATZT662GwjdqPnC2Z6/qix0yD2K3erziuJO4iIL9QS1XoQgP7ed2SpmbL
         YK3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732870719; x=1733475519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RiMRUUT2M7xVzatty0ZrzXrnlDpHODfPfP79MfeCsvw=;
        b=fh5x+8C1lEx1x4jfR1ihV1kOswoLgwOZE7K6fyeyLlx5osgXWGtGww027xL4c+4G9h
         UjVcFSEMeLbN4Ehw9/TheUB3QAgWGQpwf27KtxaHh+qm7Zaq5p80eTTy3RMWFCNLivwJ
         bffzaVrFn+IHWUncfJ0QGHn2Ctw+ZaerPfyoxx+PpBeytsqPBGDOxbFMTROYLRZli21O
         W8phO/I/jHXgytElTRWjEuxnTKQTLIBDqDypvcVyW/L5Rx0VfbW+51cZIpHeonbB9jd0
         8OShKl2/5zZQImD9jVT75gzXkB9ZUEt/Pk7JbkJQhFCp4Utjt5cPPhVDE0vo7giNcOXg
         7Vsw==
X-Forwarded-Encrypted: i=1; AJvYcCW0rOefFDlGk7p41jx+IqGutojLsnj4KD5FshnpYczfjJu4jAPPcfzKo8jv+Fo3aylLac67sRSB4S6462k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrlWn84Ds1+dCG8+39Y1DCQKvk9n2ffRE6pWQErkZg2AX29hEf
	Nlzu/S4ZZTxnrmPxdRQ3ZaLiblOlG/zpCSWx5H7WZ1XZDZb2vQgRn/0+cG65yJuLtk+oFpQW5h8
	aMEInhNAo4Or0G2Cxhx3OunzIlbHFdZdtZaJ2
X-Gm-Gg: ASbGncsZNVMVWWMcC4fgraCuTks24iTRHgzeT9U+lVmux/o3s2oPrNE9MMib+z7BOPG
	ACn1AojodHwuoPnv6lSwfQ0pYXZygGCvsFoPDADaEEB9oJrXsIxcJwery5bCQDA==
X-Google-Smtp-Source: AGHT+IHZfE+MvE59g3GUbb6K8cSnEsXzMx7JEog6LGr2L2lWRogqLF0km2dm7xM7vKZZ+7cUaT+QbeJVrgf31YLfu3s=
X-Received: by 2002:a05:6000:4008:b0:385:ca48:2852 with SMTP id
 ffacd0b85a97d-385cbd7c28dmr5175022f8f.13.1732870719463; Fri, 29 Nov 2024
 00:58:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241128-list_lru_memcg_docs-v1-1-7e4568978f4e@google.com> <Z0j3Nfm_EXiGPObq@casper.infradead.org>
In-Reply-To: <Z0j3Nfm_EXiGPObq@casper.infradead.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 29 Nov 2024 09:58:27 +0100
Message-ID: <CAH5fLgg00x1SaV-nmPtvRw_26sZbQxW3B0UWSr1suAmhybxc_Q@mail.gmail.com>
Subject: Re: [PATCH] list_lru: expand list_lru_add() docs with info about sublists
To: Matthew Wilcox <willy@infradead.org>
Cc: Dave Chinner <david@fromorbit.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Qi Zheng <zhengqi.arch@bytedance.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 29, 2024 at 12:05=E2=80=AFAM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> On Thu, Nov 28, 2024 at 12:12:11PM +0000, Alice Ryhl wrote:
> > - * Return: true if the list was updated, false otherwise
> > + * Return value: true if the item was added, false otherwise
>
> This is an incorrect change.  The section is always called 'Return', not
> 'Return value'; see Documentation/doc-guide/kernel-doc.rst.  And I
> think it was fine to say "list was updated" rather than "item was
> added".  They're basically synonyms.
>
> > - * Return value: true if the list was updated, false otherwise
> > + * Return value: true if the item was added, false otherwise
>
> Ditto (and other similar changes)

Oh I had not noticed the "Return"/"Return value" change. It must be a
copy-paste artifact from list_lru_del_obj() which already uses "Return
value". Would you like me to change that one to 'Return'?

As for the other rewording, I thought it was slightly more
unambiguous, but don't feel strongly about it.

Alice

