Return-Path: <linux-kernel+bounces-521947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2EAA3C429
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 16:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE56E1886B73
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 15:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081561FCFCB;
	Wed, 19 Feb 2025 15:53:03 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB191F4623;
	Wed, 19 Feb 2025 15:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739980382; cv=none; b=DjdaduU+BaNx6hMaX3vb5YvVdJxmBMvovHAbYJpcTcBxxNvNqBui4yJZlK+gn80yWtuz6rxcC+XQ90wRaG3gECMRoyiCD58LEbHk3AK53q/A67pMAyUmJC5dV5qGUgih+FA67aR+52zPFlNSGWjmy7wFjGeqscDwN57fNN9GAFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739980382; c=relaxed/simple;
	bh=Kw+qjdavxQF8zK0wvzryH95Kq1FFFa5LwfrPf0CZ6ZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UjgVFe5WcuIABTWxUvJDJJ2/svH++K5JmkNmfByHXX0XHAMAMaz3Ki0YwGDKfMTqmUjL7m8aOzohzT/eNmf2es1aKPcCIyz29gzUmC8L5cPsdNhW4+ne/CGsG4iQX36VH58nq9DzPxeg+FJQoPhQ1E0540Qmwt1bsWvaYBS59ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D27E9C4CEDD;
	Wed, 19 Feb 2025 15:52:56 +0000 (UTC)
Date: Wed, 19 Feb 2025 15:52:54 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Yang Shi <yang@os.amperecomputing.com>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-mm <linux-mm@kvack.org>,
	Anders Roxell <anders.roxell@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Herbert Xu <herbert@gondor.apana.org.au>, willy@infradead.org,
	Pankaj Raghav <p.raghav@samsung.com>,
	David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 6.6 000/389] 6.6.76-rc2 review
Message-ID: <Z7X-VrwJrLSBN-XZ@arm.com>
References: <20250206155234.095034647@linuxfoundation.org>
 <CA+G9fYvKzV=jo9AmKH2tJeLr0W8xyjxuVO-P+ZEBdou6C=mKUw@mail.gmail.com>
 <CA+G9fYtqBxt+JwSLCcVBchh94GVRhbo9rTP26ceJ=sf4MDo61Q@mail.gmail.com>
 <Z7Xj-zIe-Sa1syG7@arm.com>
 <b44dc8f6-7abf-4168-b96d-54f1562008e6@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b44dc8f6-7abf-4168-b96d-54f1562008e6@stanley.mountain>

Hi Dan,

On Wed, Feb 19, 2025 at 06:43:52PM +0300, Dan Carpenter wrote:
> What's happening is that we backport the latest kselftests and run
> them on the old kernels.  This is a supported thing so kselftests
> are supposed to be able to handle that.

Yes, I do this occasionally as well (a single rootfs with the kselftests
that I use with different kernels).

> So we need to modify the testing/selftests/arm64/mte/check_hugetlb_options.c
> to check if the feature is present and disable the test for older
> kernels.

I'm not worried about the test failing yet, we can solve it later, but
rather the WARN_ON_ONCE() in the arm64 copy_highpage(). We should not
trigger this condition since hugetlb vmas don't have VM_MTE_ALLOWED set,
so PROT_MTE mappings should be refused and the test shouldn't get any
mapping.

I tried vanilla 6.6 and it trips over as well, so something wrong in how
we handle MTE hugetlb pages. I'm looking into it.

-- 
Catalin

