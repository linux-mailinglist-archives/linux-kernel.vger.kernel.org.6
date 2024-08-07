Return-Path: <linux-kernel+bounces-277291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F606949EF9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 07:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3400E1F25A8F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 05:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB161917D9;
	Wed,  7 Aug 2024 05:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KjuSWvGE"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3273915CD46
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 05:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723007576; cv=none; b=QW4le49M0ghPvSNt6RE50+wJ1q+UoBzNiyfMawP7oQjoI7vQ13SEFvNT66Mo8bjbEYFhy/aSEuMetXiZGaSvJoBOaxnWxR247gsZxqkPntp2VhdQTE/afUV/xPcV2XQCBHotn+ukUshs7W4iIbOQv/nj//g+6vEKBCIXiWHFDOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723007576; c=relaxed/simple;
	bh=47M41ZpgKe74fHVVAqsjqnphhy3WW8MdGWVa4z+f9kU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=GJm/Sdt5JqgvHs+ghjrAB/EJawVFHuC6ixyi/IBO7ITm6MqfAvwXcARM3m3i0O2IcPoIRVxmxmeUVx3ZbDMqPwW/7qY1E2JDFqJ4eOULKIjrtzM9H+gc+k7YAW/+v4+0u2h39flLRzp4P1kDo4fx8GnLEV96N4+bc6C+5MgdTlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KjuSWvGE; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3db1270da60so866344b6e.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 22:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723007574; x=1723612374; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=254hNr+AlmH4fbC99LCC9/G5WWPfXEbuSKUu4ia96tw=;
        b=KjuSWvGErhx/l+r/09sMXMcZDktqUGOvWMdL4y8sTKjIUbQq1eRUZoHlMPO0R9P3x2
         FQ6GMDoZGCEegSGsVqEd48ofBAQHoflJre6msP/Gv0/ab31D58M3UUiliLOsOKNfE23T
         ilx8vhO9wIimJAAgKgT3xH94eeSAVLfZmzY1PTZh2dCFO8ANEhuzCvXO7UtC4wS2Ll62
         rbImXUrGKOrsADmhFmLYSjQ8S3FdeiE39pzzjMeCBQdDM0ba29G7EC/DHgsYLXxjGt6u
         jnQvNUiyFoSjS0tIGmFMKOvgIjJ6LbHgxjgzlKyljKIW15uxdH40KdfzQOk9nE3bIngy
         rxlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723007574; x=1723612374;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=254hNr+AlmH4fbC99LCC9/G5WWPfXEbuSKUu4ia96tw=;
        b=Gni++pNAj2l4SJ+XGKNBAPVHoRrxMT3PUoq5vYvwYUv4vSRMtOzFUQql/tDHB2fGZf
         FAtXaMcAp1xBgc+odp0SKxnGsHv7BfgmSyVaXChnUQ+r8joBCHeUy6ghRaTsyRpp+PSC
         Rv2enGVbzJPUPVHdEz3CcYoCM9oo5649sJyppCAibVDZAfpA68kOUSHCxV0RpK8yUnYE
         jTcMB6cnBla2rhY4kLk5v+Zckf1s6c7Ga9bAl0lsY5mqq+FZhTXtMTc9R9q2o3O7MJ7k
         zTd+WJweJ6sO56UsxsdnZflWIL/phm//tHySArSi1EkNdlxwPyZuNOh3+woWw2n+kkU9
         uBog==
X-Forwarded-Encrypted: i=1; AJvYcCUzmaGpDdhC87Yt3YcxhIT1Xm/aRf/KV/aW6PFQebGyRPTiloiaQ02wr9r/69C0ZMNXgsfVFs6iINptppXbgOJGPTTGGR8sdGc5Ugb6
X-Gm-Message-State: AOJu0Yw967VJOkDXBfQJsKjvClWAfZYssslCnmsXS/ZgcZtEwI7mcvsn
	bTdJ7Ms+5WuDAbIiZ26Sq67ogiO1gWYNd6F7KlSJI06MNKDEerHk
X-Google-Smtp-Source: AGHT+IHsGE2Gqqynq+6RB9KgLdBUb3AeqpLjWYxTUHEg4xrx7XPUiigIdk4xS+85INI0KofIJvznXQ==
X-Received: by 2002:a05:6870:b025:b0:25e:24b:e65b with SMTP id 586e51a60fabf-26891f23fc9mr22074023fac.42.1723007574242;
        Tue, 06 Aug 2024 22:12:54 -0700 (PDT)
Received: from [192.168.10.4] ([43.224.156.13])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7b764fb5671sm7644493a12.64.2024.08.06.22.12.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 22:12:53 -0700 (PDT)
Message-ID: <14e9aefb-88d1-4eee-8288-ef15d4a9b059@gmail.com>
Date: Wed, 7 Aug 2024 10:42:49 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
From: Harith George <mail2hgg@gmail.com>
Subject: [build fail] v6.11-rc2 from "ARM: 9404/1: arm32: enable
 HAVE_LD_DEAD_CODE_DATA_ELIMINATION"
To: liuyuntao12@huawei.com, arnd@arndb.de, linus.walleij@linaro.org,
 rmk+kernel@armlinux.org.uk, ardb@kernel.org, harith.g@alifsemi.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I am seeing a regression in "make xipImage" builds in mainline tree 
v6.11-rc2  with LD segmentation fault.

$ make V=1 xipImage
...
+ arm-poky-linux-musleabi-ld -EL -z noexecstack --no-undefined -X 
--pic-veneer -z norelro --build-id=sha1 --orphan-handling=warn 
--script=./arch/arm/kernel/vmlinux.lds -o vmlinux --whole-archive 
vmlinux.a init/version-timestamp.o --no-whole-archive --start-group 
arch/arm/lib/lib.a lib/lib.a --end-group
scripts/link-vmlinux.sh: line 49: 3371164 Segmentation fault      (core 
dumped) ${ld} ${ldflags} -o ${output} ${wl}--whole-archive ${objs} 
${wl}--no-whole-archive ${wl}--start-group ${libs} ${wl}--end-group 
${kallsymso} ${btf_vmlinux_bin_o} ${ldlibs}
make[2]: *** [scripts/Makefile.vmlinux:34: vmlinux] Error 139
make[2]: *** Deleting file 'vmlinux'
make[1]: *** [/home/amol/hgg/mainline/linux/Makefile:1156: vmlinux] Error 2
make: *** [Makefile:224: __sub-make] Error 2

git bisect pointed to ed0f941022515ff40473("ARM: 9404/1: arm32: enable 
HAVE_LD_DEAD_CODE_DATA_ELIMINATION")

"CONFIG_HAVE_LD_DEAD_CODE_DATA_ELIMINATION=y" is getting set with the 
commit in my .config.
But, my .config is _not_ enabling the "LD_DEAD_CODE_DATA_ELIMINATION" flag.

Reverting commit ed0f94102251, resolves the linking fail.
Infact, reverting just the ".reloc  .text, R_ARM_NONE, ." additions in 
arch/arm/kernel/entry-armv.S resolves the linking fail.

My toolchain is
arm-poky-linux-musleabi-gcc (GCC) 9.2.0
GNU ld (GNU Binutils) 2.32.0.20190204

I am working on a new platform. Hence my .config/code has other platform 
related additions which would not make sense on current mainline, which 
is why I have not added it here. Do let me know if you would still like 
to have the .config file.


Thanks,
Warm Regards,
Harith




