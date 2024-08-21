Return-Path: <linux-kernel+bounces-295674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2992959FE4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 16:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0792DB22FBC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 14:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4C51B2536;
	Wed, 21 Aug 2024 14:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="GcT3GiWT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M6jgqntJ"
Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0832A1B2522
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 14:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724250567; cv=none; b=mZ+O9JcYXXczMh4r9iyzQj82Ku+yQ16OfP6zGDHJHKN4+9A9fJ6uEFiyl6n2bEY+4GNv27Xq3pxNPCgNMk0jh4RSQyKRJMHtb07HjnYR4+xKm6iES1O6hmDp6VcttsHNOpJtoO8EwE8sd8Cknx5JnAWx9g+WJo5RJLwXDiBnGns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724250567; c=relaxed/simple;
	bh=TNRz++CAXpZTrQ+rDNgu/qHAFygHO1FeBVjKw/UuqVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aV3jjWOV4NF5v2N1ParVAPu5uBJLwdv8dKRW7y/oRlSvRWRl0vMwuOo62ruhtZkqGbQ0tu6QhCthxJ5F6H2xC6z03hzaEHAKlV40RmMVozMWa7Y7gmvMTH101fR+iQjkUUOrADpwcJdnFOPTRySC2NLSzyD1PnU953SErOgbOUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=GcT3GiWT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M6jgqntJ; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-06.internal (phl-compute-06.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 16E47138FEBB;
	Wed, 21 Aug 2024 10:29:24 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 21 Aug 2024 10:29:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1724250564; x=
	1724336964; bh=KjMAVAcSGnfZBXM47hogT6pOxUn239BFkFX3wckyOlU=; b=G
	cT3GiWTC7Yi+d9iN2CIMzd5qiDYwKM6oRIhBMN5KMJmHVEov1ur/+Un2IJiDx5xl
	BhKsg9z65d7N6YXP/79cZeVB1U5Vhc5bUhoXYb+x+jb/xoFsNAUWFDQCyfgobPvp
	6IeVCLk6vgw1bp+vdKKqIciNz5A6lX9edWA4f5Yt5aBvopE826k5ysLuF4xTcjXY
	lArH48j3znArJTgMlA/DFn0/jlutGrt0oPqiYSMAdtDxIP3i6a9ldY7eaOqpTbiN
	em01updDc0Cfc2KQJPoyM0LFZSHkAQswotuq1DweG2WDGD5szvmC1QsNgcQMYyht
	wN9ndDlZ1UoEdYWBeIxuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724250564; x=1724336964; bh=KjMAVAcSGnfZBXM47hogT6pOxUn2
	39BFkFX3wckyOlU=; b=M6jgqntJrns2iOEYOiIQmoVudHIeOXMio/xIEH4l4dIo
	AQ2HbTy3wmZggKB5jHpFKpC9X+wP7YVkm/iPJl+RvHHis5hByFxR6hE2SlZRYZJe
	7tIAOQZtdHMjB4aY99SSwbxrqkVmdnkw/Wm2BucA/WjHjL9T2lTGwql1RsoM4AN5
	ut5ve9n1dRhIFWKoiQAIT1pBlTVzPeNUUo6EkJJf51IRRfzeAjOlLGo/U/jc9EP0
	zktojJIguoi+BkQa+Xsa6gJ6h11wPtmrL3WNGiOFUQApZqaFMMJX/6NwMOYbU12v
	Xkcfmh9YsYSlTUs43qz70Tfc9HnAHggG6nY9NVHG4Q==
X-ME-Sender: <xms:w_nFZiGDFi5l0IA-jMps3FdZQyJ34M0yzlvZFW7bj4exrZTVerfBcw>
    <xme:w_nFZjWXx6GDAVNeLhmLbwLNPoXERZE5IPweZCqhtqz_dMOXUHg4N3zPygVNaKWjX
    BB_Jyj-_B7g5EQlvmc>
X-ME-Received: <xmr:w_nFZsJXEYZbHC7O3rNwvLbXevtsPdu4kldutezou54ub7a58tXdCYUzmVXfZC82deQrFYcAEdnGNPe2Zf5mlbJ2MzSrMbNthg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddukedgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhhihessh
    grkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepveeilefhudekffehkeff
    udduvedvfeduleelfeegieeljeehjeeuvdeghfetvedvnecuffhomhgrihhnpehkvghrnh
    gvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhppdhnsggprhgtphhtth
    hopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeiiihhjuhhnpghhuhesihgt
    lhhouhgurdgtohhmpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrth
    hiohhnrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidufeelgedquggvvhgvlheslhhish
    htshdrshhouhhrtggvfhhorhhgvgdrnhgvthdprhgtphhtthhopehquhhitggpiihijhhu
    hhhusehquhhitghinhgtrdgtohhm
X-ME-Proxy: <xmx:w_nFZsEV9hGT29NSd3GTszkMnbeY_p-VkBdZq4W8FW6Beyv0Yf4Zag>
    <xmx:w_nFZoVtgmVLpU-DIwoT4WPHH0SGMIa_w-YzyA6LOeq4dGvVnhspkQ>
    <xmx:w_nFZvO7cDQ9kaXvQgt3tu0Yldah_-UbOeedohmTCsEivo6DeHbYzg>
    <xmx:w_nFZv3pfQ3VXWv0tv_p3BW01BzNeUZ9sAckDGj6GuuKeRqB9Czfvw>
    <xmx:xPnFZidrllUSAVrqmNu5iz32rfTVBLTTRW5iYAXPjFF7KCntB0GGSWx0>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Aug 2024 10:29:22 -0400 (EDT)
Date: Wed, 21 Aug 2024 23:29:20 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
	Zijun Hu <quic_zijuhu@quicinc.com>
Subject: Re: [PATCH v2 3/4] firewire: core: Prevent device_find_child() from
 modifying caller's match data
Message-ID: <20240821142920.GB48808@workstation.local>
Mail-Followup-To: Zijun Hu <zijun_hu@icloud.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
	Zijun Hu <quic_zijuhu@quicinc.com>
References: <20240815-const_dfc_prepare-v2-0-8316b87b8ff9@quicinc.com>
 <20240815-const_dfc_prepare-v2-3-8316b87b8ff9@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815-const_dfc_prepare-v2-3-8316b87b8ff9@quicinc.com>

Hi,

On Thu, Aug 15, 2024 at 10:58:04PM +0800, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> To prepare for constifying the following old driver core API:
> 
> struct device *device_find_child(struct device *dev, void *data,
> 		int (*match)(struct device *dev, void *data));
> to new:
> struct device *device_find_child(struct device *dev, const void *data,
> 		int (*match)(struct device *dev, const void *data));
> 
> The new API does not allow its match function (*match)() to modify
> caller's match data @*data, but lookup_existing_device() as the old
> API's match function indeed modifies relevant match data, so it is not
> suitable for the new API any more, fixed by implementing a equivalent
> fw_device_find_child() instead of the old API usage.
> 
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
>  drivers/firewire/core-device.c | 37 +++++++++++++++++++++++++++++++++++--
>  1 file changed, 35 insertions(+), 2 deletions(-)

Please drop this patch from your series since I applied another patch[1] to
for-next branch.


[1] https://lore.kernel.org/r/20240820132132.28839-1-o-takashi@sakamocchi.jp

Thanks

Takashi Sakamoto

