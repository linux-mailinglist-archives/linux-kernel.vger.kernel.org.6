Return-Path: <linux-kernel+bounces-181549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C33728C7D82
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 21:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5FE71C20B4B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 19:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055A8157E6E;
	Thu, 16 May 2024 19:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VV7KIsTf"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB6A157467
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 19:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715889220; cv=none; b=rbY3g0K5JbK0AM4m+nKS3BmWjMOomP/TVmSL02+X1AQXoIJPYQx0IFVLMccgH2ha81rg73b17HYsBp92zfFwGR7Jq9NlSDULuymO/bC0bliySJh+ikzrJrArZtSu0OgMzjzJZqJFdOE1LLSaa4jWCAPK7lPWjqw6XDcpk9wvXiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715889220; c=relaxed/simple;
	bh=IRpTOuOOXC57Iq3ThV+GrcglJadbga9qFW7khSE7t/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gwt12DRZn3ck9W9ODpIKs4yEAydYfIS2cu0sOArBNEJ3S4JYTp2mKwXicqiWNMQ8JfG8J9Ld5QLIuMHKBsXxz/SQAKSyMMhG4LnbD8G5P22P25i3zsECNysLEDS3bOPT27vAwCr4kSRw1/06KdM9XLBC1ztLgdOkEYE1mo5IceQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VV7KIsTf; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2b3c711dfd3so505694a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 12:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715889217; x=1716494017; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T0NmuGqGhHIorLBxv2ykQz5fF5enleamOMGK+eVHPvI=;
        b=VV7KIsTf4EiFs4ekzbTYZPFDYhg+4A4uSIlP9ozh7/PGX61Hc+D0B234HPn1o7e6On
         KXGMypdzU05kDOZz8YjEw1PQCIgkpuwwSWmvNbgxn4igzKf7p0vK42ozYm1eveCyRjf3
         SeoScdx+Ji1A+9wWEAzyzS+JJv2/RlnwKZlMGjq3TbG0hWOU7JfpahHKCaAZb02wn0Xz
         tVE2ncRU8F890XPAER9C78P9e75CpeCCWN0/3o6XyI9t+4BRT06+2wGSG1v6//VmE1fl
         10vny8Osixh6vCj2k2FWUsYttXnJ/quO3+R+jbLaO2VOBnkvktV4E5OA0Gb5+KoKw+J2
         PYkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715889217; x=1716494017;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T0NmuGqGhHIorLBxv2ykQz5fF5enleamOMGK+eVHPvI=;
        b=PxPjXETfstLIhIgzeFBq2nFc5wBU64vBbA1zGQ6cdsZPtsJ+iUvBcBytVuBofzXnqG
         jcku4pPMRwSo4ShPk2Sbtj4WqtN0+C2TMs4+YjB0XYqs3DDPeD4NGLnYb4sLoL69auvu
         RWlrNuN8O7r3hxC1lU+Gna9t3w7VLjk/VVy+yB8MLJVCWM+x5+/Zz7wYbr53rPk3e8GZ
         oXR4D1X8Z49ZspEkuc8sBYMK9K2lGGmDrYOxfSPYTL1CaJnNOix5rTay8Fp5uaPeTFxW
         qCpM0YeXxOkGF53TmL5lLioVE7AxSR6iIfAS6kPrbAUYyP4RbPpPTG9IhT9lV3FApOaW
         wS+g==
X-Forwarded-Encrypted: i=1; AJvYcCViIgOJJl4E5pShms6Uo5UIQ/eHJE7tHQSysW2sQ3z72e83LZgcKWt+bDBL2WDeD+Mxb2B9V9ld+4wrJqiSLOcYia9PXf99foImCI80
X-Gm-Message-State: AOJu0Yy2BM2F32K97oqHPTdHLcQ20GK9meLLpmEILU3GRYU4XMfQHDKm
	MN4U2BrUM8TMyA25Okd8vghgveLK05h/Ztd2fFUq3V0PnpQllrFJwAJBNA==
X-Google-Smtp-Source: AGHT+IG5lBAb6kWuJkHbQV6Mhwq7OdPmYD8gO/Ik5j1zIEv1MFT0WZxMg/S2qua2xlFVh3saLhFeGA==
X-Received: by 2002:a17:90a:fd8a:b0:2bc:9bce:19c3 with SMTP id 98e67ed59e1d1-2bc9bce1df0mr1945404a91.43.1715889217378;
        Thu, 16 May 2024 12:53:37 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b62863a1besm16236334a91.9.2024.05.16.12.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 12:53:36 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 16 May 2024 12:53:34 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: broonie@kernel.org, linux-kernel@vger.kernel.org,
	patches@opensource.cirrus.com
Subject: Re: [PATCH 04/11] regmap: kunit: Run sparse cache tests at non-zero
 register addresses
Message-ID: <5c1daddb-d8b3-420a-839f-208e0a6e168b@roeck-us.net>
References: <20240408144600.230848-1-rf@opensource.cirrus.com>
 <20240408144600.230848-5-rf@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240408144600.230848-5-rf@opensource.cirrus.com>

Hi,

On Mon, Apr 08, 2024 at 03:45:53PM +0100, Richard Fitzgerald wrote:
> Run the cache_drop() and cache_present() tests at blocks of addresses
> that don't start at zero.
> 
> This adds a from_reg parameter to struct regmap_test_param. This is
> used to set the base address of the register defaults created by
> gen_regmap().
> 
> Extra entries are added to sparse_cache_types_list[] to test at non-zero
> from_reg values. The cache_drop() and cache_present() tests are updated
> to test at the given offset.
> 
> The aim here is to add test cases to cache_drop() for the bug fixed by
> commit 00bb549d7d63 ("regmap: maple: Fix cache corruption in
> regcache_maple_drop()")
> 
> But the same parameter table is used by the cache_present() test so
> let's also update that to use from_reg.
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>

With this patch in mainline, I get lots of errors such as

[   23.494308] =============================================================================
[   23.496391] BUG kmalloc-64 (Tainted: G                 N): kmalloc Redzone overwritten

Bisect log and first of many backtraces attached for reference.

Guenter

---
# bad: [1b294a1f35616977caddaddf3e9d28e576a1adbc] Merge tag 'net-next-6.10' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next
# good: [a5131c3fdf2608f1c15f3809e201cf540eb28489] Merge tag 'x86-shstk-2024-05-13' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect start '1b294a1f3561' 'a5131c3fdf26'
# good: [f8beae078c82abde57fed4a5be0bbc3579b59ad0] Merge tag 'gtp-24-05-07' of git://git.kernel.org/pub/scm/linux/kernel/git/pablo/gtp Pablo neira Ayuso says:
git bisect good f8beae078c82abde57fed4a5be0bbc3579b59ad0
# bad: [ce952d8f0e9b58dc6a2bde7e47ca7fa7925583cc] Merge tag 'gpio-updates-for-v6.10-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux
git bisect bad ce952d8f0e9b58dc6a2bde7e47ca7fa7925583cc
# good: [f952b6c863090464c148066df9f46cb3edd603da] Merge tag 'thermal-6.10-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
git bisect good f952b6c863090464c148066df9f46cb3edd603da
# bad: [07bbfc6aba1efe332d9994b2995c9bea0cd3b25f] Merge tag 'regulator-v6.10' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator
git bisect bad 07bbfc6aba1efe332d9994b2995c9bea0cd3b25f
# good: [e573d27e18f8289454b6abb378de531374bd3cde] Merge branches 'acpi-tools', 'acpi-docs' and 'pnp'
git bisect good e573d27e18f8289454b6abb378de531374bd3cde
# good: [440f9d47dfac065a8da663adbc4b28703fdf550e] Merge branches 'pm-cpuidle', 'pm-sleep' and 'pm-powercap'
git bisect good 440f9d47dfac065a8da663adbc4b28703fdf550e
# good: [41b94bc6d96b9b046ef08114f057dcc6c52e28b6] iio: addac: ad74115: Use devm_regulator_get_enable_read_voltage()
git bisect good 41b94bc6d96b9b046ef08114f057dcc6c52e28b6
# bad: [991b5e2aad870828669ca105f424ef1b2534f820] regmap: kunit: Fix an NULL vs IS_ERR() check
git bisect bad 991b5e2aad870828669ca105f424ef1b2534f820
# bad: [ce75e06eea9cfdddaa0082cef663cf2d4aa5ed1d] regmap: kunit: Use a KUnit action to call regmap_exit()
git bisect bad ce75e06eea9cfdddaa0082cef663cf2d4aa5ed1d
# bad: [710915743d53d19a1baf0326302aa1f743ab018e] regmap: kunit: Run sparse cache tests at non-zero register addresses
git bisect bad 710915743d53d19a1baf0326302aa1f743ab018e
# good: [7b7982f14315e0f6910e13b22ed38a47144a83ec] regmap: kunit: Create a struct device for the regmap
git bisect good 7b7982f14315e0f6910e13b22ed38a47144a83ec
# good: [48bccea96fead1b212e19e38e50bf8e69287c45d] regmap: kunit: Introduce struct for test case parameters
git bisect good 48bccea96fead1b212e19e38e50bf8e69287c45d
# first bad commit: [710915743d53d19a1baf0326302aa1f743ab018e] regmap: kunit: Run sparse cache tests at non-zero register addresses

---
[   23.494308] =============================================================================
[   23.496391] BUG kmalloc-64 (Tainted: G                 N): kmalloc Redzone overwritten
[   23.496900] -----------------------------------------------------------------------------
[   23.496900]
[   23.497510] 0xc69ee28b-0xc69ee28b @offset=651. First byte 0x0 instead of 0xcc
[   23.498079] Allocated in __regmap_init_ram+0x30/0xa0 age=2 cpu=0 pid=1064
[   23.499422]  __kmalloc+0x270/0x378
[   23.499783]  __regmap_init_ram+0x30/0xa0
[   23.500109]  gen_regmap.constprop.0+0x144/0x198
[   23.500440]  stride+0x58/0x4e4
[   23.500715]  kunit_try_run_case+0x5c/0x1a4
[   23.501016]  kunit_generic_run_threadfn_adapter+0x1c/0x34
[   23.501396]  kthread+0xfc/0x120
[   23.501682]  ret_from_fork+0x14/0x24
[   23.502030] Freed in pinctrl_free+0x9c/0x184 age=4 cpu=0 pid=10
[   23.502450]  pinctrl_free+0x9c/0x184
[   23.502711]  release_nodes+0x50/0x7c
[   23.502985]  devres_release_all+0x80/0xf0
[   23.503265]  device_unbind_cleanup+0xc/0x60
[   23.503587]  really_probe+0x188/0x2d0
[   23.503890]  __driver_probe_device+0x84/0x1a0
[   23.504175]  driver_probe_device+0x2c/0xc4
[   23.504454]  __device_attach_driver+0x94/0xc4
[   23.504738]  bus_for_each_drv+0x84/0xdc
[   23.505003]  __device_attach+0xac/0x1d8
[   23.505268]  bus_probe_device+0x8c/0x90
[   23.505541]  deferred_probe_work_func+0x8c/0xc0
[   23.505822]  process_one_work+0x260/0x6f8
[   23.506100]  worker_thread+0x178/0x3b0
[   23.506373]  kthread+0xfc/0x120
[   23.506605]  ret_from_fork+0x14/0x24
[   23.506906] Slab 0xcbeacdc0 objects=21 used=19 fp=0xc69eec40 flags=0xa00(workingset|slab|zone=0)
[   23.507770] Object 0xc69ee280 @offset=640 fp=0xc69ee100
[   23.507770]
[   23.508668] Redzone  c69ee240: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc  ................
[   23.509138] Redzone  c69ee250: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc  ................
[   23.509538] Redzone  c69ee260: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc  ................
[   23.509935] Redzone  c69ee270: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc  ................
[   23.510453] Object   c69ee280: 01 00 01 00 01 00 01 00 01 00 01 00 cc cc cc cc  ................
[   23.510984] Object   c69ee290: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc  ................
[   23.511488] Object   c69ee2a0: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc  ................
[   23.511857] Object   c69ee2b0: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc  ................
[   23.512268] Redzone  c69ee2c0: cc cc cc cc                                      ....
[   23.512738] Padding  c69ee2f4: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a              ZZZZZZZZZZZZ
[   23.513444] CPU: 0 PID: 1065 Comm: kunit_try_catch Tainted: G                 N 6.9.0-05151-g1b294a1f3561 #1
[   23.514023] Hardware name: Freescale i.MX6 Ultralite (Device Tree)
[   23.514542] Call trace:
[   23.514722]  unwind_backtrace from show_stack+0x10/0x14
[   23.515298]  show_stack from dump_stack_lvl+0x78/0xa8
[   23.515621]  dump_stack_lvl from check_bytes_and_report+0x110/0x12c
[   23.515972]  check_bytes_and_report from check_object+0x36c/0x3a8
[   23.516310]  check_object from free_to_partial_list+0x15c/0x5ec
[   23.516647]  free_to_partial_list from kfree+0x218/0x2cc
[   23.516967]  kfree from regmap_ram_free_context+0x18/0x2c
[   23.517298]  regmap_ram_free_context from regmap_exit+0x7c/0x148
[   23.517650]  regmap_exit from kunit_remove_resource+0xac/0xc4
[   23.518001]  kunit_remove_resource from kunit_cleanup+0x2c/0x5c
[   23.518435]  kunit_cleanup from kunit_generic_run_threadfn_adapter+0x1c/0x34
[   23.518876]  kunit_generic_run_threadfn_adapter from kthread+0xfc/0x120
[   23.519305]  kthread from ret_from_fork+0x14/0x24
[   23.519764] Exception stack(0xd2541fb0 to 0xd2541ff8)
[   23.520248] 1fa0:                                     00000000 00000000 00000000 00000000
[   23.520717] 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[   23.521161] 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[   23.521753] Disabling lock debugging due to kernel taint
[   23.522060] FIX kmalloc-64: Restoring kmalloc Redzone 0xc69ee28b-0xc69ee28b=0xcc
[   23.522403] FIX kmalloc-64: Object at 0xc69ee280 not freed

