Return-Path: <linux-kernel+bounces-527161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A5FA407FB
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 12:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22833425B14
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 11:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6399620B80E;
	Sat, 22 Feb 2025 11:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KKCVrgen"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C542080FB
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 11:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740224351; cv=none; b=SajMTvU9StwEHFGrL+y95czQVrneUIcaxnEjxycZqn3c0rGbxJ+jP0G9vd91RNtshvSxaVW3dV6yPAa45QprNLTgHqcHBSiOfAfgiSyRd8Mb0diy9cetuvXJ3J5+vZGmcNS3P1bmv9qh+PVjPfRcJOIovZPMIMuv8OF2KRmSbtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740224351; c=relaxed/simple;
	bh=Sky15R0RXBLNCxJhjHjePt0w92unXWiCXbaOvxX5Lzo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TZL1qw4ZMFDMUDer2LyqrwXizTgMe0bz9B1NUD85w3q+xWTxuO8kv6UbOdjrg85JH6v7Xm98VVmi3GXNiUggCyOYiT/+hB2wdowHVY6Dd+hKSKdtb1r7+DiFBa+6rynw2fcyc/WOuZS+IXKEeElQ5RsjW5kP1HfvZ0/xizUePPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KKCVrgen; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5deb440675eso522391a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 03:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740224348; x=1740829148; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GciUUqj1RmNWWcZPAfK8/8tZx9TktRuEfZAKKaKTmos=;
        b=KKCVrgenAZy6HIG6tOT357aeBKnDVCsqT4Y8oHEaWgfgPg8K+Lrnx6tl93wUfVofOp
         L9XX7YcIblkkxZb/rVDa1YQPotoalu9yx8dccj/ph1OyK26uMg5lvU46Qg1ImTCpG+Vr
         oXcJRoF4Cvu0FTQ14D5wc4Jo9KuVv1qYpLJw+O0EKpknOicrgJvcDAU7Wu8Kypy/4XZ/
         lJ4gLDKbRifkOWEcHIWcuGLDy7lslEf/ucA0sUftvx7zb1fdwpSE4BgOXd6vcVdvFFQm
         YQg7HRBDKNyvc/9prKQgZjFIF3gAWrrbrcaKkVjIiZ5mz/F3LwGDQ2jAvNct8uHt++z9
         ZYEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740224348; x=1740829148;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GciUUqj1RmNWWcZPAfK8/8tZx9TktRuEfZAKKaKTmos=;
        b=TsjC0E5nZpWPcH4UNAWYVvjYTPOj1DEd25RiavjU7WW28fTRmAdlYWc4EwA38I21Oe
         Ssdrwh0mlnCdJMaGw3GxeyLF5sX+0ZLrzCG4ov2u2Ys23YXqo8Kj1wk3s7E1xBSuF2g4
         1vnE6J6102dp5QL0G0lgCPNeAfOl4AIlWCPCTuJX6CZvEK1kOWDQtDsWfApWOlkJp1Is
         hQoFWu997ZwiKa46m4TKRwR2g7gWfocdZjx3WR4UhBIcT1uOeQmkTrbVOLAGRC4Ww/KC
         0Olj64/CtBTAQl1U4lh8AQoiLxDXeyFVo6TLSFnUiheHrgPLEuECOKPvfNkPRNhWaAG6
         dFhQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+9quo/vBlXTl0uGpyhH4lkULiodxZ7ORcdr+Fcdx5dOcYU5+Z5YuV/ZE33um4zfFGFse1va4+Vgcpcyg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0bPT0vfUUTCTOk73hDIk4e+lDV0+pKxjz+KTe3Q1H9XaOWJC3
	L+BpxcpLVUEEGC9iOYcFcxxaWitfCMuLEbLPb+ka9pySn2sv6euy91EFIqbr/rs=
X-Gm-Gg: ASbGnct8KJDtXfsyNpoktQ4MR6Koea/zagI49xI4ru7dWE5YSoUar9pp3wq0rmacGTI
	gKncmzek6JTZrYbXAp/lHc5I9rXiMFoi4GyUzXzWwNkowVtbjtDcsKtee2e42TNOGLODYTgPsnm
	I+KOssBFfZv8awCiZ7//2DTFVLZV4IVQRGBGbK8Ll/OnrkLx1oaNPcMsbZe78J/0LQhCZA49msz
	PT+TdVT+juOS97836Tewug+UmZOuKT9EJA2Rw/dd02zlhOj//YXFlBjD5FxHWcYpWFaMmBv2fqm
	DgrUWC8LclT9b7jfk1RSqtm2HBuPMMPhH7qX2hlL+buGMVsezVKWyEnYlBo82wZbAGLFGCXDpj9
	7
X-Google-Smtp-Source: AGHT+IG/9B+Bl7UV1RnTVBHCf1VORpcGI7KStjZd+OYFng1yCCZXzpskS3vRcsDqBd9OG8mC4clNlw==
X-Received: by 2002:a05:6402:27cf:b0:5e0:8275:e9dd with SMTP id 4fb4d7f45d1cf-5e0b7252e4fmr2256164a12.10.1740224348212;
        Sat, 22 Feb 2025 03:39:08 -0800 (PST)
Received: from [127.0.1.1] (78-11-220-99.static.ip.netia.com.pl. [78.11.220.99])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb9723a559sm1202702066b.96.2025.02.22.03.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 03:39:07 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sat, 22 Feb 2025 12:38:59 +0100
Subject: [PATCH 3/3] coresight: tpdm: Constify amba_id table
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250222-coresight-const-arm-id-v1-3-69a377cd098b@linaro.org>
References: <20250222-coresight-const-arm-id-v1-0-69a377cd098b@linaro.org>
In-Reply-To: <20250222-coresight-const-arm-id-v1-0-69a377cd098b@linaro.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=906;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=Sky15R0RXBLNCxJhjHjePt0w92unXWiCXbaOvxX5Lzo=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnubdUTnr/bCumbFZ9TWCRWI0l2q73SVxaJlZ4Q
 T6AybTflvGJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ7m3VAAKCRDBN2bmhouD
 1/KhD/0Vl495GI6HdSY/B+vUKWLh2qeBUCi+4tl+EQFNUage6r0m1EuQj8bD8/e9OHQGKohQcJQ
 Vtj10TDMDDESaRn4g0sutiP+Pkg/GSsgE6Pdwjq3kWO3EkG8O/a34PlSacmdnkctsHPKuZUYc4o
 XSUdOwS4Y2KN/q1+hKkgMRa+wtEy/dw+cyMQtGeyi15mudYVggZk9ir5D9IxwQRupbx0pXew2jd
 BdMinRcMHBpBRg2LrJTgdd7kOE5tnbZwxr8kgLrUv/Lik0QnXpG60GcwK+eBi5g2BSp2nBWJQ5X
 fTuF/a8MMirtihZQdJzaHuuSgKxgME7+XAIDroK56Idw8LTaxKB1VLX+jMakoq/grb2Srtquv98
 Un9YktybZuHoCs9AJeHvPOqiF73E5NzG1dO6+UHrxRk2P6NN51wlFoXsKFvMISkG1Qtfh6UUcwE
 ssJBuJS1AgiG5HRzE4qntaZiGb/XhD9w9/9H+KBJ8NVEIefy1ioiaUrUhrCYi7ra7xohus7R0kC
 +yOSQaLFsNRCJmfNRaCNrB2lng+TXSS90STPdeA83E9IEN0d25sMOecQmPzjBOmYVedCrVAtIVM
 DbIJS9o7UgyGyt/29ArXpBBez9cTAQSslWoxzji7AZOW9dK7lF1Co0ZVGuwnP/0SILTFRuHBNGc
 Ila9TBdtA/uS7fw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

'struct amba_id' table is not modified so can be changed to const for
more safety.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/hwtracing/coresight/coresight-tpdm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
index c38f9701665e70c0fb58726980332dbe65e09790..afc4c18dd35d0ab1cc474214b1df6f816e1aed68 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.c
+++ b/drivers/hwtracing/coresight/coresight-tpdm.c
@@ -1305,7 +1305,7 @@ static void tpdm_remove(struct amba_device *adev)
  * Different TPDM has different periph id.
  * The difference is 0-7 bits' value. So ignore 0-7 bits.
  */
-static struct amba_id tpdm_ids[] = {
+static const struct amba_id tpdm_ids[] = {
 	{
 		.id	= 0x001f0e00,
 		.mask	= 0x00ffff00,

-- 
2.43.0


