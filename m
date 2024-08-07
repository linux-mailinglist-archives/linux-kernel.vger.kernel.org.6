Return-Path: <linux-kernel+bounces-278252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D6894AE1C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 18:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B5BD1F22BBF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 16:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89856137776;
	Wed,  7 Aug 2024 16:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PajLKMfh"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFC67829C;
	Wed,  7 Aug 2024 16:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723047725; cv=none; b=oayMhQW/dtUKCfXFayTA6AY5Kiby+Q8BANM4NwWgOyEygBAriFK+i75ZGv+9/8tPNixPBVpLPQ2o3+393R0p36Wo/FfTIOiMzGhwf/4BOB0Ygj0AVw2ZN5VN92D6bCZAiUNxvHai93Yc3M/5e674AWeuzQjd+wQzJvenR1O/grs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723047725; c=relaxed/simple;
	bh=csoxM504M/IKkeAwQJU4vJ16AtPpU2Ww21JXNHIvTgo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gbXYciCaJKiBc79WuenjUE/7DU0YHmzK674jaNnNufDPo2COU+SFhgOrvL0yrX4aBltTJokzDmvAS9sBzR/ZZD7YqlGCagAhM1SsXXUt/levD8Hl1K5S1hGmcjo/9Y9Bw29sXQzxRabltH4BZjJQWqpNkGYk/Hdg0CJ7mbvZQRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PajLKMfh; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723047724; x=1754583724;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=csoxM504M/IKkeAwQJU4vJ16AtPpU2Ww21JXNHIvTgo=;
  b=PajLKMfh/WOtJ9WiwEeC0wLMwkLlcJfZjPmcncs/ZCaiibhmiYY7+mcx
   XGbHAGqRK0VfEQjQW8vbk15vwU0bLUzEE0vK7dtTuZwBpXyzMLXIJZoVu
   ILiNp41yJncnlgJz3BCUFJQWZLxGieTRRELfcscuvhfiTaBPmWhpypvxy
   +FghqhUHatWFluX03KNRH0C67a2tF7CFrV/+JL1T4H+/8j78Nw7WvMBQh
   pK7HIpsHxAuN84F8DDJgcO2vxJzOay744SWisBJSJTETSu2s/Pv8fCkpj
   mnvZVGpGXXC+KSaUNFjk4/BoVLnZHd6QayMt098HYkIvfX63wVY0LBit+
   w==;
X-CSE-ConnectionGUID: rgFOp8S9S82QzEZZFAeO5Q==
X-CSE-MsgGUID: 3MPUVaRZSYyZiH+VkIt6yw==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="21251596"
X-IronPort-AV: E=Sophos;i="6.09,270,1716274800"; 
   d="scan'208";a="21251596"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 09:22:03 -0700
X-CSE-ConnectionGUID: lcWSrhGmRom/U+ItrnaNKA==
X-CSE-MsgGUID: HiDpRUBGSwSm3VMuqQ/oXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,270,1716274800"; 
   d="scan'208";a="57602771"
Received: from opintica-mobl1 (HELO [10.245.245.20]) ([10.245.245.20])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 09:21:56 -0700
Message-ID: <a91373cef3d55ba7f13f347e2b10b2398c347c35.camel@linux.intel.com>
Subject: Re: [PATCH] sound: sof: ioc4-topology: avoid extra dai_params copy
From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
To: Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>, Arnd
 Bergmann <arnd@kernel.org>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam
 Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi
 <peter.ujfalusi@linux.intel.com>, Bard Liao
 <yung-chuan.liao@linux.intel.com>, Daniel Baluta <daniel.baluta@nxp.com>, 
 Seppo Ingalsuo <seppo.ingalsuo@linux.intel.com>, Kai Vehmanen
 <kai.vehmanen@linux.intel.com>, Jaroslav Kysela <perex@perex.cz>, Takashi
 Iwai <tiwai@suse.com>, Nathan Chancellor <nathan@kernel.org>, Nick
 Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>, Brent Lu <brent.lu@intel.com>,
 sound-open-firmware@alsa-project.org,  linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Date: Wed, 07 Aug 2024 09:21:46 -0700
In-Reply-To: <d988fe89-104e-46ce-94b7-6754f2c7a455@app.fastmail.com>
References: <20240807080302.2372297-1-arnd@kernel.org>
	 <731fa66a-bed7-45fb-9187-a9263612eac4@sirena.org.uk>
	 <d988fe89-104e-46ce-94b7-6754f2c7a455@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0-1build2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-08-07 at 17:18 +0200, Arnd Bergmann wrote:
> On Wed, Aug 7, 2024, at 17:09, Mark Brown wrote:
> > On Wed, Aug 07, 2024 at 10:02:27AM +0200, Arnd Bergmann wrote:
> >=20
> > > From what I can tell, this was unintentional, as both
> > > sof_ipc4_prepare_dai_copier() and
> > > sof_ipc4_prepare_copier_module() make a
> > > copy for the same purpose, but copying it once has the exact same
> > > effect.
> >=20
> > > Remove the extra copy and change the direct struct assignment to
> > > an explicit memcpy() call to make it clearer to the reader that
> > > this
> > > is what happens. Note that gcc treats struct assignment as a
> > > memcpy()
> > > that may be inlined anyway, so the resulting object code is the
> > > same.
> >=20
> > The effect of the copy is to ensure that if the function fails the
> > argument is unmodified - did you do the analysis to check that it's
> > OK
> > to modify on error?=C2=A0 Your commit log says "the same purpose" but
> > never
> > specifies what that purpose is.
>=20
> There is always a chance that I misunderstood the code, but
> yes, I did understand that the idea is to not modify the
> parameters inside of sof_ipc4_prepare_dai_copier.
Hi Arnd,

The idea behind the local copy is that the DAI widget needs to handle
its audio formats in topology differently from the other widgets in the
pipeline. So, locally the sof_ipc4_prepare_dai_copier() modifies the
params to make sure the right NHLT blobs are chosen based on what's
available in topology and the information passed in the params. But
when the params variable is passed on to the next widget in the
pipeline, any local modifications done by the DAI widget should be
carried forward.

For your reference, this is code that does the propagation of the
prepare callback for each widget in the playback/capture path in the
pipeline.
https://github.com/thesofproject/linux/blob/bc47b82db6e03d540061964d4540a37=
1e7d344c8/sound/soc/sof/sof-audio.c#L442

Thanks,
Ranjani

