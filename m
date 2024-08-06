Return-Path: <linux-kernel+bounces-275495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9BDE94867D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 02:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CE07285C92
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 00:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153BDA35;
	Tue,  6 Aug 2024 00:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="kyLDjodZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a94riqfh"
Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1DF382
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 00:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722902794; cv=none; b=X0u41DZ4wEJRKRl54+k6Oo1R0vB025XQ7vJflkJaxqgsKKetVfx4bnWH84tnvZra37n+IoIOJCCjY1PY44RJjowN2gTirT4bQm2sxpwIVA8p1P0dkP/oa991PKbjMh1HisHkokU/F9oEeSAB3sear4bMtw/IXu0taJFCKMd8FLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722902794; c=relaxed/simple;
	bh=QX0ohP3lMd5wHCMpteY12/q6DRwpT5+Vkf2NcqZgaYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SA45PScNb/Spo+hA0LQgpACTxY3a7788Jmlb1eQ62ow1tvScUEld4PzQvPZEXH7NJ4UgPlxYVW0eQhac6msH4r8/Wh1Cah0myDCn3+9W6FWfyVRr6mRf2Y8F2owmZultJLcoTxZ/CJUIH/vV6n8sQ4yGqvcWWxoxJnzXPRARTXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=kyLDjodZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a94riqfh; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 66707114FD18;
	Mon,  5 Aug 2024 20:06:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 05 Aug 2024 20:06:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1722902791; x=
	1722989191; bh=yYBuxa02hn1I8nuNlxVPTW633WCaq8XlhKZ8OVqohWo=; b=k
	yLDjodZ86PN38ubAdxKabIZn7ijBLrGc3tc9Qp+4o91p/cZEZJNaJALBH4+BS5wP
	LQOqr3LYpaHUb00JmuzzBlDwYpHkZsKD1bp0K8MxltxTXSGd4TZc1XVrL8E4iZa5
	UvIp8IBB3wsGVZIoolNY31dCf6vzfOc59NynrGCnmsVotCoeAe5IHxB2oKI786ts
	Fwv9Mzz6I3zbNKajrOjD0jMykpFFrdZrDlmhgS8SCdkkLSPRFzWz2rcalHIiU4CT
	hPgPmJEW0v3mSxY0RX9bOJuKfT21ZAtnPJLeCUvxY2Sk1xOW81jJ17RHQRWuURl+
	YJm4JKhRt+jyIxfP9c13w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722902791; x=1722989191; bh=yYBuxa02hn1I8nuNlxVPTW633WCa
	q8XlhKZ8OVqohWo=; b=a94riqfhtJcsnDys0mbsSATOdkT3rhd9Cn9ncl2K/Kc2
	C6xL01b/bpXVZ2jo+ySy4pRKJUKD8A9fvn2I9wwezhg5g7sqRhBU6oiJ2HL9cPlZ
	6fDgkiSO5HAC9/Lobb+76i5RfTCJ5csyyVALY6b/EBEuxq/V7NhwtUlRDtr2/YLe
	aRbtCb4U6LJiHjaePGJC8DA8xVjt9rd3ErTfGkg5y/uraSwkFnav+nxAHE8P6RrV
	jFvW50xugbmEh1fse/O9h71hzgQ3Jo34TcwqnCYOHTzRaMLdha1OTi0w150RQYuK
	0dftwQoqlA457GoOH/Qgp8ojy/jUTn8XQcVkeCyOwQ==
X-ME-Sender: <xms:B2mxZoSckoEgdG07mikoIUfJI8_SstpZsqtGHpGV8KZaaP0-_-X8Ag>
    <xme:B2mxZlxYse3ecK8SWbULFFTbrICQhLtbAEdFXM_loLKWXp7To0o4E7pvmc0SopiOL
    su7iu8Q_dAkVueiRuQ>
X-ME-Received: <xmr:B2mxZl2fFb6eGtXJhwk42gOQ_wsniSEPCNwkqH0vUXdT-r1mY1pYiF9BjEvnzzzBt1aiclzOB8fJbLl9n1GDMj680OeVgDiT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeejgdefvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtre
    dttddtvdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
    shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepveeilefhud
    ekffehkeffudduvedvfeduleelfeegieeljeehjeeuvdeghfetvedvnecuffhomhgrihhn
    pehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhppdhnsggp
    rhgtphhtthhopedt
X-ME-Proxy: <xmx:B2mxZsDUATEFIDdxjJa5p0PvEpHbpTKqntKWnYMVHGd3uVfMntofxw>
    <xmx:B2mxZhjaL2CEn9giEwYhE8JTRgiC3lVVMtTV4FLO70vbdumDlid5Hg>
    <xmx:B2mxZooIWFFPT8fl7-EJQ_KHmeNmGK-7YanqevZF_Mmjgls5J6CZBQ>
    <xmx:B2mxZkgw_bd8-wiAWKrAH3v4MAp01gRTfom3EkphBSW2G5qc7IvpHg>
    <xmx:B2mxZksS40gAMhcXw9UlwEVb619wk6KyMIsx08e6av8d1sH4cgdMNM_U>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Aug 2024 20:06:30 -0400 (EDT)
Date: Tue, 6 Aug 2024 09:06:26 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/17] firewire: core/ohci: use guard macro for any
 type of lock primitives
Message-ID: <20240806000626.GA264514@workstation.local>
Mail-Followup-To: linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20240805085408.251763-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240805085408.251763-1-o-takashi@sakamocchi.jp>

On Mon, Aug 05, 2024 at 05:53:51PM +0900, Takashi Sakamoto wrote:
> Hi,
> 
> This patchset is a revised version of the previous one.
> 
> https://lore.kernel.org/lkml/20240804130225.243496-1-o-takashi@sakamocchi.jp/
> 
> The guard macro was firstly introduced in v6.5 kernel, and already
> available for spin_lock, mutex, RCU, and R/W semaphore. It is useful to
> ensure releasing lock in block.
> 
> This patchset includes changes to replace lock/release codes with the guard
> macro.
> 
> * Changes in v2:
>   * use scoped_guard() instead of guard() just after label so that
>     statements are expanded there instead of declarations.
> 
> Takashi Sakamoto (17):
>   firewire: core: use guard macro to maintain static packet data for phy
>     configuration
>   firewire: core: use guard macro to maintain the list of card
>   firewire: core: use guard macro to maintain the list of cdev clients
>   firewire: ohci: use guard macro to serialize accesses to phy registers
>   firewire: core: use guard macro to maintain RCU scope for transaction
>     address handler
>   firewire: core: use guard macro to access to IDR for fw_device
>   firewire: core: use guard macro to maintain the list of address
>     handler for transaction
>   firewire: core: use guard macro to disable local IRQ
>   firewire: core: use guard macro to maintain list of events for
>     userspace clients
>   firewire: core: use guard macro to maintain IDR of isochronous
>     resources for userspace clients
>   firewire: core: use guard macro to maintain isochronous context for
>     userspace client
>   firewire: core: use guard macro to maintain list of receivers for phy
>     configuration packets
>   firewire: core: use guard macro to maintain list of asynchronous
>     transaction
>   firewire: core: use guard macro to maintain properties of fw_card
>   firewire: ohci: use guard macro to maintain bus time
>   firewire: ohci: use guard macro to maintain image of configuration ROM
>   firewire: ohci: use guard macro to serialize operations for
>     isochronous contexts
> 
>  drivers/firewire/core-card.c        |  60 ++---
>  drivers/firewire/core-cdev.c        | 252 ++++++++----------
>  drivers/firewire/core-device.c      |  83 +++---
>  drivers/firewire/core-iso.c         |   5 +-
>  drivers/firewire/core-topology.c    |   5 +-
>  drivers/firewire/core-transaction.c | 146 ++++------
>  drivers/firewire/ohci.c             | 399 ++++++++++++----------------
>  7 files changed, 403 insertions(+), 547 deletions(-)

Applied to for-next branch.


Regards

Takashi Sakamoto

