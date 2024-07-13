Return-Path: <linux-kernel+bounces-251259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD96F9302C0
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 02:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7470B28347C
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 00:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9923B79F5;
	Sat, 13 Jul 2024 00:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="aaEErcjq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PtyH7TG0"
Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6258BE0
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 00:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720831125; cv=none; b=j4lmo61kDupYnCAk+bH030eVZFrBCv1bghEQC47q94HFex75OBDpu41WfyXktIr/KyjtkuFO+E+UUWY4rVBgxs+A9Xpg3S622Og8R41if++vCX9e0/DpGBO18yyRFJ7i1OgM/8IA/8UL2d9mHoDfPOxbaBP7fRpelAJu/p/PISg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720831125; c=relaxed/simple;
	bh=yiToMgplHMDtGFd2whxfsKEfw8UIyu1Vxys6Ij1Ch+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jq6K93d8AUkfWQXhKz+9XzdDTHwgmG3UNfGGGwJ4jGAINdniFdG65Per7qbvTSr43u6WVGwLjkjAojTwAiRX7AEctD1zlTYxS+5tay1gP7vDd8tnMcG1DKMutz7TtxSAAlzBBtsSLIjU8Jj5xHjkrVpkie6s020lLmDyvtpD5FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=aaEErcjq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PtyH7TG0; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 0F3F81140C69;
	Fri, 12 Jul 2024 20:38:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 12 Jul 2024 20:38:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1720831122; x=
	1720917522; bh=IlKo+22jX4Sfmbrw57Vqlb0xo+n1oEvtf2J9dwT6eig=; b=a
	aEErcjqJtnGaEToFWtrtQviFxQbKFw8gzyg7bZn9FmHg5K27moZLawgrIckIOfn0
	lceMyL3CPzkLoRDV+piGTuEQSnKzx452u6Clq/CS0fxs3sDKeIqtnVlhPjAvnyOi
	ZERb+dyY5d6depH4WXGn0sYx/N080/8Q4zzmzgNIS9SmB8Ik7b+D8Hw+MZ1Lggz9
	79csGnSbxQKJ4bnOJuYsf6ZAwh20cX5bTKGYEWbdPBGwJm8vGFPvlopkV7YF2Zi4
	GYxVAXy3JuWNc5gWGB8n8H14CyIYAFs3xM1KMWTeq5FBhrFjfs+85P3SHFFWKeuI
	9N2/4savZvQFGeUcmUKDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1720831122; x=1720917522; bh=IlKo+22jX4Sfmbrw57Vqlb0xo+n1
	oEvtf2J9dwT6eig=; b=PtyH7TG0Ohe0XrUdrA4bWFlPhmTxn74YoXkvJ0OtkNBY
	BJAX8w84wMiLfuZlI8bJa6cSm1wTOD700RK01d6pfd+ugApvVBA6LK+OQ4T1s0SP
	xBZDZuF752XMuAnTjK0B275xQTW0khTcE7zZrq/N8DkuImkTGpFfB6gFC3l9pqd9
	t574pHttgRB6+kCP6NAhIqIgVVhi3pJddfKCquiVxs01oTYVve1bhf5LbyzVwkHp
	R2xMROju+5y6cllVsgiS0YsM2JVfNuEXS00cgQWD33Y9QSXLEWsxq8ACYdkC19hH
	4XrhcQrk/OopJ1rdF7Qj+bHkN3S9O9RUtTWlSfd/cg==
X-ME-Sender: <xms:kcyRZpDoMqu5wxU3HDQpZRy0Cidbt4YQlX-_ymXwcHK1692tgOiPrw>
    <xme:kcyRZniBVC5asF6P5tCahmbXOYmfHC6IvbmVFlqPVMGnuRoTlAUm12t34MXf2lVH6
    GcYSZQV_6Lv_XMMGBE>
X-ME-Received: <xmr:kcyRZklITQip7k1xi-zOtfkOFGWMKDeBr8EPxfUvV3f9XyMdU7AOmpXHCuqrjzP1AiDerMIEst5e7r2tu9LdlyHo-y3OidjlHva6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrfeejgdefjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtre
    dttddtvdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
    shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhephefhhfette
    fgkedvieeuffevveeufedtlefhjeeiieetvdelfedtgfefuedukeeunecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihessh
    grkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:kcyRZjzJCC6XELpA6aPCcXEAiZxDNioKI14ZzUoWByefs3VZFb1JAw>
    <xmx:kcyRZuRaHUbzcrFKMmxW_inhRJ4qJNb2K0D136uuNuvWI-xj18YpbQ>
    <xmx:kcyRZmYnPz2A8K4O6QMi39co-c_kkHSDX3qy8ku5GZ537cEkRnRpaQ>
    <xmx:kcyRZvT77gn2Nvyd_zsmrk-tdMqVs9gvLzwB1RI0ZfzHTJKwxDwWsA>
    <xmx:ksyRZpdg-8C-OPM0ZVtIph0VaF36L4PI4aE1pD4AY5bbX_3yNm1LSCzR>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Jul 2024 20:38:40 -0400 (EDT)
Date: Sat, 13 Jul 2024 09:38:38 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] firewire: core: move copy_port_status() helper
 function to TP_fast_assign() block
Message-ID: <20240713003838.GA107956@workstation.local>
Mail-Followup-To: linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20240712003010.87341-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240712003010.87341-1-o-takashi@sakamocchi.jp>

On Fri, Jul 12, 2024 at 09:30:10AM +0900, Takashi Sakamoto wrote:
> It would be possible to put any statement in TP_fast_assign().
> 
> This commit obsoletes the helper function and put its statements to
> TP_fast_assign() for the code simplicity.
> 
> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> ---
>  drivers/firewire/core-trace.c   | 11 -----------
>  include/trace/events/firewire.h | 15 ++++++++++-----
>  2 files changed, 10 insertions(+), 16 deletions(-)

Applied to for-next branch.


Regards

Takashi Sakamoto

