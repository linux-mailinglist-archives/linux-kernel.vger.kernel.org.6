Return-Path: <linux-kernel+bounces-335511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F74E97E6BF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 09:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 703351C211D6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 07:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999214778C;
	Mon, 23 Sep 2024 07:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jllj9Gg4"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459C03C485;
	Mon, 23 Sep 2024 07:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727077165; cv=none; b=O8qP1N9gcxs5nfsNyJVGiw6UGts9PamfgnTkSlpjOEcjyh4XrY0Eo71n8rsxf0v4NH69ri4E336VQ57z+ru15YnGdx+nbhPFoYSi55i90+KJPYWShUtxxClHQpRDfSqt4pX8ubuc7KQlnn96vuKRsBOy8FpyV9ln5JaDyY99luQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727077165; c=relaxed/simple;
	bh=GMKvCuvHA+Mc8+Nk2ZMiVfP2w25K77l3kYWApL9GDAw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sDJ+SGobo72nxxX652hIONxyXEFvwCzo+Zq3IDeiuI7OAhuv2a/FdQLFsmWWlHIBmpyk5y4LyMFK0lrafbscw5xn4qiBEgHOfhHCx567EdiZne6vswM0UodtVIMTz3X5rwBb81nxQLlEUi/bPeoiTnxkQZVFGhSIXU4Y69T2RuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jllj9Gg4; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727077163; x=1758613163;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GMKvCuvHA+Mc8+Nk2ZMiVfP2w25K77l3kYWApL9GDAw=;
  b=Jllj9Gg4bwNHwVaNMPuwkX3+Im73B7X1MZKU2+DDAmvISnk+7hi4B1iX
   nSkA87aE46egvXVpHZmS9Rqgkm5VSUNfaeljAPyDOy7baVIlRrwoGhepU
   CPQqqk5GCcFRMLL9FNglCGrEUWiY6H5cgo2zNehbYBPPLIcynU5TQ5T4r
   b6f5HYsRvRTrDfcSraWU9bSjtV6EcYP4x1YaznZodu/gDuP4gyTIY3mA5
   7wfantSNU1wekNAPGg5k9OvazZs3f2pMycUPukVHJGsR0vfgNfkPf4AZ8
   7TyS/vU8WLp3hPkoWINwW9ie5qZV7xXPnDtV/QIcIZxd9pwCit1qOljvB
   Q==;
X-CSE-ConnectionGUID: e5fy4BlxSmqxtrwvvYD5eA==
X-CSE-MsgGUID: KN1ZJJtBShiptK2EM9Zn6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11202"; a="26165333"
X-IronPort-AV: E=Sophos;i="6.10,250,1719903600"; 
   d="scan'208";a="26165333"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 00:39:22 -0700
X-CSE-ConnectionGUID: l622R80WSrKXaEwn4CZZpA==
X-CSE-MsgGUID: MAPBcoPUTf2eBNGV6/WgrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,250,1719903600"; 
   d="scan'208";a="75539933"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.94.0.53]) ([10.94.0.53])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 00:39:20 -0700
Message-ID: <3ceac85f-e419-44b1-b04b-1d1cf99a3e87@linux.intel.com>
Date: Mon, 23 Sep 2024 09:39:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: topology: fix stack corruption by code unification
 for creating standalone and widget controls
Content-Language: en-US
To: "H. Nikolaus Schaller" <hns@goldelico.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 letux-kernel@openphoenux.org, kernel@pyra-handheld.com, risca@dalakolonin.se
References: <7eca678fa7faa9e160b998192e87220de81315c8.1726847965.git.hns@goldelico.com>
From: =?UTF-8?Q?Amadeusz_S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <7eca678fa7faa9e160b998192e87220de81315c8.1726847965.git.hns@goldelico.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/20/2024 5:59 PM, H. Nikolaus Schaller wrote:
> After finding kernel crashes on omap4/5 aess on PandaES and OMAP5UEVM like
> 
> [   46.367041] Unable to handle kernel execution of memory at virtual address f164d95c when execute
> 
> a bisect did initially hint at commit 8f2942b9198c9 ("ASoC: topology: Unify
> code for creating standalone and widget enum control")
> 
> Deeper analysis shows a bug in two of the three "ASoC: topology: Unify code"
> patches. There, a variable is initialized to point into the struct snd_kcontrol_new
> on stack instead of the newly devm_kzalloc'ed memory.
> 
> Hence, initialization through struct soc_mixer_control or struct soc_bytes_ext
> members overwrites stack instead of the intended target address, leading to
> the observed kernel crashes.
> 
> Fixes: 8f2942b9198c ("ASoC: topology: Unify code for creating standalone and widget enum control")
> Fixes: 4654ca7cc8d6 ("ASoC: topology: Unify code for creating standalone and widget mixer control").
> Fixes: 0867278200f7 ("ASoC: topology: Unify code for creating standalone and widget bytes control").
> Tested-by: risca@dalakolonin.se
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
> 

There was an earlier patch for same issue which got merged:
https://lore.kernel.org/linux-sound/172675955522.1842725.17347774552974803458.b4-ty@kernel.org/T/#m527c2b9bee99d40d7cd5224cb1d8046dd0528097

> Notes:
>      There seems to be another weakness of all three patches. The initialization
>      of the kc.private_value is now done after calling soc_tplg_control_load()
>      which may pass the incompletely initialized control down to some control_load()
>      operation (if tplg->ops are defined).
>      
>      Since this feature is not used by the omap4/5 aess subsystem drivers it is
>      not taken care of by this fix.
>      

dobj is internal management detail of topology handling, I'm not 
convinced end users of topology API should touch it. I would say that I 
would even be worried that someone touches that, as they may corrupt 
list etc.

>      Another general observation with this code (not related to these patches here)
>      is that it does not appear to be 64 bit address safe since private_value of
>      struct snd_kcontrol_new is 'unsigned long' [1] but used to store a pointer.
>      
>      This is fine on omap4/5 since they are 32 bit machines with 32 bit address
>      range. A problem would be a machine with 32 bit unsigned long and >32 bit
>      addresses.

As far as I know that's exactly the reason why it is unsigned long in 
kernel, you can store a pointer in it.



