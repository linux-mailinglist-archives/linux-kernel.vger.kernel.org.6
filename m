Return-Path: <linux-kernel+bounces-571459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B33A6BD80
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 15:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87CC03ADC2F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 14:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9942F5E;
	Fri, 21 Mar 2025 14:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="NIhgSJe0"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C827615855E
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 14:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742568351; cv=none; b=CoWkfQxlAIdC5CI1G7fWe+cNJpD+GjK8waCp71S1DZQfZnBX3ZWahzzlKS/V3tAjWxU593ybVsn2Y1jM3O2+AoEx6AsrTyLAb4W6rCeSaH8b6s9guoSSw3sPA0tOJcylsAtKyo989LlZYJEuiuNFRvdUHcmlxjEyAX/J0U3cWzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742568351; c=relaxed/simple;
	bh=0k4WlE/9Tyqofqq6qU4Rq2nzt306TPjVYhaNxs0Bvcs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Jmp77iMe0PPeNjc6cocDeAz+XIqI1lT6r0ORbPN5LXB1b/ZfQqBcfQVlbxLiDw7Kl14UOiZU2bXo4FqK3KjuHtnaBo4SE/9dIXm5lPe7X8BYjub/hdQb07CqAv/M5e67qedooJtsjfqcOEDGMSlwYSsdBV8YZohauCKwTSmyu8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=NIhgSJe0; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ac25d2b2354so352707766b.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 07:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1742568348; x=1743173148; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UfREiEIegsjqq2j/Wuwqi5NQffLWKjGNHk3ynXc28wY=;
        b=NIhgSJe0xnaf5jKCrMK6BSd/D305UgFcyZWpz2rODjKRvWY/LVKabDP5NufS4q8DQP
         HhMQxKdx9bNlng21gmeUj8ayfmnxRJ6V/SwuDqvE+m5E1CbJdYOmjdVHSaGxVhLDAjsI
         TyDoCfIrLgnJ0PcAD/s5R7gR2GFxwKO4VsaL7AoJLLMy6zwrxN87vBj2jn3NXVHIcRTj
         pUaYOBTQ5JsZWCJSopidjlZR/SrPY1t0HUR+ErwHMgdQB8rhH3Qa49aHflUAwFFTIzwZ
         J5A7CsxZymW8XRsSdBigvmODl52Q5zjwp58hqVLHtlejyLq5rdkJbU5HGIWGgDX/h7+z
         5MYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742568348; x=1743173148;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UfREiEIegsjqq2j/Wuwqi5NQffLWKjGNHk3ynXc28wY=;
        b=cu3MPZ2hvVXpRZf+sYdpoArA7LvUZfrlJ8EbpOBMqXMI/Y1xwQ69gvaId12y1rYRUV
         xgDHvPjjxRH4J3coerN142xh1Pf4+8OaSAXs69Pz4AJeH/qn8iAsMsdX0ixcdAJ9RkIP
         8KUEET9VO3Iei7y7nbWjtcmMeolLOcPW9Q5AduzcTRCNDeXmf8VfrsOFRIdk8RPgzX7w
         nGx6tw5Q1hgzY3mtez9dvLjqsrLgSiQUJpWWCyVuWGrVB8s1f7gpeWwZlQM52TsATcLO
         V26mv8Q0L0o3wcEYImLE3PF330m1KOu6i868+OG+n8ffJ0HSXMVWl9PPAuVg2HxB/RhH
         D5Mw==
X-Forwarded-Encrypted: i=1; AJvYcCVc04DmnFcTnBXdVZywLs3MLw3TIsz4fl6Wv35ppEvK5vjU8WrtzhL7danU8/pZVE52VyOE83cNXdfQfHw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjhw0+8CGG5XpWZBQkCCE9UNjRCC83a1qjIimq1xWtd9pROSMJ
	44LCPUieLas25XxQil1XWchfoOVi8UyWnUO5YlL8C4k7VXMff4rJgPNPNqaeLk8=
X-Gm-Gg: ASbGnctf8oLaz/CiFytw0VK0lImEpS/heSSlAgo1cQOOK9k1lWOD2oLty6GgVwURt3f
	TXt7uv7SQC02KL9y2M7dalBQaal5QhknFt8IkC2TMn3X7nD5MQ8gQbT+1KtflHRUcAhN+XH2hIb
	//VWeGmWc4TekGQjWgSQbXA20s6ScAU74it9LECeDKeeTrw2Sm44YHrU1bPeUfNv28DGCCbnAUk
	3sMej0vRxY43vfJqbptlk1CIkQqcsTihvSZroEHf49wYA+JpqV5m8J12vQFZEbzAAZ3CpWk4wbB
	4V8G8WdXChWr+no1+AJm9g2FKrUL8fDMqw7uUNRMalM003EIAn6RjQM3injM7x/tbDCVDJPXTxD
	+wVtCh+85QUyMJPkMDQ==
X-Google-Smtp-Source: AGHT+IG5MlM9CgB175VZ3Vc4RH0qB2s7BEDKyYcPQFBlPYs47o+HPbEy2dUQI25i+CYb4c4VAAdkLQ==
X-Received: by 2002:a17:907:ba0c:b0:ac0:6e7d:cd0b with SMTP id a640c23a62f3a-ac3f2268607mr442093266b.34.1742568347928;
        Fri, 21 Mar 2025 07:45:47 -0700 (PDT)
Received: from [100.64.0.4] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3efb648acsm168092466b.98.2025.03.21.07.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 07:45:47 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Subject: [PATCH 0/3] Add video clock controller for SM6350
Date: Fri, 21 Mar 2025 15:44:58 +0100
Message-Id: <20250321-sm6350-videocc-v1-0-c5ce1f1483ee@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGp73WcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDYyND3eJcM2NTA92yzJTU/ORkXbPU5JQky8QkI3NTMyWgpoKi1LTMCrC
 B0bG1tQB8vXnyYAAAAA==
X-Change-ID: 20250321-sm6350-videocc-6ecdb9ab2756
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Taniya Das <quic_tdas@quicinc.com>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2

The driver for the SM6350 videocc has been lying around in some branches
of my git tree for a long time, let's upstream it. It doesn't get any
better by letting it age!

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Konrad Dybcio (2):
      dt-bindings: clock: add SM6350 QCOM video clock bindings
      clk: qcom: Add video clock controller driver for SM6350

Luca Weiss (1):
      arm64: dts: qcom: sm6350: Add video clock controller

 .../devicetree/bindings/clock/qcom,videocc.yaml    |  20 ++
 arch/arm64/boot/dts/qcom/sm6350.dtsi               |  14 +
 drivers/clk/qcom/Kconfig                           |   9 +
 drivers/clk/qcom/Makefile                          |   1 +
 drivers/clk/qcom/videocc-sm6350.c                  | 355 +++++++++++++++++++++
 include/dt-bindings/clock/qcom,sm6350-videocc.h    |  27 ++
 6 files changed, 426 insertions(+)
---
base-commit: 73b8c1dbc2508188e383023080ce6a582ff5f279
change-id: 20250321-sm6350-videocc-6ecdb9ab2756

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>


