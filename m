Return-Path: <linux-kernel+bounces-252257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 240059310A7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 10:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85AC8B2330C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 08:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B5B185093;
	Mon, 15 Jul 2024 08:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j3d140dF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47644CDEC
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 08:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721033560; cv=none; b=V6GRHsNrErPcQPLPT/9nABKqIoFOgcLnNhGncC+c0e852ihCpRjVP0EYTIOs8+oPLVX7ez+JTHc/U9zNDNGzU2+84Wh3lUtctaPRsUEGLLjts589yE1S0v9aqZJaMxA61dmV6QEsqP0CzItLOs8wmrCzzg5ULIZAd2klnn4xf+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721033560; c=relaxed/simple;
	bh=l4FdFEWG4RNG+NPOkvNxdL+rwE31rUQQHAk9mqAM9Q8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=p/DSzaNmToaZ3Rz0rQBYvqb3qwOL0JbrZqGD5m+Hx2yHpODPj2opbofyq8KNjotx4zcRgxr8e6HhmpwcEuxOf6BNttltYiYnQHC3bPhzPePGAQ4qdUK5RmBNlIAKi3Q/w0//Crb8ac4XXDyOhRBhMj2CNMrGcG/X4zU5e0bUTdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j3d140dF; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721033559; x=1752569559;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=l4FdFEWG4RNG+NPOkvNxdL+rwE31rUQQHAk9mqAM9Q8=;
  b=j3d140dF810F94p2EpFkhKcegOhjOEC7BxtKUOJUWeaUj+DZYrhHJzwt
   G8y0+e6tbkOn3Xh1039CcUa0CrWh6P1yTF4ANlT+MJ9n8iFIvK8iCQHcW
   kPQFstd8SRHIqpcbbjBsmLtmJY9Q8IppP4SE7+idNBvrgjDfgyhBuQjhJ
   SsFnQd4xG9ScIt8vTGIlJNyG4+5NonWGYY7XvMMK46GYbNQw31coi0f5v
   O7gBnCGuSet2/FLwTDXbxpynnCy8YjnLDBpoIOLHawmURxutNUf8bunNt
   oRwLjp5eeDrVnv2zUjiPr656RywWmkKJ4HwY2hbO+u8K2Kd+eJsyWSw40
   g==;
X-CSE-ConnectionGUID: 1B8eEEm/QqSLNqN9UEerEQ==
X-CSE-MsgGUID: w1WvIMt8R5+0+WFizzLr6A==
X-IronPort-AV: E=McAfee;i="6700,10204,11133"; a="18597598"
X-IronPort-AV: E=Sophos;i="6.09,209,1716274800"; 
   d="scan'208";a="18597598"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2024 01:52:37 -0700
X-CSE-ConnectionGUID: 4qvkgtWIQ1O4yX1BjGm7kA==
X-CSE-MsgGUID: nbMlS/uLQti9hpgO7w39Cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,209,1716274800"; 
   d="scan'208";a="50194907"
Received: from jlawryno-mobl.ger.corp.intel.com (HELO [10.246.3.118]) ([10.246.3.118])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2024 01:52:35 -0700
Message-ID: <117fa0e0-5945-44e2-910b-6fd478b32968@linux.intel.com>
Date: Mon, 15 Jul 2024 10:52:32 +0200
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
 Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
 Krystian Pradzynski <krystian.pradzynski@linux.intel.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240709-fix-ivpu-firmware-metadata-v3-1-55f70bba055b@xanderlent.com>
 <35a7963e-e92b-4c73-b03d-a846e93adf5a@linux.intel.com>
 <ZpTgnNxSNbbeEWQ8@phenom.ffwll.local>
Content-Language: en-US
From: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <ZpTgnNxSNbbeEWQ8@phenom.ffwll.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 15.07.2024 10:41, Daniel Vetter wrote:
> On Wed, Jul 10, 2024 at 12:23:06PM +0200, Jacek Lawrynowicz wrote:
>> Reviewed-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
> 
> I'm assuming you'll also apply this one?
> -Sima

Sure

>> On 09.07.2024 13:54, Alexander F. Lent wrote:
>>> Modules that load firmware from various paths at runtime must declare
>>> those paths at compile time, via the MODULE_FIRMWARE macro, so that the
>>> firmware paths are included in the module's metadata.
>>>
>>> The accel/ivpu driver loads firmware but lacks this metadata,
>>> preventing dracut from correctly locating firmware files. Fix it.
>>>
>>> Fixes: 9ab43e95f922 ("accel/ivpu: Switch to generation based FW names")
>>> Fixes: 02d5b0aacd05 ("accel/ivpu: Implement firmware parsing and booting")
>>> Signed-off-by: Alexander F. Lent <lx@xanderlent.com>
>>> ---
>>> Hi Jacek,
>>>
>>> Thanks for catching the error, and for the more succinct comment.
>>> Please find v3 attached.
>>> ---
>>> Changes in v3:
>>> - Simplify comment, per review.
>>> - Fix typo in 40xx firmware path, per review.
>>> - Link to v2: https://lore.kernel.org/r/20240708-fix-ivpu-firmware-metadata-v2-1-78b953172026@xanderlent.com
>>>
>>> Changes in v2:
>>> - Only annotate the module with the production firmware paths, per review.
>>> - Drop macros for de-duping firmware fileames, just use string literals, per review.
>>> - Link to v1: https://lore.kernel.org/r/20240705-fix-ivpu-firmware-metadata-v1-1-704b73852d92@xanderlent.com
>>> ---
>>>  drivers/accel/ivpu/ivpu_fw.c | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>>
>>> diff --git a/drivers/accel/ivpu/ivpu_fw.c b/drivers/accel/ivpu/ivpu_fw.c
>>> index 1457300828bf..ef717802a3c8 100644
>>> --- a/drivers/accel/ivpu/ivpu_fw.c
>>> +++ b/drivers/accel/ivpu/ivpu_fw.c
>>> @@ -58,6 +58,10 @@ static struct {
>>>  	{ IVPU_HW_40XX, "intel/vpu/vpu_40xx_v0.0.bin" },
>>>  };
>>>  
>>> +/* Production fw_names from the table above */
>>> +MODULE_FIRMWARE("intel/vpu/vpu_37xx_v0.0.bin");
>>> +MODULE_FIRMWARE("intel/vpu/vpu_40xx_v0.0.bin");
>>> +
>>>  static int ivpu_fw_request(struct ivpu_device *vdev)
>>>  {
>>>  	int ret = -ENOENT;
>>>
>>> ---
>>> base-commit: 22a40d14b572deb80c0648557f4bd502d7e83826
>>> change-id: 20240704-fix-ivpu-firmware-metadata-3d02bd60768d
>>>
>>> Best regards,
> 

