Return-Path: <linux-kernel+bounces-534036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8F5A461E5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2AC116F126
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7852522170B;
	Wed, 26 Feb 2025 14:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="DeOZhNdX"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198152206B8
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 14:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740579037; cv=none; b=bR1EvFZ8fuHxqaagYQxFmlnvyNYrDErZgeJRBvwCHwbO5alenuPPARzAAsKtZtzEHBQ7B5xQs4/4QZy1R+VYcXAKyglpXvuWVGPXnXA7rPtKNwtzCWtLhw1l73shWTKrTZ9H4QrDSeqnovHslmFtjj0y/CWzJac9d3cwuBWHkbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740579037; c=relaxed/simple;
	bh=hUdgjR/RHMYEJ230+g45ik66o3c8rPTSefQWcBqffE0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fAeojED61UnajYFiIJdhp2SIX6S/Rh8Vs0n1k9kVqdL/2W1k8rgG/wz7QmiXw2M06F//s4y3mZAq0Hm9K6mPd/5Uj3l9Vd7cvP4rr0+DRWmJ3aD0u1z0EPSlxy+4Vtn8/yV0nJ1JtZtACDNTfmX4gffB5CWK+is/gE+HocWDb6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=DeOZhNdX; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-390df942558so213992f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 06:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1740579034; x=1741183834; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6v2COQag385USHXDZetedSCoQTFZUjvQNehs7tzBwHk=;
        b=DeOZhNdXYJ0BLCNchdC3zPuh5engZ5KAccRSZuU5HlEK/qFmVJOdM1mk+KZJrlQHye
         GLMR/ar2Tp/V6LipuO/A5DhRC5r0O3S8fZcwh2Rc/aog7/7VZbrlPOI4uLRvsPjK0p2C
         jSFwizIu0ydRsfsBRdouuuycQLHvAOvsI41TEefFhp/7rUleRhzCSb/GP9JxJ00r+7uT
         nEA0ssVvwLz+Mgt+XY10elpypie2YDmu4iM0QW1IUhuhWZH0e5xjlZnanl82k/y4D6I/
         jEPbBe0RuUcb7jwPxD1xqo3GupikXR3p47ZlH9DEKb3K5kIS+M7oDtB0rwM+cFmHZdJj
         x0Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740579034; x=1741183834;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6v2COQag385USHXDZetedSCoQTFZUjvQNehs7tzBwHk=;
        b=LqqVGIKazuB3oxEjYNKj/qdnRvfajegydoqXs37/j2+DdzxgQz5Jchice+DpsuceKD
         w6bPU8uuuxsaRWjiujX9JKGRsZOvK5iXwBA6ihVGQjDQL1aksIv7dw/N4BydChAiml2E
         iVKge2D6cXdClCZ+zZEjRvkUtuLP4v3HgECribNWeOUWMyQvjoqISL1Bh5R8RGK3xMFH
         JSN4QC4YuYzZEvRQqUXbwsu2eFY3I2IzIBcmGsEWlKAugar+EWuPUfkkAtwffEbKVgiK
         UjwuieAAQYFb/sWsNweyDhtHkzYJC7BuyuOWjPoxUxSkWfEJIGPlJXPv+BgHnUL6IgLz
         MhZw==
X-Forwarded-Encrypted: i=1; AJvYcCUoP7jmPyT5WfAW4J72dQVkxUmBrvBbR+OMzMRThNM2BLtOZvVqk0QQa8PmBpcrBAgDsI89P0BhU9LUNqU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ+6tDvD12xOnFfHWwbcZNJWVEacCdGpsi4nXyGnA49njf7FKs
	0fO8CPK3IXMKu3/lQT5TnKbLu32NMzG1koQOafGpVCAx29Xpll4gMMZRgXGGoN4=
X-Gm-Gg: ASbGncvQjfbi9tKXkWlQ7U3FcESXDXDpnMyiwFPZzsEB1dLAYnk4RVFClHoTBdajPLT
	1tLXlgwkvqB/9NzVFFkZk6r3bD9rHGCN47qHKp53LCF+eTXC13cJP/fNUt0ShSukA8YLi5nH9Jb
	Fg6e0c/fsM84Zue/FGYEE4+9ZR0nJTxRdYaycciqLOu5q5HmreJKs9qXBM3Os04bQqT0AFgG85q
	nkmNdAK2e0TNEy+Uc32C41VpRMkgONrJfuEl/QHn6tD/3BbCBrY3yWvqrAhTgHIbAVM3tgTaDFi
	eDNmn340lSU4JuEhBU1odcndOr/nVdx8izn3Ekr4cHoiIA29m5ZndS6OYB4xMzz+lR/jf2J/dIY
	=
X-Google-Smtp-Source: AGHT+IE4o+OfE2YSudEnTjsH/f3XjsEpd8AL7T6UbGEbbpXVQOECvonikWzyjtQETBsUiLsBsFmVjA==
X-Received: by 2002:a05:6000:1ac8:b0:38f:39e5:6b5d with SMTP id ffacd0b85a97d-390d4f8b64bmr2958570f8f.44.1740579034331;
        Wed, 26 Feb 2025 06:10:34 -0800 (PST)
Received: from [100.64.0.4] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd70be4csm5755889f8f.0.2025.02.26.06.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 06:10:33 -0800 (PST)
From: Luca Weiss <luca.weiss@fairphone.com>
Subject: [PATCH 0/3] Fairphone 5 DisplayPort over USB-C support
Date: Wed, 26 Feb 2025 15:10:17 +0100
Message-Id: <20250226-fp5-pmic-glink-dp-v1-0-e6661d38652c@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMkgv2cC/x3MTQqAIBBA4avIrBtQ+6WrRIu0qYbKRCGC8O5Jy
 2/x3guRAlOEXrwQ6ObIl8tQhQC7TW4l5DkbtNSl0rLDxdfoT7a4Hux2nD1q1Zi2kV1liCB3PtD
 Cz/8cxpQ+CQWT1WMAAAA=
X-Change-ID: 20231208-fp5-pmic-glink-dp-216b76084bee
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2

This series adds all the necessary bits to enable DisplayPort-out over
USB-C on Fairphone 5.

There's currently a dt validation error with this, not quite sure how to
resolve this:

  arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dtb: typec-mux@42: port:endpoint: Unevaluated properties are not allowed ('data-lanes' was unexpected)
          from schema $id: http://devicetree.org/schemas/usb/fcs,fsa4480.yaml#

See also this mail plus replies:
* https://lore.kernel.org/linux-arm-msm/D0H3VE6RLM2I.MK2NT1P9N02O@fairphone.com/

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Luca Weiss (3):
      arm64: dts: qcom: qcm6490-fairphone-fp5: Add PTN36502 redriver
      arm64: dts: qcom: qcm6490-fairphone-fp5: Add OCP96011 audio switch
      arm64: dts: qcom: qcm6490-fairphone-fp5: Hook up DisplayPort over USB-C

 arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts | 110 ++++++++++++++++++++-
 arch/arm64/boot/dts/qcom/sc7280.dtsi               |   2 +
 2 files changed, 108 insertions(+), 4 deletions(-)
---
base-commit: 417c2d4ed67b729abea7dc73d7fb2153b7154d31
change-id: 20231208-fp5-pmic-glink-dp-216b76084bee

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>


