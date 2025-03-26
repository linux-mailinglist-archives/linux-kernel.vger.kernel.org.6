Return-Path: <linux-kernel+bounces-576553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64675A710F3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 08:02:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19120188A2F6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 07:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D66A1946AA;
	Wed, 26 Mar 2025 07:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="J2IKZvBp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HikZFqdC"
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C7D155316
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 07:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742972520; cv=none; b=gf2y5plR3ZUfxu7M3vNfnA8wOyi8fTtM6jbbgxEUy2pev/CqwRLptR8+JFHR4eB7v+bSjKfqRJP9MPe38CjjX3JO+StdGG3ehK9Mfmi/6grqMNiQS3NyOMks92X1jkWONwbf0AofkcraZ6ZIDHJXaZqbo8V5iS+btUTwVfQWbo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742972520; c=relaxed/simple;
	bh=kbfn5AxD6Ehm0QJCn9Njt6hlzD6AjlNkNsiSSAUueQc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RpqPQrJAfweptlIzoXC62O1ueIeECU+AadKNCcnjbXbj9DY7q2StObof72yQTq1nMTEvQWmQg0wXsJO7dr06U+OQyIO4EOciYlxxBzUgxU+nRqqOkRmilcEROQ0k0GHfdvExAUZFNvwIhaZGBJ4+mGyT2e9GAq3Bn8uatCm4gO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=J2IKZvBp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HikZFqdC; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 93D351140137;
	Wed, 26 Mar 2025 03:01:57 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Wed, 26 Mar 2025 03:01:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1742972517; x=1743058917; bh=S6n1PFsC1w5DEottY+AwJ
	eJag53HyiRO+q5bkxFofLY=; b=J2IKZvBp6WoCuSf+Enj1G4HWsyNAexnVcN/G+
	0lp1e79REc9ggHYcHtkm7Yt2cdFIXn3OPOglRgmwX1QgeDcHx46G8KJW7VgYb6cf
	FTj8KnNd0fWCPSOVxYNMwPlsvsFNIZG+nIMPxwgdpTpCsZRmBK9yBXwgFjccRWZ5
	LjKxP7JdgnuKcDEkIP3qPstle6g75sXt24SE1PUlbeqDmVJ0x0ibBeG6oqn1Avkk
	RxpsUg0V8NbeXx3xHB9TdmyABLrHwS8YD0+zD9745NT4mAboZhk199DkewBXc93j
	g80qMYztjn9b3stN2iacVq0K7MQPyLF58RQv63rlWiS9JcQHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1742972517; x=1743058917; bh=S6n1PFsC1w5DEottY+AwJeJag53HyiRO+q5
	bkxFofLY=; b=HikZFqdCQkVrfylr12dgbQ2WTcsjuKjaJa5FyEmXT0wdVXfxKRA
	lPp4txpNprnnrr4s0yk7AZe+YAOF5s9wbgpmDywyIiVNHi/n/Q8IOlReXlJN13lP
	0sl/3y6lc7AMKy/eLIAiG9OAJu7vnTB/QyPjXabuek9DXE8XdZ5wVCM4CINXramI
	oKzxiQKUneB7S5xfIQFK7KQB/fZhJJ939lpzfVrCKN/QQaX6nxShAd8JwagBCAiS
	OQMIjuD4aD1aeh3i4YYOY9h11p7OANsR34lEzEd9gr7kRqTbOcit5Z7o8IHX0aJV
	0QZI6mxuWoyZ6HM59faSAn6xDDbpLmTDmrQ==
X-ME-Sender: <xms:ZKbjZxY0fe4sN8gYyrP8q8p6raVgKgxsHgI4Cydmmfk5yxj8shVbGA>
    <xme:ZKbjZ4YNWWgb_BorMIat-fJEOfUPopoIcIGop_sN9Eft07gOq95DhnteXl9EB0u-2
    Pe3FEbcRxrByaINzeY>
X-ME-Received: <xmr:ZKbjZz9--RII037CM1GABfIXmXb0DDjcAAwRpHR9SYHQGwz07smOqd2DUJBDVQIgJnlE3WZzoImTZlNYUvf3rTlPM9wfF9yjUcK9299GJC8bvO3m>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieegkeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeflrghmvghsucfhlhhofigvrhhs
    uceosgholhgurdiiohhnvgdvfeejfeesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpefhvefgkeeiuddtudfhgefgiedvuefhhedtffejtddtfeekieefieejveet
    hfegheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhlugdriihonhgvvdefjeefsehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthht
    ohepudehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehhrghrrhihrdifvghnth
    hlrghnugesrghmugdrtghomhdprhgtphhtthhopehsuhhnphgvnhhgrdhlihesrghmugdr
    tghomhdprhgtphhtthhopehsihhquhgvihhrrgesihhgrghlihgrrdgtohhmpdhrtghpth
    htoheprghlvgigrghnuggvrhdruggvuhgthhgvrhesrghmugdrtghomhdprhgtphhtthho
    pegthhhrihhsthhirghnrdhkohgvnhhighesrghmugdrtghomhdprhgtphhtthhopegrih
    hrlhhivggusehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhimhhonhgrsehffhiflhhl
    rdgthhdprhgtphhtthhopegruhhrrggsihhnughordhpihhllhgrihesrghmugdrtghomh
    dprhgtphhtthhopegrlhgvgidrhhhunhhgsegrmhgurdgtohhm
X-ME-Proxy: <xmx:ZKbjZ_rGnoREY8PfpwEgVG0VmuD6B4WRPWPRNm7UquJhy6FkvH09gw>
    <xmx:ZKbjZ8oYG5WQNPFFAommQaMW7ZrXJciXBBLre_fUM0UpMb8Ow7Tj2Q>
    <xmx:ZKbjZ1Sm7VvTxzgF6xPX4xSt5QQtmqq0-6xVHwx0TSfcMew5Kx0Q8g>
    <xmx:ZKbjZ0rbrEfZvo_9sYl0PyyHI2jvklYp1YZMnpgNK2WMrImCnXt0qQ>
    <xmx:ZabjZ4a3pZHLl8x8CSh0Mzcv5ww2ntLzwGpSnBrU9ZkUXlCAU8R1Itiy>
Feedback-ID: ibd7e4881:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Mar 2025 03:01:54 -0400 (EDT)
From: James Flowers <bold.zone2373@fastmail.com>
To: harry.wentland@amd.com,
	sunpeng.li@amd.com,
	siqueira@igalia.com,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	aurabindo.pillai@amd.com,
	alex.hung@amd.com,
	skhan@linuxfoundation.org
Cc: James Flowers <bold.zone2373@fastmail.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/display: replace use of msleep(<20) with usleep_range for better accuracy
Date: Wed, 26 Mar 2025 00:00:10 -0700
Message-ID: <20250326070054.68355-1-bold.zone2373@fastmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

msleep < 20ms will often sleep for ~20ms (according to Documentation/timers/timers-howto.rst).

Signed-off-by: James Flowers <bold.zone2373@fastmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 2cd35392e2da..2d225735602b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -682,7 +682,7 @@ static bool execute_synaptics_rc_command(struct drm_dp_aux *aux,
 		if (rc_cmd == cmd)
 			// active is 0
 			break;
-		msleep(10);
+		usleep_range(10000, 10200);
 	}
 
 	// read rc result
-- 
2.49.0


