Return-Path: <linux-kernel+bounces-247825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B941392D51D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 17:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74811286704
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 15:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7251946BA;
	Wed, 10 Jul 2024 15:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P7pVDO2n"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641361B809
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 15:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720625805; cv=none; b=LO02FT2OdPkca9AZzmMB+LTLL/FjnGxNZ7zO7kafLNy9wqPx/8qH+WhbkAnn9XwXeWOHs/A8FLhv5r001xSSLfVztkNsfEXBg5LX7xCrBhUmXgTh29BIk+q4uZJLR41mwY12TU1DwOho7c3JeRJ/+rYbNP/sSu/WlPEWIP/WdPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720625805; c=relaxed/simple;
	bh=nGxZ7+sPfbSD9L/xDpQMGSDenouM/MQtuKp6Pk5Sbis=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qfskUr29g63N3aUSnuU13jQDkXiUE6xrpvlb+bw616RVa//GknqWWfq54DjhmN94HRWBqMUdeXtvue2f5YezhcNS6RK9S/tGmIudLz4uEmeggcyHWafrkJ68QCPPpr+FuvYkflk5xSn4O2O25sRsKNovBEgonF3K5sPYQX4p564=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P7pVDO2n; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720625803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=q5a8aqf2Qw0uN2DWbSw9HMcPNkfGMcvI4EjXKVoTQf0=;
	b=P7pVDO2nasG0eqxqYaRrjT1bpRhxqT/3Un3+CzkPriMopqHpg04sapodzNiPQTirF6HBzN
	kR4yWdLhoS9MvR66w15M9cYUV2nAtm0f/zGGY+E7svOosRmMloBzgXbKIix2nhhLfwZ3/U
	wDin2bKZj1YzeDAYeKb38QSM3m9JZ+0=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-9Cx1IfBfN2yBATSlkrqqAQ-1; Wed, 10 Jul 2024 11:36:41 -0400
X-MC-Unique: 9Cx1IfBfN2yBATSlkrqqAQ-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6b5e96477ebso93074876d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 08:36:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720625800; x=1721230600;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q5a8aqf2Qw0uN2DWbSw9HMcPNkfGMcvI4EjXKVoTQf0=;
        b=EVAbbRs7sem63jDhaGAE/ATjwjlxANF7x6Z3IIbR2o3QsiH1kKaK4cgP1WFEBNbWWk
         A+R+wFluKzNopVy4RvI0gAXkW6Tafqxvs6zi1U3wl6G+vBWVu4UJVUOtCSfJ69x4jCbv
         vJVA3xjJrBgoGtyHwGCFZpPDQuE21u2MItSbG1nUtQ3EJO2/uo+2cm2D4e3w6t6vlZFp
         h5fjuhcsgh5D8dsAMr1omzJKH8D04sYU4uNXBd5NlZmD8UiUZNl4WKqHgJ4lNfCCbfFY
         ZrVOxJWiM/GPWC+2NV4Ddc7JjcskJg0mbVF8jX0G9qwF0QXPpxinZ3Lt0wLfwqWRXtjP
         ANqg==
X-Forwarded-Encrypted: i=1; AJvYcCX81ZcFJIEUzY+T6w13UA90ORhU7fttpEaL3Q9VMpTZsX15dbvOlwBm+RIjdnVJnuSeZ3Qnk5r/Z6NLQvNObDnuA3qh9FwWS34oUkfg
X-Gm-Message-State: AOJu0Yx2jb98REmK5f2w2SMX/v8dgWMCfyCqjD35ua9xM52QL9iqamre
	tIfhLYZqlnLm5pYGndUzudBjq/qDG+MLSQlKGQm5IYHOw3m5h/7ohJJmRBpB7XCEkcyQXPAG8JW
	EvE1t5rsIQb5U33Ji/H7YtBGbDLbzzOvmRC/YsXHQ5yx/jMB1IBRncyoRI8wam9e9kb6GezuqxQ
	uAqqUxaUP0Z1zyde44ciddJE0VRsKxJ6LNL2jLiK1H18sUig==
X-Received: by 2002:ad4:5be8:0:b0:6b0:8e78:34e5 with SMTP id 6a1803df08f44-6b61bc7e852mr74436876d6.1.1720625800155;
        Wed, 10 Jul 2024 08:36:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwwk9zMDFJHhokk8/VE/YUtae35sOvbKvWcXqT0wPDf6vvskCA9/qu0sN6NA6kASG1jbldgw==
X-Received: by 2002:ad4:5be8:0:b0:6b0:8e78:34e5 with SMTP id 6a1803df08f44-6b61bc7e852mr74436586d6.1.1720625799794;
        Wed, 10 Jul 2024 08:36:39 -0700 (PDT)
Received: from [192.168.1.111] ([2600:1700:1ff0:d0e0::40])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b61ba74d8esm17970576d6.94.2024.07.10.08.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 08:36:39 -0700 (PDT)
From: Andrew Halaney <ahalaney@redhat.com>
Subject: [PATCH 0/2] arm64: dts: ti: k3-j784s4-evm: SERDES0 lane cleanup
Date: Wed, 10 Jul 2024 10:36:12 -0500
Message-Id: <20240710-k3-j784s4-evm-serdes0-cleanup-v1-0-03850fe33922@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGyqjmYC/x3MywqEMAxA0V+RrCeQarHFXxlm4SNqfHSkQRHEf
 7e4PIt7L1COwgpVdkHkQ1T+IcF8MmjHOgyM0iVDTrklZwjnAifnrVrkY8VUd6yE7cJ12Df0zlg
 yjS+p8ZAeW+Rezvf//d33A8SWCvdvAAAA
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, mranostay@ti.com
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Andrew Halaney <ahalaney@redhat.com>
X-Mailer: b4 0.13.0

This fixes a splat caused due to overlapping lane usage of SERDES0 by
PCIe1 and USB0. It also cleans up the dts a hair to be more readable.

Link: https://lore.kernel.org/all/yhtb4clns57t7qo5yxil3oofisdlzfubyiwrvjo2ufw2ngv67m@g6p7ktxfgfv3/
Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---
Andrew Halaney (2):
      arm64: dts: ti: k3-j784s4-evm: Assign only lanes 0 and 1 to PCIe1
      arm64: dts: ti: k3-j784s4-evm: Consolidate serdes0 references

 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)
---
base-commit: 523b23f0bee3014a7a752c9bb9f5c54f0eddae88
change-id: 20240710-k3-j784s4-evm-serdes0-cleanup-871401b860b8

Best regards,
-- 
Andrew Halaney <ahalaney@redhat.com>


