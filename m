Return-Path: <linux-kernel+bounces-423973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 000BC9DAEEE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 22:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CDE4B21D62
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 21:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98F12036E5;
	Wed, 27 Nov 2024 21:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="gjq3hl0X";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OwTYQmd9"
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED3313D518;
	Wed, 27 Nov 2024 21:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732742656; cv=none; b=EJmP8dq7wCMDinKcMzVCa3ZBCUb0Y4Dz5A0ig3U0svDbrkGHCQgX7iEk1CxpCQVNs6Gpl9XL6xI5IlG8SCZ+DlTQMBecKuSOL8+TjGiN+7ZFsz4pXjqD4sK3a8x4NIQQmfd2O5/DDMD4hA/lIExyHUsl3I2f1wDO9a54ls3Adms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732742656; c=relaxed/simple;
	bh=h6OeHMu0PZWvASV5lowdtV43UgQFs2F1Z5FoT+vDHsw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=s+8I74q7R+qyYfzy2E9NmMoQ+6Jfl1z/BHqh1Bh8ocTZgVlZIrRbwfjUa6Gm/yZPkV+nhR90DwsYeoyTUnz1nxOIAu1jhucR4hpr3V0uRSUOAthkpL+Tl2mcMEm4KGjjd+8VId4o7xZmir0ZgeRt1nSjolID7I4s9IYy88IMnlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=gjq3hl0X; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OwTYQmd9; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0F9E3114019B;
	Wed, 27 Nov 2024 16:24:13 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Wed, 27 Nov 2024 16:24:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1732742653;
	 x=1732829053; bh=A/qG1PCWH5DIdjBCou8V6S3ZjochUv53NXLjRXrbNBA=; b=
	gjq3hl0XgvRADwxaY6xtVoz2rKXiUC+9uUIjK4JTyo1B1TgozvlUu5J+lfzmMGRx
	+U/PbOrTr4G7/wW18lBRGEjs9AGk0CuZ83nO6loMdATqv/Rjt8z93Z8kdraPeB7d
	RNZlMOMN0ZsWn592gnrKjD5D7gnQDr87DZnHPgxet3szA6Q+QKzb6PogLVj1Bv8B
	QnhbeiNFAu1wVbvxhpWpdoy2PYHhoUWp5GL1uMCozj8bbICGt0I9LKfQRFJUwKHo
	Y6fd9aKXXMsJjkZTvivrdYdyA1UpyWT8xdyhM2imAD4506dtLLzhjHtKEdeQNwoE
	+wSmRZXmmdicvinRZt7R4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732742653; x=
	1732829053; bh=A/qG1PCWH5DIdjBCou8V6S3ZjochUv53NXLjRXrbNBA=; b=O
	wTYQmd9TokVOLvF2vAUccJfwlyLPiRR+Ctjlp2D6Q/+QhK3bWZM02wr+h03D8YSm
	6tOQf5lLvxwMMHMc1o/SmIuwG06+W6utUJMtT4GsgvWTHzrGdqCrV1fGdGBvVC/7
	GMLQ//uep/AFuZkzU7mws1oFFxAfSFMAjckG1oWESy8lGU3qbPbidUZ8YLiKVewL
	k0zy2FszKmEmkv/WoAALuUHhx5tH9d1nv5fKkgx2S9bPQaMm3KiouInkWVnQ2EZx
	Q8V1gQMusCh+nCJ5UuXVa3V+gSHzC4jcdxzd/mHSyvgT+gCHWccCOVaPAu4v2cKL
	Rmg19EGUt3wu5i9ezquzw==
X-ME-Sender: <xms:_I1HZyaQhEH4eHjR5OhZ10hCPejA0CCvC8p2egqcgPvxViq50J-bSQ>
    <xme:_I1HZ1ag8R2tf9dHilhGNaPLvdg3vOs-jhTjLRj5Xhg3xiadbUMimzlUHPN5iPGHX
    A42ur3BB-deBEAgGlE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeelgddugedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefg
    gfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepuddu
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjsghruhhnvghtsegsrgihlhhisg
    hrvgdrtghomhdprhgtphhtthhopehkhhhilhhmrghnsegsrgihlhhisghrvgdrtghomhdp
    rhgtphhtthhopehmthhurhhquhgvthhtvgessggrhihlihgsrhgvrdgtohhmpdhrtghpth
    htohepmhgrrhhtihhnrdgslhhumhgvnhhsthhinhhglhesghhoohhglhgvmhgrihhlrdgt
    ohhmpdhrtghpthhtohepsghrohhonhhivgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epshgsohihugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvihhlrdgrrhhmshht
    rhhonhhgsehlihhnrghrohdrohhrghdprhgtphhtthhopehlihhnuhigqdgrmhhlohhgih
    gtsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidq
    rghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhg
X-ME-Proxy: <xmx:_I1HZ8_gljDEAjSj2_i2Z32mj08WcG0CpxI1zfSJ_oJPxJPsntoPpQ>
    <xmx:_I1HZ0oe70OojxKuJDXilLWlsi8MBucRGyAEZ3uUCGQ5n36zHwBSuQ>
    <xmx:_I1HZ9olghZMkwyy6fj-KC-n5WxUi5GgDyBvL1LJOAPGhMcPWB1qIg>
    <xmx:_I1HZySWSvXIL8IFo4ONqcn7vqXzffoi6f45QK1OqQcg3_N46AoHRQ>
    <xmx:_Y1HZ6jihTLiBZlmwD58U1KDPO3yzSFtSW4gdoCbZ3mvINjfEFKhJ_mX>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A71B22220071; Wed, 27 Nov 2024 16:24:12 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 27 Nov 2024 22:23:52 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jerome Brunet" <jbrunet@baylibre.com>
Cc: "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Michael Turquette" <mturquette@baylibre.com>,
 "Stephen Boyd" <sboyd@kernel.org>, "Kevin Hilman" <khilman@baylibre.com>,
 "Martin Blumenstingl" <martin.blumenstingl@googlemail.com>,
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 "Mark Brown" <broonie@kernel.org>
Message-Id: <f8de4a2a-776f-4c10-b75e-e845bcc38dde@app.fastmail.com>
In-Reply-To: <1ja5dk2y5l.fsf@starbuckisacylon.baylibre.com>
References: 
 <20241127-clk-audio-fix-rst-missing-v1-1-9f9d0ab98fce@baylibre.com>
 <12f29978-c8ce-4bee-a447-dcd086eb936d@app.fastmail.com>
 <1ja5dk2y5l.fsf@starbuckisacylon.baylibre.com>
Subject: Re: [PATCH] clk: amlogic: axg-audio: select RESET_MESON_AUX
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Nov 27, 2024, at 21:56, Jerome Brunet wrote:
> On Wed 27 Nov 2024 at 20:30, "Arnd Bergmann" <arnd@arndb.de> wrote:
>>
>> It looks like RESET_MESON_AUX is a user-visible symbol,
>> so you can simply ask users to turn it on, and add it to
>> the defconfig.
>
> That would work yes but It's really something a user should not be
> concerned with. I can follow-up with another change to remove the user
> visibilty of RESET_MESON_AUX. It is always going to be something
> requested by another driver.

But that's true for all reset drivers, each one of them is
only useful because it's going to be used by another driver,
same for clk, pinctrl, regulator, ...

All other reset drivers are user-visible, with 'default, so for
consistency I think it's best to keep it that way, and
just add a 'default ARCH_MESON' the same way we have for many
other reset drivers:

diff --git a/drivers/reset/amlogic/Kconfig b/drivers/reset/amlogic/Kconfig
index 3bee9fd60269..c02edc1b51aa 100644
--- a/drivers/reset/amlogic/Kconfig
+++ b/drivers/reset/amlogic/Kconfig
@@ -14,6 +14,7 @@ config RESET_MESON
 config RESET_MESON_AUX
        tristate "Meson Reset Auxiliary Driver"
        depends on ARCH_MESON || COMPILE_TEST
+       default ARCH_MESON
        select AUXILIARY_BUS
        select RESET_MESON_COMMON
        help

The only bit that's special here is the exported symbol,
but that is handled by the dependency.

>> I also see some silliness going on in the
>> include/soc/amlogic/reset-meson-aux.h, which has a
>> non-working 'static inline' definition of the exported
>> function. Before my fix, that would have caused the
>> problem auf a non-working audio driver.
>
> If by 'silliness' you mean there is symbol definition for when
> RESET_MESON_AUX is disabled, indeed I guess that could go away.

Yes, that's what I meant.

      Arnd

