Return-Path: <linux-kernel+bounces-405897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A16499C58A6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 14:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 318C4281DDE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 13:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71F6433C0;
	Tue, 12 Nov 2024 13:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BE5zfsKU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E76B139D1B;
	Tue, 12 Nov 2024 13:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731416998; cv=none; b=imOp1U1uTPW1zc5vWcLs5+Dlw5fbCBg4MwSpUyxhSW1fX80NZjNKVLOa0TGAlJo2oWv6S6FfoyM9kPzkkfes+6RTrYxhxhTDgY8x+wLD1z6m2djB3rD7OMCi8OmXjFf1eViftgHo0ldaItK6E+QZb6cFswlD43bjoWU+88gK7iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731416998; c=relaxed/simple;
	bh=ZOR976k4viMscvaHHP1VDvAEW/nPievAM4xObeUGsa8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=sD7vPStasVGc5gE7LI4AA/FGj3RIEaaPW+/P/f5F2KQLFdhEcF3WOlefNWS/kFrz/TeOlynh1rI8EWb1uiFrYVnTnwl5E1NoU56AMK3cQAHmh822oTSW9vh94Cqid28U93K8Xm37XTWAOf4eQH6lueQEe9ZzeEkOdWdxiTTshBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BE5zfsKU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49D6BC4CECD;
	Tue, 12 Nov 2024 13:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731416997;
	bh=ZOR976k4viMscvaHHP1VDvAEW/nPievAM4xObeUGsa8=;
	h=From:Date:Subject:To:Cc:From;
	b=BE5zfsKUWJJheftZvRaRfz6tFIXzgM4kSbF3nzYAYCOEIrFNpott7i2of6NWWEQQH
	 TWpweHCf28ufd4JU82/w58GbR714FxakaXAsj4K+5A12glYbqCTYfkUVtkd5hZkjGW
	 cIpmh4RxS++6VXB71AmY8h0yrgCMtnuuKfHd1rrSK7Ud1COSiJbnsNBxnhTulSnBN8
	 XAAqyjJ9MQS5Yhe5QNm1aRgnUaxEMwMmucp6IVjLCpam/sId6LFOcpy8ol5HSi7Nmu
	 1zteMZAlCcdZGYYQff95nQVWAvcOP5IVzkc5Bkb87V5O25Pm/i5mrINdixnhFpj3ls
	 q5ToaE1dQVRqA==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 12 Nov 2024 13:09:50 +0000
Subject: [PATCH] ASoC: max9768: Fix event generation for playback mute
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241112-asoc-max9768-event-v1-1-ba5d50599787@kernel.org>
X-B4-Tracking: v=1; b=H4sIAJ1TM2cC/x2MQQqAIBAAvxJ7biGl0vpKdNDaag9ZaIgg/T1pb
 nOYyRDIMwUYqwyeIge+XBFRV7Acxu2EvBYH2chWFNCEa8HTpEH1GimSe7DRnW1XaW0nFJTw9rR
 x+qfT/L4fTmKMdGQAAAA=
X-Change-ID: 20241111-asoc-max9768-event-085b4d2bb517
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1409; i=broonie@kernel.org;
 h=from:subject:message-id; bh=ZOR976k4viMscvaHHP1VDvAEW/nPievAM4xObeUGsa8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnM1Oj/iyjLp42K6FwkAMtLtI88dujvscwd2q8W
 SOwMPTSaaGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZzNTowAKCRAk1otyXVSH
 0B5rB/9HgMF1OAq7y41eUySmIuGus3hX6rW/ohRlXijs8I1co/qEIObCFKzyq0MptDCdNYz57zT
 5qXoAQ0lRBgoU0AdIEpRo9DgG5twicyt4Ih8vFHMduDZR3Q1mcwhzhL20w6d6bzDvZIdMvVGECK
 wLqdr6amN+L9RxbtVTkSECjPG+8S7FgujLn0oGsTuXWCtpIKlt+4d+IL1kuSH098UWItyPCBXnq
 N7OMCB/D3v4WzDHOGrAXel/3FUdOVEBo/raCv5m6Q5cdA+EmWbxxpBAYF5qWig/B91F02Yijlso
 MMhmpt8yeejIs9E33QpcxIrvcbhSuEQBCQbRK0JQ8Iz5CZ6s
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The max9768 has a custom control for playback mute which unconditionally
returns 0 from the put() operation, rather than returning 1 on change to
ensure notifications are generated to userspace. Check to see if the value
has changed and return appropriately.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max9768.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/max9768.c b/sound/soc/codecs/max9768.c
index e4793a5d179efced38c8f04de5e49f4cf67a17a1..8af3c7e5317fbb0c47baa40b90f8799b9b3d3e8a 100644
--- a/sound/soc/codecs/max9768.c
+++ b/sound/soc/codecs/max9768.c
@@ -54,10 +54,17 @@ static int max9768_set_gpio(struct snd_kcontrol *kcontrol,
 {
 	struct snd_soc_component *c = snd_soc_kcontrol_component(kcontrol);
 	struct max9768 *max9768 = snd_soc_component_get_drvdata(c);
+	bool val = !ucontrol->value.integer.value[0];
+	int ret;
 
-	gpiod_set_value_cansleep(max9768->mute, !ucontrol->value.integer.value[0]);
+	if (val != gpiod_get_value_cansleep(max9768->mute))
+		ret = 1;
+	else
+		ret = 0;
 
-	return 0;
+	gpiod_set_value_cansleep(max9768->mute, val);
+
+	return ret;
 }
 
 static const DECLARE_TLV_DB_RANGE(volume_tlv,

---
base-commit: 8e929cb546ee42c9a61d24fae60605e9e3192354
change-id: 20241111-asoc-max9768-event-085b4d2bb517

Best regards,
-- 
Mark Brown <broonie@kernel.org>


