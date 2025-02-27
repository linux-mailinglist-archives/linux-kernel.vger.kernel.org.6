Return-Path: <linux-kernel+bounces-537144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD291A48880
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 20:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49214189206A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 19:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4665126D5AE;
	Thu, 27 Feb 2025 19:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R+bHUtjP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E4C26BD95
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 19:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740682973; cv=none; b=Mu5v3s/Y5vN9Prwl4bw/sy//durNFDKYm4yumzWiFxr9h9wk32xYyI+yl/BPaAqEuFpOEm/wVddBHziwNwtC9EgVg+UJMUsu2KU/ROvrisW9GMsBiOSj+8iMDimjnpTAEjinibVNhB93KtzEpTYy6zQrrHDeG7+RLcEu0C4AR/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740682973; c=relaxed/simple;
	bh=EjsHTuUbWnrPYjIIx2yKR92OKvYTcP2du2pWlUysGVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cTFwGpAy3kuBn+zhLXvKbFPp272U2bvTTddjgwlhjYpSilsCMjzV8bc7oE9VxyASfkTKbjmfFlIfIV8fihj2yQva5AoDqOwoTk8FGdD9w0wnF6PKzkmFIbL8Iah+iwhJ6IhzCamShAbvVlyzXrt4JVBTF+wM4xCieMKhA2x9xkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R+bHUtjP; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740682972; x=1772218972;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EjsHTuUbWnrPYjIIx2yKR92OKvYTcP2du2pWlUysGVE=;
  b=R+bHUtjPQMtkqPnrFfoeF/ifFwxBaABTM4TT8JYdDtkQkAVWYwjvVXNV
   S0HGXuBLxz8NWL5egKU296URwqG310Fbdx2Eo4xHKmt9rcS08QOcD+QAI
   KVCHFEpuviL3ePQTsHx6IPMVj+mNTr4YxJidQxLsDJp/v5cXJhK4chQQU
   7+dfuO4D0PEFcGTUEWxatsfoJqjqzTEp/WtOPDhk9vEUMgt8myta8eqlL
   N51CBz3hf747W+HxE0fc8EzpjYvoqOR9gOMFU1iwIOyKU5tjEfkUQwGJz
   aNBF71w2cqm6KqTu3d4qII6SqOccRGpaebT/lyzusBKGEuBGfPuSEPwX4
   w==;
X-CSE-ConnectionGUID: u2aRbjvxSaSsWAQ9jfgh3w==
X-CSE-MsgGUID: 263XK7kcTKGx1lVoH/PV7g==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="53003535"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="53003535"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 11:02:52 -0800
X-CSE-ConnectionGUID: P+Bm43hsS6qWyvCu44SCJQ==
X-CSE-MsgGUID: jlUvJY+qQd6wZ4g+MbQHOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="122344657"
Received: from kcaccard-desk.amr.corp.intel.com (HELO [10.125.108.72]) ([10.125.108.72])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 11:02:51 -0800
Message-ID: <7fa02be2-0884-4702-ae73-a3620938161b@intel.com>
Date: Thu, 27 Feb 2025 11:03:03 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v1 02/11] x86/fpu/xstate: Introduce xstate order table
 and accessor macro
To: "Chang S. Bae" <chang.seok.bae@intel.com>, linux-kernel@vger.kernel.org
Cc: x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
References: <20250227184502.10288-1-chang.seok.bae@intel.com>
 <20250227184502.10288-3-chang.seok.bae@intel.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <20250227184502.10288-3-chang.seok.bae@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/27/25 10:44, Chang S. Bae wrote:
> The kernel has largely assumed that higher xstate component numbers
> correspond to later offsets in the buffer. However, this assumption does
> not hold for the non-compacted format, where a newer state component may
> have a lower offset.

Maybe "no longer holds" instead of "does not hold".

This never happened before APX, right?

...
> +/*
> + * Ordering of xstate components in non-compacted format:  The xfeature
> + * number does not necessarily indicate its position in the XSAVE buffer.
> + * This array defines the traversal order of xstate features, included in
> + * XFEATURE_MASK_USER_SUPPORTED.
> + */
> +static const enum xfeature xfeature_noncompact_order[] = {

Nit: I think we call this "uncompacted" in most places.

> +	XFEATURE_FP,
> +	XFEATURE_SSE,
> +	XFEATURE_YMM,
> +	XFEATURE_BNDREGS,
> +	XFEATURE_BNDCSR,
> +	XFEATURE_OPMASK,
> +	XFEATURE_ZMM_Hi256,
> +	XFEATURE_Hi16_ZMM,
> +	XFEATURE_PKRU,
> +	XFEATURE_XTILE_CFG,
> +	XFEATURE_XTILE_DATA,
> +};

There are two possible ways to do this:

One, hard-code it like you have here. If we do this, we probably also
need some verification debug code that it got done right.

Two, dynamically generate it. I suspect that once you have the
uncompacted offset read out of CPUID, you could generate this in fewer
lines of code than it takes to define it manually. I think it would also
not require adding new features manually.


