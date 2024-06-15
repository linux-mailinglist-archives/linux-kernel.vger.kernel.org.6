Return-Path: <linux-kernel+bounces-216023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B16DC909A08
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 23:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21D1E1F2165A
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 21:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B807A61FEB;
	Sat, 15 Jun 2024 21:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hEvdr7h5"
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6D21CA94
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 21:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718487712; cv=none; b=pIfDTsT/EkFxnb/Zx0EFOkrhu+h2TrfnBnYKsjDP5HCgKcUIgfYr8stgRtKx3n8X28djELYLxsmynB6Lz4OAZSZM65Dx3TCqVpTRPRPfMO3jKOyIbDc9YwVMmRBmECd6XkRZpKuVw8sLGAIPiupO0uOuy79olKVdc9UVsybqyQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718487712; c=relaxed/simple;
	bh=XS1BRZN1SjBQqYx8cKsHHYq7gvoU3NEtzp4uXV72Gsk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eKEa4VxqgBb/TMVwjQedzOi7XBtDVt8WMZ0pqtF6s7T0AdcULN/ADDdbwxkT5tVRrBS+bqBsAxy+IIw7jDUJSTO34FFRGsGetS18pDdn/Bh4yRhLBRCKabZqHWQ+PxsUyjhn0bjZv+yJYpWOuNQFgb4/6TmfAXISM42WzG26sXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hEvdr7h5; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5b9a5be6668so1709743eaf.1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 14:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1718487710; x=1719092510; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=T5ucE0W5TgTryjSxB4HJKh3yQO0XyVzTKVYePiu3SYU=;
        b=hEvdr7h59dSV2WxkvegcnKSi7lh8OyFROTTYNYYT9ej3ILwpC5f/ByXcmq0IWGlJ+V
         F+2YkpJi3gRxRhcixEeahfPuTF9X6QqR43hLKBtIIf6X5oFl9CP9ILU/FGMAFl2Oq6Fp
         0/QXK7o47bn/1tMmxDQ4T3hPrkUh5q3/xHtXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718487710; x=1719092510;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T5ucE0W5TgTryjSxB4HJKh3yQO0XyVzTKVYePiu3SYU=;
        b=ZkN84RvZD0f4tvRr4s9Hl8Lr/waue/sihi3lI8OKONjqzx2wfivljB0YCx/cqE0INq
         a/DpZD6BWc4qu3T0J2V0pbC1C3TtYKmg1zqH0bXnB8pSdMSsvrROI/zoo5FYf5/e0s8G
         c8xaQ8c1LRp+qNL6yzYt07WEh0q4E0pN2gNnesyUpu4PFlQoCgC8IsJ4mM6hsti3HCE3
         hyxNy3PWgHUDj/WnX9hgRrMeIhTnqiDOApaSCHZ7YGM5SsXLxEM5Qf9XHZiARo8WYRop
         Hp5KlvPskakoyCq/ndw0ZoXNuxsx5VBpsorq32P7fwBZzXoX1H10dLwZ5W/w7M9DmQ1l
         6gsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQ8/Sa9eyONpSP9NyBMPmM8ebcG33uaEFnmIGXm2prrYOhb1lsXH6V53zPEahozG10ql2Oh6Oxdla8JKerqV1FbbkQzkBT3BljQ+Yf
X-Gm-Message-State: AOJu0YzjkroZCv74rYsDJ7T0fCqZOmTVDTZtY/ihmCCAjXRyY1oFal7G
	k2KLj48AKMkjaVf3EQMBIooSVuxwO/7Issj6XAiU3Fm/bjgqog0fSdyRcxagFAoAh7Hz5Vg5ypQ
	=
X-Google-Smtp-Source: AGHT+IFoDRGbZRhAmMsNK5qfCiBeSc9/VPI+7uFmZyY6h4XyY+k/1XfZY+EzFO1TxwRhAVkawVWeSA==
X-Received: by 2002:a05:6358:6f06:b0:197:df0e:f23c with SMTP id e5c5f4694b2df-19fa9de65dcmr819174555d.11.1718487710046;
        Sat, 15 Jun 2024 14:41:50 -0700 (PDT)
Received: from [192.168.0.212] ([50.35.46.55])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c4c45ac600sm6330432a91.5.2024.06.15.14.41.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Jun 2024 14:41:49 -0700 (PDT)
Message-ID: <ed6e1387-3d8c-4ebc-b8e0-f8fbfc4d00c3@broadcom.com>
Date: Sat, 15 Jun 2024 14:41:47 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [tip:x86/vmware 4/8] vmwgfx_msg.c:undefined reference to
 `vmware_hypercall_slow'
To: Borislav Petkov <bp@alien8.de>, kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
 x86@kernel.org
References: <202406152104.FxakP1MB-lkp@intel.com>
 <20240615143344.GDZm2mSB-qyB0Vt28Q@fat_crate.local>
Content-Language: en-US
From: Alexey Makhalov <alexey.makhalov@broadcom.com>
Autocrypt: addr=alexey.makhalov@broadcom.com; keydata=
 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 EuY0
In-Reply-To: <20240615143344.GDZm2mSB-qyB0Vt28Q@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

SPI warnings/errors are introduced by commit e77603d5468b90 ("iio: dac: 
support the ad9739a RF DAC")

On 6/15/24 7:33 AM, Borislav Petkov wrote:
> On Sat, Jun 15, 2024 at 09:22:00PM +0800, kernel test robot wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/vmware
>> head:   ef08e7dc21307b226b5280d5e8cfea687bfd2866
>> commit: e5ac9008b79c59235c34494e555419665022f5e1 [4/8] drm/vmwgfx: Use VMware hypercall API
>> config: i386-buildonly-randconfig-002-20240615 (https://download.01.org/0day-ci/archive/20240615/202406152104.FxakP1MB-lkp@intel.com/config)
>> compiler: gcc-9 (Ubuntu 9.5.0-4ubuntu2) 9.5.0
>> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240615/202406152104.FxakP1MB-lkp@intel.com/reproduce)
>>
>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <lkp@intel.com>
>> | Closes: https://lore.kernel.org/oe-kbuild-all/202406152104.FxakP1MB-lkp@intel.com/
>>
>> All errors (new ones prefixed by >>):
>>
>>     ld: drivers/gpu/drm/vmwgfx/vmwgfx_msg.o: in function `vmw_open_channel.constprop.0':
>>>> vmwgfx_msg.c:(.text+0x203): undefined reference to `vmware_hypercall_slow'
>>     ld: drivers/gpu/drm/vmwgfx/vmwgfx_msg.o: in function `vmw_recv_msg':
>>     vmwgfx_msg.c:(.text+0x46f): undefined reference to `vmware_hypercall_slow'
>>>> ld: vmwgfx_msg.c:(.text+0x49c): undefined reference to `vmware_hypercall_slow'
>>     ld: vmwgfx_msg.c:(.text+0x4c3): undefined reference to `vmware_hypercall_slow'
>>     ld: drivers/gpu/drm/vmwgfx/vmwgfx_msg.o: in function `vmw_close_channel':
>>     vmwgfx_msg.c:(.text+0x580): undefined reference to `vmware_hypercall_slow'
>>     ld: drivers/gpu/drm/vmwgfx/vmwgfx_msg.o:vmwgfx_msg.c:(.text+0x729): more undefined references to `vmware_hypercall_slow' follow
>>     ld: drivers/base/regmap/regmap-spi.o: in function `regmap_spi_read':
>>     regmap-spi.c:(.text+0xf): undefined reference to `spi_write_then_read'
>>     ld: drivers/base/regmap/regmap-spi.o: in function `regmap_spi_gather_write':
>>     regmap-spi.c:(.text+0x2b4): undefined reference to `spi_sync'
>>     ld: drivers/base/regmap/regmap-spi.o: in function `spi_sync_transfer.constprop.0':
>>     regmap-spi.c:(.text+0x337): undefined reference to `spi_sync'
>>     ld: drivers/base/regmap/regmap-spi.o: in function `regmap_spi_async_write':
>>     regmap-spi.c:(.text+0x445): undefined reference to `spi_async'
>>     ld: drivers/iio/dac/ad9739a.o: in function `ad9739a_driver_init':
>>     ad9739a.c:(.init.text+0x10): undefined reference to `__spi_register_driver'
>>
>> Kconfig warnings: (for reference only)
>>     WARNING: unmet direct dependencies detected for REGMAP_SPI
>>     Depends on [n]: SPI [=n]
>>     Selected by [y]:
>>     - AD9739A [=y] && IIO [=y] && (SPI [=n] || COMPILE_TEST [=y])
>>
>> -- 
> 
> Zapping tip:x86/vmware from the tip/master lineup for the time being, until this
> is fixed.
> 
> Thx 0day guys for reporting.
> 

