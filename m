Return-Path: <linux-kernel+bounces-443112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4899EE76A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 14:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D81F61887679
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 13:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27AC2147E2;
	Thu, 12 Dec 2024 13:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sK2826eM"
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEE3213E84
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 13:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734008928; cv=none; b=ttSD+QceBRlkm2l+iUCFFuQdCLBfy1YWNfqLqjK0+YBj0FAHwkoXdv7bhc/EzdPtLoJFXXuWwjYhCzJgKf/ZMk+kUlWmVSWT/ufPi7N2nYrBEi7dp0kIz2Y6Ji/IDG80teO5v1xu4Lu0K90OD6uQvZwWonMmX8DKWy+Soc0uqrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734008928; c=relaxed/simple;
	bh=zA6ZPtaAQOTzGizfmfD0bMOas198YKokHObIlhfB6dw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gGaWvVlU0UGgFnj9iTHz24bGykcK6Oqydm8Ei7hZBYSajpDr64x0p1NW1/tdE/rIIyBkh5317VFVxOFcjrQt8sgcQCnBCQ5bbOuNRhQuZiXpUBdjEchPBa//j0CGb/lcwG08DBauQGMqrT/6j+KtkH1HO2fLEOChWi5zlCBnte8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sK2826eM; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-a9f1c590ecdso76966b.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 05:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734008925; x=1734613725; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7o61OcaB2Y81Wzjk8zNCFvqYQvjVcvvI6j385R2UuN0=;
        b=sK2826eMw0qMAB2/OxIZFkQQM56PZ73Vm8yjjktT31SRid+2AdpTbG+BwCrzKQ67YC
         sCG4OS/+gNiGn6FeVhIqld7N31amV5EmxDVQnMvFJDcoxnBSTsWUQFDyt3i4HtlAbAeM
         S8XHFj6HMA4pqd02fHH5ZSzjZBP8FCqHms4TY/6B7nsVu5yLUJpGCr5IH8zx2XuyDSDW
         OXluqMWPQWCLQnKFrT8zYTyEFWjqLTPeEsM3wiutNf4sD3kRVZmdS+unjAzdkr9VyVd4
         pZN6g7XBJ0+w9HksULTitxIdokOaRLDD2+uHlLQ23hClfJQSquhMxBfYkFHMZ0+HbBaX
         AoIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734008925; x=1734613725;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7o61OcaB2Y81Wzjk8zNCFvqYQvjVcvvI6j385R2UuN0=;
        b=mYwkKGnpGEBPCCLpMtqwmR3Ug/L4q1Mw5wChQcz6NSTT7GIboKscfH2iphCFyaRuPL
         BDejJ4PyXAwPhua24mugkcDJCmT6THM56T1RR2tFia/HHmoiqvMoNG/eN/2Uq4/QUp5B
         vg4HgiMajK/ZpjKoqoi3VMYVYK2RbjmqDIXlhdhPovwLqbV+BVqtfH2HA7pVQYVgOESu
         Tof6uLvZUTAb7aJszYlxPztp0IkJiBzFrUpCb+R83PTuuxRvmJ+q7etID4dVozoO799k
         UriuHde+PIhGQUJBIT920AXFCJhxlLQ7tPlGb6UQoJEnFcSzZX//SlpjMmdSWB0QjZYp
         USsw==
X-Forwarded-Encrypted: i=1; AJvYcCUbyz3yp75wSNvEhTrqNFyFEG0HnGm9AxD7p2cxuVIfOWdITsrodoMp90eTJhmX0vlDi5IMvQBC4UK+OAs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOAxx1SidvqZQICwYW7y5Ta8qlTiPxFcTdnhGX4X7Qzg1xqVLv
	lPNhD1NuZAqMeHe+kKmny0BNGA3cXsx43Ef8+rZuDZcqU30EZtsETh632jVZR0g=
X-Gm-Gg: ASbGncta/m2cfr0G6eseJ45sO6tyXvaXxRwpSwcbNWy6O5Ld47XdvxXSbPk5GuHTZZR
	ewFq6ZkN+PvFw3WyDTVFuHF68FqVpKjP9iiR+FIRYOJn5j1Hp7jct1GgnOzuevTqpUhLdI7JqeS
	TmaT5eGrgnsywPcQ8r11kmQf5w1K93roJCA/JFx1zLBkQ6EFbaWbQfZIcNuoqHMLqXWoqQFL327
	CVwBt2sxi8WeW9hOPcRPD8hGqcZCSlHkpeYGqkg3PMyoLtca69+ZgEbjvujvEzacbie4g==
X-Google-Smtp-Source: AGHT+IE077OiUs7z0n4b9UML3M+XJa3dWw4Yzh21GNZ2CW9eRGcp7+5BBhtoo0lrpVH6NRp0jXXkLA==
X-Received: by 2002:a17:906:31ce:b0:aa6:8600:24df with SMTP id a640c23a62f3a-aa6b11e4882mr698182266b.26.1734008925413;
        Thu, 12 Dec 2024 05:08:45 -0800 (PST)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef40:3c0e:7a2d:e7e3:9cf8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6845ab4absm605843366b.73.2024.12.12.05.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 05:08:45 -0800 (PST)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Thu, 12 Dec 2024 14:08:23 +0100
Subject: [PATCH 1/3] dt-bindings: usb: gpio-sbu-mux: Add an entry for
 FSUSB42
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241212-x1e80100-qcp-dp-v1-1-37cb362a0dfe@linaro.org>
References: <20241212-x1e80100-qcp-dp-v1-0-37cb362a0dfe@linaro.org>
In-Reply-To: <20241212-x1e80100-qcp-dp-v1-0-37cb362a0dfe@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-usb@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>, 
 Johan Hovold <johan@kernel.org>
X-Mailer: b4 0.14.2

Add a compatible entry for the onsemi FSUSB42 USB switch, which can be used
for switching orientation of the SBU lines in USB Type-C applications.

Drivers work as-is with the existing fallback compatible.

Link to datasheet: https://www.onsemi.com/pdf/datasheet/fsusb42-d.pdf

Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 Documentation/devicetree/bindings/usb/gpio-sbu-mux.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/usb/gpio-sbu-mux.yaml b/Documentation/devicetree/bindings/usb/gpio-sbu-mux.yaml
index 8a5f837eff94b27bbd55bfe45f8d1156e3d183eb..e588514fab2d8c9d0d3717865fe2e733664fc28b 100644
--- a/Documentation/devicetree/bindings/usb/gpio-sbu-mux.yaml
+++ b/Documentation/devicetree/bindings/usb/gpio-sbu-mux.yaml
@@ -20,6 +20,7 @@ properties:
     items:
       - enum:
           - nxp,cbdtu02043
+          - onnn,fsusb42
           - onnn,fsusb43l10x
           - pericom,pi3usb102
           - ti,tmuxhs4212

-- 
2.47.0


