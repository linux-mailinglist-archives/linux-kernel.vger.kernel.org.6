Return-Path: <linux-kernel+bounces-280894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60BD194D08B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 14:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1812628461F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 12:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F877194A60;
	Fri,  9 Aug 2024 12:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R9yC+uRm"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8C0194A40;
	Fri,  9 Aug 2024 12:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723207984; cv=none; b=r24NBwoo1qhptLTF1HmSbK6BBEe+B7tKf/qbIjUsAZhuw+A9QKMUlRmNaesGbHu1vi4Eqh7Q96rhi1hj4N0K+sX3YQirAyXlD7XCUYmDWKh/7/8VC48cJekskybi0LkbA27mPL98ErcXZh4Uqrxp1+BzREIcZWgE1dksOlGggsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723207984; c=relaxed/simple;
	bh=StJCn56NfSCbXiuX84fVBJOp8AURT5jnW7GtHmbmadE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B5UaidcqeZkUscffxhIlMluT5sCO/MeHGRqAnWLyIDZ+jsKhU6ndQO3RL8gjzW5pa+WSSQ7XBNCVgBiSATwtz4l4jHVMrZlkHV2k5AURsmm/KWDdisrYunHXbGPsg6eY/6BhY+Ie1GLX04YiUdUp6zNnYpFj/DPY9Oo4w6KgDS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R9yC+uRm; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723207983; x=1754743983;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=StJCn56NfSCbXiuX84fVBJOp8AURT5jnW7GtHmbmadE=;
  b=R9yC+uRmgX5sxVQ7RD1i+VLOgaOqbSsYt4CLIoa0EvUumm3WtiSTjcJG
   H8mtATyZe+bOyz26cFOTRqshffttjdKC5PGMeNebTy1xU332hPO7mzidH
   shg2LaDuDIpDWRwY1DCnoXW/52NGYEyMCo88NwfMe7VhIUNHOFn0rXWWL
   HcbyGk1T4HeLtB+J3CFEFouRivgjDetgXEKkUb56z8kzXPZFoNNBKM3Qc
   dPf8/hNP6HwBVnzawYhguA4Nlb/2OWbLESxu3mUYgV35InzAiqxIT81OZ
   g8TPwdcJ6PypFHcdzCem0zjn9WeAPTKmN0KKC5c9A3Pims4qWb1DogTjX
   w==;
X-CSE-ConnectionGUID: 8J9lre/5S6aCpA5zpYHEzg==
X-CSE-MsgGUID: QzS1qJ9/SX+8wf7rMYy2FA==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="20942064"
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="20942064"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 05:53:03 -0700
X-CSE-ConnectionGUID: HUnwVTzaQ3um/ldO5hPmgA==
X-CSE-MsgGUID: iVCjZyP7QSiYLwxvT1CzWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="80791690"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO [10.245.246.249]) ([10.245.246.249])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 05:52:58 -0700
Message-ID: <542d47c5-7ce3-4c17-8c0a-3a2b2a9e6c6a@linux.intel.com>
Date: Fri, 9 Aug 2024 14:52:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/6] ALSA: compress: add Sample Rate Converter codec
 support
To: Shengjiu Wang <shengjiu.wang@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>, Shengjiu Wang <shengjiu.wang@nxp.com>,
 vkoul@kernel.org, tiwai@suse.com, alsa-devel@alsa-project.org,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 Xiubo.Lee@gmail.com, festevam@gmail.com, nicoleotsuka@gmail.com,
 lgirdwood@gmail.com, broonie@kernel.org, linuxppc-dev@lists.ozlabs.org
References: <1722940003-20126-1-git-send-email-shengjiu.wang@nxp.com>
 <1722940003-20126-2-git-send-email-shengjiu.wang@nxp.com>
 <e89a56bf-c377-43d8-bba8-6a09e571ed64@linux.intel.com>
 <CAA+D8AN9JXJr-BZf8aY7d4rB6M60pXS_DG=qv=P6=2r1A18ATA@mail.gmail.com>
 <ffa85004-8d86-4168-b278-afd24d79f9d8@linux.intel.com>
 <116041ee-7139-4b77-89be-3a68f699c01b@perex.cz>
 <930bb152-860a-4ec5-9ef0-1c96f554f365@linux.intel.com>
 <c9039808-cd04-452d-9f6c-f91811088456@perex.cz>
 <ed1192e0-00e7-4739-a687-c96dc2d62898@linux.intel.com>
 <CAA+D8AMOh=G7W5-dYw_=Xx-s0PqEu2suKYorscoWku86Rn-=+A@mail.gmail.com>
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <CAA+D8AMOh=G7W5-dYw_=Xx-s0PqEu2suKYorscoWku86Rn-=+A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


> Why I use the metadata ioctl is because the ALSA controls are binding
> to the sound card.  What I want is the controls can be bound to
> snd_compr_stream, because the ASRC compress sound card can
> support multi instances ( the ASRC can support multi conversion in
> parallel).   The ALSA controls can't be used for this case,  the only
> choice in current compress API is metadata ioctl. 

I don't know if there is really a technical limitation for this, this is
for Jaroslav to comment. I am not sure why it would be a problem to e.g.
have a volume control prior to an encoder or after a decoder.

> And metadata
> ioctl can be called many times which can meet the ratio modifier
> requirement (ratio may be drift on the fly)

Interesting, that's yet another way of handling the drift with userspace
modifying the ratio dynamically. That's different to what I've seen before.

> And compress API uses codec as the unit for capability query and
> parameter setting,  So I think need to define "SND_AUDIOCODEC_SRC'
> and 'struct snd_dec_src',  for the 'snd_dec_src' just defined output
> format and output rate, channels definition just reuse the snd_codec.ch_in.

The capability query is an interesting point as well, it's not clear how
to expose to userspace what this specific implementation can do, while
at the same time *requiring* userpace to update the ratio dynamically.
For something like this to work, userspace needs to have pre-existing
information on how the SRC works.

