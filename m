Return-Path: <linux-kernel+bounces-556614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD69A5CC65
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 18:39:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C4FC3B7B03
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 17:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E93262817;
	Tue, 11 Mar 2025 17:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cH/02nWr"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F7E1D514A;
	Tue, 11 Mar 2025 17:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741714781; cv=none; b=tEI9KbvsGMc20Ehv9ujmuU+U8UP4sxyER3/B6YkNcWlNZm2t3tV1pO9yxVvOrdB6D2WC9uW7YM5GqSGkJknziPGhF8PnjYnN8YlRvY/48RNxCc4BhuCmIN5ky25bwxtKeGNyaooqqiCt06D9CkGUwher2sPG13gDpFK8gVZE+Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741714781; c=relaxed/simple;
	bh=kv+WwmqbGUNvAZ6GSHtKuPsxWSYd7YbvpRYthTPZg+M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pZeHnQ55nLoL4fWHxmPPW4UwFKba2ZXeZNPX57oAh9FQgzu79N/KQKTazrefjyfd0VnJO4HSGoSbOligQrGdQZQWbTPp5dAsqs37fbCIpLFz7qoqLZ5+97ZWJISYp49IoRM/gY99Ae7gjPWW+ehTeUW9R5/AMBd+tcyXqF89M4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cH/02nWr; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741714780; x=1773250780;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=kv+WwmqbGUNvAZ6GSHtKuPsxWSYd7YbvpRYthTPZg+M=;
  b=cH/02nWrJ5/0trGF3xk5H31DCm9kiMXtf0KJprTtsMC3T/BzQ98XQqhV
   zbjy6cYj++Mr+jf02AKyjfTcKmBvj1/a1iUJvxo0EOdF9jaOtbrWDELqv
   lrTRHqhEFldQ1NRBzw4FmRJwBle8d0ehfpGVWmZlkSGakdqqoF0H4U4Fj
   IKzrMBCW7T5n3oiRTsFUj8HNCKYKHI2T3Y5bNI4Vr9H6YT9WHIfGiJlos
   oOe3WlzP5j05NAjhDCpNx42X7K8qMghwLiSd/Lof5V0amvR1No8cf/vD6
   zT+WJ/GI1pKknCrigXPb3je0oRPNOXbhVKVbtNzLksKNwkpVAf8/mfeYY
   g==;
X-CSE-ConnectionGUID: 1eNGaYU4QCypM6VAm/4K6Q==
X-CSE-MsgGUID: w3lOysZGQ+evXyLkHiRQpw==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="54151993"
X-IronPort-AV: E=Sophos;i="6.14,239,1736841600"; 
   d="scan'208";a="54151993"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 10:39:39 -0700
X-CSE-ConnectionGUID: lukZ3jFvQKqbjZc2kJGWfw==
X-CSE-MsgGUID: 81yNK9BARMSc9B197TEYsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,239,1736841600"; 
   d="scan'208";a="143583704"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.251])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 10:39:32 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: Hans de Goede <hdegoede@redhat.com>, 
 Patil Rajesh Reddy <Patil.Reddy@amd.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-janitors@vger.kernel.org
In-Reply-To: <232231fc-6a71-495e-971b-be2a76f6db4c@stanley.mountain>
References: <232231fc-6a71-495e-971b-be2a76f6db4c@stanley.mountain>
Subject: Re: [PATCH v2] platform/x86/amd/pmf: fix cleanup in
 amd_pmf_init_smart_pc()
Message-Id: <174171476741.1715.12385728122456798855.b4-ty@linux.intel.com>
Date: Tue, 11 Mar 2025 19:39:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Mon, 10 Mar 2025 22:48:29 +0300, Dan Carpenter wrote:

> There are a few problems in this code:
> 
> First, if amd_pmf_tee_init() fails then the function returns directly
> instead of cleaning up.  We cannot simply do a "goto error;" because
> the amd_pmf_tee_init() cleanup calls tee_shm_free(dev->fw_shm_pool);
> and amd_pmf_tee_deinit() calls it as well leading to a double free.
> I have re-written this code to use an unwind ladder to free the
> allocations.
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-fixes branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-fixes branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86/amd/pmf: fix cleanup in amd_pmf_init_smart_pc()
      commit: 5b1122fc4995f308b21d7cfc64ef9880ac834d20

--
 i.


