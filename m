Return-Path: <linux-kernel+bounces-401763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0379C1ED8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 15:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C50C22830CF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 14:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68EFE1F4267;
	Fri,  8 Nov 2024 14:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="C2X7nxlj"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0523E1F12EF
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 14:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731074894; cv=none; b=XHgRRXyH1TgWeI663ibRHtNRLcffC0HN5WNChbARjT9lY0C2ZLGoKVhb767OXKg2ZINxEq9JWThBQeemW3urky9puqWJ8z6ZvgAqQOBc/MVny13wGkkiFqP0+H1ar5qUH1XP8HvVP2MQl+7FYbpXBaX8+4KxftihIjTRnz0Pda8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731074894; c=relaxed/simple;
	bh=8V0KRtLgpNSHZKC6FrTejyUm3s2LWtEqb4RmRc56BII=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gG7ShG22vi/9sbRvTStAKXf9vcO+pgzth0pyFoLxSx8I5dvFOx/qFe3W8l5hs8cFQ13PwKc3aEC5tr/KR71qEvkwlNOk+3VR+fLKcJCb5UYJE+1rgWDQgKjtrJ7UESx6wi3mNl4KK7wIZj1OhXqS76a9SgVKeS3dH+0Pm259838=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=C2X7nxlj; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-157-155-49.elisa-laajakaista.fi [91.157.155.49])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id D75A03E;
	Fri,  8 Nov 2024 15:08:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1731074881;
	bh=8V0KRtLgpNSHZKC6FrTejyUm3s2LWtEqb4RmRc56BII=;
	h=From:Date:Subject:To:Cc:From;
	b=C2X7nxljSohkumoOoMBrkpjB93IBgZUoHjpb2HZy4B8/KFXIAF2thAIgB3QoTz+7W
	 fGwloc9jsIyBQqRBmsJnRpMQsPlklv9+gLsGL6XllitlnRTI2L/xhyHEe2qcxWAQMS
	 B2k26joBgBDHE2JU+alpB0MahGprZaIGJpAILgoY=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Fri, 08 Nov 2024 16:07:37 +0200
Subject: [PATCH] regmap: provide regmap_assign_bits()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241108-assign-bits-v1-1-382790562d99@ideasonboard.com>
X-B4-Tracking: v=1; b=H4sIACgbLmcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDQwML3cTi4sz0PN2kzJJiXQuj1ORkSwuzRPMUUyWgjoKi1LTMCrBp0bG
 1tQB7j6r+XQAAAA==
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Andy Shevchenko <andy.shevchenko@gmail.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Bartosz Golaszewski <brgl@bgdev.pl>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4193;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=gDoOGlVBthln/1GrO4ZHDIVwRWVIteTb+2RSN4uO9NM=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBnLhtGIQbLHblNZWR9tpLxcOBTrMH3MyuXXkKuO
 dQK9Zuh+mGJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZy4bRgAKCRD6PaqMvJYe
 9XxkD/44aJQndtQY9zA975iedBs0aMwemLIqT6WYEhD2yiFm/PXeLDjoaAvefS5k1jCYncHderB
 JNlgCI8qqBJHUEXkypjRGQxGMWG370H9rBoEzBVjzuOUtc+ZbllkMqvcYGehkjzGPy6YWap9dFe
 QERzXTWSvbaXasQbD+nzM6D7VjCYJUNHNo7GAT+1ZjOvhDrRcBt5t9S8lpWdHpGQ6D4jpCA8A3A
 t/88cODh2Fk3l3ypjCre3pG8EGcrF4mjFYXrveIL9BGcF7P5oN8NRYkREsTXwo0valIrSZaHBTc
 7QDs2/BfOJCwmGTEj91nCIcOZUlXnNH5MB6nuneS19QPORsJlHYi4irLqj9A4gmm9+E2Mq0MhtX
 3dGvMC3xGpPGDMLxsRpxWizdHUbuMtqiBvk269YJ0wghodTMZf1Be2eBQyETGz99qz4x0sZNzEs
 6Uab/yRhiBmylVr7twnH/OKA/yjc3jT8NzT5X90HxPN5bFpytSS7TmNvCSzFU8UrgARs4rPdvJp
 Om3PwDlvO5TmwEcjuDschaLQCdBzqi7wgHeUWCcB4O/zh+Ol6q5sWiuNWfSXqL9iW/YHHjehTl9
 Je165z5o7E3JJUc9juiavZ0jDqtHQyvr5g9ZQf+YvfnGyrdX/5S0fb3RQDWywrigsGxQQ/H+e/R
 Lnz8PQCz7TNRhIg==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

From: Bartosz Golaszewski <brgl@bgdev.pl>

Add another bits helper to regmap API: this one sets given bits if value
is true and clears them if it's false.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
The patch to add regmap_assign_bits() was sent some years back, but not
applied:

https://lore.kernel.org/all/20201104193051.32236-2-brgl@bgdev.pl/

I still feel it would be useful.So, here it's again, this time with a
semantic patch (for discussion, not to be applied).

Running this semantic patch:

@@
expression RMAP, REG, MASK, VAL;
@@

(
-regmap_update_bits(RMAP, REG, MASK, VAL ? MASK : 0)
+regmap_assign_bits(RMAP, REG, MASK, VAL)
|
-regmap_update_bits(RMAP, REG, MASK, VAL ? 0: MASK)
+regmap_assign_bits(RMAP, REG, MASK, !VAL)
)

with:

spatch --no-show-diff --in-place --sp-file assign-bits.cocci --dir drivers/

gives:

$ git status|grep modified|wc -l
130

With some cursory look, many of them are of the pattern:

regmap_update_bits(data->regmap, SI514_REG_CONTROL,
		   SI514_CONTROL_OE,
		   enable ? SI514_CONTROL_OE : 0);

which are then turned into:

regmap_assign_bits(data->regmap, SI514_REG_CONTROL,
		   SI514_CONTROL_OE, enable);

I, at least, find the regmap_assign_bits() more readable and
understandable. Here the mask name is relatively short, but I often name
mask macros as something like "{DEV}_{REG}_{FIELD}", which results in
specific but rather long names. And the "enable" variable is often in
some state struct. So for the sake of discussion, let's lenghten the
names a bit:

regmap_update_bits(data->regmap, SI514_SOME_CONTROL_REG,
		   SI514_SOME_CONTROL_REG_ENABLE_FOOBARING,
		   priv->enable_foobaring ?
			SI514_SOME_CONTROL_REG_ENABLE_FOOBARING : 0);

would turn into:

regmap_assign_bits(data->regmap, SI514_SOME_CONTROL_REG,
		   SI514_SOME_CONTROL_REG_ENABLE_FOOBARING,
		   priv->enable_foobaring);

The above could also be done with:

if (enable)
	regmap_set_bits(data->regmap, SI514_REG_CONTROL,
			SI514_CONTROL_OE);
else
	regmap_clear_bits(data->regmap, SI514_REG_CONTROL,
			  SI514_CONTROL_OE);

This pattern is also used, but I only found 7 files with a quick
semantic patch. And I like the regmap_assign_bits() better: the
operation is an assignment to certain bits, so it's a single operation,
not an if/else situation.

I was also thinking about naming the function as "regmap_toggle_bits",
but maybe "toggle" is similar to "invert", which is not really the case
here.

Another option would be to make it regmap_assign_bit(), and allow only a
single-bit mask. But I'm not sure if that really helps any, although I
would guess that majority of the cases where regmap_assign_bits() can be
used deal with a single bit.
---
 include/linux/regmap.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index f9ccad32fc5c..239659919203 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -1328,6 +1328,15 @@ static inline int regmap_clear_bits(struct regmap *map,
 	return regmap_update_bits_base(map, reg, bits, 0, NULL, false, false);
 }
 
+static inline int regmap_assign_bits(struct regmap *map, unsigned int reg,
+				     unsigned int bits, bool value)
+{
+	if (value)
+		return regmap_set_bits(map, reg, bits);
+	else
+		return regmap_clear_bits(map, reg, bits);
+}
+
 int regmap_test_bits(struct regmap *map, unsigned int reg, unsigned int bits);
 
 /**
@@ -1796,6 +1805,13 @@ static inline int regmap_clear_bits(struct regmap *map,
 	return -EINVAL;
 }
 
+static inline int regmap_assign_bits(struct regmap *map, unsigned int reg,
+				     unsigned int bits, bool value)
+{
+	WARN_ONCE(1, "regmap API is disabled");
+	return -EINVAL;
+}
+
 static inline int regmap_test_bits(struct regmap *map,
 				   unsigned int reg, unsigned int bits)
 {

---
base-commit: 42f7652d3eb527d03665b09edac47f85fb600924
change-id: 20241108-assign-bits-82ecc986a7d5

Best regards,
-- 
Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>


