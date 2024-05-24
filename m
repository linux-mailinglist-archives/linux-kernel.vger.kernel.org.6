Return-Path: <linux-kernel+bounces-188270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8628CDFE7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 05:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F55C1C21607
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 03:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7D4381B8;
	Fri, 24 May 2024 03:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="AMrGHsF1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HGbjbReB"
Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC83F3BBC0;
	Fri, 24 May 2024 03:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716522027; cv=none; b=RxE1smQSlU0g2Rp/LcCwTFFNfh+00qcxQXZAI6J0bA1xXKAeXjxJrSKK/BcQTv/eKRji++p760OVL7CxNsPvz5lsFc/wFgRtXymC2OFfWLteUBaZBZD+SBF8qiZmn3Q79AaqS55PtrJBz7AZgjSvwLUs8pFDRMkqr+DpumNT4oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716522027; c=relaxed/simple;
	bh=Foi+rLSNwjZREewBC4ipev5MaL7oc9IlmyDRpDyf0DY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uUD+AU9dhpmtIVeTS154b+nNu1RYWaa1+3M0belmW5ahzgRBELcShdPxZCKA4YGsLd3YD0igrU34zAQnsJLAYEGXM1+J3btf028xGARaso8TtiT8fHo7QAQI6ewmCjWTrNrXlpfgDoiNx4sEsx8y4cjn9npGcYz6sa5b8/ryz8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=AMrGHsF1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HGbjbReB; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id D54651140218;
	Thu, 23 May 2024 23:40:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Thu, 23 May 2024 23:40:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1716522023; x=
	1716608423; bh=nJg3BRJ9fLaFbQuErZUwdRHtpE0NqZPJNW5qvN3YXN8=; b=A
	MrGHsF13baaIv8VyDJMA8a4jZHX+9esb+FRYzcf+VPOZxD2fvJA3jeuIu41iYK5X
	5YCMOUDDo9bQg4ESQQCtWN9l3ZZdQn8EcsakgsQWiswOYSEvWpvh3+bL6xH0Umsq
	ej7VcC040Irrpec1D/ic3Gy8qAEB3IL+5YrB6i/B4yCgmdM2SRf40C669YN/ix81
	yIn7B8lMZ4UiJd79xQHrvPKCrGUYEOKjSPxClEhSwXlmxjSVFgcOJtdLp7fdzXS8
	2jj/wtnpVVXDvNMxGp2PEJW4SMrzWC9kYLX3bqqmOzpPG9G2FfczWvKST35bCGnc
	UJDe0t6typOEfdRhCYb1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716522023; x=1716608423; bh=nJg3BRJ9fLaFbQuErZUwdRHtpE0N
	qZPJNW5qvN3YXN8=; b=HGbjbReBid14Y+3VU+ljAqIRymKMhkh+FYGDH2a4KQ5C
	3QdnupR+ejxS4fNFtNbD/QHVZkhYfx64JoXnF0tDyqiSPFirtLxTdzYXtUqAM47i
	JAKzCRn8Jg0ZDWmvYTJPeblyNWY3f0qpppjBAOj6No9PzEtGgq0IIbRMIbsLSQyW
	9F2q4758S0ZL/5ykzPtm0rSNqgQ13sL13SK2LmrdsTaSR/xf2gkRCkMyPltlDyFD
	nSrpEb3xkqLV+ojRSX+KLWvSLvMHb41kwe5WpPvCiIHznbWytXlJYFEzo+82Wz4g
	7LWXFANUg1McpMrryM+d2dx2xYNFQ3R7T3+crbevqw==
X-ME-Sender: <xms:JwxQZsLsYNR9m99rTo0rqoGRDm3-eUmczu7szB6NJQtfKnICDv21Dw>
    <xme:JwxQZsI2yUimfP9h3pqSx2cL_Ro5CUO-IShY6WaZc0Y_MtyRSoRImGvWrUx-gQjji
    16dL4AIy98w_nVG0rE>
X-ME-Received: <xmr:JwxQZsv0FnPjfF7Cf580FPcrdkZJl7-dISr2zVKI90XuBoGmzvgw8djZe_wGzal7wBgMW1POzJFlrmnHhZnVPOmY7srIA9wEIXM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeijedgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfgrkhgr
    shhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhird
    hjpheqnecuggftrfgrthhtvghrnhephefhhfettefgkedvieeuffevveeufedtlefhjeei
    ieetvdelfedtgfefuedukeeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:JwxQZpYIvJrayzpI7Akrlq1JYmr9MxwM9UrP-i9xx1-qjC8SVYK4Iw>
    <xmx:JwxQZjYwUgz98HaJLCJcwIhmixL67PmDF69RntdX-WnTABWbyBJhAQ>
    <xmx:JwxQZlCn_dwltP-tHeF9aReKxQRuvZjQEASC4Q9kexWASxUFGQ9zgA>
    <xmx:JwxQZpaurwyQ1jAtp6Zu68vsRLcqvv3w2hvrZS04UBntSJIHYuIIkQ>
    <xmx:JwxQZiU6tHoIlQrKwwc6J_yp6xfBedy8nMeHc2Vkiteh7METJAVL-IFV>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 May 2024 23:40:22 -0400 (EDT)
Date: Fri, 24 May 2024 12:40:19 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] firewire: add missing MODULE_DESCRIPTION() to test
 modules
Message-ID: <20240524034019.GA276112@workstation.local>
Mail-Followup-To: Jeff Johnson <quic_jjohnson@quicinc.com>,
	linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
References: <20240523-md-firewire-uapi-test-v1-1-6be5adcc3aed@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240523-md-firewire-uapi-test-v1-1-6be5adcc3aed@quicinc.com>

Hi,

Thank you for your sending the patch.

On Thu, May 23, 2024 at 04:22:34PM -0700, Jeff Johnson wrote:
> Fix the 'make W=1' warnings:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/firewire/uapi-test.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/firewire/packet-serdes-test.o
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
>  drivers/firewire/packet-serdes-test.c | 1 +
>  drivers/firewire/uapi-test.c          | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/firewire/packet-serdes-test.c b/drivers/firewire/packet-serdes-test.c
> index f93c966e794d..e83b1fece780 100644
> --- a/drivers/firewire/packet-serdes-test.c
> +++ b/drivers/firewire/packet-serdes-test.c
> @@ -579,4 +579,5 @@ static struct kunit_suite packet_serdes_test_suite = {
>  };
>  kunit_test_suite(packet_serdes_test_suite);
>  
> +MODULE_DESCRIPTION("FireWire packet serialization/deserialization unit test suite");
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/firewire/uapi-test.c b/drivers/firewire/uapi-test.c
> index 2fcbede4fab1..bc3f10a2e516 100644
> --- a/drivers/firewire/uapi-test.c
> +++ b/drivers/firewire/uapi-test.c
> @@ -86,4 +86,5 @@ static struct kunit_suite structure_layout_test_suite = {
>  };
>  kunit_test_suite(structure_layout_test_suite);
>  
> +MODULE_DESCRIPTION("FireWire UAPI unit test suite");
>  MODULE_LICENSE("GPL");
> 
> ---
> base-commit: 5c4069234f68372e80e4edfcce260e81fd9da007
> change-id: 20240523-md-firewire-uapi-test-08fb0a9e18de
 
In my opinion, it is not so urgent. I would like to postpone sending it
to mainline until closing the current merge window.


Thanks

Takashi Sakamoto

