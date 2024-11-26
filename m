Return-Path: <linux-kernel+bounces-422188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2059D95A4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 11:36:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 954851664C0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 10:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E031B6CE6;
	Tue, 26 Nov 2024 10:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hChHMJIL"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAD618FDBA
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 10:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732617398; cv=none; b=Z0VunJmSxEgYU3i33o9VVBTbipw2zRkoaoMb0mBLo92n8Dbh+fGo0g2X3oLyHcxkyvMRDibz2r2ADCJyUf3zgc5vMfHSecBZJFbNDx0pOINJTEWS/Vrm3G5fTJORycXGvewqzCx7za41jfU4p2rcIkjV7teY+eYIiWsRYpoT/DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732617398; c=relaxed/simple;
	bh=2d22fSXH3xHtYPQeuQ5/HB+WWNcQefsX3YBG8H/58B0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ToH5Le7heJQ0Poa3YkSOQGrjUOZns+/uvhgTzj2f7rdQ7rnj6WEH70TKdmna+Z1QQLuRAJR+cdGv1jGX5Y86cEY0D0sCekM3KTCRw/t3Bx5aySlL1sHHl7b9BZE7DAjEAZrNAVTYDvdEwJhCpiBqRUeK5O6LWHIbhmEdbVp40gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hChHMJIL; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ffc3f2b3a9so29068591fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 02:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732617395; x=1733222195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w9WF3O3Q9CqJ+jQNAGLBDdeZMuKGc8yveqCJFxa21hM=;
        b=hChHMJILqQz32sUdizG7YcSxmhh92GE4neRI/rqgf75g5SkAJ2Zb1Dx7MRRzynU3lp
         fYY03esQe7T2RJPiqwaLElPSgKIiHDe8hpV366mJWKLsrcfT52DBVywOuhewE9GPxjED
         uENsjQaTB2mMkQ4cTMvWRdhxKuuSlYCmDY1zQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732617395; x=1733222195;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w9WF3O3Q9CqJ+jQNAGLBDdeZMuKGc8yveqCJFxa21hM=;
        b=DjOOu41PUgoZ2zfMmSAS1suKJYY16jrJKlNGkLrlOpc/B1fdeoujd7jnVIZXwepG8n
         IDa6beipsor91TkKNv83ix21t2Fvs4A7UgsXgPqlANQW20J00WiIpAop1AfgY/znS9+P
         kspsqjrxj2yyBmy+IfdO185iqg9M4tLKtuFdRamejlcIPV3ueiPQ1jmv0l5w1B+/b2Zu
         ru6wTkbsO33nQ7ZcDac+wsKkBDwDvIdcO5fR9HGiahKneZSXhdN68bHQAN84BsCF9X2w
         0PUY3dZKmZl8Usdn7pWMeJFhry9q2uIHGx2bf5l/7+SBcT0HCb6pib1EwgtYphp5K67g
         zx1A==
X-Forwarded-Encrypted: i=1; AJvYcCViLomGo24URGGVMdhgcTcLWmrcI2Bf/wPHlWfKg3p4mkbmePA2kzJz0Tes6UQmLDfc4362Hxjf65pXeCA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjiO/VzBwB1X5e89SI6pG/5mKk/I0AGY7enFmzZltAhiBOj4jt
	ULWDJUMPYzpLh7njr6LzQlZt1+Pyvfusau6EcYY0OLBUCZFRMpGOY6JTSOwJXA==
X-Gm-Gg: ASbGncsBVT6lc6uYQekXmaMG7OkJyi26U2XQApakKx9s+YNT6GRdQpU7TYmgnETxkr9
	mzWxXtE49vKIS8Ms9dQGVa1BasueoU+ab77wwzOi/xifh4+ejRBm32VeWQetwo/QfNMHJ7+1bU/
	q7uW7CKw3PVFK6/eo35ttyf+IjKVT+eVIuSYvY4yqCAw7R4Aum7/kBXCJaXeU1cyts3ZrPnIqYR
	J9ku/K3MknxnHSMnc/4imzmuiCnijmKI7RnN3rUAX+UVSAwjC3R6dWg16G+L+l6SHKTJBiNUuNR
	OMXLtTII
X-Google-Smtp-Source: AGHT+IHUd82WHFzG3Ngfmo9+Qx0VDQrc7wt1+aqc5AYj5jle85lRZhKtCbEOP9pPHyNo7rQmWMAmcA==
X-Received: by 2002:a05:651c:54f:b0:2f0:27da:6864 with SMTP id 38308e7fff4ca-2ffa711f902mr117712941fa.17.1732617395232;
        Tue, 26 Nov 2024 02:36:35 -0800 (PST)
Received: from localhost (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-aa50b5b6e9dsm578926866b.172.2024.11.26.02.36.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 02:36:34 -0800 (PST)
From: Wojciech Macek <wmacek@chromium.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chen-Yu Tsai <wenst@chromium.org>,
	Rafal Milecki <rafal@milecki.pl>,
	Hsin-Yi Wang <hsinyi@chromium.org>,
	Sean Wang <sean.wang@mediatek.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Wojciech Macek <wmacek@chromium.org>
Subject: [PATCH v3 0/2] Add support for Starmie Chromebooks
Date: Tue, 26 Nov 2024 10:36:30 +0000
Message-ID: <20241126103632.419469-1-wmacek@chromium.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an entry for the MT8186 based Starmie Chromebooks, also known as the
ASUS Chromebook Enterprise CM30 Detachable (CM3001). The device is
a tablet style chromebook.

Wojciech Macek (2):
  dt-bindings: arm: mediatek: Add MT8186 Starmie Chromebooks
  arm64: dts: mediatek: mt8186: Add Starmie device

 .../devicetree/bindings/arm/mediatek.yaml     |  13 +
 arch/arm64/boot/dts/mediatek/Makefile         |   2 +
 .../mediatek/mt8186-corsola-starmie-sku0.dts  |  31 ++
 .../mediatek/mt8186-corsola-starmie-sku1.dts  |  31 ++
 .../dts/mediatek/mt8186-corsola-starmie.dtsi  | 465 ++++++++++++++++++
 5 files changed, 542 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-starmie-sku0.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-starmie-sku1.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-starmie.dtsi

-- 
2.47.0.338.g60cca15819-goog


