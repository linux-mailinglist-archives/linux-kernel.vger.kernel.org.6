Return-Path: <linux-kernel+bounces-195563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C204B8D4EA1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 17:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3EDF1C23B9E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 15:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E1817D8A0;
	Thu, 30 May 2024 15:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="AzT19l+8"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1610117C216
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 15:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717081576; cv=none; b=Q8fo1C2DmZrHCjq9Kbtp4dqEZOAcptWsmUaeIPd25lbtbv9iAYhbGRqReywbI5+k+A/dkbiqNfEwoZmo/d2nfnenewS/8BtFAMoqgkSSiFSj4Z2eAjMmVwJC6GANHuzd8oW2rC0QnD56ny0kAeMIy3sr0RrSbRO1OlBPs0Gl9MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717081576; c=relaxed/simple;
	bh=Bu3eUC4zXNscfdIOpLA9uD5yFC8DKBu6iITNVsT2m74=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QWgK0vTW395Y0qBJwR0uTNCUA3sf6wMBF1gvfwKnWwN2r6qNpBvZ9jv1Ayuc5ulKz9CgV6KYGwVdQEyCRAXXQWIpyz1y7M7sMf7cXhfQv+8V1M7CJk59SSWSlukeer0t7DXpZC265Rt06AyZ6CIxq8LEVCv89bQUl/Vn23W3WTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=AzT19l+8; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a6302bdb54aso116441766b.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 08:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1717081573; x=1717686373; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JJnwAaQpjN82Mm77xT5tgcdbB47RO3jR/e4Zn+cYjI0=;
        b=AzT19l+8ierwARZnUaIEf69F7kJdej2heAFi+vqc8p54WUHudOizBczffnFW++TyO8
         Bkp+KY8OajyilnDa9WibzEXkm/y4qbBCJiDX9EveIJe66xcUpEiP/ng+wbPWoCBpIm3X
         RJh0AP07Ni2TdJe4yEwM1vVdYhUy/Ut3fdI8y0LYp1qjnYkThvuGkMhC5jszHRf+2ixx
         ZG/UpOq21GgWrXYtmcwAXSc26+l175zVO1Yd6mjplUYo5dWDFMwiBhS5Lvi9Wtc2YekS
         7eCVAz667C28HwHU4ynFJvSqnXO2RT2PZb8QMddyaC9plEB2vlUS3449T3MWM1sS7K/B
         jWtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717081573; x=1717686373;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JJnwAaQpjN82Mm77xT5tgcdbB47RO3jR/e4Zn+cYjI0=;
        b=VjSovRPbzo0w0k9CiUQxMOrMpcg51k3iUpXevXUoOpjDVt5FN8oN1oi2eIdV2nC/6I
         SgFR1asYXazwbH3i2wfuuX+UDSZTqUkLUs9+IIpVJn+SaJzNsVtJwG1zc3k+Xz3xRyz7
         YZBV8bQ0uX2RKh49CQO2UAsgV8lhalpeziBoHhoN+NVplLed2rau7fkNOmhY1/MCtnoD
         vwEPNnX4lD1yMLRg1oiY946z3wXqUjGPQcd1+phMTHI2LpOv6h4zl8RU7rH41sQ7E8ul
         BTKVYKDrollTSFgy6YzBpVjPPutDL+MG2WYIqpo1psJ5Hwoz5f04ipPBluaoKy52kS4o
         bghQ==
X-Forwarded-Encrypted: i=1; AJvYcCUstl0GZPR+nHsK6j6/aGP19Pa0Xtv+p33X2+BxSsqCcTOvAwBNSbBVCP5PArZxjmu9szQtqGMeyFvjJLlgiJfr29SxAhY7/yt36SDF
X-Gm-Message-State: AOJu0Yx/170okUIyBSl6dcHQhiw63T15NKRmEH0i4YPSZwIc3pg792HD
	0r+H3CWPBrbbg1mzor6zeVw6pdPmeSCcOkCVVjmzqVsDa0JaDK2V4oeVfoVzqgM=
X-Google-Smtp-Source: AGHT+IFwM84B436/a3wmQnrKDqwgfU8pKRsAVsHO3PtYHV7JTyw3SgobDAJDf7LdUwKjvwM6hBtLMA==
X-Received: by 2002:a17:906:5694:b0:a5a:1b47:dab3 with SMTP id a640c23a62f3a-a65e8e5d4a5mr173703866b.25.1717081573409;
        Thu, 30 May 2024 08:06:13 -0700 (PDT)
Received: from otso.luca.vpn.lucaweiss.eu (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a67430f8457sm13531066b.122.2024.05.30.08.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 08:06:13 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Subject: [PATCH v3 0/3] Add TCPM support for PM7250B and Fairphone 4
Date: Thu, 30 May 2024 17:05:46 +0200
Message-Id: <20240530-fp4-tcpm-v3-0-612d4bbd5e09@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMqVWGYC/22Myw6DIBQFf8WwLg0CFx+r/kfTheVR70IhYEgb4
 78XXZmmyzk5MytJNqJNpK9WEm3GhH4uIC4V0eMwvyxFU5hwxiUTnFMXJF10mCgfjGqtAxBSkXI
 P0Tp8H6n7o/CIafHxc5Rzva9/IrmmjGpQUrKuM9A8b27AGEY/26v2E9lDmZ/l7iTzIpvGtdrUC
 gTAr7xt2xcJ/CwE4QAAAA==
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
X-Mailer: b4 0.13.0

This series adds support for Type-C Port Management on the Fairphone 4
which enables USB role switching and orientation switching.

This enables a user for example to plug in a USB stick or a USB keyboard
to the Type-C port.

To: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
To: Conor Dooley <conor+dt@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht
Cc: phone-devel@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>

Changes in v3:
- Disable pm7250b typec node by default since on some platforms the ADSP
  firmware will manage it and not Linux (Bjorn)
- Move usb-role-switch and orientation-switch to dtsi (Konrad) - update
  sony-lena also as per https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git/commit/?id=dad66630a083263b513448426523a3b52a959c79
- Link to v2: https://lore.kernel.org/r/20240329-fp4-tcpm-v2-0-d7f8cd165355@fairphone.com

Changes in v2:
- Move disabled as last property for pm7250b_vbus
- Update USB graph to newer version, connect both HS and SS signals
- Update FP4 Type-C properties, try to keep phone charging intact by
  disabling USB PD for now
- Pick up tags
- Drop patches that landed in linux-next already
- Link to v1: https://lore.kernel.org/r/20240322-fp4-tcpm-v1-0-c5644099d57b@fairphone.com

---
Luca Weiss (3):
      arm64: dts: qcom: pm7250b: Add node for PMIC VBUS booster
      arm64: dts: qcom: pm7250b: Add a TCPM description
      arm64: dts: qcom: sm7225-fairphone-fp4: Enable USB role switching

 arch/arm64/boot/dts/qcom/pm7250b.dtsi              | 46 +++++++++++++++++
 .../dts/qcom/sm6350-sony-xperia-lena-pdx213.dts    |  1 +
 arch/arm64/boot/dts/qcom/sm6350.dtsi               | 50 +++++++++++++++++++
 arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts  | 58 +++++++++++++++++++++-
 4 files changed, 154 insertions(+), 1 deletion(-)
---
base-commit: 4adcd8f0525c79f058c10e3ecaaba74932f6ffff
change-id: 20240322-fp4-tcpm-2ad68ef55346

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>


