Return-Path: <linux-kernel+bounces-179814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6DA8C65C8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 13:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 900D21C2109E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 11:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB746F073;
	Wed, 15 May 2024 11:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OcgoRcKT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AA6433DC
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 11:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715772848; cv=none; b=OVtOsSEwhvUl1KfQd7VN4hRhTFdCzpe5C5kK2casbQPeTziWCS9F55BzUiJaNUl7g3bA9JyRAP4v9F3yyS92TduRDzx3iAPjPgaXdjFjogfq45Mtih3ugmtjBh9a2FXjSPRL9+e3Nmi2KouboZolhtFGq/MD0grEQPb6+W/tOpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715772848; c=relaxed/simple;
	bh=vjz3YtkE6x9jeBbjI+Y3bdQZjv0Zgo1PCO5LCXUI51o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gSLREa3ySqVDynpzn1zwV8Gb0Fgbi36rfbHK+qkDl0sup4dKdYsSCnN3CQxm6QUtdvOXMyvFpsQyKXR0neK3sRxMG7eaPMSBtO8ED/vB/Eg8dBYX+NLoX4w3J/mcubchUdR7GChE0aE3GPM/d3Y6j6yIcMm2BiSl4loR9ocKajw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OcgoRcKT; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715772847; x=1747308847;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=vjz3YtkE6x9jeBbjI+Y3bdQZjv0Zgo1PCO5LCXUI51o=;
  b=OcgoRcKTst3gZESXJE9p0LppQ/gcFKdHmyVrQTwUDwytDvPjp5tF1+Zw
   sozLGi2LTJawRbcaFfuDjjqUr0T8gelcTU7844ij3VV8ydWVIWTxYxTIk
   j/PR1fYmc3BjVLjxqUU/N0bV0nt2I3pGb3B1ICOqPjcjhjkoAbMlF9k2Y
   Gm/NfH/YyFbedTgyWfxZxtZ19x4ljkpgfZfwshHWVtgnMwpssMgj7sn0e
   u4G8i+G7kLKUclrT+knm6SV1/gI+PFst2WYMd7aJT5Tv/SUyluiOAFE38
   XhVFsaZayL0X6u8t/7LHwSZ4kvGe5KmRUzKdkShfmdSxQZ+AAueUudthX
   g==;
X-CSE-ConnectionGUID: TH4VxVqRR5ON7k1QF6Oa2A==
X-CSE-MsgGUID: q0aSS+dXTgWvk8NPb/MnHA==
X-IronPort-AV: E=McAfee;i="6600,9927,11073"; a="15602475"
X-IronPort-AV: E=Sophos;i="6.08,161,1712646000"; 
   d="scan'208";a="15602475"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2024 04:34:06 -0700
X-CSE-ConnectionGUID: c1brhzZxRc68waYgCcrztA==
X-CSE-MsgGUID: Rnyqba5TQEOfKPYIggFvWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,161,1712646000"; 
   d="scan'208";a="31028469"
Received: from mwiniars-desk2.ger.corp.intel.com (HELO localhost) ([10.245.246.141])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2024 04:34:02 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Sui Jingfeng <sui.jingfeng@linux.dev>, Neil Armstrong
 <neil.armstrong@linaro.org>, Maxime Ripard <mripard@kernel.org>, Dmitry
 Baryshkov <dmitry.baryshkov@linaro.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drm/bridge: Support finding bridge with struct device
In-Reply-To: <bd175eb3-ca70-4ce7-89ab-ca7f622ed153@linux.dev>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240514154045.309925-1-sui.jingfeng@linux.dev>
 <20240514154045.309925-2-sui.jingfeng@linux.dev>
 <87v83fct2e.fsf@intel.com>
 <cd81893c-ef0b-4906-8c9c-a98b1e4669e6@linux.dev>
 <87pltncqtg.fsf@intel.com>
 <bd175eb3-ca70-4ce7-89ab-ca7f622ed153@linux.dev>
Date: Wed, 15 May 2024 14:33:59 +0300
Message-ID: <87msorcnrs.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, 15 May 2024, Sui Jingfeng <sui.jingfeng@linux.dev> wrote:
> Yes, you are right, I'll back give another try then.

Thanks, but please do wait until you have feedback on whether the whole
thing is a good idea or not. :)

BR,
Jani.


-- 
Jani Nikula, Intel

