Return-Path: <linux-kernel+bounces-292046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1CE956A79
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 14:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A00B51C220C4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 12:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D62216B735;
	Mon, 19 Aug 2024 12:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L7W7kxzw"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14DD1684A0
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 12:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724069307; cv=none; b=PSxeuJ4DHylP4hwc8I39hnEJGckIURg0uV+m78qEn2t1aOzxlVDz7sUdPHJR5uvpmi31bFJoKm9ionRZe3LaDWYyVnPw9HYHvdEDf2DZ4C5RerZhKg77Rgw7QhhQyqckmbt27QonhAJn5IqhUuPmfOp539J1RQ3/JWw8FiEH1io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724069307; c=relaxed/simple;
	bh=RWyAIFk9G8mmDGLmrZO/cnlLMTqmW12k7ttu2XvJDu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FgyGYcWMMTSW8y8vH9HUEwNn7EweqlQxJqBw44vz4UY90wnQ+N4rSyFw0PXGZvepKB8vecPSWcR/S1JJlILSh+9BbF84dKQ88l6fUIFgL9awVHBPyABTrwPyRl753txUxa6wVBt28/a+9+5QfxKTTOV/lJMbAJwK09hKiFp1/xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L7W7kxzw; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724069306; x=1755605306;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RWyAIFk9G8mmDGLmrZO/cnlLMTqmW12k7ttu2XvJDu8=;
  b=L7W7kxzw83ZePn6kzZ41EbNH9/Ha0jNoGqgBKCoopZR4FBBtpbqqBv8r
   jb7oEojBlkhhpaBzSL4KecPSrQwr3hvTIM2pADPGbMepmE4F/0Kb331y1
   KHp5PBsjTcWG6/uGJE+ySNAVkouJHbm0kg+5Tid47nVGY/IihLSy0qvN6
   yM/1iwVifL0aXjjNyLUJtBmgextq+iCT3juWeVVWJyHtLVPmnPUpuEHfa
   ey1f5J8z93HcfpQkOUhviuAqYAIjV9h/czQ+P6v5euQUlnmdnHMqTXzh9
   VRIa5AN0APzeoL/zDVCfodJeoqHwwnxAtcdDmZfzXAssVVDL46m4HBFDK
   g==;
X-CSE-ConnectionGUID: NZ02Ku63RlqjHoh3X7qaHQ==
X-CSE-MsgGUID: hYqKeO3aTGageSJvzS0b4Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="32931389"
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="32931389"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 05:08:25 -0700
X-CSE-ConnectionGUID: kHmAH+33TNOjgVyrOu/O0A==
X-CSE-MsgGUID: Xe7CVMajRsiXlJ2H/m3B0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,159,1719903600"; 
   d="scan'208";a="64514648"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa003.fm.intel.com with ESMTP; 19 Aug 2024 05:08:21 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id B971F2D8; Mon, 19 Aug 2024 15:08:19 +0300 (EEST)
Date: Mon, 19 Aug 2024 15:08:19 +0300
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
Message-ID: <dekciupp32nqq6lpqecpwpoictme3b3qw5ha3rxaxhdbl6ba34@622ualchvsvt>
References: <cover.1722862355.git.legion@kernel.org>
 <cover.1723807851.git.legion@kernel.org>
 <9704da6a35d62932d464d33b39953fc5b2fd74ea.1723807851.git.legion@kernel.org>
 <3xcmaxmpoemmotdqhtr5fu52wyssixyvnmirqbbnvhwpcuss5z@sayg725h5wcz>
 <ZsMy1YaHI4gaN703@example.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsMy1YaHI4gaN703@example.org>

On Mon, Aug 19, 2024 at 01:56:05PM +0200, Alexey Gladkov wrote:
> On Mon, Aug 19, 2024 at 01:48:11PM +0300, Kirill A. Shutemov wrote:
> > On Fri, Aug 16, 2024 at 03:43:54PM +0200, Alexey Gladkov wrote:
> > > From: "Alexey Gladkov (Intel)" <legion@kernel.org>
> > > 
> > > In case the instruction is close to the page boundary, reading
> > > MAX_INSN_SIZE may cross the page boundary. The second page might be
> > > from a different VMA and reading can have side effects.
> > > 
> > > The problem is that the actual size of the instruction is not known.
> > > 
> > > The solution might be to try read the data to the end of the page and
> > > try parse it in the hope that the instruction is smaller than the
> > > maximum buffer size.
> > > 
> > > Co-developed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > > Signed-off-by: Alexey Gladkov (Intel) <legion@kernel.org>
> > 
> > I think this and 3 next patches do not belong to this patchset. They
> > address separate issue that is orthogonal to the patchset goal.
> 
> Should I drop them from this patchset and send them after this patchset as
> a separate change ?

Yeah. I think so.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

