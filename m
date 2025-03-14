Return-Path: <linux-kernel+bounces-560943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD7AA60B46
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 09:24:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCEBA189BB9B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 08:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1F219CD0E;
	Fri, 14 Mar 2025 08:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="urM8dhWs"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A8E1946AA
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 08:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741940677; cv=none; b=TAZyUGASuoBFMUClkX39lUlSjDv1MTTYlm5KNx/OZmJj6e5syCH9Um8dSOzbHv0OXXbJRW0VDpTl5z3KC+RiOkEVsostg0AkRQBmBYXOpaTM8MtQ6ZbUEYscOeHukhdPk+YoCC9CZsmaOIT7YRSB4wsjD74x0ou7xrTGzb8QQnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741940677; c=relaxed/simple;
	bh=w97u6BXDdV//+jswswofrPD9VxViQ2Pn0svg6KRTA6E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Eve8VWa2pW18iedDepcvwuI4RHEM1y1Yt5P/u5FsWX4X7Jx+ZwQSRlDY5Wj+Ln47zrXFRe+Eh+Smr42/ZxJkhve8WTY3QxjUk3zxx9UC82581EOoy6bNWMTTWDpGNA/qL/QJXO/weXj7frePXn8tWCDOF37EAmDLZ8P+bYvCYuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=urM8dhWs; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ac2bfcd2a66so314192766b.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 01:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1741940674; x=1742545474; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ywEbrJtSFC2AqYUcKXRGNHqBvY9/O6csNZBNXCU4/xs=;
        b=urM8dhWs5Y7oLcYQvV6dZx3UhUExNrSuJDeoQJufypl9eYw4jWCypSsOmzdfE83w9Y
         lpftxzCo73kh/iXTa0QDlPDHx3rwnOh8PtKmLcS/t0ygyDNPgBszsxbSUd+twIGcgW0H
         1tKob9Ic/oSHGgI7eedII5ltBV2Qd5BNujIBvLU23BqzGzEia1gDH+s6Hf7aBfDiYRd+
         g1QfojjvqmBE4B66f6BNUu/8pguo/RMd7URx2BkIEwq/Vbq+mudQFGnNrd66WmPBJoDL
         ORKi4Rj2aUtcKcFBBIlnvLJFSNy8b2uj95AS1NpJTcYsI49CKBPvidw/VMhq4l5qqlQi
         o/Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741940674; x=1742545474;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ywEbrJtSFC2AqYUcKXRGNHqBvY9/O6csNZBNXCU4/xs=;
        b=ICI+FD/YRVkcfr2xnqiKivd3fN10AB8NabZG43k8OQyP9mWeYfkm++AeRU2AQ/F3b2
         P56sei5aIcnsYT4ZYl2bu8mr4089GkS4TxwhwVcL73LpbU1BlSD4sJ6TcbkeICNEwrGG
         BFl3wwhsGqBJUmunZrHMyw0h7jCO/O2C+Bev4qc/ShSHjsyNy1pEDfG73oOFBDgsEDlG
         VGXI3nz+oQQ4o+RrpFiKqM4KC/Ll2J2ykyGgqi/aaFod0Fy2+4dYT/Icad9H0tOs3tzZ
         qQOt/yGggi03sai3KJFhXT3ZuiYIH7s9/zJP/GoHY+Vo+IxLlg/bkFRfmmdFOXyhP/UB
         uzCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxVMSBAor2PLpWZouTOtdLam2pLgbUgR8sPGnLtRtgXilWKylKIgOMlzQN+Gc2Dv1MwoBTln8O3BopxrI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2832p/zKi2IdMLgV/LCP4fqcy1d5o5VO09+lnqD0ln01ZMDMt
	grHvNK7aNGRM3gApFigg03v/QtuVhrSpUINPax3AldSYBp0NQfLLG6eAVAlHvt0=
X-Gm-Gg: ASbGncsDZp0ZQvwiuY3dH167xj33qOfazICaamBEjAemTHxiYLIJmI4OTHLsx/aYwK9
	XC6HCJtMJUhAKNspih2PbWCQMjS0m5E4CcVaQXysoNViAWLY+39bos0BqVfqNnJ8g0hg9Vhg7Ec
	uCL6A18gIF7JtIYCtxbfseBAqIj/rUSqBJiCvV03V2u2GbEOhd759iGuz/dVg233ueDjL4ZQRGZ
	hv2ypUHfxun/EI4Xx+1QzkMlswHV0IE3WvkTGntmEpjIlf4VOKJ077RbwWoDDo+T+ErzXiIqmo/
	+w85ZO13+FleaaMZ7ZpQnlXYKazaGWz7a/afEASEiaAPgVJJ0Abb6/lkv8dKhkWlk8aAb5n6PrH
	6og3AK1SCyRnCKdPNgQ==
X-Google-Smtp-Source: AGHT+IGTscR7BYFU80Pa4ZMB91BZEbz1XZF1lYz6b8n9RlCmwKKPrDiAzrx8K9+FPXXto+nTQ+ePIg==
X-Received: by 2002:a17:907:3d8c:b0:ac2:806e:bb51 with SMTP id a640c23a62f3a-ac33017d768mr166849366b.18.1741940673584;
        Fri, 14 Mar 2025 01:24:33 -0700 (PDT)
Received: from [100.64.0.4] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac314aa6499sm188846866b.183.2025.03.14.01.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 01:24:33 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 14 Mar 2025 09:24:31 +0100
Subject: [PATCH] remoteproc: qcom: pas: add minidump_id to SC7280 WPSS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250314-sc7280-wpss-minidump-v1-1-d869d53fd432@fairphone.com>
X-B4-Tracking: v=1; b=H4sIAL7n02cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDY0MT3eJkcyMLA93yguJi3dzMvMyU0twCXSMTSxOzxBRjc7NkIyWg1oK
 i1LTMCrCx0bG1tQAU0eCZZgAAAA==
X-Change-ID: 20250314-sc7280-wpss-minidump-24946ad376c2
To: Bjorn Andersson <andersson@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2

Add the minidump ID to the wpss resources, based on msm-5.4 devicetree.

Fixes: 300ed425dfa9 ("remoteproc: qcom_q6v5_pas: Add SC7280 ADSP, CDSP & WPSS")
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/remoteproc/qcom_q6v5_pas.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index 97c4bdd9222a8d5324fa3655019e2818f4fd95f1..a78d4292a05c70ccc7ad0b46e641ef45253ad8e6 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -1348,6 +1348,7 @@ static const struct adsp_data sc7280_wpss_resource = {
 	.crash_reason_smem = 626,
 	.firmware_name = "wpss.mdt",
 	.pas_id = 6,
+	.minidump_id = 4,
 	.auto_boot = false,
 	.proxy_pd_names = (char*[]){
 		"cx",

---
base-commit: eea255893718268e1ab852fb52f70c613d109b99
change-id: 20250314-sc7280-wpss-minidump-24946ad376c2

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>


