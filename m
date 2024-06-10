Return-Path: <linux-kernel+bounces-208632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8DD90275D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 19:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8820A289477
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 17:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE93145354;
	Mon, 10 Jun 2024 17:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T+g9Q+Cn"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1741EA6F
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 17:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718038803; cv=none; b=NNE2Vaj6v7SHbR2YsV8jGl0q3RsEMYYKhBo16QOYRA9bSwcF/IJlAgltHOzQIwHeD24k2qscXY7GVNC9xd6dFOmnnx7H+gzF6O+Jw4wFHbvL0zsXDbEMv2Wn8czW8wrQIcx/vn0+LuB77vVwni4pcK6On/ku0c3+rEgwgr4L7zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718038803; c=relaxed/simple;
	bh=1m7ebKHlpbsUaMBQNISNWxY4VRsCLL4ICYzNJF0nLDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ltov9BAEb895joQHJiInMEiTCuuCOh2W1YoL+p0p8ANBBpNB9PYDa9Lg1iYYwCR5YJ15I471fcceDwDZZRSJIIEDh/JArHJhDs6Fv3EdntYTFU0Wlt4eCUvY5oIh5+1f5/kr5TBW5YikXhQoRa28wBqav+48vsdLNtc3DoI65aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=T+g9Q+Cn; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=c9KYJn0jhsla+0w2VJDwqP6iO+OOPgYPwwEWm2grdLM=; b=T+g9Q+CnjlZOL26qygCjVfsS3i
	0TN7GoOjlQee0qQ5/AxHIanHGBOo4pUpN3oYjMOaGIl3HQGgJlyZX23PlP5Kv1sJiVwuRV+Cx6ZhM
	hoypDpRGHGMDXXqcS1/ruDm5qEr+rmPVnncwlNH59HzbGbxzMgdDmx6OFpOQDYbWFNsCOcglZTcpi
	MS6zEGQKBrSYXCz6JbfAgIKKYvgIHbHDlFASq8vKtfrJdNCRqz4OxwWduWC0fSubK5wAl6PbFvVpU
	O7SCSGADtlhEVQM3Y9PDehpNeUTPaGiQKzCA6Zqnr70DAJT6/CYRRhjwm2axSaNyAteRc8JL56LIl
	nuJ55v+Q==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGiMr-00000009W06-03DT;
	Mon, 10 Jun 2024 16:59:37 +0000
Date: Mon, 10 Jun 2024 17:59:36 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, hughd@google.com, david@redhat.com,
	wangkefeng.wang@huawei.com, chrisl@kernel.org, ying.huang@intel.com,
	21cnbao@gmail.com, ryan.roberts@arm.com, shy828301@gmail.com,
	ziy@nvidia.com, ioworker0@gmail.com, da.gomez@samsung.com,
	p.raghav@samsung.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] mm: add new 'orders' parameter for
 find_get_entries() and find_lock_entries()
Message-ID: <Zmcw-DymPwFcOqOY@casper.infradead.org>
References: <cover.1717673614.git.baolin.wang@linux.alibaba.com>
 <5304c4c54868336985b396d2c46132c2e0cdf803.1717673614.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5304c4c54868336985b396d2c46132c2e0cdf803.1717673614.git.baolin.wang@linux.alibaba.com>

On Thu, Jun 06, 2024 at 07:58:55PM +0800, Baolin Wang wrote:
> In the following patches, shmem will support the swap out of large folios,
> which means the shmem mappings may contain large order swap entries, so an
> 'orders' array is added for find_get_entries() and find_lock_entries() to
> obtain the order size of shmem swap entries, which will help in the release
> of shmem large folio swap entries.

I am not a fan.  I was hoping that 'order' would be encoded in the swap
entry, not passed as a separate parameter.

As I understand it, we currently have a free bit, or
swp_to_radix_entry() would not work.  We can use that as detailed
here to encode the order in a single bit.

https://kernelnewbies.org/MatthewWilcox/NaturallyAlignedOrder


