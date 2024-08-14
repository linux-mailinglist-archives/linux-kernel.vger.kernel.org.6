Return-Path: <linux-kernel+bounces-286204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95AF19517E4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 11:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEB291C20D2A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 09:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B033A166307;
	Wed, 14 Aug 2024 09:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h0zYzBZj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673C013A418;
	Wed, 14 Aug 2024 09:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723628427; cv=none; b=mnoTX7hOcmQh//k18gaSO4qBY2OELp4R+tqY8iSp9Ouy8Oz/hBL8ZLROdx/5i+RfchNH45/KeFvvitPdcJuhGj7IklFQ0zHmAPBp2sROOMw9oZBre/SEcLNHleJlBU6++t0ES5j6qiyobdL6mruBEVQnSiRv3xohXYpC9PI9L7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723628427; c=relaxed/simple;
	bh=Oqk/yZOBqPAJ0OhO/1w+U3YacKqLDREg7ya+gkJZJJY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OG8pSO8lK5tafk3w3KIr2gGLybRKsfzOjOq4VHIqpbSa/auJNcgw/Jrnud7fqeKUTT7lXu3lEGp7G84qa8Q7BzFXdL7eWFGjpfSx1YG6KxEYdTWE8QiuWihOOLBwMJIWaDuAHOTjePxa9K2EGHeYYxvoC8IdHvQYUWb9ankfWOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h0zYzBZj; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723628426; x=1755164426;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Oqk/yZOBqPAJ0OhO/1w+U3YacKqLDREg7ya+gkJZJJY=;
  b=h0zYzBZjydmCvUY1QprEJUOuDwWU42wUJTfD3SFo6fxEx7AZAl26DW9V
   Y4L74kpbPZlecYgbRPPslV0+iKSH/LHAzZjSAkSSx0Vd2Fb8cySqTxL8Z
   AzKewHqqfFFHJLTKsvvnM8retey2Rf9vrLOjBDTLe73yhrZQ6SUwbOgwC
   haw7s67gSV+akB4tJgkhVZsnoBS40j62FukvF7HqVoCrZ5OSSv+/iTgPF
   2hBv08+2xZssqRiWh1IvNgw8lAV2rLh07nZh+bLa/jnr1GTG5q0lBXOqX
   YiLb2vnKLqLiXG55IcfAwkxm2T/PgccR5FSMBba2uPnn3SiY35eQ4lZ+W
   w==;
X-CSE-ConnectionGUID: 5D0JWrkITFug+gXuWW3Y5g==
X-CSE-MsgGUID: wA9eMzSwTKqe2EUd4bIpNw==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="25635381"
X-IronPort-AV: E=Sophos;i="6.09,288,1716274800"; 
   d="scan'208";a="25635381"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 02:40:25 -0700
X-CSE-ConnectionGUID: QoDtG2jcQa6/Jw1/h4JPTA==
X-CSE-MsgGUID: 8/qT9Z0oRlGlDA7pwKz4LQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,288,1716274800"; 
   d="scan'208";a="58918758"
Received: from slindbla-desk.ger.corp.intel.com (HELO [10.245.246.67]) ([10.245.246.67])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 02:40:20 -0700
Message-ID: <3cdb2041-59d4-4d43-ac4d-39d7f9640cef@linux.intel.com>
Date: Wed, 14 Aug 2024 11:40:18 +0200
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
 <542d47c5-7ce3-4c17-8c0a-3a2b2a9e6c6a@linux.intel.com>
 <c3b8f7b8-fc5e-4285-bee8-7edd448a405d@perex.cz>
 <CAA+D8ANg7C7vuxU44mAG8EnmcZjB_te5N_=4M4v_-Q9ZyPZ49g@mail.gmail.com>
 <2be4303e-58e1-4ad7-92cf-f06fa6fa0f08@perex.cz>
 <7dc039db-ecce-4650-8eb7-96d0cfde09a2@linux.intel.com>
 <CAA+D8AMv=tHV3b-Rfo9Pjqs0bX5SVschD=WD06qxjJOk5zQmiQ@mail.gmail.com>
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <CAA+D8AMv=tHV3b-Rfo9Pjqs0bX5SVschD=WD06qxjJOk5zQmiQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


> Yes, to go further, I think we can use SND_AUDIOCODEC_PCM, then
> the SRC type will be dropped.

sounds good.

> But my understanding of the control means the .set_metadata() API, right?
> As I said, the output rate, output format, and ratio modifier are applied to
> the instances of ASRC,  which is the snd_compr_stream in driver.
> so only the .set_metadata() API can be used for these purposes.

Humm, this is more controversial.

The term 'metadata' really referred to known information present in
headers or additional ID3 tags and not in the compressed file itself.
The .set_metadata was assumed to be called ONCE before decoding.

But here you have a need to update the ratio modifier on a regular basis
to compensate for the drift. This isn't what this specific callback was
designed for. We could change and allow this callback to be used
multiple times, but then this could create problems for existing
implementations which cannot deal with modified metadata on the fly.

And then there's the problem of defining a 'key' for the metadata. the
definition of the key is a u32, so there's plenty of space for different
implementations, but a collision is possible. We'd need an agreement on
how to allocate keys to different solutions without changing the header
file for every implementation.

It sounds like we'd need a 'runtime params' callback - unless there's a
better trick to tie the control and compress layers?


