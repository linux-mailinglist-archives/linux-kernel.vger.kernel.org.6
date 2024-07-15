Return-Path: <linux-kernel+bounces-252301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A5293113D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 11:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 366021F23072
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 09:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241F2186E37;
	Mon, 15 Jul 2024 09:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DCXje0tw"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F659199A2
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 09:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721035941; cv=none; b=gAkhtqyIVTr6Mr3UKu9zr+qS5UH9fsRM6clnORcoFbVFYtILBqZDpLM7oJmocBAqOteVLv8uJGTan2jBncrABzl9rg3uE5IKeTWFRgDEwgJKkmHymVfWBd8mcJtcFmOJgbaQMRocWAtROMBeTwg6XqKq71eJTvWva4OtYyfQirI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721035941; c=relaxed/simple;
	bh=n1ctJHkCl+P5uEWWLaeLZw+MgNNGn6pFPiIwDpVt7eU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gijK4cHcVVjT8aSvRVBg+0TH0sxZbLTo5zp6b+YECGjjJ56MbbShjZMnI+/u+rhY3h3QezGlaGxOkL6y/PxcS/VKB8haGCDJlu9Pu2KusfpjCWvtMjgZQi3QKDb6JpehejFPDwdSs7ytPqlbyvdjLmp8J0uqrYfTSlBplqRhHfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DCXje0tw; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721035941; x=1752571941;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=n1ctJHkCl+P5uEWWLaeLZw+MgNNGn6pFPiIwDpVt7eU=;
  b=DCXje0twCAS1TgjAXciZN/XXATKKkxR/2KOfsKDYvPMGkWXU4ewW+1oP
   50XRvSm6LufhhdHf9pleGnAyt0b1QA7n6vTbV2X6poBbWIvxRUQXID/oQ
   4UXX3kogzEKKRom514xQyVwZtf9sn9tC95GfWdqU6T3yWKlJ224th3qzW
   24xQYSC3jC0H1KK2Aa2Kc2H0VK70fFTFRrRmV7FyCdXk62m+g7iFyqqDD
   Pdbocq7PU2G9pMyErNg49g58FM1BS46TwIIb1Ctazp5qLdRLlOhghXNPx
   KKMLPY4lW+34GDdXpPCYIMfErJhh+bEXREyFiwdixqTTz71IoKjDliua9
   Q==;
X-CSE-ConnectionGUID: O8lsJCr4Q8KE3v1BF1J4Vg==
X-CSE-MsgGUID: SkslxKltT0C6eIhoIQbbLA==
X-IronPort-AV: E=McAfee;i="6700,10204,11133"; a="35834711"
X-IronPort-AV: E=Sophos;i="6.09,210,1716274800"; 
   d="scan'208";a="35834711"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2024 02:32:20 -0700
X-CSE-ConnectionGUID: Pqyw6ck8Rr2iym/SmiStLg==
X-CSE-MsgGUID: Zzt1q+QiTKCV75MrGYv0ZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,210,1716274800"; 
   d="scan'208";a="54389993"
Received: from jlawryno-mobl.ger.corp.intel.com (HELO [10.246.3.118]) ([10.246.3.118])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2024 02:32:18 -0700
Message-ID: <76e6f01e-fcf8-4f6b-9b09-205e92f7ce5a@linux.intel.com>
Date: Mon, 15 Jul 2024 11:32:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] accel/ivpu: Add missing MODULE_FIRMWARE metadata
To: "Alexander F. Lent" <lx@xanderlent.com>,
 Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
 Oded Gabbay <ogabbay@kernel.org>, Jeffrey Hugo <quic_jhugo@quicinc.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
 Krystian Pradzynski <krystian.pradzynski@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240709-fix-ivpu-firmware-metadata-v3-1-55f70bba055b@xanderlent.com>
Content-Language: en-US
From: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20240709-fix-ivpu-firmware-metadata-v3-1-55f70bba055b@xanderlent.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Applied to drm-misc-next

On 09.07.2024 13:54, Alexander F. Lent wrote:
> Modules that load firmware from various paths at runtime must declare
> those paths at compile time, via the MODULE_FIRMWARE macro, so that the
> firmware paths are included in the module's metadata.
> 
> The accel/ivpu driver loads firmware but lacks this metadata,
> preventing dracut from correctly locating firmware files. Fix it.
> 
> Fixes: 9ab43e95f922 ("accel/ivpu: Switch to generation based FW names")
> Fixes: 02d5b0aacd05 ("accel/ivpu: Implement firmware parsing and booting")
> Signed-off-by: Alexander F. Lent <lx@xanderlent.com>
> ---
> Hi Jacek,
> 
> Thanks for catching the error, and for the more succinct comment.
> Please find v3 attached.
> ---
> Changes in v3:
> - Simplify comment, per review.
> - Fix typo in 40xx firmware path, per review.
> - Link to v2: https://lore.kernel.org/r/20240708-fix-ivpu-firmware-metadata-v2-1-78b953172026@xanderlent.com
> 
> Changes in v2:
> - Only annotate the module with the production firmware paths, per review.
> - Drop macros for de-duping firmware fileames, just use string literals, per review.
> - Link to v1: https://lore.kernel.org/r/20240705-fix-ivpu-firmware-metadata-v1-1-704b73852d92@xanderlent.com
> ---
>  drivers/accel/ivpu/ivpu_fw.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/accel/ivpu/ivpu_fw.c b/drivers/accel/ivpu/ivpu_fw.c
> index 1457300828bf..ef717802a3c8 100644
> --- a/drivers/accel/ivpu/ivpu_fw.c
> +++ b/drivers/accel/ivpu/ivpu_fw.c
> @@ -58,6 +58,10 @@ static struct {
>  	{ IVPU_HW_40XX, "intel/vpu/vpu_40xx_v0.0.bin" },
>  };
>  
> +/* Production fw_names from the table above */
> +MODULE_FIRMWARE("intel/vpu/vpu_37xx_v0.0.bin");
> +MODULE_FIRMWARE("intel/vpu/vpu_40xx_v0.0.bin");
> +
>  static int ivpu_fw_request(struct ivpu_device *vdev)
>  {
>  	int ret = -ENOENT;
> 
> ---
> base-commit: 22a40d14b572deb80c0648557f4bd502d7e83826
> change-id: 20240704-fix-ivpu-firmware-metadata-3d02bd60768d
> 
> Best regards,

