Return-Path: <linux-kernel+bounces-431003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3BC9E38B9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 12:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C118B30A01
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 10:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864DC1B4136;
	Wed,  4 Dec 2024 10:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UGCkDz1H"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE021B21B8
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 10:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733309822; cv=none; b=R/hk8VjcEJBJ/5mfMIf6asdTxN1W/4SdWMCg1GowSHjc70/LQXIBW7Cqnqj+WqUIKAWgjhMHnzSABsoKj9PgcfgE9vxieE3zT4z2fzJ8EAt2yHz2XJJ6YVvzMgONNCsoTI0avvTYv991HtbnPO/iwJ/TrPhykPcw5q4SlCchIRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733309822; c=relaxed/simple;
	bh=XQw5/dLgHP3wZZRrlANMcPewANzMAEwRZ2FnrRWc/9g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UOSy64gMkC/ePqAUOWjM8hpA+BErh/J9PTFQGiI+yeaRGp4dvZhC7pA/EZXRrwRK4asTQYXTW/1a4aANwB/+9rvzu3BoghZSvn8zkg1+Y/tBYU5eHvgFVmk9qVBU+850Ze+DPkdiJCBbbWbRTOQEdLxKpFDWIZX9v88M8yTE93Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UGCkDz1H; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4349fd77b33so54745105e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 02:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733309819; x=1733914619; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dVLQTYUKgrl6Mzfzc2kyUxFlrszPB/hoyj88gscpRSU=;
        b=UGCkDz1HwIZJcCiH1pVwv6TFGlcWaSU7KW9bbS8l6+b8MS7yNdW5haGxbKNyNeMeDP
         bPwHEtpNX6fC1u1n+vFLl1M1ryVMsZpavGst7wxZauFYOcVXYCqx2xPwxPjk4weV1Jbo
         QM94sDBORPmXg891jQZLBLolwKlHiRPjl7HutCFPxDGJjH2tGU6ZmnOTF6Q0DVrfU15V
         LXgEDEaOQB19mkGGHpiReAZnguyBZLBkuHI1aohrX8bS6eRF+FTOwFAQqtJGuqLXpY8W
         XuX0m/GfEQEyAt7xI3C8K/voUQZE5lkI/rtOjEirzqdLgpLK0jzbR9KEEg8UpRowViDC
         l84w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733309819; x=1733914619;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dVLQTYUKgrl6Mzfzc2kyUxFlrszPB/hoyj88gscpRSU=;
        b=S7AZcSp7oBnMsTNh1m5ATs/LkvFErf3RGAnVM3NXlRqImB7+sPl5k6pdJ1lFfa4yoF
         xsWENAy3jnXq6Qx6pLrJ7jBPu2DsDMbOlvKk0F7CjsTEIIgA6KMiHNWsM98tnirL4Dd/
         ujdrz1II+JmPqckHDyZVCBrm6p1TbBnUaCipWZPMT33lfJvKN8ViXZ7Iqwhut5ZlbbUe
         ohxdbSBowxO5in7Nt+v++emd4AeSOBtu4Tc5bwXh8PGqYNCmpr/b2ir99pdLqE5iuX7y
         ryElyFE56r2wa9vSEwsCcr5IJye9mVjVj1e/tcE88rhqvv93m1/QJSlzrJtqywQOOd5Q
         xKEw==
X-Forwarded-Encrypted: i=1; AJvYcCXJEHJzd9yvmD5mi2Fg2nZ83RHWft/CoSWlX4gaEeDljO2EQ+kwHT7PLFOySoE4qbF0sWxzKjvcsR5vF9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxeZT/IYA0pajkcyKjSc2CAl9ihEnnqmGwai0Ocl9p29NAnjw2
	0teWWEN16QyW7Bn7uIKruRjLT35Qt5yHzggNMlsiq87L6q6H2cC/VzTpIOI6eh8=
X-Gm-Gg: ASbGncveUy1/BBlt27gcbE3JjAnzPN5Y6o9Q4LBstkopupxbUhsUzU70u5nnJApCPDJ
	bbGRZhbzCtk8a5Dvdg5WDoQne9SomscIDxtxkvO60vAZ7m1u1+QpoXU8vBoPIfDYllQA3P49gL7
	ghba9DeU2GGiYXtbvBdaLbvWrMa35VYNZxIVwQPG1ovyasNFPhLuKPSllUMXbthiTkgwjZczTTf
	InzsaOVKTCB1vR+GSEE/KpY+DuF5N0r7JRXwFbPF8XANOpt85qmiVB5S9R64EA7csUUqwo=
X-Google-Smtp-Source: AGHT+IH2VBLl7suLujcTImBcRbwzctJqIbDDlGVXcjBAFkeer/UYeoX+207KER2j/rKNT4KMqjvZDQ==
X-Received: by 2002:a5d:5f8b:0:b0:385:f1f2:13ee with SMTP id ffacd0b85a97d-385fd53ed92mr5410841f8f.46.1733309819225;
        Wed, 04 Dec 2024 02:56:59 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd687c3sm18459063f8f.77.2024.12.04.02.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 02:56:58 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 04 Dec 2024 11:56:54 +0100
Subject: [PATCH 2/5] arm64: dts: qcom: sdm845-db845c-navigation-mezzanine:
 fix ov7251 lane properties
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241204-topic-misc-dt-fixes-v1-2-6d320b6454e6@linaro.org>
References: <20241204-topic-misc-dt-fixes-v1-0-6d320b6454e6@linaro.org>
In-Reply-To: <20241204-topic-misc-dt-fixes-v1-0-6d320b6454e6@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1203;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=XQw5/dLgHP3wZZRrlANMcPewANzMAEwRZ2FnrRWc/9g=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnUDV35JNaPnZnQJCGePoxKWzWV5+CAbqF3def5VT7
 DZraBZOJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ1A1dwAKCRB33NvayMhJ0V11EA
 Ch0naY1JsGSp3rMkV604t2VevF0cVIskJ/W2faLjv3jD8Z7hfsPhbr9W9Q8yN8w7WL8oDh+WFLa3w5
 IEIIXKQDOiJyeh7eqZR7PjVe6Ah3UepXo8ppPJRB8f/Gv8t2fWOjT8B+Bbn3QX8fRDNcuX1y9aiaW0
 RU5ts4yVLm9Z7txLuiEqoPzIrL+cVaHRvn/3n0/y8oytpB0FmUM2QvOhnB3mypkPiHB3XwPRUE5SKQ
 5AJwDn4tQSObdpCzNciaj5yV8cS36TYdMJr4uPqJcjfNSCeZgWu8uGG5URNzv8gh9qI6YQYDvwddif
 hixEE5DtwQ8j9c93v49vS6tL1CkSEwzhAHpMYKZNiVrHmqDUHgtdZ8Ylh8mamMI1qJ61w4jnaNz5Iu
 rELUCV9QJ+SxK7GmkAZEcJ6nXdqntIyYgzQmfKZ7xCo0BtX5xc7+UdHpNPxuXdasMg4tuzIaP7ZKVS
 3AG9VeI/chWNe4/72oiBB0pG2nsFMdE833ZWFeQ0D3K37Vov0fWbqtcQ8eQNUg7BA3g+XDehwxcHvj
 V+FqDFYu28MY8EBPhSA7pumkY5o//bhb64AIbOxAq1al1wbXBXVf6UD6ADnx/x3wJLH7E3zgs5rbcS
 L3VanmpnOmEVYPZsWJD32DCtW16ub9hoL/IEDWRYEv9Namrp2F+8L2uymPdg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Bindings documents data-lanes as a single entry with a separate
clock-lanes property, but DT uses 2 entries in data-lanes.

This would suggest clock-lanes is missing, fix the DT using the
bindings example.

This fixes:
sdm845-db845c-navigation-mezzanine.dtso: camera@60: port:endpoint:data-lanes: [0, 1] is too long
	from schema $id: http://devicetree.org/schemas/media/i2c/ovti,ov7251.yaml#

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845-db845c-navigation-mezzanine.dtso | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c-navigation-mezzanine.dtso b/arch/arm64/boot/dts/qcom/sdm845-db845c-navigation-mezzanine.dtso
index 0a87df806cafc8e726aacc07a772ca478d0ee3df..5a16f4c2b346b314af3d614266e1ca034057e643 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-db845c-navigation-mezzanine.dtso
+++ b/arch/arm64/boot/dts/qcom/sdm845-db845c-navigation-mezzanine.dtso
@@ -115,7 +115,8 @@ camera@60 {
 
 		port {
 			ov7251_ep: endpoint {
-				data-lanes = <0 1>;
+				clock-lanes = <1>;
+				data-lanes = <0>;
 /*				remote-endpoint = <&csiphy3_ep>; */
 			};
 		};

-- 
2.34.1


