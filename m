Return-Path: <linux-kernel+bounces-293553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD9C95813D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 10:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFA612826EF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 08:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B167618B465;
	Tue, 20 Aug 2024 08:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cUiKtWKf"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7AB18A928
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 08:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724143477; cv=none; b=UTaDyh5ERPyuE1MdJBIB5zmnsB4z9ZyPg95WZPphihYzSu1eLUKfbliPERs19auiNu/+ctokaooGVG+jTy5ejny2CdCLXLAGE5+JdYmJQ96TtIrQBabrhhw0HIlczCPZ8Sl1dO4R1LOmwTRrf9MqK2PCah8JnlXiZbW3TgGUzJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724143477; c=relaxed/simple;
	bh=ihPpTKWtmQDqETpS/ko4Upn5KM57AFh71idg3PZivGI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BjYI1t7i9GZzSSE9Ux1MK4Xa+QSQz4/5Mz4n6vX/a7Xh56cMK5RL+yHRdSoVuj/lQ5vZxmd0KC8uS0XpbUaRg6R5S5TnjZ2jA9ZiiSxDRQBVvT6ATZhsG1e5UR2nGd84jcgvfWqo2N/4JneGpJVUk/Ve9OPpdwQ5ItBa36XRBAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cUiKtWKf; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52f04c29588so7026036e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 01:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724143473; x=1724748273; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W46dkPCLl0CsM8F741fN7/xHRWhTr+kY2TsBuUOfPQg=;
        b=cUiKtWKfDf2wF04Mgp8Xn6bgLt+ixeeTf8vhEYUk5Zfew0KarJdpxXZ3kAfg07niUy
         0MdufCzsVQfaUWUhndD0HOI7eAoa050owX5R/mAuHkT4v5xiuNiav8CvY0uXht9a00ry
         GbEhO1WK1xY/7o2dKB2sHt0ECTDcIuodR+1C9KUANFTX1WbyD2nK4FETDFoEfZAv4v9r
         QGaxigs41wBOUEClH7+cAsK6dzgv8Eu7+88g/81fKMD7pouG2cKTKILb3tZWhh8ZcqzQ
         2sWB7V9UZzSgznVOznmP87TDQ0CdY2J8XgL+7sGSlIUra1oQAPMtPCrpoXpBBBLMS302
         +TSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724143473; x=1724748273;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W46dkPCLl0CsM8F741fN7/xHRWhTr+kY2TsBuUOfPQg=;
        b=acFLUIHQ8aSw6holcRv8gg2ef53SuR5/XZgckTpMfpN1sYk+7M23Zk1Zc4z2Ce5OGh
         /qU6yMXZ4J2Q7FMXYeEVQMsBqZsx+Ham4SO1UFUMacHu/Wevxt/XILZP3K+DJ4/R88g7
         E+DZSuDYl6t72BSbK/h/bea0R9kPMRfe07gUsV6i/vc/aDOQeIXvfmjjjGX06MvA+mZp
         KIuf+wbC+FaH+klHx86e6r1IGykO6N+/RYhGFaT63jynkP0Hk5pSqxjD6oD9GhjdIl4E
         gZ8Dnc6+LUbBfVyW0zV+4hfPx+Pz+HCx1pQhuN4Tsb4NARXtCpndomEhAai/aYRPQduf
         z6iw==
X-Forwarded-Encrypted: i=1; AJvYcCWO4g7djkUflqK16fAXILxBT1LIjw+Q2bY/Gs/TgnwrSs4W4uztv5P8JzCpHC6NCrXY3tB7ihT5ssVs6XY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm0kIiedMRXUnQW8XwNTUSKxlfUExpPV7xOD4OcRxwnZoRpYqz
	XEhIMPY6zBAKqYrZeXt+h3g1AwugQU2Ps05LWzuV5riHpxgVxVhLDVkr1V/TJsY=
X-Google-Smtp-Source: AGHT+IEPe41tNiCcGsuD99PSXMjDgsX9VqOdG2fp910RJBAJZ/OA+XpJsjsmNl4MmpOY0ptJcDG4aw==
X-Received: by 2002:a05:6512:e94:b0:530:aa82:a4fc with SMTP id 2adb3069b0e04-5331c6dc90amr8003501e87.37.1724143473005;
        Tue, 20 Aug 2024 01:44:33 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8383946973sm728037766b.160.2024.08.20.01.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 01:44:32 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 0/3] dt-bindings: i2c: nvidia,tegra20-i2c: minor cleanups
Date: Tue, 20 Aug 2024 10:44:23 +0200
Message-Id: <20240820-dt-bindings-i2c-nvidia-v1-0-2763e9a9a1b0@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGdXxGYC/x3MQQqDQAxG4atI1g2Mg0LsVaSL0UT9N6nMFCmId
 3dw+S3eO6lYhhV6NydlO1Dw9Yr21dC8JV+NodUUQ+yCxMD64wmu8LUw4sx+QJFYhl5lSK2YLFT
 jPduC/zMeP9d1A9gBYFtoAAAA
To: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=651;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=ihPpTKWtmQDqETpS/ko4Upn5KM57AFh71idg3PZivGI=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmxFdprZi2BhyVmuU7Hma8eO6WoTQIyR2Ju0ctv
 uN1HMRN46CJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZsRXaQAKCRDBN2bmhouD
 14YmD/41vh5UZXo8unidp9ve8tllo/opQ6Ph64+v1180i8l2usCbE3lZdg2/y2+CAeMukZemxhr
 Nai01YQhMm6gFyF/iZUjbCvw8AJ5Iq1Cb2msCI8HtWVqWNYNTKz5H0kbBjdGzFw6UXTBDtIIRhZ
 mbQwci271BWIQvLeBZMhoZAZWrhAGE4PMEOnpI77dJ53mlCB8ntPvfa6vz8R2nLk/yqq6JD8dFe
 F5blXyBPHAH9RBGfcbk7lN2qFdSqiFnTImsBU1DMizszApwQ9YlXKQvnOce8yX7AcRMwJxur4bF
 pF0NJylqaxgOahii/DBUIYkWhkeBdx8snF3sF4wj9LIod5G5Tuvic+spf1GPl9BjjwsKdtsEbZE
 TfZl9Ka1APmRoHMQmGO5Sno0o6qXizvbL9fWzdo7ST8kiSielD9Mckq4f1G/lE1Gb7jKH9TKNpp
 JYNH2RFsYPIgiTzsR90xoyCmmHXSU438ToU2rgHJq2nXuAqdzxLRMod6ouULSQvcKGimdgLe6eO
 uWkyQMvqPAF1FMkmaxhnEItAWsTUM9jp6a4+KBWfX9NkcD7ZDhli02syihjsJJGdU7KFx5uQLnB
 /+ODNOmAEpJ02E+ChX0eDGl0XIz5f4pqiTg7APQQDntcK2Ng5Phi4rPx13Jt7RiBrWvxmI5g2Bh
 78k2/UzZtM9cz6A==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Simple cleanups for nvidia I2C.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (3):
      dt-bindings: i2c: nvidia,tegra20-i2c: combine same if:then: clauses
      dt-bindings: i2c: nvidia,tegra20-i2c: restrict also clocks in if:then:
      dt-bindings: i2c: nvidia,tegra20-i2c: define power-domains top-level

 .../bindings/i2c/nvidia,tegra20-i2c.yaml           | 27 ++++++++++++----------
 1 file changed, 15 insertions(+), 12 deletions(-)
---
base-commit: 367b5c3d53e57d51a5878816804652963da90950
change-id: 20240820-dt-bindings-i2c-nvidia-895d89a18e8f

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


