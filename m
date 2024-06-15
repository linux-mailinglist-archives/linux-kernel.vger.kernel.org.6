Return-Path: <linux-kernel+bounces-216011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0F59099E6
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 22:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6586F1F21E6A
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 20:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089C11773A;
	Sat, 15 Jun 2024 20:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GgV/0WqU"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD492629C
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 20:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718484079; cv=none; b=IHbHDDygAGPqNuyDmt295JjyLnD0UJ//DR7tcN3mlTVX/b2JCCbB1RXP/Uar02P6OGhaNrerR2CtQQ6Dngfkk5Silmn7b8UzR2MvptViREHgwezpuAZcikXAd7N+MLzYmZqQTn+/6IEYqI0r8xWs+pFKbsHg4hq7DzCCd7KzlGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718484079; c=relaxed/simple;
	bh=41/OChH0rngz/yclsHybbNmGkPUMEbh5tsSA3lPC0ok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ub7pvWQj2l3QCV3F5B161O7r2ZiPd+c7NAzxkNqze7Vq17zs9qvmGSTWQbsKkhyDZkl947XYCh8lJU8AnTA2A+aiqgE0aNZImp5xPnlEOhOPO1J6+oLqNJrMo8pP48u89jmZtPf6dsrOXmgS6qPlhJu4/Ge5nGkGDsjK3rBE1h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GgV/0WqU; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7042a8ad9f5so2840369b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 13:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1718484077; x=1719088877; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NyfSuUkK9NXU2IrSjh8qgcwbYQ1cIHDSzfqUIvRuMUU=;
        b=GgV/0WqUPf2ccM3VxiQj3jnYXdVol2/MKvpvn+V0a11JrhcfCx9GKyj40gdPfbYI0i
         HOAXC+jDQ9Fz3LL4UzcOCLiG/wD2/vg7I/bGsPgS0ddy2g+CgoCdPDLUpjbyA54XmJ/1
         cZ1N1aZJHuB2X3XfyvP3FlG4VIdtyBdnL/huI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718484077; x=1719088877;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NyfSuUkK9NXU2IrSjh8qgcwbYQ1cIHDSzfqUIvRuMUU=;
        b=nbJYgQ2WgV3p2CnXnpZS/SB9QpuQfbCaetn03dmV7xtF9MbX/6o4z7XvN/+jcbXNiL
         eh8vira8spmCt69DWW0sf6yLzWpgriYYGS/xebSFbWUB+vFOSGdwocH7SwOjWCdYDXCm
         qb7r3p5pOF5q9QrsWRJAAKV6vEnj20PK25zXCUY5yksaRwKynYZwlHxcdjj2Ox6PCN4S
         JTuvdxGNYQAXPUxbaRP6IOkahdJDp4zYXBXXbxZftxGsxiH7S8Cr92KKc3mV7wM77U+/
         FoVWjAD4osbGlNZODPL9r0c42iP1aphBbWIdi5R879Dbvib3X+Iv0cbnDp9PtM5mPFty
         DgkQ==
X-Forwarded-Encrypted: i=1; AJvYcCULjxhYAKJtRrv2TptVAipDYmxELJIxAWLadYHKJmWrOqax1Pmv7IVcTLDOvOhOmny0mgjApscoldEFor/8vYUqFKc6fqSd0CvgOcpz
X-Gm-Message-State: AOJu0YyjSt3UmvlVXj0fp/8ah6crSJi6MFGsgmsFZML++J76PeRKLOFZ
	86Op4GF5qBh0jZzYVoDWljoCHgYc3lDjYe6A33yWfGjMyMwN0joaB7DApT4EwO8Ust00lhaZNDg
	=
X-Google-Smtp-Source: AGHT+IF+7A+KVLHOiMRbHsDYWc+FMlLvRmcXJ0M26QAAWNC8lbV4d7s/ByARHqsa9Fq4biYYbN8a5w==
X-Received: by 2002:a05:6a21:19f:b0:1b8:5967:45cd with SMTP id adf61e73a8af0-1bae7e7a23bmr9501831637.13.1718484076743;
        Sat, 15 Jun 2024 13:41:16 -0700 (PDT)
Received: from [192.168.0.212] ([50.35.46.55])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705cc96ce30sm5047610b3a.79.2024.06.15.13.41.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Jun 2024 13:41:16 -0700 (PDT)
Message-ID: <327b5f58-441a-434e-ac07-615ba9a1e3f2@broadcom.com>
Date: Sat, 15 Jun 2024 13:41:14 -0700
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

Thanks for the report and provided .config file.

The problem with DRM_VMWGFX=y when HYPERVISOR_GUEST is not set, i.e 
arch/x86/kernel/cpu/vmware.c is not built.
It is even a problem today. For VMWARE_HYPERCALL alternative to work, 
vmware guest code must set cpu capabilities properly.
The kernel based on the current config file will not work on a SEV-ES 
enabled machine.
DRM_VMWGFX must depend on HYPERVISOR_GUEST similarly to VMWARE_BALLOON, 
MOUSE_PS2_VMMOUSE and
PTP_1588_CLOCK_VMW.

Borislav, I'm going to send a fix shortly. It has to be applied before 
this patchset.

Thanks,
--Alexey

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

