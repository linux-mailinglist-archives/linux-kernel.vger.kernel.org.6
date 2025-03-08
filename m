Return-Path: <linux-kernel+bounces-552359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 553EAA57902
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 08:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A198518988C9
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 07:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E10F19C57C;
	Sat,  8 Mar 2025 07:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lPzEDsEC"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE2A1ACEBE;
	Sat,  8 Mar 2025 07:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741420255; cv=none; b=Tm/Sxyv+Vf9ZUL/VsJdzPcbs+nB11bF9J/x0Zq+wh7cVL1mBQrV43HLEfCLTcS0QEcoZFIOk/QM5om4i3vdYVDES0yCppnQK7Y5YJlpVjw8KWSZCGDTweNVKfLOFibkCOh58nDvAS3fUXS1QltIKIrwlls9yZz/GsUPRxR3SPRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741420255; c=relaxed/simple;
	bh=MTjjumplLIdg/n+qAO5fFv6tHfrmUwLPV/PXYF40D9Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NwXfZbDj9dvvjMvdqvT+R6AilNUVKF6YRt8njgm8hbr4jLz8mr21m6SaNW7tpMzj9th+NeSDezJEP4BReOoBQsWJYaobmb1WxMJTeE77uqwrniI/+JR5l2bvp7KEMpLddQaJeuUop2C+HjLiGf/e/h9/7/dXGgdCfD7AQW3163M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lPzEDsEC; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-abf4802b242so466618366b.1;
        Fri, 07 Mar 2025 23:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741420252; x=1742025052; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1yb+xEL+q27amZtPIsZaxUWluTF2p0Q/I5Y0+qwCRdo=;
        b=lPzEDsEC1DR8vwt25lqf+CVXkNB6fofDMQv0N/KSwOnv0BcX4/xFkhYq9WuMVR2UhV
         /4zxZhH4hUTPWoIvd75tMTgk9RHaMFnXwVY7TXKduK/p4vVscirrrY8c3pULy3FCrCl6
         SNfbrCO8ccTocQKEsLtLESd5+AlKw0ewDeHsmDrXviD7aEOOajSMe/L9Md7G6eCqPNDu
         rMuulkhiogwYR1CVqwdDJm0a+dSo2GPJ6QFBYzpLcDqTkTi7yeKuyl0elJLRL4wOA7cu
         7Y85jClRAxS+LeNpe/Lh89vG9o8gSzx5Je/Bq+dVa5Un5x3eNiCrfNnu2iZk+bNSWwrA
         acXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741420252; x=1742025052;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1yb+xEL+q27amZtPIsZaxUWluTF2p0Q/I5Y0+qwCRdo=;
        b=bOts7+kPlLNBZH8jFussX08iNvAOgyBpW/uRfCsTvfehjYsyoXtomqXJ/hbQAJuhXb
         pfPpOBgeH9fLuAuRlH0nE7GXHuTKOsmAJxXh9TtMaGoq33LJjyCd042DBtzTv2g+LjfJ
         OujS3SGarGe1f1epLL0Hm3aHrxACbj3KHdTzcyXAP8g/wxa+qzzEffwBuckTqe//ri1s
         sl/wqoBd4Y2tBP+0JdacqtGekaWM5D0S3JrDLeFIG0o3eceMRFtlbppChRter5jx2dQj
         exWv4sV9q2B1ar0/9h6lIucFCFeDleOS5C26/Uu1ugifihVFfeQR/B180F8DiHcgB80K
         JEJw==
X-Forwarded-Encrypted: i=1; AJvYcCVdT5suXhjqY4cafKRQFUQFhpErRTX/hlSfqu5jR7VQYvj4V9cVcg/BTC4VncOFtBi2tIRH5ky4V6hu@vger.kernel.org, AJvYcCVdmfEBAuHcGO76aVSasC8TrBNAtJdVjtTw0VWdFleVVITZGq7MssvSbNI3QWG2Z3nCuG/CRpBwT00sjbi1@vger.kernel.org, AJvYcCXxcF1BziMKaMIEpVwc11+xBD9UBDcmOKgM433NS0lXAYdfOy2ICKPtbbixI1GNLBSoQLtiB6S74TXe@vger.kernel.org
X-Gm-Message-State: AOJu0YwFuW4sv2lDDB+94gOj3vUUqCS8fnqh1P97cOX3Q6iIxuvUGbQc
	lrUgyIoI1TvJ+vaZsDF2noKC0rh7c6K8TKYpCR6rzEp3l53jqq+Y
X-Gm-Gg: ASbGnct3mTBn7fRgXQdVACWvhBsjIm6y3uH3/IZeRl4GGHh/JjFcMXBsyJa56ARqo1C
	YbPfZPFUdV+oRv1qNCvJGE3QqRNomFDuE/OiYPjQNscVEJvphGwaQK341QMHjnVwhw9hebsX7xJ
	r5arPjlKyz6eMmTy0EaYOda8w0MH4SsM8YoHnUUJJ9Fh/gGjYMNYU4if/PguneAKDyso5dFlu/7
	jxs+YbpHwVd67RAhpNoBZrb0T694EoNqt+6cOOJgPFS6+WBV2nfsmBZIGtbMjQ10cCJ99TGq999
	ICdBicrr92XQMSznGi7A/aYDlYa0K00vqB0usv2FbqwjiD9vPqY+X7X3LtjolFGLdOL4w/2/HLZ
	LgHasFC1dR6BA/5Ic+A==
X-Google-Smtp-Source: AGHT+IHMfCShJ44BPPOmdXR5sgE3GK3o5kDdW+Mt6KivNeNhft3B5lgcURTuLPom+Yrgz1fexz7zxA==
X-Received: by 2002:a17:907:9491:b0:ac1:ea29:4e74 with SMTP id a640c23a62f3a-ac252b5aa82mr648274366b.28.1741420251913;
        Fri, 07 Mar 2025 23:50:51 -0800 (PST)
Received: from hex.my.domain (83.11.221.132.ipv4.supernova.orange.pl. [83.11.221.132])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac25d376342sm213104766b.106.2025.03.07.23.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 23:50:51 -0800 (PST)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Sat, 08 Mar 2025 08:50:43 +0100
Subject: [PATCH v3 5/9] clk: bcm: kona: Add support for bus clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250308-kona-bus-clock-v3-5-d6fb5bfc3b67@gmail.com>
References: <20250308-kona-bus-clock-v3-0-d6fb5bfc3b67@gmail.com>
In-Reply-To: <20250308-kona-bus-clock-v3-0-d6fb5bfc3b67@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741420241; l=8577;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=MTjjumplLIdg/n+qAO5fFv6tHfrmUwLPV/PXYF40D9Q=;
 b=pVBzx+27YetSXkafyCJC8wOYIBDGjJqoIodlDyaKCW+2kfABwwrz/Np1Y6xnb7ZE5QPqdKtAE
 cTVY0VLPo2pD+dSpazb4t/Mn/HQ978d6M+KbzDyOM3vLL+VpH7ChyhN
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


