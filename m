Return-Path: <linux-kernel+bounces-553179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C81A5852A
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 15:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DCBC7A1F56
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 14:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFDA31F4C9B;
	Sun,  9 Mar 2025 14:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xvGwBYEz"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838F71DE88C
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 14:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741532269; cv=none; b=jSSVTsc5g6h8YLqRJ1PQuqOdF4Sh+yvE1TFwfGOxTx8Yx2jrnOZpYD4navZxIlIhd5KNzJTZSfbbvJ2XfOFzW7o7QYkxGgjYcppo/u7yEso3QZuwyrdPYT7RcLJYvtf85VtQ+F4BzZYdBjYAWvQyVuwTonPDu3fYoL6rgUK2Raw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741532269; c=relaxed/simple;
	bh=nu94xce3hyuD6l8b5q4Pb8Eh8vp9Z2NiKH6joMYQjlo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ltRMrlzVnPKScBCaEqriKaMDYaw8wdIlhmQ2jA60S3hnL716BOgVvEDlKnBOGkICb8sr3ZSaQiJjfURa/wzKy12pB+LAivX2E25LFt7t1EF2YqCrV9cKggIlQANAgYqjE1b+IedVv3ac44iBcMMXlslJKy/4GVWQmzRgC5J/4Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xvGwBYEz; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3913cf69784so1170588f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Mar 2025 07:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741532266; x=1742137066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o4ophriFopD1iIs2XtFpF4lW4o87XIA47+/GjWwD8Ak=;
        b=xvGwBYEzfTMlSEh/znkusQkijcQDQQSOG55lWrma+TKw4sqFqNL/E6i+4SfXuQ2BGR
         ZuY5iFrade1aLCFPPzPLYXqa9SmqWTxLGCaNbCBcpp9P9PEKNFQqI6jXp53cLOAVztiA
         QRJhHeyF7vwOIXRsg17fMElMijFbUNbk8bpqtPHtzY6EDm10Q5CPlt8y4gQkPJZwX4W5
         A09a4KbEYwZYQ2FG2Kzh55gorzpkX7+c50ZcFbxXQbzgyBrElkD9Zos3khu/7200kPdn
         NL/o0Eo3g+LRingq1qjyXXqZOWF6AADAC5Y5bcnI+HmYKcnkamdpDZhHFVyPxHVIGSLW
         aIgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741532266; x=1742137066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o4ophriFopD1iIs2XtFpF4lW4o87XIA47+/GjWwD8Ak=;
        b=qZ4ytvFfyECTMPhvzPkXET+tSXZegtsZt6m2LkF2MJYJEn+3gEQSOby8UU2Lssq74B
         xQ6iIolwZjEtYmziX2Ee9TT5DuuYrva08lx7LbnP8ldU2l3hf4Wg2ff2m4U2DM7Woffg
         4JWsf82v3WiW+DEOWzmnfayz9eyoKBzpgUnVWuSV+DV+WbVXCHbTVK3kEeotV2h8rnc1
         rgEe9CgNuPCCZ/gjwUjwgroUGXQa3sVCc5vEMTlpkSVX1o5jnj0RM8V2uuNZKPQ9GnBL
         n2HZp2uKyRuCk2M37gfLJJSEmlKSPipkeRlFKzOM3bVEz5ZiVhXiUIimo/L5BNJ8fLW7
         PGaQ==
X-Gm-Message-State: AOJu0YzrO3UxScQca/mKfvGXN/7ZgGzSAnHs5jTMezICpqU1an4G2knX
	mk/fwPl3vmI51etLbLr0btJqx0cFX14vvSSxCsKZLlCYK+YbCAJZ46s/cMQ0twQ=
X-Gm-Gg: ASbGncsc1i/d4Ml5sY/mTu1oZPgiRNj8hdA9LA2mc1k/lo0EoGIl7YyBYvvAolCbHAS
	hhhIgWW9AAlLySXE9khpmmHcbP+GXbRdU7qU72qSsen6Ch1UPAiCHUNNvXLJtfN1qlWvdLIm9Q/
	MJ2DhfbkROIP9hocqi/yLuoylFIwKiZYRQP2r70dyNZXv4swMEipDge06dCLRtFtSTkPw8ZgKRw
	+jWjGzREZFjX5LiB9lz8BmWkIF0PhVu7OB4GV+paCraFDAzpfS4RCbAjsk9G4df/GhsihXkEp4q
	UPR2Um94m+AS7fhYMwONNGcBovjD8nxkOKDgYDWYFkosuxjRRMrXPt42CqTKf2ck2rE02w==
X-Google-Smtp-Source: AGHT+IHdUw43gnANMNo/sLb9hEYI+SOQrnOJ+XTqpU8TbhPfMhojR86Kz7MP8L/xi7ak18twOVQa7g==
X-Received: by 2002:a05:6000:1849:b0:391:158f:3d59 with SMTP id ffacd0b85a97d-39132d21141mr8714408f8f.15.1741532265904;
        Sun, 09 Mar 2025 07:57:45 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c1031fdsm11744899f8f.89.2025.03.09.07.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 07:57:45 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Sricharan Ramabadhran <quic_srichara@quicinc.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	George Moussalem <george.moussalem@outlook.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 12/13] dt-bindings: nvmem: Add compatible for IPQ5018
Date: Sun,  9 Mar 2025 14:57:02 +0000
Message-Id: <20250309145703.12974-13-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250309145703.12974-1-srinivas.kandagatla@linaro.org>
References: <20250309145703.12974-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=980; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=7KrYFwn+zoxtcS7p7RKNnXyTkthKyH04diDTbjPiXp8=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBnzaw6uqkrbBFgImiw9ZOyRPVqD40fnJhoJoaXj 5/P1pke5OaJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZ82sOgAKCRB6of1ZxzRV NwpYB/9/TQgEQ/TCmItGWo+XZYwLe3Z3VNDouc7IGE2aMz4j2L+mOhOatF19yGJil8QtZ/SIpzc maql57pdjEGZG/6pjFXqw4d7Sd0hOfFTkb+ZG1NcAEPFxNTm5bbAqauDuxp0cAaQybnPDl9d5+N Xzvgo80fK7kpY+kRXc8pa9CsTtH9ep7C/2rrcpSJzwQhK9MYLBo8RT08bPkv1mJwRoulyobzMZn hUHehRsu6tXbBJt+NCJbqlIK4WQQ7Il/3dniXYmW9gsjSXcB8tjaHdHMyk058QnWVn2YxsHOb0s Kuhxk4ETzHlEvCdFiUZUettAJXcf8D/2clAANv1fThVJC9N/
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Sricharan Ramabadhran <quic_srichara@quicinc.com>

Document the QFPROM block found on IPQ5018

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
Signed-off-by: George Moussalem <george.moussalem@outlook.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
index a9de635bf31e..69e3669f8178 100644
--- a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
+++ b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
@@ -19,6 +19,7 @@ properties:
       - enum:
           - qcom,apq8064-qfprom
           - qcom,apq8084-qfprom
+          - qcom,ipq5018-qfprom
           - qcom,ipq5332-qfprom
           - qcom,ipq5424-qfprom
           - qcom,ipq6018-qfprom
-- 
2.25.1


