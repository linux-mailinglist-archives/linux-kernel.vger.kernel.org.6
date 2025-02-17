Return-Path: <linux-kernel+bounces-517371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0C9A37FD1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2443E3B318F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECFC7218EA2;
	Mon, 17 Feb 2025 10:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o8twVDZo"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D89218AA8
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 10:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739787479; cv=none; b=YzPk1idapfJkbrpUMmol15Bawh9KxlSig5L+5T2GfmIkpCK2nH0FGPIeRyABWyNmG/UvMEjq7DJ5UmPbeNe6r5kHbdHzsZv8ejKagoyd3O/4BtkkwxNNdgktjYyD8gi4MiN6ZXmToZl1q1Wki6UxE5L07UG7HgXoBjzzPVwInQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739787479; c=relaxed/simple;
	bh=aIDoW7X3UEqmkRU5fd1ed1f7Yb48yUxmvjsG6JEXMy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jaQnn4XnTUJALsWxb8C2SvRgo+GuotS0TB4edC3TroUKNBCNLgyy9Dqs4IF45d8TgqqZuxPAWzxuMZUAHgj1sVNnGfBDg/TQgq5WbhBQO/5lEK4tyB8Y4lXfzPJHoutbZuTPHsdZk6i1xb9gv6HHVduCLgOPtbZsQC1ckpS2IPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o8twVDZo; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-abb79af88afso297712066b.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 02:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739787475; x=1740392275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pjqSIaqjo22M/fJ6WrzBYInBLUW49xWtc11H9nbdufw=;
        b=o8twVDZojukUFWL3S8iI2AP6UXMtrVpRVaVZH5UvvmTEpXcZO1UpLxeF/YDscsxnCB
         S+jjnSTM2IasEld2rvi7OfFnTKUwwPSYqTk+coYyqOpzyHziSAl9zl9ev9M3FstDb+5+
         6cErzq/sJAhoxcjpkzUqzAsC7sjlrUrsgoclQu4UtPVOQaI9hsjGQJM+gNY4bjgXnNXq
         520EfVxXrR3v4tW+oAMjlHcgqhXKdqfbFznB/CwuROHoYjyRM1beA6qm27iN4iy2tif0
         Bs/ZBIll+F39RX/vEk+4u5isoI7LTWYnz8UsU8QLOJSPKMibWBQMwpbEJxaN1dZnHue9
         wutA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739787475; x=1740392275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pjqSIaqjo22M/fJ6WrzBYInBLUW49xWtc11H9nbdufw=;
        b=mzUyerHnxoUgO6RFq57jTXE26UJf66kwZ0pWY3G25jx0cmGcgWnhfWLzLmfqh1aOEo
         uJndS8+hVR8FdV+bpgXEWPuAIZvKiig+8OVl/ax9MtqB4viED6OHQ5q9t9XmIp4go0Ev
         MI8ekmVVNQH7FnUPiI8umtyB2FRCdiygwdUqjXKYrz0dvd9IgYzTW3jpiM29GsBItl2A
         Oyk1+8nNmWT3ca24dRl765AThexE0Q3aSubX1wZIpFtt2i4WxycSD5ImgRlGneBScHHc
         05iPWW7HsbvGZiA19itzbKQYngoyH8z8W1odTVdw5qUcR4aSpvBCIF0a9hyc37rG0fsu
         WxtA==
X-Gm-Message-State: AOJu0YyoI87zylb7oDJfh548jH9TeKpg/EMhjpUwYGWx3iHg1gxOHjm+
	Pu5MJG5sCWofFprMnztQlcUrlX8OzS3A/cfXXpZc0IhMb6ODzvgsLXKpsV07R9s=
X-Gm-Gg: ASbGncurNa/US5wO16ckNSVObLPSnaAxbK2+jecsoAaFI0RIMoK2Ojvvlhg4OUA69CW
	7IInXvnFQkQczdNdP4sapOz7HdEHM2LR3uq7wX1JVpZmhUrq89L0V5Wagnj9/gB52lWGia9EScJ
	XEUPmgVABCSrgN75v/ucPkE+ua+ayOY1se33x4hIp+yY5URtITAl3Yc9ch+ICLU7fC7YIp1sIBr
	MYtzXkh1p6fyYPvu+lguJI+UY5lmOO2NB+B69K2aquSK6qkRPV+08DaE7jaZtCOD3GmtB/iiWIO
	q1iWO06R4XTgzGkQbp7Jrs90
X-Google-Smtp-Source: AGHT+IFlDyIupv/Dc3O4C3y1gwzt/272w46jucKO95aSvrTTvzjMkzKCPNIWu+2421TQveFqhl50lg==
X-Received: by 2002:a17:907:26ce:b0:ab7:b878:e8bc with SMTP id a640c23a62f3a-abb70de288cmr1064938866b.38.1739787474939;
        Mon, 17 Feb 2025 02:17:54 -0800 (PST)
Received: from eugen-station.. ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb8b1767e8sm308583266b.174.2025.02.17.02.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 02:17:54 -0800 (PST)
From: Eugen Hristev <eugen.hristev@linaro.org>
To: linux-arm-msm@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	kees@kernel.org
Cc: linux-kernel@vger.kernel.org,
	johannes@sipsolutions.net,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	andersson@kernel.org,
	konradybcio@kernel.org,
	tony.luck@intel.com,
	gpiccoli@igalia.com,
	pmladek@suse.com,
	rostedt@goodmis.org,
	john.ogness@linutronix.de,
	senozhatsky@chromium.org,
	quic_mojha@quicinc.com,
	linux-arm-kernel@lists.infradead.org,
	kernel@quicinc.com,
	Eugen Hristev <eugen.hristev@linaro.org>
Subject: [RFC][PATCH 06/10] qcom: smem: enable smem pstore backend
Date: Mon, 17 Feb 2025 12:17:02 +0200
Message-ID: <20250217101706.2104498-7-eugen.hristev@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250217101706.2104498-1-eugen.hristev@linaro.org>
References: <20250217101706.2104498-1-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable smem pstore backend that registers regions into the minidump
table.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 drivers/soc/qcom/smem.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index 592819701809..f4d2646fcc0b 100644
--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -1236,11 +1236,21 @@ static int qcom_smem_probe(struct platform_device *pdev)
 	if (IS_ERR(smem->socinfo))
 		dev_dbg(&pdev->dev, "failed to register socinfo device\n");
 
+	ret = qcom_smem_md_init(&pdev->dev);
+	if (ret)
+		dev_info(&pdev->dev, "smem minidump backend init failed\n");
+
+	ret = qcom_register_pstore_smem(&pdev->dev);
+	if (ret)
+		dev_info(&pdev->dev, "smem pstore backend registration failed\n");
+
 	return 0;
 }
 
 static void qcom_smem_remove(struct platform_device *pdev)
 {
+	qcom_unregister_pstore_smem();
+
 	platform_device_unregister(__smem->socinfo);
 
 	hwspin_lock_free(__smem->hwlock);
-- 
2.43.0


