Return-Path: <linux-kernel+bounces-389479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE2A9B6D92
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 21:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 157CF1F21DC9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 20:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96C01D173D;
	Wed, 30 Oct 2024 20:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XICBmOKz"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCE81BD9D4;
	Wed, 30 Oct 2024 20:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730319927; cv=none; b=qRqvRk9b4p0Tibff2f9IqEhPn0470rhe5nJlUJ8B486HYdpxRBNgtzLwpsOW5Qlql+j45Shj5turyR+80vgMJyBdN63gAmVgVA2iWK5Hw+WYTb457G0+uyBM3tMIcSHL3nZ/sLT1g/rQLEnEZ2/wdGq41OJoKOnM8yyzq4tvdC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730319927; c=relaxed/simple;
	bh=QN6MSFbSt0yh8czUjSmnBq1ueDBBwxCetA52nbnP29k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f3IHrpHeKNQS0Ey9SJ5wyvfswEm6umXLl9bb7K9kH14XZOhXCRFTaR9ONFTEW8hPp3Ch/5t0d4Nz8RpzL5AWFv8Bm+uL+dne/11h5EnA4ZXV0PYdga7zUEBCcYw+EmTszoGrzPcHZcyLN7SG2xhOWiJIiGyUGvThWFEiImL1ZQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XICBmOKz; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-539f53973fdso210617e87.1;
        Wed, 30 Oct 2024 13:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730319923; x=1730924723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d/u+gOzoI/Ju0naSJU7xEVGZdDUGJ7r27JpshygR/dg=;
        b=XICBmOKzhvCj/OJH5QlFXU326yjPEDVVyV7uK4PMFVE++9oV4LmzZYWEoBN537ceLL
         wDD8o8ABmJ7OB5eFZH689LrsOYAz+7Xf9QwH2e8t4NtLp75yvRGVWusuwMbgDXE0FF3i
         tVr9ysUPnyRPRRZoqeGBvb43GmVoCRqjZSvnGAWXbAhBupoxG0juHrGm0RJpCwXhsEjc
         G5ZaSHGLZ3HBm0RQxd0vSWHkxiB1oTE66VHRAAJqa7iNVhqS07LotjCaF4GEF0sEYcve
         KET8b5OzFM4SIjIiZ0OUwKhoOOStVRkKNv/0sOkaugtEb+icgeKeoH8p2SO0pwr/ZlM4
         ziTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730319923; x=1730924723;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d/u+gOzoI/Ju0naSJU7xEVGZdDUGJ7r27JpshygR/dg=;
        b=voStTaIRdV5l+eddoo2iUu6LLw2lk0HfjPXkUws8/JNxhgcvDPuWlagp37CjMpHov8
         vFW1dWllp+mDuZgB4EHbFXVL36vNYvb8B2a5mRsTMFNHpyPvsm5u05wG9S6ZqSfHkSIx
         Q5uJNEetm+oZZQHYayqkCtWRp2CyebZHmG6Ey3etD3bvHwKm/IjJ0tTt/Ur3/lK2di/b
         NXXg+7zPYCA+fAWkS1FZ11F0DgczPHOmMGd5OgQEGIu4aid0tjZxxJYyvCAhb3YALJTt
         gOS7KvbgHiv1WqzwJXsrDWdDNNQCJN7iupG5ssZ+fJXFUg0RBwwn0McqdNupsX7rM32p
         Yo8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUaeq9GjWnpvXhiDa7vzqF9YBlBRKD87NUg25FuuTlhXoouIHjPUWwBmC/pTwBZrjr8KoVdkPnfc9Qf+Og=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs5pE+mMy8Tm6XItGLe7qa/hSVpvQBMD/OtgJygbPs7H0gHsXO
	fV14uOCYX0KK26rBiXc5VcKGEut2U4uIC9P6a+TZMYFEoWAKklxw
X-Google-Smtp-Source: AGHT+IGkxRIrT29z+dGSuMPxqZG2brU8VM3Jmu4a2uWHhYJfat89wSUyA2Q2OF2Gvtb67PHFl+cwZQ==
X-Received: by 2002:a05:6512:2808:b0:539:fcaa:d0ca with SMTP id 2adb3069b0e04-53c7bbe0907mr966e87.13.1730319922783;
        Wed, 30 Oct 2024 13:25:22 -0700 (PDT)
Received: from localhost.localdomain ([91.90.219.38])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53bc0d6ff10sm334644e87.269.2024.10.30.13.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 13:25:22 -0700 (PDT)
From: Dmitry Yashin <dmt.yashin@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Dmitry Yashin <dmt.yashin@gmail.com>
Subject: [PATCH v2 0/2] arm64: dts: rockchip: add Banana Pi P2 Pro board
Date: Thu, 31 Oct 2024 01:21:42 +0500
Message-ID: <20241030202144.629956-1-dmt.yashin@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series add support for Banana Pi P2 Pro based on Rockchip RK3308
(RK3308B-S variant) made by Shenzhen SINOVOIP.

v1 Link: https://lore.kernel.org/all/20241028213314.476776-1-dmt.yashin@gmail.com/

Changes in v2:
- Drop ASoC dt-bindings patch (applied)
- Fix excessive board naming by matching to other Banana Pi boards (Heiko)

Dmitry Yashin (2):
  dt-bindings: arm: rockchip: add Banana Pi P2 Pro board
  arm64: dts: rockchip: add Banana Pi P2 Pro board

 .../devicetree/bindings/arm/rockchip.yaml     |   5 +
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../boot/dts/rockchip/rk3308-bpi-p2-pro.dts   | 362 ++++++++++++++++++
 3 files changed, 368 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3308-bpi-p2-pro.dts

-- 
2.39.5


