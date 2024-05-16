Return-Path: <linux-kernel+bounces-181157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C2608C784B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 16:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC0331F230F5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 14:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5311D14A0AE;
	Thu, 16 May 2024 14:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sc4HhVUG"
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E591487CD
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 14:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715868654; cv=none; b=BXrsx5pXZ0OjCA4Mayn3O0NmdGie20AeDsPVe4QthM4oYXtpy9F6iSHDsBaEQWmM9qwDupIcIsZDVWwOS6vU3evikxDyi9AhIvdVjl+dwnxMqb5UO8EL1crjdgtr8BGJL+Jg/CXrFuEaLOrcoaneMPo+3uG+B1S2nsm7E0C8En4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715868654; c=relaxed/simple;
	bh=mnvj+qh6fnc2dz1OtvSl8U5zGPGDwak9VJs7OHFHwSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SL5MQvhrvPq+bFYJ1ozVajCD9AFIRXDYTLHahJqsBByrl2ON7OACkSX2lGgCPwUoeR2J/4sFrfyFJC4ex4sRj+IeKpZNqHNJC+0lqZGmOpOcPeLpxVbGUK0p74CkmDzNQ09nK1G0h2hvZXKLyS+f/rROxgWLZz4LsoAShyin7FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sc4HhVUG; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6f1239a2e83so140432a34.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 07:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715868652; x=1716473452; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EmERywOLItQdbPqV7TU/hQijQ/77khKWhpW6wK/l15M=;
        b=sc4HhVUGHBC5Bf/ZrXv13UlbuTvC0BT649BUOxXGIGV14Aq/PEVdKvjYo3jAAL+NiR
         i5K21sjE9aZSKQHVyGhVIkzO40Z4Qn2rKIt6DbPTeZsKFJXcVpdciUodf/tPykJ42jKQ
         +JpkO5T/+gddGavX1i7kn8nBa7CR6t2gtInI04INYp1vAthfYbCqrDUxbME/8yBQy8r/
         +Rs3RJ62MF3vVFycP6xRNpUmG6sPXkeOOUiJ6ZnBYpLYe6YOwQMmC4OOnn+EbD3yb5vQ
         tdGIGPAhDJwf0NIkc/dd4NvbbTYk6igfWmd9MiW6hdhuKna36hqu0UOhEA3WeVp8uZRy
         IeQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715868652; x=1716473452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EmERywOLItQdbPqV7TU/hQijQ/77khKWhpW6wK/l15M=;
        b=hHy9HTqkugiETnvPka5Te7DlqoB+nMJL8OSxWQVCCCg2haasxONcWASerdrHJcEmdX
         deFtazsTgIPlbxRMHq/IQq9lplfLmMIfnAxuhS3OVmLi0+O5jiwhFRcXL2pcPGwkiQJJ
         hMpa+RADwV2wwVrdzn/BFvYvXaler0m/UAU55iJ4R71CO9bRI2PJUy6rR4e34UnAB9PR
         AYjDAlF5DASK43PT9CU/IAUc2HlLGYEb0iWwh4eJb0Xf6asUF304nnwGPbzoVPTWi+FY
         KIbqy25UfzD5wiUF5o1ezyV56xjDltCmv3cVUeWpGfJJIG4sp2iJn2EkG61vckCACJZK
         Vvhg==
X-Forwarded-Encrypted: i=1; AJvYcCXpOOP2kjI8AuEVIMOw6rJVnlmqei1nG+xJTQmOxHIVEHbgIUxFFTUJohsedNQIEiv/n1Uv2CzCFPXrhuSzFVdQekx5gdqKGSKz0y3R
X-Gm-Message-State: AOJu0Yxgqw0UlG1XXEAteMciBsLc+a5/WmQRxIXnm0Nrdjw3F2rVz3Qv
	lS/ReyVXWYIOwAoYF78DFt11Qc6NcXgJPN82URSHeDj1ddoyH5eOBfIYWrOt5hKe9bErj0xxSOD
	pZ2zT+8DlGPJT4G56hBP2O+j3GvVMvKwF99g3
X-Google-Smtp-Source: AGHT+IFSxIIw5+TRsjWyYP9yGDTrpI+j1ZHyy/eI6LFhWko+dNPEXPkD5HoZu1iEfsp1TB70Tl70y9O174itz+Z1MxE=
X-Received: by 2002:a05:6808:1206:b0:3c9:930c:1c9 with SMTP id
 5614622812f47-3c9970cfad9mr29242397b6e.40.1715868651918; Thu, 16 May 2024
 07:10:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240516133952.4072309-1-cmllamas@google.com>
In-Reply-To: <20240516133952.4072309-1-cmllamas@google.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 16 May 2024 16:10:40 +0200
Message-ID: <CAH5fLgjP8eozdA3wSari2LHyVUzaOMNTU12JWb2rzGgy9RRpsg@mail.gmail.com>
Subject: Re: [PATCH v3] binder: use bitmap for faster descriptor lookup
To: Carlos Llamas <cmllamas@google.com>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Tim Murray <timmurray@google.com>, John Stultz <jstultz@google.com>, 
	Steven Moreland <smoreland@google.com>, Nick Chen <chenjia3@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2024 at 3:39=E2=80=AFPM Carlos Llamas <cmllamas@google.com>=
 wrote:
>
> When creating new binder references, the driver assigns a descriptor id
> that is shared with userspace. Regrettably, the driver needs to keep the
> descriptors small enough to accommodate userspace potentially using them
> as Vector indexes. Currently, the driver performs a linear search on the
> rb-tree of references to find the smallest available descriptor id. This
> approach, however, scales poorly as the number of references grows.
>
> This patch introduces the usage of bitmaps to boost the performance of
> descriptor assignments. This optimization results in notable performance
> gains, particularly in processes with a large number of references. The
> following benchmark with 100,000 references showcases the difference in
> latency between the dbitmap implementation and the legacy approach:
>
>   [  587.145098] get_ref_desc_olocked: 15us (dbitmap on)
>   [  602.788623] get_ref_desc_olocked: 47343us (dbitmap off)
>
> Note the bitmap size is dynamically adjusted in line with the number of
> references, ensuring efficient memory usage. In cases where growing the
> bitmap is not possible, the driver falls back to the slow legacy method.
>
> A previous attempt to solve this issue was proposed in [1]. However,
> such method involved adding new ioctls which isn't great, plus older
> userspace code would not have benefited from the optimizations either.
>
> Link: https://lore.kernel.org/all/20240417191418.1341988-1-cmllamas@googl=
e.com/ [1]
> Cc: Tim Murray <timmurray@google.com>
> Cc: Arve Hj=C3=B8nnev=C3=A5g <arve@android.com>
> Cc: Alice Ryhl <aliceryhl@google.com>
> Cc: Martijn Coenen <maco@android.com>
> Cc: Todd Kjos <tkjos@android.com>
> Cc: John Stultz <jstultz@google.com>
> Cc: Steven Moreland <smoreland@google.com>
> Suggested-by: Nick Chen <chenjia3@oppo.com>
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

LGTM. One nit below, but it's not a correctness issue.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

> +static inline unsigned int dbitmap_shrink_nbits(struct dbitmap *dmap)
> +{
> +       unsigned int bit;
> +
> +       if (dmap->nbits <=3D NBITS_MIN)
> +               return 0;
> +
> +       bit =3D find_last_bit(dmap->map, dmap->nbits);
> +       if (unlikely(bit =3D=3D dmap->nbits))
> +               return NBITS_MIN;
> +
> +       if (unlikely(bit <=3D (dmap->nbits >> 2)))
> +               return dmap->nbits >> 1;

I think this is intended to say that we only shrink if only the lower
fourth of the bits have any bits set, but for the condition to
actually be that, you need `bit < (map->nbits >> 2)` here instead of
`<=3D`.

Alice

