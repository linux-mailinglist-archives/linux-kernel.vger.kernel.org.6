Return-Path: <linux-kernel+bounces-337393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B22984976
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 18:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1761C28697D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 16:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514161AB6E4;
	Tue, 24 Sep 2024 16:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FPL/5qe9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF0F1AB52B;
	Tue, 24 Sep 2024 16:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727194892; cv=none; b=M0AlOtphvxeqFAdQHGSwwlI3p3Jwssln53akRZSlksLN4yQTYMueZdMiKiqPF1oTHZIbI6NzX3clSo+0GFX9etXOuRFAptladJW1Q+pcxD4jM5/xpSBMzMtkbaAVhXVDw3UagyAiky2knfH7w1lyn2dyVlDcaOp52lfNJfE4B38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727194892; c=relaxed/simple;
	bh=If0Kg6028VLRNv0YcjegQIYXdDdeeFDQJjbLyBQtNv4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=decQ5RWOBbKLcFenrVXSu4QLhBWc7DENy3DFh2rjqf4eqs3vsuotJW5yM6iVdQPrRhoChMSTGULVl2d30Dms+NoShf3XZT1Zr0oYR2rsQhqqhbRGslqD3yKuZEPcPfrMgvRiEOJAemYqb3Lyqw+S4KeUOWUPVNlh4TQO5MilG70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FPL/5qe9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7821C4CEC4;
	Tue, 24 Sep 2024 16:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727194891;
	bh=If0Kg6028VLRNv0YcjegQIYXdDdeeFDQJjbLyBQtNv4=;
	h=From:Date:Subject:To:Cc:From;
	b=FPL/5qe9yfxBfuWln86yGmJQ0RBSqpevOB4HRphE79osPHYHhG6fWCHa/d4tk8ktS
	 b6t7OEKylKl8N0MrKEYUS+0mbm7+vPjWP5Ah9nlnAJftZtbzpCG9zHgQlfIK9AncV1
	 4Yv66gCfVbSHTBMtXisYPbz2ItC0BS38WZ8v7rMrBIemjLf5lildXDHjAeG3AcDyi/
	 s5FsrDkW/NoD26HN9ngNSNsWb3uXh3yi8isj67tcCFlMBwjjDJ6DqnLHwJXehvx4E5
	 XSkN8Oatgqlgc6bNzNTR17hRgbpQeEytKy1L75WwIB6S3+0+Wp89Vxeff7wp6e9rOj
	 e68ESGyqlndIg==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 24 Sep 2024 18:21:20 +0200
Subject: [PATCH] ASoC: bcm2835-i2s: Use maple tree register cache
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240924-asoc-bcm-maple-v1-1-9d221f4a0195@kernel.org>
X-B4-Tracking: v=1; b=H4sIAP/m8mYC/x3MQQqAIBBA0avErBuwQYm6SrQwm2ogNRQikO6et
 HyL/wtkTsIZxqZA4luyxFDRtQ24w4adUdZqIEVaDaTR5uhwcR69vU7GnozRw7YSGQc1uhJv8vz
 DaX7fD9NKHnVgAAAA
To: Liam Girdwood <lgirdwood@gmail.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>
Cc: linux-sound@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=openpgp-sha256; l=1131; i=broonie@kernel.org;
 h=from:subject:message-id; bh=If0Kg6028VLRNv0YcjegQIYXdDdeeFDQJjbLyBQtNv4=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBm8ucGkMM3ILmWqBXTjwuLXWQnmk53z4VoIM657
 +t11fdVWwCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZvLnBgAKCRAk1otyXVSH
 0IgGB/9iRb/oHGo21YvJq4gv8qWPHdpRBoJPUM7OREpVlKGSrCETZqoZfKxMGlwhJIg/ci1reUD
 /gUFqmLEoJajsT+3hUCLzsbHn4w4zM0wIdZ2jwXsofF6I3ASQnTbi7VkHfcVrf3C+EzsUlHchr3
 eNZOcJ+SKaQEltTZrZINZIcDgXo5gDKSf6rXO2WugieWZww1IzzbB07+hAOrNuoNlZEvYsjF7qv
 uVSb06DO+U1sPRPhX0gWP+PzDY0y1+judfQ/2fG/+OHS9uBae5ghL7m2yx7oy/wG9ojKA5deNEr
 eBXSyUjRWX/jy7VArxiXY5R/h45IdgYxxEECQ/Q2l02aMKDp
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The bcm2835 I2S driver uses a rbtree register cache but has no clear need
to do so. Since the maple tree cache uses a more modern data structure and
makes implementation decisions more suitable for current systems switch the
driver to use that instead. No functional changes.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/bcm/bcm2835-i2s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/bcm/bcm2835-i2s.c b/sound/soc/bcm/bcm2835-i2s.c
index 9bda6499e66e..87d2f06c2f53 100644
--- a/sound/soc/bcm/bcm2835-i2s.c
+++ b/sound/soc/bcm/bcm2835-i2s.c
@@ -817,7 +817,7 @@ static const struct regmap_config bcm2835_regmap_config = {
 	.max_register = BCM2835_I2S_GRAY_REG,
 	.precious_reg = bcm2835_i2s_precious_reg,
 	.volatile_reg = bcm2835_i2s_volatile_reg,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 };
 
 static const struct snd_soc_component_driver bcm2835_i2s_component = {

---
base-commit: 98f7e32f20d28ec452afb208f9cffc08448a2652
change-id: 20240924-asoc-bcm-maple-725549fd225c

Best regards,
-- 
Mark Brown <broonie@kernel.org>


