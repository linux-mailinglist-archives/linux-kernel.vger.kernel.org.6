Return-Path: <linux-kernel+bounces-330947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB21597A65E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 18:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 723341F25270
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 16:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F6415EFA0;
	Mon, 16 Sep 2024 16:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XUgctqN5"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D66715C123
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 16:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726505913; cv=none; b=mmw21rhwB16KQyua0NMzNyEbfL7q9k5rdC6sVl9T5UH8+fPMqdZZq2PrNvZavyXCbckn5mYvWffUeP0gz0RAWLi7F1JyxK1mpjFwFGP77ibmnIRuoL+kHvAp0gMbf3Xw5QHB4l9MFGpTpsLcWRURuiKsrdA1OCUsTQRJ3z8IUJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726505913; c=relaxed/simple;
	bh=K3lXrcROTvdy6rGll9oP1BBWq/QYqnRnIwHnaiLNNwQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=luNqjvYXkcA/AwJ768jXlM5j/t2fHoCfxua1v8wjPVEcOwKnLVylgtB+Bx3fqij7AJYwgIzeMgiHrJ6opP8nn4E54lgkj9sMINVPBgM4I+5dHUOSEyq1bc+CprGghQA2AfZ65ukPzKXUpShRj0Op3fbAfkQ2gEGflZKvO4Q0vkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XUgctqN5; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53653682246so5380295e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 09:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726505909; x=1727110709; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yk/h5FBiZK67j4ccJbtxk7Fvu6fYbqtAXQZenT1Ni5Y=;
        b=XUgctqN5GYvPs/3K/Gyq0CMAgbcLGK/yz+l466y/NHAO0+aOSC5GtHDrcaTrljkY3F
         hLdmSfdlQXIOuqf4v/Xg+tvNRmLBZ29kfS2zXVXPKgbTMIVB8SBjTf/covrO6zZKdm3S
         3EZHkqPbZgge10Th0quLe0YD/sAJuVcCqNm3uiV0RTgec0CFi3Wa2X2sRT9dH81BJ0pG
         gCqRWj54eEVhwjmnrmXQmekeSsYjBaSdm7zQML55PGtHuo51Q78izmL9CKYBdCQwFC30
         TYURZ4jtyIYltINA7AKMJ5hkQgHaEJ8OQlnI3L7fMlodcIVeRwUpNiWCP8Qhmi08/Cka
         akqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726505909; x=1727110709;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yk/h5FBiZK67j4ccJbtxk7Fvu6fYbqtAXQZenT1Ni5Y=;
        b=mVY/HgI5lNJ6Hh1zsFHLQl9rCPTvioj/kUxs8GvYc5VPK/RtRmeIYjPzUtlL/bCGqR
         ZUi1YQQo6y/k9rStEcvmS4m47cKbBYceikQOMM50ET2W2mA9AhANX98QxqfJFHWuYw/2
         5kYvL0U9+bqktDNwEXHs+M9hG164cwTvW/ImgExerrXESFqRkhRsUk9Ymj7wypIAgizA
         SkqL6ViQ0hPgaLNzkAfqGy3UH6huCa4fc8hxL1tK2BeCSY8kk249tvINLHl72vPFLkt3
         /mXfWjI3dicdN51uGsiO1nnN0ozihSEga7o4IOGGTd/DvClK2erj/KqwF9u0pwGeQCdS
         qDww==
X-Forwarded-Encrypted: i=1; AJvYcCVjo52IrvG5Q0qf6YWnfU65oRzBtVlzNCF1doy+bGdftXw++aQe3Oa/DyfTufxKf5VFUYUEQjNL/nsLUvw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrAs3B3wmrOO9x4ATAm+3i5vDF5p3p3X5rKmMe82f+B6xBIoDy
	mFHXt6uiyNnzF5XhAM7G6dw+d67ICOHe3yQNWl0HJnh5h9rbRP/mtXI2PywXn7c=
X-Google-Smtp-Source: AGHT+IG1GyB4Uzmr1jsA2DlRryPeboo71WZg5vEXsdjAHjoidTLA1PP/1PSbdjCuFfXWUR7lA/E6iA==
X-Received: by 2002:a05:6512:15a1:b0:52e:999b:7c01 with SMTP id 2adb3069b0e04-53678feb0c0mr8003888e87.48.1726505908290;
        Mon, 16 Sep 2024 09:58:28 -0700 (PDT)
Received: from puffmais.c.googlers.com (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90979ceb67sm32992966b.219.2024.09.16.09.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 09:58:27 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Mon, 16 Sep 2024 17:58:26 +0100
Subject: [PATCH 1/3] arm64: defconfig: enable Maxim max20339
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240916-max20339-dts-v1-1-2f7ed7c24e83@linaro.org>
References: <20240916-max20339-dts-v1-0-2f7ed7c24e83@linaro.org>
In-Reply-To: <20240916-max20339-dts-v1-0-2f7ed7c24e83@linaro.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Peter Griffin <peter.griffin@linaro.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.13.0

Enable the Maxim max20339 as this is used by the gs101-oriole (Google
Pixel 6) board.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 5fdbfea7a5b2..c43df2164201 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -778,6 +778,7 @@ CONFIG_REGULATOR_HI655X=y
 CONFIG_REGULATOR_LP873X=m
 CONFIG_REGULATOR_MAX77620=y
 CONFIG_REGULATOR_MAX8973=y
+CONFIG_REGULATOR_MAX20339=m
 CONFIG_REGULATOR_MAX20411=m
 CONFIG_REGULATOR_MP8859=y
 CONFIG_REGULATOR_MT6315=m

-- 
2.46.0.662.g92d0881bb0-goog


