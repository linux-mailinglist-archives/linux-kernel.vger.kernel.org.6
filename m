Return-Path: <linux-kernel+bounces-536171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D58AA47C5F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:39:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88C1B3A886B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 11:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7BD22B5AA;
	Thu, 27 Feb 2025 11:38:58 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.213])
	by smtp.subspace.kernel.org (Postfix) with SMTP id B3577225768;
	Thu, 27 Feb 2025 11:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740656338; cv=none; b=ecWp0SPgXerDK6+J9aqXJxvsEO4SJEjekRdSeCWSoU02K+CC5cQ2WsFmo30K6zK9bPxt5wsCLjtauFR7sTS/i9eF+XzVGmFKBFSd0fFBI8kc4HoH3Iqr0GuHlrhYiIzpfo3PivwLiJracAz5729FlKhkr9k0hggxBC/nl9PLoF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740656338; c=relaxed/simple;
	bh=RX1PWw/7Ty35sZsMyI8sJW7Y0t0cSW2gA/03rZtWLl0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type; b=Hv/3oa3igN1MBgNaJmhCO3ZIj7mvSvVOqJuFND0sckMlSTq/VpeZE8uyLa408TzgNXWXQ1AlI3FrIwXxu1/nw6PhuopMWopxlZljnjOILNIk77Jf0bl9/LOxDCQWTcjAgq+n8sVcF+ZHcy1P5tDlsxz3s7SNNvuaSzOoGV8RpVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from [172.30.20.101] (unknown [180.167.10.98])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPSA id 2B7B8609B18F0;
	Thu, 27 Feb 2025 19:38:49 +0800 (CST)
Message-ID: <28f9ca0e-136f-2cd6-0dba-4e3b7d172759@nfschina.com>
Date: Thu, 27 Feb 2025 19:38:48 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH] drm/xe: Select INTEL_VSEC to fix build dependency
Content-Language: en-US
To: Jani Nikula <jani.nikula@linux.intel.com>, lucas.demarchi@intel.com,
 thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch
Cc: ilpo.jarvinen@linux.intel.com, andriy.shevchenko@linux.intel.com,
 michael.j.ruhl@intel.com, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
In-Reply-To: <87senz3br3.fsf@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025/2/27 18:47, Jani Nikula wrote:
> On Thu, 27 Feb 2025, Su Hui <suhui@nfschina.com> wrote:
>> When build randconfig, there is an error:
>> ld: drivers/gpu/drm/xe/xe_vsec.o: in function `xe_vsec_init':
>> xe_vsec.c:(.text+0x182): undefined reference to `intel_vsec_register'
>>
>> When CONFIG_DRM_XE=y and CONFIG_INTEL_VSEC=m is set, ld couldn't find
>> 'intel_vsec_register'. Select INTEL_VSEC to fix this error.
> Documentation/kbuild/kconfig-language.rst:
>
>    Note:
> 	select should be used with care. select will force
> 	a symbol to a value without visiting the dependencies.
> 	By abusing select you are able to select a symbol FOO even
> 	if FOO depends on BAR that is not set.
> 	In general use select only for non-visible symbols
> 	(no prompts anywhere) and for symbols with no dependencies.
> 	That will limit the usefulness but on the other hand avoid
> 	the illegal configurations all over.
>
> This should likely be either
>
> 	depends on INTEL_VSEC || INTEL_VSEC=n
>
> or
>
> 	depends on INTEL_VSEC

Hi, Jani:

I tried to use 'depends on' at first. But there is a recursive dependency:

     error: recursive dependency detected!
         symbol DRM_XE depends on INTEL_VSEC
         symbol INTEL_VSEC depends on X86_PLATFORM_DEVICES
         symbol X86_PLATFORM_DEVICES is selected by DRM_XE
         For a resolution refer to 
Documentation/kbuild/kconfig-language.rst
     subsection "Kconfig recursive dependency limitations".


I will try it again with 'depends on', need some time to check this 
recursive
dependency problem.

Su Hui

>
>
>
>> Fixes: 0c45e76fcc62 ("drm/xe/vsec: Support BMG devices")
>> Signed-off-by: Su Hui <suhui@nfschina.com>
>> ---
>>   drivers/gpu/drm/xe/Kconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/gpu/drm/xe/Kconfig b/drivers/gpu/drm/xe/Kconfig
>> index b51a2bde73e2..7a60d96d2dd6 100644
>> --- a/drivers/gpu/drm/xe/Kconfig
>> +++ b/drivers/gpu/drm/xe/Kconfig
>> @@ -44,6 +44,7 @@ config DRM_XE
>>   	select WANT_DEV_COREDUMP
>>   	select AUXILIARY_BUS
>>   	select HMM_MIRROR
>> +	select INTEL_VSEC
>>   	help
>>   	  Experimental driver for Intel Xe series GPUs

