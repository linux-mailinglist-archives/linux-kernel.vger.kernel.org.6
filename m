Return-Path: <linux-kernel+bounces-242084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 546D1928354
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 09:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D67F82841B3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 07:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26AD1144D2B;
	Fri,  5 Jul 2024 07:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HnvR032M"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2D9145B20
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 07:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720166351; cv=none; b=kzmJkrDJpQ3UJNTiLrdZX/GzThGs187JJ1VSqOxsl3ft7ulW6xX3Rzy/OyaxqGkqPinLvFju5FZKjpiKj5wdvaCIkMxYJ4sj4sLdKLemKSZBl38r4nnKyBPW1655RbNYAnbLFi5TLA5IXyJDmkv21xVpJJlsG0WEC8hcsZvx0Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720166351; c=relaxed/simple;
	bh=rpGrIWoy7L3m8NGIRBoMhINKNndn2QfbZx7fdos1EQQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U/XdZ1B8KtEb30mEo9nKi1Js5Gr0j/eMGPPRT1HEsJD+/wjh8tTEtp9hCrPRgbdCTBHZFKI0Vh8aV9IWz9u1U7k/+QNW2ZJIha89bg8QZ9li6INiJIe6Fk1qi6VXygSMH/+nV7cVx0fnIFzkVLj1A9IVtfkmPvAHqetrujjnJUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HnvR032M; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52ea3e499b1so741900e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 00:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720166348; x=1720771148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xJMsODzy4vs3aLpIbdr6SfS4EPENNYARdHRHbpGgNyw=;
        b=HnvR032M2xDqK9NN5J4uy6ILXuewV+iIEbZWq1t3QUyHAaCxU83Q5Hn0lzKMaOTWwH
         koLby8+Ib68Twy9i+TdQtN9sBv8M1ruMh0ctOA5QCLYqDRxs0b5xz8pVi9wvmOqo5KHX
         ky8lv7kIEpRbjOUSpMaGpzSkhODJW11RBPPVKx6KLD776rLcs0DqBYm11lBgTfJgN0rB
         4f5Fh6mcBsel4FWD1V6JmmGWLpuQu8cIbVNZAnxCljanKwbU9Gc2KUswbl6vRBPFUysG
         kRTKpyglpvU/WUDZ1cH7VTzYc0t+u8ZQHOJCNDHim/sHtOjuSYdNddBztHb6WxjUIhng
         kicg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720166348; x=1720771148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xJMsODzy4vs3aLpIbdr6SfS4EPENNYARdHRHbpGgNyw=;
        b=X8RD66fbh0mM8K1sTuut9W1I1HoNZtgbdW5yOvywCrfOzW+BoynuP7ZhegV7QGmnBS
         NwVs6UMWn2jdc41GVUzH+3sdC8DqAB3KyO8lYcOg3zDs4BPnB1pQjMDEKEa+hKAQHrho
         tWBNHmfBdouH/ikTWA8/gt6za3xjri1gFg6OXZuciiFFc3mvE7rRyYodhj5adIOSXqAs
         xtDmBx6BbBBJKAYA2IXexavt8XnZxDW7LBo869jiFXGOGuz/xc5rw8hDKp1Ly8qN+wfH
         2WrBXFMFu20s2MA6Mqrpaai4KlphH4QgkmQHEtzQSlT20bJTDkL+5hp/zeggktynTeg9
         +yIQ==
X-Gm-Message-State: AOJu0YxwNSQC3JfIihOsD5XZpH/t8N5iBZ9Mqe1UJhzshZJQ/2hUnbf7
	TUMD0kYKLZJlP8XLUbhNGMP7YVa1LqSXfQNgoMIOKFTbPNUMv/Js5g1VxkcpYTc=
X-Google-Smtp-Source: AGHT+IGhtkecfba9NiIpJp/X26F7qVefbcuG7PPZ0aWZbiS3HuUI5If/0GX0IWBzbXaGmkmUZOwxCA==
X-Received: by 2002:a19:6a14:0:b0:52c:d9f8:b033 with SMTP id 2adb3069b0e04-52ea061f85fmr2416825e87.3.1720166347674;
        Fri, 05 Jul 2024 00:59:07 -0700 (PDT)
Received: from srini-hackbase.lan ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42651531f1fsm15315485e9.0.2024.07.05.00.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 00:59:06 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Dylan Van Assche <me@dylanvanassche.be>,
	Caleb Connolly <caleb.connolly@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Ekansh Gupta <quic_ekangupt@quicinc.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 4/6] misc: fastrpc: support complete DMA pool access to the DSP
Date: Fri,  5 Jul 2024 08:58:58 +0100
Message-Id: <20240705075900.424100-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240705075900.424100-1-srinivas.kandagatla@linaro.org>
References: <20240705075900.424100-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1956; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=C26JNwUiWg5/qKi+dgD+tXUf7Ay0d6cJGOQDusSWOwU=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBmh6fDiDRIfX4R6b60wCUc2Uoh26ciwbOe5sU+4 JlDne1aq7CJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZoenwwAKCRB6of1ZxzRV N1XXB/0VQtMXTGlnMsmU07RcDDa7naD1G3qZNP1kN02ChS3woJtmToGBK4S4Nre2PfQq9DUm3Ro MWrUZdggqu/PNgZB6HGUIVBemt9r8RlaoiaipKi7K3OmL61PO+aC1hikiEPrpATQWsIw3pcqGgT 4vplbyonr2dpCVU+X8ANAiuGNrNJuW1b77+uWrv1sY8NRSOpwJvu1rEImP1/AX4ZeYlKqEykCg7 WCmrz4QuWO4trs58cTyWiboC6mhH6D2K8XOGpkQHetfrUvQBVPR9DxMZeA8IR2LsHqLEyedd3IV ikeqDFgT4hW4LlKs/ljOBA7vV90fe3MktAmJ83JWQR8b3m/C
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Dylan Van Assche <me@dylanvanassche.be>

To support FastRPC Context Banks which aren't mapped via the SMMU,
make the whole reserved memory region available to the DSP to allow
access to coherent buffers.

This is performed by assigning the memory to the DSP via a hypervisor
call to set the correct permissions for the Virtual Machines on the DSP.
This is only necessary when a memory region is provided for SLPI DSPs
so guard this with a domain ID check.

Signed-off-by: Dylan Van Assche <me@dylanvanassche.be>
Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/misc/fastrpc.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 5fb302b8ae5d..1c045f9a75a4 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -2250,6 +2250,8 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 	int i, err, domain_id = -1, vmcount;
 	const char *domain;
 	bool secure_dsp;
+	struct device_node *rmem_node;
+	struct reserved_mem *rmem;
 	unsigned int vmids[FASTRPC_MAX_VMIDS];
 
 	err = of_property_read_string(rdev->of_node, "label", &domain);
@@ -2292,6 +2294,23 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 		}
 	}
 
+	rmem_node = of_parse_phandle(rdev->of_node, "memory-region", 0);
+	if (domain_id == SDSP_DOMAIN_ID && rmem_node) {
+		u64 src_perms;
+
+		rmem = of_reserved_mem_lookup(rmem_node);
+		if (!rmem) {
+			err = -EINVAL;
+			goto fdev_error;
+		}
+
+		src_perms = BIT(QCOM_SCM_VMID_HLOS);
+
+		qcom_scm_assign_mem(rmem->base, rmem->size, &src_perms,
+				    data->vmperms, data->vmcount);
+
+	}
+
 	secure_dsp = !(of_property_read_bool(rdev->of_node, "qcom,non-secure-domain"));
 	data->secure = secure_dsp;
 
-- 
2.25.1


