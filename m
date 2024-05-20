Return-Path: <linux-kernel+bounces-184197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E071A8CA3D1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 23:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 979CF281BD5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 21:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0369D139D0C;
	Mon, 20 May 2024 21:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V5Wzp9Gt"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B99155E43;
	Mon, 20 May 2024 21:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716240803; cv=none; b=Orc25bBncQ5WLjt/3P4tYcCiasQ8cWatIycAP+mcDGOq2qvWc9s32vlQ/ZEEUIgaKuVzRFsP6XO7M24jVSt2AYUkN5BVD2gUfzWEuEtroz2XkY56W44V/LaStvDVFwZgGCMMcvjvVxWtmDxDIzcpEZ/enNb2NyH8AiEHDz7khVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716240803; c=relaxed/simple;
	bh=WrZ5Vf7Jh3/G3dGoiHMd/08geH9pMlfqTaIaOal5dMk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nj+kq1WT9bcxXdX9+rErM2Pq5ShIPkKf2Lugsu/X58C8F9ybl6aqCaJtW2gxd40td0zFHu8c/FYk3wKtYsJgtL/UwVm4cVmHIIBwRHkgjZwDZVedeNWK4w5tjD3NaPoXlzL6lrGD65TaAw/uFILcCGZDm7pWSfYy+nSGZETboQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V5Wzp9Gt; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716240801; x=1747776801;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WrZ5Vf7Jh3/G3dGoiHMd/08geH9pMlfqTaIaOal5dMk=;
  b=V5Wzp9GtkDD2fl2Lm++oOkRByBXm96g35566eB9y/WYYt/cXSDz012j/
   YbKZIgrF8aMtPwAuqEz3UWXFtL6Z8aXSFV4Tg60nW7h46OzVeN+jmDjrV
   g/BE9LkO2cwQFH6vp4DkMY4i65Xi7fFVCumNZNTkSXU+6Ure3rs2byWO+
   TFEyxCwlNe/54JpD9ibahN5YAWaaEwxGYhXWlr7qLwrhKXd0cEdhW7G5Z
   4UkukPGYcK909lmSzHrQoDo9pkqQAtJdx5RXYO2Zrp+kztGSEDjxb4RMs
   TK9IySuP37LcSxGg/TNQgTon5PTJkgoGFWpQ0+O5m13NHpr45cdZ3w8dd
   w==;
X-CSE-ConnectionGUID: yMwj0lMERqiEp9aimUQ61Q==
X-CSE-MsgGUID: mKCjX4ZAQSeGK6Coh4EJmg==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="29922096"
X-IronPort-AV: E=Sophos;i="6.08,176,1712646000"; 
   d="scan'208";a="29922096"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 14:33:19 -0700
X-CSE-ConnectionGUID: u4AE7DrRRte9dwLdiod1Kg==
X-CSE-MsgGUID: K2cU40uRQLSWHZ62riEPiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,176,1712646000"; 
   d="scan'208";a="32552694"
Received: from daliomra-mobl3.amr.corp.intel.com (HELO [10.125.109.51]) ([10.125.109.51])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 14:33:19 -0700
Message-ID: <4884ef78-2b86-4dcd-bec4-d6e111fa5455@linux.intel.com>
Date: Mon, 20 May 2024 16:33:17 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ASoC: intel: Constify struct snd_soc_ops
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
References: <2f0613bf4c6018569cdaac876d0589e49cf38a80.1715622793.git.christophe.jaillet@wanadoo.fr>
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <2f0613bf4c6018569cdaac876d0589e49cf38a80.1715622793.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/13/24 12:57, Christophe JAILLET wrote:
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

We don't test all the boards in CI but I don't see any issues with
https://github.com/thesofproject/linux/pull/4993, so

Tested-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

