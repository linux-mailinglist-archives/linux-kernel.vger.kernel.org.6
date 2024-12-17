Return-Path: <linux-kernel+bounces-448732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D74F09F44C6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 08:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D603188C876
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 07:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C72F1DA61D;
	Tue, 17 Dec 2024 07:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="PjJPyk4i"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A0B171E49
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 07:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734419151; cv=none; b=c6SDgAto2EXoEuPEVtChvrDiSF7wpUgz+HTFp4ghypZAuUQfIMsakZ96laj/A0mkHGawZinFbczrizvKQS1qdcZbvFWAXwM3TFioZG7TUKC4DVKpTS9i2pcPWlOU0Y3kSeXb/2OuYZv37cH9ly7KkSa8uqE2FvZhel98zonkpeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734419151; c=relaxed/simple;
	bh=zX2cFtcHCICYnLmShbz9S1nIR8E0jVMXhZVDQSSl+do=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qjPS+i+u1/hf+nTOTdBsuWwtsY+w3A2P6DkRRWFw6H1or2g1q6fkUbUP2OQrvP5Pcw5vsM8tHSBms7MtQVQJIvzlaeepNOm7Mg8sRfPnUSBLAX6Wr6qh+mUPdpfpfRd4fwHtOui3H3+d5wd4NAFOm2iLGrfmQVtnr1dvTFWNDlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=PjJPyk4i; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding; s=k1; bh=cv19Q1wJnDXa6l
	jWtXODVtaNwf0ZT2uRVQhVVv4kjrM=; b=PjJPyk4i9ytfFJBcSfUNF6Lvzf7ewX
	CuZoDS9t6xM/dPQmfDlDvhuTwvYsw7lL/Ynnt4HuroTfEVAAUZeNOHSkEDIX7Dyk
	DJ82/NtKDg0wT8PUSQqCfuYgn8NgjLMn58T+k1hA5X5HS9Mw4VyoOKh3U6YNYOkr
	HBCesVfAa6O9Ad5E0F3sheG0P3UCYNjKe8vB4dLdwkF/ptmiZRDG15sDOOAvPNBu
	PbU+Ex9EkUFqpTTDP3S7BDT+5tKR1Z5It0rk7jKUKKcKPoqh59yfCZtfhYO/pviS
	o4v17/0rVbXy0QXU+/2jUqQbmXD66Pe9ViGNoL+/TRpga3pBqXz1jgAQ==
Received: (qmail 3977869 invoked from network); 17 Dec 2024 08:05:46 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 17 Dec 2024 08:05:46 +0100
X-UD-Smtp-Session: l3s3148p1@THof7XEp3oJehhtS
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com
Subject: [PATCH] ASoC: cs42l43: don't include '<linux/find.h>' directly
Date: Tue, 17 Dec 2024 08:05:45 +0100
Message-ID: <20241217070545.2533-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The header clearly states that it does not want to be included directly,
only via '<linux/bitmap.h>'. Replace the include accordingly.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 sound/soc/codecs/cs42l43.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs42l43.c b/sound/soc/codecs/cs42l43.c
index 4236f78beec0..bee032c3ebbe 100644
--- a/sound/soc/codecs/cs42l43.c
+++ b/sound/soc/codecs/cs42l43.c
@@ -12,7 +12,7 @@
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/errno.h>
-#include <linux/find.h>
+#include <linux/bitmap.h>
 #include <linux/gcd.h>
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
-- 
2.45.2


