Return-Path: <linux-kernel+bounces-428429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BAC59E0E47
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 23:01:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2ACB2B28E4D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 21:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BBC1DF74B;
	Mon,  2 Dec 2024 21:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jn4qmnZ+"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5985F1D5AC0
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 21:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733176697; cv=none; b=nz45y7Ac2+yo/LOfYch0tG5mi7g/WY6ecPMJlHluy61i3adbrrwTwWuHQeDPHwU4nnnWus3oUYyPmuZz6RX8MVohWFYT12bgA6fYTxCcuOybMf2EOLSXZKcDeDuVDQZwvPutiFuxJL/bpoguR4lLQkyuY/ulSKmfFY1GKsILEXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733176697; c=relaxed/simple;
	bh=+/DVVW6WUjdjLg5RORA2jmgavCUSk2XulB8IIihD9Wg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MEMJ3XxYFC+yxGYYE2n9nfwxvGJ0/37UohbItO/sgJTkKUh0ho+oomlQ7y+2o3jqB1AGJoz76GeHGghUIxB+8mXV9unxAQuK9sbzSzt1yREG832ECIIRBVLF98Be543hi0p0x59PRzU3PnnMd9wm13xnHvNmDcX8WzmZCe3muu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jn4qmnZ+; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5d0c7c8cd6cso4672169a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 13:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733176695; x=1733781495; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mrBbGY/AkvyAnPMS5AoFhOpFUDEMtFSR3nExs8D5+LU=;
        b=jn4qmnZ+2sigx6c7+gTG1R+RF0F0YnxS0ypyboB4WqQ2NFPGB+D1+HXrxNTyGmHEUp
         CphabwIpQxiJJHifQ2XLl42OYOZO119NmY/QnzC4WPIleLhDgmVSu0Ci8PRS+tE+q1kG
         kYrcjoSBrRtyOaHhJRuHZPlDdfvZCZu3xKTK5VgfCWBSES02MvMBuOapbO1SeRu9Wdd4
         4XMNZjHfu5H1o9VUFPPPBdCMTYa74oyARhRF39BRC1QQRe+Z7yHR63fP604TpEuS1327
         ZIqHgUoqWSFVdYUS37VaXwoZyNexbixzA5QMiJ9ea02qABVIFG0uCrwNwrr7+6Yl75oS
         4Wng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733176695; x=1733781495;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mrBbGY/AkvyAnPMS5AoFhOpFUDEMtFSR3nExs8D5+LU=;
        b=Did7nO0QmQogRUoOKu0NDz4ugTUtp9gufxip3lFTno6uyjeF1aBa0BOEtd7mRzwlg1
         M3jkL3cppy3Eb9ThV+Ku/BL7LrDprL6O+Nz60/yps6ijLw0ThS6qF7jgiuARNLamOOla
         P3mhu0irl9Rem7jaDtnLd4oJxaogfv7stbDu7/+af/QzSkEkCSzJhhUFKGtCeWMna1sF
         eEXVT2gkKH6m2VvzbK49WLLJJ+Yn6zmIqDka1Zo+uYKH1jTQTePumgoocDUPIS6W72uf
         x2tJsUPT5lh/78AI1BK62X9dgB6167Y6nsjEGvtpokzYO7VQfO0Lozv3IiaPzs3EIp+Y
         md6g==
X-Forwarded-Encrypted: i=1; AJvYcCWBFGbGCNukb4QjaONaW8gJILdg6BOWly8iGa2JjBoBM23/caa1qfv1o0DZfW84e8nvJoSSw4iENyNSbrY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkvKWy3/zmx0u2ng0Ce5/mUwT1qJ4xCNiBcsIARt4Y78jNmXvO
	aWWgPeH4RJdZvgrHmeGFaLGp6MZE2Oy3CHPDwb8qEUw+kjedUaQY
X-Gm-Gg: ASbGnctWVDUeeOLJkQfHzjjBeVMgfvfSRlipCpoOIVjJjXWgMkq/XDen8BQ+CC2jCXr
	W5syPphKQ2y0K5O0qrUBxKiGPTWNgl/zvlJ4u59AHsJ7QXPKzykTY0CuBmFz49/cFirmDMbeUy5
	CDvOuvs0/wzegAzweseZGCVJTt1lnnwHsTlXTz0fD5v3UZB1/7AaY0BFRKCD7AT1zkbC4wplkbY
	wBgUIfZtGdF5m2xS6UJZKAmrJ2mMc/jI/g8m2gpNO4ryxyw9efqHe8phTaz
X-Google-Smtp-Source: AGHT+IFv6TBZ6aOG0/JTNc8Vt0A1Qh+GjctKsIGgi8qOVpyNGGZQc7lLfKo4DABA0G+DDReqWQW1Ag==
X-Received: by 2002:a05:6402:270e:b0:5d0:d845:2882 with SMTP id 4fb4d7f45d1cf-5d0d8452bfbmr10046018a12.13.1733176694488;
        Mon, 02 Dec 2024 13:58:14 -0800 (PST)
Received: from f (cst-prg-22-5.cust.vodafone.cz. [46.135.22.5])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d0bfa327dcsm3724662a12.83.2024.12.02.13.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 13:58:13 -0800 (PST)
Date: Mon, 2 Dec 2024 22:58:04 +0100
From: Mateusz Guzik <mjguzik@gmail.com>
To: Frank van der Linden <fvdl@google.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, 
	Muchun Song <muchun.song@linux.dev>, Miaohe Lin <linmiaohe@huawei.com>, 
	Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@redhat.com>, 
	Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/hugetlb: optionally pre-zero hugetlb pages
Message-ID: <3tqmyo3qqaykszxmrmkaa3fo5hndc4ok6xrxozjvlmq5qjv4cs@2geqqedyfzcf>
References: <20241202202058.3249628-1-fvdl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241202202058.3249628-1-fvdl@google.com>

On Mon, Dec 02, 2024 at 08:20:58PM +0000, Frank van der Linden wrote:
> Fresh hugetlb pages are zeroed out when they are faulted in,
> just like with all other page types. This can take up a good
> amount of time for larger page sizes (e.g. around 40
> milliseconds for a 1G page on a recent AMD-based system).
> 
> This normally isn't a problem, since hugetlb pages are typically
> mapped by the application for a long time, and the initial
> delay when touching them isn't much of an issue.
> 
> However, there are some use cases where a large number of hugetlb
> pages are touched when an application (such as a VM backed by these
> pages) starts. For 256 1G pages and 40ms per page, this would take
> 10 seconds, a noticeable delay.

The current huge page zeroing code is not that great to begin with.

There was a patchset posted some time ago to remedy at least some of it:
https://lore.kernel.org/all/20230830184958.2333078-1-ankur.a.arora@oracle.com/

but it apparently fell through the cracks.

Any games with "background zeroing" are notoriously crappy and I would
argue one should exhaust other avenues before going there -- at the end
of the day the cost of zeroing will have to get paid.

To that end I would suggest picking up the patchset and experimenting
with more variants of the zeroing code (for example for 1G it may be it
is faster to employ SIMD usage in the routine).

If this is really such a problem I wonder if this could start as a
series of 2MB pages instead faulted as needed, eventually promoted to
1G after passing some threshold?

