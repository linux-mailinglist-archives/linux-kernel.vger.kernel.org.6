Return-Path: <linux-kernel+bounces-564319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E38ADA6529E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 15:16:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E729171577
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 14:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D158424110F;
	Mon, 17 Mar 2025 14:16:04 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8D51DFCB;
	Mon, 17 Mar 2025 14:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742220964; cv=none; b=NiLQGgDBeECz0z7I6xwjSmsg+WrQGoh302r/HS34wY9kCzEcwM7qtit7jRr24EOiW/WGz/vEieGFSu/AN1F+p3gzzp0bQSMSHtBxUmgmQaINl+IocR0Kp3HwFuxqUjx7LbnQUrxWFKYFUGBVZJk8/ZsJUICE0RrlsJwiudR9YUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742220964; c=relaxed/simple;
	bh=AldV/hJHv/I1W5buCOvwpWiW3xaNj5/BwKZ/rUXUNZk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hAQesG1Xftc4zZXNmsLMDYCNQW7fiVMIJCacuAYOXwGTXpbrxYUtVVrrAMoPbaemk7pC53Z/KSeWl1VMTPzpMdbU2clIEiAio1p3bKhqBARK89BkzIUeIQsd71lTgrro099ile5hoXP/ujexOIwuc5vWBhLzKPDmBcSfXOtGDD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [124.16.141.245])
	by APP-01 (Coremail) with SMTP id qwCowADn7dH+LNhnDJr5FQ--.11818S2;
	Mon, 17 Mar 2025 22:09:07 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Cc: u.kleine-koenig@baylibre.com,
	patches@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>
Subject: [PATCH] ASoC: Add initialization for wm8997 component
Date: Mon, 17 Mar 2025 22:08:44 +0800
Message-ID: <20250317140845.702-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowADn7dH+LNhnDJr5FQ--.11818S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtF4fZry7Jr48Cw45Aw48Crg_yoW3twc_Ca
	1rW3yUZFy3KrZavrW2q3y5K3WkZayxCa1jk3WvqFy5JF47Ja1fJryDJry3uryDW3y0ka45
	ZF9F9r4jyrWIkjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbckFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
	1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
	cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8Jw
	ACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_Jw0_
	GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
	42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUqeHgUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBg0EA2fYDpVwXwAAsH

In wm8997_component_probe(), wm8997 should be initialized by
arizona_init_gpio(). A proper implementation can be found in
'wm8998_component_probe()' where the wm8998 component is
initialized with arizona_init_gpio().

Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 sound/soc/codecs/wm8997.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/wm8997.c b/sound/soc/codecs/wm8997.c
index 5389c363b14e..ef8e09cc7211 100644
--- a/sound/soc/codecs/wm8997.c
+++ b/sound/soc/codecs/wm8997.c
@@ -1066,6 +1066,8 @@ static int wm8997_component_probe(struct snd_soc_component *component)
 	if (ret < 0)
 		return ret;
 
+	arizona_init_gpio(component);
+
 	snd_soc_component_disable_pin(component, "HAPTICS");
 
 	priv->core.arizona->dapm = dapm;
-- 
2.42.0.windows.2


