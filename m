Return-Path: <linux-kernel+bounces-245601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3969592B4CF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 12:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A2FF1C21B10
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 10:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1BA155C98;
	Tue,  9 Jul 2024 10:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l4/4mWOI"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8E838FB0
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 10:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720519815; cv=none; b=ZIkRDEBrHTV21CSGpkh/IvC12VozUSfEmqq3vC0h8LxMBd26VdW/uNMA/J+zAQVREL6kWWeA2x35x0jTjkUDRC33RxSurOyjAKxZ831VG1oqpCPBvmefaHyTyAXfOjTNTgjBWYlbTrMN9v17Qu4kVLqFw6apvzPHNqIXCC8Lo2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720519815; c=relaxed/simple;
	bh=aJOfIDatk3vEMdHF2A2FfLbUH1bI23Rmm2FvHwmD1J8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AYUGgS/Yz8Cxi4LM2qMKylIpq470RRp0bUk1TLYfndvtb0g2ZhlVQbG02N3vFMb1OtlRshXCXqSFsM+x2j0ExGG/JOTmyvpHrQtTR0VUKjB/TBF5Ygh9oGTs/pze2JXxkrqt0Ogo1S9MZoOYgYOpMJZcIXELrzSl8e5BK0+UveM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l4/4mWOI; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720519815; x=1752055815;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aJOfIDatk3vEMdHF2A2FfLbUH1bI23Rmm2FvHwmD1J8=;
  b=l4/4mWOIhfcs5uOwE0pB9j8onYJ4yyuS71G0l8ozkGT28rQlOF79POl1
   9zqia4lCsyqRdAUlxVXAtOsOmC6xz/X4MbuUDmUwMRI4ZucHDTVPCOlxT
   mRbnUCrVmI3ro5eoDwlFQVwxXm2LXW2qKef61tYYyjIIDAYTWMlEbLlhC
   aGQLobAsh2k4RBC+lepggekYttEqfNapbCf5KR7vriOIvp/9C06sMCmL9
   Hix/sc69LkrHn5RzrVVWiodQxLjm1DqoOw08QpVz4E9L3XFJXw6KPj7OB
   KZ0/QlD/yMQeQOUjHEi58l7x8ydXPku82jGygw/gBkyCLnUs1zCnxJO4A
   g==;
X-CSE-ConnectionGUID: iHkzgnHLQrKhHqMsams1PA==
X-CSE-MsgGUID: ebf9DHu8RQSyVPetPq72Nw==
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="17581040"
X-IronPort-AV: E=Sophos;i="6.09,194,1716274800"; 
   d="scan'208";a="17581040"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2024 03:10:10 -0700
X-CSE-ConnectionGUID: fG2qZg3TRm+mflpFiR6edA==
X-CSE-MsgGUID: uiux1DIKTHmbdKxyz9w0dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,194,1716274800"; 
   d="scan'208";a="78538860"
Received: from jlawryno-mobl.ger.corp.intel.com (HELO [10.246.19.58]) ([10.246.19.58])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2024 03:10:06 -0700
Message-ID: <73a245d2-2e12-476a-b22a-cc11bdcecef0@linux.intel.com>
Date: Tue, 9 Jul 2024 12:10:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] accel/ivpu: Add missing MODULE_FIRMWARE metadata
To: "Alexander F. Lent" <lx@xanderlent.com>,
 Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
 Oded Gabbay <ogabbay@kernel.org>, Jeffrey Hugo <quic_jhugo@quicinc.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
 Krystian Pradzynski <krystian.pradzynski@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240708-fix-ivpu-firmware-metadata-v2-1-78b953172026@xanderlent.com>
Content-Language: en-US
From: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20240708-fix-ivpu-firmware-metadata-v2-1-78b953172026@xanderlent.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

Just two more comments and we are good to go.

On 09.07.2024 02:25, Alexander F. Lent wrote:
> +/* Add module metadata for the production firmware paths.
> + * This needs to be kept in sync with fw_names above.
> + */
I would prefer: 
/* Production fw_names from the table above */

> +MODULE_FIRMWARE("intel/vpu/vpu_37xx_v0.0.bin");
> +MODULE_FIRMWARE("intel/vpu/vpu_37xx_v0.0.bin");
You probably meant *40xx*.

Regards,
Jacek

