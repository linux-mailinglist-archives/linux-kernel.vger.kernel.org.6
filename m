Return-Path: <linux-kernel+bounces-256851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33FD993713C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 01:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC7341F21FB0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 23:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19971146A8B;
	Thu, 18 Jul 2024 23:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z/I9ZBRo"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C59148314
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 23:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721346215; cv=none; b=Ed4s59smWJwa+N3hMSe/U92n1SbvdMGVBk7V/1WLEdzIjCTCiC9Mhl0artbCkAd9Qie2Yj2C+w7VEB0s5yuUR4tI3rtWH0EXp4mrEh4Sj9BFHpkNX4vDfB2Odfh2M4cJj3p85uO2eHovXxBdjZv+ENM7QnQZsTjZAmpVWOvXvyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721346215; c=relaxed/simple;
	bh=q9HqaY78viyGGiaUkgmvLpNWtXDFKV24MjRfrhvMn+U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XYNn16nH5ckTtnLNqp22f01krNCsCxzrMCk5rfjScLWUQoDBt7nukhd1i76RrO+72F7iUbVrztjmKEyUs5qu2evstbHlmE4QhXdh6DOj6/5jShYurbqGEqPkLJfI7KwkVM/TlxA+DDz3uvTGK/+zikatXsq7o3e5C8nTpVWgM/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z/I9ZBRo; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52e99060b0dso1109750e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 16:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721346211; x=1721951011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qiy79RCH12nO+kuD43r9KxQZmT684plvYyRVA5SbNNc=;
        b=Z/I9ZBRoZ6zTywC1rtlBk+efuDYKgcIlMhFHnaljqMSk7EpqsX0/sA113l4E/o9wlu
         LRnKUuQoxlHIoF7qAxViIaEXgttiCIXeAlgfgFa9RNGBlRNc8bor845iQLHqrHTRtz4O
         RmSlhf8cVZ+8/w0EhpWMIk3iTlQWZJRzM/cZPdHDboYBagr8l2A02Ie9v3opihNWC6Ek
         pNtOxlYtwRFTQTRGQHqo9G1y42jCatIzqTsn9lkIeLhjIkoX7UCJcVxyHaGgHJBY+7Yr
         PB3OUriKodUml5FrPNfvDFkwlFuMqs3qOIh3KUzxgcgdOxdphMMt0OiL3Y8G2Rud1dby
         NbEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721346211; x=1721951011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qiy79RCH12nO+kuD43r9KxQZmT684plvYyRVA5SbNNc=;
        b=SygKQNI/06HyJ22Gpo6m0Q8gMOBI7RXUXSVZuzzAdQFAPUhN7keFwmxGZY8VBdqkCO
         6mstnnksifxsOAeR2Nt+6HeNy2wZxgMMzlsGLQXjGvhHceEoO022nU9UgvU/wC1XWwqy
         6YTNzwiwWfqewGu+ahEozRqGnhWs9JU6WNT4tPFWeE52odAR0PDZSlmwPAm+lbO+d8Mo
         Oxomx2K3C6/GIkN5C6E5lmjHFNxmfTNgEGUzaX9CbWh6KY34NYuvmDkXKo7MRRyKC+BP
         hIEcWp8mlUg87elK7Q4UPsK/6+xxTKsixb/2JqB088M2vttWUERt5q1vCyk7MPHVcm6L
         Nasw==
X-Forwarded-Encrypted: i=1; AJvYcCXbIv1qDxQTHgEoCLqtsRdVPUM7TrkuO+uORwzaenLkV5/62tFnR6b9q5IQPR5pquYwgZJiggjRiS/IwzVXM0Cgw5D7ThYXFeua2wjL
X-Gm-Message-State: AOJu0YyWF+ujpNJE8cuzG5jRc0yqVh+PIpPh2qBIGRm588L0LsefVVbE
	SLjGKAkY5PhZVWXhOaTMWzJoZq58ZUme6qPNGaYppNOEtNwbGOYw7VYe2VUBkvo=
X-Google-Smtp-Source: AGHT+IE/PQcs9Xj45ekRvDZ9k+t/Et7RHcrmh62SIuBoPAG7Wl7rJpYPtWq1KQeWzrJ9ZjlpqQ2KEA==
X-Received: by 2002:a05:6512:39c7:b0:52c:8df9:2e6f with SMTP id 2adb3069b0e04-52ee5429228mr4551665e87.42.1721346210863;
        Thu, 18 Jul 2024 16:43:30 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ef556b4fbsm22491e87.139.2024.07.18.16.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 16:43:30 -0700 (PDT)
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
Subject: [PATCH v2 5/6] pmdomain: core: Drop the redundant dev_to_genpd_dev()
Date: Fri, 19 Jul 2024 01:43:18 +0200
Message-Id: <20240718234319.356451-6-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240718234319.356451-1-ulf.hansson@linaro.org>
References: <20240718234319.356451-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There's no longer any users of dev_to_genpd_dev(), hence let's drop it.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	- None.
---
 drivers/pmdomain/core.c   | 10 ----------
 include/linux/pm_domain.h |  6 ------
 2 files changed, 16 deletions(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index fdbc3aab9083..bc89edcbd583 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -184,16 +184,6 @@ static struct generic_pm_domain *dev_to_genpd(struct device *dev)
 	return pd_to_genpd(dev->pm_domain);
 }
 
-struct device *dev_to_genpd_dev(struct device *dev)
-{
-	struct generic_pm_domain *genpd = dev_to_genpd(dev);
-
-	if (IS_ERR(genpd))
-		return ERR_CAST(genpd);
-
-	return &genpd->dev;
-}
-
 static int genpd_stop_dev(const struct generic_pm_domain *genpd,
 			  struct device *dev)
 {
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index f24546a3d3db..772d3280d35f 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -260,7 +260,6 @@ int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
 int pm_genpd_init(struct generic_pm_domain *genpd,
 		  struct dev_power_governor *gov, bool is_off);
 int pm_genpd_remove(struct generic_pm_domain *genpd);
-struct device *dev_to_genpd_dev(struct device *dev);
 int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state);
 int dev_pm_genpd_add_notifier(struct device *dev, struct notifier_block *nb);
 int dev_pm_genpd_remove_notifier(struct device *dev);
@@ -308,11 +307,6 @@ static inline int pm_genpd_remove(struct generic_pm_domain *genpd)
 	return -EOPNOTSUPP;
 }
 
-static inline struct device *dev_to_genpd_dev(struct device *dev)
-{
-	return ERR_PTR(-EOPNOTSUPP);
-}
-
 static inline int dev_pm_genpd_set_performance_state(struct device *dev,
 						     unsigned int state)
 {
-- 
2.34.1


