Return-Path: <linux-kernel+bounces-252297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E995B931125
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 11:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E0861F2134A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 09:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44963186E3C;
	Mon, 15 Jul 2024 09:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RWhxIZLv"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE476AC0;
	Mon, 15 Jul 2024 09:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721035531; cv=none; b=ugW+r8MZDhahCahPKz3bNYeVojgjZUcMqd77s4QYwJWIe80FN49VtqJscIzTK78rZyiSvQ0bwLgWV1qbmM6KP9rCHn7d58U8gOMe9AjcD4ie7U9rPpQpp/qkjG2IU7Ncp0ioDAhWahTy1N4oAjc3N6rCJf0njSRbkZAVv6IqJTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721035531; c=relaxed/simple;
	bh=8ladW+rqCwCi2KnMbdLEzh70YZ0rfIe4aeFAwhNRgEE=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=eKN7XGzknlAd5tKnvIGcljGXzkV/mpZ64EQ2tZyVPETRR/dEp/YCN5jEqribYjI2gCBm1NuI8h2kH9XXAgFhekYICMv0NZauUZmacUBhDT9aRA/QOOjWghXFa2l1wqO3Oca7QNwsZArTOYbPtzyVI9Vn5602ZrxpqMWlSjq0M/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RWhxIZLv; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721035530; x=1752571530;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=8ladW+rqCwCi2KnMbdLEzh70YZ0rfIe4aeFAwhNRgEE=;
  b=RWhxIZLvYaSrklPEHquhdNyvF6eQuuWolqJu8eryC8ecwvhOFv1gOvWT
   pboZM5ntAUxNR3Ldm4dJthhGzCVzBTiEsBzL3ypidqT2GOtEZbOM3M8Ta
   InGtKpeafJmcghKNsj/5BMlOgFey9EJKlinA3ditTPoyCDgkiTSWrZm3s
   TuNhzZmQO3kuW3qmpNWhKGgSIekNK/eC3nRQcBrkTxsWZ0TQJUhsT9CMU
   MvzTeXI4UIUtfaPDcC3cZQAaz64+RAiF1QsnBE9twmKHuWQCTK1M87H/g
   eeVTZy0Kso4nju/zNIXzEH6kTZBMLASI8n/k68UBKY6lNhx8M7+2tfkjI
   g==;
X-CSE-ConnectionGUID: t6jxPYV0TpmURPOOR1oBVw==
X-CSE-MsgGUID: AfSDEliuTmKemZ+riDtiWA==
X-IronPort-AV: E=McAfee;i="6700,10204,11133"; a="18116965"
X-IronPort-AV: E=Sophos;i="6.09,210,1716274800"; 
   d="scan'208";a="18116965"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2024 02:25:29 -0700
X-CSE-ConnectionGUID: w4YbGjS4QT2Flzwk22vxNg==
X-CSE-MsgGUID: c3bSWFr6SD+oPLkg4naVsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,210,1716274800"; 
   d="scan'208";a="49444312"
Received: from unknown (HELO localhost) ([10.245.247.131])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2024 02:25:26 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 15 Jul 2024 12:25:21 +0300 (EEST)
To: Dan Carpenter <dan.carpenter@linaro.org>
cc: Tero Kristo <tero.kristo@linux.intel.com>, 
    Hans de Goede <hdegoede@redhat.com>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] platform/x86/intel/tpmi/plr: Uninitialized variable in
 plr_print_bits()
In-Reply-To: <8ccfab0c-3c11-4168-a383-19895ae60022@stanley.mountain>
Message-ID: <1467f140-c035-cb2a-20d9-b5910971cb56@linux.intel.com>
References: <8ccfab0c-3c11-4168-a383-19895ae60022@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 12 Jul 2024, Dan Carpenter wrote:

> Initialize the "str" pointer to NULL.  There is a test later for if "str"
> is NULL but in the original code it was either valid or uninitialized.
> 
> Fixes: 9e9397a41b7b ("platform/x86/intel/tpmi/plr: Add support for the plr mailbox")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> Almost everyone automatically initializes stack variables to zero these days so
> bugs like this don't show up in testing and we disabled GCC's uninitialized
> variable warning so it's easy to miss.
> 
>  drivers/platform/x86/intel/intel_plr_tpmi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/intel/intel_plr_tpmi.c b/drivers/platform/x86/intel/intel_plr_tpmi.c
> index c1aa52c23d25..2725a1ddba92 100644
> --- a/drivers/platform/x86/intel/intel_plr_tpmi.c
> +++ b/drivers/platform/x86/intel/intel_plr_tpmi.c
> @@ -162,7 +162,7 @@ static int plr_clear_cpu_status(struct tpmi_plr_die *plr_die, int cpu)
>  static void plr_print_bits(struct seq_file *s, u64 val, int bits)
>  {
>  	const unsigned long mask[] = { BITMAP_FROM_U64(val) };
> -	const char *str;
> +	const char *str = NULL;
>  	int bit, index;
>  
>  	for_each_set_bit(bit, mask, bits) {

This fix looks slightly incorrect. It silences warning but for logic 
correctness, the NULL assignment seems to belong inside the for loop so 
it's done for each bit.

-- 
 i.


