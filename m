Return-Path: <linux-kernel+bounces-177649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C523B8C4261
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 15:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55624B240CD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 13:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A7815358E;
	Mon, 13 May 2024 13:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F7n7ktId"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C21153576;
	Mon, 13 May 2024 13:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715607718; cv=none; b=Gd8rmEKF6hcz5Tw+Mkdq8Ln4ntjHORQkfIHiA80hh5pE2WKR12mLJ1Cv2ob6t8GQwHRVFJv0lDYUjSqO7ZVetbP5LATdoIJD640JdzDC2aKTNMbmwqNLQzFtauwblDAfc2KbxePzDiuJMzo3KrX8OsXnA2vUm/Br0egOxKfhwSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715607718; c=relaxed/simple;
	bh=NHGPLgtCUqCEfcn2vaIa5U959E4/fnbBgnnTfKGDUhM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PHFbDKrsCF3me2mVHlZLD2Y9nFljpywXqdFqSulWuO1RPJ1B+2NTGwqRrKUaZb3SPMet3/yOh0FVhSE8pY2q0qs3wxStSvbOSA5Jl6fZvfW+c2w9MbCwWqmNSdrmM/XvC4z+8jo/5SwdsqnfsJ9BDSwufg0dqo5nghkFkbJakfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F7n7ktId; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715607717; x=1747143717;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NHGPLgtCUqCEfcn2vaIa5U959E4/fnbBgnnTfKGDUhM=;
  b=F7n7ktIds1fessChL6a9WvgGOS0WmeC15lJ92clTX8C9NjDm8aF6Zn/m
   i9yNOI+pWHQLCa1Efp1hufnhQyh+39Bxa0ff5NXPLpaA6QpxeDtscZVTJ
   BzJeh91P3wXWJDRY/iFLIbVE/4WVHPPBxLQ55jdW9qoVzF6S+KUa00VM3
   itmG5vTC0iqMgNItCWzXQOacQpjtqQpR9VdD0cqZQ+bstYYbHnBBh0uJ8
   FZJXgYTIM3HVC3jWto17io9uJG9VLIn+oHD8QtwLTVPeV7OcIsypEIpNN
   w+zsoGiQmnHsdkGqLil9brY4HPFO37zMz+6WYg4XIAtN5k/9zFeVQOgz9
   w==;
X-CSE-ConnectionGUID: nYxQqSqXT3WXr+bt45KwGw==
X-CSE-MsgGUID: 5uFUxJ+uQ2iXowJ/hTdB3w==
X-IronPort-AV: E=McAfee;i="6600,9927,11072"; a="34055952"
X-IronPort-AV: E=Sophos;i="6.08,158,1712646000"; 
   d="scan'208";a="34055952"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 06:41:57 -0700
X-CSE-ConnectionGUID: IDlEf8a7Qt6kUtLIFkGQJw==
X-CSE-MsgGUID: kcqS9LquTyiO6UeF+3ehCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,158,1712646000"; 
   d="scan'208";a="30323298"
Received: from sgoshi-mobl1.amr.corp.intel.com (HELO [10.212.69.71]) ([10.212.69.71])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 06:41:56 -0700
Message-ID: <88e6bbe3-94a2-4b50-b462-eb27376698c4@linux.intel.com>
Date: Mon, 13 May 2024 08:41:55 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: intel: Constify struct snd_soc_ops
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Cezary Rojewski <cezary.rojewski@intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, Mark Brown
 <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 alsa-devel@alsa-project.org, linux-sound@vger.kernel.org
References: <242aef53b5b9533ae4cca78148622f5fe752b7ee.1715452901.git.christophe.jaillet@wanadoo.fr>
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <242aef53b5b9533ae4cca78148622f5fe752b7ee.1715452901.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/11/24 13:42, Christophe JAILLET wrote:
> Constifying "struct snd_soc_ops" moves some data to a read-only section, so
> increase overall security.
> 
> This structure is also part of scripts/const_structs.checkpatch.
> 
> As an example, on a x86_64, with allmodconfig:
> Before:
>    text	   data	    bss	    dec	    hex	filename
>    6315	   3696	      0	  10011	   271b	sound/soc/intel/boards/ehl_rt5660.o
> 
> After:
>    text	   data	    bss	    dec	    hex	filename
>    6379	   3648	      0	  10027	   272b	sound/soc/intel/boards/ehl_rt5660.o
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Compile tested only.
> 
> I hope that it can be applied with this single patch because all files are
> in sound/soc/intel/boards/

Doesn't apply for me, can you rebase and resend?

CONFLICT (content): Merge conflict in
sound/soc/intel/boards/sof_maxim_common.h
Auto-merging sound/soc/intel/boards/sof_maxim_common.c
CONFLICT (content): Merge conflict in
sound/soc/intel/boards/sof_maxim_common.c
error: Failed to merge in the changes.

Probably a result of all the changes in this directory...
Thanks!

