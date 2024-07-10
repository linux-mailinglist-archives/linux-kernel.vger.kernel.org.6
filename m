Return-Path: <linux-kernel+bounces-247990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6690492D723
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 19:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 075721F25627
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 17:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA93819580B;
	Wed, 10 Jul 2024 17:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e/bXP+WV"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680071953AB
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 17:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720631119; cv=none; b=chazIHR+ZehumJbolBGTlVN8jJHBDyK6FtHmfYW3ZIoyjSDIpgssbIpkhk/XBp7+DucX3xcXeKvCa8M0S3c5m9NJ790VyvWVyiF1jBBw+yoIfKbVDa6OtyClSusIO0zV9AmV6r7GIZ0qTNlaOeND/txIE0Cd0sKmufSFwa7K03I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720631119; c=relaxed/simple;
	bh=wXcS/KnBI5LgsGogTMFCCth33LAkgZkI+3fauQ91JiE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cFIYu4HVFW04A13n7ZfYRldRMb9MOqxjAfLctb2JG0oIB083lSo74g+TlbXEgUbv87yLd6v3bP44WEyLW663pit49bTds71jSx1JRIA2/E9C2zAp1OsPzGXnsoJek9Wk79zZIBmrRS1zNvAJt25eIOr/EvJQBVetF2yE8AtSLFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=e/bXP+WV; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-367aa05bf9dso2850200f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 10:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720631116; x=1721235916; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ri1KrrJv5lGlLAnLFws19LhHfpuP+FO80ojRQ99yShw=;
        b=e/bXP+WVdxJ+GppzonXkozIOLiRKmMnJ9RCWcsH8N0GO7ky4VDOy99r0PlGkNOqoSR
         7aNcu0a49hIQIXHXtVPsgDbj+dGvgkFxD4aP2F/Fb4rCBpRvqnzmcR4FDSrn8ozIR+cp
         CdqvMuCHRz9PvpN8BN0Ioj5PzSmlebZjnHx+ZyYW0LxPw8ua85X3GL+Ph/DJ/D8kjn2Z
         IiQosaFf69Mct8pZkKXm7m+PC2utw5TUeBNTVVwbJYVzjLENfgnX5ZBM2VChfrCYjmup
         BDUCMiTAesCYcmnQqfwLnX/4alm65oGj1OVSTL/UWUw15Q3WJBeEjGYhArfn1nl9EPax
         UfDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720631116; x=1721235916;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ri1KrrJv5lGlLAnLFws19LhHfpuP+FO80ojRQ99yShw=;
        b=Z2jWtlFBZl46Jw44dF4b9B3uhxmU8ON+ytOs6KxwIIPgrfqEh5QqDLswg3wuIV8saJ
         vVBcEERGsbXoD4/5dOLdMx/6Kv9tV1ont9i7upiTPDYZaFyRZ99svUlwSGBobwTBxTog
         46stYask4NtwinSlYUbOAjG/DFfWe6yRZZspw2qfT208VvSwkhvatlH5U/lVbAXTRonR
         mIezfoSApWrSh5rmiDT+nbgLWBzqgxePqeQ+VWmWprbvFSi5OGV6FCcXWyAmVFuPXQ/7
         j8fmE6+x9JgeUGwZe+a0QvlB+4pyCAxeO5J6p8UC5lqUmgrEF/ohXNq03aFDciMHswvi
         JrHA==
X-Forwarded-Encrypted: i=1; AJvYcCV8uE0AoTplQJoFJIsMH1fshl2kYBKz0+dhzL9uAHWLGKYm7NC+UVimp+8ALGdu+QKnm5x7iqJTdLlY1st8Xju0fvMJTlv9mXCFb44y
X-Gm-Message-State: AOJu0YxT9ec2mmRoXViXpusV2K2TMWoZy0LA0YQZPoXd4Cd7T7VMYpkL
	itpPbU3SHusxxP2ukzvh4EUgi8b37Zxhs7Y+vvPxbLeeCE7t53trGhaRFLIVwoA=
X-Google-Smtp-Source: AGHT+IG2I2vfs2A9BrUdEREFeLsTLIRYJLTlw8D0se40K1gnpRKxO6FDo/ods9+emAorOvUndvejzA==
X-Received: by 2002:adf:978f:0:b0:366:e9f3:c242 with SMTP id ffacd0b85a97d-367cea46887mr3987846f8f.12.1720631115960;
        Wed, 10 Jul 2024 10:05:15 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff1f:b240:65e6:93ca:5f80:ea9b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde7dedfsm5838446f8f.24.2024.07.10.10.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 10:05:15 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Wed, 10 Jul 2024 19:04:57 +0200
Subject: [PATCH 1/5] dt-bindings: display: panel: samsung,atna33xc20:
 Document ATNA45AF01
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240710-x1e80100-crd-backlight-v1-1-eb242311a23e@linaro.org>
References: <20240710-x1e80100-crd-backlight-v1-0-eb242311a23e@linaro.org>
In-Reply-To: <20240710-x1e80100-crd-backlight-v1-0-eb242311a23e@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Douglas Anderson <dianders@chromium.org>, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>, 
 Johan Hovold <johan@kernel.org>
X-Mailer: b4 0.13.0

The Samsung ATNA45AF01 panel is an AMOLED eDP panel that has backlight
control over the DP AUX channel. While it works almost correctly with the
generic "edp-panel" compatible, the backlight needs special handling to
work correctly. It is similar to the existing ATNA33XC20 panel, just with
a larger resolution and size.

Add a new "samsung,atna45af01" compatible to describe this panel in the DT.

Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 .../devicetree/bindings/display/panel/samsung,atna33xc20.yaml       | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/panel/samsung,atna33xc20.yaml b/Documentation/devicetree/bindings/display/panel/samsung,atna33xc20.yaml
index 765ca155c83a..d668e8d0d296 100644
--- a/Documentation/devicetree/bindings/display/panel/samsung,atna33xc20.yaml
+++ b/Documentation/devicetree/bindings/display/panel/samsung,atna33xc20.yaml
@@ -14,7 +14,11 @@ allOf:
 
 properties:
   compatible:
-    const: samsung,atna33xc20
+    enum:
+      # Samsung 13.3" FHD (1920x1080 pixels) eDP AMOLED panel
+      - samsung,atna33xc20
+      # Samsung 14.5" WQXGA+ (2880x1800 pixels) eDP AMOLED panel
+      - samsung,atna45af01
 
   enable-gpios: true
   port: true

-- 
2.44.1


