Return-Path: <linux-kernel+bounces-366143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3BA99F156
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 17:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F19F32822D8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 15:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D8A1DD0D8;
	Tue, 15 Oct 2024 15:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="kK96T0r8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QsDLUsDZ"
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8A71DD0C1
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 15:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729006505; cv=none; b=QM4kUUGFXb8GNGnzOy1CWm/75qafg4ut5oG4dWS1eiuQb4ldlztyI3+980wkh5pvaFjPOvi0G8UgjY63eekuHdTdFholE+S02vGcPGDr7pdZUCSOrSBLNtgiyHVowB8aN3q2uFiLS1cyq/VAUTenKSmi3aDwGmKiw31xZU1k4Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729006505; c=relaxed/simple;
	bh=w7+VlNy+mcjqqc7N+f8jrxpCCG5BLgYLo1iOtySe8Kg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=e4zW4GoqXqcrsocB3vxLH6H/QF3VYdCo4K+qTCSwP5l2P1nenoySpubRPqSimkBW6T4RG20X/nYArV58VedRsKS9Id+qi58Mo2BoKd83hhE80ayM6ubDpymXDmHy4xqLL+a2cqG7u7LZ/USw9Ii8FtUSKkNbx0z6jzDnaAUhyjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=kK96T0r8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QsDLUsDZ; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 98CA31380211;
	Tue, 15 Oct 2024 11:35:01 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Tue, 15 Oct 2024 11:35:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1729006501;
	 x=1729092901; bh=4HXXXPsyaxavdVR1EisJ5bQc5ynj0wcNlMTAGsD4Pzs=; b=
	kK96T0r8kqYicTw4W6qvfBT+cYlWKFhwrCTSGpYLAFeFZ4xgj/odr878U0jZhJQL
	v8PhAirirnS7LSvhGjUfp+310XH1MuSPE8RdsnkTAVXo/xTRLBTtHPhlS/3QZ64B
	kkeky0owSOoZ5jfAU/mTrRs2NMr3YIBRROmBrvkNFNUd7CiHRTp3PTvz/KwBMyYe
	YQSYj5L0FEeZuPJclczW1y9S4I7Uh0oqTqtXGgnhwvsLQM7WJDhZzWl4HPHAPurM
	RHyNcVI1CSlopi0gO8hqA5+Iyd2M/bN2xIJOXu8aFCWRX9zB7kCY9eaanLK8dx2K
	tBgvrOSunpQmC/E5j6UKOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1729006501; x=
	1729092901; bh=4HXXXPsyaxavdVR1EisJ5bQc5ynj0wcNlMTAGsD4Pzs=; b=Q
	sDLUsDZ/1dZcyBaMtC7CzfyWnMI5JW4UhI2ExqdkFsFMRf+jzJE2o59l71C/B/qq
	PGTVbtIGSwG9czYbDUxBi/fj9ilHQWt8Oh3tX5ma7mQccM+cAWRCDhG2GGzkp5ay
	bGWGAw0ObUY6duqy8w7W4mnhGSHwCxHZVj7lyLbSQjMdOgm39AEpg4hxRQMysHWS
	H86rUVd1pvaK5cZDcki7BpUIJ5t1+l76GBMMmB56+E1L1WF2r4qNZPxibqi5IJ8C
	1U+0qi6+PahsUuuNqK0nibEMLUTm6DJcxWsPG8uCJQFsdudzRyYWrCtqJhbcXPCV
	vp6eWKm/E9s6dRhLAoRag==
X-ME-Sender: <xms:pYsOZ74lvLtGr8eX9g6L2YUAKtVeSmf0mydMIbCOY_xPAPziZAjlXA>
    <xme:pYsOZw7iItAymH8EGDPGR-cT5TNNnD83_tUBHBeDpZTci62UW58EnyqrCejY3HZIZ
    LlT5znIbDU5m6sPQis>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegjedgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefg
    gfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepudef
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsihhmohhnrgesfhhffihllhdrtg
    hhpdhrtghpthhtoheprghirhhlihgvugesghhmrghilhdrtghomhdprhgtphhtthhopegu
    shgrnhhkohhushhkihesghhmrghilhdrtghomhdprhgtphhtthhopehruhgrnhhjihhnjh
    hivgeshhhurgifvghirdgtohhmpdhrtghpthhtoheprghrnhgusehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehmrhhiphgrrhgusehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    gumhhithhrhidrsggrrhihshhhkhhovheslhhinhgrrhhordhorhhgpdhrtghpthhtohep
    nhgvihhlrdgrrhhmshhtrhhonhhgsehlihhnrghrohdrohhrghdprhgtphhtthhopehmrg
    grrhhtvghnrdhlrghnkhhhohhrshhtsehlihhnuhigrdhinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:pYsOZycsO3ZPxkZi2C2FwqGgcVPjgDDwF94nyLs4VbwdOOTFh5VQUQ>
    <xmx:pYsOZ8JCtEsR14EiSLGYaiYXp5rrab0NFh3zfD8WSL9AufKn-AfLTg>
    <xmx:pYsOZ_J81jJSUQdO8yQZByfnEDJYJoW_4UWNshb6Tc4YbhMZe-ocfw>
    <xmx:pYsOZ1w7k-VOU39qI6ny1j2wjYfv9bcaNbyF3F6Ok8S4BRzymPT0Xg>
    <xmx:pYsOZ5DQZb_4JJ6OenA6-Xntac46Eii2WHJYO-0aKyoSNcfU-87a_ZfW>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E3CAF2220071; Tue, 15 Oct 2024 11:35:00 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 15 Oct 2024 15:34:33 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Ruan Jinjie" <ruanjinjie@huawei.com>, "Arnd Bergmann" <arnd@kernel.org>,
 "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "Dave Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>, "Dzmitry Sankouski" <dsankouski@gmail.com>
Cc: "Jessica Zhang" <quic_jesszhan@quicinc.com>,
 "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Message-Id: <b0b7a36e-0327-4ee0-ac03-7aef6b4f4e87@app.fastmail.com>
In-Reply-To: <d32b15fa-3b4b-d0ef-ade3-dda44e4abc4d@huawei.com>
References: <20241015073115.4128727-1-arnd@kernel.org>
 <d32b15fa-3b4b-d0ef-ade3-dda44e4abc4d@huawei.com>
Subject: Re: [PATCH] drm/panel: s6e3ha8: select CONFIG_DRM_DISPLAY_DSC_HELPER
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Oct 15, 2024, at 07:52, Jinjie Ruan wrote:
> On 2024/10/15 15:30, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> The new driver needs the dsc helper code to be available:
>> 
>> x86_64-linux-ld: vmlinux.o: in function `s6e3ha8_amb577px01_wqhd_prepare':
>> panel-samsung-s6e3ha8.c:(.text+0x16b1e65): undefined reference to `drm_dsc_pps_payload_pack'
>> 
>> Select it from Kconfig as we do for other similar drivers.
>> 
>> Fixes: 779679d3c164 ("drm/panel: Add support for S6E3HA8 panel driver")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>  drivers/gpu/drm/panel/Kconfig | 1 +
>>  1 file changed, 1 insertion(+)
>> 
>> diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
>> index ddfaa99ea9dd..ffe7eff71496 100644
>> --- a/drivers/gpu/drm/panel/Kconfig
>> +++ b/drivers/gpu/drm/panel/Kconfig
>> @@ -626,6 +626,7 @@ config DRM_PANEL_SAMSUNG_AMS639RQ08
>>  config DRM_PANEL_SAMSUNG_S6E88A0_AMS452EF01
>>  	tristate "Samsung AMS452EF01 panel with S6E88A0 DSI video mode controller"
>>  	depends on OF
>> +	select DRM_DISPLAY_DSC_HELPER
>
> It seems that it uses DRM_DISPLAY_DP_HELPER in mainline but use
> DRM_DISPLAY_DSC_HELPER in next.
>

I think I made a mistake during rebasing and ended up having
the 'select' under the wrong Kconfig symbol.

The new driver DRM_PANEL_SAMSUNG_S6E3HA8 was only added in
linux-next and does not exist in mainline yet.

Sending a new version now.

      Arnd

