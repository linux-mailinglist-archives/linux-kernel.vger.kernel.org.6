Return-Path: <linux-kernel+bounces-534171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D156A463B9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F5B2173F72
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39CE1224884;
	Wed, 26 Feb 2025 14:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nJn4NZlH"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1CD2236FF
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 14:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740581470; cv=none; b=S/j01NdIegiQphefeqxs/OQXMvvdxyfLlKAVHxfz5GVrl4KxhcHagPkfexqBl5FqdmKtF1S0QjvilmOxEN4mIVkRPLOVyfa/Q3VIPfmLkX+oWokZzAH8eMPsY16r6hJ6SQd6vt2/5dQl2f38qAqjcG8C8+aNwWbfTU2JD6Oz1Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740581470; c=relaxed/simple;
	bh=piZ8Qx7Zly2LRu7vla4X/tFQmM9QLWzUUZoYM5vZihY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fVT/5aHKZzjzhlLGPS18pz40L2myGqoK0n+w6rIMLby29ajjzxh8hCUhfE+U4cYXgiHpDJc/PJxQXH6fbetkPfnfGURBhp6B822iZXssxyCS3EQZ66o+hAIeDa6ccZK1SrbJUGLmKGyO2+yYpcoi2/sILX9SrTm3B+dUeiN6kNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nJn4NZlH; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5ded7cb613eso1321912a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 06:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740581467; x=1741186267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fPL5OtvPOd0OiAnfy72yXUM/L5nYTRUqyQwYMjGIY3I=;
        b=nJn4NZlH/ffOdqXN9qH2kkkxc4CzCN/uTLvpSzOD6xNxgFckwyxBUScL7ey7tH6rSN
         792Xz/uB9h2IU8FLgq4zfrrrjIkxEVpOrpcRkVZuaJAvIki8snyKnvmelehOHnJm6JJF
         81MM8QStl2QJ+oGRds9/91sxXEJb6K7Zq/lyWd2BpXA4eD7EjWJ/AbB9dCUTXYFbqc/j
         0xpBQw5OQq6Yhd9Pf1yD8i1IVX9WdZIpZlRR7WoY4Sgj8BmrMzWVYfodDSE+LmzTe+1/
         XlrxPCnCUQidfprdquLnmrS5hS15BBRqvmyCztt6s8kVBlzXQlJ6JDG5+wVkv0opLdSv
         C7ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740581467; x=1741186267;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fPL5OtvPOd0OiAnfy72yXUM/L5nYTRUqyQwYMjGIY3I=;
        b=QSjdDbsnH8vKCfXRA+6KPlOzxKOhBBlAbGWHT/dWfQq6t8TPpeTwtNb4dgTrV/KEEj
         PTetp+dSk9D2GsXzWZWqQ6sJ+7ug5YhAf3Ns8UN9i1GYRQBC2UO/QzA/0vO2ia++pxHa
         0fa6AKo+0acO1bRuuAR9WpksMdADKEj8KqTE1V/xYa6LxvOPstNjGleeJxw6bvwCVfA4
         etMoytce8Z7NlzIKyUupHCmwNZQf+m/BEAZDb9+7qhjAOu+ygFNvTrac2Pj1fO5mWLGP
         HAcu1UaXDRBaW/roaHrhmrrPS7TM6OGtybCuFyTzpQS8k/ClcquEXcMirTvHi4cajdYd
         1Tng==
X-Forwarded-Encrypted: i=1; AJvYcCW9xQZI8kwyUjfz6qocSf6Kw9VxOpfwiZhbkfxPKC+mU+C3kbXICGKP6wGfI3YWzLMcOQChQ0JB51RjIGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwZRk93zBtRaZgdjwhRMv3S0j0v7OFX4DJfk+tDiTKC7/LfwIU
	34zks2SwipUsM/D8CbROkzSCfwpkE13DFMI7hvwJ7rR8WxTu+ctNQ859skwgIpI=
X-Gm-Gg: ASbGncvGezTGKZDxgt8YHFmbZmAL7D9H0kG0TXng57UY9fdVLIEAdl5RPosvhiC9dPy
	iGoWt2Ty5pfL179Ma31vWT0BYrv+hWpQ+XJ9ivfOUb5hQkjRMtwP31Gd3VXOlzxEWKatZT+IRtb
	6t7crjJ4XcytKmISGzs6sUThVctCixMmcW9tJrPGJEr8UIE1yY6F459N81hiSp+qNUJWgG9EwFd
	g2AF9oa8arAYfFD2oBIGvinC3vGukBDED7Z1qOzKpWXecF9E+TW4OYhNIIrNlpRZxEmXpGgED+w
	WfB0zAq6/vhkVWXN1fv5oOZVdNW6QGiso9F+y1+nHNwGpSNYe9IENc+Cg6GFSWIHJ42A9nsUITI
	5OQ==
X-Google-Smtp-Source: AGHT+IEblvH9C+/IxOlb268xBLoBJ6CHeZV4hc+SEnuQVt9gsMb7Ys0EDvzEpZU/6FgDLvXxyTLMng==
X-Received: by 2002:a17:906:2453:b0:abe:f613:bcff with SMTP id a640c23a62f3a-abef613bd71mr115534566b.0.1740581467102;
        Wed, 26 Feb 2025 06:51:07 -0800 (PST)
Received: from krzk-bin.. (5-226-109-132.static.ip.netia.com.pl. [5.226.109.132])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed2054d9fsm339110866b.147.2025.02.26.06.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 06:51:06 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-remoteproc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2] dt-bindings: remoteproc: qcom,sm6115-pas: Use recommended MBN firmware format in DTS example
Date: Wed, 26 Feb 2025 15:51:03 +0100
Message-ID: <20250226145103.10839-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All Qualcomm firmwares uploaded to linux-firmware are in MBN format,
instead of split MDT.  No functional changes, just correct the DTS
example so people will not rely on unaccepted files.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/remoteproc/qcom,sm6115-pas.yaml         | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sm6115-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sm6115-pas.yaml
index 059cb87b4d6c..eeb6a8aafeb9 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,sm6115-pas.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,sm6115-pas.yaml
@@ -127,7 +127,7 @@ examples:
         clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>;
         clock-names = "xo";
 
-        firmware-name = "qcom/sm6115/adsp.mdt";
+        firmware-name = "qcom/sm6115/adsp.mbn";
 
         interrupts-extended = <&intc GIC_SPI 282 IRQ_TYPE_EDGE_RISING>,
                               <&adsp_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
-- 
2.43.0


