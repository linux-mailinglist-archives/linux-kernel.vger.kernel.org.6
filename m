Return-Path: <linux-kernel+bounces-516667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED5A3A37590
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 17:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBE543B2038
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 16:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1189A19DF64;
	Sun, 16 Feb 2025 16:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZWOaLUi"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3576C19C578;
	Sun, 16 Feb 2025 16:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739722376; cv=none; b=FuULWmbBG1lxtT/OfQ664+MZ27DMW+xXByVy0WZYQPKUNgb2bbsVp3MyGwbDuyDKK4mXspzFznIVKNlsFgl2oc4od6DZfqYqgeWIVOuEJ77cJHl75fghBm6KJWygYGUOwGVIKJcFHUrndTkEo3SIdNRbwC+g/p/XVBXM/oJJewc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739722376; c=relaxed/simple;
	bh=VeeVmD/o8Dsf3wPBzIti6j/EIlDAuwzvCwpc3RCU4qM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FZu7i72/DAkCN3WAyz2/o1enb76w/7nWdjoB2x2t3fLcM0lnAixlQz9tuSy1wQWpMvbQzMCS8dDUnJVlaWxZmKnky4QOsvwTIZLLASdT/2GsTJUYbLQ251Pj20f4sX3fMbCSPYo8Zmpbk1Ov8udrZJkbFx3vauGtMF4/Pr6z4Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LZWOaLUi; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aaf900cc7fbso531851366b.3;
        Sun, 16 Feb 2025 08:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739722372; x=1740327172; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bFtcXLHPXTm+qAgLIh2Q+3EIz0nV5DFjQtabctfzSP0=;
        b=LZWOaLUiL9N+A2+oBRVALXRwBpndNQ6BYLH8zym6TFhgzsEKkSoHbgHOnGHupGEN6E
         MHo6MFyRfzGzWObVGaxG0GIfPqbJHSAa3AI8kj1Pqg1M/sTe4f4EUES184/KmAz5cxM3
         9XybFbNj9gB1fFbEtp7DIt5EtxVhGNpbfDGvJbJOpnAy9x53RLzFZniILNUa5cEaVKPH
         bOKHTdXWg9kmlrpe44d8eJu/vhz1fOWdTXDjeKrSrC8vh3nJZCJ4Odifjw49lyizCGnO
         DyzGo0vGbzHJ42/MeyF1/mjqCT2itgRowaBGP0yhuaLA++aNXcpVgBF/rH9Z5vKXuRCe
         PE0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739722372; x=1740327172;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bFtcXLHPXTm+qAgLIh2Q+3EIz0nV5DFjQtabctfzSP0=;
        b=kQtlatq1EJ6BwgKHBOwgSqjwfVQVZlTxOmM5F5bgDr13rju6ZQcBiyiYJ43dTdW5dc
         8uhx0zj5Ssfi2tMjcghtEEWX/v5mqZfAfw6Uj0wEIAXt0hCH8n+rs8etT+nui/+4yZnc
         zKXJZFvL+Vx+yaVgf4EOAOKie2wdCppnYCBZJXC6cdcXU3Z16UQq1Y4kl53zQqYgGFuy
         rkS1M8T/gsiDlNzeHPRIuV00md+KHkezAlCrCMUbORI/09cmGjvGsZVcuYdnkJH3Btot
         /HBuq0Nr05+7XG+irlBN1bFC9sutPQ5TLMenHN6QamiGIGvxHpCCKBMx+jRy0fJZih9b
         Y9pA==
X-Forwarded-Encrypted: i=1; AJvYcCUcR0Rj5VyaRsD6wj8jBSmTSPyxvTMIbhZOrcAgdsfKqDNSKR+/BwAyIo9dLCgpBN8evDgWBz+Rjw+2K5Mo@vger.kernel.org, AJvYcCVif55qboUmpa8SJqwbLdDEzKYFSlX6id9XvyZ1gCD5lNmecWMMlOvTxZGdFvewJXM8qxutPP6bT+fH@vger.kernel.org, AJvYcCWIr6QWM71erZnYZ9azfNVKEs1ofETOg5LXBu/7o6LNpk6vkMptG1a4hVphZnDX5Ca8znTnqJdx7/lS@vger.kernel.org
X-Gm-Message-State: AOJu0YwEZFjZ83bxblUUJ3p5FckBxF4aLFOy9IASQTEAVDxwmaIp99Aw
	Koil+e6OsktksJzlIg9ZqivbSwvcLtJzNQxyHxGPtAGJAFukSi5h
X-Gm-Gg: ASbGncs/ozvLKMIAWIXqJuhjwkmLHuOy/jwZiLLmehYLkKD0nab1fs9PsJ1bHl5upJm
	+z7EJey1Jtd1pLnZt6LkuaK5tm3WdirDlwcyIbqGMnMuJJgtR9lEjc3e8B6v3sqceOJTloYWnU2
	U4RTVYgz1yZhmgh1xLCNbBbf1S5KBecWxdXWLTFMXjd+tGivFmdBjbRdjr6fFCaksojzcG2d3lV
	dFdlxA5HDWngqawmKY8S9/yC9pi5HfsGCz2d5g20fD6dq9aHoofRe9X04xcPcsdFPMujObIY5xI
	6lEmz0B+g1nJ538/PCtsvZjYqBJWXRFeWEQ+KCDNCK0imukOdSsHx9noq7CtAg==
X-Google-Smtp-Source: AGHT+IFzLyfSCIRwLkmoAYjQN/rQ2y/+Bj4d2a9uOBk11O3VyIArjMDRFlg+jhREqi9whehcRVFmOw==
X-Received: by 2002:a17:906:370c:b0:abb:519e:d395 with SMTP id a640c23a62f3a-abb70a959d9mr541482466b.20.1739722372334;
        Sun, 16 Feb 2025 08:12:52 -0800 (PST)
Received: from hex.my.domain (83.8.115.239.ipv4.supernova.orange.pl. [83.8.115.239])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb8eea4d65sm148463466b.161.2025.02.16.08.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 08:12:52 -0800 (PST)
From: Artur Weber <aweber.kernel@gmail.com>
Date: Sun, 16 Feb 2025 17:12:38 +0100
Subject: [PATCH RFC 3/5] clk: bcm281xx: implement prerequisite clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250216-kona-bus-clock-v1-3-e8779d77a6f2@gmail.com>
References: <20250216-kona-bus-clock-v1-0-e8779d77a6f2@gmail.com>
In-Reply-To: <20250216-kona-bus-clock-v1-0-e8779d77a6f2@gmail.com>
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
 Artur Weber <aweber.kernel@gmail.com>, Alex Elder <elder@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739722366; l=5257;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=45Vb7U7z4DhCqwxNlVuYEGiXzYnfLCnnP5g3+QGTQgg=;
 b=bBMw4Gd3sQKAn5fzIi6iF1AJ/Uqf5q4mEflXvR4dXfeVZYYM5Q1p+B/FYbPEZFF+jzi15ujL/
 w8cA+rAuZXFDzcTv7CSpIzXveRzFO7poEFITtF3u33pEzbhAFPZcFo2
X-Developer-Key: i=aweber.kernel@gmail.com; a=ed25519;
 pk=RhDBfWbJEHqDibXbhNEBAnc9FMkyznGxX/hwfhL8bv8=

From: Alex Elder <elder@kernel.org>

Allow a clock to specify a "prerequisite" clock, identified by its
name.  The prerequisite clock must be prepared and enabled before a
clock that depends on it is used.  In order to simplify locking, we
require a clock and its prerequisite to be associated with the same
CCU.  (We'll just trust--but not verify--that nobody defines a cycle
of prerequisite clocks.)

Rework the KONA_CLK() macro, and define a new KONA_CLK_PREREQ()
variant that allows a prerequisite clock to be specified.

Signed-off-by: Alex Elder <elder@linaro.org>
--- Artur: rebase on v6.13, move prereq prepare/unprepare to main
    prepare/unprepare functions, use locking versions of clk_prepare
    and clk_enable since the non-locking versions are no longer
    public ---
Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
 drivers/clk/bcm/clk-kona.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/bcm/clk-kona.h | 20 ++++++++++++---
 2 files changed, 79 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/bcm/clk-kona.c b/drivers/clk/bcm/clk-kona.c
index e92d57f3bbb147e72221802175a80502897d7504..21f925683d0da05ebc97f92236dfb207b1f9c741 100644
--- a/drivers/clk/bcm/clk-kona.c
+++ b/drivers/clk/bcm/clk-kona.c
@@ -9,6 +9,7 @@
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
+#include <linux/clk.h>
 #include <linux/clk-provider.h>
 
 /*
@@ -961,6 +962,63 @@ static int selector_write(struct ccu_data *ccu, struct bcm_clk_gate *gate,
 	return ret;
 }
 
+/*
+ * Common clock prepare/unprepare functions. These implement a "prerequisite"
+ * mechanism; the prerequisite clock is prepared and enabled before the main
+ * clock is prepared.
+ */
+
+static int kona_clk_prepare(struct clk_hw *hw)
+{
+	struct kona_clk *bcm_clk = to_kona_clk(hw);
+	const char *clk_name = bcm_clk->init_data.name;
+	const char *prereq_name = bcm_clk->prereq.name;
+	struct clk *prereq_clk = bcm_clk->prereq.clk;
+	int ret;
+
+	/* If there's no prerequisite clock, there's nothing to do */
+	if (!prereq_name)
+		return 0;
+
+	/* Look up the prerequisite clock if we haven't already */
+	if (!prereq_clk) {
+		prereq_clk = __clk_lookup(prereq_name);
+		if (WARN_ON_ONCE(!prereq_clk))
+			return -ENOENT;
+		bcm_clk->prereq.clk = prereq_clk;
+	}
+
+	ret = clk_prepare(prereq_clk);
+	if (ret) {
+		pr_err("%s: unable to prepare prereq clock %s for %s\n",
+			__func__, prereq_name, clk_name);
+		return ret;
+	}
+
+	ret = clk_enable(prereq_clk);
+	if (ret) {
+		clk_unprepare(prereq_clk);
+		pr_err("%s: unable to enable prereq clock %s for %s\n",
+			__func__, prereq_name, clk_name);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void kona_clk_unprepare(struct clk_hw *hw)
+{
+	struct kona_clk *bcm_clk = to_kona_clk(hw);
+	struct clk *prereq_clk = bcm_clk->prereq.clk;
+
+	/* If there's no prerequisite clock, there's nothing to do */
+	if (!bcm_clk->prereq.name)
+		return;
+
+	clk_disable(prereq_clk);
+	clk_unprepare(prereq_clk);
+}
+
 /* Peripheral clock operations */
 
 static int kona_peri_clk_enable(struct clk_hw *hw)
@@ -1172,6 +1230,8 @@ static int kona_peri_clk_set_rate(struct clk_hw *hw, unsigned long rate,
 }
 
 struct clk_ops kona_peri_clk_ops = {
+	.prepare = kona_clk_prepare,
+	.unprepare = kona_clk_unprepare,
 	.enable = kona_peri_clk_enable,
 	.disable = kona_peri_clk_disable,
 	.is_enabled = kona_peri_clk_is_enabled,
@@ -1260,6 +1320,8 @@ static int kona_bus_clk_is_enabled(struct clk_hw *hw)
 }
 
 struct clk_ops kona_bus_clk_ops = {
+	.prepare = kona_clk_prepare,
+	.unprepare = kona_clk_unprepare,
 	.enable = kona_bus_clk_enable,
 	.disable = kona_bus_clk_disable,
 	.is_enabled = kona_bus_clk_is_enabled,
diff --git a/drivers/clk/bcm/clk-kona.h b/drivers/clk/bcm/clk-kona.h
index a5b3d8bdb54eaee9fad80c28796170207b817dfd..c32c621282ec6dd40fff3f7598ee8aa007fed524 100644
--- a/drivers/clk/bcm/clk-kona.h
+++ b/drivers/clk/bcm/clk-kona.h
@@ -406,6 +406,10 @@ struct kona_clk {
 	struct clk_init_data init_data;	/* includes name of this clock */
 	struct ccu_data *ccu;	/* ccu this clock is associated with */
 	enum bcm_clk_type type;
+	struct {
+		const char *name;
+		struct clk *clk;
+	} prereq;
 	union {
 		void *data;
 		struct peri_clk_data *peri;
@@ -416,16 +420,26 @@ struct kona_clk {
 	container_of(_hw, struct kona_clk, hw)
 
 /* Initialization macro for an entry in a CCU's kona_clks[] array. */
-#define KONA_CLK(_ccu_name, _clk_name, _type)				\
-	{								\
+#define __KONA_CLK_COMMON(_ccu_name, _clk_name, _type)			\
 		.init_data	= {					\
 			.name = #_clk_name,				\
 			.ops = &kona_ ## _type ## _clk_ops,		\
 		},							\
 		.ccu		= &_ccu_name ## _ccu_data,		\
 		.type		= bcm_clk_ ## _type,			\
-		.u.data		= &_clk_name ## _data,			\
+		.u.data		= &_clk_name ## _data
+
+#define KONA_CLK(_ccu_name, _clk_name, _type)				\
+	{								\
+		__KONA_CLK_COMMON(_ccu_name, _clk_name, _type),	\
 	}
+
+#define KONA_CLK_PREREQ(_ccu_name, _clk_name, _type, _prereq)		\
+	{								\
+		.prereq.name	= #_prereq,				\
+		__KONA_CLK_COMMON(_ccu_name, _clk_name, _type),	\
+	}
+
 #define LAST_KONA_CLK	{ .type = bcm_clk_none }
 
 /*

-- 
2.48.1


