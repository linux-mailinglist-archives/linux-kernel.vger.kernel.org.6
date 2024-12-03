Return-Path: <linux-kernel+bounces-429024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E7D59E182E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 10:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5E1BB24050
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 08:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2D11DE2B5;
	Tue,  3 Dec 2024 08:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L2YR/bTr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6477718A6BC
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 08:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733216228; cv=none; b=QEK4mPbPRsyT36dv/GSaW2OosigUkMsJUXzQ3LXD+gbYeW+CFCzdWU82Uzj87EwEnL533qP55pX5ktiEPG9ZWdiw+cntHi4vtnIRcO0qeotBr4PXZJC0aOdGojiTFauQJFJmy3xBjrZjDrtGr9WvGCuIU7UeodhbRw4VGcbuLKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733216228; c=relaxed/simple;
	bh=OOceX6kz0XXbimZbAprvOOOhYfdQDD8f85dFSF0Tppg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YtG9aduwLImB4VNyJUR/ywrAOTKq7qnwtcGlNtCHfpb02S7Wr5DyUy3m/PEP65Ml9H5ePeiylarlnx/Af9zVV0YtnjPopp5Bx18ZkSGJFFWAS6O32oeDAYXtKX4xs6rJ50FTmpr2zVYrL4/c7PoHMxcWXpYIN2Q7DDTu4Z1V7y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L2YR/bTr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733216225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FGHz7ghiBxVIbssf5/hQmDMUZC5ROBwA/LtGFN8UTlY=;
	b=L2YR/bTr50036YLMzv/6VnzsYYxfAv3Ow1r8VDzAYjY8exbJ0XTkVlIMnMb2ZL/FvdwG16
	+XEZOnOcoUKAZFkuO9jQDxWbCNoXM1JtnXsQ6IrZUUGk7GbsDQ9iVBJQb4130JHBADQUwZ
	wqwxlwsP8/SrfqFK/Wtusq4zSQ5sKko=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-bNOwHLQfN62x5VR2LJ22xA-1; Tue, 03 Dec 2024 03:57:03 -0500
X-MC-Unique: bNOwHLQfN62x5VR2LJ22xA-1
X-Mimecast-MFC-AGG-ID: bNOwHLQfN62x5VR2LJ22xA
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ee3c572485so6153944a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 00:57:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733216222; x=1733821022;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FGHz7ghiBxVIbssf5/hQmDMUZC5ROBwA/LtGFN8UTlY=;
        b=wXhia39n74C7sugH3yi3MqU+Cxl33aRBuUwlS/OTpKK9Xhq2FgurP1S2ux4X7k8uU8
         l0w0XQ3F4mBbHZqPsd3xCdqHg0b1D0PFb0ElX6Z2camJ2Wh6Ivdpa9dUVBHRi+n+k27+
         sllYCar/X3K9WyGEO+A63sPIeEMg9XycI9G9A5hbS8Hp/gAadYNIvj0HhtVmPm7JWvEg
         +AUWswCTEdlOw8dfEq5B/6xv1SKa34oFV8kSmx9PslfrlVOsQQ/37tIELaJEQltoQ+7r
         f4WyCQEmSahWFhrGfeiTl2CX/mhYqYg9ObPzUySHsC39rKZ1Jrzx1raQFFt55IPkJp0Z
         5Tbg==
X-Forwarded-Encrypted: i=1; AJvYcCXm+Yr7XI3xdYaXilqDnZV60HjYeaP/lThCYUV9uutRpz6rt/hhWzXE03Y27no7giiTW2xhX2ZKbQhjcfM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLsPL7WurBdkWFjGM493mDUtnZGHmzbuX+K1pD4mxKMnwaF4IJ
	akxqYK2BdQhkDPaNeisAi4TR94THG+WjRJafMAszXlEvsR/C2XlcFuzpspWjhSpAfwd2XyUF/HP
	fe+FZ0+wP4kGlBIERemcZW+tf3du/HczGKhd/qZDe4iCe7Vd5xTVSAQfFbjZa2w==
X-Gm-Gg: ASbGnctdm4rq7O4hiJIdzpvIBdmP8oookMmcNd0z7SmM6zvdHIdksnNTG7J+gGcTIMi
	Ya135HLamAPJJF7F5GBNqIYCtBXX+GpgBFnCDYKoV0/f0iBaisx35f4vPmiOfnuM4bQZTILIf5J
	oMFMdkE5wTnhfgVrWCOW+NMtYF2h38Z0OLhBmlkZG+dPu3PY/zztQ3HiDkBAOOEwrMJ4j6GE1UB
	Qq8EtW5Hs02hfEpy4l1WT4S+MfnQ6URtsObhLdSHbjDDuNVn/c=
X-Received: by 2002:a17:90b:33c6:b0:2ee:ee77:2263 with SMTP id 98e67ed59e1d1-2ef011e4926mr2503888a91.7.1733216222616;
        Tue, 03 Dec 2024 00:57:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEIcOl4s6XHMdDXHxmOpeH3xZ9kLRLW+50zloAvOHAMK7Z7v1F6jBYhjBcR7dhJA5/1Z8PpzQ==
X-Received: by 2002:a17:90b:33c6:b0:2ee:ee77:2263 with SMTP id 98e67ed59e1d1-2ef011e4926mr2503625a91.7.1733216215342;
        Tue, 03 Dec 2024 00:56:55 -0800 (PST)
Received: from [10.72.112.157] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2eead160674sm4605513a91.3.2024.12.03.00.56.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 00:56:54 -0800 (PST)
Message-ID: <b1923d68-726a-4864-8661-54588a634d95@redhat.com>
Date: Tue, 3 Dec 2024 18:56:49 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] arm64: rsi: Add automatic arm-cca-guest module
 loading
To: kernel test robot <lkp@intel.com>, Jeremy Linton <jeremy.linton@arm.com>,
 linux-arm-kernel@lists.infradead.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 steven.price@arm.com, sami.mujawar@arm.com, suzuki.poulose@arm.com,
 will@kernel.org, catalin.marinas@arm.com, linux-kernel@vger.kernel.org
References: <20241203000156.72451-2-jeremy.linton@arm.com>
 <202412031348.bp5i3ws2-lkp@intel.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <202412031348.bp5i3ws2-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/3/24 4:03 PM, kernel test robot wrote:
> Hi Jeremy,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on arm64/for-next/core]
> [also build test WARNING on linus/master v6.13-rc1 next-20241128]
> [cannot apply to kvmarm/next soc/for-next arm/for-next arm/fixes]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Jeremy-Linton/arm64-rsi-Add-automatic-arm-cca-guest-module-loading/20241203-080347
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
> patch link:    https://lore.kernel.org/r/20241203000156.72451-2-jeremy.linton%40arm.com
> patch subject: [PATCH v2 1/1] arm64: rsi: Add automatic arm-cca-guest module loading
> config: arm64-randconfig-004-20241203 (https://download.01.org/0day-ci/archive/20241203/202412031348.bp5i3ws2-lkp@intel.com/config)
> compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 592c0fe55f6d9a811028b5f3507be91458ab2713)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241203/202412031348.bp5i3ws2-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202412031348.bp5i3ws2-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>>> drivers/virt/coco/arm-cca-guest/arm-cca-guest.c:224:21: warning: attribute declaration must precede definition [-Wignored-attributes]
>       224 | static const struct __maybe_unused platform_device_id arm_cca_match[] = {
>           |                     ^
>     include/linux/compiler_attributes.h:356:56: note: expanded from macro '__maybe_unused'
>       356 | #define __maybe_unused                  __attribute__((__unused__))
>           |                                                        ^
>     include/linux/mod_devicetable.h:607:8: note: previous definition is here
>       607 | struct platform_device_id {
>           |        ^
>>> drivers/virt/coco/arm-cca-guest/arm-cca-guest.c:224:55: warning: unused variable 'arm_cca_match' [-Wunused-const-variable]
>       224 | static const struct __maybe_unused platform_device_id arm_cca_match[] = {
>           |                                                       ^~~~~~~~~~~~~
>     2 warnings generated.
> 
> 
> vim +224 drivers/virt/coco/arm-cca-guest/arm-cca-guest.c
> 
>     222	
>     223	/* modalias, so userspace can autoload this module when RSI is available */
>   > 224	static const struct __maybe_unused platform_device_id arm_cca_match[] = {
>     225		{ RSI_PDEV_NAME, 0},
>     226		{ }
>     227	};
>     228	
> 

The definition may have to be something like below, to avoid the compiling warning.

static const struct platform_device_id __maybe_unused arm_cca_match[] = {
        ...
};

Thanks,
Gavin


