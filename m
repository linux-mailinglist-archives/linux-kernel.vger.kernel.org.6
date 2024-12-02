Return-Path: <linux-kernel+bounces-428481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E6D9E0F0D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 23:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59CDF16432C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 22:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099C11DF96B;
	Mon,  2 Dec 2024 22:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FbMhRmb1"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89541DB940
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 22:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733179864; cv=none; b=udf5TYwcucal0EHsbVJWBrKnLJLK0z+oTbl1qCUBzgTs6xKLH/p62lCABcKolB9Eop07cN8GBqBbq7RvM4VNzMyvKErQAq8BjtRtegbJfBV98GSPlmdxCQqifq5LQ8qqTCWAoAKh+/VPS3yJTDFboD8KLnhyyGMKq/NuTpuqMZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733179864; c=relaxed/simple;
	bh=xD++Pu2Owlwdz/HJYnfDKrfCE8Tqkbg/Wk+AX/Qx0C8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S2fWk2AQVppJEbWaSF10p2DkJ9iElaKDjpYUChIwup5TzWoXfpEEW8FsH7TtaBifFcKRXm+VBPYo4HgQRJYQGE+3DT92KtrAxYUUvLqbwla0Znma1Za0qjpPdIyLQRKmUMnXW329/YkKCR5oJrihHUmcj3ggj0uzqXD1gjBaLxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FbMhRmb1; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53ddad86f4dso1311e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 14:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733179861; x=1733784661; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xD++Pu2Owlwdz/HJYnfDKrfCE8Tqkbg/Wk+AX/Qx0C8=;
        b=FbMhRmb1rTDpBqhWr0YrcmyCN+70hBf+RnJLWRgTD8Wc7QjhL6cO+6RgiIe6btYxVr
         BFEXUsk+CwMyM4d31XhG5rNVbBUJs6biyodsKAYhDcwrf96xIcYHSsi2CxCUuiFMh4cp
         x1VZpimnYobCK0CqlytwQUj7PHnjWJWKXgKe3dAcY4iRQw+1RWNfwatgtx9Qq3TbBvJ8
         XN8CGBHF6s0frnQGxTSu7B5VzwI6WRwV97bMo87gp0yHnBeYXrECc5rYknLlHbx1y6mF
         q9QCKGRLmiZrqgjYrLn/bNYRHeawWCD8+6wJkxe9Qzb0NtRvLuyisnojXQX9LTSpDLGy
         SYFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733179861; x=1733784661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xD++Pu2Owlwdz/HJYnfDKrfCE8Tqkbg/Wk+AX/Qx0C8=;
        b=oM3CHTXK9RoYKaUs4wi0Z9xx1kOt/HsSFvrDtOLKDHtlsIVP09OJUv+LA4BYITT/aS
         s9gbuVt7wdJNFCRTr7IaGBxYl4AIcY71Kn1R2ORzAB8nM8Vskp9RMchn97xCjYh3MYM3
         1GBB4/xf5RYQpt8KW/Gs+Yel99F4wDpf6pgRysr34ZVJ6vCwF48lZpp3I68vXX5VeWOy
         B3v9FqZxlGER5Bdy8966PkzjYrNZI8llyqSfeMyvXqZhEC2rElUnptfa4QgQ4k+6KYZg
         aCc3XUu5LEURJr7t0LcUXkBWfdbB6SoIv/UfPjXwtL0aZeTYmBZ4x9tcZB0yvjb54GIx
         gp0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXTQ5nKnUwS/TK2r3qa6bptFFLPgbJVvKtbZ67gRnBhP9Y7zq1n4jNPUcoX6eQzPPuAmnGaR+WxuM5xoCY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaG9b3df6xKQ1MBWw2S9IfgAFjuIURHEjglRxd80RbRyzLimqn
	ziUaV+CFDguzCJwu8Lhilo8e4VUjKAcD9vHoMPlai1mOYAocuT+cBe+irJW491P9MCK3y4MHU4h
	fKLSmijGqmnW2hofC7qy8pYSjQuw/tfUUfO1O
X-Gm-Gg: ASbGncth4JnjE/F97ohqY25khsGtxY1IjZ3kXAV90vhIvdF4hGVVAnxn+nQZyYBSBic
	ZySHkIDDdJzYBgH/JMBU8IesOYGEv
X-Google-Smtp-Source: AGHT+IHtcvBhHAx9qITe3ZXRX+vuVeVnkREr9poKckp6W8ETlL79sRXQdbH7chQZER3ONqKDyN8Ihk+RnC1IMlKztN4=
X-Received: by 2002:a05:6512:2c97:b0:53d:b15d:1348 with SMTP id
 2adb3069b0e04-53e12938ccfmr41765e87.4.1733179860582; Mon, 02 Dec 2024
 14:51:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202202058.3249628-1-fvdl@google.com> <3tqmyo3qqaykszxmrmkaa3fo5hndc4ok6xrxozjvlmq5qjv4cs@2geqqedyfzcf>
In-Reply-To: <3tqmyo3qqaykszxmrmkaa3fo5hndc4ok6xrxozjvlmq5qjv4cs@2geqqedyfzcf>
From: Frank van der Linden <fvdl@google.com>
Date: Mon, 2 Dec 2024 14:50:49 -0800
Message-ID: <CAPTztWbmkFisL7qnmAnre5hv=UD1E60P0hr_kXNyLoQFy9OoTA@mail.gmail.com>
Subject: Re: [PATCH] mm/hugetlb: optionally pre-zero hugetlb pages
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, 
	Muchun Song <muchun.song@linux.dev>, Miaohe Lin <linmiaohe@huawei.com>, 
	Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024 at 1:58=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> wr=
ote:
>
> On Mon, Dec 02, 2024 at 08:20:58PM +0000, Frank van der Linden wrote:
> > Fresh hugetlb pages are zeroed out when they are faulted in,
> > just like with all other page types. This can take up a good
> > amount of time for larger page sizes (e.g. around 40
> > milliseconds for a 1G page on a recent AMD-based system).
> >
> > This normally isn't a problem, since hugetlb pages are typically
> > mapped by the application for a long time, and the initial
> > delay when touching them isn't much of an issue.
> >
> > However, there are some use cases where a large number of hugetlb
> > pages are touched when an application (such as a VM backed by these
> > pages) starts. For 256 1G pages and 40ms per page, this would take
> > 10 seconds, a noticeable delay.
>
> The current huge page zeroing code is not that great to begin with.
>
> There was a patchset posted some time ago to remedy at least some of it:
> https://lore.kernel.org/all/20230830184958.2333078-1-ankur.a.arora@oracle=
.com/
>
> but it apparently fell through the cracks.

Hi Mateusz, thanks for your reply.

I am aware of that patch set, yes. The discussion around it evolved in
to one about kernel preemption and the evilness of cond_resched().

You can certainly improve the time it takes to zero out a 1G page by
optimizing the code that does it. See also, for example,
https://lore.kernel.org/all/20180725023728.44630-1-cannonmatthews@google.co=
m/

However, while, say, a 50% improvement in zero out time, at the max,
is nice, this still leaves the faulting process spending considerable
time doing it. Like you say, that's cost that needs to be paid - but
it would be good to avoid paying it inline. This patch avoids doing
that altogether, leading to a basically 100% improvement under
reasonably good circumstances.

>
> Any games with "background zeroing" are notoriously crappy and I would
> argue one should exhaust other avenues before going there -- at the end
> of the day the cost of zeroing will have to get paid.

I understand that the concept of background prezeroing has been, and
will be, met with some resistance. But, do you have any specific
concerns with the patch I posted? It's pretty well isolated from the
rest of the code, and optional.

>
> To that end I would suggest picking up the patchset and experimenting
> with more variants of the zeroing code (for example for 1G it may be it
> is faster to employ SIMD usage in the routine).

See above - happy to pick up older patch(es) as a separate effort, but
they won't fully solve the issue for the scenario I'm describing.

>
> If this is really such a problem I wonder if this could start as a
> series of 2MB pages instead faulted as needed, eventually promoted to
> 1G after passing some threshold?

This idea sounds similar to HGM (high granularity mapping), an idea
which was originally posted for the purpose of live migration of VMs
(but never made it in). It's not trivial, and seems like overkill.
Again, my patch is non-invasive and optional, so I think it's better
in that regard.

- Frank

