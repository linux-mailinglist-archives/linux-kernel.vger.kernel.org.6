Return-Path: <linux-kernel+bounces-206827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A65900E4E
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 01:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDC20B22C4F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 23:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45581C6A1;
	Fri,  7 Jun 2024 23:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="FWMdH3qE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RCO2KBq0"
Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4125D49646
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 23:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717801676; cv=none; b=CO8TR7ruZDqcEKPuM/VErxXPjnjQIZPA1+zgUPNV+YURsWpXXeb2aBJexIbcItICYeLFSBzpvLr6rk37MchPljG1+AYTcDBbxfk8XRIpPZd4hBg2aSlBuWbqom7AdQI2/Wa3BGHFgNigKdqo4jW60NZMS8GsyOFnZoWmCxyKDZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717801676; c=relaxed/simple;
	bh=TEq1TDDxfQv6GNFB8iorRs0IOxBof4X8S2dkmZfg4pU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O9rr01oumGT5x3LDM7gvWqAGE6BMU3DCGioBdjrh4ImpSEg6b2pVmLCP98y20bRuOxfNwZlvI26nis3qb6276qxtkAvxdWVO8C1VAuUfShbrFRE+gfT6hc+E3YHwPus4F7ABsgEWjgk0KCsKOsSNztwJqlkfN81YpIqGrFOhfJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=FWMdH3qE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RCO2KBq0; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 4FE4F13800E8;
	Fri,  7 Jun 2024 19:07:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 07 Jun 2024 19:07:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1717801673; x=
	1717888073; bh=6pdC/PPeU998+RzKdeO9cLmW7uSwlM/TVhAEkUWbOIU=; b=F
	WMdH3qE+jPjMD8O2/Op8RnY5tdJV0XoKg9eYvS367FiOcKEoDbVpor4tZUOBgm2/
	csuf8Fj+Rmb9O+zt8ByM8fUA4QMZctZbGGqYsghQJQGwFHyX5mfzPyvjIneNUEqN
	Qj2Z0AJPJhARIzUMruGN3XcPGuRFtdng6RtG6/mbwc0Ha40Af0V+FDRSFsMkw+4x
	ytXaD/7dRj8LSiM+mkIIQr5r29EJ8DhRRbqQEgbFaM9jmGqsKsFfdipu2wF2qwrs
	h+t6kYiTQ7S//o7KYG2jQQwvCnQlaSCaNi3N86yHxS9JdnD4EIsRrbIM9EkVqIaE
	ZJIKUM9kmnrEBL6vjBXkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717801673; x=1717888073; bh=6pdC/PPeU998+RzKdeO9cLmW7uSw
	lM/TVhAEkUWbOIU=; b=RCO2KBq05P6gGDqe4NNlfUr7IgrNKydICWP76NHHCC35
	UBT+kZ4lyAb1++FSnZEmlhwc64QfxPdBMzIcfnIH6Bl4sBQr0+EVgTus7KUjr+IY
	TOFTVkwKLwqbf5h1DgSTeKMi1SotyaNvdbBfMx4P/U1tZ8LX2celSjDqCfhQe7Dr
	YE3Ip0JBguRX1agMurAY76cgwlOpjSQwRoHiFVyEg74XB8M4JYLY4sgI4wr2E0YX
	lxWIesqVFLPkQ6nViragSHye6a4dQqSKE9z3mH17DEQKuqw55etazoO/brt2V+UD
	Rnx+MpzY4VFhEcmI1C2BJllmGssSpKnGhmDDmycCfg==
X-ME-Sender: <xms:yZJjZhFr4vFF4EraFQ-4rC6GwqwGFKgafKSrL65cu6OHM3KutOKmXg>
    <xme:yZJjZmX4OiNTeuhfKT8XUQTxB7kcTeKuvZFOmr_Uq3UGzgCd4t3ajeuaIvJSCMORs
    PRPK3g4yutWKZ53hOA>
X-ME-Received: <xmr:yZJjZjLZwoXdRjRY5oZ_0GfVcu2NVYN1Q-IF9DHMWa-n23snUQ_00pQ4dOGfh34sSPAew8nLg6Km5VGNavoZQS8yXrCF9EGankE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedtvddgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttd
    ertddttddvnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeehhffhte
    etgfekvdeiueffveevueeftdelhfejieeitedvleeftdfgfeeuudekueenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:yZJjZnHSFN5UpnqqZuvBWQEu1YrWL_LeupTNYdOJrma1DK7QMwotPw>
    <xmx:yZJjZnXkXn5M5L4n3PvBTfO-oOlmhhgqDp0bte-6ira8lTLgtw1Q4Q>
    <xmx:yZJjZiMAa6JmRfCDlk40DENcxjfq2QWqgMOhm9vt6SAGB93OTI5CDg>
    <xmx:yZJjZm0SkDbKVFf4lO-P4PlZaRVf1YnKm71wkcov8_n6a0Q8JxPJrw>
    <xmx:yZJjZkgr1KaL4r5AKGa74HKh2IM9TTnz92Zhz21ucinYzC_CSOciOgDs>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Jun 2024 19:07:52 -0400 (EDT)
Date: Sat, 8 Jun 2024 08:07:49 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] firewire: add helper functions for phy configuration
 packet
Message-ID: <20240607230749.GA245773@workstation.local>
Mail-Followup-To: linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20240606235133.231543-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606235133.231543-1-o-takashi@sakamocchi.jp>

On Fri, Jun 07, 2024 at 08:51:31AM +0900, Takashi Sakamoto wrote:
> Hi,
> 
> In recent months, the batch of helper functions was added to serialize
> and deserialize content of packet in IEEE 1394 protocol. This series of
> changes includes some helper functions for phy configuration packet as
> well as some KUnit tests for them.
> 
> Takashi Sakamoto (2):
>   firewire: core: add tests for serialization/deserialization of phy
>     config packet
>   firewire: core: use inline helper functions to serialize phy config
>     packet
> 
>  drivers/firewire/core-transaction.c       | 22 +++----
>  drivers/firewire/packet-serdes-test.c     | 79 +++++++++++++++++++++++
>  drivers/firewire/phy-packet-definitions.h | 55 ++++++++++++++++
>  3 files changed, 144 insertions(+), 12 deletions(-)

Applied to for-next branch.


Regards

Takashi Sakamoto

