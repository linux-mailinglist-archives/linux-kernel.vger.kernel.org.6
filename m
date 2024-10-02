Return-Path: <linux-kernel+bounces-347255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7E098D02A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 11:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F8141C2166F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 09:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26EE1CBE8F;
	Wed,  2 Oct 2024 09:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="APXNCBOO"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F7314F9F1
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 09:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727861477; cv=none; b=Wte6T6vLhXDFkHnQnqbgM7VJk6f2Ye4szvpdRHEJCKwMt1nzMzbBaLYzhAKnFuVUTltkPR6FirCf38mb2vbsGaFXRHEtTgBtdTeTlrZ8FLth4NeQ+dZIrIKtqfB1N/tQC+g+aL8hOFgeJBhEJkTNAr+D8ufNBmgjE/KDfElQVa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727861477; c=relaxed/simple;
	bh=M/xuWoBxSI6MlUtevTzfsjELo92lZ3E2JYYFJgnbECE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QdK/eFtj07t8bDTuiNQA/dhFuYKWItGejg+Ky3Gx4IPyXi4qZI1QPWiPTcDeZzZBCtNkqrHiNLsuZ6SGdMfbPqD9UIU/U79VZ5iZ7+5Z+tVBiNAirOh87EZ1I0juz83/YnXem8r4MibaKqF5yz69unN4H1SwcRMDNQrtj6qNIWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=APXNCBOO; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7ae3d7222d4so5474933a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 02:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727861475; x=1728466275; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dQsBsaM7dY7aIRNdr4ZfJyn7hQmF6qmQ2WZwZQ+GX/w=;
        b=APXNCBOOD1y+QkLHCS1rE2B6jKX+SZWwP4zVn0fuSZN1IBOr3M0W4usjWjnYi2Cr4n
         U839Jfihbha8zp1xDq8XFNuLAhnELa2pymkDKE2MSZMAkpqm+I6i+OelmB//FhSISYU6
         +56c6s+uQ8FsdrIvdLxu8Fdh4J3fOBVE7/M1mHd+lfRg5QHu5EUWAoIfAw/5toWVPBgb
         uVkT8vwc8UzsP/5B7aw/mmVTRbKP2k47QuGIkQBGYHXchf65jKon99uGkbdhBDZ+FPQk
         yoUf5TbFfgKN/vKAb2NqJ/BM0vWAtvJqk4srgN/YbmV9Xx4oKLFI2OnRGWIQVgd+BAJG
         rfAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727861475; x=1728466275;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dQsBsaM7dY7aIRNdr4ZfJyn7hQmF6qmQ2WZwZQ+GX/w=;
        b=nTmXZQTaJY0pOphoCb20Z738bjbHpf00/20EeSAv46Xqw8AKn8Ftu90cYhK5xrU6U8
         zppXO35IBM/ImFHQsOr3NxfN3s8fG3adK4XoV9ylC8l5m6ei0/Np1kQZVyfEOUQxnDL6
         qwGANtrBlWXV8BdhCIXCRd2tyvQf/0gpvklcvU0anVzvSZhnzrAVmiqv22q54adQMizw
         eYivtjZNHwXC9sCZQxsO+f7GIbFMfOYL6u49OD8zZQb9L/nNeRplsOIoBVgAivE3im1u
         ENYGnLmD/gbcqKa90DR1hbdFbjRXBIcjUD7b4YWTWpsm3wzeuzLvPNEGk8pzWwLN9p1o
         14Xg==
X-Forwarded-Encrypted: i=1; AJvYcCUmx2JEbviJNqd0lycOY1OyYEHWEbNdHp8VnuatmIILD41KMDCSpMmrF/NHoKqJMOn0U32g/DBlf0Y7FO8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5kaOvC21BAl8DRfE9gIISFFNkuFfahwremFEtqyoXizDDnSQQ
	GuP0/W5i2kmlBFoEHdYdQUm5LqkPBc9a5cTdSMhQPct+FV9bu3RC
X-Google-Smtp-Source: AGHT+IH5QNtkscMqNw5g/0G2sojvD2apcNrSZcMxWxllmBxurgwHCUxP5arW/tkzDpRzIEITNovzwA==
X-Received: by 2002:a05:6a20:d70a:b0:1d5:2d6d:1614 with SMTP id adf61e73a8af0-1d5db176d1dmr4460719637.23.1727861474641;
        Wed, 02 Oct 2024 02:31:14 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:59b3:a140:3cbe:62fc])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b26498c2dsm9447717b3a.27.2024.10.02.02.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 02:31:14 -0700 (PDT)
Date: Wed, 2 Oct 2024 02:31:11 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>,
	Javier Martinez Canillas <javierm@redhat.com>
Subject: Re: drivers/input/touchscreen/cyttsp_i2c.c:47:18: error: implicit
 declaration of function 'i2c_transfer'
Message-ID: <Zv0S3wXOzgmyFP3x@google.com>
References: <202410020735.aBI61ZYn-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202410020735.aBI61ZYn-lkp@intel.com>

On Wed, Oct 02, 2024 at 08:03:35AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   e32cde8d2bd7d251a8f9b434143977ddf13dcec6
> commit: 25162a4f64f8ba0065f300977589fe1f6af332f0 Input: cyttsp4 - remove driver
> date:   8 weeks ago
> config: x86_64-randconfig-001-20231120 (https://download.01.org/0day-ci/archive/20241002/202410020735.aBI61ZYn-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241002/202410020735.aBI61ZYn-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202410020735.aBI61ZYn-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from include/linux/sched.h:38,
>                     from include/linux/percpu.h:13,
>                     from arch/x86/include/asm/msr.h:15,
>                     from arch/x86/include/asm/tsc.h:10,
>                     from arch/x86/include/asm/timex.h:6,
>                     from include/linux/timex.h:67,
>                     from include/linux/time32.h:13,
>                     from include/linux/time.h:60,
>                     from include/linux/stat.h:19,
>                     from include/linux/module.h:13,
>                     from drivers/input/touchscreen/cyttsp_core.h:22,
>                     from drivers/input/touchscreen/cyttsp_i2c.c:16:
>    include/linux/mm_types_task.h:19:45: warning: "CONFIG_SPLIT_PTLOCK_CPUS" is not defined, evaluates to 0 [-Wundef]
>       19 | #define USE_SPLIT_PTE_PTLOCKS   (NR_CPUS >= CONFIG_SPLIT_PTLOCK_CPUS)
>          |                                             ^~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/mm.h:2928:5: note: in expansion of macro 'USE_SPLIT_PTE_PTLOCKS'
>     2928 | #if USE_SPLIT_PTE_PTLOCKS
>          |     ^~~~~~~~~~~~~~~~~~~~~
>    include/linux/mm_types_task.h:19:45: warning: "CONFIG_SPLIT_PTLOCK_CPUS" is not defined, evaluates to 0 [-Wundef]
>       19 | #define USE_SPLIT_PTE_PTLOCKS   (NR_CPUS >= CONFIG_SPLIT_PTLOCK_CPUS)
>          |                                             ^~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/mm_types_task.h:20:34: note: in expansion of macro 'USE_SPLIT_PTE_PTLOCKS'
>       20 | #define USE_SPLIT_PMD_PTLOCKS   (USE_SPLIT_PTE_PTLOCKS && \
>          |                                  ^~~~~~~~~~~~~~~~~~~~~
>    include/linux/mm.h:3050:5: note: in expansion of macro 'USE_SPLIT_PMD_PTLOCKS'
>     3050 | #if USE_SPLIT_PMD_PTLOCKS
>          |     ^~~~~~~~~~~~~~~~~~~~~
>    drivers/input/touchscreen/cyttsp_i2c.c: In function 'cyttsp_i2c_read_block_data':
> >> drivers/input/touchscreen/cyttsp_i2c.c:47:18: error: implicit declaration of function 'i2c_transfer' [-Werror=implicit-function-declaration]
>       47 |         retval = i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
>          |                  ^~~~~~~~~~~~
>    drivers/input/touchscreen/cyttsp_i2c.c: In function 'cyttsp_i2c_probe':
>    drivers/input/touchscreen/cyttsp_i2c.c:90:14: error: implicit declaration of function 'i2c_check_functionality' [-Werror=implicit-function-declaration]
>       90 |         if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
>          |              ^~~~~~~~~~~~~~~~~~~~~~~
>    drivers/input/touchscreen/cyttsp_i2c.c: At top level:
>    drivers/input/touchscreen/cyttsp_i2c.c:128:1: warning: data definition has no type or storage class
>      128 | module_i2c_driver(cyttsp_i2c_driver);
>          | ^~~~~~~~~~~~~~~~~
>    drivers/input/touchscreen/cyttsp_i2c.c:128:1: error: type defaults to 'int' in declaration of 'module_i2c_driver' [-Werror=implicit-int]
>    drivers/input/touchscreen/cyttsp_i2c.c:128:1: warning: parameter names (without types) in function declaration
>    drivers/input/touchscreen/cyttsp_i2c.c:118:26: warning: 'cyttsp_i2c_driver' defined but not used [-Wunused-variable]
>      118 | static struct i2c_driver cyttsp_i2c_driver = {
>          |                          ^~~~~~~~~~~~~~~~~
>    cc1: some warnings being treated as errors
> 

This is really weird: cyttsp_i2c.h includes linux/i2c.h, it has
dependency in Kconfig on I2C and CONFIG_I2C is present in the .config
referenced above, so all the declarations should be there.

I tried reproducing with the exact commit and config as in this report
and I did not get such errors. This is with gcc version 13.2.0 (Debian
13.2.0-13).

Thanks.

-- 
Dmitry

