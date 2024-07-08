Return-Path: <linux-kernel+bounces-244315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F9C92A293
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 14:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C06E4284180
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 12:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F1A12FB27;
	Mon,  8 Jul 2024 12:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="atM897Iu"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C5782D9F
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 12:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720441386; cv=none; b=oSNZcn+n1nOcztWQ3qBM1w3asw1sC7y6oJ+xEQ27ULkm7EIg77OdgmtKTugnY0tUQiOhOWnE+XMfkLKvZ8HnCKmUIwfPfR6tQBv61G9J1HObySUG3ZnysxoIHf7KOxpKAYicwKiHvWms41XHH5BbQ7ruOkqC/SCiSnV/aGdigrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720441386; c=relaxed/simple;
	bh=a9ltpCCByjdBmPwzY8NTJCgzDHbIcqn2UsHtrfrIUGg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VlBwn8c2KrxB/pyvgV9HE9M4npOQCdYylyGJlJWMeszQq5oorCwDSalcXg27yXkZ1df/BR1X1dmpFG6zdi1vqlbf2CEu8yX3K1P18LqiWMjLe+2RU/XVFQ0+BUCt6ju3988zMFUKupV2enN959L5mHsyoXGeYfXcjgvAmQ2m3Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=atM897Iu; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a7523f0870cso466521166b.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 05:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720441383; x=1721046183; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cjsp7pSBAArMHdQni+W9ujHChM6z0PA2ajKmcUfUJMI=;
        b=atM897IudYcXRpsJMP5fjs3c369ZkOgXekJQmgp3/xcNiaf6+fIX4sGz8BYwl9xang
         J+0UkuDMAVicOuYMqivv826JMtc6mvCOxODEegsfyb/QZCwpy7QkLMHFYAP7fdKgvlpP
         sVnglHeNbqCzppUStFSCurg6Fu+Zh0QADbMej6TsmZMVfMG+y+MUPIXCz645WEZbLgwq
         Q7i7DpfWM90vzsWRvWD4sYgGVqBRgEk1mFkDtDy88vA2VaN/Om8xuP5sb5xq15v2ClHS
         nKLwHB3n9ilupSboujG/3R6hsMW6F8130tGuiKQsrW32Y0XlWjALAtPAcZytHCCTk8Qy
         p0Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720441383; x=1721046183;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cjsp7pSBAArMHdQni+W9ujHChM6z0PA2ajKmcUfUJMI=;
        b=KXDo8uz2PQ9QamBhXaU+agqeC4FsHO4konNo38tzNmlt+9YGapi4nzybLMMuW6xaHH
         jPKXSRfiuNfnGS738RfHPhT022A9xxXqQDh9mEY8ZMMZ1bsm7fgvdQSty+aKRaZH+lko
         Ep0wBC4lNdzPbXMy8zJZzfoDm3wynCxE73uGaoItXpRBwl9aFkuNm2JPMAzY7aJmU7hl
         +bCxq/6L6DpCmySDL6UiL4TCRXJbbo+46KTCoXdn38DN1DBz7HOis1h+19f2kxt354bo
         5YKBhIUuRri3pujnTaZK9ultNLOdXnBSG8ymEoF5r/BH0Wv0wpcfLOV29t1fDRSGNA7g
         NQ7w==
X-Forwarded-Encrypted: i=1; AJvYcCVpllHBnIrrrAFcAtxlszrDpI4eK7cEQVZjWLJShVU2VY7lxVjyAt686uwaNT44JUnCNdDd6Z0nIFFcGD6LbGebYjAzO0dCRXtaIQup
X-Gm-Message-State: AOJu0YxyK9sm4f26qXy5x3ydAzEK/qfqtZo03gBuR3MFAaT+3AG0mQTv
	+CasFWpTW3UACiNl9V1DJHlsGc1vYHtYRHwYL1IwFOQPSU37/PMnEV17yu5ZwwM=
X-Google-Smtp-Source: AGHT+IEHOSOCSTQTCAKQiQAbeH62nSmAElW3TfCdMCd1bjLHPVzqzlCm2o+YDc+pjUO8cHDBRIdJFQ==
X-Received: by 2002:a17:906:81d4:b0:a77:e0ed:8bb with SMTP id a640c23a62f3a-a77e0ed09bbmr414346166b.42.1720441382755;
        Mon, 08 Jul 2024 05:23:02 -0700 (PDT)
Received: from [192.168.105.194] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a77e52ccf19sm208983666b.147.2024.07.08.05.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 05:23:02 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Mon, 08 Jul 2024 14:22:34 +0200
Subject: [PATCH v15 03/10] dt-bindings: opp: v2-qcom-level: Allow
 opp-shared
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240708-topic-cpr3h-v15-3-5bc8b8936489@linaro.org>
References: <20240708-topic-cpr3h-v15-0-5bc8b8936489@linaro.org>
In-Reply-To: <20240708-topic-cpr3h-v15-0-5bc8b8936489@linaro.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Stephen Boyd <sboyd@kernel.org>, Niklas Cassel <nks@flawful.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Robert Marko <robimarko@gmail.com>, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-pm@vger.kernel.org, Jeffrey Hugo <quic_jhugo@quicinc.com>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720441372; l=790;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=a9ltpCCByjdBmPwzY8NTJCgzDHbIcqn2UsHtrfrIUGg=;
 b=4vzsiflIbtRjRk3Rt4GJxG4C5hZHfbRBCjf34IdI2ymD5PPib4hhrTZp2N3seAJmS0shxegbs
 Tl8XZiHD6rgDV5ftBxlM3T4yJ18fAzZhMJVP26R4rhhHxEYzm3nZvPT
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Some devices may use a shared OPP table, such as separate CPR threads.
Allow the table to be marked as such.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml b/Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml
index b203ea01b17a..cc694b254a14 100644
--- a/Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml
+++ b/Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml
@@ -16,6 +16,8 @@ properties:
   compatible:
     const: operating-points-v2-qcom-level
 
+  opp-shared: true
+
 patternProperties:
   '^opp-?[0-9]+$':
     type: object

-- 
2.45.2


