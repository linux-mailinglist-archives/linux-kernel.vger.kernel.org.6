Return-Path: <linux-kernel+bounces-221175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EEEC90EFC8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 16:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36E981C21161
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 14:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30DB3154C1D;
	Wed, 19 Jun 2024 14:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qs/GKz/5"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D09115381C
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 14:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718806160; cv=none; b=VTXsgXpE01SukJQN8XsGNqzMDYgSQWaoY74Y7eCIJpp9Nj8CXgYupnQA4DlnPbIYma8U+/reK59L0R4mbZIDJTKwHyS3GZ3geK8Eub/RBsoJP6MXWJhCa08e4ciydVhQ/8BDIfOBofXVsZKM70JM2bFCxfH4ylF7hq25PkyDNzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718806160; c=relaxed/simple;
	bh=UqitLzzPeo8+v+foWj/D1g1tTUg9dHcKK5jhxbU/5dc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ku0TgJ7LU4PNtSjNSDEQWzOrcmyGIS5WZs90wE/NUZz6XMLYtSXKAJuiUOz//ytgHwUenanSnIOGUn5eYQ8Mi4o6Sl9kPkyasuUCfDZZMEXPRVWRnwm8QkBIzK4L3szfK5vI34ZDcH+MFBqd8ADl6Z539f1ZNxaydhysgo9aHYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Qs/GKz/5; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ebe40673e8so68811861fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 07:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718806157; x=1719410957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jH7teSUneCZWfoVt/91/lHeZpMwu3/Yn++4TJjeU7NA=;
        b=Qs/GKz/5laiNYvsjeBxiBkVMGf/5lX6TdCWc6ifXLOHgmafbxHh2zpaImHh9Aj7Z2y
         TyThogMJ1kLkUrYNneisnVLk0Xo6zFuDgxy/H+IAcao0s98TKJrXJ+4812XNsNKFpvMr
         Q4WH+vfDxF3QDnMROa3kDLorTNL2hG+0xoD+C/wUumglztuHan1jB5e1hvG/OxlbGnAk
         iC3q199BeVgMRNPD9Buz20CPnxCc/mWExi6FmsV4hi6MZQ5wOlIrnSVeaGPeS6LO71Zb
         0vZJoHp7bz4l7vpkJdZantaZNhc6nhoMXd39Fov9k1UcZeiceWknmsAaPpiZkv+S+agn
         fBzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718806157; x=1719410957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jH7teSUneCZWfoVt/91/lHeZpMwu3/Yn++4TJjeU7NA=;
        b=TPTWziBqCJJRxgHn//Mx2VsSnOHDhebvkBfd30Epm3GMOv5onI+5na+BFo4dMuI+WO
         A1L4ZISmZJoebHce2jpy+0b69KhL/4Oogz5aCSWijhfMtCXmpaBd2uKw40m3Ygn3Vpl1
         YcpleMEhfv7yTZCaazRoPA4pitz8iPC40S6ZUhtDUKPvg+fTLtCElk6DbuFe368soKaz
         dd6gpB/gUMzUB0/Xh/ngWRSMm11NdNf71SHvDa7X0H2xe4vujpVpwEQ8jyd3KvCOrivB
         XFk6Alr9clFsKdgTJGbRRQFkhNTe4sd98i/Jmx7GLtmQBHP42NPDYGMcXz2ysq/3H47r
         wZbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcF+4qFxZdK8QupGTcagkqF1R+lkayshiyME43ewfii0FaGD4IYO1aUDb1BDVODVHYIV52g5m0r+MVAPeArdH5/ltLTuzXt1YdlV9s
X-Gm-Message-State: AOJu0YwH5Bdl5sUKqga7H8rK4+7XSGoC2xIGZYRbY7Olg6bk62BTJg+t
	hIhyUp3iRLhASdKF+CskuBD5oLgJJvyUvOphQwzgZ+7JTQy8t3GGCK/UCfG9qF8=
X-Google-Smtp-Source: AGHT+IGoJr5DuwJJ1A2TjVENIUslYHC6GqIXMmnq00+SVaUdczAOZsm6VolY8hrQoNfjsd/Xd4Uhig==
X-Received: by 2002:a05:6512:3d0e:b0:52c:cda0:18bf with SMTP id 2adb3069b0e04-52ccda019d6mr967714e87.4.1718806156688;
        Wed, 19 Jun 2024 07:09:16 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca2872241sm1787003e87.124.2024.06.19.07.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 07:09:16 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Nikunj Kela <nkela@quicinc.com>,
	Prasad Sodagudi <psodagud@quicinc.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] OPP/pmdomain: Set the required_dev for a required OPP during genpd attach
Date: Wed, 19 Jun 2024 16:08:48 +0200
Message-Id: <20240619140849.368580-7-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240619140849.368580-1-ulf.hansson@linaro.org>
References: <20240619140849.368580-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Through dev_pm_opp_set_config() the _opp_attach_genpd() allows consumer
drivers to hook up a device to its PM domains. This works for both a single
and multiple PM domains. Their corresponding virtual devices that are
created by genpd during attach, are later being assigned as the
required_devs for the corresponding required OPPs.

In principle this works fine, but there are some problems. Especially as
the index for a "required-opps" may not necessarily need to match the index
for the "power-domain" in DT, in which case things gets screwed up.

To improve the situation, let's instead assign the required_devs during
device attach in genpd, by using _opp_set_required_dev(). At this point the
genpd and the genpd's OPP table are known for the device in question, which
then can be used to find the correct index for the required-dev.

As a part of this change, genpd also starts to assign the required_devs
even for the single PM domain case, as a way to align the behaviour.
Furthermore, to maintain the existing behaviour for consumers of
_opp_attach_genpd(), let's adapt it to the new genpd behaviour.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/opp/core.c      | 45 +--------------------------------
 drivers/pmdomain/core.c | 55 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+), 44 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index bc1ed1d3d60d..7e567b479c3d 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -2369,7 +2369,6 @@ static void _opp_detach_genpd(struct opp_table *opp_table)
 			continue;
 
 		dev_pm_domain_detach(opp_table->required_devs[index], false);
-		opp_table->required_devs[index] = NULL;
 	}
 }
 
@@ -2393,8 +2392,7 @@ static void _opp_detach_genpd(struct opp_table *opp_table)
 static int _opp_attach_genpd(struct opp_table *opp_table, struct device *dev,
 			const char * const *names, struct device ***virt_devs)
 {
-	struct device *virt_dev, *gdev;
-	struct opp_table *genpd_table;
+	struct device *virt_dev;
 	int index = 0, ret = -EINVAL;
 	const char * const *name = names;
 
@@ -2427,47 +2425,6 @@ static int _opp_attach_genpd(struct opp_table *opp_table, struct device *dev,
 			goto err;
 		}
 
-		/*
-		 * The required_opp_tables parsing is not perfect, as the OPP
-		 * core does the parsing solely based on the DT node pointers.
-		 * The core sets the required_opp_tables entry to the first OPP
-		 * table in the "opp_tables" list, that matches with the node
-		 * pointer.
-		 *
-		 * If the target DT OPP table is used by multiple devices and
-		 * they all create separate instances of 'struct opp_table' from
-		 * it, then it is possible that the required_opp_tables entry
-		 * may be set to the incorrect sibling device.
-		 *
-		 * Cross check it again and fix if required.
-		 */
-		gdev = dev_to_genpd_dev(virt_dev);
-		if (IS_ERR(gdev))
-			return PTR_ERR(gdev);
-
-		genpd_table = _find_opp_table(gdev);
-		if (!IS_ERR(genpd_table)) {
-			if (genpd_table != opp_table->required_opp_tables[index]) {
-				dev_pm_opp_put_opp_table(opp_table->required_opp_tables[index]);
-				opp_table->required_opp_tables[index] = genpd_table;
-			} else {
-				dev_pm_opp_put_opp_table(genpd_table);
-			}
-		}
-
-		/*
-		 * Add the virtual genpd device as a user of the OPP table, so
-		 * we can call dev_pm_opp_set_opp() on it directly.
-		 *
-		 * This will be automatically removed when the OPP table is
-		 * removed, don't need to handle that here.
-		 */
-		if (!_add_opp_dev(virt_dev, opp_table->required_opp_tables[index])) {
-			ret = -ENOMEM;
-			goto err;
-		}
-
-		opp_table->required_devs[index] = virt_dev;
 		index++;
 		name++;
 	}
diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 74ebb8a423be..a38d08862a61 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -2774,6 +2774,57 @@ static void genpd_dev_pm_sync(struct device *dev)
 	genpd_queue_power_off_work(pd);
 }
 
+static struct opp_table *genpd_find_opp_table(struct generic_pm_domain *genpd,
+					      unsigned int depth)
+{
+	struct opp_table *opp_table;
+	struct gpd_link *link;
+
+	if (genpd->opp_table)
+		return genpd->opp_table;
+
+	list_for_each_entry(link, &genpd->child_links, child_node) {
+		struct generic_pm_domain *parent = link->parent;
+
+		genpd_lock_nested(parent, depth + 1);
+		opp_table = genpd_find_opp_table(parent, depth + 1);
+		genpd_unlock(parent);
+
+		if (opp_table)
+			return opp_table;
+	}
+
+	return NULL;
+}
+
+static int genpd_set_required_opp_dev(struct device *dev,
+				      struct device *base_dev)
+{
+	struct generic_pm_domain *genpd = dev_to_genpd(dev);
+	struct opp_table *opp_table;
+	int ret = 0;
+
+	if (!dev_pm_opp_of_has_required_opp(base_dev))
+		return 0;
+
+	genpd_lock(genpd);
+	opp_table = genpd_find_opp_table(genpd, 0);
+	genpd_unlock(genpd);
+
+	if (opp_table) {
+		struct dev_pm_opp_config config = {
+			.required_dev = dev,
+			.required_opp_table = opp_table,
+		};
+
+		ret = devm_pm_opp_set_config(base_dev, &config);
+		if (ret < 0)
+			dev_err(dev, "failed to set opp config %d\n", ret);
+	}
+
+	return ret;
+}
+
 static int genpd_set_required_opp(struct device *dev, unsigned int index)
 {
 	int ret, pstate;
@@ -2830,6 +2881,10 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
 	dev->pm_domain->detach = genpd_dev_pm_detach;
 	dev->pm_domain->sync = genpd_dev_pm_sync;
 
+	ret = genpd_set_required_opp_dev(dev, base_dev);
+	if (ret)
+		goto err;
+
 	ret = genpd_set_required_opp(dev, index);
 	if (ret)
 		goto err;
-- 
2.34.1


