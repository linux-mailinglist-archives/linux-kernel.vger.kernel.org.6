Return-Path: <linux-kernel+bounces-414781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A95C9D2D46
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 18:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A32CC1F23D93
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 17:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98741D3586;
	Tue, 19 Nov 2024 17:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OM0a6WbG"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F263E1D26EE
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 17:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732039010; cv=none; b=kwvLtG44g6vNLBFnWO8H9cli3Plmi9/E+tWKnG14U5s4reDwcRoUWg4t/4kW+X/OyUR7I7/LVLtWrlmEsQnLjwdYiwm5MlQA9BkHn0hN2kIzZqamelgWkEPaogQWFju+P5zYSAWf2GjNn2PzAbODvplcgK4JpvC7ZDxe/ApJ7Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732039010; c=relaxed/simple;
	bh=jYCp8TR7dzoclrZB3zyNwAn2VlLPZL58y51ut7TpNS0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oz/uA0Moj5mtkzdS85g2zfunUVSv15PClBT7M8yA/iiyIKGdtkei/NFViEpo2bPGMe1llvMHNqODCP1y8KydxtDU2KqZryfyWyoFG3vK8evXsJPhzIEAC3Ylj2dQ8yfy/0uIBEtH6G4QO5lVcxv73iLIY/77t0BK0wGlUxDg3Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OM0a6WbG; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4314fa33a35so48608545e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 09:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732039006; x=1732643806; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=77Eoli2JKcfvmzeyZfmZcAC8ruXlT3sz4RV/g2sy6qg=;
        b=OM0a6WbGN4kRpvTMxCmFJtzlXzPxr4CWzs3RGOG6xaoq9KwxyxSYOf/L9GJEuzVCVQ
         TO9mXD4n0raQOsNIrc40+LmFP7eG9MPxUICMYAYUixfrzeod9THdZ1noKIiKPEmG8KCx
         4uFF0IS+7lbYpPZqizWzQIsCfKz/ojKNRawUyRY7hART8wHErAFNOROWyCZCp1sHOGd7
         CkhriO2sGSn6RYaDxMKu0q8N9b8iSqhqlr3ZQLUm6FDX3xexJgucFGXKrVMEuKhS9lxt
         OUeCHdodzZUdnLMsyngGm2ADRplwu0RTSRVpJv0Dqz29wXpyZ+456h3ScktJlnLla6eO
         B48A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732039006; x=1732643806;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=77Eoli2JKcfvmzeyZfmZcAC8ruXlT3sz4RV/g2sy6qg=;
        b=IadJ8JGJF09vN0S8sNawZ1zhU+dVfPzT9IsiJhiedFDNwF4G0mYbmXAEevFjDN33k6
         567sczOTgj2B5vhwsf4UPfks4QYv4OExn2H40d//mhmdfUwxh+3jMIgPNtb1fXb30Kmu
         MKMhTGW4Vzd1sXIdw1+BrJJEYqA+WmPoYH/MlPklZW8fHLYFARL1X1Msw93YiZkH6Ztx
         fHR+mvKE5MtDbmyfGC+yFNk3wn+G2Avi96mcsAvIf6xZl+sV6/D9/yO5aeAC7CQyVv6f
         eNWF//at3NBINPH9gkJoDFPIG67rdz9xZRYhSZuNW1NfvBKpTeIHt6kbQT18EC0xqSaI
         z83Q==
X-Forwarded-Encrypted: i=1; AJvYcCUyK89MBO3hsJ8zvdkxl18q3m6wjZ0iq5v8XLQdqc4CBuV6626w8oRZmjArLRU5UBF0LSAJcDiRPngIFng=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIjMYNT9A6zz886TOuQCe7wp95lEKjJOQfuBwvBmtdbID+l+3v
	yttIzF5RhXwuzncnfuLqUAHrkKRQwvv4VD3FmFMe5U5b4VnlODtCb1nLLmUVbT5LVCzhSoHsKgP
	5
X-Google-Smtp-Source: AGHT+IF+Lx7qgtgHAGXdWBZ2QyFola8SI6L7q/xdAwZBh6gOo8f5SFDq9dfDsh2MOCUWBja2J9sv1A==
X-Received: by 2002:a05:600c:35c8:b0:430:57f2:bae2 with SMTP id 5b1f17b1804b1-432df791f62mr123906335e9.23.1732039006322;
        Tue, 19 Nov 2024 09:56:46 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da27fe68sm208302275e9.24.2024.11.19.09.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 09:56:45 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 19 Nov 2024 18:56:36 +0100
Subject: [PATCH v2 01/11] opp: core: implement dev_pm_opp_get_bw
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241119-topic-sm8x50-gpu-bw-vote-v2-1-4deb87be2498@linaro.org>
References: <20241119-topic-sm8x50-gpu-bw-vote-v2-0-4deb87be2498@linaro.org>
In-Reply-To: <20241119-topic-sm8x50-gpu-bw-vote-v2-0-4deb87be2498@linaro.org>
To: Akhil P Oommen <quic_akhilpo@quicinc.com>, 
 Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Stephen Boyd <sboyd@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Connor Abbott <cwabbott0@gmail.com>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 devicetree@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2743;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=jYCp8TR7dzoclrZB3zyNwAn2VlLPZL58y51ut7TpNS0=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnPNFXzHRfip66xeIvRHFGvMRVvKXc3AYGENiBWrVV
 6SXuRnuJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZzzRVwAKCRB33NvayMhJ0btFEA
 CxS/Y3wNk1GVdwKy07e3iKyukBHX2qmyQj6NiA9v2ta5Cz/uPNSaS8Tc32gJESqqwJojuIQlF7k4No
 DynYwa/WDju9SFUVD1z2cMFL+FCvgSRWaqWCLqR7cGJMvMgyZlMv7zR9WYa7M5wJ/MNzYn91nUDvCa
 3//OfR6I3DwpaHFLewgE8rLC9ZB3RLsi4RzMKGsK+IKXcvsbmbPJf+HjgFYMSAc8PW/I2tvWQ/InSy
 gFFZjfXuvRuLrZWHqT1Gi4rRicne6TRCYpLh4p+BFUxe5KnEGDZg8o3ceWMxwKor4TSaVQQTKsnNWt
 W/GPR6N7GgzTLxQO6epXobNAUv02VeDNUs66KIY7rUF4qy3sMI6G+aTf9vE0w/g8Fd3u1YaOE3N8o1
 nxMzXagpNBdnf9rI110qFeirQMY6ZIp57HyQbmKVK1Vk0R0VM46MLCJdfp5t7I0/NU7NG4If6uYuqK
 PLKl+kOpOLIq8yaTA/vpvfP5uV0q/3HYIBx/QJAHJIYUtp3PMoCTj+VYqhHaQ6bGrK9iaqwNAorqeO
 8VefKlo8kKdPgB6/7ip8k2Y625U0EHqOAdluF4+kCxGD+T0qLHefkoqkSSmaHYSoVHzL7H6hVZZPzq
 wMkQtSkoWZmSqTLDUZZWPPkznILvnx0n/3S8aVEASCP32GztYdODY1Npp8GQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Add and implement the dev_pm_opp_get_bw() to retrieve
the OPP's bandwidth in the same way as the dev_pm_opp_get_voltage()
helper.

Retrieving bandwidth is required in the case of the Adreno GPU
where the GPU Management Unit can handle the Bandwidth scaling.

The helper can get the peak or average bandwidth for any of
the interconnect path.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/opp/core.c     | 25 +++++++++++++++++++++++++
 include/linux/pm_opp.h |  7 +++++++
 2 files changed, 32 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 494f8860220d97fc690ebab5ed3b7f5f04f22d73..864b9b99b0129acaffaf45c584c5f34b8bababed 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -106,6 +106,31 @@ static bool assert_single_clk(struct opp_table *opp_table)
 	return !WARN_ON(opp_table->clk_count > 1);
 }
 
+/**
+ * dev_pm_opp_get_bw() - Gets the bandwidth corresponding to an opp
+ * @opp:	opp for which voltage has to be returned for
+ * @peak:	select peak or average bandwidth
+ * @index:	bandwidth index
+ *
+ * Return: bandwidth in kBps, else return 0
+ */
+unsigned long dev_pm_opp_get_bw(struct dev_pm_opp *opp, bool peak, int index)
+{
+	if (IS_ERR_OR_NULL(opp)) {
+		pr_err("%s: Invalid parameters\n", __func__);
+		return 0;
+	}
+
+	if (index > opp->opp_table->path_count)
+		return 0;
+
+	if (!opp->bandwidth)
+		return 0;
+
+	return peak ? opp->bandwidth[index].peak : opp->bandwidth[index].avg;
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_get_bw);
+
 /**
  * dev_pm_opp_get_voltage() - Gets the voltage corresponding to an opp
  * @opp:	opp for which voltage has to be returned for
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 6424692c30b71fca471a1b7d63e018605dd9324b..cd9a257b8e7766d6c8631351a10a845c88414a74 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -106,6 +106,8 @@ struct dev_pm_opp_data {
 struct opp_table *dev_pm_opp_get_opp_table(struct device *dev);
 void dev_pm_opp_put_opp_table(struct opp_table *opp_table);
 
+unsigned long dev_pm_opp_get_bw(struct dev_pm_opp *opp, bool peak, int index);
+
 unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp);
 
 int dev_pm_opp_get_supplies(struct dev_pm_opp *opp, struct dev_pm_opp_supply *supplies);
@@ -209,6 +211,11 @@ static inline struct opp_table *dev_pm_opp_get_opp_table_indexed(struct device *
 
 static inline void dev_pm_opp_put_opp_table(struct opp_table *opp_table) {}
 
+static inline unsigned long dev_pm_opp_get_bw(struct dev_pm_opp *opp, bool peak, int index)
+{
+	return 0;
+}
+
 static inline unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp)
 {
 	return 0;

-- 
2.34.1


