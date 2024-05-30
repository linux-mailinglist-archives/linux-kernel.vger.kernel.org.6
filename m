Return-Path: <linux-kernel+bounces-194859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A498D432F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 03:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE72F283CC6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 01:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5CFD179BD;
	Thu, 30 May 2024 01:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="W7kod+94"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F0C17548
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 01:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717033931; cv=none; b=UWTGQNUkn6P9tdFpKHcIbQi+3CWnoHUwIw53cjjkuGVIlHp7HVfQc3LM8G5AzUyCTl3nR4C/klMnSbR4gJxyoO6LBEtl9omQ41aQgGsmph4KSsB+dadSwLFAzzVQwbg917oF5bK2bJDC0OP+sOU33iDfUxsHkt3thTxd6gBF7kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717033931; c=relaxed/simple;
	bh=nB+XZsKWpc5ljgyHSuCbpjXbGBBDLp4qCe63FFC/UZ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eL4twSsJjMHsH2DlfM97PSD0LEscZdG556mZR3zdwH1QWEsiyiBhudjAhismq5jSBLHAGAbl09l9J+GfKB0KLujrrfwOlyc3EtkDDolrIx7hZhOz2/4jbKQp3j0zLmtn4CP9tU9AgCQiq6BJM9Sq68AgYtMt1tFJLD0YLy0Bfok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=W7kod+94; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: lkp@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717033927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w9ZCYefeTQLGp7iJxKwNqZXF5uN8/nAqbBuXiFWgfDI=;
	b=W7kod+94OfQQlV0ikrrzDr3hlo7avGo9tOpU2Ut077MJS0/ke0UDyXpRvOKOBvwH+pgGmh
	1j8UrbHksws73QBmjn2DAH5GScKxHXGqJfSgXztt2h9IoRxK+kxe3g8ADWrwWXG8CwB2gP
	YSXMemj8uaFx1iDaz3Zgi6PImgQ70mY=
X-Envelope-To: tglx@linutronix.de
X-Envelope-To: mingo@redhat.com
X-Envelope-To: bp@alien8.de
X-Envelope-To: dave.hansen@linux.intel.com
X-Envelope-To: oe-kbuild-all@lists.linux.dev
X-Envelope-To: x86@kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: mjguzik@gmail.com
X-Envelope-To: tangyouling@kylinos.cn
Message-ID: <6969a97f-4c2b-4c59-bff7-78ad126eb1e2@linux.dev>
Date: Thu, 30 May 2024 09:51:38 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] x86: Remove the prefetch() specific implementation on
 x86_64
To: kernel test robot <lkp@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>
Cc: oe-kbuild-all@lists.linux.dev, x86@kernel.org,
 linux-kernel@vger.kernel.org, Mateusz Guzik <mjguzik@gmail.com>,
 Youling Tang <tangyouling@kylinos.cn>
References: <20240529032059.899347-1-youling.tang@linux.dev>
 <202405300328.eZmSYZrP-lkp@intel.com>
Content-Language: en-US, en-AU
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Youling Tang <youling.tang@linux.dev>
In-Reply-To: <202405300328.eZmSYZrP-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 30/05/2024 04:03, kernel test robot wrote:

> Hi Youling,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on tip/master]
> [also build test ERROR on linus/master v6.10-rc1 next-20240529]
> [cannot apply to tip/auto-latest tip/x86/core bp/for-next]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Youling-Tang/prefetch-Add-ARCH_HAS_PREFETCH-definition-when-the-architecture-is-not-defined/20240529-112345
> base:   tip/master
> patch link:    https://lore.kernel.org/r/20240529032059.899347-1-youling.tang%40linux.dev
> patch subject: [PATCH 1/2] x86: Remove the prefetch() specific implementation on x86_64
> config: x86_64-buildonly-randconfig-006-20240530 (https://download.01.org/0day-ci/archive/20240530/202405300328.eZmSYZrP-lkp@intel.com/config)
> compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240530/202405300328.eZmSYZrP-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202405300328.eZmSYZrP-lkp@intel.com/
>
> All errors (new ones prefixed by >>):
>
>     drivers/soc/fsl/dpio/dpio-service.c: In function 'dpaa2_io_store_next':
>>> drivers/soc/fsl/dpio/dpio-service.c:745:17: error: implicit declaration of function 'prefetch'; did you mean 'prefetchw'? [-Werror=implicit-function-declaration]
>       745 |                 prefetch(&s->vaddr[s->idx]);
>           |                 ^~~~~~~~
>           |                 prefetchw
>     cc1: some warnings being treated as errors
> --
>     drivers/soc/fsl/dpio/qbman-portal.c: In function 'qbman_swp_dqrr_next_direct':
>>> drivers/soc/fsl/dpio/qbman-portal.c:1213:17: error: implicit declaration of function 'prefetch'; did you mean 'prefetchw'? [-Werror=implicit-function-declaration]
>      1213 |                 prefetch(qbman_get_cmd(s,
>           |                 ^~~~~~~~
>           |                 prefetchw
>     cc1: some warnings being treated as errors
This problem is caused by not including the linux/prefetch.h file. There 
were
no build errors earlier because the definitions in processor.h were used
indirectly. (For architectures that do not implement prefetch, this build
error can occur without the patch).

We can fix it in the following way:
diff --git a/drivers/soc/fsl/dpio/dpio-service.c 
b/drivers/soc/fsl/dpio/dpio-service.c
index b811446e0fa5..a4692b9ad8d7 100644
--- a/drivers/soc/fsl/dpio/dpio-service.c
+++ b/drivers/soc/fsl/dpio/dpio-service.c
@@ -9,6 +9,7 @@
  #include <soc/fsl/dpaa2-io.h>
  #include <linux/init.h>
  #include <linux/module.h>
+#include <linux/prefetch.h>
  #include <linux/platform_device.h>
  #include <linux/interrupt.h>
  #include <linux/dma-mapping.h>
diff --git a/drivers/soc/fsl/dpio/qbman-portal.c 
b/drivers/soc/fsl/dpio/qbman-portal.c
index 0a3fb6c115f4..1c0bf04b101c 100644
--- a/drivers/soc/fsl/dpio/qbman-portal.c
+++ b/drivers/soc/fsl/dpio/qbman-portal.c
@@ -7,6 +7,7 @@

  #include <asm/cacheflush.h>
  #include <linux/io.h>
+#include <linux/prefetch.h>
  #include <linux/slab.h>

Thanks,
Youling.

