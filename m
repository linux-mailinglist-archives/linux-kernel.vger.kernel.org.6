Return-Path: <linux-kernel+bounces-311954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF95968FDF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 00:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 114251C22CD7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 22:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1903C188597;
	Mon,  2 Sep 2024 22:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ar5Qvbj0"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85CB187345
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 22:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725317306; cv=none; b=Vg0+y4qjEKIIlpMKIZx5b7K10MqdqZQ9oiMdjl0Sj2opU44itwrv0OaAmb1EZC2ENsZnAtShfonifYLoImvso7rFBTrTpQfMw3aV0s06Yq0o8MuSoUcXKJbwGEmNNCdxmGOBg3ARFoqGW+BK96wWkaSZY9ZwpripQWQqNIniGAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725317306; c=relaxed/simple;
	bh=KRl5gIk/xaaSVm4A8qkRf/eQuDGM9FOXcCPGTsi2ir0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VFCxP/hEt4fC0ZJuSBDSMjNMX7c3Jy7Tw9vvtrzhI/dDq8iZYKozg1EXKzBqpvJTR2iG4B114Fwsqur/FXvS2W3J+kpZwX0vqmYHXx04HHERqOgnSCv9+y0NLa8GAIqHBNXL8NIOYDO0sK1zb56JGIAJtFke12qY6i95vB98MWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ar5Qvbj0; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-533461323cdso5826295e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 15:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725317303; x=1725922103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=unxJ+wBaXqYULZDFmCrhH65p4MukCH6nGkbZu7WGkXY=;
        b=Ar5Qvbj0g0GkgxwwnpK7m3bHr40jSrocPOvqoY2bzcsCcuMYdM4CsBzgMZtc1xmtg6
         ZzuWpSa07rEg/QFBXuW8/Ijadb/gXejbpLt1UhrKMjROz8lV8fRAmGAYpVkyMF8LAOPP
         9dOB7vFNqNvme/7b39Sxba2Orb0nUyZhWA79wPMqxMbndDYVxaNhlH/XR5oFecg/wZMt
         bhuoennCGARNQjXjblsPXGdGu/4qjVVtr/1XvltP74TvD0LGmfRw0u0FXdw2eMgbUiDO
         4kPIFREmvFDcJb2CMVWHgwAd2rnKUZATfkODqPCGaTRJswXxKLuqy7clljhsG3AfUmDQ
         5/yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725317303; x=1725922103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=unxJ+wBaXqYULZDFmCrhH65p4MukCH6nGkbZu7WGkXY=;
        b=iIz2F0eKiOddXJijGgFk77dyFc63V0i5PEiUpIM/Cl5cILOc7I26ah0/cw1s2gZFRm
         lR5uTzmmdgbvR4fQgOu5NJGd1PCjtyOy5grF6QBPqz9QC+UTXGHFm0cP1bTsP7LpEefx
         /DYraqLqKITi17efaheQ4l8OfJ/uDoIm4eo5LdSA19qDeZNP4uHhzOPN+eYL5si6Y3js
         pLveigiQHfseqg4ul5e4GR2l1jAwjjsMpKG4eI5UsepPJ2TGFTIwHBXtA4G3wEGpArsO
         qfMymg0OI8mbrMnqOeZrG3gs97JaCn6TEfWhPW+WBn8C95gnsJy8RyWP8eYjrsroL7Bp
         E47g==
X-Forwarded-Encrypted: i=1; AJvYcCUoRpe54nBSaUBJcbGKXnZUDPcfz/Vc2a/MsTwiVm5bHvGXjFDIjq3oxnCzj6ODsBSN1TaKTa9ngN9obvA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsxXpWsv5C58w3n4VkPuKEFpD4sjoaqaD4o81bWy2/mwWk6ppI
	Lft+aPYYG7BCD8DpOCxe9RW34YIfhhhbHoKA4H4WT3dCwudFdmxJUe9qw5MyYTs=
X-Google-Smtp-Source: AGHT+IGRv4/CgOPjLgovmViqGy6VQy2jkOlEq31xC1A2H4ZtVtkvJUMee9Gvs1n9YE+bjKaghE76Jw==
X-Received: by 2002:a05:6512:2310:b0:533:448f:7632 with SMTP id 2adb3069b0e04-53546af92c5mr7263393e87.1.1725317302670;
        Mon, 02 Sep 2024 15:48:22 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5354079bbf2sm1790646e87.20.2024.09.02.15.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 15:48:22 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Dikshita Agarwal <quic_dikshita@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <quic_kdybcio@quicinc.com>,
	Nikunj Kela <nkela@quicinc.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Stephan Gerhold <stephan@gerhold.net>,
	Ilia Lin <ilia.lin@kernel.org>,
	Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
	Vikash Garodia <quic_vgarodia@quicinc.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] OPP: Add helper to retrieve the OF node for an OPP table
Date: Tue,  3 Sep 2024 00:48:14 +0200
Message-Id: <20240902224815.78220-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240902224815.78220-1-ulf.hansson@linaro.org>
References: <20240902224815.78220-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As being shown from a subsequent change it can be useful for a OPP consumer
to retrieve the corresponding OF node for an OPP table. Therefore, let's
add an OPP helper for it.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/opp/of.c       | 12 ++++++++++++
 include/linux/pm_opp.h |  6 ++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index fd5ed2858258..f0950339da55 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -1461,6 +1461,18 @@ struct device_node *dev_pm_opp_get_of_node(struct dev_pm_opp *opp)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_get_of_node);
 
+/**
+ * dev_pm_opp_table_to_of_node() - Finds the node for an OPP table
+ * @opp_table:	The opp_table to return the node for
+ *
+ * Return: The DT node corresponding to the @opp_table.
+ */
+struct device_node *dev_pm_opp_table_to_of_node(struct opp_table *opp_table)
+{
+	return opp_table->np;
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_table_to_of_node);
+
 /*
  * Callback function provided to the Energy Model framework upon registration.
  * It provides the power used by @dev at @kHz if it is the frequency of an
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 451a7465a605..7894e631cded 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -469,6 +469,7 @@ void dev_pm_opp_of_cpumask_remove_table(const struct cpumask *cpumask);
 int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask);
 struct device_node *dev_pm_opp_of_get_opp_desc_node(struct device *dev);
 struct device_node *dev_pm_opp_get_of_node(struct dev_pm_opp *opp);
+struct device_node *dev_pm_opp_table_to_of_node(struct opp_table *table);
 int of_get_required_opp_performance_state(struct device_node *np, int index);
 bool dev_pm_opp_of_has_required_opp(struct device *dev);
 int dev_pm_opp_of_find_icc_paths(struct device *dev, struct opp_table *opp_table);
@@ -528,6 +529,11 @@ static inline struct device_node *dev_pm_opp_get_of_node(struct dev_pm_opp *opp)
 	return NULL;
 }
 
+static inline struct device_node *dev_pm_opp_table_to_of_node(struct opp_table *table)
+{
+	return NULL;
+}
+
 static inline int dev_pm_opp_of_register_em(struct device *dev,
 					    struct cpumask *cpus)
 {
-- 
2.34.1


