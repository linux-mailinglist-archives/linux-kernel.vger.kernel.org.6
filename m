Return-Path: <linux-kernel+bounces-437917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E7F9E9A79
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 16:27:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7676416192C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 15:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE1E1C5CA0;
	Mon,  9 Dec 2024 15:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="PjtCvuIB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rFvst69z"
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2F623312A
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 15:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733758060; cv=none; b=YT/9IkoHVyP4CXLjRFiXoV6sIozQBgC1wBabbdihWpb9+1rTiotvh7+3U7ostp2pZNBPKWJVGdYXEYFDI0dO9+MGgFLpVPniMhxg5V9hXQ1m++oGTpjpdSA+Qfsk39+T/91XyBKdIWHyKqiCca7hEdXo/ro8O6zOyi9y5lPUqwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733758060; c=relaxed/simple;
	bh=Mi6xyLASzYfyppW5vp8TMpaqmbV1tgszj4BQyrTpbFA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=o5B2xCipapihk97TGXTrm5QfUIAfyimXl2eeekgqovkFXlUg9LIuN2oNHWrnVRLhvmKF5ygaoPFmci62wC4w0KiSpotoK5vLfMtKHcZqYW3oDjgOyroWFfEAc+Ef3xxGnezHb/HAumcevaVt4nDzP7i3yL5gh9NaCAkbgxLrTsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=PjtCvuIB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rFvst69z; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CE99A254015E;
	Mon,  9 Dec 2024 10:27:36 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Mon, 09 Dec 2024 10:27:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1733758056;
	 x=1733844456; bh=g1wpLU7NdMNLKMJXitPexq3zWQMmtGFqtdStBciFX6Y=; b=
	PjtCvuIBomD0NC33tx10Lr/RuHaGuTSMMuNWOlh7t3f+jPDHD7FBKum3PaB0PPSv
	ZjeCk7FUXnZbOyd85LgLy0eDaxDi09/amwyiYxaydufp8IblfYKIb630Byl0WaLn
	XVJzIHVWTzGn0q2+CCOlsI4DQeCzU7RyivMnMWz+c/0NeozuqcfgGp3EpI2HswcA
	fd/TbomeVmZNvtebel+97+Gg/UqkPJdOveRJFk6naLIfaCh0+9E2RqOACwMWjtkd
	+JH0+yJemuQHVyMiXx+RY6Q0WFVhGQj2CEa6Zzf4LM5jE3gF1RhqavgfXGuNJzLO
	buyZusiLiKh1BlKUw71GyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733758056; x=
	1733844456; bh=g1wpLU7NdMNLKMJXitPexq3zWQMmtGFqtdStBciFX6Y=; b=r
	Fvst69zJKY8+MrLbf4po14ZKBgbWBi0L/Y4feBgdxdPp0WD+H0Bsl/4ASUVVL6wh
	knS5li5jUx4w9avH4xG/37CcWOCfc4YvF3ZTZ4aLNdCNuqIf3NyA+j7IQR71Zq4s
	XeEJcfdCgqm3WkJYw1xAtddoBS2bXVyPzRDDbj+ygc8v6W4zt1MKWPWqTrNubPd5
	HzrTP654g0g66Mdd4NOsFCt+mEvvzbnJUanbDNLuAzpKLlztwayeD0SAi2W54qjy
	gk+j0dccwAdwJzJy7F5wqVzaiYz6hyP4PdUYR4xuF1h6c30JJi9ODLR3ZDsTKFPC
	yO3HAxafVazR1A1/BHNvg==
X-ME-Sender: <xms:aAxXZ0Qh7KNgoQ4rjLgGnlKYMsD6Y-9hiCz03FtyYgiI3wy3c7mHOw>
    <xme:aAxXZxxeE9xwcuxWQtA081_mNeEfaphU_iGMaqU4k5CAEjFuYjfbWMitW9ODizP2E
    UPEImLIqo7CnuMx-I0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrjeeigdehtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredttden
    ucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdrug
    gvqeenucggtffrrghtthgvrhhnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffg
    vedugeduveelvdekhfdvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopeehpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehnugesrghrmhdrtghomhdprhgtphhtth
    hopehsuhguvggvphdrhhholhhlrgesrghrmhdrtghomhdprhgtphhtthhopeihvghorhgv
    uhhmrdihuhhnsegrrhhmrdgtohhmpdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrh
    hnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhu
    gidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:aAxXZx2S_Bv21hz3hVLHNM0DhYNB_S3FJFmyop0i2y0TbMmnhzWpWQ>
    <xmx:aAxXZ4Cwb_NTepIABwjTYBvgDmiN9SjwlgSu5K4MIwo-EFiyeIe11w>
    <xmx:aAxXZ9jqZPGXA85VrApzvxYeFMkxLb09CJntam5wpKF29um7fywB7Q>
    <xmx:aAxXZ0qq_MJtxNOA6H7x-Rr9pVBN5-ZjvRsS_uCWBrFnOYjKyeF3Rw>
    <xmx:aAxXZ9f2abhBisLhbbeovIqnN-gYz6v4OIXdLe4edRfywWTCGVxoh1Q1>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 028E32220073; Mon,  9 Dec 2024 10:27:35 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 09 Dec 2024 16:27:14 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Yeoreum Yun" <yeoreum.yun@arm.com>, "Sudeep Holla" <sudeep.holla@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 nd@arm.com
Message-Id: <9e60e996-070e-43a7-80e9-efdfda9f6223@app.fastmail.com>
In-Reply-To: <20241203143109.1030514-3-yeoreum.yun@arm.com>
References: <20241203143109.1030514-1-yeoreum.yun@arm.com>
 <20241203143109.1030514-3-yeoreum.yun@arm.com>
Subject: Re: [PATCH v2 2/2] firmware/arm_ffa: remove __le64_to_cpu() when set uuid for
 direct msg v2
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Dec 3, 2024, at 15:31, Yeoreum Yun wrote:
> From: Levi Yun <yeoreum.yun@arm.com>

I just saw this commit in the pull request, and I'm very
confused because the description does not match the
patch contents.

> Accoding to FF-A specification[0] 15.4 FFA_MSG_SEND_DRIECT_REQ2,
> then UUID is saved in register:
>     UUID Lo  x2  Bytes[0...7] of UUID with byte 0 in the low-order bits.
>     UUID Hi  x3  Bytes[8...15] of UUID with byte 8 in the low-order bits.

The specification you cite here clearly describes little-endian
format, i.e. the low-order byte corresponds to the first
memory address.

> That means, we don't need to swap the uuid when it send via direct
> message request version 2, just send it as saved in memory.

"As saved in memory" does not sound like a useful description
when passing arguments through registers, as the register
contents are not defined in terms of byte offsets.

Can you describe what bug you found? If the byteorder on
big-endian kernels is wrong in the current version and your
patch fixes it, it sounds like the specification needs to
be updated describe both big-endian and little-endian
byte-order, and how the firmware detects which one is used.

> Remove le64_to_cpu() for uuid in direct message request version 2,
> and change uuid_regs' type to unsigned long.

'unsigned long' makes the code unnecessarily incompatible
with 32-bit builds.

     Arnd

