Return-Path: <linux-kernel+bounces-184199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1578CA3D8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 23:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B3111C213BF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 21:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB18139D17;
	Mon, 20 May 2024 21:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZUHisKTI"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2BF1369BA;
	Mon, 20 May 2024 21:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716241139; cv=none; b=YfLcLKu6pVlvYHmqVNl/1q31IF1T29iKzYklvmKzmpOTT8d9eDGsFJ1gBEtgtIsPs80SJJGzNGiI5HPD/02sEfXitZm9kKQD/Woe2zi8kjHMvY5J2ZoJKf4Nn245TdDv7X5NM/KDDML1Ln6UT2neXhAMk4NrlSXltZqNPfcnXsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716241139; c=relaxed/simple;
	bh=yw2rCIrCQibFXCP4yX81inyprqmfwEEpDAwGlUMhIJY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ci+av9u+G1frLXKJ5qVnCZn2WZa6z26euidktkhQGA9DGla6n1vlspwOCRI/cDPKWku6sxjc/ATuW+QXcQ/tyhvam7frLQ7cMHHSoHJikdAbnvi1tKAsaJzx81dS7R6IcYLFTLdb03Q1EZ7oSbKjIM/86MGz4K9AGBDKESbyTlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZUHisKTI; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716241138; x=1747777138;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yw2rCIrCQibFXCP4yX81inyprqmfwEEpDAwGlUMhIJY=;
  b=ZUHisKTIz38vSvQ1ClUt9pFSyv5xd4wDlQ1p9p9CV86gh/zCyt4SAEJV
   WG6FL85exbt8/erL7IslWt/w5wE54dsemDwLgb6CLbU0wq8mtKGYLL5wC
   WPVDRvjfv+76uiZY/o5caImCuhpXqDR7Nw6ACsrj2DLF7DxStCf0DX7dC
   Oc2jMYDb6NO73vuHNmW+qZVTX4ibbB+NT2Ytu/6bYxMBmZV31TouvEw8i
   1FsRokfPh66har7CmuSjCC7BBeyL3CDNOPFq8lb6LvPOJPOrBCeZd4RKM
   k4xtn58cNmtSk4Kes+JKvQPuu1tlXbEphkTjSvOiE28k/VhQVHHxdhe+d
   g==;
X-CSE-ConnectionGUID: hn5TJ6scSuSC/ZAqkwPcrA==
X-CSE-MsgGUID: GZFCZkNVSd6yIsOQFEwy/A==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="12585216"
X-IronPort-AV: E=Sophos;i="6.08,176,1712646000"; 
   d="scan'208";a="12585216"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 14:38:56 -0700
X-CSE-ConnectionGUID: DGQ7yuvzRpeP50GVaMCv6w==
X-CSE-MsgGUID: 0MqdF6MhR2ehoTcJGZj5ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,176,1712646000"; 
   d="scan'208";a="70084551"
Received: from daliomra-mobl3.amr.corp.intel.com (HELO [10.125.109.51]) ([10.125.109.51])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 14:38:55 -0700
Message-ID: <c683b42c-f75c-427e-b6b0-66babce9b55e@linux.intel.com>
Date: Mon, 20 May 2024 16:31:31 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] ASoC: topology: Constify an argument of
 snd_soc_tplg_component_load()
To: Mark Brown <broonie@kernel.org>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: lgirdwood@gmail.com, tiwai@suse.com, cezary.rojewski@intel.com,
 peter.ujfalusi@linux.intel.com, yung-chuan.liao@linux.intel.com,
 ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
 srinivas.kandagatla@linaro.org, bgoswami@quicinc.com, daniel.baluta@nxp.com,
 linux-sound@vger.kernel.org, alsa-devel@alsa-project.org,
 sound-open-firmware@alsa-project.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <f2f983e791d7f941a95556bb147f426a345d84d4.1715526069.git.christophe.jaillet@wanadoo.fr>
 <1fb69d24-03af-4742-9f44-5a93704f5cfb@sirena.org.uk>
 <b736e11e-430a-462b-898a-d5e1dcf7f74a@wanadoo.fr>
 <baf1789a-a573-470f-b816-ca9bb0d7f299@sirena.org.uk>
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <baf1789a-a573-470f-b816-ca9bb0d7f299@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 5/20/24 08:24, Mark Brown wrote:
> On Sat, May 18, 2024 at 10:34:33AM +0200, Christophe JAILLET wrote:
>> Le 14/05/2024 à 12:21, Mark Brown a écrit :
> 
>>> As mentioned in submitting-patches.rst when submitting a patch series
>>> you should supply a cover letter for that patch series which describes
>>> the overall content of the series.  This helps people understand what
>>> they are looking at and how things fit together.
> 
>> Ok.
>> I usually do, but I thought that the subjects were self-explanatory enough
>> in this case.
> 
>> Do you want me to resend?
> 
> It's fine this time.

no issues with
https://github.com/thesofproject/linux/pull/4993, so

Tested-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

