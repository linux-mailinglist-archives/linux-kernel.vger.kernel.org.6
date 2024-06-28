Return-Path: <linux-kernel+bounces-233366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3947391B61B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 07:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA20C1F2251D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 05:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF423C08A;
	Fri, 28 Jun 2024 05:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dvvywQi4"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D262D05E
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 05:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719552471; cv=none; b=QdzNAlbQlXM2xZ46kLoVriCT7OIlXv4Qo/fQyze1k7BmIxM5uTC+dQH+Au+pxP5W65YITBWCsDdOqc7KSZcHMDkggstHkwY9shcr9nyDJdkUgrTCNg2SVNyfjnJdjTQxeilOObbMDhDzXunpa7rVjoFeAXgh/2g/0xTFEtom9Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719552471; c=relaxed/simple;
	bh=EbWFE2VnTSRfIqIsYblunUdrhQzg/C0mSK2Ujk57jGg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hiG1jgA+/mf+GBHLrlZ7h2PwlVVmBmY3gJh7N2uGeJRLAkMyx6ELYinZDq+KW/JPS9VBhL1s505myzfPQYNFVhp6Ec0DE1R0CuGEbZ9RWXyoLcyv6aIGQvE3ZIo1xzFCf8rTryF1Q55vV3Qs1xyNYRJIcgPwte5pg+6Ebbe7Qlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dvvywQi4; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719552469; x=1751088469;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=EbWFE2VnTSRfIqIsYblunUdrhQzg/C0mSK2Ujk57jGg=;
  b=dvvywQi4YYKYnoumopw65Ae9pER4nlnlMGcrcSFRN97xvfJI6qZ6TY53
   bJ9wWOqIfidbZ2643qw+Fun6xhcmeNHrtGwz4tN1MtneHeZn5qfcDBKjZ
   5sL1v+LXYhjXJTdpdUC4kfrrHpa43s/Ocbx4TBuQ6khf+pqXXkkJPkcFN
   oGRKU32jrbU3MLwc4EA/4o5kWHXCODdhTh9vI1IN+D3OzFvFbAFoQ1H/Y
   KHACrOoOl93UC417Qsr0NYMbPwU6jzSg847ISUaE/9rjLLNkMcevqa32x
   X4VGYQl2bl+FxBi5CGxISfpPY4Zv9oyMviMAEAfSSc13j2w8jbbYIvVmH
   w==;
X-CSE-ConnectionGUID: 6KizJdhdS1WEAUiKJLmCOA==
X-CSE-MsgGUID: EjxzyoO9Ss634TDZe41Lyg==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="20593221"
X-IronPort-AV: E=Sophos;i="6.09,168,1716274800"; 
   d="scan'208";a="20593221"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 22:27:48 -0700
X-CSE-ConnectionGUID: qrvTILA6TI6zx5MgNg1xmw==
X-CSE-MsgGUID: W50Q72weR1SfU3HNkX4jxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,168,1716274800"; 
   d="scan'208";a="49085086"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.54.38.190])
  by fmviesa005.fm.intel.com with ESMTP; 27 Jun 2024 22:27:48 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
	id E9A88302A3B; Thu, 27 Jun 2024 22:27:47 -0700 (PDT)
From: Andi Kleen <ak@linux.intel.com>
To: Ruidong Tian <tianruidong@linux.alibaba.com>
Cc: linux-kernel@vger.kernel.org,  linux-mm@kvack.org,
  akpm@linux-foundation.org,  nao.horiguchi@gmail.com,
  linmiaohe@huawei.com,  tianruidong@alibaba.linux.com,
  xueshuai@linux.alibaba.com
Subject: Re: [PATCH] mm/hwpoison: avoid speculation access after soft/hard
 offline
In-Reply-To: <20240628033509.27612-1-tianruidong@linux.alibaba.com> (Ruidong
	Tian's message of "Fri, 28 Jun 2024 11:35:09 +0800")
References: <20240628033509.27612-1-tianruidong@linux.alibaba.com>
Date: Thu, 27 Jun 2024 22:27:47 -0700
Message-ID: <871q4hzlf0.fsf@linux.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ruidong Tian <tianruidong@linux.alibaba.com> writes:

> Page that offlined can report CE/UE event due to speculation access.
> Delete kernel 1:1 linner mapping after soft/hard offline to avoid it.

But that will split the large pages for the direct mapping, costing you
every time there is TLB pressure. You can probably do the math, with
enough uptime and a reasonable error rate aand this patch there might be
not even be 2MB pages left at some point. Cheaper to just ignore them,
since they shouldn't cause any other problems.

-Andi

