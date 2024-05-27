Return-Path: <linux-kernel+bounces-190960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DEF98D04E0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 16:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E66062893F2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 14:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80A9170843;
	Mon, 27 May 2024 14:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k40r6NRU"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D71616F914
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 14:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819976; cv=none; b=o8ywMIXf4DzHWIB7tt/NYM7jg5dUmGvsWKO7l3gHa0M0cDrJ2cCjbz2OlZkLZr3S795jKPUApz9G/Gph6pECXD9qcUSm8RsYYI97dS/r0dJGbl+1LcEyk9svDmJGzqUH/1GTlyPOCVDYZ3vY8mIgJ/hOWJOwmEpwo1TYD2gtXkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819976; c=relaxed/simple;
	bh=pVa/c7bjkzXR/HPoXDkq9hzau6IgX+Petquna3Ia5vI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TH/OYUVIYPTledfF1w32DioeXOLSvmOm8E9AbThTiFcDiisDaoAqR28Fa6ESrol6uvF53PRV8BU4RIyCzyXG2N3PS+j7o3XrvmUOebAps9Y/BBpaBx2+ixFdm90V8MEofAQCSU6+Ef4FvhNu1J5pSwa5Qm9JUk4INNxoktdMFfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k40r6NRU; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5295dada905so2658185e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 07:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716819972; x=1717424772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p4GCCTlIOT/1pc4oKXuIbqiN9A8llTw5QQ9hWjk7xes=;
        b=k40r6NRUDBENIKez7hzrCxWWEDP3/XjlJR1btJO4VZlzav0eH++gFzeOe875QuFE5l
         xn6MtImvBnOfGIi7tm6vTHd0NEr0YDUL+xcQ5hjd8cBh1DNcAXuxcUCVimwp/cbJ/nCb
         jD8+uuBws7qWiuuoSQwuw14aDG0c7KnshjfHdlCAkgv78/fnhh5wYETJC7+VWfcLBbmy
         QZukE37sho/H86UFyezP9/OWfTP2wV/OWQ40E2BYd/W4HPa2lFE2nLcHU4Lu2IUICJGb
         CVmk5qo+bonKruklyrfBXWAo0VgaQpV6m3vsCMF0k8JZ3syVlQpCRE5BhlPEdkKywuja
         H4aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716819972; x=1717424772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p4GCCTlIOT/1pc4oKXuIbqiN9A8llTw5QQ9hWjk7xes=;
        b=kw6YXCPMgzkBrPoAf5UBrykpbTffGK0NHF1kzohpgnPCXetK1hXxf9ZSQq0HQj1rHp
         68Ova91KHVVEjWmimgnjG0RZN3QRlTZGvL4yqUZ+eHjNZMDJM3qaD5uID1Cle1NsnWUG
         OwLjbaBj5XnuEsJCnZrhwWtlQLyaV764Xjqzsr7IuAuZTj02gj7bhnXVKie8MCvcva+x
         FE1w2kdzfB1JaTC6u2ceD4ZSoWHZJO2vTQysr57lltpqTWpvYTihllNkDk5hbFbLh01I
         NTyZanboOhaC/ac0Y6h0kG63xjyQeYBBNPUgRBEFXWL2dRhgeGC4ic/jKKfHamHj6OlD
         w2Pg==
X-Forwarded-Encrypted: i=1; AJvYcCXn/Np3IWcZXhxuE8TPIhU8iPOgljgm1uyIvb0pHoXNRIMKEkqwYLu9KFK7msfnYd8vgkhziM7SdBtLoM4Nl3ExhCN/dSbOMHu36cxW
X-Gm-Message-State: AOJu0Yx0K3ooFXxRFbzHjNbb+b+b0TsCBtl5xhzHJbXWR/2bZWBtziVv
	VmW7tBob4XEy4xkUMXRRIP2iMPwN14Uh9crZWS1gR/JodrBXYVf831tp0WbXoEc=
X-Google-Smtp-Source: AGHT+IGBURZMgZ64X0UKam0G5PlXXXeQ2dC+7S7QNY89ucqJb86w8XI5Zqsgk9t8jyaoT8/KyxTQXg==
X-Received: by 2002:a19:5e10:0:b0:51f:c38b:149c with SMTP id 2adb3069b0e04-527ef3ff4d1mr4004141e87.10.1716819972310;
        Mon, 27 May 2024 07:26:12 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-529711fa7f3sm562002e87.258.2024.05.27.07.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 07:26:11 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	linux-pm@vger.kernel.org
Cc: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
	Nikunj Kela <nkela@quicinc.com>,
	Prasad Sodagudi <psodagud@quicinc.com>,
	Maulik Shah <quic_mkshah@quicinc.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-rt-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/7] pmdomain: core: Use dev_name() instead of kobject_get_path() in debugfs
Date: Mon, 27 May 2024 16:25:53 +0200
Message-Id: <20240527142557.321610-4-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527142557.321610-1-ulf.hansson@linaro.org>
References: <20240527142557.321610-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using kobject_get_path() means a dynamic memory allocation gets done, which
doesn't work on a PREEMPT_RT based configuration while holding genpd's raw
spinlock.

To fix the problem, let's convert into using the simpler dev_name(). This
means the information about the path doesn't get presented in debugfs, but
hopefully this shouldn't be an issue.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
Changes in v2:
	- New patch.
---
 drivers/pmdomain/core.c | 23 +++--------------------
 1 file changed, 3 insertions(+), 20 deletions(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 454fccc38df1..90a65bd09d52 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -3182,7 +3182,6 @@ static int genpd_summary_one(struct seq_file *s,
 		[GENPD_STATE_OFF] = "off"
 	};
 	struct pm_domain_data *pm_data;
-	const char *kobj_path;
 	struct gpd_link *link;
 	char state[16];
 	int ret;
@@ -3215,16 +3214,9 @@ static int genpd_summary_one(struct seq_file *s,
 	}
 
 	list_for_each_entry(pm_data, &genpd->dev_list, list_node) {
-		kobj_path = kobject_get_path(&pm_data->dev->kobj,
-				genpd_is_irq_safe(genpd) ?
-				GFP_ATOMIC : GFP_KERNEL);
-		if (kobj_path == NULL)
-			continue;
-
-		seq_printf(s, "\n    %-50s  ", kobj_path);
+		seq_printf(s, "\n    %-50s  ", dev_name(pm_data->dev));
 		rtpm_status_str(s, pm_data->dev);
 		perf_status_str(s, pm_data->dev);
-		kfree(kobj_path);
 	}
 
 	seq_puts(s, "\n");
@@ -3393,23 +3385,14 @@ static int devices_show(struct seq_file *s, void *data)
 {
 	struct generic_pm_domain *genpd = s->private;
 	struct pm_domain_data *pm_data;
-	const char *kobj_path;
 	int ret = 0;
 
 	ret = genpd_lock_interruptible(genpd);
 	if (ret)
 		return -ERESTARTSYS;
 
-	list_for_each_entry(pm_data, &genpd->dev_list, list_node) {
-		kobj_path = kobject_get_path(&pm_data->dev->kobj,
-				genpd_is_irq_safe(genpd) ?
-				GFP_ATOMIC : GFP_KERNEL);
-		if (kobj_path == NULL)
-			continue;
-
-		seq_printf(s, "%s\n", kobj_path);
-		kfree(kobj_path);
-	}
+	list_for_each_entry(pm_data, &genpd->dev_list, list_node)
+		seq_printf(s, "%s\n", dev_name(pm_data->dev));
 
 	genpd_unlock(genpd);
 	return ret;
-- 
2.34.1


