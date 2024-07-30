Return-Path: <linux-kernel+bounces-267484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F6C9411FF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 14:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 766B41C22767
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 12:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC8F19EEA0;
	Tue, 30 Jul 2024 12:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="qeZiBLiL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CJfCWURt"
Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6595F194A57
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 12:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722342979; cv=none; b=imGdlo151Hf8LXysrKk05lS6PEh7IyIvkOZr/SaH8k6pG9VbuRzgtN4DiHVAcSmZF2kTAvEhYl6K9Kqmsn6ShL5Kg3rzqIXnJbwbgi26kyGWHnaTRBK99Bf5rEzn0ILZseSD5NNNksdOgh8ykJBz+K6ou9u21rYHjPyQMtDPhdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722342979; c=relaxed/simple;
	bh=4mtvM/AUYroBha1aBhmfY7H9X9FmA61v2/MLYUKPGh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GvjcXocN1Pdototv8ciIEynriZqPfwEe+5TXp/grwQUfD0zH9WgdlMdShSIzMmcDeaQurWeQdm0STUpU0eM2Cdk0V5L2LTc62mMjgKg/i1pMfrI9tpDHLvA9w/+j3MpXxV3l8e57YT3k0dd7zNbG47yTvXM4ITVRxyiez3fN7m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=qeZiBLiL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CJfCWURt; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id 397B51380702;
	Tue, 30 Jul 2024 08:36:16 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 30 Jul 2024 08:36:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1722342976; x=
	1722429376; bh=0mMuqrnN4zFshoDbqGo53axgHIxHFvWUKbJFZBwFEy8=; b=q
	eZiBLiL9P2lMbMEjQetxWjdY/HPP/Fs/Sx5/n3cGlIT7NcemydOqJkvgjOVRCh7D
	BxDuOYyhQXM6NA1YweLFuvo/WiBiTGmHMPg2AW0LYkmqLWrAl3BnTbIm5CQi1GeF
	K4n/WiRK9eVmu22hHnS4cRNTGf9mRPtSr223fKAKvcLBVo1XEoE2VG11w2J0roqZ
	7tN7k4V5oZL+8RdKNg47o4EJRaNQdVWEkKJcVnGCSzQHkFNq0UjYJ9zaa5lirQFz
	1B1r3btgNylCGCOtdK0TQUAFvflJkfJ2mOXfBMTA6YWKj/WpfkM0uiEx8W2KYy5H
	BFuviIVLc2BEDEmNzbOAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722342976; x=1722429376; bh=0mMuqrnN4zFshoDbqGo53axgHIxH
	FvWUKbJFZBwFEy8=; b=CJfCWURtnzr1gaDgWgJJcJz4mFxUm3gUB73Oj/R7/TFO
	svinSNWx1uKucD30UT0+Ly96i1n19McxNiBt4wlK0cU6B6H1qAUt4m7wBg+4up5P
	dVCHp4wME674tmO21Y3cAum9b5REGP4nsI26/s38UbYnYQcVbNg1ucMtLK42KDsW
	R0bRIHl1tUsGCOK5lU/R6YkTYloM8QGztlRp/Jnzg4nih9zQGt9pjGIcXWf3lhPm
	ar1LEmDsCotmeUm4a0LLmTUL8OWTeFU3jtuFImLbGy9B8c8h4GPQrjzYhftHWR0F
	UIT5sJEvQobNehJQuxh90wqxv90pyJhYKY6xw4kiew==
X-ME-Sender: <xms:QN6oZgdXRDPIVTfGsF2r3LyRxLK_mPnBkNXlfL1k5-X3SbMBZ9S96Q>
    <xme:QN6oZiN0s86U95zsMjfwYETH1jXJbgvdXA64ISsLJ_eE7X3F5rjUz-kvPDPqy_oyG
    Pfn5w-OxyeWsGTSwFw>
X-ME-Received: <xmr:QN6oZhg9ZJ69OTIrl7WQNDsktoGKyef91pNgJYYjApKR4cEV7XMLRYAZTLz-KS2h7-cbffAk0A8HPcRYBeIM8xtNVEBif4XTygqH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeeggdehgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtre
    dttddtvdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
    shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhephefhhfette
    fgkedvieeuffevveeufedtlefhjeeiieetvdelfedtgfefuedukeeunecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihessh
    grkhgrmhhotggthhhirdhjphdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:QN6oZl__lOYBoDLUk04LBfdU6Kgmed81SltZ4LkqvcAlhLkN-isciw>
    <xmx:QN6oZsvZtxSnRUJ5ZwQwsgaHinlFuhgL6c08ahnP3nyA1_qgiXFp4g>
    <xmx:QN6oZsG5_lHfcTrp1L1bfvKz5qirIiTBwYFOYgCnRNJz9oOV40F5uA>
    <xmx:QN6oZrMO4tKWg9_BO9dJT42DBxAzm_QLrHfzuhVuPILhAriNbI-s8w>
    <xmx:QN6oZl41GigIm5yM8gCzt4BQMCeZfz_ZNzfrur5jCCJsvXQQr0VoPnLK>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Jul 2024 08:36:15 -0400 (EDT)
Date: Tue, 30 Jul 2024 21:36:12 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] firewire: minor code refactoring for link internal
 data
Message-ID: <20240730123612.GA206389@workstation.local>
Mail-Followup-To: linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20240729134631.127189-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729134631.127189-1-o-takashi@sakamocchi.jp>

On Mon, Jul 29, 2024 at 10:46:28PM +0900, Takashi Sakamoto wrote:
> Hi,
> 
> The current implementation of both core functions and 1394 OHCI driver has
> some points that need to be refactored regarding the handling of link-
> internal data.
> 
> This patchset is for the purpose.
> 
> Takashi Sakamoto (3):
>   firewire: ohci: use TCODE_LINK_INTERNAL consistently
>   firewire: ohci: minor code refactoring to localize text table
>   firewire: core: use common helper function to serialize phy
>     configuration packet
> 
>  drivers/firewire/core-cdev.c        |  4 +++-
>  drivers/firewire/core-transaction.c |  2 +-
>  drivers/firewire/ohci.c             | 37 +++++++++++++++++------------
>  drivers/firewire/ohci.h             |  1 -
>  4 files changed, 26 insertions(+), 18 deletions(-)

Applied to for-next branch.


Regards

Takashi Sakamoto

