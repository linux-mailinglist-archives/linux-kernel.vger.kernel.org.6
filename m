Return-Path: <linux-kernel+bounces-428046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 141839E0963
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 18:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D376F282472
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 17:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CFD61D9A42;
	Mon,  2 Dec 2024 17:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S57ahAV3"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D2A1D6DB0;
	Mon,  2 Dec 2024 17:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733159116; cv=none; b=TKBBSwE8I1gK03I06MDwzX8kuYwXsfFmdNEVGUNm1y2EDsna4q45YMTiGMdXo7Y5zipBILqHe8gB8bdetnDZxuJN17Ljaz1V2SQOy7AsSWImJe3geR3PhJegT33KTk6gf9ggO44h7OIgErAc40NQ0pSs6YX6enk7syTH/S9qq+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733159116; c=relaxed/simple;
	bh=ur/ypVaK5ksBUgYzHCV7S9+K8dj1MZtTztQiwluvImY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CrAfGCQACUBgWjLycNnkdVSBeRJg/QrPUOD/Mv0pNHFvT1rnlTE4lVg4QvVlhuZjqAKGdyIRK8+MEqZ34r/NLATVzaXH5LVkBdGUvR7EojreLbDD7kHDkfhno7tABwiMLcqjVgMhJPf7SJUIBl1/iqlw+crk08Qhh/3uhM0nAO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S57ahAV3; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733159115; x=1764695115;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=ur/ypVaK5ksBUgYzHCV7S9+K8dj1MZtTztQiwluvImY=;
  b=S57ahAV3HLnO7/znzE2hM9D8FPsrZEB6qZtlSK5adHVm8gFmoUhNwu0N
   UwTexBXwElvyfbjWo5SYPBoNkkB9EVijbilr2g6KRz1cJdT7yhMDsevOy
   8iJUnhXWlYSy+JoqN6UBaxjiA1kSu179kuq9WVTRnxPz97YBRAFPQ7Y4M
   FEYZt1xmixo5P9VbVBEspd7pL/O1I/RISmLAb54Aghm2j/AZJ4qyvekAS
   ytIqq89osGZHjupqXaq1VE897J8V3RAyDAC2bFHDbPfpPrTjMzNsJo/Dp
   qrK8xuSiadOIEb0TYf3BOw6I7DkBDTWaban7G4RMiChG6WnD4c2YtYMCG
   w==;
X-CSE-ConnectionGUID: MvprYvLdTG6pqNDXWCsMEQ==
X-CSE-MsgGUID: rhFl621XS8CYM1DASciOfQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="44374778"
X-IronPort-AV: E=Sophos;i="6.12,203,1728975600"; 
   d="scan'208";a="44374778"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 09:05:14 -0800
X-CSE-ConnectionGUID: iLKlw9UDRcuhEF6q0z915g==
X-CSE-MsgGUID: yzGlkKIcR2yv5KcpASTCmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,203,1728975600"; 
   d="scan'208";a="98133225"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.61])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 09:05:12 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: auslands-kv@gmx.de, corentin.chary@gmail.com, luke@ljones.dev, Armin Wolf <W_Armin@gmx.de>
Cc: hdegoede@redhat.com, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241124171941.29789-1-W_Armin@gmx.de>
References: <20241124171941.29789-1-W_Armin@gmx.de>
Subject: Re: [PATCH] platform/x86: asus-wmi: Ignore return value when writing thermal policy
Message-Id: <173315902009.13686.3627393003888118989.b4-ty@linux.intel.com>
Date: Mon, 02 Dec 2024 19:03:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Sun, 24 Nov 2024 18:19:41 +0100, Armin Wolf wrote:

> On some machines like the ASUS Vivobook S14 writing the thermal policy
> returns the currently writen thermal policy instead of an error code.
> 
> Ignore the return code to avoid falsely returning an error when the
> thermal policy was written successfully.
> 
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-fixes branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-fixes branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86: asus-wmi: Ignore return value when writing thermal policy
      commit: 25fb5f47f34d90aceda2c47a4230315536e97fa8

--
 i.

