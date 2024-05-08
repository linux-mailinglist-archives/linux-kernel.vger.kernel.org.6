Return-Path: <linux-kernel+bounces-173927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 220DF8C079E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 01:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C63771F21E39
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 23:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6489012AAD7;
	Wed,  8 May 2024 23:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="LXoP1o3/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DamMVyl5"
Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946124500F
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 23:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715210554; cv=none; b=A2002oAr0CD/6eaTjfuDJUDwluxsguUe8ppnNEK9SA1M9Q+lsUm+a5IOCcnX9KuNl/9vR8IonVTWh2RT920zQ0IvKjmwZwD5YKW/T2iuMl5A32U55iPAyXTYRmSZuRFCCdmX7PBrfztsVELu+pElpLGzAxrSqCkf1Jv1iuaLhX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715210554; c=relaxed/simple;
	bh=lngbHDQsQRj5Hk1X061YNZ2PwKPmOTLgrOxgGJm3xlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b1FqJSXnHv1zxOfGFgvsbttO5xNwfkvdzBgZUkf6Xl6BOMQJc16AIkkMDQ7cD/Izm8bubNc5RFVlAjH96Z33ShFo7cAJbQN0cSqA6IhPHnZmApQOFB4U7ZInvqU36/OClbdihjdgv1lH5YO8VdSqMwCSzgNhasGV++eP/4r/ed4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=LXoP1o3/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DamMVyl5; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id EF2B61140165;
	Wed,  8 May 2024 19:22:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 08 May 2024 19:22:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1715210549; x=
	1715296949; bh=PqBmtiMR6pS/tekKeSNhOa3yqevNRmTxuIESSK02LFc=; b=L
	XoP1o3/MaG7ZKFLGJn9zRvBzslXe0kASTMbNYLTvh9oLGHqcbTTL7JF07E5lkQUd
	kNEJxmCnP4b4xzLcLGQA3sEei0QaXHTghCaItqUPu+7PR7/5ftT5t3x5BxYfhPgn
	oMiGHO/SSoa0Mg9zhABoBocPbMlUaGOBFwhiszLk8FMb7YNb5z0+RqJiYCE+4p58
	LYelow9xtIa5QNJBhxuHuyag7C6oqDvTY/sO0l5i6aZMWmaP7Mj3anjNDJxkfO0P
	ezMdTTn4rgmX9MWS/rq5QXK9yf9ahY2fffvZgJd+h580ykX3Fb58rgI2F9rVNpcR
	eZ7gqVNM7udaX8CDK406A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715210549; x=1715296949; bh=PqBmtiMR6pS/tekKeSNhOa3yqevN
	RmTxuIESSK02LFc=; b=DamMVyl5VV4JB02JP6Gg309He8zHcpTAouBNipQ07axb
	aJJGxNLmEDgud1NCzenP+OUoRfJfiSuzzwqiXmXpRz4S0obKKbCeFyUg/ngfI7w9
	qPkr3C5TzxlXltuyfSPD8Gq1ufWBpAFAnZI4Mi0XT4+VgNJ36LH/R2QynzYAh5YJ
	VB7JdUyEzcaiviid1DaMu3mSyQlbLoGDgXn4TyujUyzLnb+we4LpT6kN/S3cjCTA
	rSTCUjP24g8xy57qJZnFZXtG0WCEfh8Savy+/AbqiWair7ObowyRkIrejnmU973s
	9Z7bpzmk7QWkhHfo44TV8AUk02/EsEizxPcMV83eUw==
X-ME-Sender: <xms:NQk8Zqs7t7v_OnhC-VlHZmnMu-hqq3MhAWRS219DexdzGyW70ab9mA>
    <xme:NQk8ZvclOiA7V-yrUoH0xe-LxOwwW91oI6QtwdDniKSgnCVeb3Pnb8P2doTuyAyfB
    vx9dNzgRtQLXdyrfLc>
X-ME-Received: <xmr:NQk8Zlxs8h_MenB-tD5zjk97eoAxJ4MFA5OTt7bKyLrcJLoaEhmHW_YhqVxRuKF0pDEgxN-sI8yN_egklIDBmXsSBk-P94lOKQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdefuddgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttd
    ertddttddvnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeehhffhte
    etgfekvdeiueffveevueeftdelhfejieeitedvleeftdfgfeeuudekueenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:NQk8ZlM3RlkRmooEL5722T4VR-7oXnq6lSPQuY8LnmBw_nsvD6RyrA>
    <xmx:NQk8Zq_kYU9F2HkRKzxaNE1MtCMx5DzXi7RuTBTn4cgerCt85tY9_g>
    <xmx:NQk8ZtU0XtRYl4phR9EcREhxl4WtLWYWolfWnAj4gN_2zTh2aurnpQ>
    <xmx:NQk8ZjdujezXgOd5eoCKF464krudlM9tQRTvncRNfMrQmgqhAT8YRw>
    <xmx:NQk8ZsI4vYP--ZOmKsfJKcvixDYopFHPx8pUs4VOgftb7xcP50hCYW8T>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 May 2024 19:22:28 -0400 (EDT)
Date: Thu, 9 May 2024 08:22:26 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firewire: obsolete usage of *-objs in Makefile for KUnit
 test
Message-ID: <20240508232226.GA31582@workstation.local>
Mail-Followup-To: linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20240508105351.532693-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240508105351.532693-1-o-takashi@sakamocchi.jp>

On Wed, May 08, 2024 at 07:53:51PM +0900, Takashi Sakamoto wrote:
> Nowadays *-objs list is just for user space programs.
> 
> This commit obsolete the usage, and simplify Makefile for firewire KUnit
> tests since the tests are not composite objects.
> 
> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> ---
>  drivers/firewire/Makefile | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/firewire/Makefile b/drivers/firewire/Makefile
> index 013e1f2641bd..75c47d046925 100644
> --- a/drivers/firewire/Makefile
> +++ b/drivers/firewire/Makefile
> @@ -16,8 +16,5 @@ obj-$(CONFIG_FIREWIRE_NET)  += firewire-net.o
>  obj-$(CONFIG_FIREWIRE_NOSY) += nosy.o
>  obj-$(CONFIG_PROVIDE_OHCI1394_DMA_INIT) += init_ohci1394_dma.o
>  
> -firewire-uapi-test-objs += uapi-test.o
> -firewire-packet-serdes-test-objs += packet-serdes-test.o
> -
> -obj-$(CONFIG_FIREWIRE_KUNIT_UAPI_TEST) += firewire-uapi-test.o
> -obj-$(CONFIG_FIREWIRE_KUNIT_PACKET_SERDES_TEST) += firewire-packet-serdes-test.o
> +obj-$(CONFIG_FIREWIRE_KUNIT_UAPI_TEST) += uapi-test.o
> +obj-$(CONFIG_FIREWIRE_KUNIT_PACKET_SERDES_TEST) += packet-serdes-test.o
> -- 
> 2.43.0

Applied to for-next branch.


Regards

Takashi Sakamoto

