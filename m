Return-Path: <linux-kernel+bounces-281462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9236494D722
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 21:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03EB8B21F32
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 19:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C37015F404;
	Fri,  9 Aug 2024 19:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aYwMTqYy"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377C1182B3;
	Fri,  9 Aug 2024 19:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723231247; cv=none; b=l3uVrPTCYJ0YNFfeR9lJNJUYvMNOlUr4qdG/jiaGn2hbTKkKmspSSpITapQomJFVTYXS46KGl0cH0YYu0SxmGM7wZj506I7xSKLrBOFunosLJlJN3ozkSvZdqur2AhDKtBfhCdJh/sxO+o3yhdDnMxXlfkpmWcKKk6CovpKFTAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723231247; c=relaxed/simple;
	bh=EjHqHHKYoRZX3HoUBZAvpzA3I2pO6ift5GDZ3LPhRnc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kjwvBSjivkbFr/e9qSKrftwT4EjLIle48hmUMmLAAZSg0E+nkIOUnOXZ5s7KcyGgCs3O+F9ZEynNar7IFuRj4L4AC8hA+mDOzBAb1TOJRuJkRDKuuQqTyl/0SrEEMasbEa3RpZJtbvjmR7TyKwGap5fJFGIZCxN9PoEhD5jQ504=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aYwMTqYy; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723231246; x=1754767246;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EjHqHHKYoRZX3HoUBZAvpzA3I2pO6ift5GDZ3LPhRnc=;
  b=aYwMTqYyuECREOYI5c8Z2kVgbU90QGlnCWt4C8IqNwX0it51KkFKNGU5
   4cfzpnFJTCfZV+mUq0rRq7RevQufywSzyVkpmkNos2KdZsE05gc7EZVcB
   2jsvI+1b1rc5L1NHQ5u7e10sBY0SHHyV84gU319/tk6dcWztirWx2vqfT
   +frv9ZP9ZN/1aT0JiP7r2+jLMXdmSTTiaHuhJqMtAwIfOO5/FEbv/WUhm
   +wQIojrNQRQL6gEvd/ZMweHmEl/2beN/n0nqm5HnBFsUk7bNVwddd8o5/
   9WLs0QyJ2JkO686oyMWPWNXZTOFjX5el/lziUQMmVoZYBXJNcOPN0HXV2
   Q==;
X-CSE-ConnectionGUID: 9ptTgab+Toq8IBNiKq1dlg==
X-CSE-MsgGUID: l8UO9hHFR1qmOl918+J7yQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11159"; a="25285238"
X-IronPort-AV: E=Sophos;i="6.09,277,1716274800"; 
   d="scan'208";a="25285238"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 12:20:45 -0700
X-CSE-ConnectionGUID: WCOiZLDZT+WOhIWdX/i3CQ==
X-CSE-MsgGUID: UZY+OjWrRDqm300lv/H98g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,277,1716274800"; 
   d="scan'208";a="61793214"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO [10.245.246.249]) ([10.245.246.249])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 12:20:41 -0700
Message-ID: <a41029df-a1a3-4540-b28d-55fbfc3dcf1c@linux.intel.com>
Date: Fri, 9 Aug 2024 21:20:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/6] ALSA: compress: add Sample Rate Converter codec
 support
To: Jaroslav Kysela <perex@perex.cz>, Shengjiu Wang <shengjiu.wang@gmail.com>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, vkoul@kernel.org, tiwai@suse.com,
 alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
 nicoleotsuka@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
 linuxppc-dev@lists.ozlabs.org
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
 <542d47c5-7ce3-4c17-8c0a-3a2b2a9e6c6a@linux.intel.com>
 <c3b8f7b8-fc5e-4285-bee8-7edd448a405d@perex.cz>
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <c3b8f7b8-fc5e-4285-bee8-7edd448a405d@perex.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



>>> And metadata
>>> ioctl can be called many times which can meet the ratio modifier
>>> requirement (ratio may be drift on the fly)
>>
>> Interesting, that's yet another way of handling the drift with userspace
>> modifying the ratio dynamically. That's different to what I've seen
>> before.
> 
> Note that the "timing" is managed by the user space with this scheme.
> 
>>> And compress API uses codec as the unit for capability query and
>>> parameter setting,  So I think need to define "SND_AUDIOCODEC_SRC'
>>> and 'struct snd_dec_src',  for the 'snd_dec_src' just defined output
>>> format and output rate, channels definition just reuse the
>>> snd_codec.ch_in.
>>
>> The capability query is an interesting point as well, it's not clear how
>> to expose to userspace what this specific implementation can do, while
>> at the same time *requiring* userpace to update the ratio dynamically.
>> For something like this to work, userspace needs to have pre-existing
>> information on how the SRC works.
> 
> Yes, it's about abstraction. The user space wants to push data, read
> data back converted to the target rate and eventually modify the drift
> using a control managing clocks using own way. We can eventually assume,
> that if this control does not exist, the drift cannot be controlled.
> Also, nice thing is that the control has min and max values (range), so
> driver can specify the drift range, too.

This mode of operation would be fine, but if you add the SRC as part of
the processing allowed in a compressed stream, it might be used in a
'regular' real-time pipeline and the arguments  and implementation could
be very different.

In other words, this SRC support looks like an extension of the compress
API for a very narrow usage restricted to the memory-to-memory case
only. I worry a bit about the next steps... Are there going to be other
types of PCM processing like this, and if yes, how would we know if they
are intended to be used for the 'regular' compress API or for the
memory-to-memory scheme?

