Return-Path: <linux-kernel+bounces-240356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27837926CA2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 02:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C93272842B8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 00:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96FB4802;
	Thu,  4 Jul 2024 00:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="HtxxS1jz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i1AAVg1m"
Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FA84C8E
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 00:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720051628; cv=none; b=fKUZKYpr5eO1UhQtwVfDYrJC/0wHrYozLRvbVkkHoaYScCPhEf5OA4Wm801Q+7wwJRthSshG+YBsHvkQb2Tkky4ERFIbWMNWOpeT7KMzGmH6iSHxDra/rm4T16pHr00wFERKPM4KOyUF+xAB508J58aLqtzhkD00FTIvu8Zw6Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720051628; c=relaxed/simple;
	bh=nR/ucJXcJ8cldOFmGkGoepXJjtlHuiS+G7xoHyBIyUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U+PftwGI3iMjoJQf7ap4XLyPwd8eC4tHu8f47g3qH3NHQpysr/Wuf9wYWpz1ad3ol/Pzu42DNAw6qpZMzV+bwPFjwKmr39XODP00hqXOlcuQkxJjZfGwindibkAk3Pe3d2S3yQUuRrfGtni8fbx0xhJAkb45tHCmLZ0J/AoZ/7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=HtxxS1jz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i1AAVg1m; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 43208114009A;
	Wed,  3 Jul 2024 20:07:05 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 03 Jul 2024 20:07:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1720051625; x=
	1720138025; bh=sw9VuEVMWaWe2X2HOhdWK8vj1JPd5Bh8ayDVDAlK70E=; b=H
	txxS1jz3UZCsJsds+T95rneYb+gLU00eEjd55MMut9E5CDv1g0x1aYBjTSIlAdy1
	/lfUqCC4zTG4/T9oJ5h12vrT0p3Pf4iIZr0J6qTx8nQXsR3Z/UJxws006LXSc620
	9eKXk7+jCChgFDVESFXHaETOVTyjcxzVbiVxQS7Y+HLI9zclwmCB0u9WNmkYBvFa
	gjgFqDO5HSTZsip/FPFACYHc5eUzADGGc8g99J3xVkF+MJyGUCvsCFCZehSw5+Jb
	oYxLYB09COq4o5Zgg3xr9S9qpqKpUlnOO3+SBSxrZ4GTz+BLrrvr+xMjR/dlMaOI
	IlLGvbVjJF127KaSQfkDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1720051625; x=1720138025; bh=sw9VuEVMWaWe2X2HOhdWK8vj1JPd
	5Bh8ayDVDAlK70E=; b=i1AAVg1mXGzg/YrKVKHe//CLgIGnxgjHlpO37ru+efmZ
	8MboowEYVYoNxCIhQjDskTCauuSBmpZHg+BJxR/zperDaVfEpDEM3IA6ls/jHSMz
	kdnrH7RXT6Oz/A1uWEdKgGeaA9wc/IOwk3MSzLOFHQBCM/6mUZVWkgPcPlvC9IkL
	MUOmODo/3GesdUbPAANNicHYV3OaeQQcbuZM51knQulmHiYgQjpzn1OEsdSSr753
	dQA/8RpWyj/I2WjVpVNM+JvCeB+7WXEl9+cxjSzV72nF8d28rkCiRBUb10McuixG
	xohb4e0jxDXYBMNH7GPhG27HnB6hyuUOpz6FGycLtw==
X-ME-Sender: <xms:qeeFZiI5Q0muT2r1PhGpnUPPlfrkR2M5OyHRGvC_J9NEN0Z9BxCTuw>
    <xme:qeeFZqL7QQaEo487Nl5nYIWXrLB_qHjxVYOYL_Bj9gjQNC9zzHJLw2RPQrg5oJ_-D
    Se8xznuYoYoPI1VPVA>
X-ME-Received: <xmr:qeeFZisI5F7wsZTgQqYk4KM9jHf_FDUSDWcIGOtlXezm5egbPwUtUJYlcQFfdqDZqkeHsKtutHEGL9ftv00NkOeDuoiU-zikqYo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekgddvlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtre
    dttddtvdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
    shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepveeilefhud
    ekffehkeffudduvedvfeduleelfeegieeljeehjeeuvdeghfetvedvnecuffhomhgrihhn
    pehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:qeeFZnaI9VxY-bMDNwRTigUgktCf7YYfS4tH_dzXNI9SrlZ-ALa4sA>
    <xmx:qeeFZpbiMIqZ89Ss24BX3Qsarzm0uCHy8ZIew1_R-gaISQJAfPu7fQ>
    <xmx:qeeFZjDakTl08opagEmRx9kKnESPE0V5ZzGXNAWVK4SKBVzQ-Hos0g>
    <xmx:qeeFZvaX_sMGpgxZ16aNadp0QKif6_ku7swoiO0KPIFTrJ6FUG6MFg>
    <xmx:qeeFZolsgdPZrrxmKjsDKUhNCSlYwRQLarN6QYsbFiut87toYG62dbid>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jul 2024 20:07:04 -0400 (EDT)
Date: Thu, 4 Jul 2024 09:07:01 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] firewire: ohci: add tracepoints event for data of
 Self-ID DMA
Message-ID: <20240704000701.GA1447446@workstation.local>
Mail-Followup-To: linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20240702222034.1378764-1-o-takashi@sakamocchi.jp>
 <20240702222034.1378764-6-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702222034.1378764-6-o-takashi@sakamocchi.jp>

Hi,

On Wed, Jul 03, 2024 at 07:20:34AM +0900, Takashi Sakamoto wrote:
> In 1394 OHCI, the SelfIDComplete event occurs when the hardware has
> finished transmitting all of the self ID packets received during the bus
> initialization process to the host memory by DMA.
> 
> This commit adds a tracepoints event for this event to trace the timing
> and packet data of Self-ID DMA. It is the part of following tracepoints
> events helpful to debug some events at bus reset; e.g. the issue addressed
> at a commit d0b06dc48fb1 ("firewire: core: use long bus reset on gap count
> error")[1]:
> 
> * firewire_ohci:irqs
> * firewire_ohci:self_id_complete
> * firewire:bus_reset_handle
> * firewire:self_id_sequence
> 
> They would be also helpful in the problem about invocation timing of
> hardIRQ/softIRQ contexts. We can often see this kind of problem with -rt
> kernel[2].

Oops, I misunderstood. The handling of Self-ID DMA buffer is in hardIRQ
and process (workqueue) contexts, thus the above issue is not the
invocation timing of hardIRQ/softIRQ contexts. Let me correct it at the
applied commit comment.

> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d0b06dc48fb1
> [2] https://lore.kernel.org/linux-rt-users/YAwPoaUZ1gTD5y+k@hmbx/
> 
> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> ---
>  drivers/firewire/ohci.c              | 11 +++++-
>  include/trace/events/firewire_ohci.h | 54 ++++++++++++++++++++++++++++
>  2 files changed, 64 insertions(+), 1 deletion(-)


Regards

Takashi Sakamoto

