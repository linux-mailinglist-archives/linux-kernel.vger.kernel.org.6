Return-Path: <linux-kernel+bounces-372001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D03689A4323
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 18:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F87228A6CB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 16:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8391FF5F7;
	Fri, 18 Oct 2024 16:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="itViWaYU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KOkWr2j2"
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0B14207A
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 16:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729267303; cv=none; b=YBjX9ojdvDA48JZl+6eSfB5c3f0vU32aq2TGZRbjDJCjSxuejMsBGq1BpPSFp4F2Gl7SjvPTdyuL6Q8S7Qc83dXWMZ2sAFBWbImH3ZufTleVmD0gUmBmL1j+8P4MpORMAxX2RGa2X8zh6w2RpUJRol1xGk85WRmFiGUbFl9R/X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729267303; c=relaxed/simple;
	bh=3Ie0PXZEHTY+zqhprmnN8AxiG8zgAlQ9Vub9AzGxIOs=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=oyOM4ggXJv6Dv985h+C3gkHwHrfsFsphQjIevNGov67rfMUiiFT2n9uy4jM5zstxZSlKHWV+UFHFJeSPBQS6tWJoa/4rUhNtU72oS+TjH/Q4RiWUgdSm92WOkk9KBss3pd4HZSmmILGP3nBddid/Nnh3ehvrdw8yapE6yk/K10U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=itViWaYU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KOkWr2j2; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 0E9E013800DF;
	Fri, 18 Oct 2024 12:01:40 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Fri, 18 Oct 2024 12:01:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1729267300;
	 x=1729353700; bh=P9Apt1nbtdeQ0a3W4zKojvEn5mSX00mXwGNDKio6VuA=; b=
	itViWaYUMUHdgEj0/RGD3MHHtpT00hsX18QqDhvwSGaheJylGRD/iUev36w15HsT
	CKZ96iuR9T+QWdhl1tPJXO0i+prMHO4UGh++1HIK7uySy4aQs7PM0+tPCG5/mVlO
	64gymRo0qsybCk15k7o4jxRAk0avjsuVDxQaI5qysA3dKXWoRnr3NEuTsnT2MnoJ
	mmRsLEqSesPwFk67GU609sroX0cZOV1pGlhRhsiSZqVtXrWfP+OtYqvezjkFJMAt
	bbOR9LS9Wkn8Xb7M/Y+mbnHI1zLvwsQMeeeju1DJFkv8tMJOCVCQx1TFUfcKueuL
	wmVJ8Wysmb4auhHEsvetOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1729267300; x=
	1729353700; bh=P9Apt1nbtdeQ0a3W4zKojvEn5mSX00mXwGNDKio6VuA=; b=K
	OkWr2j2KA9PZTfz8FsltzY6mii397Uwei7+Lyh1qin2lDXR05aiM/c4YB5ka8qZU
	PQ/UecOZXq5cbSHzRI+3iIY90eSFVqrQGs0fqjcJTFs2ClgKibqyAjGBuJ2wwum9
	ofV1KMypFkDo4+78pQv38bGQNWB0jBMSmXgXN7+vvG+4nmgie9ermoMLNmhXfkep
	wJMt3/ivfXLjxXoiCPCpGIy53Ycy9iDeLOj0BJUmZBB0CMjFEc3doeQC7AbnvPgW
	WFso6La3AITqObeQ0qzZWRDPKcRKQuXpZhLmjOkIHo9GoGzWsA6t6GqtalmY3xGT
	T3fAKIbQ9aEfi6Wn7oIMQ==
X-ME-Sender: <xms:Y4YSZ-Jk-3QxjSsGxYuMfxPJ0VaJ_JXetxfiEAIUc5O5dD971KGe2w>
    <xme:Y4YSZ2Ic--_EqLXAfAOBqYmFD77GogjXUIRnyRxovo3zHBfKbtbAoB9h2RSydCPJE
    r5jLL-sNMKZ7qqNt2o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehfedgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefg
    gfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepudef
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsihhmohhnrgesfhhffihllhdrtg
    hhpdhrtghpthhtohepghgvvghrthdorhgvnhgvshgrshesghhlihguvghrrdgsvgdprhgt
    phhtthhopegrihhrlhhivggusehgmhgrihhlrdgtohhmpdhrtghpthhtohepihhmrhgvrd
    guvggrkhesihhnthgvlhdrtghomhdprhgtphhtthhopehjrghnihdrnhhikhhulhgrsehi
    nhhtvghlrdgtohhmpdhrtghpthhtoheprghrnhgusehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehmrhhiphgrrhgusehkvghrnhgvlhdrohhrghdprhgtphhtthhopegumhhithhr
    hidrsggrrhihshhhkhhovheslhhinhgrrhhordhorhhgpdhrtghpthhtohepmhgrrghrth
    gvnhdrlhgrnhhkhhhorhhstheslhhinhhugidrihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:Y4YSZ-t5I-fEAq27p_KSet2yelvgn8up0UqbHYA8yn_okz2f89-c1w>
    <xmx:Y4YSZzZ3K730ejWLxZpZfUwY714xJpE_70oYGFkUCPNdyk3g_UPhTQ>
    <xmx:Y4YSZ1YKqI64KlYFX2vi-n1fZIvYZgE1MtS1r3Icc_u_6S_-Do2DOw>
    <xmx:Y4YSZ_BGBFMXihQtIJduRVeRXIV5L56OJK_QN3RCQ3wu3N-ausZYpg>
    <xmx:ZIYSZ5Q_NBdb3MDcJjpwcOwmj3wdrJqSdJjniD9faQeTTvAcy3AvtiHh>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 4ADB62220072; Fri, 18 Oct 2024 12:01:39 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 18 Oct 2024 16:01:17 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org>,
 "Arnd Bergmann" <arnd@kernel.org>
Cc: "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "Dave Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>, "Philipp Zabel" <p.zabel@pengutronix.de>,
 "Jani Nikula" <jani.nikula@intel.com>,
 "Geert Uytterhoeven" <geert+renesas@glider.be>,
 "Imre Deak" <imre.deak@intel.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Message-Id: <19944f9b-e7d7-45da-bf1c-0c3eeda27c12@app.fastmail.com>
In-Reply-To: 
 <3yqpyobkkvnan4fo5h3vx5jw5ke4zqoavo354rkw7h3frleurn@oag6vpmedaz6>
References: <20241018150850.3418359-1-arnd@kernel.org>
 <3yqpyobkkvnan4fo5h3vx5jw5ke4zqoavo354rkw7h3frleurn@oag6vpmedaz6>
Subject: Re: [PATCH] drm/bridge-connector: select DRM_DISPLAY_HELPER from
 DRM_BRIDGE_CONNECTOR
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Oct 18, 2024, at 15:42, Dmitry Baryshkov wrote:
> On Fri, Oct 18, 2024 at 03:08:45PM +0000, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> The imx display drivers use the new bridge connector helpers but don't
>> explicitly select CONFIG_DRM_DISPLAY_HELPER, leading to a link failure
>> in rare configurations:
>> 
>> ld.lld-20: error: undefined symbol: drm_bridge_connector_init
>> >>> referenced by imx-ldb.c
>> >>>               drivers/gpu/drm/imx/ipuv3/imx-ldb.o:(imx_ldb_bind) in archive vmlinux.a
>> >>> referenced by parallel-display.c
>> >>>               drivers/gpu/drm/imx/ipuv3/parallel-display.o:(imx_pd_bind) in archive vmlinux.a
>> 
>> Move DRM_BRIDGE_CONNECTOR out of the DRM_DISPLAY_HELPER block and
>> instead select that symbol indirectly.
>> 
>> Fixes: f94b9707a1c9 ("drm/imx: parallel-display: switch to imx_legacy_bridge / drm_bridge_connector")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> I think a correct fix is to select DRM_DISPLAY_HELPER instead.

I think I just didn't express that clearly enough, selecting
DRM_DISPLAY_HELPER is what I did and what I tried to explain:

>>  config DRM_BRIDGE_CONNECTOR
>>  	bool
>>  	select DRM_DISPLAY_HDMI_STATE_HELPER
>> +	select DRM_DISPLAY_HELPER
>>  	help
>>  	  DRM connector implementation terminating DRM bridge chains.

I had to move the 'if' block just to avoid a circular
dependency.

Or did you mean the imx driver is the one that should
'select DRM_DISPLAY_HELPER'? That would also work, but
adds a bit more complexity.

      Arnd

