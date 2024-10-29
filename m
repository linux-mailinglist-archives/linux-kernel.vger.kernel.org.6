Return-Path: <linux-kernel+bounces-386147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 717689B3FAA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 02:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09845B215D9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 01:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20ED75589B;
	Tue, 29 Oct 2024 01:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="RbrvQtuQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gI0i/TCL"
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C2222EE5
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 01:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730164773; cv=none; b=d/PAtmpjwhShyOCmXQBsBsIBbjpIir3zp6J4v9llmXc6YvWWVQh0ebVb7Gd2yLky5z0Vqpag7PdhSU1C5b4G0cNPpJHJD1O4ZWs7ufQQqdUpFxu6pW94/lGIKXCMo2711eHgZYucakvErnhTYoyECBl/aX2QQeYrbS300aQPw/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730164773; c=relaxed/simple;
	bh=RgOf++afi0EyvtCuAJWxb+F5DBowWrklNIpvpFOvCJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X7wuEyR6Gf9mnT5/bXNMKEELzZhzym6nd/4vRD+c0RJbKPMfbUqcG4keNQ6JDsJubmmfVTmprmstUxeshzrhElQyVCkwXQAUP6gOPZY2eZeSICIzniCfAf3rm+8OpyVfd6IbS9X4LGcK8exUHCvX+HxrtuKIMH0Ehng8Fb3GAIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=RbrvQtuQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gI0i/TCL; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AB231114019A;
	Mon, 28 Oct 2024 21:19:29 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 28 Oct 2024 21:19:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1730164769; x=
	1730251169; bh=DFZvUn3BP1CH8W8twa67vrPGh9GQ/uWPY5MPWnm3GKQ=; b=R
	brvQtuQNXOyWPf/F2Rm2IBo1L9v2GCuGjn7qxnD1PouF2i5Cjj3hZ80jo8xrc3lj
	Z0hydBCd1ssb3iZPctSURCN6CJmgyJU3YR0zP2xbyF78uF/4HyJQotrMiAUMIe5n
	W4LAHBWj4DO12oe+4ALsRri1ujgrmiTwZk0c/BrmUzsLowoJE7aThBdZBXG1lXjT
	oh0VktUQlMEhmORKBjwPeOWVXn1vFeMS6646yOgTiY3AbZF0jQQY96wXmJkkF3pz
	IT1aiKmF69n4BSYtAmB5sFin/MG/yNkra1+v9i7UZJ4ynlL7ZzTTU2gzftglwuZs
	4tGM5l6DGBB73sbDwDgXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730164769; x=1730251169; bh=DFZvUn3BP1CH8W8twa67vrPGh9GQ/uWPY5M
	PWnm3GKQ=; b=gI0i/TCLghkUKGeCa9UQJpmeB8r557gUV+GJMXTil9ji3/I5erJ
	XbWhyBB5ktCHO9fVEU9hLEHuMq1URxGd+Gm8bnY0qbIJomkR7vzegTBqJDbNMRGU
	lkJu+2xFJUSEmCB+P/RZGruAD0oOQUKz7J3/LZ+9ND+s7wrJVcn7mgpiso7uHAnr
	qZf4yWySOTCUPorliwbKjzB/8kfZokTpIby4FWzhXim8jPkTE+TxQq++gPFqtIGe
	K6AtnwsNvre1QzqdBEDHvFjfRelORb49B0V8cd+Sklzb//yjvsgGSvVi4vFnFANU
	drpypgsq9KBy8K1wkrXr1ykW+/QalI2gkVw==
X-ME-Sender: <xms:ITggZ7FgsIreILCi1bsrgdbeyOgWTpN4D1eQ7jvypdQ6-G2_npnqhQ>
    <xme:ITggZ4VNGm24TVHdN4_6-BYSxuYT7tKBLPMKOjwfLFOa1C3UF67kU_ceoRY1ywPSf
    d_6McQrNV4pzTnMLeo>
X-ME-Received: <xmr:ITggZ9LX1NlEPs_wQBHmF5tDr_OOdWuXa8XcFJnRiNY7jspZuO8jY_NUEZbkjUXGlQWCR5D0zstgM9ZCapkaFCwbQUZXYsT_Yrc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdektddgfedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhhihessh
    grkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhephefhhfettefgkedvieeu
    ffevveeufedtlefhjeeiieetvdelfedtgfefuedukeeunecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhho
    tggthhhirdhjphdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepphhsthgrnhhnvghrsehrvgguhhgrthdrtghomhdprhgtphhtthhopehlihhn
    uhigudefleegqdguvghvvghlsehlihhsthhsrdhsohhurhgtvghfohhrghgvrdhnvghtpd
    hrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:ITggZ5H8AVDwHhj5XWaKwjmlz4Ht4VuPmoE5GweB3AtvQBrzjUWwZQ>
    <xmx:ITggZxWUsqmUFpMqhTLx0jzajltPB21Cv3d7XAnmHbJRmb0bMirVdQ>
    <xmx:ITggZ0OHVuyp8I4HKusz-foPr-KlAUgOwyEbH0k8jlyG7FCJSrtOIw>
    <xmx:ITggZw1bv5wasf2IawOpCt5r64xKim9t4kmV3uJXXGPlrPajq2XpqQ>
    <xmx:ITggZ0RygUTP7uD6NmFgkw7E07dwizLIMSOzEcuf_6DSuX1x3XF5Cduu>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Oct 2024 21:19:28 -0400 (EDT)
Date: Tue, 29 Oct 2024 10:19:24 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: Philipp Stanner <pstanner@redhat.com>
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firewire: ohci: Replace deprecated PCI functions
Message-ID: <20241029011924.GA260237@workstation.local>
Mail-Followup-To: Philipp Stanner <pstanner@redhat.com>,
	linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20241028094440.19115-3-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028094440.19115-3-pstanner@redhat.com>

Hi,

On Mon, Oct 28, 2024 at 10:44:42AM +0100, Philipp Stanner wrote:
> pcim_iomap_regions() and pcim_iomap_table() have been deprecated in
> commit e354bb84a4c1 ("PCI: Deprecate pcim_iomap_table(),
> pcim_iomap_regions_request_all()").
> 
> Replace these functions with pcim_iomap_region().
> 
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> ---
>  drivers/firewire/ohci.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Oh, the API has been made available outside of PCI subsystem, great.
Applied to for-next branch.


Thanks

Takashi Sakamoto

