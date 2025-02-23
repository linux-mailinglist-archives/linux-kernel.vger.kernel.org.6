Return-Path: <linux-kernel+bounces-527957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0676FA411AE
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 21:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 694B27A636B
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 20:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C45123A9BC;
	Sun, 23 Feb 2025 20:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="GFavm7qc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O2gn1knU"
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CBB146D59
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 20:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740343117; cv=none; b=Wqa0irLxacHaDtpbKIJyZjtdhiXWw5oQwmVRAoQo5CsPVsEM97KUKCL1dS0pTqvWYVu5fwLKBdQ9vY4xT2yr3K26Ym3V+0xzlvBtrLjvUR8GsJZnfRCMwpgKax/rirzqk0XMO/BCMkOEZk1NpjtcG9Nk8E9ADSZz13z5ZpEwi/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740343117; c=relaxed/simple;
	bh=veaE5wmZnE3tPlToa+LP0A62kR+RPbOAUXst3QSuQzo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=IXNL5JY9DstAHA9pcM9zjzsTCCekMwzvudc0LuKDpZ5VG0PXJGFO5CO0FxE8/QargmVqmj7l3/NFSQX/24sE8pIfy4TfsfjbetZ3DNTYy+u268PwDK+9AUcva6ySTFVZN33dYCXorBc7TXhdjM3LYChw1aYFYRaHq8f3koh3gn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=GFavm7qc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O2gn1knU; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5832211400EF;
	Sun, 23 Feb 2025 15:38:33 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-11.internal (MEProxy); Sun, 23 Feb 2025 15:38:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1740343113;
	 x=1740429513; bh=5AkbcJFFUnBwFfNbXXb8Zk7BLBCtTFKVq5k01FwVtTg=; b=
	GFavm7qc3GYeRtUS5MHk2SxYQnXMwmYCewBUlqLuScBNEkpJwzlbuY5yKapRjCMH
	X30uFdIe4wLAXsjFWKx8kHwEwFnlX3mdlZ9dt6CE5D9RbTYXv5vzt0deK+2ZGb3n
	Z+BKr7wHQayigxTNyRTfSin/JmKHFEG5X+OiZMmlPW6Yv99EsvGL0Pg7MsgSaBAZ
	kGoHW+98d6dGbUvmD39zpGeZZZMMbhNuX1WhW9wz2IhjJQRhfvkuVM8p8qYi6O3S
	KVCCgtQ82yO1oSv1VEQW2LNj3GmCiFvUm94aq2YC5hdtThgjmRj+d7K7rbCUTQrA
	HL7Edy8TfeM/9elkoGovjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740343113; x=
	1740429513; bh=5AkbcJFFUnBwFfNbXXb8Zk7BLBCtTFKVq5k01FwVtTg=; b=O
	2gn1knUDqErNxvpmJ/qOiDOttYuWsczHVilogUKNcSRTCvExARUhvqhm8u1bpHRo
	/xt5uusBpv0xd6CBa44O9jvq+67SXt/rCULrmTxRbJxq8RIsGVQnGEspXr8lTK+o
	vUbL+F34fOI5s/Q38xM2UCcgTKj3ObsrirajbCanY9Z6LXz+39JjfQGfOKYg40s9
	M26XHVfi2J0Zlb6iybUHO2J2IWVGEpZwLPEWt3ZoH36Bc03CG9WS+xRlWPotQP33
	tjX0ap96GXMObkqZKiqX7EZzN/yD9ob1OtSbXAwulUyWs5rbyxIftwjojz/TgDzL
	mR0C/vwLzMRNh2xnO265w==
X-ME-Sender: <xms:SIe7Z4uWXVaDvn-FTBE27PtkVcf01Iqmcr78n2P_TDpnIiBhg68iew>
    <xme:SIe7Z1cXNHU5EYy8r1G0NW37t2IFEPutbiDyetiNbXbw6vkcY6eEJdGZEm3gfNxQB
    6ByOGPMGoohZ70zu9k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejieekfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpeeijeejledvvefghfegjeeugfeggfduudettdeg
    vddtgeetvefhhfelgeeivdegjeenucffohhmrghinhepuggvsghirghnrdhorhhgpdhosh
    hmohgtohhmrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohephedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtoheplhgrfhhorhhgvgesghhnuhhmohhnkhhsrdho
    rhhgpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorh
    hgpdhrtghpthhtohepuggrvhhiugesrhhofigvthgvlhdrtghomhdprhgtphhtthhopehl
    ihhnuhigsehtrhgvsghlihhgrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvg
    hlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:SIe7ZzxyuqHHxM4GNfXzij40w1k43PecX-yLtb6BlSoT13FT96Zcaw>
    <xmx:SIe7Z7P3N_vwO9o6TWoxNteNh6YZTTZjbvSbWD7LSM6AuzfhuHYSGw>
    <xmx:SIe7Z48Npw553dSKbI5Kb3kLg0YNE8fG2kMytEvaLm2OCEiPBla6bQ>
    <xmx:SIe7ZzXcCVZvu285gC0cVqOIuNXO6PeIWIaT4IpZLdbQWs-42-Di-A>
    <xmx:SYe7Z8YMo2aEgGudwCEB6JugjTp9rGLywLEJSxKx-eSa9AMzDARKwzLj>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B31012220072; Sun, 23 Feb 2025 15:38:32 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 23 Feb 2025 21:38:12 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: linux <linux@treblig.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, david@rowetel.com,
 "Harald Welte" <laforge@gnumonks.org>
Message-Id: <07afd3cb-3ab1-4dc9-b0c1-3fef2d52f60b@app.fastmail.com>
In-Reply-To: <Z7tZhYET41DAoHVf@gallifrey>
References: <Z7tZhYET41DAoHVf@gallifrey>
Subject: Re: users of drivers/misc/echo ?
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, Feb 23, 2025, at 18:23, Dr. David Alan Gilbert wrote:
> Hi,
>   I can't see anything that uses drivers/misc/echo - should it go or
> is there something out of tree using it?
>
>   I see where Greg moved it from staging into the main kernel
> but am not seeing anything include the headers or call any of the symbols.

Good catch!

I don't see any in-tree users for it either, but I found one
project using the exported symbols, and there is a debian
package for it as well:

https://tracker.debian.org/pkg/osmocom-dahdi-linux
https://gitea.osmocom.org/retronetworking/dahdi-linux/src/branch/master/drivers/dahdi/dahdi_echocan_oslec.c#L34

With our normal rules, we should just remove it as there is no
way to use the code without external modules, but I don't know
how we even got to this state.

Adding Harald to Cc, might know more about it.

       Arnd

