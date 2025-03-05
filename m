Return-Path: <linux-kernel+bounces-547178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0926A503DD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 16:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E35A51890E41
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91BD6250BF2;
	Wed,  5 Mar 2025 15:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l0/a65GZ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C84524F5A5
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 15:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741189989; cv=none; b=bxmwtaTHhj+sTjgf+SyiVZEt9V94ngQUF9OXcwgm4doBh+ri88z39wcoqp+O3rQW0r6YZ96uQ+sC04+BTBHfxM5kTnECtWjHDNtwQHv1gP0yuoOuEHpp2ranx+wNL6nG6l2bObZ8gjIXvmj+lzxvcihYaXA1J1bDEmy5gNcK+EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741189989; c=relaxed/simple;
	bh=Tn7c/4KBBSgdrZj70XjtojmoeN5yFcyHGbn2LUyfXrs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SdJIILnZJtLjffkiD+VdoXxfbMrvmTeRY5cGrYgpopH600KobByWqV7P5r+1LHsHNBXH+ltx46xP3DVdsgz+xJeZhzBz1kVlNNS4dBczdkJwhqmnwQlsqDjZqxCZopnU1cOZ4NKKgzwH6du9maTyW+HxxMXWpPDOzJ4jlB5sAxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l0/a65GZ; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741189987; x=1772725987;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=Tn7c/4KBBSgdrZj70XjtojmoeN5yFcyHGbn2LUyfXrs=;
  b=l0/a65GZXoccvbnf9lkFgrZljsvyzHIaXy2Y5yW4SImSHxDKqnW3yTKX
   j920GdY70TY/9na9Z/MwWoggqOiHjxDJRYpGaoKZxfatE/KVCbHeKEPSg
   xGbwCti5m6cpk6jhVFLeoLX2jRLz83M8//HqJrtp1hl4O2n1guDalXcV3
   Ly9t34+EV1vxScLWhSCnQQ0MXoqjuRkzrklgSK0RyFnbuaczAiVughKzw
   ReDUQJqlAwakdaW5bE6fzBFh8W5ORdLN/UnKAcLkFS1kOKnlMxF/NQidV
   9mmX836LlgyR4ekurhTe5PFb5NpTycnVfiv0wyTrzOi8nG3X4wvm24b16
   A==;
X-CSE-ConnectionGUID: YF3MjsjOQ1OhyPoCQ3uxWA==
X-CSE-MsgGUID: 32BPraKUR82Rqd87fpeipg==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="67527580"
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="67527580"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 07:53:05 -0800
X-CSE-ConnectionGUID: twW6RAXcQQa2tZs6ZhOGjQ==
X-CSE-MsgGUID: 88yD85AESISGO7rdvHmilQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119234936"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.49])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 07:52:59 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Yury Norov <yury.norov@gmail.com>, mailhol.vincent@wanadoo.fr
Cc: Lucas De Marchi <lucas.demarchi@intel.com>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Andrew Morton
 <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, Andi
 Shyti <andi.shyti@linux.intel.com>, David Laight
 <David.Laight@aculab.com>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v4 3/8] bits: introduce fixed-type genmasks
In-Reply-To: <Z8hx9AaUX_GvYq_A@thinkpad>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20250305-fixed-type-genmasks-v4-0-1873dcdf6723@wanadoo.fr>
 <20250305-fixed-type-genmasks-v4-3-1873dcdf6723@wanadoo.fr>
 <Z8hx9AaUX_GvYq_A@thinkpad>
Date: Wed, 05 Mar 2025 17:52:56 +0200
Message-ID: <87a59zxynb.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, 05 Mar 2025, Yury Norov <yury.norov@gmail.com> wrote:
> On Wed, Mar 05, 2025 at 10:00:15PM +0900, Vincent Mailhol via B4 Relay wrote:
>> +#define GENMASK_U8(h, l) ((unsigned int)GENMASK_t(u8,  h, l))
>> +#define GENMASK_U16(h, l) ((unsigned int)GENMASK_t(u16, h, l))
>
> Typecast to the type that user provides explicitly?  And maybe do
> in GENMASK_TYPE()

The cast to unsigned int seemed odd to me too.

BR,
Jani.


-- 
Jani Nikula, Intel

