Return-Path: <linux-kernel+bounces-282603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDDA294E650
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 07:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A27C61F22303
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 05:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D1914E2C9;
	Mon, 12 Aug 2024 05:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="M63/iTF2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FipcL2aQ"
Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F6E4879B
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 05:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723442185; cv=none; b=IqtAkh2pkrEBG3KL9BpubvnO/xKcTnwrmfdmQaER2dL9wSsFTz2JuVRoMV4G0YDwj+1AkBDm1j0Ok99daq4yN8GQ+z5c4ABYivdE0yMRp7VgRg/sMJK4ssG44mG5mvJcCiRtR3nqtpuMrUIibpC2B2K0kaSeiaNAmMYcsalPMI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723442185; c=relaxed/simple;
	bh=XuPV6GbW+jbKtVsfZPkDQad/1OnLNTnaFQZmTgAgXxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cLsVO7/sl0mr9KY5AGnWROoni/Yq03okHLPjiJ3CwZKzKWLbqVcPo2i3U3MjL119A+9IUuyUCxe1fp8ahLC/xXr325vBX2SpJI1N51dHkUQCLDuszCh4cpBPF3mt3UACkM7DC0v1E1f/FaQyZrl3YqjLHehoujDwJPohZKPcDLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=M63/iTF2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FipcL2aQ; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-06.internal (phl-compute-06.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 03B041151B24;
	Mon, 12 Aug 2024 01:56:22 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 12 Aug 2024 01:56:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1723442181;
	 x=1723528581; bh=ZVA4f7AmbmGYpA/IkhbgNFHPlK1W4aI6vT8jJYelqbY=; b=
	M63/iTF2V7l7GcWHC4PJAc4KVZAtokRKScVw2ZgrCjg+jZ4DYOipuB2SeoOQlesp
	wOsBpvsF6/C4u31c6/ogYnLD6pxbBYov4sKGx5mcte3NGoz1Cy6+DG6OgntTGwuy
	ubz3kYp9IJey29irM31Cu80BQLhf/m4I8ebhZjFnrGJWEDqSpgrWpsc4ccSR8/N7
	A6BJJaiGVIH3ONwWcdPe5GmSlCm3AvqEfkA5Ct1UIWecn3z5W54e5cUyIWxqAX2l
	uRsUxoh9v8uK4RAs8mKnS2t9HP83yoiMgddfF2689kRQiF2pkx8xyrd58YNnWYvX
	2DU37RA+PBjfWujz4WptQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1723442181; x=
	1723528581; bh=ZVA4f7AmbmGYpA/IkhbgNFHPlK1W4aI6vT8jJYelqbY=; b=F
	ipcL2aQ7K3vAkc2GAi7lJEYn2uAhbQtJ30R2o2DzIx94SUF43rg9ayR6yzb2Yngq
	OaQtwzznnUYADtUOOqeemJfREUbl6Zw8uvp7X5IeQkbtkmqnMb3OhXm+l81UBjdv
	S/UizHXB0Ua5VG0QcKe21qQGc95sW4jAdvpczDZrljYQchAtBJFiOhBoMg0ksLUN
	bz2tSnZs+57szMGQ/90OE+FyL/MhTXAm+JeIxEe+IhfAL/kh+alSGi1Dk8VOzd+p
	gtIdBGJ2q7UZeS9pFPn5RoDvhamP9X8EeI0PJ2b9L9tW+9bfHdlf3hwcC5MW/On6
	gRPHqX/KNoZYOiiB0u/Uw==
X-ME-Sender: <xms:BaS5Zs_BQVAo2Tv78sxaQY1csbTxwSxEhWoAWqBUxLHIJtXh1pIQXA>
    <xme:BaS5Zkub6bRNipc3MEld5e3kQsJtMTAHCdcLnXJ2D-f0qXXdgpdHfsrZQ6ZeBiGsO
    ghcYep4gS4fIg>
X-ME-Received: <xmr:BaS5ZiDZgBMiUFZ9aoJrQhk8gZC9Bja1ms5jv5IJJiEDZUBwSSdU7eQ-5-1i2GRe9JC12zKy_Wg1OKeruJ683Z5QtODrPw_2psYNYA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrleelgddutddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtf
    frrghtthgvrhhnpeejffekleelgeevuedtfedugffgjeegvdetjeelleegjefhieekjeff
    vdeuheehteenucffohhmrghinhepkhhrohgrhhdrtghomhenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhdp
    nhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsghroh
    hokhiguhdrtghnsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhn
    vghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:BaS5ZseeUj9c--pf93QF-oAEBPmVVHtrIYpt9iQUNESskTO5UfprKQ>
    <xmx:BaS5ZhMpjF5CUOdSDiRFfjgt9b8zVJ-SOHVtOQR0-7wTo_qB-fWQRw>
    <xmx:BaS5Zmkr_wbBA_uFB8Fn9JndV21tMJqjBsYVRN_gMwBjDjWiknQS8g>
    <xmx:BaS5ZjtjD8GFC7mXZV9da0wwbk6G6_yMMmIgGzcwrKY1QZh3pBMLAw>
    <xmx:BaS5Zmr-FcPXbaOGmoiO14trE9CNzARxVgcM7UmstKVFy0qog8HwtTtE>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Aug 2024 01:56:21 -0400 (EDT)
Date: Mon, 12 Aug 2024 07:56:19 +0200
From: Greg KH <greg@kroah.com>
To: =?utf-8?B?6K645pil5YWJ?= <brookxu.cn@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Query about the maintence time of LTS
Message-ID: <2024081250-mummy-wildcard-0208@gregkh>
References: <CADtkEecKdWc9t0reu5WCefTaFvW_cuNmZAxjDFL8btN6LmfnPg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADtkEecKdWc9t0reu5WCefTaFvW_cuNmZAxjDFL8btN6LmfnPg@mail.gmail.com>

On Mon, Aug 12, 2024 at 01:29:09PM +0800, 许春光 wrote:
> Hi :
> 
> We are now a little confused about the LTS maintenance time of the
> LTS. Does the maintenance time of the new LTS is limited to 3 years or
> 2 years? will it have any chance to extend to 6 years as before?

Please see:
   http://www.kroah.com/log/blog/2021/02/03/helping-out-with-lts-kernel-releases/
for more details and how you can possibly get 6 years if needed.

thanks,

greg k-h

