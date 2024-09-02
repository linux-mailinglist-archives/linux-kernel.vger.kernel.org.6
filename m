Return-Path: <linux-kernel+bounces-310843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1E69681EE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B02B41C21B2B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 08:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4621865F6;
	Mon,  2 Sep 2024 08:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="O/moLlpe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dTthiM9Y"
Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B1718661C
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 08:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725265892; cv=none; b=sw+wlgK39SnZczr706hIcP4XfZxHl6CzaMMjEt4YT6+3q1wekTt4UX6GtwsISO41vFSjPw9rnD0m4hwD//CfbS6R3NwiC/zED6A5t1L9ouxHYxbTQLAy7345PC37/Rkwr1f8UEqb9T0s8HQonVjvUbtsbX0wfeatmpY1BixEWiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725265892; c=relaxed/simple;
	bh=fHYYnHE6Dn7P6OKnw76inhjRIE2ccvMa6gLmRgz8kOg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=F7lYdPGsz5U6Tt/GnWKgy0SXGNPtp+Ev2L/bSgqrRXxeMkMfhvSnDmUkSQX/ZgdtQBTmjCM8ITiMLf6v2P9dra7d1WuaY+Ev0qACumjVkMbci3HZmU8qgKCso1ks+rMAbe4Ioxyiu12gYR3O80kLZ0VJeiqjuJkLxjtGIPnFqFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=O/moLlpe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dTthiM9Y; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 227D91380371;
	Mon,  2 Sep 2024 04:31:29 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-04.internal (MEProxy); Mon, 02 Sep 2024 04:31:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1725265889;
	 x=1725352289; bh=V6qSRDQuSIP7OjXQgmwIcXYuXlRNSI6hDsiXyNOF7ac=; b=
	O/moLlpeIGMJ0v8+919zfughMDyGESAJPNpKfhq7wttsyXXo7id9Ru4i+1xLoMTk
	KekDMXjW5GhwgfftoxqD7bwjkat5ZqUIOgtVL7iCghg9CUDKLIx38GKBpweZO/QF
	Q/1n0iWEAhtShwnMREjckL6943WY6LSIZjeJj98dOhVx6s6TG7DWlxvZw9eQvDsZ
	llx5YuzHDAu6sYSKm3r+7y7rezRym+fb08DH/kQ9W2oOpHkNU1Oc9PevNlytxJdx
	1S0NRn+tQiNdoR6s7xvSpfvYn4iWC8hbEXFTgJY7KXqbavHOVXLftX5cqQ5Iu041
	WKJgxerIrRHnF9+iHjMNhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1725265889; x=
	1725352289; bh=V6qSRDQuSIP7OjXQgmwIcXYuXlRNSI6hDsiXyNOF7ac=; b=d
	TthiM9YqdBQ5ZHgDTG8x7hYNA/BoRS4ctVgTyHktnQtHY1u0x9XtZBF3mMFsUnT7
	SKb8ASPdE4RYU6pIBotngnCjn9TQ5IiMJTVlHN1lRhOAO6cvRSwxhj9SbRONGH+G
	grgPmw3WpE94/riJWNdG3ARleTbA22+CylSgE6NBQt56ZbD30J25tBWbCA6WcqiA
	Xf8+qkufkV13TeIAvB9tY/sg8mfiqu7u2/E6RiLjNQIPvTUPhCkK8ZscyQb2AxOx
	3lB+zPdnKLsCF568YtLWQNRnNausFHXsM9R+yICplwrkUnUWTIQo0qimln6IFqD6
	ZIWAC796dJ/NDKeZOUG7g==
X-ME-Sender: <xms:4HfVZihCfPEf4MfRc8HwB04CFCn_KSuPtp9nAnJVIIa2uakMe0nQ1w>
    <xme:4HfVZjA3LmobvqtLHFcmZeoUSyv54vRDVdU4X8rTU6x2wR55kQVSW44ZIKb02_3Mf
    mDezAcMab9JXH6ONAY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehfedgtdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhepfefhheetffduvdfgieeghfejtedvkeetkeejfeek
    keelffejteevvdeghffhiefhnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghr
    nhgusgdruggvpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehlkhhpsehinhhtvghlrdgtohhmpdhrtghpthhtohepjhgvnhhsrdifihhklhgr
    nhguvghrsehlihhnrghrohdrohhrghdprhgtphhtthhopehlihhnuhhsrdifrghllhgvih
    hjsehlihhnrghrohdrohhrghdprhgtphhtthhopehulhhfrdhhrghnshhsohhnsehlihhn
    rghrohdrohhrghdprhgtphhtthhopehgrhgvghhkhheslhhinhhugihfohhunhgurghtih
    honhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghr
    nhgvlhdrohhrgh
X-ME-Proxy: <xmx:4HfVZqH34jKym9HtQaU_92zJYPI2J5zMeME4xDEy9XCbOns48oDyJw>
    <xmx:4HfVZrSBbcDpnWPnrVzeYRNeMclRx24AH4ODuBP8gSH_yRnuKFPxAg>
    <xmx:4HfVZvy1Wzd-fT6AxvghjRG4KSzGrcJlpgLCdf0im4DO-NURZ7MKqA>
    <xmx:4HfVZp6Aw8QRSxOgMfqHQzvFJTsjziXg-PxhO2nfz-KSDaLkuuS-6Q>
    <xmx:4XfVZqqET4dDCTltpkUzNmhVKFTdbmWOpPY8uOx_840iyBliI1TlwNm8>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id C70322220083; Mon,  2 Sep 2024 04:31:28 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 02 Sep 2024 08:31:08 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jens Wiklander" <jens.wiklander@linaro.org>,
 linux-kernel@vger.kernel.org, "Ulf Hansson" <ulf.hansson@linaro.org>
Cc: "Linus Walleij" <linus.walleij@linaro.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "kernel test robot" <lkp@intel.com>
Message-Id: <b1787919-77d3-41da-9ebb-cecc65d2d310@app.fastmail.com>
In-Reply-To: <20240902080727.2665235-1-jens.wiklander@linaro.org>
References: <20240902080727.2665235-1-jens.wiklander@linaro.org>
Subject: Re: [PATCH] rpmb: use IS_REACHABLE instead of IS_ENABLED
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Sep 2, 2024, at 08:07, Jens Wiklander wrote:
> Use the macro IS_REACHABLE instead of IS_ENABLED in <linux/rpmb.h> when
> deciding if prototypes or stubbed static inline functions should be
> provided. This fixes link errors when the calling code is builtin while
> the RPMB subsystem is a module.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: 
> https://lore.kernel.org/oe-kbuild-all/202409021448.RSvcBPzt-lkp@intel.com/
> Fixes: 1e9046e3a154 ("rpmb: add Replay Protected Memory Block (RPMB) 
> subsystem")
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>

Please don't work around a bug like this, fix it properly instead.

> diff --git a/include/linux/rpmb.h b/include/linux/rpmb.h
> index cccda73eea4d..37b5273c4027 100644
> --- a/include/linux/rpmb.h
> +++ b/include/linux/rpmb.h
> @@ -61,7 +61,7 @@ struct rpmb_dev {
> 
>  #define to_rpmb_dev(x)		container_of((x), struct rpmb_dev, dev)
> 
> -#if IS_ENABLED(CONFIG_RPMB)
> +#if IS_REACHABLE(CONFIG_RPMB)
>  struct rpmb_dev *rpmb_dev_get(struct rpmb_dev *rdev);
>  void rpmb_dev_put(struct rpmb_dev *rdev);

This gives very unexpected runtime behavior where both RPMB and
its user are enabled, but it doesn't work.

I think what you want here is a dependency like

      depends on RPMB || !RPMB

for every caller. This enforces at build time that the MMC core can
be built either when RPMB is disabled, of when it is reachable.

    Arnd

