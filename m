Return-Path: <linux-kernel+bounces-291858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73AA395681A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 12:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31D0D283DAF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 10:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19F215E5CC;
	Mon, 19 Aug 2024 10:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZOkaAYor"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC04A2900
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 10:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724062752; cv=none; b=BoXdsQOWiuvrPFyeVZXYhMmhDQfXdldJuA1CKf/gYyTPfr7LbsmBacWsDG6ku5UkrrqAZjLOGUZ5NX8wXlLpalOSgYhER4EOv++Zt3811LFvtx8BiZEUYZ+wNvoPMt1oci7yrMM4jhPQfuqQqTEc1DqwYbhAgYD02iHGN4jquGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724062752; c=relaxed/simple;
	bh=HiGS7tD3nm/qZRC2hpvpf7nPfwvtfE8Ozd1cEfXVz8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CB916XXWyTUvpvilXSep1GulbLzVXqiWTQXSvjZTO9lWHfM+7JeS9MMqnLjoeSjOzgve1WZiaIvnUHsdhsPPJXZ7OyBdHXZBwpBcjLY46+0S3INDDPkldJ8CAr/F7OT9q1f97YGs582xVK9vIBdekelSz1di3SFIvsA9k4t7Qrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZOkaAYor; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724062751; x=1755598751;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HiGS7tD3nm/qZRC2hpvpf7nPfwvtfE8Ozd1cEfXVz8o=;
  b=ZOkaAYor0AC1vXlSrZlZMxPOJPcULVV3MMsQlZNWW7icR5k8xlQ/KXWD
   24sxE455fYqPIdCM4tdvwpAhKU16G47oklh87VS6ooKL0Bh/FZlPgycao
   gc1R1DaHJfVWCgQUcowT8oi6A23/FS6mx+YhEqiJc4t7P0W1oIjAT6oQF
   WRzGZJnng9AcOj6Nhc+VFtkA2RBNyoR0jVV1Ri/xu5kkrhbKO7+MlpkRo
   Unb6sOokgrwR4QQTJYnhn6MEKQ1bLqdmv3szCnd7Gv11fuQ5KbNE5mlj7
   comnyvUVXMylqutXc8KBUi7FER5vnZu1Jq/uBwgm8LYp00YzwiiguWxrQ
   g==;
X-CSE-ConnectionGUID: 0/UKpdg7R9WUesH5UuGeBA==
X-CSE-MsgGUID: JHwmk5zxT/S+rIGNyOp8bw==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="33714850"
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="33714850"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 03:19:10 -0700
X-CSE-ConnectionGUID: uWuMSAYwQhS3HdBWP8e8mg==
X-CSE-MsgGUID: iKqdGccASgqwzBQpwkO4Hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="60163726"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 19 Aug 2024 03:19:05 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 6798A2AA; Mon, 19 Aug 2024 13:19:04 +0300 (EEST)
Date: Mon, 19 Aug 2024 13:19:04 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Alexey Gladkov <legion@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Yuan Yao <yuan.yao@intel.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Yuntao Wang <ytcoode@gmail.com>, Kai Huang <kai.huang@intel.com>, 
	Baoquan He <bhe@redhat.com>, Oleg Nesterov <oleg@redhat.com>, cho@microsoft.com, 
	decui@microsoft.com, John.Starks@microsoft.com
Subject: Re: [PATCH v3 01/10] x86/tdx: Split MMIO read and write operations
Message-ID: <6yppfuuzhatzgugbme7us6xpgadr3un43s4dmfvpmteh4no7by@lucru5isrpfc>
References: <cover.1722862355.git.legion@kernel.org>
 <cover.1723807851.git.legion@kernel.org>
 <0b5f95e9c7639ddb6e4cbd99b3904e6538e91371.1723807851.git.legion@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b5f95e9c7639ddb6e4cbd99b3904e6538e91371.1723807851.git.legion@kernel.org>

On Fri, Aug 16, 2024 at 03:43:51PM +0200, Alexey Gladkov wrote:
> From: "Alexey Gladkov (Intel)" <legion@kernel.org>
> 
> To implement MMIO in userspace, additional memory checks need to be
> implemented. To avoid overly complicating the handle_mmio() function
> and to separate checks from actions, it would be better to split this
> function into two separate functions to handle read and write
> operations.
> 
> Signed-off-by: Alexey Gladkov (Intel) <legion@kernel.org>

Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

