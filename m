Return-Path: <linux-kernel+bounces-325205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 242C397561B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 16:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D66C5287CB2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 14:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270521A3BA0;
	Wed, 11 Sep 2024 14:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="QCtU0Wrg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Sz3G0FAt"
Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F3B15C13F;
	Wed, 11 Sep 2024 14:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726066492; cv=none; b=ObRDQQOemtIS5riiyEOvrl4CrYpgNlDbY6eNMfmVPUHGM5/A8aZqvQKlD3wlTB/7BA77tP7O174xAjEf4l0cknCACUUI0lZCbKCqc9aV7pLgzpPCXWSjqtGBXkVG7En+Z1fDm0V8sDVVwrqxTUVgXQ9aLHb6Cfx6hYZRcIT1ek8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726066492; c=relaxed/simple;
	bh=TEGsLt1jeouhgGKvWBnhX2IAfldS80tGzCPn3MIWvjQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=r3mjig/d8HSkOo204peEzXTpFLJm9aXGJnHdLlOsnPSvfrTbNow8a1itBqtQr8bqg1UqNpY17hUPmhjEB6EXx3pwh+CTVEsHA3gpUZBgI+BycAv9eqxBtf1xLIqheE4kkpAgIa+HsX374uzfgMZf2sMxK/fKgc6ND5Ld0t+beE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=QCtU0Wrg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Sz3G0FAt; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A899E1140162;
	Wed, 11 Sep 2024 10:54:49 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Wed, 11 Sep 2024 10:54:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1726066489;
	 x=1726152889; bh=o31KnfvC+LHhCIJAD2586HDBNBdNcofxhPOGlMMUPUo=; b=
	QCtU0WrgDQxoCHeKmBDc6R63ChRlU5hUM90Hoku381EWq3g0CKmtvHyKLWQTVxrV
	+H9APqJBeokfChc7910FOKN7Cv+hksEg9IEgAVsrJMO6ymsK6hI1s3Obta+kqtBO
	LKso3g9bvN9Sk7zQE2NIlG69N0NrsS4I/1EzA2PYnC5AiGkYtnHjUsFutmSvJrT+
	LrRYPROiz90Q43wtCNXiAGjspg3hc/OmBpNYGoy6wkJfWo1z2TATx/SjhEEWkbeg
	MScaATOH1LfN3AqbTfF+vWic2PijIcfwvAvrB02tchRpdRgg9gTEhEDDFViKzc7H
	M2EfoQf9bZ7xjWh0mjoD8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1726066489; x=
	1726152889; bh=o31KnfvC+LHhCIJAD2586HDBNBdNcofxhPOGlMMUPUo=; b=S
	z3G0FAtclbvFLfaMcrjSCO78eBG3LCNZWuA+l/+EmMJjmc5eZf+YfF9RY/dHWwU9
	d0wygw9jDZguZrEPGiOSTz+WGZlgZq7ZHLYYGgGYFr62pROUgV67s9HaNtD0Zfx2
	hLRJEF/nC7l0dBXy0XmX61eCwMMLOTwQExorN2JdXWI+M9Som05d7DrjrvQybAaG
	LpRJyth8wFH1sciGD/x+mPr59FxxpfGEWEPxm5XBma9UzxtwB0G4YNuSnC+yheKe
	2ewz4R1++ffwLzNAw3ueWyMS9hN1n9Qw6JnFb0Yy+Mu/VSot5cSPqSWqO8aXl6H4
	iebCZnQC/Crjf4JAzfERg==
X-ME-Sender: <xms:OK_hZjHSDxXV5G6iegUpFDvE24omDHSmTboLCr8uHJaBbeYEQPdY5w>
    <xme:OK_hZgWhtrnEr0F1TPX0Z8NrfLXxrprnB35GnT801MApPwwrfcELi05y15_BOwSyf
    acX1ZhxAGjzFGkilm4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejuddgkedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefg
    gfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepkedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrd
    horhhgrdhukhdprhgtphhtthhopegrlhgvgigrnhguvghrrdhsvhgvrhgulhhinhesghhm
    rghilhdrtghomhdprhgtphhtthhopegurghnrdgtrghrphgvnhhtvghrsehlihhnrghroh
    drohhrghdprhgtphhtthhopehlihhnuhigqdgrrhhmqdhkvghrnhgvlheslhhishhtshdr
    ihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehnihhkihhtrgdrshhhuhgsihhnse
    hmrghquhgvfhgvlhdrmhgvpdhrtghpthhtohepkhgvrhhnvghlqdhjrghnihhtohhrshes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlh
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehhshifvggvthgvnhesvhhi
    shhiohhnvghnghhrrghvvghrshdrtghomh
X-ME-Proxy: <xmx:Oa_hZlJlaeV6S3piIFOMyZSw9R27_Dl17HgwJaJPqxG8v-nv-Fwpcw>
    <xmx:Oa_hZhE8YycP-7ydAsD_N8c_4CnCs6DNt4n2swjyY8FHLKAZNFC8Jw>
    <xmx:Oa_hZpWdJ0fhn6WWNSUZn-KCkxATptiXt5--scjH4SwtFy9NaIUV0g>
    <xmx:Oa_hZsOStN-jBj4XnuOCevMTZNjwg9q7KQxJjbiH5lQAbhbj6nXntQ>
    <xmx:Oa_hZoF2Tl1tS3rdBortOMb8B6ZzkmxM-KkVRhXM1nOC6_iXlPuCFYYm>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id DE1192220071; Wed, 11 Sep 2024 10:54:48 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 11 Sep 2024 14:54:28 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Nikita Shubin" <nikita.shubin@maquefel.me>,
 "Dan Carpenter" <dan.carpenter@linaro.org>,
 "Alexander Sverdlin" <alexander.sverdlin@gmail.com>
Cc: "Hartley Sweeten" <hsweeten@visionengravers.com>,
 "Russell King" <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Message-Id: <a1ceab99-f26c-4edb-8f72-12abf20eec9f@app.fastmail.com>
In-Reply-To: <246de2986dce9d867894bb006a1b2b3601e94a4e.camel@maquefel.me>
References: <a05454f8-e409-4f60-93f7-6aa2ea0a2a23@stanley.mountain>
 <246de2986dce9d867894bb006a1b2b3601e94a4e.camel@maquefel.me>
Subject: Re: [PATCH] ep93xx: clock: Fix off by one in ep93xx_div_recalc_rate()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Sep 11, 2024, at 08:14, Nikita Shubin wrote:
> Hi Dan!
>
> Reviewed-by: Nikita Shubin <nikita.shubin@maquefel.me>
>
> Alexander, Arnd
>
> unfortunately, the ep93xx DT conversion series is also affected by this
> bug.

Here is what I did now:

1. applied Dan's patch on a new branch
2. applied the DT conversion series on top of that,
   removing that file.
3. applied the first patch (with minor context changes)
   in drivers/clk/clk-ep93xx.c again, along with
   the MODULE_LICENSE fix I did.
4. finally, merged the entire branch into my for-next
   branch so it actually makes it into linux-next

My plan now is to keep the branch in linux-next for at
least a week and send all the other pull requests for
the merge window first. If no other problems show up
(either with this branch or my other 6.12 contents),
I hope to send it all later in the merge window. If
something goes wrong, I'll send only the bugfix as part
of my first fixes branch for 6.12 and we'll defer the
DT conversion once more.

I should have merged it earlier, but wasn't sure about
interdependencies with the parts that already got merged
elsewhere and with the comments about DTC warnings.

From what I can tell, the current state is as good as
it gets, as we'll always get more comments or conflicts
with new reversions of the series. Let's hope we can
address any other issues on top of what I've merged
now and stop rebasing.

    Arnd

