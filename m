Return-Path: <linux-kernel+bounces-561047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B20A60CEF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBC9216F79B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 09:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536221DE4D3;
	Fri, 14 Mar 2025 09:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="sn7xSLH5"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B525D1C84DD
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 09:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741943837; cv=none; b=apfXS79P/BdhkaBw26mm+5u2xSQBpqlhZI86EX+K0nikRNG8Ct8fb+VVJMGyHdAcnJfNY9o8XvxeZfMSChhzWI8QU2AmuA9Y0fhy2DvNgHW0PVKt3qPSNJayoeBAZbyoTBjzU7ZIFJYlE634sA0yXWWOlQ9jwZoeLaFXouqZl/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741943837; c=relaxed/simple;
	bh=KUctck5B55TBuotnv0g4TVm9b/ov5ZebjgiW7exjsQo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TxLmJ4PJi8n3O9GPpLSZ7w4EFnQY0jBQcpO6QfvjlUnrzBO6ZK7dcy0Kjn7j54K6mqwIMDyNCC//J+BhQkKnSardIe7vCgzPWxCJkUHfWSk5xPseZJ+kLwS9U+yunWuLBX2KfAovacL/xyqtWaPzR4Vc8mm8hEmYKSJO8DTg5WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=sn7xSLH5; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ac25d2b2354so328381766b.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 02:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1741943834; x=1742548634; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DduIjgVbqMB+YIwUT9DVdolqDatgrNDkgwKYlFwXCYM=;
        b=sn7xSLH53u/FyO8GYZzU+bXDy6EiauK2H6aQb+V9p7JBxxG4EAA6wooCde0WxQDXaa
         xp1xbHGuAU1x5bTLqESpzj8taA8S7/9VxO+TbGR/tjiv9axNa4IqUmizoyR9smr2SFlC
         k2Q3ESEFgCMgdaeCgzbpVUeOZNqJBXQMyU564+bPoW60/rEyDzicwhcyfW7VKy2spYe/
         V6IJ9l3p/+JBPOLBXM+uhXK0CDjeUQDXQL8W4JkFiW9Wz4+xnlDlLk1DZYnqD2r4QfaS
         8xtV74OHr1xbF1YESBdmDECAzxjorEpjUMCRtmnskNjDMMxO3wMszLJ50okCSYCeTBci
         HiAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741943834; x=1742548634;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DduIjgVbqMB+YIwUT9DVdolqDatgrNDkgwKYlFwXCYM=;
        b=T7z7le4E0I/sdKUEQv3WyPvogIo6Ujkij7X9jgDlDx/Ggf9jT9FtVFbPeu+rGgBzrf
         0DCRJUJbaDXLP3XDIA7lVIwbsAo+ZTc3LN2k8ma6iBugGgx2oVQJmnFLvcES5vwKVsXG
         KjgVol0WXIMSBJLI0XaaCB6xF65Phbb1oXU1VdtlLZlwUc1CZu0TlTntcbpcmheKlCTB
         TkCmO1QpPgYbsbYdhCPJ+Txvx8KH1o0FWoKjb1Sre8srz/qyCLv+3opuCmW750E2dBqT
         osTphcoorFD52pbGKhEsCNVKM9teNvFqOw9PQJjDSFQMJ46yvs+cG2hxG+wdN0/vjzZL
         SITg==
X-Forwarded-Encrypted: i=1; AJvYcCWYxPqxB+Pow2tGbuBbyrmZqHQS+3OcfjKwt+hR/72WBZ5u5HnC8E195WOLjEgZ1MoUu/kOnj9rkr0hKUM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjbWWGeX58lN61hcohKY9jX87KW3ujIIbrVsNcBAphUA3IajLT
	dgoqffcetKKJ2aP7f94rczWqqMy6xzg3x2G0hsiJN3E41qYKmIgOpbfdc2og2QQ=
X-Gm-Gg: ASbGncuQ3TrZpdI/3QWRLOClTSkbbJ36Oe1DUNg9iQoUfVgVtXUftMw7aVahF6GxFFM
	2GFRWWAzxW0f0pH0PL3xtrttYr9PuVCLbLNVzn1rR3ZGWUWfzvBJ4Bjkm5JmtvOMWZiJ7XBi+Jh
	1/b3JkFOXj0lZ50E9vv8lgZ3rnxAU4s7qj5ON6wEwA/9C479XvQQgdiXpOScC20MJeSQYc9Q4uq
	+tsS4ydNi9gMN154ZhRusgw+xgPe2ZCuenLnqVpuycRzukjHUchTm0p2MCSr+Ha4gSx4QAWvBES
	qIqgW+4dwbLsFPzc1/6TgYiOigMqPT9QdrpnlVAxOjQxbIJGH/jNIkNgaKGhtgdiwhXhlos0YYx
	AYxw0M7rEGKUjjNvKTTnumzSqsvwL
X-Google-Smtp-Source: AGHT+IF2fMs8v6rvbwb4avWb30H2q3Lx24BGBU4BTH0RNBEh5rOJldaU2Obk6124KsZ+HU4ZWVHV7w==
X-Received: by 2002:a17:907:7241:b0:ac2:4d65:bd72 with SMTP id a640c23a62f3a-ac330441d57mr197243166b.36.1741943833904;
        Fri, 14 Mar 2025 02:17:13 -0700 (PDT)
Received: from [100.64.0.4] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3146aeadbsm195582166b.29.2025.03.14.02.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 02:17:13 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 14 Mar 2025 10:17:02 +0100
Subject: [PATCH 1/3] arm64: dts: qcom: sm6350: Fix wrong order of
 freq-table-hz for UFS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250314-sm6350-ufs-things-v1-1-3600362cc52c@fairphone.com>
References: <20250314-sm6350-ufs-things-v1-0-3600362cc52c@fairphone.com>
In-Reply-To: <20250314-sm6350-ufs-things-v1-0-3600362cc52c@fairphone.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.2

During upstreaming the order of clocks was adjusted to match the
upstream sort order, but mistakently freq-table-hz wasn't re-ordered
with the new order.

Fix that by moving the entry for the ICE clk to the last place.

Fixes: 5a814af5fc22 ("arm64: dts: qcom: sm6350: Add UFS nodes")
Cc: <stable@vger.kernel.org>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/sm6350.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
index 00ad1d09a19558d9e2bc61f1a81a36d466adc88e..e6df0b7dae8baf39bfa7ff3856759e8cd200f0c8 100644
--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -1177,11 +1177,11 @@ ufs_mem_hc: ufshc@1d84000 {
 				<0 0>,
 				<0 0>,
 				<37500000 150000000>,
-				<75000000 300000000>,
 				<0 0>,
 				<0 0>,
 				<0 0>,
-				<0 0>;
+				<0 0>,
+				<75000000 300000000>;
 
 			status = "disabled";
 		};

-- 
2.48.1


