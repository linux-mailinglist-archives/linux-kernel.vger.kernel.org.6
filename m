Return-Path: <linux-kernel+bounces-518056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74420A38934
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 17:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B3EA16947E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 16:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF8E2253F6;
	Mon, 17 Feb 2025 16:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iiDU8xY1"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0A02253F7
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 16:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739810010; cv=none; b=epbteawba+YbO1voj6uN6CyMCLlGBiFESYiBN/qcm6uHQlsA5/fodvkIGQzsvBlqvjlpoIIubFh6gb995keMz0EoXcffFaLmz8A3+3TNphvR+tMSjTkMRjN99ySiWrWt7P067wpE+X9cNjD6jsbA1TDZPbIiIGzeVpMfssbzrnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739810010; c=relaxed/simple;
	bh=zhDVJvHjB5Lzuhnk6MLMvE1kAvmruLGrFv1o/of7giQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aaHT0dWfeFNtf5qZWg57dq7Ik+7Zk74ijOFyurZ3uxJ6zZE4rsYP/t+AviIEoxFILFrbQ6+ryQd8eg6FsnPppdrCz1wz9+3HeTtABVcA/SvHS9HsHVlZnV1ysm/mj3Cf3I/K9F7pjf6XAih2qVftCBbUEx8z21Pav/XnDHJcQGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iiDU8xY1; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30a29f4bd43so14257611fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 08:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739810006; x=1740414806; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zTk1JOhDFyU+6z9JRqVi4gh1NwvHjNu6gaxKn+V6LLc=;
        b=iiDU8xY1FgsqeFI4W+dqes3xnGgFaLSElW4iip+R97pYPVNyT8TqJnaM+qtti0W1CB
         VZBWVlsHP9LyVoB3HKajjMycFoBNhJ//aaA5hWBdx37fWd+rz4mzkNoihLVZSbncCzqf
         EAf6meAlL0VmK7+3eCZGQqubQX1mshHKFGSrILMnhb0EDsWFLq615PFZEDZtxQQCoTjc
         QCKN6tpBDgi7wWIxwjjalpTq89kHRIn8H9kmBTRmSTQpSckLiQ6jxiKA7u+lyi5ULca4
         e2ZmPjciRd85Ebix68cDY7fRO9BHPqNFjyoG5KbpwcLexoydfyGXmtwaq77B6D22bzGJ
         /AUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739810006; x=1740414806;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zTk1JOhDFyU+6z9JRqVi4gh1NwvHjNu6gaxKn+V6LLc=;
        b=q01MQ0CnQq4SRONjiSpwKs76Zn0MLCUFhSFERWyrGKN+6urQ09RtsvQxmfgXI+rgPv
         dGmV8TLFdVlaPeePeHMFrQh1wq1xscOABSAmC87v3EEQC6HTx9KLlF2ELKLjIa6jUxWC
         jKBQjwrxadt1HdUfSeIf7nXZhBn0CLG8k1Nj002xAhSc2+rKpFIJ8PceKCPsZ0xTUZ0n
         6hm+t5RX59EzBPdYJFYEClBVrRVHPwWbw7wEaN6HL2Gy6B1Xg8KA3ywUrtQl0AeWZ2jR
         GSKuHAc18Uq6yTltOnEO9E0nTgygvyaSdIalttPX8It4d3XEXTDWioS7KQG0t5g0VJDw
         CKTQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5phHyWBGcgQUSGD+B5usj21gf81R/oZ2hCs0ATkLtKH7ECBbMzimpJUbnhoHDPqY0jPboc85CFbr8V+4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5wttq9z9XYc22P+Zoco5ng5PT1CQMddJlkjkKCt1M7UXmdzh3
	6QOcHJhrppe3vdTAfnNtXrQSARGhnrlJ6DXcSiqELkzEVCShf8A0dCsanA8qvd0=
X-Gm-Gg: ASbGncszPPEzj2M23eS/fAQXU309GMIvpddcfQGa3xy35v5rv1oysyObdQ+NzBjqrYs
	2bSGZnLNIESzhzMNc6D/4KpEhpB2GMoOV2XGjd0bZpwrZFeTZ7wt5vkwMNWcVYCSnruHLgLrAvf
	Z96xIfHRg5G0A/xNFk6Uf7K6EaRNQZDF16YLoE8yUpuH/sHQN3XM6dX1+kWrD4zHzor8nwRZEMp
	xbgQg2CI3IqHAuSjB4mYaQZl6zsiJAktBTLxnmGaAz2tTWH49scuzv8XwCNRLflIC2/WOvRwRut
	ZcL8nGRIwGatHNu0+dMylgnNBe+E/L5H8sVrr0oVploKKU0Fek2D3U04ngc=
X-Google-Smtp-Source: AGHT+IGzI4BEq8iQ8ebMwalu59c1aO+y/rKFu+C3kD7LqJ5UE6HVzDUxUsXxpYOyGfa6H+jPNWIXDQ==
X-Received: by 2002:a2e:9ad6:0:b0:308:e9ae:b5b3 with SMTP id 38308e7fff4ca-30927a2de98mr27830941fa.1.1739810006210;
        Mon, 17 Feb 2025 08:33:26 -0800 (PST)
Received: from [127.0.1.1] (2001-14ba-a0c3-3a00--782.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::782])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30a2cef18d1sm5695991fa.76.2025.02.17.08.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 08:33:25 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 17 Feb 2025 18:33:18 +0200
Subject: [PATCH v5 1/5] dt-bindings: nvmem: fixed-cell: increase bits start
 value to 31
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250217-sar2130p-nvmem-v5-1-2f01049d1eea@linaro.org>
References: <20250217-sar2130p-nvmem-v5-0-2f01049d1eea@linaro.org>
In-Reply-To: <20250217-sar2130p-nvmem-v5-0-2f01049d1eea@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>
Cc: Akhil P Oommen <quic_akhilpo@quicinc.com>, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1110;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=zhDVJvHjB5Lzuhnk6MLMvE1kAvmruLGrFv1o/of7giQ=;
 b=owEBbQKS/ZANAwAKARTbcu2+gGW4AcsmYgBns2TQfC4FtXqBdUxy1mAiGozMMqn5scy5wXUU8
 MOU6EDgxoCJAjMEAAEKAB0WIQRdB85SOKWMgfgVe+4U23LtvoBluAUCZ7Nk0AAKCRAU23LtvoBl
 uF0iEACudRVZ6tx6aH1ir2ml/AYJM9XCw5Qet5H7mXsmcis7xR2iVsfGOH6VGoOLbnSDAKUp/3P
 39wzkVXSptHiyxFHWaFqNKKJ0yjdWeh7DnPsI72+kmg8pTYKKuqzTpz2YdgbAPJhUHirHX9G9Be
 3UafGfWFiyPIH1wLiWaGfcY2n86VyHBwHx7WZb7+bvnBFLN6BeoKsmhqD5AMFDA0zbNaoPOXX2/
 T1PskCjspTRWUBp6ZjU44coFzodswxmoT8wOgXLe0Kbfj2pYMm6UMqNJ6vIEqcceFD2GbWOMruX
 rA2Bb0xr9cC1YIYWl1r8kFXI/2dmnDoA9GrKjHvwj//Vxc13+hjorWayBRroLbF4J8kDakUlOHY
 EI8ZbUdQteaI2XLUX80dyDlaaTe5rNfWUx4F3iE4/sgeHBKXrt+e0IObiuffg62+7rgi9UwBP1F
 KWrjvv4zBYHElX2ZxAEUBP8v+SVPCn4ExYila5NNxalA+Cbsr7tpTIBjgSeFSCBZ+orRNYp7V/L
 rvyIaJwqWBws7+5euGB1yT+Nl7oSSsXLRUl0cMNLFAvTvEyTkAc0I8zJ8fHFvvX2rW/qu47v45X
 7DnMMHbC7tGw3LiuEOzeTzwAW5oHZKGV7vHxFKFJ1bHNnngKEhnb/bSvYLIkHkTz5WDj5EKWqlN
 LJapm1xwV8ebRew==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

If NVMEM uses a data stride bigger than a byte, the starting bit of the
cell might be bigger than a byte (e.g. if the data comes in the second
byte of the 4-byte word). Allow the staring bit to be 8 or greater to
reflect such usecases.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 Documentation/devicetree/bindings/nvmem/layouts/fixed-cell.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/nvmem/layouts/fixed-cell.yaml b/Documentation/devicetree/bindings/nvmem/layouts/fixed-cell.yaml
index 8b3826243dddfcf9c9bea531541c55d3fc04a3bf..38e3ad50ff4fb6200023f22b4c70c506349142df 100644
--- a/Documentation/devicetree/bindings/nvmem/layouts/fixed-cell.yaml
+++ b/Documentation/devicetree/bindings/nvmem/layouts/fixed-cell.yaml
@@ -27,7 +27,7 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint32-array
     items:
       - minimum: 0
-        maximum: 7
+        maximum: 31
         description:
           Offset in bit within the address range specified by reg.
       - minimum: 1

-- 
2.39.5


