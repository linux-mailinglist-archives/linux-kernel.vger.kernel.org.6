Return-Path: <linux-kernel+bounces-260703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD9693AD31
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 09:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C4171C21D12
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 07:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3164A71B3A;
	Wed, 24 Jul 2024 07:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SlS85wNj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECE23D97A
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 07:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721806461; cv=none; b=iPnG+8aoSYD26JX51ySKwQjCvf2vx0jKCSypjFec5pUz9Xb/EBZykYl7yWn9VRnzKtC28THqh8IWSE7FJh8ZyPibZaMYNAblfwvcWV/SuSMyydD4rPGH8sEE7jLagrERTdXxvlAdYyrg68d2wrKqGHhOHPYP/fGd9QweQQnI5bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721806461; c=relaxed/simple;
	bh=ryU4IBCBceUxEUDP2SiVcXZERvqZxabEiR5XZy1XpYo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h0e0Vvl6DOoasdJP4txrTc7DK+6whjINUFAquya1+Hrp+lJ3ENJWh9jwNquWswBfMNZ3AfL/IRmaj68c1XT5VUBVzVMMagYcEeF6q2hYFDTh7+bqEH77qsK9JXavXJhI/UlHxQBNFq/WvBYp/P1X29FykYcOVVY3h/JMo7azjQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SlS85wNj; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721806460; x=1753342460;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=ryU4IBCBceUxEUDP2SiVcXZERvqZxabEiR5XZy1XpYo=;
  b=SlS85wNjheYcFa4Ocwi7meTu8zemdDS+uVa5gUuZ3oxXkFPBUBq6zUnM
   mJt62fqo4Clpm64vvDUjVB3Yl2U1urh7rzewm8HopG1cwRZHPa8kH2KcN
   9DKTc7PeEfp23PG87sskmAXuflzu6gEkptedudID8DnIHIUywAU/jrkzz
   G1aQIVO6H4vA6ru4AWUEjJVyiMAyezKUn9Um4HWfAhDCj5d6dYNz1OLvu
   AZZQgnMoGicc3/RW/CcLg5LB4gNm3ZXXJ1fJM/jQ/s/W0hyIMhqVTx9AK
   rjin41pQSsPcGEUB1j6tg78ppN6GStdU/1vIMDRsHNJjky1T+rgkmLIYN
   g==;
X-CSE-ConnectionGUID: MEwSvSZTTiikI36TIQUnxA==
X-CSE-MsgGUID: GR0Ewe9GRwCJ8Apngq+/UQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11142"; a="23276748"
X-IronPort-AV: E=Sophos;i="6.09,232,1716274800"; 
   d="scan'208";a="23276748"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 00:34:19 -0700
X-CSE-ConnectionGUID: y5Aewy0cQm+wkYhiNRBGBg==
X-CSE-MsgGUID: rERyPg1CTq+4t4DFPxXG0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,232,1716274800"; 
   d="scan'208";a="57303592"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.156])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 00:34:15 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Philipp Stanner <pstanner@redhat.com>, Luben Tuikov
 <ltuikov89@gmail.com>, Matthew Brost <matthew.brost@intel.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Philipp
 Stanner <pstanner@redhat.com>, Marco Pagani <marpagan@redhat.com>
Subject: Re: [PATCH] drm/scheduler: Use ternary operator in standardized manner
In-Reply-To: <20240715071533.12936-1-pstanner@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240715071533.12936-1-pstanner@redhat.com>
Date: Wed, 24 Jul 2024 10:34:10 +0300
Message-ID: <87wmlbfdl9.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, 15 Jul 2024, Philipp Stanner <pstanner@redhat.com> wrote:
> drm_sched_init() omits the middle operand when using the ternary
> operator to set the timeout_wq if one has been passed.
>
> This is a non-standardized GNU extension to the C language [1].
>
> It decreases code readability and might be read as a bug. Furthermore,
> it is not consistent with all other places in drm/scheduler where the
> ternary operator is used.
>
> Replace the expression with the standard one.

The GCC extension is widely used in the kernel for brevity. Arguably
duplicating the first operand is more error prone than omitting it.

Consistency within scheduler may be a valid point, but I'd consider
removing the redundant middle operand instead.

BR,
Jani.

>
> [1] https://gcc.gnu.org/onlinedocs/gcc-14.1.0/gcc/Conditionals.html
>
> Suggested-by: Marco Pagani <marpagan@redhat.com>
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> ---
>  drivers/gpu/drm/scheduler/sched_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
> index 7e90c9f95611..02cf9c37a232 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -1257,7 +1257,7 @@ int drm_sched_init(struct drm_gpu_scheduler *sched,
>  	sched->credit_limit = credit_limit;
>  	sched->name = name;
>  	sched->timeout = timeout;
> -	sched->timeout_wq = timeout_wq ? : system_wq;
> +	sched->timeout_wq = timeout_wq ? timeout_wq : system_wq;
>  	sched->hang_limit = hang_limit;
>  	sched->score = score ? score : &sched->_score;
>  	sched->dev = dev;

-- 
Jani Nikula, Intel

