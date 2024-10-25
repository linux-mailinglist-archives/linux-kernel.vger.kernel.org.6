Return-Path: <linux-kernel+bounces-381206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1119A9AFBF1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 10:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB5F21F2424C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 08:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095DC1D1F4C;
	Fri, 25 Oct 2024 08:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UBvQFnOc"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3C71C4A2E
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 08:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729843438; cv=none; b=dq/qC5hnI3L+9faltG4LN1waxQs0W9mRyMzfOVMwqgqpueBPZg01z2dSTZmHUc/tGkQqe6hMIo2FYsQ7qXvS+pY4sSwy3fomc4Cj7Y0lvJjA3MuMFGIxkm3KZ27Mh9YCmTgldv/5DqmXWt4D/hr3by0m/rM0m1mhvZ38lLLb2wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729843438; c=relaxed/simple;
	bh=YNGgZAthKOQL0rBfRyNKs3BL2tQTXjxN30E5SWsM/Fs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JexUEp2lNjlbDABQNZDUOotH7wMSVQ4iEhm90jfrDHxe4veVMwZXxo71XAxoU9WfV2hr273wHgYLP9Tqis08Zs8a7DJ7HexiRQIi+9GqNyngTOjvj+8KZQBkl472D7usdNwwBXoUIQeljdjDflef2nS8pyg1uDV6G0y1lxI3iuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UBvQFnOc; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-71e52582d0bso1288052b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 01:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729843436; x=1730448236; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V426SONJx3MLBE2ouij2w9iGSgsxKgZI4w/+L3SS0B0=;
        b=UBvQFnOcYHWubgrmz7p+u9ntHHwVLjuDl9ANAqTbWZeVxV4MpMprbJXyAG7TeCL2o5
         HjeLxoJ1R2WWSJrUAzZpUzllUv+CObatDvbhm4un2SA6j7mmMD1BXZlEIMADKTRSywfC
         mkcik8PdzFqEyUGlkrrpZusFJGsIGinoxd/Pw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729843436; x=1730448236;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V426SONJx3MLBE2ouij2w9iGSgsxKgZI4w/+L3SS0B0=;
        b=SJi6l1jSCBigW7s9HO+l+nRA/SuLR/U5I6uSTBq5VridHhicexAIW1DajTRmsyNnQL
         UEud6iT3gxsl2Cy/Zs1TAvIRq6ps5i+99Q8+fUBTWpgdg4HIqC/1wWHQr3Y3ZGKddA4G
         t0zqm0BILWrvIvJn7v9clRGU6rkLvDpiTIeEEMArSK8DcWpSiqfLnXhgexR32HQSe0GZ
         UvPyLKd4mcnlhbalXxYSDWByhdyxfe9C0q52gg2vaLfmU9nWHUOCxxynCo7eRLJay/nx
         n9Ttz+8DF7gpGDH/Yft6PULWIKB44hhhpZm7PJ6bg2fWaBg19HAMn4VlRdjRMzOOqbND
         otpA==
X-Forwarded-Encrypted: i=1; AJvYcCXwWt7Shg4hnoEAv15O+jk6eCjKq2TZ6+maz0RqvbhZAApCBk6Q2ARsFfv+RF49NzWmnuMYgOPUqPmRCm8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxlq87iFDJqCH3irKVplj4kjACvP78hNH3tIp+zCYJY2W/pnlVS
	T/EqW3pFa0BoOvlwColBXbipUYzZKK+2aIR6/bqwPkFnUXKdJJIsr9PZz9L9Lg==
X-Google-Smtp-Source: AGHT+IGPF7HJ8L3nCZ+GHTH78bcR+LvoLHRv7xDwbVUo8kTsgGTY9/4E2fHll3lkd4t166jBzlSafw==
X-Received: by 2002:a05:6a00:194d:b0:71d:f7ea:89f6 with SMTP id d2e1a72fcca58-72030c6f2b2mr11752920b3a.18.1729843435814;
        Fri, 25 Oct 2024 01:03:55 -0700 (PDT)
Received: from yuanhsinte-p620-1.tpe.corp.google.com ([2401:fa00:1:10:5a9f:16cc:8d5a:55e5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057a0d025sm558120b3a.101.2024.10.25.01.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 01:03:55 -0700 (PDT)
From: Hsin-Te Yuan <yuanhsinte@chromium.org>
Date: Fri, 25 Oct 2024 16:03:48 +0800
Subject: [PATCH v2 1/4] arm64: dts: mt8183: fennel: add i2c2's
 i2c-scl-internal-delay-ns
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241025-i2c-delay-v2-1-9be1bcaf35e0@chromium.org>
References: <20241025-i2c-delay-v2-0-9be1bcaf35e0@chromium.org>
In-Reply-To: <20241025-i2c-delay-v2-0-9be1bcaf35e0@chromium.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Hsin-Yi Wang <hsinyi@chromium.org>, 
 Enric Balletbo i Serra <eballetbo@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Hsin-Te Yuan <yuanhsinte@chromium.org>, 
 Daolong Zhu <jg_daolongzhu@mediatek.corp-partner.google.com>
X-Mailer: b4 0.15-dev-2a633

From: Daolong Zhu <jg_daolongzhu@mediatek.corp-partner.google.com>

Add i2c2's i2c-scl-internal-delay-ns.

Fixes: 6cd7fdc8c530 ("arm64: dts: mt8183: Add kukui-jacuzzi-fennel board")
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Daolong Zhu <jg_daolongzhu@mediatek.corp-partner.google.com>
Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel.dtsi
index bbe6c338f465ee7c11bfbfc30767bdb142706480..f9c1ec366b26607581c116b364cc2f80f8621a57 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel.dtsi
@@ -25,3 +25,6 @@ trackpad@2c {
 	};
 };
 
+&i2c2 {
+	i2c-scl-internal-delay-ns = <21500>;
+};

-- 
2.47.0.163.g1226f6d8fa-goog


