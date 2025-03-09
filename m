Return-Path: <linux-kernel+bounces-552953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE368A5816D
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 09:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C97D53AE99D
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 08:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A38C183CCA;
	Sun,  9 Mar 2025 08:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="b3RCb9ZJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rCyICrMO"
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BDCC2FD
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 08:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741507500; cv=none; b=MNACD0hh+057Rqth8+bskvXfJHC9m4s62/fualkC2vPXy/EO1sfjNdvJGWPhTSpEPFdPbbvB2cO3yGHxboGfXlA0JHr2k8ylfK5pWEah87BaVSAhFcTrjCm2JAlxWCCk0VzshW48hRFO40J7gSg5LOEGsF8lbXAn5u+5CWWJ7kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741507500; c=relaxed/simple;
	bh=BpiG0WDe1Lcls4MUZWZafgma3RijC7WNleRW4wBVUQg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=avzMlpSLEa78bNN7vV2jXQI7rdQfc1BVT0U8wTagwj6QcKBn2K74l79XwDLmbtYMMP8tIeFQnmySHbaY34BfYUoi693ePj0FMbMRussNu77xzXlw8ibExw8nHsUlRQEIcc/l+EdbgkKU/swjkZM22P8St5Q6K829/VURirFVO1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=b3RCb9ZJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rCyICrMO; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 652942540160;
	Sun,  9 Mar 2025 04:04:56 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-07.internal (MEProxy); Sun, 09 Mar 2025 04:04:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1741507496;
	 x=1741593896; bh=V/+c+PfSv9Xbnb72b+7nPtdlmShsnuUQf+Gys1FKZRs=; b=
	b3RCb9ZJed0cffiq+kpxIx2fEdfHKb/AnMmYUuJWzgkbngdGD69WP5tyoHVhl74K
	3BOm5CVkDIf/BYwdphC5IHkxyqK2LhpORJFJpn5bT9j4SU6lqEbp+2QlbzF7ne2X
	BlkidegF831ciauOTqEENa1JYdbUlNcanLIVtzLotTbr8cAFVSsSmeGuV9e+oRVD
	cG3AjkfX3zB+xZAkbIhs1GTwRTrelQZLFGEh+dRbGaayNrORqwvGGGahSmx1sS+U
	mtB3Q6kG0Hb5F4R/SNGTzlnN+SyfJgTcGz/aqEvy6p2+sI71wpMAibLp/+YV2yfg
	4j828AbpP9oOfhzNHCBW0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741507496; x=
	1741593896; bh=V/+c+PfSv9Xbnb72b+7nPtdlmShsnuUQf+Gys1FKZRs=; b=r
	CyICrMO5jdMpzat+Er7wqT4fWws5kqjyCnCFFvpZMgP5Dhnspkxi7SM+82hpR5i5
	sUY+1ReYiMwBH9NcM1zemOMEqMK+I7xflpvoQkBsnAh9ioI/3Dy16LUCsJPPFTfe
	2Xvg3EjqlSjD1i+ttRdKpno3vZzlTEIiqWdnE0sgmbZAWMPCHnoSp3Yjf03pxS34
	oIwhW5/3X+eyLQCRKrRpkvFPndy+HqVFIRJnovhOV8MbrMKM87UM2qGaSjMwM5bz
	DboLlNWG0VGnIqfzMeTKvEKpf3xSYnoMk22pC9izfbwef3pufY1KzNGNWiWmtibw
	llBorT7Ot/EPHjg+9W4uA==
X-ME-Sender: <xms:p0vNZ03CgzlL47ZftuMBw1gbYKPIurw6i3ELOTh0ymRWgciJqc5eBg>
    <xme:p0vNZ_EEnQrJw9d6M1OqKE9sU5vuzXnXPnQhWKgKfIPWVYeTDyzHr25jknAZZ7CBp
    1BT5UEUbom1CQqYBh0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudehleduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefogg
    ffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcuuegvrhhg
    mhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrhhnpeefhf
    ehteffuddvgfeigefhjeetvdekteekjeefkeekleffjeetvedvgefhhfeihfenucffohhm
    rghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohep
    fedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhgvvgeskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheplhhinhhugiesthhrvggslhhighdrohhrghdprhgtphhtthhopehl
    ihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:p0vNZ8741xqegNpqM-EmEPkpNt0NtptqW9r6gfW8eDPmjwP4Cs0XFw>
    <xmx:p0vNZ91vSb4zvhgZguRs9y9KR750MzN3ZCcrtiueQSyBeytBk9z03Q>
    <xmx:p0vNZ3HzxAHp9SOXYsoU0XKfJHGrh_C5aUArKs5IJiHZ0_QqFngTIQ>
    <xmx:p0vNZ2_JpZ4AGgisH4FZR4EEbFo3gjPAfGm_u2r7E4W1fbNje49J2Q>
    <xmx:qEvNZ8SdtqjN8Wv1F10GcHQ125szM8HdLedRSwme9bt8sxeo9pf0GVC0>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8E6A92220072; Sun,  9 Mar 2025 04:04:55 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 09 Mar 2025 09:04:34 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: linux <linux@treblig.org>, "Lee Jones" <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org
Message-Id: <d68fbcda-d77c-4426-b579-57010de82c7b@app.fastmail.com>
In-Reply-To: <Z8z236h4B5A6Ki3D@gallifrey>
References: <Z8z236h4B5A6Ki3D@gallifrey>
Subject: Re: the pcf50633 - dead?
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, Mar 9, 2025, at 04:03, Dr. David Alan Gilbert wrote:
> Hi Arnd,
>   My scripts noticed pcf50633_adc_sync_read and a load of other
> pcf50633 symbols weren't called; and hmm I'm pretty sure most of it's
> dead.
>   Your:
>  61b7f8920b176e3cb86c3b5e7c866261720a7917 
>   ARM: s3c: remove all s3c24xx support
> removed the last/only includes of any of the pcf50633 headers,
> I think it was part of openmoko.
> The only place I see it enabled (=m) in a config is
> arch/mips/configs/ip27_defconfig  which is the ancient SGI Onyx
> which predates the pcf50633 by a good few years (and is definitely
> not portable and battery powered!)

Yes, I have that one on my list of drivers that are unused upstream
and should be cleaned up.

See also my reply at [1], feel free to send patches for any of those.

      Arnd

[1] https://lore.kernel.org/lkml/a15bb180-401d-49ad-a212-0c81d613fbc8@app.fastmail.com/

