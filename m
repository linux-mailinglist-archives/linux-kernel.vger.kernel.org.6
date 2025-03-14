Return-Path: <linux-kernel+bounces-561049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B17A60CFA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0897816E7D3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 09:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05BD01DE4C1;
	Fri, 14 Mar 2025 09:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="sAEJ9drg"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C843E1EE7B3
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 09:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741943840; cv=none; b=YLW7RwXAUgnO2kKq4YdwJoi1M8QTRAGwxJwqCfHSCrY12JYJoSz3cZD6JTNOn2Y0CWzTTeqKfFz+nZgsax/+/00tyXDdOonNTjGblnJ3ersWvx4yVQZRJe6yT/Hcj7yyd22ekWztGRYtSX9jsajzPE09jaI189WS0jddtkZGcpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741943840; c=relaxed/simple;
	bh=TQql/7bvMiWWTcBiokJKn28h+W+qXYbOIZNvdiAC8+g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=thxu67FOiGfLyTb4XD6DPuuUtIJzKppHkvIQjsbq0FK+3CqQvxn+OamWgFzwA+rfFAo/fUlMuwHYc8lo1kUNcglXiGf7NR/YZOWrXbatHIUxf8p87CpzPrDqF6LPgI5itvYaOBzY/fNdd4AfxorRiHZH3jCDGjS7/YoYMwIx/hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=sAEJ9drg; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ac2a81e41e3so410414766b.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 02:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1741943836; x=1742548636; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0EnUUGo2HHQ13RN1/OtPiMt5tSoeJymaCLmfHSf2tq8=;
        b=sAEJ9drgHr3+wBROICba5S4zJQg7ZAo5X311awjDLWBZqkJ9xirCzZjA5gdnNP6/+P
         UQtsEDta5CT3KR9OtozNCTvlAeTbGMVZPh8U5u+BZoe2P4r86KNnzjKADf8O8hcBPbLE
         VTOT10nm/AHDuqa/DNuwBjBYkt5YRjONTvWO9UNkvMmBqZ0iErAnYqobv9AfMdP427FF
         RacKPpMYj4Lx6T8sEMBU4dTaDdLpKuKwbuaB+cSs4xxcsHRxL6asOBMvwWmU8///r0sI
         nJw7GAVLMkJmW4kph4nx/e3N1IjX4yZ/mOXqcp9L7gjbA1+03T/hhML2zQDEWTwNPuEF
         52uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741943836; x=1742548636;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0EnUUGo2HHQ13RN1/OtPiMt5tSoeJymaCLmfHSf2tq8=;
        b=j3K8MLuhMazZZ4zK3DEORC60qdaP3ngzS/ukAL7BpMusRXjlKGcJk3v2Wr+GwSxCQq
         6pglwUHmcGzrJu5AIlBlxDhYheHAWjdaMrXnQpUNUZ1mhohXwWxcjDCQ1maAB6OOU5gI
         w7zDqzXo5A1RnbwFb1YmK2RGfYZbzyaoo/FOG4dJN6AyBqPaX0mZiHumkYxv+ujcBGAW
         pWH+8P8YObu6buHhLbD5YHQbxHh3/UgfDI9IyMm0clsVMqoAP+s9OqiPklIGfhIuwqPL
         hsFSC9FoefS+LwmptdO7/K+Hiemgcj3i7a5PuLqE3s/Qn3vlPK9SrR9gFCKwBNiSUc1o
         3wtA==
X-Forwarded-Encrypted: i=1; AJvYcCVSaVmHMGgYmU1RwwhkOldbC6eNbzSmorXUOCu4cktW8ZBsAkhGWCSSF2wkI1LNHx1GSK7ueWXLE3aPlIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9xpfV3AsE1BUVpqllDp5zy7sC9UKTVsXWsjyNuNlSlWxD1Z3H
	ZTobZJLUKhKB/bRsB4WKWWQY1bbV4MWB3yVQKwQ6h1fh20JUKyMBziU5O6afN+g=
X-Gm-Gg: ASbGnctZDg/4Q3KJdtOTzcz7AKM0o3ToJcxgEpCSIuTdchet9fQnzFip9lOAH6KnxpC
	7T3T7b44mCPCb7Mmy8EjWgvX0j2pcRCHZJGPSbkbnlDE5yct37Rno6dVrwI6jrCUfnkqFfwPUvU
	JrjfNMNQUmu4bSQBOL61dv3YRiysV8vqFZoIccequBW7wKYzKkNrBhDeX5uxcPjfDwlGFrYeWX/
	l9iWuvSYkgfeWTFbHCdgdjcutbNeODEjUKcAQtCHzdKy3RiWqn1/YEulY3zKwgtgWSt0PKnJjiw
	ob0l0dySKzw2ttH9SXkrEVId8PGryyMjLSqVR9fNY/BUUmu6WwgRskGIMtNfnhdLHFAc0vpB3Gs
	FrJxYAsHlsm6Q2MD+HByKVCHn/i7F
X-Google-Smtp-Source: AGHT+IGROEW2AOW+QYcjTEvqRULVelQ6EYGyR5ofJR2GdD8rWy92xsCBu/twsCMr/ZtxcA4CpFpYHQ==
X-Received: by 2002:a17:906:730b:b0:aa6:b63a:4521 with SMTP id a640c23a62f3a-ac33018ef75mr189422566b.15.1741943836163;
        Fri, 14 Mar 2025 02:17:16 -0700 (PDT)
Received: from [100.64.0.4] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3146aeadbsm195582166b.29.2025.03.14.02.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 02:17:15 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 14 Mar 2025 10:17:04 +0100
Subject: [PATCH 3/3] arm64: dts: qcom: sm6350: Add interconnect support to
 UFS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250314-sm6350-ufs-things-v1-3-3600362cc52c@fairphone.com>
References: <20250314-sm6350-ufs-things-v1-0-3600362cc52c@fairphone.com>
In-Reply-To: <20250314-sm6350-ufs-things-v1-0-3600362cc52c@fairphone.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2

Define the two NoC paths used by UFS: ufs-ddr and cpu-ufs.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/sm6350.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
index 77ca8990c7a096f40aab5666da9f69465f59b71e..b26ee8cf66a3f53b6068efdd05ab4347fb175c61 100644
--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -1175,6 +1175,13 @@ ufs_mem_hc: ufshc@1d84000 {
 
 			operating-points-v2 = <&ufs_opp_table>;
 
+			interconnects = <&aggre1_noc MASTER_UFS_MEM QCOM_ICC_TAG_ALWAYS
+					 &clk_virt SLAVE_EBI_CH0 QCOM_ICC_TAG_ALWAYS>,
+					<&gem_noc MASTER_AMPSS_M0 QCOM_ICC_TAG_ACTIVE_ONLY
+					 &config_noc SLAVE_UFS_MEM_CFG QCOM_ICC_TAG_ACTIVE_ONLY>;
+			interconnect-names = "ufs-ddr",
+					     "cpu-ufs";
+
 			status = "disabled";
 
 			ufs_opp_table: opp-table {

-- 
2.48.1


