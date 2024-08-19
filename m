Return-Path: <linux-kernel+bounces-291905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E30F9568BC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 12:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01E071F22C5F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 10:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E43161916;
	Mon, 19 Aug 2024 10:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G1UopoB+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926FB13E898
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 10:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724064500; cv=none; b=GKTBjcyroZ1vV4gkGrk6BpVf/0G26OyVa3Q2oBG7nPjt08ojkfwkaULqSg8wP6kXU1+xsTDidGhlYiY5vMed4rzT0yNqRmB3hZ3J2THo/2a7aUR7U58mvyFLdgZ5/4LFLlzIJeUX94c2rlK7RBIbGJGDygl7E9YYmtuygiKPkcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724064500; c=relaxed/simple;
	bh=2eb3wu7JFge0oZQJsuIwYIapeV2qPhMIIp7PdAHuX/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DxPv7GhXv7Lhl8gxQX3tQ1yVmmYiW/70P8mXR3hogs86sOkJfkV8bB6hrzIJqo1mvx4U8YqyVwZckXQtUzsLRzIHQPC53oumr72GlKtNzZPgxGKGn1yU6DYJzsie2EFFiWvbmJQ05Ql4AHkGL7rFpEc9/Kzv4uJB9MYHFHHHSb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G1UopoB+; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724064498; x=1755600498;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2eb3wu7JFge0oZQJsuIwYIapeV2qPhMIIp7PdAHuX/k=;
  b=G1UopoB+Lcq/9NZNFM/Gkxc2oHOlR709Sd5SyPUHEZzf1ILNt5SaOLtk
   k7OtqGYbBado+R/DSpbZ8D4xi+Ka+HYzkouYUvHqHNqIRtkFbWQyxccI6
   Q+U5g/JvbQcNhMFCwWund5807h2sTMnlNE8lt9CsgoZd2Ota9lRxpy30p
   X+ro9yxch8O7hg6wzSdv1ezQ45LtpuD8UzJ49aYYDf9DZGWr1Ge3n0mlF
   TJxINRDdaLI4RErpvddbIawxAWXtf5uiJ+3cN0zgrGzfXv5mkDJ9mGDIp
   +rsmSfM0n4qgQvXMSjkTkwdnPCAAqNt0cvbCnatp/ij0OSuAFBHcBG00b
   w==;
X-CSE-ConnectionGUID: GPfZrqMMRpar9hUwP9mxdA==
X-CSE-MsgGUID: Nscqux6cRciYznuY9q8jNA==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="33717125"
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="33717125"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 03:48:17 -0700
X-CSE-ConnectionGUID: cbFVa9OrSfGAB7Cf5TH3aA==
X-CSE-MsgGUID: /KV1V9rmQ0C47l48HXdwjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="60633451"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa006.jf.intel.com with ESMTP; 19 Aug 2024 03:48:13 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id A3F5B2D8; Mon, 19 Aug 2024 13:48:11 +0300 (EEST)
Date: Mon, 19 Aug 2024 13:48:11 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Alexey Gladkov <legion@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Yuan Yao <yuan.yao@intel.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Yuntao Wang <ytcoode@gmail.com>, Kai Huang <kai.huang@intel.com>, 
	Baoquan He <bhe@redhat.com>, Oleg Nesterov <oleg@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Kevin Loughlin <kevinloughlin@google.com>, 
	Nikunj A Dadhania <nikunj@amd.com>, cho@microsoft.com, decui@microsoft.com, 
	John.Starks@microsoft.com
Subject: Re: [PATCH v3 04/10] x86/insn: Read and decode insn without crossing
 the page boundary
Message-ID: <3xcmaxmpoemmotdqhtr5fu52wyssixyvnmirqbbnvhwpcuss5z@sayg725h5wcz>
References: <cover.1722862355.git.legion@kernel.org>
 <cover.1723807851.git.legion@kernel.org>
 <9704da6a35d62932d464d33b39953fc5b2fd74ea.1723807851.git.legion@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9704da6a35d62932d464d33b39953fc5b2fd74ea.1723807851.git.legion@kernel.org>

On Fri, Aug 16, 2024 at 03:43:54PM +0200, Alexey Gladkov wrote:
> From: "Alexey Gladkov (Intel)" <legion@kernel.org>
> 
> In case the instruction is close to the page boundary, reading
> MAX_INSN_SIZE may cross the page boundary. The second page might be
> from a different VMA and reading can have side effects.
> 
> The problem is that the actual size of the instruction is not known.
> 
> The solution might be to try read the data to the end of the page and
> try parse it in the hope that the instruction is smaller than the
> maximum buffer size.
> 
> Co-developed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: Alexey Gladkov (Intel) <legion@kernel.org>

I think this and 3 next patches do not belong to this patchset. They
address separate issue that is orthogonal to the patchset goal.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

