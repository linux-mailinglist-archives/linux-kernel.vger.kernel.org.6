Return-Path: <linux-kernel+bounces-243985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2285B929D61
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 09:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67BA7B221F5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 07:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFDBC28E0F;
	Mon,  8 Jul 2024 07:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CWHRehCm"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F55A1F932
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 07:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720424584; cv=none; b=Vg/0kDppUDH0q8ogYNFrECNceVseleIMKWGfsilKf3/jsPTelL1J89E1U35oyX/w1S1N037kWyTV9VHf+IejGRrvfn20WSaRXVbet/d46Bo7Z1L9iqKEFV+lSzWPo5DBchC8Rl7nUc//21VOypLBawa/XAD/diSpGje2vsvJ8FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720424584; c=relaxed/simple;
	bh=gR2sv2VYvHGEVJeByiF31fIirAGeTcv2VNhnHXYZaJ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fw8NBghCp4R2a4mQ5tWDo27+FYHGfHjipcwxk2L+iGosPSNRJf0tIIUvlQ786JUVDDMWhp6nQZ7gX8cbvIKBp7O6J6MqTpzJAG5ED4por+yshbIUyReu/FbLlSh93F5Zx1J1+pL3sy8naWXILKqxoqmthIKYmNvMSsA1u032WRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CWHRehCm; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720424583; x=1751960583;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gR2sv2VYvHGEVJeByiF31fIirAGeTcv2VNhnHXYZaJ4=;
  b=CWHRehCm1aVy1LnOr/FlqqrIB9pW0JkEKCVwbt5C25RepNmDWsPqo54e
   srLICCdfnsKwoDleOqSJaiJSAQjuh8csCuJi91qE5MAfDGjyEiT8MeVxm
   b7IEirXMUXUBQ2IVXkbMg3vIAwp5sbpW6OazGLJC+lHUR6L6q5kN/BJZS
   oRp0kAW/6bAappwcbJ9+zHseoY671YKCb11TtnLaW09LiQaWKsD4kmfrx
   jmr3INcmdlbziit1ftpg+cvmiuOOpmLy3x9qm3wSA9Y5MrEviSD+wKIec
   lWagQPgb+RKkVubgjpAkACuTeIhgMsWv72/FxsDXeQ+eJSgnMb+JwCndO
   A==;
X-CSE-ConnectionGUID: MTQ9wl0ETg+hm9yODPXMVQ==
X-CSE-MsgGUID: 8mtOjrnVQLS4c1R2k1bR6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11126"; a="17567054"
X-IronPort-AV: E=Sophos;i="6.09,191,1716274800"; 
   d="scan'208";a="17567054"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 00:43:02 -0700
X-CSE-ConnectionGUID: 8OQH5ZjYQ86Xnc0uG9Baow==
X-CSE-MsgGUID: puA4PV+gSDyj6Xi9BWrIKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,191,1716274800"; 
   d="scan'208";a="47190926"
Received: from jlawryno-mobl.ger.corp.intel.com (HELO [10.246.19.58]) ([10.246.19.58])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 00:42:59 -0700
Message-ID: <832c27d0-a2ec-46df-afcd-be74b8108358@linux.intel.com>
Date: Mon, 8 Jul 2024 09:42:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/ivpu: Add missing MODULE_FIRMWARE metadata
To: "Alexander F. Lent" <lx@xanderlent.com>,
 Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
 Oded Gabbay <ogabbay@kernel.org>, Jeffrey Hugo <quic_jhugo@quicinc.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
 Krystian Pradzynski <krystian.pradzynski@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240705-fix-ivpu-firmware-metadata-v1-1-704b73852d92@xanderlent.com>
Content-Language: en-US
From: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20240705-fix-ivpu-firmware-metadata-v1-1-704b73852d92@xanderlent.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, thanks for the commit.

On 05.07.2024 13:14, Alexander F. Lent wrote:
> Modules that load firmware from various paths at runtime must declare
> those paths at compile time, via the MODULE_FIRMWARE macro, so that the
> firmware paths are included in the module's metadata.
> 
> The accel/ivpu driver loaded firmware but lacked this metadata,
> preventing dracut from correctly locating firmware files.
> 
> Fixes: 9ab43e95f922 ("accel/ivpu: Switch to generation based FW names")
> Fixes: 02d5b0aacd05 ("accel/ivpu: Implement firmware parsing and booting")
> Signed-off-by: Alexander F. Lent <lx@xanderlent.com>
> ---
>  drivers/accel/ivpu/ivpu_fw.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/accel/ivpu/ivpu_fw.c b/drivers/accel/ivpu/ivpu_fw.c
> index 1457300828bf..51792a00b7e3 100644
> --- a/drivers/accel/ivpu/ivpu_fw.c
> +++ b/drivers/accel/ivpu/ivpu_fw.c
> @@ -48,16 +48,26 @@ static char *ivpu_firmware;
>  module_param_named_unsafe(firmware, ivpu_firmware, charp, 0644);
>  MODULE_PARM_DESC(firmware, "NPU firmware binary in /lib/firmware/..");
>  
> +#define IVPU_FW_PATH_37XX_BIN		"vpu_37xx.bin"
> +#define IVPU_FW_PATH_37XX_V0_BIN	"intel/vpu/vpu_37xx_v0.0.bin"
> +#define IVPU_FW_PATH_40XX_BIN		"vpu_40xx.bin"
> +#define IVPU_FW_PATH_40XX_V0_BIN	"intel/vpu/vpu_40xx_v0.0.bin"
> +
>  static struct {
>  	int gen;
>  	const char *name;
>  } fw_names[] = {
> -	{ IVPU_HW_37XX, "vpu_37xx.bin" },
> -	{ IVPU_HW_37XX, "intel/vpu/vpu_37xx_v0.0.bin" },
> -	{ IVPU_HW_40XX, "vpu_40xx.bin" },
> -	{ IVPU_HW_40XX, "intel/vpu/vpu_40xx_v0.0.bin" },
> +	{ IVPU_HW_37XX, IVPU_FW_PATH_37XX_BIN },
> +	{ IVPU_HW_37XX, IVPU_FW_PATH_37XX_V0_BIN },
> +	{ IVPU_HW_40XX, IVPU_FW_PATH_40XX_BIN },
> +	{ IVPU_HW_40XX, IVPU_FW_PATH_40XX_V0_BIN },
>  };
>  
> +MODULE_FIRMWARE(IVPU_FW_PATH_37XX_BIN);
> +MODULE_FIRMWARE(IVPU_FW_PATH_37XX_V0_BIN);
> +MODULE_FIRMWARE(IVPU_FW_PATH_40XX_BIN);
> +MODULE_FIRMWARE(IVPU_FW_PATH_40XX_V0_BIN);
Include only V0 variants, FW names without version are used for development and they wont be included in any distribution.
I would also skip macros and just use literal strings as macros add a lot of lines that don't increase readability.

Regards,
Jacek

