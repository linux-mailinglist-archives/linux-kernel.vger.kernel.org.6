Return-Path: <linux-kernel+bounces-221421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D8F90F35E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 18:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01E2128131E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 16:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42CFA156C5B;
	Wed, 19 Jun 2024 15:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gUNd32TU"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94881514FD
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 15:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718812130; cv=none; b=BV7AShFso5HYZ1X9KzjBDnjMGB0Z9XOg9WW0W9TrnMoerzoS/j6HPPZd/NC+YPK9WM+qcFg8GUiltrgt+dVh4zzYJ4NYleYVUQSLbeRJDMPzhotr5PrYgE2UqC6uvqbiyZDs6fDpfW8iC1ngo3YqMfRrc0XEaAZwA3klCEGg+0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718812130; c=relaxed/simple;
	bh=44tfr9Q/yxzd5k0GS5X2bOuf4cl/wNWn1fVz/zaqgb0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bg4mGWx8xcFmsizFbe8OXR2A+yvFj/GvVgvY5WObrvDOIDuC/shX+nwzBINn2mjCCGUJzUOEBMmRPAOPHrqjqENp2+UuExtKZ+Y9ILNQZ8+C3k0TRzmsl+6Nw+aWNUqmVGE2vz+6UfeIfNwrDGJ4aYBjepzBNikAuPMj+lbEhjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gUNd32TU; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2eabd22d3f4so80909651fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 08:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1718812126; x=1719416926; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Z8dIFFBUj8uYaau0DmFweJKWuC0Ps3w+y7afUQaxxWc=;
        b=gUNd32TUMs1vPxcXbKaFocojq6B/mAuj7iXzO4b5V9FpOqF9P74fYSjQm8O5sWP1nf
         fFlqgzv2VxoAzu1PxZ8K7+Qh+vFdphYBGXt8XwdrSqYmFOjOGyrMD43aygO3ENicP85z
         fvioXxIT/nXYJl50SzmuVTd2+25ISzbL8cZw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718812126; x=1719416926;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z8dIFFBUj8uYaau0DmFweJKWuC0Ps3w+y7afUQaxxWc=;
        b=ciCgsVWGzYKr6gZe8mM0gfqyOffunviA5oRVcR2bSesJ7CB3ZGnP5c7lZsnpTRIH2K
         DNd4FJ/iSbT1yzqSAppUtxPWKXvzdXcTG940lqMonxEDQKaEmpLMBFDNZeRs81FOkKMB
         Z13jkrdcEc6CgUup9YxJ6cYYNROgyogCqzw2YzpiZHg1ipLm9GWyz27o38rDMPkjcuy+
         HxaWf+6WqNQkk2954Hg6hyxs73aEDkduFb9GLkLqg3ndJbyP5bTpAIeURioqQxpX+ZHd
         ZDXteKcI6SwNles5+FYNpU4V7gBvp5rHHDw/Hx0EBu9DiPr/k9pXbG2LyUYz9vKJTz/s
         bKCg==
X-Forwarded-Encrypted: i=1; AJvYcCXB+/QFxgeiEg+VLNEhFRChXAuwQ8r4YOzt0prBcDQMY1EYTEMj5A2nOsxJhhhMHmeVCPjTt7JVpCAV4xgydpZUU7DYVzDuNyvqV9SJ
X-Gm-Message-State: AOJu0YwZt4gL7OhfI5Owxk2syLpSPiExiO58JYX0I6ccAGcUTtowZSZ9
	I9drFsGXnyRaKJGWcJ+nrSvHBcM5yZzy+KvQsEqBQy60IqqNt01O8o/zIN/FPY7okFLujB2M4Kh
	nLmU=
X-Google-Smtp-Source: AGHT+IGf6CpS3jJ01PR7fRTnSL8SXuh1g62NoDvQo9cNz3s9O16TJMa7Yok2PqK7eLe+J8xzeNQ3xw==
X-Received: by 2002:a2e:3203:0:b0:2eb:de2b:940 with SMTP id 38308e7fff4ca-2ec3cff2e67mr17867081fa.41.1718812125878;
        Wed, 19 Jun 2024 08:48:45 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d0d9c3b7fsm593956a12.55.2024.06.19.08.48.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 08:48:45 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a63359aaaa6so1052939566b.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 08:48:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVLg6+9U9sdgWGO4ItryZOQBYI64JKHgp2wmQWEpYLUP2s4kTH/X+gkNbjBc1rgAjqHiKqE7O8hqZ+ymO9BAkzi0GlMhP75fWzOIr7p
X-Received: by 2002:a17:906:5590:b0:a6f:5562:167 with SMTP id
 a640c23a62f3a-a6fab648adcmr149389966b.38.1718812124564; Wed, 19 Jun 2024
 08:48:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJFLiB+J4mKGDOppp=1moMe2aNqeJhM9F2cD4KPTXoM6nzb5RA@mail.gmail.com>
 <ZRFbIJH47RkQuDid@debian.me> <ZRci1L6qneuZA4mo@casper.infradead.org>
 <91bceeda-7964-2509-a1f1-4a2be49ebc60@redhat.com> <6d3687fd-e11b-4d78-9944-536bb1d731de@redhat.com>
 <ZnLrq4vJnfSNZ0wg@casper.infradead.org>
In-Reply-To: <ZnLrq4vJnfSNZ0wg@casper.infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 19 Jun 2024 08:48:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=who82OKiXyTiCG3rUaiicO_OB9prVvZQBzg6GDGhdp+Ew@mail.gmail.com>
Message-ID: <CAHk-=who82OKiXyTiCG3rUaiicO_OB9prVvZQBzg6GDGhdp+Ew@mail.gmail.com>
Subject: Re: Endless calls to xas_split_alloc() due to corrupted xarray entry
To: Matthew Wilcox <willy@infradead.org>
Cc: David Hildenbrand <david@redhat.com>, Gavin Shan <gshan@redhat.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Zhenyu Zhang <zhenyzha@redhat.com>, 
	Linux XFS <linux-xfs@vger.kernel.org>, 
	Linux Filesystems Development <linux-fsdevel@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Shaoqin Huang <shahuang@redhat.com>, 
	Chandan Babu R <chandan.babu@oracle.com>, "Darrick J. Wong" <djwong@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 19 Jun 2024 at 07:31, Matthew Wilcox <willy@infradead.org> wrote:
>
> Actually, it's 11.  We can't split an order-12 folio because we'd have
> to allocate two levels of radix tree, and I decided that was too much
> work.  Also, I didn't know that ARM used order-13 PMD size at the time.
>
> I think this is the best fix (modulo s/12/11/).

Can we use some more descriptive thing than the magic constant 11 that
is clearly very subtle.

Is it "XA_CHUNK_SHIFT * 2 - 1"

IOW, something like

   #define MAX_XAS_ORDER (XA_CHUNK_SHIFT * 2 - 1)
   #define MAX_PAGECACHE_ORDER min(HPAGE_PMD_ORDER,12)

except for the non-TRANSPARENT_HUGEPAGE case where it currently does

  #define MAX_PAGECACHE_ORDER    8

and I assume that "8" is just "random round value, smaller than 11"?

             Linus

