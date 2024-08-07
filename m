Return-Path: <linux-kernel+bounces-277577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 875A294A345
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 10:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B905289600
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 08:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0591CB329;
	Wed,  7 Aug 2024 08:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="mt1ISLtg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MWKyLLBt"
Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EEA1C9ED8;
	Wed,  7 Aug 2024 08:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723020477; cv=none; b=k8769VljREpr2HPI9OAxDqBMt/LKgiUqYKwmeVRottNbkgJo6mFUPcLJxPUWtq49ws5oMXE744petkLy2bb23Ma29pLx+xmZ+Eabbqj459Hg11t81gYcvb4rtjnnggcCMOAOx/AaSGswhnqyfLOumevGYJOxuWZpAdAdAGlSUJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723020477; c=relaxed/simple;
	bh=D/4g9iSpdCu9/6X1854okWB4SvxpMW9c9SdjmIf3uLo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=gmoMKz9qra41NqF17LKuk7L+2rHTxHbyillIV4fX/hV9O2XsxVa9GnCW5aD3DixIat9TbmVaFMuNnPfHkn9p1vnQo7D9iEnxDah3paeLrEd9ZFQr92f83mXRaR48x2gP2eTgLebnnNRIAUrUJRC+mwo/Btgm0ScRXuQ5SCnUoYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=mt1ISLtg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MWKyLLBt; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id BB9F5138FCCB;
	Wed,  7 Aug 2024 04:47:54 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute4.internal (MEProxy); Wed, 07 Aug 2024 04:47:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1723020474;
	 x=1723106874; bh=8cdJSPVUAdCYHD4i9n6JllUQ32KC29sx+ZdNKg4EM2Q=; b=
	mt1ISLtgJ4wPrVpN8XOSY6V2fc7T6NL6YDE28T+dgv6vXmLuLOJcU5pz4woOUb3e
	ReAGYhEeIVSshGhHWA8im6UczAR20Yy0qsW396qqDYQ1iEq887CcCjf2h2nUqhNh
	fI6WzUvbA3RTvKZhpeQVIuYn/rjW8dicjN6F2MSpIphADJRDpv1qI64P5rUt42dj
	WBpdiL+jiQrS8f65MKmhcxCjld4NfGxCwp9RrMhzRkrPv4ChWQH2kRiqR9Il9IxW
	Nn5BxJhaJuSe9PbDTu4zLZI17axf+uSxYClqL9OgD8bQ2uhEM4mOjY4lA8m7P5Fy
	P34cR+Q6iPmQUY2ndccOJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1723020474; x=
	1723106874; bh=8cdJSPVUAdCYHD4i9n6JllUQ32KC29sx+ZdNKg4EM2Q=; b=M
	WKyLLBtl8lMsgJgcxKinlxOEhOA/emue/bwI8nkTo4b6++1Zsj+oBAzZAj6ghV6Q
	+Cq4UyDgJyz3m99EwTF+TAga2FlY0XJqG75hZ8AYwR2meRV2S3D0FtEs9nL3aNbz
	RS2JWWnxhHHyPTPaRlu1Y8MONGmFM3mh+1tCKWM8+hFZRmKx5pJmkug3Ap00hhpr
	FXwZmmTstnOnGdiJInx79jS33NBXp1hWUq60loFHrkWTHKHU9W9RiliHMNkXzum8
	ea40B36uDsS7CYUZQoIXcxVOHDoydNQ/2bP9vH4uqij3sO0kR6c1AQ8pM61BhpbC
	662+4+Lkj92YFArgGMEJw==
X-ME-Sender: <xms:ujSzZkbyLShVvafvELKLrQJ8LU_Il43rjUcyQ13XW2yH1i1xFYSRqw>
    <xme:ujSzZvYnubeJ9o-xkvo0uhyxKJjcZ98jAwjzHsUSKFlNCCFJ5FEAl-5_dkkL81CJ9
    d-grAHgLTjVYzTAhBk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledtgddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffgvedugeduveelvdekhfdv
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:ujSzZu9f5bXwwafSDSWl3osS70qcTCiNjITSjd91_Nf3Ljy0vS4hEA>
    <xmx:ujSzZur-EX7Rkrt8W-SjNq_hXfdncDFDBoARU450Dgwqwl4egT2n1g>
    <xmx:ujSzZvqJqwBhjuDoGEr1U3QeEf9P8ccTsFNl8vEkZw-N9GxZPXd4cQ>
    <xmx:ujSzZsT3XubuL_13vJq_7MV2WtO1wisvJieE0MkuvI2pEHbk1dCEug>
    <xmx:ujSzZrowJb6m6X8hk1pnkU-pyGTzSCwheNommCjWwymBfNHN60yugiKS>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 17D47B6008D; Wed,  7 Aug 2024 04:47:53 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 07 Aug 2024 10:47:28 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Pierre-Louis Bossart" <pierre-louis.bossart@linux.intel.com>,
 "Arnd Bergmann" <arnd@kernel.org>, "Liam Girdwood" <lgirdwood@gmail.com>,
 "Peter Ujfalusi" <peter.ujfalusi@linux.intel.com>,
 "Bard Liao" <yung-chuan.liao@linux.intel.com>,
 "Ranjani Sridharan" <ranjani.sridharan@linux.intel.com>,
 "Daniel Baluta" <daniel.baluta@nxp.com>,
 "Seppo Ingalsuo" <seppo.ingalsuo@linux.intel.com>
Cc: "Kai Vehmanen" <kai.vehmanen@linux.intel.com>,
 "Mark Brown" <broonie@kernel.org>, "Jaroslav Kysela" <perex@perex.cz>,
 "Takashi Iwai" <tiwai@suse.com>, "Nathan Chancellor" <nathan@kernel.org>,
 "Nick Desaulniers" <ndesaulniers@google.com>,
 "Bill Wendling" <morbo@google.com>, "Justin Stitt" <justinstitt@google.com>,
 "Brent Lu" <brent.lu@intel.com>, sound-open-firmware@alsa-project.org,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
Message-Id: <b821f357-8a11-4814-8ae0-e0e8d8cd4afb@app.fastmail.com>
In-Reply-To: <250c63d7-d81e-49ea-ac8f-2e3496075f20@linux.intel.com>
References: <20240807080302.2372297-1-arnd@kernel.org>
 <250c63d7-d81e-49ea-ac8f-2e3496075f20@linux.intel.com>
Subject: Re: [PATCH] sound: sof: ioc4-topology: avoid extra dai_params copy
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Aug 7, 2024, at 10:37, Pierre-Louis Bossart wrote:
> On 8/7/24 10:02, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> The snd_pcm_hw_params structure is really too large to fit on the
>> stack. Because of the way that clang inlines functions, it ends up
>> twice in one function, which exceeds the 1024 byte limit for 32-bit
>> architecutes:
>> 
>> sound/soc/sof/ipc4-topology.c:1700:1: error: stack frame size (1304) exceeds limit (1024) in 'sof_ipc4_prepare_copier_module' [-Werror,-Wframe-larger-than]
>> sof_ipc4_prepare_copier_module(struct snd_sof_widget *swidget,
>> 
>>>From what I can tell, this was unintentional, as both
>> sof_ipc4_prepare_dai_copier() and sof_ipc4_prepare_copier_module() make a
>> copy for the same purpose, but copying it once has the exact same effect.
>
> Humm, not sure. I think the copy was intentional so that if one of the
> fixups fails, then the initial hw_params structure is not modified.

It's clear that one of the two copies was intentional, however
the same logic exists in the caller, which passes the copied
ref_params into sof_ipc4_prepare_dai_copier() instead of the live
'fe_params'. If sof_ipc4_prepare_dai_copier() fails, the copy
is discarded by returning the error, and otherwise it gets
passed on to sof_ipc4_init_input_audio_fmt().

> Also not sure why a compiler would think inlining such a large function
> is a good idea?

I think clang prefers to inline large functions in order to better
do larger scale optimizations. gcc starts by inlining small leaf
functions and doesn't get to this one.

Note that the actual problem of having two giant structures on the
stack does not change through inlining, the risk of overflowing
the 8kb thread stack and the cost of maintaining these variables
is the same. The only difference is that clang triggers the warning
because it sees the total stack size where gcc doesn't see it.

    Arnd

