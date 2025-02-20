Return-Path: <linux-kernel+bounces-522964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D93A3D09B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 06:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEB2A1789FA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 05:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1411D9A70;
	Thu, 20 Feb 2025 05:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="Wx7xhbG9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CReqSs3S"
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E569A286289;
	Thu, 20 Feb 2025 05:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740027801; cv=none; b=Assv0I0dnNYRYXZle9ix4+SjVOn6MpcCDjHkR8K5lSNLoIwVIgyqgxu93KK3HItXCdF3UMIAjJiq4OfvyGWdNU8ZqLUoAVw1IjDPBZJWZ0vpMUGrdc2ZdDSEUL0QXpenLU2HjsGd36qGEVhCqWIFBKhNjiKpKQsB2qcWch/6AIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740027801; c=relaxed/simple;
	bh=UxWcVhMp47jM55dg96qpdOhjqQ5omZLDVdiQxdddyRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hvxj3AbZjP3FrZjoeEs5rvCysIx1vVLwPf9GtCyKeYBTyQSfLo2/i9fqd7WTIxXXti8moiSHLgcq8goXAYtS1eX2WhTEW0uVMTuwveWXzKj6VecNDal7IRLcy2Q/jgS8QrW7t3hNj2zB20KF/1//XpRK+NfLzvmNb6P1zvBeTuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=Wx7xhbG9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CReqSs3S; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 941ED11401D9;
	Thu, 20 Feb 2025 00:03:17 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 20 Feb 2025 00:03:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1740027797; x=
	1740114197; bh=9mEVFLUyvs8sEJhryugUBE/GDAB4W49PXkBIcvI6FNI=; b=W
	x7xhbG98kNkIda0zueRAA+bYV/oItN8qfL5TJHnjIlsSngov5zSVx11AazYS0Ebb
	Tuq26agL4f/a9teH2CdZbB++MhLNaq2Ldbt+21inEJELzjRTJncvRjmvBGnyGes6
	2dIClKgNVXAbQGlvjKIo2OFEQFev2L/a8EeEs64JvsBZjVLUqQgq9IxZ04F2pN7s
	/ZZxDx6upoYRUj4FDKZibbp2kdceqO/jVHmM/k9hIRqZ4pLxQUJRkfJm0yiFZctS
	Gg8guyeDC5qOhsSzeuxF3FWqYTCcbygWxdyVBgpoW5hXKcHczo4FJIy7ZJuXjp66
	09f7x58AfADX6WtQkR0Mw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1740027797; x=1740114197; bh=9mEVFLUyvs8sEJhryugUBE/GDAB4W49PXkB
	IcvI6FNI=; b=CReqSs3SuprWaFjdMrBu9JK1VW5t0AKR6mKfxFIjLsZ78mydGs6
	kCCaBPWLUAkAIA+O65w0eyjZ6jpZ8bhc5awMHG/sSrzepFucskQzvwFLq9xNKyvw
	J2Q9qg98PCPHYD/VP0bkeHBr6O+aPe+iqgdZXq/0pcftBctDBzKjTqLxJj/12KoB
	LuInFvsRmZCbtCqtJMJHSEdw8xKvP3jYXInHNT8BzVS5Lhveu2SNl1lDsinNhxF1
	W/hC+OBLHvWlT9aRkpZX812m5lWd5OX7wdGsxaa7D6d6AM50dKhqx46mb8E1BAs4
	iq11jtzIvaMxmy+DP5SGUN2jzC32ddDB4Sg==
X-ME-Sender: <xms:lbe2ZyK0k166HTEPaOCSUKVT5-x01N_n5InL6-nL6dlFB0n30YY9Pw>
    <xme:lbe2Z6JaCMw06rexprhcfTXV4GS30m41Ryy8fAbd_RDibEzAQT6AkBIMaYXZD5Wb0
    DpbXWzNljnKknszxYE>
X-ME-Received: <xmr:lbe2Zyt7tGEPN2-xIXRCUalf-cpTxD0wYRmVszkVK1YIjn9sPGNHGyf3mE36Jd8wWEOpnduNzps6E78kC16YWd-msgL_I71nyUA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeiiedvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeehhffhteetgfekvdei
    ueffveevueeftdelhfejieeitedvleeftdfgfeeuudekueenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhisehsrghkrghm
    ohgttghhihdrjhhppdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopehmtghhvghhrggsodhhuhgrfigviheskhgvrhhnvghlrdhorhhgpdhrtghp
    thhtoheplhhinhhugidqughotgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopegtohhrsggvtheslhifnhdrnhgvthdprhgtphhtthhopehlihhnuhigqdhkvghrnhgv
    lhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigudefleegqd
    guvghvvghlsehlihhsthhsrdhsohhurhgtvghfohhrghgvrdhnvght
X-ME-Proxy: <xmx:lbe2Z3Z_CNuQCw05QISh-QHZm_hkrE5zQCIdD9lgKcLEpqt9c4PrAQ>
    <xmx:lbe2Z5YNLvbKri0N9Vid6zViII0eoqUJBBJnLSDY0sFyo008PS4tmg>
    <xmx:lbe2ZzAp_0zsB-Q7Q6AdDo0y7-G0HxA2AITEdka4QdCXoMrz0_QhDQ>
    <xmx:lbe2Z_Y6gxITF6y6HDV9XwOeojC3p0vEzheNXSf-jGTbA9O5k7VB_A>
    <xmx:lbe2Z8y2l39_E_p5nU3v5tBTSir8WkJ6UeH1VSkFKG_77zahtd28-vGW>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Feb 2025 00:03:15 -0500 (EST)
Date: Thu, 20 Feb 2025 14:03:13 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
	linux1394-devel@lists.sourceforge.net
Subject: Re: [PATCH 03/27] drivers: firewire: firewire-cdev.h: fix identation
 on a kernel-doc markup
Message-ID: <20250220050313.GA414097@workstation.local>
Mail-Followup-To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
	linux1394-devel@lists.sourceforge.net
References: <cover.1739952783.git.mchehab+huawei@kernel.org>
 <56d88f897214cbfc4593b4bb4b2a04d0168865d7.1739952783.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56d88f897214cbfc4593b4bb4b2a04d0168865d7.1739952783.git.mchehab+huawei@kernel.org>

Hi,

On Wed, Feb 19, 2025 at 09:32:19AM +0100, Mauro Carvalho Chehab wrote:
> The description of @tstamp parameter has one line that starts at the
> beginning. This moves such line to the description, which is not the
> intent here.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  include/uapi/linux/firewire-cdev.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied to for-next branch.


Thanks

Takashi Sakamoto

