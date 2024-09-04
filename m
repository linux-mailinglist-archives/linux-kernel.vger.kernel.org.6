Return-Path: <linux-kernel+bounces-314755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB88F96B804
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 12:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 660891F2226B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 10:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC851EBFEB;
	Wed,  4 Sep 2024 10:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="q/zIbPxd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fyQfGcx/"
Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E2C14658C
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 10:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725444909; cv=none; b=ACu+2pFRLcWnEz4Hem6vG0t2hLfyv6wPTHTtcIhBoGbHOMmoJumyhTx+LdboRz4FDZpCZ3nfPXdBnFr6JCtsL4HwQHhZKCfkXUgtuTT1MwzklLWZ05KT9unBFzJlEH/ttcjjqsBwhLGK9mUi7a7SKN8MOLmBs2SoLwVOQSZwtZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725444909; c=relaxed/simple;
	bh=EfXlBmZw6IiE7Jq3QPpycLR2cm/ieebGMAgReOlbRmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FUqzu8fjZoktejx75vWSmeMyCIbRQj9ir4f7Q3OMuDmjCbH/bWgGQ9rNslUSA0y3wg++BvVkvxFDP6Z/6YAsPHBtfohc1JAEw+Prs1uA1U4vW2MSWo7/PHgMLMXjCznta1so/Y/Ddlf/7lMfGKjFjOhJkK10A/aUtQwPgfHr+Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=q/zIbPxd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fyQfGcx/; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E9F51114024E;
	Wed,  4 Sep 2024 06:15:06 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 04 Sep 2024 06:15:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1725444906; x=
	1725531306; bh=NICRXsHVZn38zfbA1RWDA2vC04hYOdWZ0/xCYE5ibDA=; b=q
	/zIbPxdrwGFwiAKwQm6MW6G6+WDRQH276AzCzprr+RHP4DuAk4VHKh1rcIOrccsh
	k117wgQ1DnkOuG+ZnHvop89YsmC165uoU63vBxk7Vruzm4FrDE5HKJvriPUjuvXR
	rdH1Y+4gzExAh8dekXJY/TgR+egAxP+5EXD3OK62S3G/UM+PZF/uh9/3w5uLlShi
	mKtCU+ygQu9kryALpVc+lSqPT9ZHn3/ifGepf11fnR4dhPpc/ox26ol0abh3Hwe0
	AvewyKjbHB48rsYlaMSduscsWWSIFdA3DrEPn7NWjOGlu5Iegev5htXnkt0Rzebo
	skLkM5F6nGNvaSUBoNxUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725444906; x=1725531306; bh=NICRXsHVZn38zfbA1RWDA2vC04hY
	OdWZ0/xCYE5ibDA=; b=fyQfGcx/p8jBfNPg8WeKctuwUrCH7TKWxy427dkX3QOX
	bGLkz14rhv24FTQ7aq3HVafX7Z5eHshBpwja18nRv1N8j/PGtKwPoggh9V8Il1lw
	GQQ55krU+XitVheJ5GLoOoLXZH/aY/t1o6YMHnblpZOAXIohZz7As1OshTvVAcnv
	0mVWEjxN5Z9p8kvNq+ZOtXDMEo5b1rvHx95v0NhX0/ByvjOFAJRZfhH5kP+sGVmn
	zsSNDwUptaZMD1hmm9dduF2Md/fP4RcurxczzA1SNPYwI6Mk9LsvPuYqJXmHiRqh
	Ktu55nA+s61YxkPSQvfkuglGnPcI7gnW28gOlNMiRQ==
X-ME-Sender: <xms:KjPYZhXRCuamrOYJjxoKPBrvMp1enaoXT6VrlOfYJlYmfaTnfv-qbg>
    <xme:KjPYZhkAxufhhez12BJqJ6pfmfRUaDM3Wz1XMs0zrvXP5B3CXChPoNYHz4W1YXOfu
    0waMSC4krQH33n8XLQ>
X-ME-Received: <xmr:KjPYZtbY0E-iUGq2tMpW3t1KTat4dgP5UbL5fR7lEX6HGOndwkLlLtVNbnlbNPxepu7fFogp0b407aNJD6JX3ONm1KKBqq4VfTk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehjedgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvrghkrghshhhiucfurghkrghm
    ohhtohcuoehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrg
    htthgvrhhnpeehhffhteetgfekvdeiueffveevueeftdelhfejieeitedvleeftdfgfeeu
    udekueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhppdhnsggprhgtphhtthhopedv
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigudefleegqdguvghvvg
    hlsehlihhsthhsrdhsohhurhgtvghfohhrghgvrdhnvghtpdhrtghpthhtoheplhhinhhu
    gidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:KjPYZkUD6FxbnZ49sO8HL2-67TuaZ04xnDE2ibw90kyhEw4cowtjWQ>
    <xmx:KjPYZrkmmReSZJE67IkxsTK-OCkRIeMmZnIRRpJXwYRnegkV2T8z7g>
    <xmx:KjPYZhdPckbHsqW1G8bSxCGed2JhaAxIDuCTVHPw_vghbRPeIpxmhA>
    <xmx:KjPYZlHoi__R3ASdEpdV88JaZB3L0nQSj8f2Xpi-WFBaQQ585YAUAw>
    <xmx:KjPYZgzyUmYHz5XRzH7AEvSWTm4Gq7BLGt-Xiy4dAqNhShJ6F5peq3lJ>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Sep 2024 06:15:05 -0400 (EDT)
Date: Wed, 4 Sep 2024 19:15:03 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firewire: ohci: deprecate debug parameter
Message-ID: <20240904101503.GB437448@workstation.local>
Mail-Followup-To: linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20240903101455.317067-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903101455.317067-1-o-takashi@sakamocchi.jp>

On Tue, Sep 03, 2024 at 07:14:55PM +0900, Takashi Sakamoto wrote:
> Many tracepoints events have been added to 6.10 and 6.11 kernels. They are
> available as an alternative of debug parameter in firewire-ohci module.
> 
> The logging messages enabled by the parameter require some cumbersomes in
> a point of maintenance; e.g. the code to decode transaction frame.
> 
> This commit adds deprecation text to conduct users to them..
> 
> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> ---
>  drivers/firewire/ohci.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Applied to for-next branch.


Regards

Takashi Sakamoto

