Return-Path: <linux-kernel+bounces-307444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56277964DA9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 20:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F19021F223D8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 18:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 496371B86E0;
	Thu, 29 Aug 2024 18:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a3s9hF3Z"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FF91AAE1E
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 18:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724956145; cv=none; b=VlpNIsYlA5k5005I/lHGjN/i7FIoz42Fx7QOyngDQMB2W5AQZ6yFnkbzQy0FXUEgsW/PyV+tfRQElPsj5I3bcHe2Atbs3OKKeA0gTZdEnOZZu6Qv46yJGktaWyoWkPZ2heIBMysIpAgslHp2KEbBQ6+CWb+crGyJcTnqBpntgeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724956145; c=relaxed/simple;
	bh=uFlJynURVWC+M2UJehrQrk5CWf/a/Gwly+Kkpykmcts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QTwZc41uCTC2qa9hX1Cw9WxEI4rMo8LluPSy/Zm2uo6+25MnKmNehf9OAhKXm6qaPnmiepGHZDnB7J10j/0UqcCCcT4y7PNKQzyie5pgvzxQ1VV1+9L02VwC7KgMGxuswxSDwhCSdgc3uyLod4cfv1rnpjE+eowg3j4vLD+EYwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a3s9hF3Z; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a8696e9bd24so127840366b.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 11:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724956142; x=1725560942; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uFlJynURVWC+M2UJehrQrk5CWf/a/Gwly+Kkpykmcts=;
        b=a3s9hF3Z1kRsUDVfWRJMlkEgoLOPouyvn8zpf5QacXuMkq1yjamUa83QTs0MyRhira
         btMci4O4coCdXBTrhroz8+GInCKRlzMo7Tuk10rKt1P8l7yXTeV3YUJT54lUA27iQLbn
         8xxp4gWSfo4tiu1QBeugA6Q6cGZcys/YqdCihvzgo07osaQnQ+NLJoPbxsfbjI/VNxVH
         iOuAbeEBUWqBligSBzrl6L2ZEqEFlx68VarpP7uVspS2bIGQgROTKPu3MwcuEVh60GQr
         w+Y2taID1L+oEituO7p4NT/rvdSFC5uf9pADP6g4ca5I/3ncew9qnS49uZec5wR4PWr2
         ODhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724956142; x=1725560942;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uFlJynURVWC+M2UJehrQrk5CWf/a/Gwly+Kkpykmcts=;
        b=hjBlb2XLCb24TzGxI8qrueEfMM0QHVQTM/2bj1MY6cS+LppfgWMge7rPWyMRSGuJyT
         3Vj9O2xdmOrhdubR/4lDQCLQ1Om1UU8sT/wlUozbWodDzrLnYU1PaBYXmT8bbX3ag7QU
         +NxeE7mCj20odYuTPYxI8hWtkmTAPq/rN2ZuaqqEPWdLh8HvdpCzUsh3l5JkJrNxVKzV
         Dd2IJb0daTim8yVk9DfktAXxUzqMdSiXwh5OUigu7DTffK8grQNwk3ugpgvU/iHtCgU4
         6Rd9sTHIX1kNyGAy0z6qxcxFbAaykt2bKCqSf2UwtdLdrARpj4bshnNI9PIeVC7wwHW4
         AxEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmEYHvIcPrUTEuNfgI4wbkqbUO/4Ssi6oIxT8YjAypcFS6uzO85dxYlycugfKL17SHvxUhQdPsUhx8an4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh4qzbAUA4PfTWBHgWR0yBjiqVCuqY0yvI5iq8Q5961eZjnLMv
	ovHkcp4+ylmFkLpsKZqDDiW+w/hDf+bNM/dls+38gTapYfQ8IRCZFzMzsxZ5AocbCJqrqXser8v
	fd2vdk8dhkzgpcEzzUz4n6liY7juwW2BOrJW/
X-Google-Smtp-Source: AGHT+IEjCsZ5C7DEJGtuDAb8jQenH6fq4Xe9rcECFO/np82w+7fJUFxQQ/NSCKZtW9cfxdwYkeCFsnLIObrWOWS1Sd0=
X-Received: by 2002:a17:907:868a:b0:a86:9880:183 with SMTP id
 a640c23a62f3a-a897f789550mr277753066b.10.1724956141671; Thu, 29 Aug 2024
 11:29:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827235228.1591842-1-shakeel.butt@linux.dev>
 <CAJD7tkYPzsr8YYOXP10Z0BLAe0E36fqO3yxV=gQaVbUMGhM2VQ@mail.gmail.com>
 <txl7l7vp6qy3udxlgmjlsrayvnj7sizjaopftyxnzlklza3n32@geligkrhgnvu>
 <CAJD7tkY88cAnGFy2zAcjaU_8AC_P5CwZo0PSjr0JRDQDu308Wg@mail.gmail.com> <22e28cb5-4834-4a21-8ebb-e4e53259014c@suse.cz>
In-Reply-To: <22e28cb5-4834-4a21-8ebb-e4e53259014c@suse.cz>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 29 Aug 2024 11:28:23 -0700
Message-ID: <CAJD7tkavjpYr54n13p9_9te-L10-wn6bc_uLkAozsuFWT31WjA@mail.gmail.com>
Subject: Re: [PATCH v2] memcg: add charging of already allocated slab objects
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	David Rientjes <rientjes@google.com>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>, 
	cgroups@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

[..]
>
> Another reason is memory savings, if we have a small subset of objects in
> KMALLOC_NORMAL caches accounted, there might be e.g. one vector per a slab
> just to account on object while the rest is unaccounted. Separating between
> kmalloc and kmalloc-cg caches keeps the former with no vectors and the
> latter with fully used vectors.

Makes sense.

>
> > Wouldn't it be easier to special case the specific slab cache used for
> > the objcg vector or use a dedicated cache for it instead of using
> > kmalloc caches to begin with?
>
> The problem is the vector isn't a fixed size, it depends on how many objects
> a particular slab (not even a particular cache) has.

Oh right, I missed that part. Thanks for pointing it out.

>
> > Anyway, I am fine with any approach you and/or the slab maintainers
> > prefer, as long as we make things clear. If you keep the following
> > approach as-is, please expand the comment or refer to the commit you
> > just referenced.
> >
> > Personally, I prefer either explicitly special casing the slab cache
> > used for the objcgs vector, explicitly tagging KMALLOC_NORMAL
> > allocations, or having a dedicated documented helper that finds the
> > slab cache kmalloc type (if any) or checks if it is a KMALLOC_NORMAL
> > cache.
>
> A helper to check is_kmalloc_normal() would be better than defining
> KMALLOC_TYPE and using it directly, yes. We don't need to handle any other
> types now until anyone needs those.

is_kmalloc_normal() sounds good to me.

Thanks, Vlastimil.

