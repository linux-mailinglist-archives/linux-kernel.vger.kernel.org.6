Return-Path: <linux-kernel+bounces-250016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A90792F2FD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 02:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98A54B21A10
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 00:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA8F138E;
	Fri, 12 Jul 2024 00:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="i2n41sSU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BSQoHoBN"
Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5FC10E3
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 00:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720743912; cv=none; b=QeAlwPeIWF7UNu5J2ivcdNpRv6+P+spYfYVYriLPIYjZWRpRQ9mAhnF9nrTa/ZNDBU7Xff50czTMNg7s3cYB+LqkdcL3awbeAcB1ojkh8FKb+g7cwVMNYgLwWGY5Q8ESLwnautKkjkqrEMwIz+zWJYV4IRnVkt4Xpi9hohnPTFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720743912; c=relaxed/simple;
	bh=Jh6jhbGa6xoT8nOuaI7+Y5Nej2dy28PshSFccpSnboA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BdV/PIlG6oxaOrwoOZ7DmxaxtnsvM9j3FkQCptvXQ3+tW+HFESngSpGJ4oK0sH47GGr3HL5ewr5CrzYE3tu//BJesEe8f+Qnx+9yjveJJFrQa8jIH9UrS3hvDBKmhOnSvMdlKISqppNfvKryCqDT6zImGDo4DHxfy/3UzchfLP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=i2n41sSU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BSQoHoBN; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 28ABE1140FE1;
	Thu, 11 Jul 2024 20:25:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 11 Jul 2024 20:25:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1720743909; x=
	1720830309; bh=4GIBJYxkr7iWUZFxwzxEuQ91x/vyXdkRozSaihbY1tU=; b=i
	2n41sSURasjd1O2Df8RVWZoABre5Wh0zTpRKFh2gU5dSc3I/RCE1khmhfJ2xB/nd
	z5IyGw6m8Ev5axVmBkBDlWew8o+RBXg2yI++Z2IPrqQjpZTn8yuFy9SlHmImMD+Z
	0jwiafgdwsA1ruLD8+wyn0n1MHjiAGWHtDvww3CldhAERght7mCVsWCuhiVRYbB3
	+4v5gq3F+PVmGul5nAUZWSbMVTp/OQuPfZJOVoUhWYtyNI+6RlWd+FhfP1rSdef4
	1MU+lttAhqH/SPR+BAb7tQgDpTXuyBMw53idZ2JEAenTVGwe0pACu00HGjF5gPiG
	ldwGIqdcJQcTrqyS9CeLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1720743909; x=1720830309; bh=4GIBJYxkr7iWUZFxwzxEuQ91x/vy
	XdkRozSaihbY1tU=; b=BSQoHoBNfPTdSbT+NZOlJ58LAUFYZcUh4Nn8db1qLgeH
	OWe0xb6GE8qkdKE58/vNqabyrrrfIfbiBeAs5G5d2HgpFhxUP12MsyX86IPCxEQH
	lE3/5f+o60onPzuJD0IBAGRaxJWStgvXJuHB2e0Sv+QrcWY9ngVkQCpjZrL8V3is
	8zzL5EPsiixbb6EC1CcPkeYOTQSna98MXITIBrKegbEliuiEPduTNDdGAxtPN2dD
	elSRJw6DIyW9DZT1GFlbPMDwWAfB9poX7UOHAm4SMVrFtA16qXSQP51CVrIcOZ4c
	pbnVYUs4rxGZr9/GKTjX19ojgq3MLlHVAlikjYIpfQ==
X-ME-Sender: <xms:43eQZtWiuw53Gwi_WhQZfwzgrCNP_xPXURNJqRMU0YecVQnhlS8XZw>
    <xme:43eQZtnOgfSNjeM3Pj26tNltmo16QtpftS0RxyBI0kIdqoC2EBmcbDygMpOPNxL7f
    nGAYA-P3uEfL6geafQ>
X-ME-Received: <xmr:43eQZpZgiJCKEM84nH03tNsT02jkUyRcJvS_KstkG7a1mLKorW4Z4TMkc4-nVg8aQhghm8Vl6uiwbn9ztLawftNCK-wDV8iJm0Uq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrfeehgdefiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtre
    dttddtvdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
    shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhephefhhfette
    fgkedvieeuffevveeufedtlefhjeeiieetvdelfedtgfefuedukeeunecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihessh
    grkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:43eQZgVQA3THE1ZW4vj6GkPADMCCKwPdf88NSEge8wHp7PFoYoeCng>
    <xmx:5HeQZnlULbb0w90TxG7uUtYnLRGcGpVkgIsdXF5cSTC4ueUa_Ul7Fw>
    <xmx:5HeQZtdJpJk6GW3mtt_CQfg29_MQtUgGeILQ51LRZsJD4N1_mzZZZQ>
    <xmx:5HeQZhEsHPzGozUieUgEk-gBpDJIZQrk9gQO9_2tRzxL2QYQtp7Brw>
    <xmx:5XeQZswXl7yZe_daoV3kgUt5YwzRj9PrwVyAlvLFzXUdO-KsEbKyf81y>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jul 2024 20:25:07 -0400 (EDT)
Date: Fri, 12 Jul 2024 09:25:05 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firewire: core: move copy_port_status() helper function
 to TP_fast_assign() block
Message-ID: <20240712002505.GA86058@workstation.local>
Mail-Followup-To: linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20240712000424.85124-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240712000424.85124-1-o-takashi@sakamocchi.jp>

Hi,

On Fri, Jul 12, 2024 at 09:04:24AM +0900, Takashi Sakamoto wrote:
> It would be possible to put any statement in TP_fast_assign().
> 
> This commit obsoletes the helper function and put its statements to
> TP_fast_assign() for the code simplicity.
> 
> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> ---
>  drivers/firewire/core-trace.c   | 11 -----------
>  include/trace/events/firewire.h | 12 ++++++++++--
>  2 files changed, 10 insertions(+), 13 deletions(-)

I realized that the prototype of helper function still exists in
'include/trace/events/firewire.h'. Let me abandon this patch and
resend the revised version.


Regards

Takashi Sakamoto

