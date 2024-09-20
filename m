Return-Path: <linux-kernel+bounces-334229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A1B97D43E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 12:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7547E1C218CB
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 10:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50EC613C9D4;
	Fri, 20 Sep 2024 10:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TQoRwwb9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA95718EB1;
	Fri, 20 Sep 2024 10:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726828472; cv=none; b=HW5asUTpWd2h2EbHJT5AQI0SWg8gj0KXdFYKkTBgTt2xnnqzxMKF1jSTu4Y8a828SFa5Xipg1htxA3nnxb0Ka/wf3Vk20elCKuw6y+SUULHo3ez86SkfOTQnupXH8FiqxKzDSz2I6MKBKcfX/GUnqY3w+f7vmsWsA5URzYHF3IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726828472; c=relaxed/simple;
	bh=msSfy8aQxcSX26ff0qYOjmm4QfMt+q0fn7mxSUrE3ns=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=R+6+Tx7x3TnGGA62ujGpZ757fRDsA0gj5U5vce29Q1ZzRB0OuFJDakBgTcKip2AjdFG8U/TXnnF3hf1IAwC1DSztgXLVXZd1EaJZtxVPNwbeyMdDqEbvVkAmP5Q3aP8+NaNR36r8TLW1yhRSo2NqkdKFUlR7dA2kuTONdAfxpnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TQoRwwb9; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726828471; x=1758364471;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=msSfy8aQxcSX26ff0qYOjmm4QfMt+q0fn7mxSUrE3ns=;
  b=TQoRwwb9qZe0bUxFEJcq7ue7S7zjE268G6wul6NZttgMRNEOn4EreAlY
   VCTFInJ+tO9iMIVcvVz5tQFCEuD6lbINZWGZMSG08u3oiefsv2cadRXVl
   OyCvq35cKa6SwpPTxYKho6QJEJLvKYOCib1ySlIzLjXvC147DElLZWXFS
   TP0Yt6NtVeUre5k7yXny+btuvP7Wn3gCpztYlEKG7ZtgStvk1j24v8Nys
   Pb8/Rmy3+lk+8aH/Uhw58myH/dIeOqxZopNnlO0pC3Fhp48ZqIEZiTR1m
   hlIh6Sn/lUCvkC6swuG9n+XP0+F53SrkPVDFE5ZRJsz9dCD7l6ptfZuHP
   w==;
X-CSE-ConnectionGUID: miWVqdASSjKrq2hq39lKBw==
X-CSE-MsgGUID: bRJMoSTAQee7jUJig6Peog==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="28726201"
X-IronPort-AV: E=Sophos;i="6.10,244,1719903600"; 
   d="scan'208";a="28726201"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2024 03:34:30 -0700
X-CSE-ConnectionGUID: WR/wBH1KRYizccCaLE0iqA==
X-CSE-MsgGUID: +qTSfa17TM6Vzn5BmgDN0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,244,1719903600"; 
   d="scan'208";a="100994983"
Received: from mlehtone-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.47])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2024 03:34:27 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 20 Sep 2024 13:34:23 +0300 (EEST)
To: WangYuli <wangyuli@uniontech.com>
cc: david.e.box@linux.intel.com, Hans de Goede <hdegoede@redhat.com>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    tzimmermann@suse.de, lee.jones@linaro.org, lee@kernel.org, 
    guanwentao@uniontech.com, zhanjun@uniontech.com
Subject: Re: [PATCH] platform/x86/intel/pmt: Correct the typo
 'ACCCESS_LOCAL'
In-Reply-To: <781C12799421D366+20240920031620.1211752-1-wangyuli@uniontech.com>
Message-ID: <26b8f38f-ff32-81fb-bbe5-aa141239427e@linux.intel.com>
References: <781C12799421D366+20240920031620.1211752-1-wangyuli@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 20 Sep 2024, WangYuli wrote:

> There is a spelling mistake of 'ACCCESS_LOCAL' which should be
> instead of 'ACCESS_LOCAL'.

"instead of ACCESS_LOCAL" means opposite of what you intended. I'd just 
drop "instead of".
 
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Signed-off-by: WangYuli <wangyuli@uniontech.com>
> ---
>  drivers/platform/x86/intel/pmt/class.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/intel/pmt/class.c b/drivers/platform/x86/intel/pmt/class.c
> index c04bb7f97a4d..7680474c4f96 100644
> --- a/drivers/platform/x86/intel/pmt/class.c
> +++ b/drivers/platform/x86/intel/pmt/class.c
> @@ -207,7 +207,7 @@ static int intel_pmt_populate_entry(struct intel_pmt_entry *entry,
>  		/*
>  		 * Some hardware use a different calculation for the base address
>  		 * when access_type == ACCESS_LOCAL. On the these systems
> -		 * ACCCESS_LOCAL refers to an address in the same BAR as the
> +		 * ACCESS_LOCAL refers to an address in the same BAR as the

The change is fine.

-- 
 i.


