Return-Path: <linux-kernel+bounces-530826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E31A438DC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1427A3AD833
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F364267F6A;
	Tue, 25 Feb 2025 09:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L13KKHFO"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C10265617
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740474323; cv=none; b=AtFqSbbPHg5elQrsoQCg6qYFr/nUPc9nppnwT+81B7W3fKOzUf4EnvXsXjezmNfPtAuKK/02WsYAkWVVQTSsXvGFhjgSH2SecKHL3wvigH3yPgmtWmJKft7dRMeOqYMV4pZeIVl0Xo91wbJuUMTfz7RZ2xpp1iTf4CCqnYCAd5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740474323; c=relaxed/simple;
	bh=MuVFv0xJA1aIIdUbLAcynY4g87XgdT+Fpu04pLc0qqk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OF/rCvbWin0suJDaaHqJwLaq2tExUqLoxE88ahZpYKonOeJlsbuZBjBM5NrEc3gS1b3iAnPzkTuovjwwz67ygoHSRvy3hTEbdhn0d4+du9FMVPzxVtH77rvvm4ApWFXTslemAXhGUQkbtybo+FLX01piXdU976uWL5BwyR5N2SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L13KKHFO; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-38f3ac22948so2678594f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 01:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740474319; x=1741079119; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n1Wm3m4ktQWXQaRTF4Zc5/MnyxbU+OWxULwpKIAGXso=;
        b=L13KKHFOhjAuAoG0MGtqsInmAHzPZU0nnhRFxlyJAqkd5/aWiIvmcE0iNJqF/nBjp+
         WfOxPHpdb8zTEJeL64kvX591mPIAFvSyo1YKczZKM3+MWAZjZfLrVb6Iak66eg8dM+zw
         +QJRkJh7YQ9+QXmjZXaRVorbngy9jPvqfVJGzlvI+ii1TcJ5/NcNxZrcegTXq0CR5uis
         p/4xoz7tAD1UszBPF91b2+uc+MfiPEiSjtYVfoSBpibVBqiskYmoUK5et5HIVMhzsmpE
         4Xu4gS57TwBqT6IhOdv64q27Mj++Y+0JZwZnbJuOUmgoekzIQJtbMTYmdOEG1rr813vd
         SgAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740474319; x=1741079119;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n1Wm3m4ktQWXQaRTF4Zc5/MnyxbU+OWxULwpKIAGXso=;
        b=tXvi0x5Prj05pzk4Mpk5S50Sls8LLwWsKQVr0AqXSOLEQwZJ7LtHehmXVGT5Gl9iQo
         +1OFY+1nUdRq7VufmGpkKNgH7FNKKkp9SS5ULGG1+IWB24wb7DPoEutW1shbgOeWN3oS
         cHcRy5++iaJNcwlMlUBwjvMvmyOXoj2qCo8q2+VahriSIOrIa2/B9Drj7dXpcKHzUY7L
         dMjZZJLZAJjHM5TD85eZ94srDLdkVBFOHSbVtjf4Xj71X1uA3bO+x1NOPMM1mdJ3Hr6o
         TIv8N92fgjSTauM/7Hy5W+2mIm9AneSIXEoRdEW4gfDuTrdfoT60A6BtvRwERW83INDB
         +guQ==
X-Forwarded-Encrypted: i=1; AJvYcCVB47WWSzdXe8Fz3RyDHOzab/ur9uKIv5o05M5hZhzgRuguCN7z2vTRSvqUXWZm/rsi8g561/wPfYqm4oQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/ezlXk+f7zECihQwoJArNPExLVa+RVkpox6FWp7TO9ciqd6xd
	CvQU/UkO/78ydEk8fCxaqsdsrDisk4up8Ewj5xAejmDFEWZ/T+YxBMAjzuHt7Uo=
X-Gm-Gg: ASbGnctIwfbJOgsVwNvP+CoG2jZCP+Jx3emb1ff92IkA+Rdwf8fgibeBkKrxI39nntp
	CjrFpYAHn5zmLT1e9+jxTygPHOiM1XpMgYF909FLhRF/kH8+KERvqf5oltwDzP5Ln6HdnAuK+78
	ssChBuKcNdRerAUSNA5bTBo3E8b2Fn3227LIEuJhuHe8Z7+egTN6W5SmgxgRnI6eKaKpRLdQls7
	qMaHsPBtp6jp8Vq0u6DJFZ00LLQt1cqkFxLPyEkiDMqnIwaNji9Bk9vUpp0rjsJu58rHUi/z6QX
	5GkzymIWtsrWdSt1aTscfMy5wx2V1dmweZ9wEeudFOtV5k4=
X-Google-Smtp-Source: AGHT+IExJfVX2pa7E8zGHho5gW4/I4CUzeqhG7AuJ1CY8Ss/DePppdeXLqIKsLK4iw25aSCA/hBgOA==
X-Received: by 2002:adf:ce12:0:b0:38f:4cdc:5d36 with SMTP id ffacd0b85a97d-390cc630c2cmr1583604f8f.43.1740474319256;
        Tue, 25 Feb 2025 01:05:19 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd86c93bsm1573540f8f.26.2025.02.25.01.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 01:05:19 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 25 Feb 2025 10:05:10 +0100
Subject: [PATCH 2/4] media: platform: qcom/iris: add reset_controller &
 power_off_controller to vpu_ops
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-topic-sm8x50-iris-v10-v1-2-128ef05d9665@linaro.org>
References: <20250225-topic-sm8x50-iris-v10-v1-0-128ef05d9665@linaro.org>
In-Reply-To: <20250225-topic-sm8x50-iris-v10-v1-0-128ef05d9665@linaro.org>
To: Vikash Garodia <quic_vgarodia@quicinc.com>, 
 Dikshita Agarwal <quic_dikshita@quicinc.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4781;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=MuVFv0xJA1aIIdUbLAcynY4g87XgdT+Fpu04pLc0qqk=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnvYfLpi2ryu2nYjTFw4rJn8OiaJy5B5WJgLv0J0SB
 noO6oFeJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ72HywAKCRB33NvayMhJ0SJ3D/
 9LqsoPuOuXTSSGjcDIaChAU3qiHXJeQd+SP4Y4Lz51YFykc44TJzIyw2FpeKqPGMGt6/lJ1Am3NOkM
 oU0cfdc1iGpzgcxt/Mp1guuEFXZRkzSqcceXw/YyE+m7t1AGyu8BRFveUwxTQoaH6BNeLudxBOKLl2
 z/wGTmZkMQd1JVzVsX8TLI1F2fmDW38bO1TnQfIGTALiB+kP6LkedkCNaKqD7FQULmr/xYb1lLDOEe
 bEy/EuP7EuvjCt6vWLh+RC228HcZHFuwyORpP/dNXMJWJxlWGk8x79nfysiG7NSW4i/EiVPD4oxD5e
 KyZHjoOCsM9JSByZlW7He6usz5D3ZBEp7ievG2E7Ww27GqDH++cynzOFE6meK2fzd8jy25hTrv14Jj
 STFXGLGt8T1sgdG1WyShCNoNhmwltYzskZGXvzCH5BbvyVEljSSNNpUNxxrIfZGKzLv7wvjWd1rRhF
 dqZsxiPY4dRnObHfC4DvBIvtaU9rrpT2FCtlj/fRBRlmthEgURkmlqZOXtEGVlQ8991ReN1FOpNBcE
 utJdBjoQI/61mbJiwpixZNfES81PLGjegIs3Xy6PX3VBE08r4nd3mWWLMeNnaa8Gwl4ONlHnDDFCs+
 wyzvJiKy9P0BHNOcAKQqG7gqmGBcuhwl38fwKGA3BgQY+OSK6HGc2q8/gjaA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

In order to support the SM8650 iris33 hardware, we need to provide specific
reset and constoller power off sequences via the vpu_ops callbacks.

Add those callbacks, and use the current helpers for currently supported
platforms.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/media/platform/qcom/iris/iris_vpu2.c       |  2 ++
 drivers/media/platform/qcom/iris/iris_vpu3.c       |  2 ++
 drivers/media/platform/qcom/iris/iris_vpu_common.c | 14 ++++++++++----
 drivers/media/platform/qcom/iris/iris_vpu_common.h |  4 ++++
 4 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/qcom/iris/iris_vpu2.c b/drivers/media/platform/qcom/iris/iris_vpu2.c
index 8f502aed43ce2fa6a272a2ce14ff1ca54d3e63a2..093e2068ec35e902f6c7bb3a487a679f9eada39a 100644
--- a/drivers/media/platform/qcom/iris/iris_vpu2.c
+++ b/drivers/media/platform/qcom/iris/iris_vpu2.c
@@ -33,6 +33,8 @@ static u64 iris_vpu2_calc_freq(struct iris_inst *inst, size_t data_size)
 }
 
 const struct vpu_ops iris_vpu2_ops = {
+	.reset_controller = iris_vpu_reset_controller,
 	.power_off_hw = iris_vpu_power_off_hw,
+	.power_off_controller = iris_vpu_power_off_controller,
 	.calc_freq = iris_vpu2_calc_freq,
 };
diff --git a/drivers/media/platform/qcom/iris/iris_vpu3.c b/drivers/media/platform/qcom/iris/iris_vpu3.c
index b484638e6105a69319232f667ee7ae95e3853698..95f362633c95b101ecfda6480c4c0b73416bd00c 100644
--- a/drivers/media/platform/qcom/iris/iris_vpu3.c
+++ b/drivers/media/platform/qcom/iris/iris_vpu3.c
@@ -117,6 +117,8 @@ static u64 iris_vpu3_calculate_frequency(struct iris_inst *inst, size_t data_siz
 }
 
 const struct vpu_ops iris_vpu3_ops = {
+	.reset_controller = iris_vpu_reset_controller,
 	.power_off_hw = iris_vpu3_power_off_hardware,
+	.power_off_controller = iris_vpu_power_off_controller,
 	.calc_freq = iris_vpu3_calculate_frequency,
 };
diff --git a/drivers/media/platform/qcom/iris/iris_vpu_common.c b/drivers/media/platform/qcom/iris/iris_vpu_common.c
index fe9896d66848cdcd8c67bd45bbf3b6ce4a01ab10..ec8b10d836d0993bcd722a2bafbb577b85f41fc9 100644
--- a/drivers/media/platform/qcom/iris/iris_vpu_common.c
+++ b/drivers/media/platform/qcom/iris/iris_vpu_common.c
@@ -211,7 +211,7 @@ int iris_vpu_prepare_pc(struct iris_core *core)
 	return -EAGAIN;
 }
 
-static int iris_vpu_power_off_controller(struct iris_core *core)
+int iris_vpu_power_off_controller(struct iris_core *core)
 {
 	u32 val = 0;
 	int ret;
@@ -264,23 +264,29 @@ void iris_vpu_power_off(struct iris_core *core)
 {
 	dev_pm_opp_set_rate(core->dev, 0);
 	core->iris_platform_data->vpu_ops->power_off_hw(core);
-	iris_vpu_power_off_controller(core);
+	core->iris_platform_data->vpu_ops->power_off_controller(core);
 	iris_unset_icc_bw(core);
 
 	if (!iris_vpu_watchdog(core, core->intr_status))
 		disable_irq_nosync(core->irq);
 }
 
-static int iris_vpu_power_on_controller(struct iris_core *core)
+int iris_vpu_reset_controller(struct iris_core *core)
 {
 	u32 rst_tbl_size = core->iris_platform_data->clk_rst_tbl_size;
+
+	return reset_control_bulk_reset(rst_tbl_size, core->resets);
+}
+
+static int iris_vpu_power_on_controller(struct iris_core *core)
+{
 	int ret;
 
 	ret = iris_enable_power_domains(core, core->pmdomain_tbl->pd_devs[IRIS_CTRL_POWER_DOMAIN]);
 	if (ret)
 		return ret;
 
-	ret = reset_control_bulk_reset(rst_tbl_size, core->resets);
+	ret = core->iris_platform_data->vpu_ops->reset_controller(core);
 	if (ret)
 		goto err_disable_power;
 
diff --git a/drivers/media/platform/qcom/iris/iris_vpu_common.h b/drivers/media/platform/qcom/iris/iris_vpu_common.h
index 63fa1fa5a4989e48aebdb6c7619c140000c0b44c..c948d8b5aee87ccf1fd53c5518a27294232d8fb8 100644
--- a/drivers/media/platform/qcom/iris/iris_vpu_common.h
+++ b/drivers/media/platform/qcom/iris/iris_vpu_common.h
@@ -12,7 +12,9 @@ extern const struct vpu_ops iris_vpu2_ops;
 extern const struct vpu_ops iris_vpu3_ops;
 
 struct vpu_ops {
+	int (*reset_controller)(struct iris_core *core);
 	void (*power_off_hw)(struct iris_core *core);
+	int (*power_off_controller)(struct iris_core *core);
 	u64 (*calc_freq)(struct iris_inst *inst, size_t data_size);
 };
 
@@ -21,7 +23,9 @@ void iris_vpu_raise_interrupt(struct iris_core *core);
 void iris_vpu_clear_interrupt(struct iris_core *core);
 int iris_vpu_watchdog(struct iris_core *core, u32 intr_status);
 int iris_vpu_prepare_pc(struct iris_core *core);
+int iris_vpu_reset_controller(struct iris_core *core);
 int iris_vpu_power_on(struct iris_core *core);
+int iris_vpu_power_off_controller(struct iris_core *core);
 void iris_vpu_power_off_hw(struct iris_core *core);
 void iris_vpu_power_off(struct iris_core *core);
 

-- 
2.34.1


