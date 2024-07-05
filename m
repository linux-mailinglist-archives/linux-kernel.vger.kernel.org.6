Return-Path: <linux-kernel+bounces-242034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D2E9282F2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 09:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01B281C243EA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 07:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9A9146584;
	Fri,  5 Jul 2024 07:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bSOZ0JXS"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA43145B22
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 07:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720165282; cv=none; b=bEJhQW2bZKuMbU+0lL+ZZNUOZxfVIKvgmi6shm+YVzvFTK2xOkslJ/Y3vzCUGeOX3ZXzZpGaaSIIOYvrTDEj0zHCpYSOQlJEFWa+mMbs41q42pfm76JAQtVbJTiyGl1auZ+sS+QyWX/SrMnhZqfrg20WhxZxcQBsnwTa8wYa748=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720165282; c=relaxed/simple;
	bh=rpGrIWoy7L3m8NGIRBoMhINKNndn2QfbZx7fdos1EQQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cglo61N/z9wRpMUSOYaD0ZVPzcjfZNgzhrFK83AbTH0nnPmEaf4bb298dd5zAHJ1uLPmNBUr7ej9P7EvfuRnIOLigC/R4LQbCpg61um5+8KQ0rI8zwKa74d6v6BXTMDpiX2vXQaW9dfhmTfCQDR48x7FTdwOCoW5OWxMU8TqMR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bSOZ0JXS; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-424a3ccd0c0so9015795e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 00:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720165278; x=1720770078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xJMsODzy4vs3aLpIbdr6SfS4EPENNYARdHRHbpGgNyw=;
        b=bSOZ0JXSVCAbZGF3jI0oOwNeuJ7ETlG93cwv+nJru0paQiYxys6SjO8G5NAb77+x8W
         Jv66UA/4wbvrIpVm4pxhdxUFjQzNQM8E72FyGOlnXpN8Pfg0RaSFkj4OQXOr/bk09cwm
         DXKvXjEW/c7B4JDwqrNVNFiuEa3WWHUImt+FMUjHIZEsqNbtR8bMK6f9kkkhvXp0g5IH
         ZQvvtDAxhu9SgCa6tXEAf2YN4e+Wip6+6ew3EVcQmHXq+2kRYLiRucM8XoF1UYqTbD9W
         LUlKKZdXBavuruADa0CzWomCWDYmHc775/MCpiAUBFHyEqsiTW+OMO3GopQvWZTB8dA3
         rE4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720165278; x=1720770078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xJMsODzy4vs3aLpIbdr6SfS4EPENNYARdHRHbpGgNyw=;
        b=hpNUvYtEXmQOAZdaWxZt0VAHaBjOMDFELUrhAFhwd3gCqXvJ7lI9fOVRtC7+Fndc25
         yRY/1FSaz7F4a220R1i5kYxeJTAB0e5qXMWY+fQbulHWgUSXjZsd0g2cWNXTR4PexJpw
         nnUUdtMFEBpkhYOTtjdrRZZ3gSFvpmgKgQqFz0Rhq4qTsPDHd5flZITJjmExQCzoReRj
         dMd6rW8j/Ydt2BbNfPOWElyIhUXUntzHw+4VDzLCk0Cel5KlXaL6rQ6iCQeNoa54HCzz
         CkPnBRQ+ib0h3BSCdewGY7zI4cEL5BnSMYt5Fp4BN4QKTMelpam0rJTq7xCoOZkg1Sa8
         1a+w==
X-Gm-Message-State: AOJu0Yxt7mLYM5WNIVOUrEfbkYss/GFWwpXiIBj/NG1Oinzs/FvdQLVk
	8A5PbAvdo9xiNYOlIH1bp65dY0mA3SXuZgx/FnTpGghmg0b20IRtOtKcq5JH7nLKqau2dUlUko8
	uVLQ=
X-Google-Smtp-Source: AGHT+IHTlh75orymobhMecJd6iCtg8T6sjOfNmFJv74cV3zabggPpuI8lsUi0AcAdtb4hUX6TFCjqA==
X-Received: by 2002:a05:600c:12c5:b0:424:a578:fca with SMTP id 5b1f17b1804b1-4264a3d9e29mr28131675e9.4.1720165278592;
        Fri, 05 Jul 2024 00:41:18 -0700 (PDT)
Received: from srini-hackbase.lan ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a1d5116sm50837455e9.10.2024.07.05.00.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 00:41:17 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Dylan Van Assche <me@dylanvanassche.be>,
	Caleb Connolly <caleb.connolly@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Ekansh Gupta <quic_ekangupt@quicinc.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 4/6] misc: fastrpc: support complete DMA pool access to the DSP
Date: Fri,  5 Jul 2024 08:40:43 +0100
Message-Id: <20240705074045.418836-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240705074045.418836-1-srinivas.kandagatla@linaro.org>
References: <20240705074045.418836-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1956; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=C26JNwUiWg5/qKi+dgD+tXUf7Ay0d6cJGOQDusSWOwU=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBmh6N9iDRIfX4R6b60wCUc2Uoh26ciwbOe5sU+4 JlDne1aq7CJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZoejfQAKCRB6of1ZxzRV N56lCACtVM30SEJ7XzYFLNheZKulRSTz6V4wvpXgajTR9Sh1bgkmf1hO98NpEof5UncCr1co5Qp L4kpzS/0TNyOFZd3Rmj5YUdVj/wTr8KqhQ4cdz0gBUzGIVlR2aG6zmj3PkUH2+5uRyIfol7nqU3 wAF9y5Y5xjrArcuaU6YMdLQmqG6Fatgo94iEpAm8kIeLbIDsqLTJbMOZs0kzOs7XmwfIf1yqjVp gNgpJw/uJ73qqXCYv4Jx5k97ai7xUCVmzBLT24domoythvQkBd5ZpFl0is6TNdsfu9gb9TdvETb 6XjJc2X8OASTncef+7vxORgVWlU0Y7JfDaVNaKTFYUSNess5
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


