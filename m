Return-Path: <linux-kernel+bounces-215716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B27AA909639
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 08:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D23641C21417
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 06:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96C5134B6;
	Sat, 15 Jun 2024 06:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="a5lOoSE+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mZ5dDT5p"
Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EB719D8BA
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 06:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718431282; cv=none; b=D4V/N9mBuG/fKEICW9Y1WIrnja1j4S0TgWtoouM7mGaXJ1rGI9Uw7r2rJfEmONxlDXdua45hZvbSTnQdqsZ/e3Q4T/Wa3qX51rr0UPxpvFMaDT41aYdL/C59KF0sj7n6VaomDlBmAzXdnPV59bd2F8NZFLZ9R4FYrc0o2YHPEkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718431282; c=relaxed/simple;
	bh=JO2PziB5CpacOXmmrRDldDs6/Rn67TWJpSMclVoZf4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=olvUf7yYy25/f3BxrGqg6NaxflKU31oBXM3d8NB/L+eZ3SzK2ghWOWcv1QV9n07blZG07ch6rYn3vrL3DLvHJkyCBMXekJH0VmnOS/QXLK0wBVbjLL6SR+9GDt+a61tmq6WoaOR9sUUvRXiz2fFzAXC/WU8uS52iFMzoc5Xc54I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=a5lOoSE+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mZ5dDT5p; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id B7B69138030D;
	Sat, 15 Jun 2024 02:01:19 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sat, 15 Jun 2024 02:01:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1718431279; x=
	1718517679; bh=pVkvcR5Mh/CuKy7u+0e9iN5sR7E/3l6Wx4z3fQhdZjU=; b=a
	5lOoSE+miL9JdhfK+Du4a+OVtOLtDCHCUIPDY5YQEK5nO+eI3uyHjDBSh3rGDKH2
	OH5xVRbmmg9EJQiEIkywKbdSUK6wtSeN0C0G3K0hbvCgyfUL2uBnc5vpykRaThON
	9j7el1bnQSsl2UWr2Tlfg47a/8Lo2UYJQqBZYJoNt46sU3HYEmsRPQjAtzL4aICe
	eusrKbrhLi9qNCE4Vjt1GfBc2WxJ9YMYy3TO47aFXsQQbS01RyrbpgGbeBJhRC0f
	dDSNJGsaxPDjb6dmwBz1uG1hrOhmo7gbQJetb4Dq9/diVFMZR0HOOaeFOagRGsa7
	eS63wSOzGSW2dk7DC7Jng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718431279; x=1718517679; bh=pVkvcR5Mh/CuKy7u+0e9iN5sR7E/
	3l6Wx4z3fQhdZjU=; b=mZ5dDT5pTJ191Zcgo763UUeyxtCHRc1CRLu78QDyAwRS
	/uQ80UgeAZNO7bX6S6kmdOcWHyrjTdQK3aZKgr5fqJ0TreR4zGwNIWHKVV95bvl1
	vB8Hwbot1VBcusMJt1ITAt0qinEOr8QNTdn88OBcMVpkVjfXu/r+CagXFNK0AEyI
	yb9aEN3cFOLPWsoq4GWpFVkSYvbcU5Vn05Czz1fz4JI0HoG3WLO4s2NnlkTnkw/P
	BFHualGOsxCgOmh/WKPWvCIzjd4/HwQIX52NU+M+uMF+0c3moHv8vrVVIFipPMBp
	q5DNPB1VY9WsK5JxPmnX402biPSrgxPAgJHgv81P8A==
X-ME-Sender: <xms:Ly5tZgI2qR4RiBk4zQI3rNVe7pd6o8_aMiIhtnXbChFwrrAvFRz4vw>
    <xme:Ly5tZgLnX-JozYQPiuYp-IqraX77lYub3-rr2GZBqKT99GfORIojHmA98pHC6yIGL
    AtunFOa4O7tX9CXIaU>
X-ME-Received: <xmr:Ly5tZguAmTUA_HFCrixg67nxflqsPSOI0QJJw594FPL1XZ_TpmXN5uiV5BFYFgZraNRnZ25vjPEGG3PcdwOBmbGbISR8VMBnNyiH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedvtddgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttd
    ertddttddvnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeehhffhte
    etgfekvdeiueffveevueeftdelhfejieeitedvleeftdfgfeeuudekueenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:Ly5tZtbSbJThrsagKvWGfZGsO9lZZH5Y4FH1kopGyyonKOLBmF8x9A>
    <xmx:Ly5tZnbNTSW5iMqcgyT2T3pZ0ZrHFaHRj9BBm0_46rSJUtR1j5JLAA>
    <xmx:Ly5tZpAbZwa0NUHdCdGJ3oNub4-AqJtxb6XUu16kWfXJYXZ927_GMw>
    <xmx:Ly5tZtatBxjQU9cLqCzm4yaqH0HJNSu2Zc-x24RKWM4QMORdKKPg0Q>
    <xmx:Ly5tZmnTfNrFElbb4lVSchkkZ5wHIv-kvQ__91PoNouX4L-KNR-z5WNg>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 15 Jun 2024 02:01:18 -0400 (EDT)
Date: Sat, 15 Jun 2024 15:01:15 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firewire: core: record card index in tracepoints event
 for self ID sequence
Message-ID: <20240615060115.GA497879@workstation.local>
Mail-Followup-To: linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20240614004251.460649-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240614004251.460649-1-o-takashi@sakamocchi.jp>

On Fri, Jun 14, 2024 at 09:42:51AM +0900, Takashi Sakamoto wrote:
> This patch is for for-next branch.
> 
> The selfIDComplete event occurs in the bus managed by one of 1394 OHCI
> controller in Linux system, while the existing tracepoints events has
> the lack of data about it to distinguish the issued hardware from the
> others.
> 
> This commit adds card_index member into event structure to store the index
> of host controller in use, and prints it.
> 
> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> ---
>  drivers/firewire/core-topology.c | 2 +-
>  include/trace/events/firewire.h  | 9 ++++++---
>  2 files changed, 7 insertions(+), 4 deletions(-)

Applied to for-next branch.


Thanks

Takashi Sakamoto

