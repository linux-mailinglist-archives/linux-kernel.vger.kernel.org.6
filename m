Return-Path: <linux-kernel+bounces-204044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DDFA8FE34F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 11:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92A0A1C23445
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70686179650;
	Thu,  6 Jun 2024 09:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZS8oHu8U"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44375178CC1;
	Thu,  6 Jun 2024 09:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717667123; cv=none; b=nWnYVy5TTgUPSP7c0oCT+wnrElcLGK3cRSGRZF9Ood7a4zN0aKJ456Xq0dfjyvvdXtfkwrl7MeBco/YPI3e89qqnzGP6cpjPTUiDjOFpIeU7g6Ydo47baeS+3EG0NynlZjpeX2gmqTJa14ehtq5s3W0qQf0kMwO6plgYnW7JMFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717667123; c=relaxed/simple;
	bh=BHKxBsa6XW0c4NSkz2qopssDmmvqtOsiOwQ3mhZwKiQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SagNwa0BTFLxFlEL0HSoi+2GxoIhUn8YYJ/JiBke3Vdg0HkgZl89vYU0nhSdEIO0CO/9/7q7QGEuKBYrHWP/yuJUGf9K+MOq3NflSkhjO0x1dEpcLJ7ZzNE/fpkXMK7Mud2HDHuoIK+zD9qk1QVO5u1hPUJO+SMQ4Dq4CeFhllo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZS8oHu8U; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-35dc04717a1so551871f8f.2;
        Thu, 06 Jun 2024 02:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717667120; x=1718271920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i/abp3c/U8eNKudjyhDdtFs1lZxFEuDv8/SDa8wxnOc=;
        b=ZS8oHu8UCT9koLAzrzQE4ElcTpQ/wZEpoAtE5mYDvhSt/pK7R+ruUD9W5oiyHearm6
         m/1B2ZbjurJaXNh5Ph42rg4V9TlXeYiglLHSr2t49CrqZApt0UePuZBIL1qdKA7snXZA
         qxviHMkAM4I19e1r0Th3BaGBGIsdPthjKpkwrhOPegdsGOTAiNNszVIBktP01lZIget0
         Fxhag+oe6Fd1Ixd+EjABmGUYXhcn3zL4dEKuR5Y9Gie/q4rAnV+LCu6bSvt+ltk8GGz3
         kwmHXGF9tbP53UXBXU8Mk9DlgwkKha9f9FCHbVG+8641RiGtXq1w2ZeaU88Jpj21Uspv
         FKkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717667120; x=1718271920;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i/abp3c/U8eNKudjyhDdtFs1lZxFEuDv8/SDa8wxnOc=;
        b=tA1j1OZliIxDcV4LxaYLx9UMXnrw7jBdp3V2HfI1b+Wd7/VOUSFAeT96w/q3miQUMv
         CMwcqf4xDQ5j53oZm5hipUDGzF2nriOdcdxZldotVhbbb0VS+vDDuIBtL7CRqNPPicRY
         RB1lxfdDrgAwNVv6/5IBSAnlil94mZ9N8JJXp401okwDNC3Zia1YD5VocjDh94yMrksO
         lZPq75nfAh0SrRW/V2OO0hUIaWR6xROILkjEbCacMILZy5OFlXgHOHfcB9reOefotbVX
         zs3yGsb3Mrjk4p5pAEPp3MlEWZjajRVVFx2niWRVcsKipjS2osefWV4B7kfYazaoHY5I
         kv5A==
X-Forwarded-Encrypted: i=1; AJvYcCU01G5jrhu33IqQITesiBHob7Abm6ZVKL67wK3JIlROVMbj6k9ASY7yAb2CPQB0cxU2NQC4Y5AHJTh1gwo5zNRb/K3lDMxezpHiNv4RLcJIvC+OxkOJKCUfSoqDFn4iug21iGMMxjiGwA==
X-Gm-Message-State: AOJu0Yxug4cbJ9YomjlneR8ecEFP0360iq0zQ5F6JazIQauetQoYnFNw
	349aVFZhoLwrscA1bddUWscAqGIRjZncb2WdaIiqSX0P/vJlD6a4hxvsN3dt7fA=
X-Google-Smtp-Source: AGHT+IG745YuhU9aw87AU94dbf4in9m4EmzyV2/eQwRQ89ttaSUzLVoesp8NdrEDNh0TbYWm7kbzjw==
X-Received: by 2002:adf:feca:0:b0:35e:83c0:82cb with SMTP id ffacd0b85a97d-35e929c89e7mr4058570f8f.70.1717667120186;
        Thu, 06 Jun 2024 02:45:20 -0700 (PDT)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ef5d47930sm1094817f8f.29.2024.06.06.02.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 02:45:19 -0700 (PDT)
From: Christian Hewitt <christianshewitt@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 2/3] dt-bindings: arm: amlogic: add support for Dreambox One/Two
Date: Thu,  6 Jun 2024 09:45:12 +0000
Message-Id: <20240606094513.3949323-2-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606094513.3949323-1-christianshewitt@gmail.com>
References: <20240606094513.3949323-1-christianshewitt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dreambox One and Dreambox Two are DVBS/T2 receiver boxes based
on the Amlogic W400 reference board with an S922X chip.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index 77f8dfa86e6a..b39eb17abbba 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -176,6 +176,8 @@ properties:
               - azw,gtking
               - azw,gtking-pro
               - bananapi,bpi-m2s
+              - dream,dreambox-one
+              - dream,dreambox-two
               - hardkernel,odroid-go-ultra
               - hardkernel,odroid-n2
               - hardkernel,odroid-n2l
-- 
2.34.1


