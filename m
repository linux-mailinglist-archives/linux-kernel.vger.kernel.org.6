Return-Path: <linux-kernel+bounces-239508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9EBC926163
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 15:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 060571C21351
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 13:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3FEC178CCD;
	Wed,  3 Jul 2024 13:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CsgZJWNH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4853143C50
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 13:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720011938; cv=none; b=rpdxee4gMDxBibBgvQAYn5vyg1h0mKH72n3ltbF1E8ERSaMEoiVed3TO0BEypA6O/c1JtWzUh/L61xWONATUvfNnAGyBheJkUEOZlIWfmb11RPB7bIPlpYABIL9NpRD8vyvq47lbSksrCk4D0vWDxbTpjGCzQqSrujT8wcu0yiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720011938; c=relaxed/simple;
	bh=N3VfChY9Spyt/LaiY9me9EB1gxzRvnAWlCT4R8Zzspk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bAGMTSDkwkXhjvrZoRpEidFGAX91lIYPeOoXAKFdD3mq2+FvaqJkv3TrG/e4StcAzfaQMR52GujbO6BNfqPkz2VY2nt/upW52nLtBcPvy3PT5HVayDA36sI1ohjOozbKkz7Au78g1XVJnOmcqax6TrgvlXm5hQPSt8rPm7SnK4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CsgZJWNH; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720011937; x=1751547937;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=N3VfChY9Spyt/LaiY9me9EB1gxzRvnAWlCT4R8Zzspk=;
  b=CsgZJWNHFSVvZ1QzQn83u5+E3cCcSlbgB9E18Y9K/IDq8Aq0z7V1qTnU
   6GIcIsc9AkpqBJ6jRAvpwTpRJ5QSuguvWJ+2ACYrZ7CWYtwkH3d4exH+D
   HtIt1xYEhqH72xlzhDy61GK/PWzguZWkZzvQJE6NU0ssgwlp/fjtfM1xs
   CnU/uA/ei3CWGBNz5xeFmkK5SWCpZdzbJbbKisAOP9aRadpSECzk3gKQH
   rb4hDwSI+VmjeykX7lx9Mk4lAypnX+NyUeRhPoj15MVMOiCHM4F9KFkxm
   p3h9nZRgsR7Bj/Pj+YABIlIj+68TZbzUVp/95VKXg0L+jzBQqdXkwHPZU
   w==;
X-CSE-ConnectionGUID: BZLgXFeMSX2gX3rTNMdBbg==
X-CSE-MsgGUID: BrMGeie1QxattVBkrVzPBg==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="27855518"
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="27855518"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 06:05:36 -0700
X-CSE-ConnectionGUID: wx+mwJHXQhedVrtDNcDGMg==
X-CSE-MsgGUID: lMaTGRZ2SneQ5z4ZeQ2Qow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="69431301"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa002.fm.intel.com with ESMTP; 03 Jul 2024 06:05:34 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id DD2C6194; Wed, 03 Jul 2024 16:05:32 +0300 (EEST)
Date: Wed, 3 Jul 2024 16:05:32 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Nikolay Borisov <nik.borisov@suse.com>, g@black.fi.intel.com
Cc: Dave Hansen <dave.hansen@linux.intel.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.orgg
Subject: Re: [PATCHv5 3/4] x86/tdx: Dynamically disable SEPT violations from
 causing #VEs
Message-ID: <auyvnefisebmpfj3ugj76qagqmrd6xstxv36otmd5az2smdskk@dw74rg3tqw73>
References: <20240624114149.377492-1-kirill.shutemov@linux.intel.com>
 <20240624114149.377492-4-kirill.shutemov@linux.intel.com>
 <d405c84e-2b8c-4139-b4ea-d716fe53dfca@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d405c84e-2b8c-4139-b4ea-d716fe53dfca@suse.com>

On Wed, Jul 03, 2024 at 03:22:35PM +0300, Nikolay Borisov wrote:
> 
> 
> On 24.06.24 г. 14:41 ч., Kirill A. Shutemov wrote:
> 
> <snip>
> 
> 
> 
> > --- a/arch/x86/include/asm/shared/tdx.h
> > +++ b/arch/x86/include/asm/shared/tdx.h
> > @@ -19,9 +19,17 @@
> >   #define TDG_VM_RD			7
> >   #define TDG_VM_WR			8
> > -/* TDCS fields. To be used by TDG.VM.WR and TDG.VM.RD module calls */
> > +/* TDX TD-Scope Metadata. To be used by TDG.VM.WR and TDG.VM.RD */
> > +#define TDCS_CONFIG_FLAGS		0x1110000300000016
> > +#define TDCS_TD_CTLS			0x1110000300000017
> >   #define TDCS_NOTIFY_ENABLES		0x9100000000000010
> > +/* TDCS_CONFIG_FLAGS bits */
> > +#define TDCS_CONFIG_FLEXIBLE_PENDING_VE	BIT_ULL(1)
> 
> 
> So where is this bit documented, because in td_scope_metadata.json
> CONFIG_FLAGS' individual bits aren't documented. All other TDX docs refer to
> the ABI .json file.
> 
> Landing code for undocumented bits unfortunately precludes any quality
> review on behalf of independent parties.
> 
> > +
> > +/* TDCS_TD_CTLS bits */
> > +#define TD_CTLS_PENDING_VE_DISABLE	BIT_ULL(0)
> 
> In contrast the TD_CTLS bits are documented in the same .json file.

Yes, TDX documentation is lacking here. I hope it will be fixed in the
next version.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

