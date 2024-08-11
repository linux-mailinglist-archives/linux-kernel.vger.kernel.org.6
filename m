Return-Path: <linux-kernel+bounces-282188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E8E94E0A2
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 11:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99DC428170C
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 09:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2D12E405;
	Sun, 11 Aug 2024 09:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b="McIv2Bc6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wc33fUPK"
Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DF635280
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 09:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723368025; cv=none; b=M5dA+wAXcjYR8vgACxulXbQwfOYtLO6rBnhO9/Su1Za0s8Q09NoTp3436kfgg2Ab6Zr/PM99bFUszRNvSnCh6vnwrhkshv6DT5QYX4NZrnmIqw5immxlIy3ugyO3K4LKGEOcBcg9dLhUySOmdFA2hym5m2WtLm2Ww/sPJUA3DGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723368025; c=relaxed/simple;
	bh=HzDUWlcEZ+AI9AML5gtK1iEZNE5PjJE5maicXLoLqUs=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Ot9cX7BBfIUXmTRsfnqf4Ek8RoAxF/Esg35PEN2gEBgyZVEaBQxPd+ZqrYtNID3EDUDhzX0XwTYj/mpJAlbyhtI58m+l5mLm2Qytv8A0hL8P4E09oksFnUlyPoaLDdsaKixXQPdFQbkn8lGLqZ6T/I8yT4Fw0IdbS9h8o5xhAds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev; spf=none smtp.mailfrom=ljones.dev; dkim=pass (2048-bit key) header.d=ljones.dev header.i=@ljones.dev header.b=McIv2Bc6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Wc33fUPK; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ljones.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ljones.dev
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id 95736138CC6A;
	Sun, 11 Aug 2024 05:20:21 -0400 (EDT)
Received: from imap41 ([10.202.2.91])
  by compute3.internal (MEProxy); Sun, 11 Aug 2024 05:20:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1723368021;
	 x=1723454421; bh=5rbfEqURGiF9jlW7xiee/gg1cziT13qgtmb8s8ZIskI=; b=
	McIv2Bc6A+lcrkOnigv3JSiu/agexrOXbzv2IU8Lq/Lga/Q61VG1I0I7Z/BnnIjK
	F9iRQ2jVv7mulY7Z4IAs7tetaV27dQmnFRv3AR9hTDVOsvtI+Yjf9YBPW9NLDdPp
	fGzikrDbz9YErCTVR9oDBgJDJSUtcd3mXWbsgVuEsKd8mYXNLLiKkNaQLNkwjGA2
	pRGx9Ibr/mFgHvSGXfKCZCoscxcLe1lCF814mQy7IsYereY7A8W+vjep1sO1j6KB
	xVUPI0XLTxCra7vSmjROM89n59S3AT8TnUWqnNbVLEHVzq/pYJVUw23TVaKwTXD7
	j59u+OuD7ZMYBzsRg59InA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1723368021; x=
	1723454421; bh=5rbfEqURGiF9jlW7xiee/gg1cziT13qgtmb8s8ZIskI=; b=W
	c33fUPKT086vfQwh/CnHNcq4XP8r3OzNQ3sElcAm/QBu/e39yqa4qLr19RFFA4Gb
	S8OplPP1rt2p/ZnBcizC4RX9pnx1C41+aJu1s6pC06/MaGffV2RaYxfS2A2BHm1t
	KMVGtGP9AcZP7filzW4L61Vg6i2mjDxsMqnj7Hynoj++7G1BSV9PsPfaMtIHuvaR
	dYMJ8XPyAU6cgeozqAv8o6+I8pP9ANImWKUJVgEEgOTFZHoy176BkOHreHlS5nAj
	xOrFwsCEqpOON+wm/VI3hLuS0JFLAf877CMan5cpvnQB9iuH0y2eKKRbf6+AQdtp
	BGr3jppRTJ3CyG7EotLVg==
X-ME-Sender: <xms:VIK4Zm6i60rpN5e1_DFKI9uDs_1l7-R1fHYANo4N6Umdkp9DWbJodQ>
    <xme:VIK4Zv4YoQM8exqJpKO4ogqTFgrrtiZY-iF3VfY6qPh1PuXmU-K-fGV35UL8twn6z
    p5HkA6qw5fHbMjWhd0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrleekgdduiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredttden
    ucfhrhhomhepfdfnuhhkvgculfhonhgvshdfuceolhhukhgvsehljhhonhgvshdruggvvh
    eqnecuggftrfgrthhtvghrnhepgfeiffehtdfghfettdeiuddtfeekvdejgfevhefhffev
    tdfhjeelgeefffekvdevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvhdpnhgspghrtghpthhtohepledp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrnhhivghlsehffhiflhhlrdgthh
    dprhgtphhtthhopegrihhrlhhivggusehgmhgrihhlrdgtohhmpdhrtghpthhtohepsgho
    uhhkvghhrggrrhhsmhgrvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhhrihhprg
    hrugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrrghrthgvnhdrlhgrnhhkhhho
    rhhstheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopegurhhiqdguvghvvg
    hlsehlihhsthhsrdhfrhgvvgguvghskhhtohhprdhorhhgpdhrtghpthhtohephhguvghg
    ohgvuggvsehrvgguhhgrthdrtghomhdprhgtphhtthhopehtiihimhhmvghrmhgrnhhnse
    hsuhhsvgdruggvpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgv
    rhhnvghlrdhorhhg
X-ME-Proxy: <xmx:VIK4ZlcwlI3Z-3saHAL3TAXfCdGUpOdk1i2FzsAEpJzZBx-tRtUSkA>
    <xmx:VIK4ZjIrnrI2HtGCjgSl_CMxGrWSBTh6pENLQ4l1RndcMupHfvgijw>
    <xmx:VIK4ZqIUg5JcYpQ3Z4fQpQ3LWdIertKRPsCUEROOyTwV-tU66q2NDQ>
    <xmx:VIK4ZkzxlygI3g5eInQoJHkV33Lx3PsRyEiuQyD0gIZ-MKh7P402Fg>
    <xmx:VYK4ZrremrMpv_rXJcg1FHJc4o4iZn2-vtpvOOKtzWleSMq9Uo-BBym4>
Feedback-ID: i5ec1447f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id A87522340081; Sun, 11 Aug 2024 05:20:20 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 11 Aug 2024 21:20:00 +1200
From: "Luke Jones" <luke@ljones.dev>
To: "Bouke Sybren Haarsma" <boukehaarsma23@gmail.com>,
 maarten.lankhorst@linux.intel.com, "Hans de Goede" <hdegoede@redhat.com>
Cc: mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Message-Id: <ac41ed9d-59c6-406e-805d-4a272a90a626@app.fastmail.com>
In-Reply-To: <20240728124731.168452-3-boukehaarsma23@gmail.com>
References: <20240728124731.168452-1-boukehaarsma23@gmail.com>
 <20240728124731.168452-3-boukehaarsma23@gmail.com>
Subject: Re: [PATCH RESEND 2/2] drm: panel-orientation-quirks: Add quirk for Ayn Loki
 Max
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 29 Jul 2024, at 12:47 AM, Bouke Sybren Haarsma wrote:
> Add quirk orientation for Ayn Loki Max model.
> 
> This has been tested by JELOS team that uses their
> own patched kernel for a while now and confirmed by
> users in the ChimeraOS discord servers.
> 
> Signed-off-by: Bouke Sybren Haarsma <boukehaarsma23@gmail.com>
> ---
> drivers/gpu/drm/drm_panel_orientation_quirks.c | 6 ++++++
> 1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
> index a1dfeaae644d..0830cae9a4d0 100644
> --- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
> +++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
> @@ -208,6 +208,12 @@ static const struct dmi_system_id orientation_data[] = {
>   DMI_MATCH(DMI_BOARD_NAME, "KUN"),
> },
> .driver_data = (void *)&lcd1600x2560_rightside_up,
> + }, {    /* AYN Loki Max */
> + .matches = {
> + DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ayn"),
> + DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Loki Max"),
> + },
> + .driver_data = (void *)&lcd1080x1920_leftside_up,
> }, { /* AYN Loki Zero */
> .matches = {
> DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ayn"),
> -- 
> 2.45.2

Hi All, are we able to get some movement on this? Although many folks who rely on this are able to keep patching it would be wonderful for others to not have to worry about it.

Cheers,
Luke.

