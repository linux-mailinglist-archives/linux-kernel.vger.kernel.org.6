Return-Path: <linux-kernel+bounces-412757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C499D0F3F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 12:08:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C9E3B27CB1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 10:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0260D197A99;
	Mon, 18 Nov 2024 10:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RkEEcc/M"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFD01946A8
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 10:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731926080; cv=none; b=LrrLdeOqjQcFCC+as5EPmcGmKalQ9MLBZyUkgBQUY7vGiXHJHzDzcKdgVve+QiOXf934DqRX49knhFRJ+5+3sxByliYaLPcN/Hufg62BE3430/G2BtFV7/jHp+gkZHfm4NscugL28SK3GG4ekc92IfCHNEDvJri9pPhYwjL04ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731926080; c=relaxed/simple;
	bh=XQsDyuRiau3IHO4Li1+Y+cuAubOEwOYf9EOJSmEbkBs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UbEdvCfVXBXrMtWP1PAwnuknzzPw69m/mMU5Pgyc5Fn26q0CTTU6tInkNt+wgFGBmR81n/cmfbBcgQ18z9v6SGOq2EBG3xdU1aErHcUutQXwWI/c5e6VYMQAqyAPB38HyoGNq4SPS5lNbrx5VHT753dDA4dTAFrsEIP8UgxzYa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RkEEcc/M; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3823f1ed492so583970f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 02:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731926077; x=1732530877; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W7YU9L/ihohCgSGV7XFCQCDHEXAXKVeCUTFSk43kuSs=;
        b=RkEEcc/MdVc4XeuUxPrXW7gCWcStT2vFV3AHdcGUqiXJptxZuuuGCD8zjAgqONl28D
         e8764lltzpNaZR02Tbvh9uIWYnkANSyvmdmekBT+i19iLfjKmbsl+p933o8UYR/kuOlR
         M+C0as/esy84Ww13qSH5cpRWqA+aY852nIh4f023ydNjXOX150eJmLoRreTrxmq1BzIf
         FOFvI74QfOABwlCtUhhOCm8PAigqzUYb8/x+Zww6aS3TsZOiU6FE6OsvIFrNdNp9ia7W
         4/l9lPCfZ+un6D6S8+CDo84yTHK38NCKU+E4LwW2tiyH5vmL2iQD0mOzAFcRNIJNFgVi
         7u2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731926077; x=1732530877;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W7YU9L/ihohCgSGV7XFCQCDHEXAXKVeCUTFSk43kuSs=;
        b=wJeHPJF6j3V5MhGXUXdNi2w70lLwsZs3opYO+vQfClpyex4NcFq51No4BDQ5CkzkNX
         3+lu7pvXHFyC2CWny18nwwRwBEg9b8GxEW8qOi64ZRDDeWMPRcyo5XBFCBBekYqLkfcw
         w+Oxovn9qeCSAMd962e3JBY9W8rPTgQiM89ZPR9HMYUYyzFsspIOnfdn+trS45eAXQrB
         PxPDiDs2Jr7n6ip0/6ei5BzZNlRtKBFwFMrV5mb8y8+FCZLrI9D8X4B+sMaguYS8AQ9W
         Mb/FyRq0bEqUcE8HNo3nygAsNZLvxWFKoHYfZCR2iCsKajwRbdmjXZjWZEdHOc6Bfo7c
         l6QA==
X-Forwarded-Encrypted: i=1; AJvYcCUe/FBXcnOSCSudjveYHCBEerE29VKvZpuq5VOBjXX2YvToNEsRxCz1SiiR1Pauo3nM7efLYI3ZCGiwmFA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj9EkWop+SuqAFQgfsQlSfZmh8JevFzx04F9pNwj9BXTd1zPz8
	7mwd4q+nxws0WzzFzytl0Xpd8XmIVbvOlsVhIPOqJfcai9maP3l31sfJ1F/lrfE=
X-Google-Smtp-Source: AGHT+IGwcJJL68jiIs4CpOJY91QszYJvr1I5b9vVKUwSfS1kEIk0ygwL6xoo18htvJHm4mOKTYcF8g==
X-Received: by 2002:a5d:6d8a:0:b0:382:484d:45da with SMTP id ffacd0b85a97d-382484d4782mr2179017f8f.6.1731926076817;
        Mon, 18 Nov 2024 02:34:36 -0800 (PST)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef40:5b7a:75b3:1e72:6e3d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38245e95925sm3162979f8f.111.2024.11.18.02.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 02:34:36 -0800 (PST)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Mon, 18 Nov 2024 11:34:30 +0100
Subject: [PATCH 2/2] arm64: defconfig: enable NXP PTN3222 eUSB2 to USB2
 redriver driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241118-x1e80100-crd-fp-v1-2-ec6b553a2e53@linaro.org>
References: <20241118-x1e80100-crd-fp-v1-0-ec6b553a2e53@linaro.org>
In-Reply-To: <20241118-x1e80100-crd-fp-v1-0-ec6b553a2e53@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Abel Vesa <abel.vesa@linaro.org>, Johan Hovold <johan@kernel.org>
X-Mailer: b4 0.13.0

It is used in many of the Qualcomm X1 Elite laptops for additional USB-A
ports, USB fingerprint readers or similar peripherals.

Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 0b8303eb498d..8b17d70b3b58 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1530,6 +1530,7 @@ CONFIG_RESET_RZG2L_USBPHY_CTRL=y
 CONFIG_RESET_TI_SCI=y
 CONFIG_PHY_XGENE=y
 CONFIG_PHY_CAN_TRANSCEIVER=m
+CONFIG_PHY_NXP_PTN3222=m
 CONFIG_PHY_SUN4I_USB=y
 CONFIG_PHY_CADENCE_TORRENT=m
 CONFIG_PHY_CADENCE_DPHY_RX=m

-- 
2.44.2


