Return-Path: <linux-kernel+bounces-222029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9746190FBCF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 05:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EAC1283D37
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 03:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6947024211;
	Thu, 20 Jun 2024 03:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zpgwds+l"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E18200C1
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 03:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718855988; cv=none; b=Cn8aB94oqKnkAqw9chWQE+wUOgaRnM4EmtGpjK4TVg6tpv6krO7l2V1maf20S17aBOyQVgE+eUiXbiYfxOK0cIKdv5GPf0BO798HzCcAZlu1PNaezZ9+DluMAFeUQ8RDGGrOvbMb/oVwjTKrkY5Ck9nGW0btRQP1svcM1jU6kO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718855988; c=relaxed/simple;
	bh=Q80GzVScXFU5boHd0SMWfobeBMQeW5+d66daP3QMaG0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=JtADtHtfMDpL2DDFdzDQQc1YxcJPJjo81pVMdluIGBAwB/vkCSNq0CSIt4uB7/u6vvHMD/GJbEvQuNVfevvxPob8bIZCOPJiMT9Ihd/dTMCmD6+scFsabEFbWj2mZAtks3E1kNLo/axfC6imB36jkMcLqMrsZq2R1anLLP307l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zpgwds+l; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e02c4168e09so408352276.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 20:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718855986; x=1719460786; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HBwc7mPCGMDxzjg6zCv5GvwP0k9UEQfjFaEZ4/talLE=;
        b=zpgwds+lRVOJmXn7d6NrF2mvYKKz/3XFnBkqSjHUJC18zhns0oixobcPZc7363QSZ9
         7cgAfqi3pUntWmPrTGK/IgJYeq1t0OWE47WLcLN1wOipQO5otaTGNLBigsLuJcVYukdC
         ap7J9LkKjfS1gZMtGw9l6zQw9UXYZQ/uKRFkVoin8h70jOokvSzZqzpmY00Sw0zmaFtZ
         2nAgrkbxk93haBGl7s7qbOu+mF/ftV9dnWACYogJ2Y2deb46K3gJneGzCKJRgkj2BLnN
         i37eWIoUXDkd8wBQR8HXliVWrivKNSaJ0dNX4pQJGr1veNpAqlOeW/L/nujm64sRQ8xI
         uNdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718855986; x=1719460786;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HBwc7mPCGMDxzjg6zCv5GvwP0k9UEQfjFaEZ4/talLE=;
        b=hW2xTA0MNHHqMXz6Q3KW22fRWFBD+3qq/bFYYwUdB/NhkbxGu4ziFkS2dA+QP3ULa9
         m06o9WaDbjd+Xybru+GueuUclNIgjrBEWeLifgO0+Dwr8xTOnKWVB69oDd5ksZUJ0Ssn
         yK2V5AGIhnuwJnWWE991jCdxNixWzmCm9TPtyrrN7lsI8xuCIeabo8IS17Zd2Al7bIk1
         QBVl+VAc2NuCifQ9gNq4eJ5KTPOSToySOjRaE6J/5jNDDH+EMM2/3wnfNfUUn5sOYuKo
         o/lG1vi3mdV44E+9iehju2GWp3E5xJm9Q0Puu1DiAiPWJ7le9tfG5/5YFnlRMirESGQ1
         X3dA==
X-Forwarded-Encrypted: i=1; AJvYcCVLUOSxaJhDDPBqzwgvU8zjqcwG0/ndr/r4aasWuaz1AZXa1wGzLLTzWv5djyErVCiT41zMHlLo1eYVb9W3AK1Iha7v0+wff2+zKgV0
X-Gm-Message-State: AOJu0YxX9TOEk9JlCFrpyISbfzz8W9BblqBxQPHUJ/JN3ZUNyTiA8JiX
	O26rubeTFcZRCCAJ2rfEICxjCwgJDDgmDOLrqUQFIJRrxznDlIWFLifjp4ouxg==
X-Google-Smtp-Source: AGHT+IHMs/wh4/uKU10a6TJOUIK0C/7FJ89YkEUzt2kLv6JiOenStOMG3JLzCl8G4mvnsX/BoqU3yg==
X-Received: by 2002:a25:6608:0:b0:dfd:f539:1552 with SMTP id 3f1490d57ef6-e02be10241dmr4964858276.13.1718855985869;
        Wed, 19 Jun 2024 20:59:45 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-dff44dd4b45sm2067078276.53.2024.06.19.20.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 20:59:44 -0700 (PDT)
Date: Wed, 19 Jun 2024 20:59:30 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
cc: Hugh Dickins <hughd@google.com>, 
    Baolin Wang <baolin.wang@linux.alibaba.com>, willy@infradead.org, 
    david@redhat.com, wangkefeng.wang@huawei.com, chrisl@kernel.org, 
    ying.huang@intel.com, 21cnbao@gmail.com, ryan.roberts@arm.com, 
    shy828301@gmail.com, ziy@nvidia.com, ioworker0@gmail.com, 
    da.gomez@samsung.com, p.raghav@samsung.com, linux-mm@kvack.org, 
    linux-kernel@vger.kernel.org, Andrew Bresticker <abrestic@rivosinc.com>
Subject: Re: [PATCH v2 0/9] support large folio swap-out and swap-in for
 shmem
In-Reply-To: <20240619183357.2ee5a818f8de1d4773be2ff6@linux-foundation.org>
Message-ID: <5f8a6e2e-8a51-dcad-a8a1-37e44349b716@google.com>
References: <cover.1718690645.git.baolin.wang@linux.alibaba.com> <20240618130538.ffab3ce1b4e66e3ba095d8cf@linux-foundation.org> <475f0f2c-afc7-4225-809f-93c93f45c830@linux.alibaba.com> <2683b71d-aebd-5527-348c-18c0e021b653@google.com>
 <20240619183357.2ee5a818f8de1d4773be2ff6@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 19 Jun 2024, Andrew Morton wrote:
> On Wed, 19 Jun 2024 01:16:42 -0700 (PDT) Hugh Dickins <hughd@google.com> wrote:
> > On Wed, 19 Jun 2024, Baolin Wang wrote:
> > > On 2024/6/19 04:05, Andrew Morton wrote:
> > > > On Tue, 18 Jun 2024 14:54:12 +0800 Baolin Wang
> > > > <baolin.wang@linux.alibaba.com> wrote:
> > > > 
> > > >> Shmem will support large folio allocation [1] [2] to get a better
> > > >> performance,
> > > >> however, the memory reclaim still splits the precious large folios when
> > > >> trying
> > > >> to swap-out shmem, which may lead to the memory fragmentation issue and can
> > > >> not
> > > >> take advantage of the large folio for shmeme.
> > > >>
> > > >> Moreover, the swap code already supports for swapping out large folio
> > > >> without
> > > >> split, and large folio swap-in[3] series is queued into mm-unstable branch.
> > > >> Hence this patch set also supports the large folio swap-out and swap-in for
> > > >> shmem.
> > > > 
> > > > I'll add this to mm-unstable for some exposure, but I wonder how much
> > > > testing it will have recieved by the time the next merge window opens?
> > > 
> > > Thanks Andrew. I am fine with this series going to 6.12 if you are concerned
> > > about insufficient testing (and let's also wait for Hugh's comments). Since we
> > > (Daniel and I) have some follow-up patches that will rely on this swap series,
> > > hope this series can be tested as extensively as possible to ensure its
> > > stability in the mm branch.
> > 
> > Thanks for giving it the exposure, Andrew, but please drop it from
> > mm-unstable until the next cycle.
> 
> Thanks, dropped.

Thanks. I'll add a little more info in other mail, against the further
2024-06-18 problems I reported, but tl;dr is they are still a mystery:
I cannot yet say "drop this" or "drop that" or "here's a fix".

> 
> > p.s. I think Andrew Bresticker's do_set_pmd() fix has soaked
> > long enough, and deserves promotion to hotfix and Linus soon.
> 
> Oh, OK, done.
> 
> And it's cc:stable.  I didn't get any sens of urgency for this one -
> what is your thinking here?

I thought you were right to add the cc:stable. The current v6.8..v6.10
state does not result in any crashes or warnings, but it totally (well,
511 times out of 512, in some workloads anyway) defeats the purpose of
shmem+file huge pages - the kernel is going to all the trouble of trying
to allocate those huge pages, but then refuses to map them by PMD unless
the fault happens to occur within the first 4096 bytes (talking x86_64).

I imagine that this causes a significant performance degradation in
some workloads which ask for and are used to getting huge pages there;
and they might also exceed their memory quotas, since a page table has
to be allocated where a PMD-mapping needs none (anon THPs reserve a page
table anyway, to rely on later if splitting, but shmem+file THPs do not).
And it's surprising that no tests were reported as failing.

I did forget that khugepaged should come along later and fix this up
(that used not to be done, but I believe we got it working around v6.6).
The tests where I noticed the low ShmemPmdMapped were too quick for
khugepaged to fix them: but if you'd prefer to avoid cc:stable, we
could say that khugepaged should in due course usually fix the
long-running cases, which are the ones most in need of fixing.

Hugh

