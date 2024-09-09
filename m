Return-Path: <linux-kernel+bounces-321019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0F9971361
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 11:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9A761F24348
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 09:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329371B2ED9;
	Mon,  9 Sep 2024 09:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WOmcoZwS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218E31B253B
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 09:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725873859; cv=none; b=DHN+KBACcwEseIFtqheV0wXqy3Sn1ZHrSYJ//Gi8+FRXSfgqSg0tYyAExSROxgknJdd5JzsUT7jarroUUKnqRu8FjD0zQFu+0DgVcUo7NMToQL5maPlFuXFYtbmGTGHTeJLjFMGavyoZiy3/OBYJqSVbBTkx6UxyJgevy2/it+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725873859; c=relaxed/simple;
	bh=y/zEhbGoGCGtET0L7VBESgrFbiwtn+5vGlpKoy71hz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i7D72kScs44Mtv+alPFl1XS/1fhpevKj69aykjzmkki6rch3pKjMkj2HKaix9ds84KYQ1onKiT9TCODQyA50kn6v3hqD/ml++6YIuLgtbai+k1fkJtoQWpoF6Ofvpd3tb4QZ9E8vHl5OtRX7qw83XOu00NJaGGshIVOMLJ1X0rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WOmcoZwS; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725873858; x=1757409858;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=y/zEhbGoGCGtET0L7VBESgrFbiwtn+5vGlpKoy71hz0=;
  b=WOmcoZwSgbkLjM6penKC0dxMIMawcTyjteibi9LKDv+oeZkgfqNgxS5R
   h7QuIO269sQddkO6gm9Cs0LBGOTdI+N77FsiwYUgcWEd0GEi8HLo2wFug
   GVaq/esFoShb1MFGpGz6IXJjmhNhP+VO8ItsJz0n+XCmyeAYdRiul4ctV
   cl7p8GUifizSwLSpRlsQsYGgw0AhWMp8LASJBsZLhqZhVBfc0GJOgBqeu
   hATuV4j+VXwNE98qZi1uRyWA4LYDV+DjN/dCiFbtwQXLINruJHgFTqtJS
   iuRWnIUMYq73dyVjC7zmxx5q8fOKyIeoIeDtvBczW8zl8uaIROQ7Z3Eic
   w==;
X-CSE-ConnectionGUID: V8fgJao2SXOa5tWqowP7TA==
X-CSE-MsgGUID: nnKrzH2+Q+Sq50D7/HQx3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11189"; a="49970385"
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="49970385"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 02:24:17 -0700
X-CSE-ConnectionGUID: cobGghzgTHyXYq1Kq7IegQ==
X-CSE-MsgGUID: m4eOU/nJRKi3E72JIibx/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,213,1719903600"; 
   d="scan'208";a="66598830"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa009.fm.intel.com with ESMTP; 09 Sep 2024 02:24:13 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 36F9D243D; Mon, 09 Sep 2024 12:24:12 +0300 (EEST)
Date: Mon, 9 Sep 2024 12:24:12 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Alexey Gladkov <legion@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Yuan Yao <yuan.yao@intel.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Yuntao Wang <ytcoode@gmail.com>, Kai Huang <kai.huang@intel.com>, 
	Baoquan He <bhe@redhat.com>, Oleg Nesterov <oleg@redhat.com>, cho@microsoft.com, 
	decui@microsoft.com, John.Starks@microsoft.com
Subject: Re: [PATCH v6 6/6] x86/tdx: Implement MOVS for MMIO
Message-ID: <7gg7baisfiiqlg3x7mohkhvxvvvgxdjkn4pwvkzxmljwgimf4z@wukl6lab7dmh>
References: <cover.1724837158.git.legion@kernel.org>
 <cover.1725622408.git.legion@kernel.org>
 <017887cf42991777c96949ecf81469965113b412.1725622408.git.legion@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <017887cf42991777c96949ecf81469965113b412.1725622408.git.legion@kernel.org>

On Fri, Sep 06, 2024 at 01:50:04PM +0200, Alexey Gladkov wrote:
> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
> index a75a07f4931f..33875a217ed8 100644
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -486,6 +486,9 @@ struct thread_struct {
>  	unsigned long		iopl_emul;
>  
>  	unsigned int		iopl_warn:1;
> +#ifdef CONFIG_INTEL_TDX_GUEST
> +	unsigned int		in_mmio_emul:1;
> +#endif

This ifdeffery doesn't help anybody. Just drop it.

Otherwise looks good to me:

Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

