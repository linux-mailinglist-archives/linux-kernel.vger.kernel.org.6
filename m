Return-Path: <linux-kernel+bounces-394901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 799A29BB58F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 14:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 310F11F21285
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 13:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC81EEBA;
	Mon,  4 Nov 2024 13:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e7CDO7UJ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201C679C0;
	Mon,  4 Nov 2024 13:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730726181; cv=none; b=jEuibH+7WjOcRlU0kjJ+2/EtiDgpDrI8JwB9fvstXlXDsv0byfKCI6MH7Gfji6cb78rkR3R6g0+1MihNf8ye/KTv2lQnC/PECdJpcWGkzFJfJS0jNHoD5IwoIY01w/OhnYO9+xnJFpgLkaEKuhwBRIhj3eaH19nrp0L9u7Chqy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730726181; c=relaxed/simple;
	bh=opA8FCEWxJHZIWCeT400QK2up7L+kKY9CnZkexN+5cA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pYv9o255nHU9yAmaECW7jOB4MSdCAHfJibl989YhEw/pKjzh5AYRW6T2ucgeFK0HdxRuTy1boeiHAICR1zM4UirQKKppLxEHrAtArGxq8cqTYMdjlsKZvJkMgMzR8TPiAvm2Zo13AznRh2hTEGE5iHjGIFriTJaOGiDoN/Q4lKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e7CDO7UJ; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730726180; x=1762262180;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=opA8FCEWxJHZIWCeT400QK2up7L+kKY9CnZkexN+5cA=;
  b=e7CDO7UJfg0zPb6Yn1ojFeReUeaRES9yAI03sVPSfYnLp/tjMPSBH7nu
   Xif4cRell/gX/l3qF/Iv0BPfj/EcEmpO5OPsQxdBHaTxwWjdCQnyAZGD1
   IZiUK14XVmQ3Rbm2T415SJebm4G0+mySYZtAC2WYlCMT6GfG5fkmVe8bb
   bk616+VYmM9mkW8j4kQ4F1etGwMR3yOJUQstn2n3LBemCe0uGWfyCTSsB
   aAB6terSSMONBmhTKBLDzDeDT5mOqaI6dKF2+TQs0P/drZUm4WsbqaFT1
   BW2a8wiQL/6YUgZiYRDh4nX5KrrKElgoTYk4SA/LUiaiL79+Kt9qhVaFI
   A==;
X-CSE-ConnectionGUID: V5oweAirSqOLTj1vw9vrNw==
X-CSE-MsgGUID: DTFMwVXJRrm9x26uXB74MA==
X-IronPort-AV: E=McAfee;i="6700,10204,11246"; a="30527533"
X-IronPort-AV: E=Sophos;i="6.11,257,1725346800"; 
   d="scan'208";a="30527533"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 05:16:18 -0800
X-CSE-ConnectionGUID: D/hDO2H2Q8eSQQAUap3KIg==
X-CSE-MsgGUID: NQeEuiynSVagaWP/v7+GGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,257,1725346800"; 
   d="scan'208";a="83770929"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.33])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 05:16:16 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: srinivas.pandruvada@linux.intel.com, 
 "David E. Box" <david.e.box@linux.intel.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
 platform-driver-x86@vger.kernel.org
In-Reply-To: <ccc08a262304f7f8c2e435349f0f714ebf9acfcd.1730563031.git.christophe.jaillet@wanadoo.fr>
References: <ccc08a262304f7f8c2e435349f0f714ebf9acfcd.1730563031.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] platform/x86/intel/vsec: Remove a useless mutex
Message-Id: <173072617111.2177.10854169180361298827.b4-ty@linux.intel.com>
Date: Mon, 04 Nov 2024 15:16:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Sat, 02 Nov 2024 16:59:41 +0100, Christophe JAILLET wrote:

> ida_alloc()/ida_free() don't need any mutex, so remove this one.
> 
> It was introduced by commit 9a90ea7d3784 ("platform/x86/intel/vsec: Use
> mutex for ida_alloc() and ida_free()").
> 
> 


Thank you for your contribution, it has been applied to my local
review-ilpo branch. Note it will show up in the public
platform-drivers-x86/review-ilpo branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86/intel/vsec: Remove a useless mutex
      commit: ab49d7bf991a524a976c9fbbeb53b050ebe4323f

--
 i.


