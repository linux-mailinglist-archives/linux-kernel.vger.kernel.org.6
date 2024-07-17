Return-Path: <linux-kernel+bounces-255676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F8893439C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 23:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56BEB286BDF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 21:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3388184125;
	Wed, 17 Jul 2024 21:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Op4RU/zR"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BD426AE8
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 21:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721250073; cv=none; b=FV8iqkyrwRztLma2FuGQPfEIkxRseeGZ/aq1vDHroMQfpcskLzDBuNUhb6dz5h0/Ju5oAAG9WhWpV3EL5Of5uLimUzrxdRTGavJUwhgVB7EXxpqgDEOPbYoSWO6L99n+hsBosDUfjMheS7D+rNlg/KfdwpycklmHt9naJ/37ZEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721250073; c=relaxed/simple;
	bh=Qa2XvP+C/3oeccCjHgfKummAIm8e+1hP7Ck2ED7Kxsg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZvfOhZw7H5UAFU7K6z26FJlf0aB4C7ezixky0w0JB9XElosygxukt26AdInexjkOCGcvEtfZPf0ETFqTuNWYka+Y8JdL8oXZ9UQBNEXVHbL3m+ZLZIIHbOkgrCv4o6UQn3UGj/SCzb8XwHpvigF6BwQtCqcXlrQLYmgwKOZ8RDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Op4RU/zR; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dfdb6122992so122325276.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 14:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721250071; x=1721854871; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qa2XvP+C/3oeccCjHgfKummAIm8e+1hP7Ck2ED7Kxsg=;
        b=Op4RU/zR1h4pGG3zH2oUufMmw/Qvkyo23R0IG5DSTA3viLXtxMbSRrLJ3RJw7db9m7
         UJnra/Uh0XCFqKCSIlD6/0AknwsmNDPrP04/MabjrJxu6GAm21reLUdK2FaxClv+UVPt
         xDMZuiZgJ8IpHxfqsn10tcOXGxTJuwN11hqh1iT+uH+4l8FF6zCmxCyElOAP1DogCJ+y
         0cKtX0tMRc/DUSu30aJP/tBlM+wm6BZrQuL096GE3peSyT0KAugz3vOl0MNYxTuCgAgO
         xUaj4d4bTK5y0eWIWiXCmlOgbhIrP/Awf8qlmEs1Ix42rHNoyYmAVFNbiCBJL3qM6cwq
         rcRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721250071; x=1721854871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qa2XvP+C/3oeccCjHgfKummAIm8e+1hP7Ck2ED7Kxsg=;
        b=T1ZRLfk2yPqAa289p6xqHcH+/DWRmCX/5q5Xs5ST3sE7yhs0RzyEPcDI6MMsLxB7dt
         UVc/03meJpWVzKnx6XCiM+EbZcpqAkMw2N2sXVDd6blB12xnBHGU5LqYsiwqifgeJcZO
         vY8YBCgsj6W8IxHTTF07+E6RdbEkK9PiA7KCaT//kIbRwBrweYtLMcG/yf1pxX77sk9U
         JVQUwOdINTlpo/N/IbF5asmTCPvQREDs2o5JqienbFxuC9A8LDJ0CXKcOHN444Pgp9CB
         AUkrARoEPfbCU0uonvD9eLjU2YBDbWDgegTAXht96IHv08yqn9AN5Ne20lvfukR29Zfh
         /Ikw==
X-Forwarded-Encrypted: i=1; AJvYcCUCrBjQsL//3fOSdxNix9w1vbAiZEa7qKdsbC6RgVxbC8mEYhAqg2mFTnviyHOGqXPuEsVV5+EIrfmsTIexT0ET7j987UMVI2/BIXPk
X-Gm-Message-State: AOJu0YxdgR5P4rLctQU0qjnX2ZGK1SPcrw/RHRaGN+OGn4Hmann7Fa2D
	YxCAnlJWrHwegdA7nJO2ShzdisfazKW5XAw2yjd9R/IxTUZRP8dvTv9G8ttAlnRBdDOvXvKgNjv
	qcqS6h1/pccz0z5wi2snXm5qrYyoC/MDe0Q8V
X-Google-Smtp-Source: AGHT+IHdAN8Zygajofm83EFiNsxZUGRZYcOfrMblNz/bnqG3bIIRWIxc/dHHBoQXgnAbK/ILfo8V2BUbVMDkWG5u0/k=
X-Received: by 2002:a05:6902:1502:b0:e05:fa51:9f89 with SMTP id
 3f1490d57ef6-e05fa51a28dmr2191237276.22.1721250070367; Wed, 17 Jul 2024
 14:01:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240716130013.1997325-1-kirill.shutemov@linux.intel.com>
In-Reply-To: <20240716130013.1997325-1-kirill.shutemov@linux.intel.com>
From: Jianxiong Gao <jxgao@google.com>
Date: Wed, 17 Jul 2024 14:00:56 -0700
Message-ID: <CAMGD6P1E+hoH_HGhmBvXskMgNvALYiNj-dhJWvzQuTx4sd1SxQ@mail.gmail.com>
Subject: Re: [PATCH] mm: Fix endless reclaim on machines with unaccepted memory.
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Borislav Petkov (AMD)" <bp@alien8.de>, 
	Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 6:00=E2=80=AFAM Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> Unaccepted memory is considered unusable free memory, which is not
> counted as free on the zone watermark check. This causes
> get_page_from_freelist() to accept more memory to hit the high
> watermark, but it creates problems in the reclaim path.
>
> The reclaim path encounters a failed zone watermark check and attempts
> to reclaim memory. This is usually successful, but if there is little or
> no reclaimable memory, it can result in endless reclaim with little to
> no progress. This can occur early in the boot process, just after start
> of the init process when the only reclaimable memory is the page cache
> of the init executable and its libraries.
>
> To address this issue, teach shrink_node() and shrink_zones() to accept
> memory before attempting to reclaim.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reported-by: Jianxiong Gao <jxgao@google.com>
> Fixes: dcdfdd40fa82 ("mm: Add support for unaccepted memory")
> Cc: stable@vger.kernel.org # v6.5+

Tested-by: Jianxiong Gao <jxgao@google.com>
I have verified that the patch fixes the systemd issue reported.

