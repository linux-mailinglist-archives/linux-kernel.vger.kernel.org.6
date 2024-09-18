Return-Path: <linux-kernel+bounces-332732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2593697BDFC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 16:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF70728275E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 14:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6611A0721;
	Wed, 18 Sep 2024 14:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YBE4zoLK"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82ACB1A01C5;
	Wed, 18 Sep 2024 14:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726669820; cv=none; b=vBcN3utDijjUW7cAchIM6LfWlr2ziHauDjx6CWsIlxSoqf91JEU/5E+Bd6pMM85E377u9xSDONJKqxF2NwdLCPItsE17DgLiTEADqXi0pJXlbyE2b1LlkdbCucJCiccw/H3n/+2CNOs4Wiwr+OrURss1Z4l+PxTudhjwIuETHK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726669820; c=relaxed/simple;
	bh=1WUFO/IQPHwNpY3FVg6Ddg7b28QOl0MF0h37pQdLBiI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rba2Rnhl2dzNJbqwMwkj0PKIGfnJiPxCInALwFm9jMScEDE8ie8ClMSk32NDBIbgardEumsVt/ub69yB21ZSo1GtN6H6PJPous8UmncQN+JYVM2PT1ladAQ+hjBWbxeEZ6Zk8NP+Y8Rb3NZuPhPKK6+VydlXJVcYYV8bVlNH4F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YBE4zoLK; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726669819; x=1758205819;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1WUFO/IQPHwNpY3FVg6Ddg7b28QOl0MF0h37pQdLBiI=;
  b=YBE4zoLKdr0Cw/odbC00diSe5LBkDrUan2M6XRpz4ajiZcrGAlxCu/H1
   Ls+kWGS22MBUBSUmCDYW4G3XcpPyMv9NKYaFYrbS8W4wFamRHUcWlI8X2
   tVDhiX/K/AyW92MC3yXJbdiuGoJiIQrY9P7aAxSIDU1gabK7FPtumgZ1+
   3QG9XFnncPnRzzD1HTVN6LQk1Uu3SvvZ4F3mfqOEGGmPnOG0qGzI7Cm4I
   7rP5cmxdkhKPzOPEXzkE9Hlno04ZgTgaz/006yw4Po2qVme6SpODHOqXW
   eVwO2/5kaBtz4oHhwdzY93xXeFOEEv2jZsgt/ujdkiBncW5GwIjn4Uylh
   A==;
X-CSE-ConnectionGUID: +EJsSHn7TXCjv+BqZTBi6w==
X-CSE-MsgGUID: b/nNswAWQresUoBR9FSqkA==
X-IronPort-AV: E=McAfee;i="6700,10204,11199"; a="48114201"
X-IronPort-AV: E=Sophos;i="6.10,239,1719903600"; 
   d="scan'208";a="48114201"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2024 07:29:43 -0700
X-CSE-ConnectionGUID: 3nxsiFddQtSP/XXjoCZwlw==
X-CSE-MsgGUID: 8s0S7PVyRuOH/3/YcMt0Tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,239,1719903600"; 
   d="scan'208";a="69197147"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.94.8.107]) ([10.94.8.107])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2024 07:29:40 -0700
Message-ID: <591ee483-9370-4a8a-9cd0-b3d8ccb555bd@linux.intel.com>
Date: Wed, 18 Sep 2024 16:29:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: topology: Fix incorrect addressing assignments
Content-Language: en-US
To: Tang Bin <tangbin@cmss.chinamobile.com>, lgirdwood@gmail.com,
 broonie@kernel.org, perex@perex.cz, tiwai@suse.com
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240914081608.3514-1-tangbin@cmss.chinamobile.com>
From: =?UTF-8?Q?Amadeusz_S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <20240914081608.3514-1-tangbin@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/14/2024 10:16 AM, Tang Bin wrote:
> The variable 'kc' is handled in the function
> soc_tplg_control_dbytes_create(), and 'kc->private_value'
> is assigned to 'sbe', so In the function soc_tplg_dbytes_create(),
> the right 'sbe' should be 'kc.private_value', the same logical error
> in the function soc_tplg_dmixer_create(), thus fix them.
> 
> Fixes: 0867278200f7 ("ASoC: topology: Unify code for creating standalone and widget bytes control")
> Fixes: 4654ca7cc8d6 ("ASoC: topology: Unify code for creating standalone and widget mixer control")
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
> ---

My mistake, thanks!

Reviewed-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>


