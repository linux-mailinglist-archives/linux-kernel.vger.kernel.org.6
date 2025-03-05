Return-Path: <linux-kernel+bounces-546454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A26B6A4FAE5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 10:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E957166265
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 09:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC8320966B;
	Wed,  5 Mar 2025 09:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QH+GqAE8"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A7B20899B;
	Wed,  5 Mar 2025 09:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741168478; cv=none; b=Rqs10A95SGHrs1ndKbTcxpBtYxKNBjiA0M1PpxJok5o/Bqo4+OydvZH3t+/d7WdJMFQRSVrOLIzfjUjg/IDbzsUguxDYFJ6PlAbdaKQO/vH4Xl0pvp2e4JmdFhXn6I9l+h/I5rc08JP6blcxRgOtYNfmL5cuGIFpy2Jp8timBC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741168478; c=relaxed/simple;
	bh=IWfs6yzKVI4Ccxc4IRO+UnK1ZSpJVL7z+ettaycFGio=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=S9HeQjg1vOPhpWcmSgkYEJfeNqvbO2IfymYe9k09C5xH98Mi0eIT3SKvbdVa87E9BLV4u+VQEqFGW9lTEB3cp0lx8Q4LHk4b+fQIKO7Sezi/LHbYeGkcYvikIiibKOyLtgJky6hsmSY516ef6L01o/1dWzcJuwSp88vCbLcgOzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QH+GqAE8; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741168476; x=1772704476;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=IWfs6yzKVI4Ccxc4IRO+UnK1ZSpJVL7z+ettaycFGio=;
  b=QH+GqAE8hhVJq9a3BkSAi94ln3Ie2qgOMWshmrGOcqP+eZaAMu+5ZHmC
   dITc8FzS1vaVTOdc8uhWoT15PL2/k+aFnqknjG+6MqXaZNZsnYo7XVHmL
   eVn4G8d2YFIyb5wJ7dG1Godus/FIRtDSvobAXwTgSQkIsqoaJVjpwz47p
   gPtlsSivwwv4b8k7eQiTuhueWCp+S1EGTBXD8M4NKYyq9Ne0l96ZDNO2L
   OdogPEywmkc2n3pyMYJoNI5QjbLXaoKpnvPAePeAGAzG3wmKc6UqH3Kki
   pls66Tk0+aABcu7fzDN9jzfl5S8tC71HtME6ukuLQhB/74hxrjb93Ktxy
   w==;
X-CSE-ConnectionGUID: QRpaNJ/KQb23KslOdOD6cw==
X-CSE-MsgGUID: 2SLQAHBMQyeIr5OXJca2KA==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="42146539"
X-IronPort-AV: E=Sophos;i="6.14,222,1736841600"; 
   d="scan'208";a="42146539"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 01:54:35 -0800
X-CSE-ConnectionGUID: NjveLfVgQTqYF8JmmVY09Q==
X-CSE-MsgGUID: xK+hVwDbS0OgxhSnkrxgcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119144939"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.49])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 01:54:31 -0800
From: Jani Nikula <jani.nikula@intel.com>
To: Shuah Khan <shuah@kernel.org>, gregkh@linuxfoundation.org, corbet@lwn.net
Cc: Shuah Khan <shuah@kernel.org>, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 conduct@kernel.org, tab@lists.linux.dev, Miguel Ojeda <ojeda@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] Documentation/CoC: Spell out the TAB role in
 enforcement decisions
In-Reply-To: <20250304194813.11049-1-shuah@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20250304194813.11049-1-shuah@kernel.org>
Date: Wed, 05 Mar 2025 11:54:28 +0200
Message-ID: <87h647yf8r.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, 04 Mar 2025, Shuah Khan <shuah@kernel.org> wrote:
>  Any decisions regarding enforcement recommendations will be brought to
>  the TAB for implementation of enforcement with the relevant maintainers
> -if needed.  A decision by the Code of Conduct Committee can be overturned
> -by the TAB by a two-thirds vote.
> +if needed.  Once the TAB approves one or more of the measures outlined
> +in the scope of the ban by two-thirds of the members voting for the
> +measures, the Code of Conduct Committee will enforce the TAB approved
> +measures.  Any Code of Conduct Committee members serving on the TAB will
> +not vote on the measures.

2/3 actually means 7/10 for the TAB.

Except two of the CoC committee members currently serve on the TAB, and
will not vote. Assuming they will also not count for the total, 2/3
means 6/8 = 75%.

All of a sudden you actually need 3/4 majority in the TAB to approve any
CoC measures.

Perhaps consider using a simple majority instead? The numbers become
6/10 and 5/8.


BR,
Jani.


-- 
Jani Nikula, Intel

