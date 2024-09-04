Return-Path: <linux-kernel+bounces-314754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 897CE96B802
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 12:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EB891F2262E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 10:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4A31CF2AB;
	Wed,  4 Sep 2024 10:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="rrTiHmf2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PcJcJnAM"
Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663211CC16B
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 10:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725444879; cv=none; b=Gp6gLDN0xYMgPnndTZ3D2/v+WO7ZtJTn6dItGje8w45QrXsLHHQbVN0RwEqEasfqeqXu5aT6th6saeSi042+A/LzOpAo4Aj9GWfDhLNn4ubc2AkxpPVhn9p1NwJSr4wk6ZjQqj7VxL5NFzhkWwwHKRKBnnsDxazH6sM65k0CpHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725444879; c=relaxed/simple;
	bh=7sHLb3GwE6eF7+H4t+Vv59739DRHAPkc6e4zUAi58Zw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BSAvXOaid+NnU1YN0epanmlny9fFcbcJmz9iah+Vl4rhZ4kYc5b5U5FdymXUzU4ixBFFWHsfUZbFE+Ac5m9HbYx67BBtpY2MH21VGAlMgHYoDIt4b0YFgbMWoMzjBfDxsllcbU/b062MZQPib+1LBmTk9nhqrHPTzroVyJBszXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=rrTiHmf2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PcJcJnAM; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6574D11402EC;
	Wed,  4 Sep 2024 06:14:36 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 04 Sep 2024 06:14:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1725444876; x=
	1725531276; bh=Nvb3h+Gb1zB7vP1UjexJohB7wGEttH6OHW/7nLMdI7s=; b=r
	rTiHmf2vJU26QXOErSv85DWptvrvJEUq0sQiF5lhBP3B3K1W4EBGDj5/H7ss+/hn
	TfnG3bgI3zHhcifOmvJTYYOZd2TYOtUKueuaIjEP+my4gUTXiBF7upZgqDxqiyLW
	zA7A8RmiGrOVD4hMTscUpJnegsVd/PhGdE2rnodxuDAHSf6hg8Bh74BtU95admCz
	70QzNddLD/aCE48W4Q3Vygps+WuXMJWBknDaFfjqHWuVt2a8DW795dvzb60a2g8X
	ebPrY1IS2SN8Nzk4tObklO6MG8bm7mjPDbc6XFDnTxDxJVeaCEcCZdc9YIP89tiC
	vVENkLvlAUWt3kCalvRLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725444876; x=1725531276; bh=Nvb3h+Gb1zB7vP1UjexJohB7wGEt
	tH6OHW/7nLMdI7s=; b=PcJcJnAMVfUQKW/nMrhZeX+/eD9p89z5QVihGtz1LOkI
	1ajzAgIyBcFQ8UfuwMEr2BtfW5S4Mq30cLJCzBdWYizhlJF+XOQHkM9G4elFzigZ
	4Jajx/egc8i2rTQ/u82foyRjVF5DdchVOfE/Z45x6msOo694oBlHg5EB4k7CjgvE
	VJuSMA7gPfCbE7Nddo8bY6HvdX+EP2MJafJ3oid0I4BQW1FNoI7Pc5AiIhRoHyuI
	BAam7IzmDy2difnWVzq4D6PCxwEIk91KakD97D2HuTT0T1sINz275oyy2NGvWifi
	3bwob0pCI3Tbpg05IPO4idFqrgnYcW4eAMFKF8Y/MQ==
X-ME-Sender: <xms:DDPYZqtRA3fjrAvvFqJYp5k6ZSHpnLXMKTpl8hvBVFz0HNZDhgsDhg>
    <xme:DDPYZveDY4PE3MIbwAXmAT9VRdp_V1Z0BRSKkNiQMpgW3yjDGFheIXYf_N0RdsnAX
    2ucXFZLUBLJv-HNbDw>
X-ME-Received: <xmr:DDPYZlxyAytkcjTYv4oLbDZFj_ppgRRecVTC6UUuZVjX2vvIzoRoV_0jggj8BKY5PJStR5f6t6b__4h4HFndM1esqLrhkUP0uRw>
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
X-ME-Proxy: <xmx:DDPYZlPF6eJxZCnUc-Kl3hVKZzG5nDogmQO7cQOUJ8_GZhoxK0hrSg>
    <xmx:DDPYZq9amcPQwp9tzmGLr6kfjHuLk50LrAkV0C1Ko_xRw3jiuEOmdg>
    <xmx:DDPYZtVy_-saP58z2blKoSxPJTRA0pF8K_bm4OSkHH0A3iFmbE1jjg>
    <xmx:DDPYZjfU6AEZ9nCoREcudFbVLpQngtnPMV8s0J87Tx7Yw5sjjfix_A>
    <xmx:DDPYZsJuLf88aqDlyrgx5W-fSDdpIi2fvZjGzVuGBI_Iuby2N6-uh2-9>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Sep 2024 06:14:35 -0400 (EDT)
Date: Wed, 4 Sep 2024 19:14:32 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firewire: ohci: obsolete direct usage of
 printk_ratelimit()
Message-ID: <20240904101432.GA437448@workstation.local>
Mail-Followup-To: linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20240903101523.317110-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903101523.317110-1-o-takashi@sakamocchi.jp>

On Tue, Sep 03, 2024 at 07:15:23PM +0900, Takashi Sakamoto wrote:
> A commit 77006a0a8282 ("ratelimit: add comment warning people off
> printk_ratelimit()") has already deprecated printk_ratelimit().
> 
> This commit uses alternative functions to obsolete its usage.
> 
> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> ---
>  drivers/firewire/ohci.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)

Applied to for-next branch.


Regards

Takashi Sakamoto

