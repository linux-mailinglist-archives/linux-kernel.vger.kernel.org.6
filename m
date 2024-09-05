Return-Path: <linux-kernel+bounces-317137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E72696D9DC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 15:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C66471F22FD6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 13:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C694919B5BE;
	Thu,  5 Sep 2024 13:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="ClwoRogj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g4/XoqNW"
Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE7219923F
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 13:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725541837; cv=none; b=JOuryrbfE7VlCIprwh3yntqeMp6QEJEGyugf/0voj7kvm9qxvgkBIbMsXvtwC068saptXy58pOHnHbLbtFIFeVoSQquedLG0XR28BulNeCfZKRXxQcTQmiAQW6xAjt30y6df4Z8jWsjMq0tJ001bXvKkl/CIG9XLqvnIW6+iq1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725541837; c=relaxed/simple;
	bh=ZEsEGjEskPAf0X1wkClscPyQ1zk3d7SqAGW84VjkDr0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fPWPbzW3S4GIONmvm3sDejpbOdytETcjXdvYPpoaJm6/kL3CePvCSXDrxfXHO4gP7YOklLj7pMfiVhkIJLP4VnrJFyK6XTcaXIhBTho5S3MSvkwFjD3l+ZhQxwqxvgtOFvqilcPIBJ/6dKDglyo17uZ9Zq4a3ka+hS10vW8DyCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=ClwoRogj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g4/XoqNW; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 648241140273;
	Thu,  5 Sep 2024 09:10:34 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 05 Sep 2024 09:10:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1725541834; x=1725628234; bh=mECBbq8SLa
	UTywVVUUZTVtpP3ufj6mxHVK9noi6AziY=; b=ClwoRogjF6MhifPzTJuH6QRObr
	pVZRgyFEDvmxdeCgRvS430y5nkwSb/0dmAi3+10QQ+i1kjBTSMoTVZKSvue28cLa
	xHLISwr4MmskNZWPbH5uo2gfBCi9w/SzJIF+dfFtEn6l6DSLgNXJXBzcaTu6msNf
	szhxvhxxcpzxa0iiZvWwKX2fnMEql4mjUpDxF6GkvBD1dE37Z1xW6KdzSdVWJOPA
	pmUvWRsLztFwN7/dfa4VE6Th9DzNJ/ya4ES1rIjfqf+tKV9tXp3zLSLkvoKuhLdE
	I++hMCGoYArV/dY/FupYouExujEZWSduHa4BNhbsvamTuqiKTuYO85r341WQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725541834; x=1725628234; bh=mECBbq8SLaUTywVVUUZTVtpP3ufj
	6mxHVK9noi6AziY=; b=g4/XoqNWetmRsYwaQPURTTf9stoOuQLU98AE5eZzfXvR
	yv0gpmE5HIhMk05mD8j3iX8VgPaDdtunxyuRNXnJC1RaMdcMw9EkKhrmxCbngtBD
	aDIQ+HC9vpX5yl5A7RbXTI5AmxyTgIz5RoY7e/XIjY/2RGX6kyalZLAPBuFKsplX
	lmA02ZhognxHe3ZEwIv7UC+mzcHSlyi7uti3ebTtQnBRcnSIomqqUizyVqmkZNyr
	mDSADiYzLovI0tWm2/ztU/3oMCZ7PVGt0Xjphv0RscczbPfpilbCM58O7TFzzON6
	er2wzT1yH0C6iSmLm8cxSmYLtAE9G26JtnMtWm5CIw==
X-ME-Sender: <xms:yq3ZZt2-SL7e6mBTz6xiQl6cjgzxRsHveceP_lUmKw3matVw0277PA>
    <xme:yq3ZZkHuJUJqeR7JP7PwInbPxvjo6W2iuTRDJ-4gw265p2mPE1F8jhocNA6FVR5vX
    H21GSqCTRW5b1h_nHM>
X-ME-Received: <xmr:yq3ZZt4vgTcWa6iB_0vYemk0buDBFwO2daKSvPtEg2PM2XnkRvv4BxSZCZp9abB8wOEZZQBFThydVqh2SuQ_S8vNDyVUWJ-GcvKwRhwlVd2w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehledgieduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefufffkofgggfestdekredtredttdenucfh
    rhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhhihesshgrkh
    grmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepffdvueelffevkeduhfetjedu
    ffeghfettdfguedtgfdvgfeufeduheevheevkeeknecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggt
    hhhirdhjphdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htoheplhhinhhugidufeelgedquggvvhgvlheslhhishhtshdrshhouhhrtggvfhhorhhg
    vgdrnhgvthdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehtihifrghisehsuhhsvgdruggv
X-ME-Proxy: <xmx:yq3ZZq1Bjpw5RBC46rK_Rmoc8UbnsGxBSEt5cY_uL9UwPT1N9IKMxg>
    <xmx:yq3ZZgEpU0Vyb13z1kafJlIVWpS8-DH-vsOID9fc8ECO9SsX0ce2Sw>
    <xmx:yq3ZZr_3EWegdmX4t7zyfqBTnNpBYm4ZXR5rNvrsfDzloa1Rh68xGQ>
    <xmx:yq3ZZtmn7X_h4t_MkYA7KGCuzwqeBI1aruBfq-Jf1FVRzkt4FsQJUQ>
    <xmx:yq3ZZkD2c8cIDDT-irj8z8T9g7J2Z_mBZeXlxBpOUDNkn5j_buI7CsWO>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Sep 2024 09:10:32 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] firewire: core: use WARN_ON_ONCE() to avoid superfluous dumps
Date: Thu,  5 Sep 2024 22:10:29 +0900
Message-ID: <20240905131029.6433-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is enough to notify programming mistakes to programmers just once.

Suggested-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-iso.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firewire/core-iso.c b/drivers/firewire/core-iso.c
index af76fa1823f1..a249974a0f87 100644
--- a/drivers/firewire/core-iso.c
+++ b/drivers/firewire/core-iso.c
@@ -220,7 +220,7 @@ int fw_iso_context_flush_completions(struct fw_iso_context *ctx)
 	might_sleep();
 
 	// Avoid dead lock due to programming mistake.
-	if (WARN_ON(current_work() == &ctx->work))
+	if (WARN_ON_ONCE(current_work() == &ctx->work))
 		return 0;
 
 	disable_work_sync(&ctx->work);
@@ -244,7 +244,7 @@ int fw_iso_context_stop(struct fw_iso_context *ctx)
 	might_sleep();
 
 	// Avoid dead lock due to programming mistake.
-	if (WARN_ON(current_work() == &ctx->work))
+	if (WARN_ON_ONCE(current_work() == &ctx->work))
 		return 0;
 
 	err = ctx->card->driver->stop_iso(ctx);
-- 
2.43.0


