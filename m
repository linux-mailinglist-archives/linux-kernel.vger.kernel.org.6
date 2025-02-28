Return-Path: <linux-kernel+bounces-538524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF24A499A3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 13:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A62E3BD192
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 12:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8108F26B966;
	Fri, 28 Feb 2025 12:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TH6nk81o"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CCC26B2A7
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 12:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740746503; cv=none; b=dYP8Q48q3PqkLkrpzsXGmehzcSQ4w23QnKKxYqwdOR3X3e9zS3QPNj/6zhowiju2QbsJw8Ags5wi2dbce5NiUCG8BRPOViVsb3vXg6/rLjIXh94vw4zYRrrguvnCqOxbNgTJSwb6ohPf6jdN/F2bFqyHt0Pq0RPSxYKPT+6xpqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740746503; c=relaxed/simple;
	bh=1OiwVi2kFznv3HgPPmi+2wkyd/L/1UiFJ0osUjwoI6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P65EmEXbPUpV3iK8oPLUDonIrf5EUsmaCqRfkogZmB252GK23GrHA9+NEXjIrdsh5ySOCy/Kve7/H7FBKHVb+wCr0XCQiITP4+VJLy2ovC97cwhdmvhfPu9PXcuuP4XwfbvapzNofhQVWLLvLDhpo8QJWOYL6gdxMEQ+Rbf+Uvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TH6nk81o; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740746502; x=1772282502;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1OiwVi2kFznv3HgPPmi+2wkyd/L/1UiFJ0osUjwoI6c=;
  b=TH6nk81oGMOvPap09ZM3cSlBciENH2YexVEs1cfCss69vcMWcucTkx38
   NlEunc2E4idn1N1W0/pJoLrq6r1jCGzB6QScZtexo58+dPciFNiw88Sn/
   fHle6xgXEXPGN+do0cmniaEvWOnVsSJo1wrk3RXPLaIE4xZhyCWJPDqVA
   JHf2BlTyJiGfwU80KoirYjU4qPHHZgn/X91rnP+6Q+un3uIx/jmTp25+2
   6RaXkJfxEgvNJSzCRqLOtRJ87djOrfl+A9QjSkaxacMjti2V8BUfVyfDE
   Tzn5iMumSGgLrPe17W41TiAzWjkyYe96n7bh6B/CMv/Ac3MEbUGo8D+l6
   A==;
X-CSE-ConnectionGUID: rFr+dOq9SkOqoK0tHc/TQA==
X-CSE-MsgGUID: e9U/QfOsSxmdlOpen4PW4g==
X-IronPort-AV: E=McAfee;i="6700,10204,11359"; a="44487887"
X-IronPort-AV: E=Sophos;i="6.13,322,1732608000"; 
   d="scan'208";a="44487887"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 04:41:41 -0800
X-CSE-ConnectionGUID: z/Gjlkx5SFy6pa3aVv9fgA==
X-CSE-MsgGUID: GBKVSnUZRFOnsviQBJ16CA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="148250841"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 04:41:40 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tnzgP-0000000FwjE-2T5p;
	Fri, 28 Feb 2025 14:41:37 +0200
Date: Fri, 28 Feb 2025 14:41:37 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: xiaopeitux@foxmail.com
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	Pei Xiao <xiaopei01@kylinos.cn>
Subject: Re: [PATCH] driver core: Split devres APIs to device/devres.h
Message-ID: <Z8GvAeFqCQPGQzkk@smile.fi.intel.com>
References: <tencent_66CF9C91EB4A4417F70E9511649A57DEC906@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_66CF9C91EB4A4417F70E9511649A57DEC906@qq.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Feb 28, 2025 at 05:18:35PM +0800, xiaopeitux@foxmail.com wrote:
> From: Pei Xiao <xiaopei01@kylinos.cn>
> 
> Since a21cad931276 ("driver core: Split devres APIs to
> device/devres.h"),but some APIs like 'devm_alloc_percpu' didn't move to
> devres.h. we should also move it.

Action move is part of the next step, see this [1].

So, basically you should take your --base branch, merge the immutable tag [2],
apply patch series from [1] and then create a patch of the leftovers as
mentioned in your commit message above.

[1]: https://lore.kernel.org/r/20250220162238.2738038-1-andriy.shevchenko@linux.intel.com
[2]: https://lore.kernel.org/r/Z7xGpz3Q4Zj6YHx7@black.fi.intel.com


-- 
With Best Regards,
Andy Shevchenko



