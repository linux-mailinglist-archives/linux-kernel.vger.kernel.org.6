Return-Path: <linux-kernel+bounces-542706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B32A4CCB2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 21:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 587353A88BE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 20:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A69230BF4;
	Mon,  3 Mar 2025 20:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RpVzr0s5"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00231236450;
	Mon,  3 Mar 2025 20:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741033681; cv=none; b=E0QnxZeOeyTTVulk3Vp6yX8sQSYfJhEr81ngTcD5vuWT13s+ONBraQcGqgzHAlZQsqPbmaCVMrWhtBdKQ/rdI+dJwcuoK5Yv0lGQ2gGqcJFKHkfMVS04aEBthkMsqQUEKpJYZ5bDPiqFwMxljwVPD8r0kBFNWIGdEz7padKqe8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741033681; c=relaxed/simple;
	bh=MTjjumplLIdg/n+qAO5fFv6tHfrmUwLPV/PXYF40D9Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YJQ8Q7ovh2geBcnHXd73k2uWMKA2QCGdclnpqMBjlH15kc8VTYugs1ml4OVUp5C/lBxzR/hydI2mTO5xHmIBQi56GMJqf6c2KPqQG159nEVahiqFVyPekTMHd5ks9HOw7ndwxxkiHYduURTgaILc5T6XDqTeqOuLW82XD2bC9O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RpVzr0s5; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-abf628d653eso316439666b.0;
        Mon, 03 Mar 2025 12:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741033677; x=1741638477; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1yb+xEL+q27amZtPIsZaxUWluTF2p0Q/I5Y0+qwCRdo=;
        b=RpVzr0s5Q9NKAqIRFekZ3tTY6gnLsflhwRhvuhPZKAzPwTL2Ay8s4sgXr3k0o9f4WT
         Q4WkETiD36BHF5XRNI5ewdwF9wMKoWach9/c4a3OilXoD/d+jABnPtyxz/H0IXZYaZrH
         +U4O8xiXZMGIHv1Gpk7z2MFiB3dS5KFMuI6XB7Snr0Xk0pm1zb5S1QJEb8Dzrnht38yd
         mSt32pwouqL/otctecV9EM9a6+sMH7y/5bAxzubgIoIEAg+xE/JGIvZj4Jlr4b9ytL2i
         KHbo3bbynzs4JNZXkF69JasWuUcy1NFTf55zJaqiHTjWGTZJaRZ2lMyUCWIdRPoqf8ZQ
         /X8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741033677; x=1741638477;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1yb+xEL+q27amZtPIsZaxUWluTF2p0Q/I5Y0+qwCRdo=;
        b=PoUT+/+XBzPkP8Kk/2wLh9xFCoFTWcRFNSXc72FDop5jl7kFYECdtxxDSPxqhU8yU5
         1llt20pQwXxesq6CzICy9g0otQZ/i0M4iwd59IlD+0Wy0LlceuhzhdwVj+n8tYUPD6aH
         Ux4f51Y4c+DA9fBfK51vrWHmUzVDSHkXx/BrS6+wxnEHOKMYfvHXE+0Q7fee0sz8JqXJ
         VJDPIlbIMEsOXMj4HRQD0oFiWGUhbfft6LkjQc0pwW0iRnRDsnoa71AM3BW6K92itFNn
         lY+9/nuNMeFgZTPndfTYw6PM1bQUO7XYLiTPPJ5jiNtsT9g6chZVUEh8FPnh27zryqKA
         LqIA==
X-Forwarded-Encrypted: i=1; AJvYcCUVwTkCvxUqJHwKSGmDJy19c9xcxxuCtLYUH7HMwMv2Pw5fQPpxtEO6Q7cxSeDRniCw/5xU/3fj6Ry+@vger.kernel.org, AJvYcCXRSl7ZXdT/jxStKRC5E4OQNBCP5lOFC8QhMzii+fYtfULMK+86UXZ/ZpDyjfZJUEz1EJlFtSgM5l5ro4Wf@vger.kernel.org, AJvYcCXmjKkLBYk0eMfBiOFLV6tarqFj/k9JO0FXaFGN+Eybz09xVg0FloA0G2cVAUhYe9F4vwlfTEAf4+Ip@vger.kernel.org
X-Gm-Message-State: AOJu0YwBSxhj2wUYvgvEtHX9O4e88hrcwzdfaG5h3Yp8ZttlXzeEaKSL
	VZ8F6pcFSF8JL/VR3tQ0mr/f4mMYtitJb9huWJmllPGOv7XExzXr
X-Gm-Gg: ASbGnctcT9x4L09lRd9/u65kmw4fNyil1G2z8K6B3GO5qRcV7jjQYtrZTOR1SV1j+IS
	iF/aJ+jFbXWnSHNSHYH01t4g+yBo5AKSFX9Ef3kH/lBK5KlGQNR62JfiuxSuN7ungCVJfVMloNd
	O1cAHvOtzMEObPnjJC3w5ur2aoXqnQL+gqwzRuoagY9ROgE39XYVvP2LPLrS7gesqBlU9xuawQK
	z41yh03ypVWMB77k4akPdo4XO6lVjfOBPMqZtc/MK8bvlkEIXIa8H7WUAzAthW0vXz7nrcS4d8H
	qonge0I5yK18U81oFrlNw2TfdTViBQYH4+HVm5Z2NrOjzIa6GoWTijEkcL27FiLVO4kcedYnn6c
	EetmeBfQM4l9eVOQ=
X-Google-Smtp-Source: AGHT+IHXcKJXj9PLSX5sOOI36dUKMg9+GSHF+EMWesnaSEGLlCKPGH1xw9l4dd54eI57N4zeOFYgNw==
X-Received: by 2002:a17:907:2d13:b0:abf:514a:946a with SMTP id a640c23a62f3a-abf514b0faemr1217686466b.28.1741033677073;
        Mon, 03 Mar 2025 12:27:57 -0800 (PST)
Received: from hex.my.domain (83.8.122.142.ipv4.supernova.orange.pl. [83.8.122.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf64dd565dsm389222166b.101.2025.03.03.12.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 12:27:56 -0800 (PST)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Mon, 03 Mar 2025 21:27:51 +0100
Subject: [PATCH v2 3/7] clk: bcm: kona: Add support for bus clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-kona-bus-clock-v2-3-a363c6a6b798@gmail.com>
References: <20250303-kona-bus-clock-v2-0-a363c6a6b798@gmail.com>
In-Reply-To: <20250303-kona-bus-clock-v2-0-a363c6a6b798@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Alex Elder <elder@kernel.org>, 
 Stanislav Jakubek <stano.jakubek@gmail.com>, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 Artur Weber <aweber.kernel@gmail.com>, Alex Elder <elder@riscstar.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741033670; l=8577;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=MTjjumplLIdg/n+qAO5fFv6tHfrmUwLPV/PXYF40D9Q=;
 b=mOukQ5ktsiyNIoe8Q4yVAPLzKgssdqyfxiKEG+FtDdInCSstlxfQCf3Q0SofYS23VMcmFfAJw
 UWTrAHUhjWOAMiE8f8AWhhPEXnlEbNuDyKmak1J9mXEdaxCB7kSRw4w
X-Developer-Key: i=aweber.kernel@gmail.com; a=ed25519;
 pk=RhDBfWbJEHqDibXbhNEBAnc9FMkyznGxX/hwfhL8bv8=

Introduce support for bus clocks into the Broadcom Kona common clock
driver. Most of these functions have been adapted from their peripheral
clock counterparts, as they are nearly identical (bus clocks are just
much more limited in terms of allowed operations).

Reviewed-by: Alex Elder <elder@riscstar.com>
Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
 drivers/clk/bcm/clk-kona-setup.c | 116 +++++++++++++++++++++++++++++++++++++++
 drivers/clk/bcm/clk-kona.c       |  62 ++++++++++++++++++++-
 drivers/clk/bcm/clk-kona.h       |  10 ++++
 3 files changed, 187 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/bcm/clk-kona-setup.c b/drivers/clk/bcm/clk-kona-setup.c
index 338558f6fbaec27418497fc246de17e15236ca0d..8b6123e188fbc035cda2cf394035d35197671d06 100644
--- a/drivers/clk/bcm/clk-kona-setup.c
+++ b/drivers/clk/bcm/clk-kona-setup.c
@@ -167,6 +167,58 @@ static bool peri_clk_data_offsets_valid(struct kona_clk *bcm_clk)
 	return true;
 }
 
+static bool bus_clk_data_offsets_valid(struct kona_clk *bcm_clk)
+{
+	struct bus_clk_data *bus;
+	struct bcm_clk_policy *policy;
+	struct bcm_clk_gate *gate;
+	struct bcm_clk_hyst *hyst;
+	const char *name;
+	u32 range;
+	u32 limit;
+
+	BUG_ON(bcm_clk->type != bcm_clk_bus);
+	bus = bcm_clk->u.bus;
+	name = bcm_clk->init_data.name;
+	range = bcm_clk->ccu->range;
+
+	limit = range - sizeof(u32);
+	limit = round_down(limit, sizeof(u32));
+
+	policy = &bus->policy;
+	if (policy_exists(policy)) {
+		if (policy->offset > limit) {
+			pr_err("%s: bad policy offset for %s (%u > %u)\n",
+				__func__, name, policy->offset, limit);
+			return false;
+		}
+	}
+
+	gate = &bus->gate;
+	hyst = &bus->hyst;
+	if (gate_exists(gate)) {
+		if (gate->offset > limit) {
+			pr_err("%s: bad gate offset for %s (%u > %u)\n",
+				__func__, name, gate->offset, limit);
+			return false;
+		}
+
+		if (hyst_exists(hyst)) {
+			if (hyst->offset > limit) {
+				pr_err("%s: bad hysteresis offset for %s "
+					"(%u > %u)\n", __func__,
+					name, hyst->offset, limit);
+				return false;
+			}
+		}
+	} else if (hyst_exists(hyst)) {
+		pr_err("%s: hysteresis but no gate for %s\n", __func__, name);
+		return false;
+	}
+
+	return true;
+}
+
 /* A bit position must be less than the number of bits in a 32-bit register. */
 static bool bit_posn_valid(u32 bit_posn, const char *field_name,
 			const char *clock_name)
@@ -481,9 +533,46 @@ peri_clk_data_valid(struct kona_clk *bcm_clk)
 	return kona_dividers_valid(bcm_clk);
 }
 
+/* Determine whether the set of bus clock registers are valid. */
+static bool
+bus_clk_data_valid(struct kona_clk *bcm_clk)
+{
+	struct bus_clk_data *bus;
+	struct bcm_clk_policy *policy;
+	struct bcm_clk_gate *gate;
+	struct bcm_clk_hyst *hyst;
+	const char *name;
+
+	BUG_ON(bcm_clk->type != bcm_clk_bus);
+
+	if (!bus_clk_data_offsets_valid(bcm_clk))
+		return false;
+
+	bus = bcm_clk->u.bus;
+	name = bcm_clk->init_data.name;
+
+	policy = &bus->policy;
+	if (policy_exists(policy) && !policy_valid(policy, name))
+		return false;
+
+	gate = &bus->gate;
+	if (gate_exists(gate) && !gate_valid(gate, "gate", name))
+		return false;
+
+	hyst = &bus->hyst;
+	if (hyst_exists(hyst) && !hyst_valid(hyst, name))
+		return false;
+
+	return true;
+}
+
 static bool kona_clk_valid(struct kona_clk *bcm_clk)
 {
 	switch (bcm_clk->type) {
+	case bcm_clk_bus:
+		if (!bus_clk_data_valid(bcm_clk))
+			return false;
+		break;
 	case bcm_clk_peri:
 		if (!peri_clk_data_valid(bcm_clk))
 			return false;
@@ -656,6 +745,14 @@ static void peri_clk_teardown(struct peri_clk_data *data,
 	clk_sel_teardown(&data->sel, init_data);
 }
 
+static void bus_clk_teardown(struct bus_clk_data *data,
+				struct clk_init_data *init_data)
+{
+	init_data->num_parents = 0;
+	kfree(init_data->parent_names);
+	init_data->parent_names = NULL;
+}
+
 /*
  * Caller is responsible for freeing the parent_names[] and
  * parent_sel[] arrays in the peripheral clock's "data" structure
@@ -670,9 +767,23 @@ peri_clk_setup(struct peri_clk_data *data, struct clk_init_data *init_data)
 	return clk_sel_setup(data->clocks, &data->sel, init_data);
 }
 
+static int
+bus_clk_setup(struct bus_clk_data *data, struct clk_init_data *init_data)
+{
+	init_data->flags = CLK_IGNORE_UNUSED;
+
+	init_data->parent_names = NULL;
+	init_data->num_parents = 0;
+
+	return 0;
+}
+
 static void bcm_clk_teardown(struct kona_clk *bcm_clk)
 {
 	switch (bcm_clk->type) {
+	case bcm_clk_bus:
+		bus_clk_teardown(bcm_clk->u.data, &bcm_clk->init_data);
+		break;
 	case bcm_clk_peri:
 		peri_clk_teardown(bcm_clk->u.data, &bcm_clk->init_data);
 		break;
@@ -702,6 +813,11 @@ static int kona_clk_setup(struct kona_clk *bcm_clk)
 	struct clk_init_data *init_data = &bcm_clk->init_data;
 
 	switch (bcm_clk->type) {
+	case bcm_clk_bus:
+		ret = bus_clk_setup(bcm_clk->u.data, init_data);
+		if (ret)
+			return ret;
+		break;
 	case bcm_clk_peri:
 		ret = peri_clk_setup(bcm_clk->u.data, init_data);
 		if (ret)
diff --git a/drivers/clk/bcm/clk-kona.c b/drivers/clk/bcm/clk-kona.c
index ec5749e301ba82933144f34acfaf6f3680c443f7..e92d57f3bbb147e72221802175a80502897d7504 100644
--- a/drivers/clk/bcm/clk-kona.c
+++ b/drivers/clk/bcm/clk-kona.c
@@ -961,7 +961,7 @@ static int selector_write(struct ccu_data *ccu, struct bcm_clk_gate *gate,
 	return ret;
 }
 
-/* Clock operations */
+/* Peripheral clock operations */
 
 static int kona_peri_clk_enable(struct clk_hw *hw)
 {
@@ -1233,9 +1233,69 @@ static bool __peri_clk_init(struct kona_clk *bcm_clk)
 	return true;
 }
 
+/* Bus clock operations */
+
+static int kona_bus_clk_enable(struct clk_hw *hw)
+{
+	struct kona_clk *bcm_clk = to_kona_clk(hw);
+	struct bcm_clk_gate *gate = &bcm_clk->u.bus->gate;
+
+	return clk_gate(bcm_clk->ccu, bcm_clk->init_data.name, gate, true);
+}
+
+static void kona_bus_clk_disable(struct clk_hw *hw)
+{
+	struct kona_clk *bcm_clk = to_kona_clk(hw);
+	struct bcm_clk_gate *gate = &bcm_clk->u.bus->gate;
+
+	(void)clk_gate(bcm_clk->ccu, bcm_clk->init_data.name, gate, false);
+}
+
+static int kona_bus_clk_is_enabled(struct clk_hw *hw)
+{
+	struct kona_clk *bcm_clk = to_kona_clk(hw);
+	struct bcm_clk_gate *gate = &bcm_clk->u.bus->gate;
+
+	return is_clk_gate_enabled(bcm_clk->ccu, gate) ? 1 : 0;
+}
+
+struct clk_ops kona_bus_clk_ops = {
+	.enable = kona_bus_clk_enable,
+	.disable = kona_bus_clk_disable,
+	.is_enabled = kona_bus_clk_is_enabled,
+};
+
+/* Put a bus clock into its initial state */
+static bool __bus_clk_init(struct kona_clk *bcm_clk)
+{
+	struct ccu_data *ccu = bcm_clk->ccu;
+	struct bus_clk_data *bus = bcm_clk->u.bus;
+	const char *name = bcm_clk->init_data.name;
+
+	BUG_ON(bcm_clk->type != bcm_clk_bus);
+
+	if (!policy_init(ccu, &bus->policy)) {
+		pr_err("%s: error initializing policy for %s\n",
+			__func__, name);
+		return false;
+	}
+	if (!gate_init(ccu, &bus->gate)) {
+		pr_err("%s: error initializing gate for %s\n", __func__, name);
+		return false;
+	}
+	if (!hyst_init(ccu, &bus->hyst)) {
+		pr_err("%s: error initializing hyst for %s\n", __func__, name);
+		return false;
+	}
+
+	return true;
+}
+
 static bool __kona_clk_init(struct kona_clk *bcm_clk)
 {
 	switch (bcm_clk->type) {
+	case bcm_clk_bus:
+		return __bus_clk_init(bcm_clk);
 	case bcm_clk_peri:
 		return __peri_clk_init(bcm_clk);
 	default:
diff --git a/drivers/clk/bcm/clk-kona.h b/drivers/clk/bcm/clk-kona.h
index e09655024ac2ad42538b924f304b23e87b7db2ce..a5b3d8bdb54eaee9fad80c28796170207b817dfd 100644
--- a/drivers/clk/bcm/clk-kona.h
+++ b/drivers/clk/bcm/clk-kona.h
@@ -390,6 +390,14 @@ struct peri_clk_data {
 	struct bcm_clk_sel sel;
 	const char *clocks[];	/* must be last; use CLOCKS() to declare */
 };
+
+struct bus_clk_data {
+	struct bcm_clk_policy policy;
+	struct bcm_clk_gate gate;
+	struct bcm_clk_hyst hyst;
+	const char *clocks[];	/* must be last; use CLOCKS() to declare */
+};
+
 #define CLOCKS(...)	{ __VA_ARGS__, NULL, }
 #define NO_CLOCKS	{ NULL, }	/* Must use of no parent clocks */
 
@@ -401,6 +409,7 @@ struct kona_clk {
 	union {
 		void *data;
 		struct peri_clk_data *peri;
+		struct bus_clk_data *bus;
 	} u;
 };
 #define to_kona_clk(_hw) \
@@ -488,6 +497,7 @@ struct ccu_data {
 /* Exported globals */
 
 extern struct clk_ops kona_peri_clk_ops;
+extern struct clk_ops kona_bus_clk_ops;
 
 /* Externally visible functions */
 

-- 
2.48.1


