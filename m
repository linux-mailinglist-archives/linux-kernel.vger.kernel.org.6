Return-Path: <linux-kernel+bounces-428958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68EA49E155A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 09:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63B0F1615AB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 08:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57981C2327;
	Tue,  3 Dec 2024 08:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O4BjREfV"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E54419C543
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 08:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733213589; cv=none; b=n2VU4nuzH7k/wFJyB0nZfq3JMdyIOWg19PIcrcVdXhVVlHc+fF6BKBRnK+imcX8Zo9dlew+qdeEgoQ0iGmxJKaUE3JO34T9Rp1k9aIsSRCLo887yj1niCP0vy94HPkCoP9uOenkfhxl1/Hv1Cd4cqakBlOgaVF9Gh4gQPNkMmsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733213589; c=relaxed/simple;
	bh=GfIxjX3fUAG9xD0E7y4Y7LPGVwA/ovHOoj/JqoQo4b8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mzczT5dVgLYZmKTCwVnbiBPK0wO1ht9eM9z5VDLCnGpv7lj+xeSmBujvRRffsV4Obq83WS0CCXiCoEwSEav5poqFWqE37gLOTiTwamRyDqaazKjH6zfhUpxFKDRGSKYfC6D0Nl9TaFSDppL5bN0mVRN4DZq5yAe2SClvaiLw0Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O4BjREfV; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ffa97d99d6so55741571fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 00:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733213585; x=1733818385; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2919edKa0scKH1VFTPp4m2/Qq3wOxmRVQ7yuQJSD4N0=;
        b=O4BjREfVVVXTSe5ArYQqnCSlBSSLQdVhil3OvX8RF4iZ0bRgfrNQGTcXdkZL2FYNfV
         GFBNNWtzGzEfOybCSOgI+gmmqu5Ovl8D/EjFx4iGDVQYCMPCv3LwJt9V4FjNpicqn+m9
         cTgaPIbKbrFyPW0t7zeFwbw7z7xzs960gj1X5Q0v0t7oge2xj36/VZRmuySHz7NZpjnN
         tRiPSJTx45hr67Y52zJtMqV73s+AilHOnBZJGF1CnjfrQONVok6mh8jjJiZaJlOcLJHv
         06jcGYjaBauFSm3cfMUwvAQKvDFHdnPQnkk2lW2fQKG9FlzsNQsygLh27b3ZwcemBnA/
         b1nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733213585; x=1733818385;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2919edKa0scKH1VFTPp4m2/Qq3wOxmRVQ7yuQJSD4N0=;
        b=rzKaHHqYLI2LWruTaG1YAn6L0EbjKHfqEiHPirGIgiDU45MX2I2uj2id6eEQDXxViJ
         E6Ii1q7bDSXNZBRIk67sUZFC34ZAfycI5OlXdWfLOWLCsWYTJFh73ePQpLDTdWMYVbcj
         ULoiFkMf8LDjDo7LijUKqI94R//AIdTDMJsNgyhOlkslx5HD0tRUdQblqSodeLvbQ+JJ
         sDNRnBOkIXb2EvVmr8o4ltC2vVW7gElilZV5d6ZaR7bGHE9fl5DPFnJeAWWSGD4EUDss
         2FB1MjbbEz5BKaPfEADuFMqgEdN+R3wN1MhZXUv/pJVH+3DeMhBVSoHvNzq21U24psaG
         1c4g==
X-Forwarded-Encrypted: i=1; AJvYcCWMQDBzNe9Cn2aB23j5Xxwbvbww/Omr1EvHa/E+nn4KQ+wyqihbJsLOOovraYwlu4J8e0pAKVRVh72FuPk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy29TdwhhkSxmd/tKQjt3ttkATD8tnFD+pxXU6NtaZ0C5ksR91g
	zKJZp0P158XnSZWPV3adca9d9UKBJ5vflYkt1gkwxR+1BScUSABrCEKVV3etwLk=
X-Gm-Gg: ASbGncs8RrHcK7NOzoJyPS6mq915u3z1qsuTD4SbkAWCtrpdvNDhA9J4cJpIGDnwgbK
	G3gMCYHS76K8ehZex8fP5cGS6OLDrz3CEy414sMegNX/mAaH5SmWI9fbPztlG6mlHhElRppX6UL
	4CRyzW74ysfdEGuLjos9gSRuVNx31MVYr/pSmYc3YA6lPD5zhyhKTBstStVYIzTL5eVynwxOmmy
	pFEz4OQ4oWhk5JbZOCTGTk1KRorkU+aB97YqgVPsNqV0dL5etOsN8dq2iRvLj6Ij57Opb8=
X-Google-Smtp-Source: AGHT+IF96tm1kW0L+6Eafet2kokvnQva3vx6OFst6liTSpf4L4XZltWOm8ICfrYv1DvfjDe/iDx2Pg==
X-Received: by 2002:a05:6512:2810:b0:53d:e76b:5e6e with SMTP id 2adb3069b0e04-53e12a058a2mr876514e87.31.1733213585423;
        Tue, 03 Dec 2024 00:13:05 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa74f2c7sm215212575e9.2.2024.12.03.00.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 00:13:04 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 03 Dec 2024 09:13:00 +0100
Subject: [PATCH v3 2/2] OPP: fix dev_pm_opp_find_bw_*() when bandwidth
 table not initialized
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241203-topic-opp-fix-assert-index-check-v3-2-1d4f6f763138@linaro.org>
References: <20241203-topic-opp-fix-assert-index-check-v3-0-1d4f6f763138@linaro.org>
In-Reply-To: <20241203-topic-opp-fix-assert-index-check-v3-0-1d4f6f763138@linaro.org>
To: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2351;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=GfIxjX3fUAG9xD0E7y4Y7LPGVwA/ovHOoj/JqoQo4b8=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnTr2Ong2+ZytkxIK3MGstGfV86Kj9+CTp9OMCqeeK
 qFhNAI6JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ069jgAKCRB33NvayMhJ0Q+DEA
 CKQjhM+SeZZOaLtTPK/swZ1Re+qNDLT9wUIMuCZzOIjbuuoMQHa6PjyLiDt9KVK/9pmnoCMEPPo6y3
 BPw+JM37Mc+rzES+XO6axgc9gE80c6DpMLIpf00WLnOybpsYMz+OuRX8ElA9bY5Z/PH2cV9UO4sEQs
 wHPxccYfZaPy8hZn/w/OO+49SBfCPV2iTTFtyi3EQQLx97ZB9olfvnZvzND7QbV8Vs+PvDYXridrMl
 zLrnSmivO3ZkThQzBXXekIy9ADKUTGbQCJu3zoHp11zhXZbIZKe6Qy7pnWqgkQmgXjZ7mNnBHppqNd
 vGQDkGW57bl7U/Gfqa/BpVoU1e0BH0UVt78jUpW5k3MZ3/4FwDCQVKEGJWGhrDST9mdU3umhTFHMqR
 yhV2oHDMh771Z9YNP9a/xO3yA2AgDbcdezwRcouR6iTj0N9Vq2N9sKS3OK8B4DMF9EJ1j/U68J3ME1
 tiiLUvsFSQJe9XEnUUMsDm9oN/UG/QNwxcFNjlY3/UbMUZH1zjYDxzhG1/Hhveh0HttP0pUnTddILK
 a2+MUCWrQeibDF0ropeuGdyPAv6MlHfCpqviUjWqoX6553b17u6rm2ncFpWFDUrDVcNn4kdHV5JjW3
 XG43HgIQ+dxFCbvCJsfk6EJR6TDqkZV/AfR6DnKlgCj3r+Pv3X1rFuBBirsQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

If a driver calls dev_pm_opp_find_bw_ceil/floor() the retrieve bandwidth
from the OPP table but the bandwidth table was not created because the
interconnect properties were missing in the OPP consumer node, the
kernel will crash with:

Unable to handle kernel NULL pointer dereference at virtual address 0000000000000004
...
pc : _read_bw+0x8/0x10
lr : _opp_table_find_key+0x9c/0x174
...
Call trace:
  _read_bw+0x8/0x10 (P)
  _opp_table_find_key+0x9c/0x174 (L)
  _find_key+0x98/0x168
  dev_pm_opp_find_bw_ceil+0x50/0x88
...

In order to fix the crash, create an assert function to check
if the bandwidth table was created before trying to get a
bandwidth with _read_bw().

Fixes: add1dc094a74 ("OPP: Use generic key finding helpers for bandwidth key")
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/opp/core.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index ebe7887a27d3c1dd6c652c8bf9f5f9a285d7e74e..137764f2ac7c72585953d0928b6f917fb6f1fe7c 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -116,6 +116,15 @@ static bool assert_clk_index(struct opp_table *opp_table,
 	return opp_table->clk_count > index;
 }
 
+/*
+ * Returns true if bandwidth table is large enough to contain the bandwidth index.
+ */
+static bool assert_bandwidth_index(struct opp_table *opp_table,
+				   unsigned int index)
+{
+	return opp_table->path_count > index;
+}
+
 /**
  * dev_pm_opp_get_bw() - Gets the bandwidth corresponding to an opp
  * @opp:	opp for which bandwidth has to be returned for
@@ -915,7 +924,8 @@ struct dev_pm_opp *dev_pm_opp_find_bw_ceil(struct device *dev, unsigned int *bw,
 	unsigned long temp = *bw;
 	struct dev_pm_opp *opp;
 
-	opp = _find_key_ceil(dev, &temp, index, true, _read_bw, NULL);
+	opp = _find_key_ceil(dev, &temp, index, true, _read_bw,
+			     assert_bandwidth_index);
 	*bw = temp;
 	return opp;
 }
@@ -946,7 +956,8 @@ struct dev_pm_opp *dev_pm_opp_find_bw_floor(struct device *dev,
 	unsigned long temp = *bw;
 	struct dev_pm_opp *opp;
 
-	opp = _find_key_floor(dev, &temp, index, true, _read_bw, NULL);
+	opp = _find_key_floor(dev, &temp, index, true, _read_bw,
+			      assert_bandwidth_index);
 	*bw = temp;
 	return opp;
 }

-- 
2.34.1


