Return-Path: <linux-kernel+bounces-374825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 622149A70B3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 19:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B07F1F21681
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 17:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC9C1EABBA;
	Mon, 21 Oct 2024 17:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eOn8ZvcR"
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFCA1E9072
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 17:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729530693; cv=none; b=M9e4JTWfuvpATBM9qIJFkr8dP2iLb8uRumgkcIZaFcwW0/PJoYqzocqc8mngT7VeQSFjSug6I9WVuMF7SnzrewqU5XXC4xlj3aiJ+uDpKfaeCJ80nmHNnwjWrA5/yoodA7TY75JK6c1gZQYy1agV07CVL5W8K3YGgEkII4/RlC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729530693; c=relaxed/simple;
	bh=AB9B8rWSlQfyFwxAGRY6xmw2pVOW4B3zewQVR9Nmebc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c1jijfxtjUkQgdrPMubdlIU3qAFZzCtv8Cn0uY1bOZ7Km954tfPEU3UnGBGwwIo4nw8GB34iI2o80371LEvoGVjTCm9l4Kja45/WjB+gZu3p2KSFg39MogYWXYjQEeMqnfL/IeCVIInNBuo94BiqsXLq7Og+WVEFgl3/OF5+8Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eOn8ZvcR; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3e5f86e59f1so2143556b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 10:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729530690; x=1730135490; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VVD1/Gs/UV2hAlYKcDc2hPgiUBvhgKLwMO2CWEYGkw8=;
        b=eOn8ZvcRQ2yRbTCyNu/OSPeuOW9YPnE8KUwZad6B4lcczP9uSiaT1z5eA3k2zNQ6bM
         inPvQ3bnVbCy0IN5pw20+hz+uEldY7C28sT8H6shrnFWDoAvcsrGdqW6u3aoSBp2fDnA
         Hnm5QS97O2tqLpkggiV3RHBzKF7D9aFUF82WmyLRR277XIbXv2Fpg8wY0ue6zbQs2Gzs
         BYQkQGAq1T+gfqP5zXieAaeO5WyTvbWPY78QAG3BzzH8GYxjQAH2a9IT5UqPWjJAUYBF
         rmpxvBXWerJsNDEJFpGXNd+CcS4y8LL/kPMCjlTVGchz963smUWl9bk6Exr+QwHhpixV
         HfqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729530690; x=1730135490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VVD1/Gs/UV2hAlYKcDc2hPgiUBvhgKLwMO2CWEYGkw8=;
        b=Bdo44zmf98a0zu+7rfzZTzHj5a0tpoyZD+as7k6IVmZAtw4nUr7zMMiqtAfXphQn8T
         60xwHv0Bz5FDJ3dpiaEydn+omHbR8vuWi97ecvoqy89IcjmbUMFwIeUtYYjKeheCl63F
         I5yPvqX9xeFVM1ZegR5/q/VOqkBvbxeu4aB0hdKNIUibf+nXSlhDEJXzXu0cRVgWTzUk
         wxKfLhwN8OHcXO2AGHT+fJwNlTvUrdwN8yIwNvAAIfkbMg4jf8jPqtJyINClwRueACEK
         3gST9PoRN/dNOPuybeqtukInAzGLhWFZfL8UMpNjALCedojlISpuUed10xibsap+zZTQ
         vXxw==
X-Forwarded-Encrypted: i=1; AJvYcCWxcm96OulLCtS+J6iDh9o/4NUEVm6X33ct+uCdFUjw+lYsCpXCHG31MAso2fOh5/7sfo/rQPfTthfS2zc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPnqSN/kNwappoDPE89EiNn9XbZkrl28UP+HgF1dwy8Uqbjsdw
	VGKSk41Zhgk5JMeW8ty+YF2gilhSUxMgWue+WiGO9zThz6ttqj0pBD3JKExL0yyLjSj6Fn9yN43
	44A5yXq1L1eAzetygGINSR577xiUxBeMqsvxM
X-Google-Smtp-Source: AGHT+IE5IYEOnusSbwRaOoohouovq/nAXtWalfDcpLhj/iQUCuxLUlnvjJNLs/bzfurkYMkzwq4i4qmHj9N+NqrTb3k=
X-Received: by 2002:a05:6808:1155:b0:3e0:71c9:cbd9 with SMTP id
 5614622812f47-3e602c8f9acmr11123528b6e.13.1729530690056; Mon, 21 Oct 2024
 10:11:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241020051315.356103-1-yuzhao@google.com> <ZxYNLb0CiZyw31_q@tiehlicka>
In-Reply-To: <ZxYNLb0CiZyw31_q@tiehlicka>
From: Yu Zhao <yuzhao@google.com>
Date: Mon, 21 Oct 2024 11:10:50 -0600
Message-ID: <CAOUHufZ1fBvj0DgxtuLvwMAu-qx=jFAqM5RaooXzuYqCCTK1QA@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v1] mm/page_alloc: try not to overestimate
 free highatomic
To: Michal Hocko <mhocko@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Rientjes <rientjes@google.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Link Lin <linkl@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 2:13=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Sat 19-10-24 23:13:15, Yu Zhao wrote:
> > OOM kills due to vastly overestimated free highatomic reserves were
> > observed:
> >
> >   ... invoked oom-killer: gfp_mask=3D0x100cca(GFP_HIGHUSER_MOVABLE), or=
der=3D0 ...
> >   Node 0 Normal free:1482936kB boost:0kB min:410416kB low:739404kB high=
:1068392kB reserved_highatomic:1073152KB ...
> >   Node 0 Normal: 1292*4kB (ME) 1920*8kB (E) 383*16kB (UE) 220*32kB (ME)=
 340*64kB (E) 2155*128kB (UE) 3243*256kB (UE) 615*512kB (U) 1*1024kB (M) 0*=
2048kB 0*4096kB =3D 1477408kB
> >
> > The second line above shows that the OOM kill was due to the following
> > condition:
> >
> >   free (1482936kB) - reserved_highatomic (1073152kB) =3D 409784KB < min=
 (410416kB)
> >
> > And the third line shows there were no free pages in any
> > MIGRATE_HIGHATOMIC pageblocks, which otherwise would show up as type
> > 'H'. Therefore __zone_watermark_unusable_free() overestimated free
> > highatomic reserves. IOW, it underestimated the usable free memory by
> > over 1GB, which resulted in the unnecessary OOM kill.
>
> Why doesn't unreserve_highatomic_pageblock deal with this situation?

The current behavior of unreserve_highatomic_pageblock() seems WAI to
me: it unreserves highatomic pageblocks that contain *free* pages so
that those pages can become usable to others. There is nothing to
unreserve when they have no free pages.

