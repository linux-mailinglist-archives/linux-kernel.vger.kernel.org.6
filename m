Return-Path: <linux-kernel+bounces-570364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CA2A6AF66
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 21:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61736483315
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 20:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7416E229B28;
	Thu, 20 Mar 2025 20:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="d76MStkt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AAD1C68B6;
	Thu, 20 Mar 2025 20:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742503977; cv=none; b=CuRxTKrn+TqdH6+o96QcFBSFMAWvrk0fQkA6GIfXy3O64DnQQmLWQ7pMJro3p4MrUnEzESfD7I3McepGcfQ6ZxxFZcANK7pklggm7rbO72owDtuEBXGgS+yFw+c7xe7TuowXHzkKdU7xiCC05F0opnZFJ6BOYSJ8AkYmAixb4hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742503977; c=relaxed/simple;
	bh=2gH4NmZgcqFsi7kx1+PzfuIhh7VfYK21h7LJTsqWt6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aJljjr44Ro/t6OXZiuCY9mWrG7y28wttL4akbor0Qfr3Gxz70WeBXfJQvd3AClpeLhbl662Z+WmOEzx0CY5Ep8pxMnRwd29yl5bpHLVDx1VBXyJZKUlVN6IsbaKpItABhRUK+7ufPbrv4Mbtj/URZGiKnezMKvndwAbgj03uf3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=d76MStkt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD7B0C4CEDD;
	Thu, 20 Mar 2025 20:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742503977;
	bh=2gH4NmZgcqFsi7kx1+PzfuIhh7VfYK21h7LJTsqWt6w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d76MStkt4ak/8cB/z1RrKactlJRuQMgk4nKM0F4GtdKKHk1fylBdZN2ux4INxJ5tt
	 76KgifpoMwRnDvrvg3u1BR8CldkNs2k8N5OGx236T8ZjU5v9Y99uMYvaedtmPbYjx3
	 mU5RylxWkwHpWA3BC3JvFYjOeIrXRQl7VQRltgFY=
Date: Thu, 20 Mar 2025 13:51:37 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: changyuanl@google.com, graf@amazon.com, rppt@kernel.org,
	rientjes@google.com, corbet@lwn.net, rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com,
	ojeda@kernel.org, aliceryhl@google.com, masahiroy@kernel.org,
	akpm@linux-foundation.org, tj@kernel.org, yoann.congal@smile.fr,
	mmaurer@google.com, roman.gushchin@linux.dev, chenridong@huawei.com,
	axboe@kernel.dk, mark.rutland@arm.com, jannh@google.com,
	vincent.guittot@linaro.org, hannes@cmpxchg.org,
	dan.j.williams@intel.com, david@redhat.com,
	joel.granados@kernel.org, rostedt@goodmis.org,
	anna.schumaker@oracle.com, song@kernel.org, zhangguopeng@kylinos.cn,
	linux@weissschuh.net, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, rafael@kernel.org, dakr@kernel.org,
	bartosz.golaszewski@linaro.org, cw00.choi@samsung.com,
	myungjoo.ham@samsung.com, yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com, ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de,
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com,
	stuart.w.hayes@gmail.com, jgowans@amazon.com, jgg@nvidia.com
Subject: Re: [RFC v1 2/3] luo: dev_liveupdate: Add device live update
 infrastructure
Message-ID: <2025032054-voltage-compactly-7774@gregkh>
References: <20250320024011.2995837-1-pasha.tatashin@soleen.com>
 <20250320024011.2995837-3-pasha.tatashin@soleen.com>
 <2025032058-reassure-veneering-0fdb@gregkh>
 <CA+CK2bA8vLjODhM1puia-SOnk9kiFhd7WXHVemh+YBuN4kSgwQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bA8vLjODhM1puia-SOnk9kiFhd7WXHVemh+YBuN4kSgwQ@mail.gmail.com>

On Thu, Mar 20, 2025 at 02:03:10PM -0400, Pasha Tatashin wrote:
> I absolutely agree that demonstrating a real use case is important.
> However, this is a complicated project that involves changes in many
> parts of the kernel, and we can't deliver everything in one large
> patchset; it has to be divided and addressed incrementally.

Ok, but then don't expect us to be able to actually review it in any
sane way, sorry.

Think about it from our side, what would you want to see if you had to
review this type of thing?  Remember, some of us get hundreds of things
to review a week, we don't have context for each and every new feature,
and your project does not have the "trust" in that we would even
consider taking anything without any real user both in the kernel and in
public userspace code.

Breaking up changes in a way that is acceptable upstream is a tough
task, usually harder than the original engineering effort to create the
feature in the first place.  But in the end, the result is a better
solution as it will evolve and change along the way based on reviews and
requirements from the different subsystems.

good luck!

greg k-h

