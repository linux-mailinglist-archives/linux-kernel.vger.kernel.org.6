Return-Path: <linux-kernel+bounces-429751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D1E9E22F8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 16:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39399283F31
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 15:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459241F7540;
	Tue,  3 Dec 2024 15:30:52 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994501F756A
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 15:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733239851; cv=none; b=BmEMKycP2jE/oFpwPn8dpc2T/zVgBKLKcho2eQrunPEULK3GysR5PKTDmlYmFjqmeQqRd/Dlz54gZTqoU/wCl2LImUoD1OR0rqbxX2Y3A+cDoz4yJ/F4DOfGoduXT8K7BOh5c0tOh2wTw646V80H4STWA9A3ZxCi1Pt5WHzVHf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733239851; c=relaxed/simple;
	bh=sWHs7nX7SOc89lcoKsFsoe9Ki9Vx7/l7ucI/NQ4jw1Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mmQtg0DZEMStCw02h38Am16/5VoXiJKdJfQjAvy+u0Lv9XJbgvc+GM+913ZQgzu/2DuUp8KM14SjI45KIHrSuJZnpKXTKRUIjnX8+f4L6ry15XkJB1yII3vEDye9kZM7SHQ5Wdz6HxMAtuKliXr8OHOARNkoKd5sGTFLeH23quc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB204FEC;
	Tue,  3 Dec 2024 07:31:15 -0800 (PST)
Received: from [192.168.20.16] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 26B2B3F71E;
	Tue,  3 Dec 2024 07:30:44 -0800 (PST)
Message-ID: <a64a21cc-6d10-4e8f-9ab9-87aca44ca858@arm.com>
Date: Tue, 3 Dec 2024 09:30:43 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] arm64: rsi: Add automatic arm-cca-guest module
 loading
To: Gavin Shan <gshan@redhat.com>, kernel test robot <lkp@intel.com>,
 linux-arm-kernel@lists.infradead.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 steven.price@arm.com, sami.mujawar@arm.com, suzuki.poulose@arm.com,
 will@kernel.org, catalin.marinas@arm.com, linux-kernel@vger.kernel.org
References: <20241203000156.72451-2-jeremy.linton@arm.com>
 <202412031348.bp5i3ws2-lkp@intel.com>
 <b1923d68-726a-4864-8661-54588a634d95@redhat.com>
Content-Language: en-US
From: Jeremy Linton <jeremy.linton@arm.com>
In-Reply-To: <b1923d68-726a-4864-8661-54588a634d95@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/3/24 2:56 AM, Gavin Shan wrote:
> 
> 
> On 12/3/24 4:03 PM, kernel test robot wrote:
>> Hi Jeremy,
>>
>> kernel test robot noticed the following build warnings:
>>
>> [auto build test WARNING on arm64/for-next/core]
>> [also build test WARNING on linus/master v6.13-rc1 next-20241128]
>> [cannot apply to kvmarm/next soc/for-next arm/for-next arm/fixes]
>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>> And when submitting patch, we suggest to use '--base' as documented in
>> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>>
>> url:    https://github.com/intel-lab-lkp/linux/commits/Jeremy-Linton/ 
>> arm64-rsi-Add-automatic-arm-cca-guest-module-loading/20241203-080347
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/ 
>> linux.git for-next/core
>> patch link:    https://lore.kernel.org/r/20241203000156.72451-2- 
>> jeremy.linton%40arm.com
>> patch subject: [PATCH v2 1/1] arm64: rsi: Add automatic arm-cca-guest 
>> module loading
>> config: arm64-randconfig-004-20241203 (https://download.01.org/0day- 
>> ci/archive/20241203/202412031348.bp5i3ws2-lkp@intel.com/config)
>> compiler: clang version 20.0.0git (https://github.com/llvm/llvm- 
>> project 592c0fe55f6d9a811028b5f3507be91458ab2713)
>> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/ 
>> archive/20241203/202412031348.bp5i3ws2-lkp@intel.com/reproduce)
>>
>> If you fix the issue in a separate patch/commit (i.e. not just a new 
>> version of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <lkp@intel.com>
>> | Closes: https://lore.kernel.org/oe-kbuild-all/202412031348.bp5i3ws2- 
>> lkp@intel.com/
>>
>> All warnings (new ones prefixed by >>):
>>
>>>> drivers/virt/coco/arm-cca-guest/arm-cca-guest.c:224:21: warning: 
>>>> attribute declaration must precede definition [-Wignored-attributes]
>>       224 | static const struct __maybe_unused platform_device_id 
>> arm_cca_match[] = {
>>           |                     ^
>>     include/linux/compiler_attributes.h:356:56: note: expanded from 
>> macro '__maybe_unused'
>>       356 | #define __maybe_unused                  
>> __attribute__((__unused__))
>>           |                                                        ^
>>     include/linux/mod_devicetable.h:607:8: note: previous definition 
>> is here
>>       607 | struct platform_device_id {
>>           |        ^
>>>> drivers/virt/coco/arm-cca-guest/arm-cca-guest.c:224:55: warning: 
>>>> unused variable 'arm_cca_match' [-Wunused-const-variable]
>>       224 | static const struct __maybe_unused platform_device_id 
>> arm_cca_match[] = {
>>           |                                                       
>> ^~~~~~~~~~~~~
>>     2 warnings generated.
>>
>>
>> vim +224 drivers/virt/coco/arm-cca-guest/arm-cca-guest.c
>>
>>     222
>>     223    /* modalias, so userspace can autoload this module when RSI 
>> is available */
>>   > 224    static const struct __maybe_unused platform_device_id 
>> arm_cca_match[] = {
>>     225        { RSI_PDEV_NAME, 0},
>>     226        { }
>>     227    };
>>     228
>>
> 
> The definition may have to be something like below, to avoid the 
> compiling warning.
> 
> static const struct platform_device_id __maybe_unused arm_cca_match[] = {

I should have tested this with clang rather than copy/pasting the 
utilization from somewhere else! It looks like a number of other kernel 
users are putting it before the '=', but its sorta annoying because it 
seems like the kind of warning that should be suppressed globally for 
this case (module device description in module that can be built in).



>         ...
> };
> 
> Thanks,
> Gavin
> 


