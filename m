Return-Path: <linux-kernel+bounces-414341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 164A89D26AA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 14:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D7D7B3349D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 13:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44041CEEAF;
	Tue, 19 Nov 2024 13:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lN1Hr222"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB63D1CDA31
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 13:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732021842; cv=none; b=SsvZHZyd4RQxGPJ7xCOmL+IlQsod5hSlw+l2Y1ZgkssgNn6AqMN7yyoyvJEEG+vmlDQ/6FVS3f5dWImwNKb/WK0UbEDftd/G+pu7bL4gTliP64q1/Lpa7YUJ5Z1ANLjjjoSMZJiM1j/w28gLJ4aIWBj6nC09B9Isk3v0jZCE1jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732021842; c=relaxed/simple;
	bh=mDcY5C/zkyEjWvX86BTuV7N14ueWFOUTtJyzCAK1OyU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RvUHB7NifhWvrEOs8/ykKMq9nd7FqbZHB53eM521xFNJLNzFI715eAssYCCVI8hM37GfZ1G4RCxRIPC9HB1Y8//V8r06BMQzGQ1Wt8W4QU/DHM0kYb78LIw2POdfZaE3ugUW6RCu8VgJSMTYOj91vmLwC4ydJkRhHVWtFNjtV4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lN1Hr222; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53da5a27771so3767701e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 05:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732021838; x=1732626638; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C3d7NYATTVdCHazYGuItvosFkWihvJYe7wijP8mDb3w=;
        b=lN1Hr222mGwxTQ9WN9VKjg1/HG1W3ygcNq3NDirZrxAHJs7fCJXsEXz3ZnFwi0vZkJ
         3eVzYfDe6PNgDH75KFyeC79j9LSEG3SU03uoLj/r3NWqwRLGI79wbgxuR2MG+4vNQMN5
         H32J4yQsyq2OLcJDMQ4u+wPkP7s0/nxZhPSlzHNumEc0PmaYJ9D1KuLwywp5xfrisZyr
         94/JVoqHt/Xmb2vXKrL+l2M78QMuZYG2qk+pT1oZN2Okui/0fYIgeXvmjGofWNEZTgUM
         2kjoqOfQdmgjLFrcdtydwCJonrL/2RiNj30/J/I7S7lHj/QM739k5mSgwfx6SejPZ/eT
         3xrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732021838; x=1732626638;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C3d7NYATTVdCHazYGuItvosFkWihvJYe7wijP8mDb3w=;
        b=V06TKBVTIKH0HbfRSHJwXOTCLSAN+Odn7Fgeb5rie3Iqy+fuZc54FphzTJ2IRB1h18
         T+n1mERCUuNFnZgIrTpV5EpJN3G+Pjqigos57EpuqyT1uw7qO3K0qyGBg2+HTo8hgT1+
         e08wXR/a7MxlrZMcpzMYj4tOc6P8dpJ91mh5bOagmcemu8adA+uOyFN2MYnMzHMhFchu
         S9nzXYD0TIg9mg87i3wd3RinaiL86pvgRz8Zo98htG8qR5ACmKM9ZN7XSpNWHGE7nIQk
         DPUsOzZJZrcYeY2qdn8QNGDf/faNcxuoJSPGUPjuANK0AUi9T1SrcouWbQ/QL2oqzt9C
         RrUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfrLremt72meBwO3S7wYeB00JDGsMJKUtAd9FHdB84D4XLbWaQ2GOSGwZ6Y3ipsePnURuw849an92zc6U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOfWlLdYBXWYtrooWzI/QZYUdfB1G8KxiEw0CtDfrPyxez++/L
	Qogfgm6HwKwk10PhQNF09DrYVnhv5I09urMDrMrdY4MP9WvuDauyfMmRk/k5yoA=
X-Google-Smtp-Source: AGHT+IFGzy6hHRNfT1Xk0fv2qf5k8xsk+yHK97gHuQ3g7T1drOUPNgaJPiNy3RNlThsTeiDlVi+aVg==
X-Received: by 2002:a05:6512:a84:b0:53d:a99e:b765 with SMTP id 2adb3069b0e04-53dab2a2205mr6495158e87.27.1732021837629;
        Tue, 19 Nov 2024 05:10:37 -0800 (PST)
Received: from [127.0.1.1] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dab76dafsm192016185e9.10.2024.11.19.05.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 05:10:37 -0800 (PST)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date: Tue, 19 Nov 2024 13:10:32 +0000
Subject: [PATCH 3/6] dt-bindings: clock: qcom: Add second power-domain to
 CAMCC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241119-b4-linux-next-24-11-18-dtsi-x1e80100-camss-v1-3-54075d75f654@linaro.org>
References: <20241119-b4-linux-next-24-11-18-dtsi-x1e80100-camss-v1-0-54075d75f654@linaro.org>
In-Reply-To: <20241119-b4-linux-next-24-11-18-dtsi-x1e80100-camss-v1-0-54075d75f654@linaro.org>
To: Loic Poulain <loic.poulain@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Todor Tomov <todor.too@gmail.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, 
 Jagadeesh Kona <quic_jkona@quicinc.com>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, linux-clk@vger.kernel.org, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
X-Mailer: b4 0.15-dev-355e8

The x1e80100 has two power-domains for the CAMCC not one.

Capture this as:
minItems:1
maxItems:2

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml
index 0766f66c7dc4f6b81afa01f156c490f4f742fcee..afb7e37118b691658fc5cc71e97b110dcee7f22a 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml
@@ -39,9 +39,10 @@ properties:
       - description: Sleep clock source
 
   power-domains:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
     description:
-      A phandle and PM domain specifier for the MMCX power domain.
+      A phandle and PM domain specifier for the MMCX or MCX power domains.
 
   required-opps:
     maxItems: 1

-- 
2.45.2


