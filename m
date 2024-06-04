Return-Path: <linux-kernel+bounces-201414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4598FBE2E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 23:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3317283FF4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 21:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A938314D282;
	Tue,  4 Jun 2024 21:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bSHlftcN"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4424A14BFA2
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 21:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717537358; cv=none; b=WW5idA37UsdG3qFIYlUpAC0AJ6GxP6KvePOjPqfLvWfxdJdaHi3uabNDyhnJ/IV1UoN/RH1bT2X6rBB39xoEW8hSzhwXhqi0H7n+IthZJjSMEvS3TwQDWA2TGhv739PIoSA3iiDpgjfV6G0DtqWupFG4sFvU1XmAO0dnlyfAYmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717537358; c=relaxed/simple;
	bh=vDctSeMuSiGp9PwhggSWKoGFj8wcUjkUW53LOQym6rc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rC2E1KN7XNh0jT+QqTUEdV0iLe5PJmHHkJz7TA14i4zZAzRCTXfbKnRSkSrc0zjb07XjMPo2L0c5OONBqf1DY7ltSOt+6tUXGYeZu1GR01qy7w75XxwU2R8LWWs6yw7kM0sXXnj8mjuc/NEkOP4bS9wYYWQVP6ku1P2jIKY1zss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bSHlftcN; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7025f4f4572so199268b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 14:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717537355; x=1718142155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q6Vw66yFGizo7QKpTFL7E/hug1hRafbghl++kv8rPPs=;
        b=bSHlftcNke+EtV0LSI7rgn6Hn1kf3+tr4/H+kx+jq6fOdUR2131YJy/DKkdNfSiFfC
         xd+JJwGrfCh5I4phXx1Q5aCr2yOy28KfjjMZEowKe7GAiBuZZ6HZMkHkrPb9F1KbhkGF
         E9xwGSxc5kuHUZpnDO+33YGh9PXX8Dg55M+3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717537355; x=1718142155;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q6Vw66yFGizo7QKpTFL7E/hug1hRafbghl++kv8rPPs=;
        b=LW9kovATi0N1YReC9gj/an3oWuyaX7aUvF6gxE6Ual0hMVGEmSf68wuORcyZF6Q57u
         B3VM+4tBaGvAqbVHibKZPyVaom65asER5tyZ6u+ogiG36yNULFUbcY/FuoJq7C6OtNRJ
         aw+b8XUZCNwVbdZMEUuctSWyxNWMCyKPOWkC4VQR9/yz7VPo19kltk8GcqbA56Jfm6wA
         ccRx5tAjegoa5urGd2FdUHjEmu3en0jwzXJLwZq4E0d5Vy/xKLdUC/IPWutuC7cOVF3p
         lAJORWTlP+4vCROqMiBWGm+Rhr3byN2MpdqTTjSlmFOJQnadmXagwaaEdSUoyo8N0RBD
         ScFQ==
X-Gm-Message-State: AOJu0YxhpacCnheRh+vjpjxs6pNgdyQO8FranoahY2h69c+NdOampw/J
	yVzs2E/dHTikB7cE4qkR6thNuz6mmYPk/PvH2U4nZeJ3z3ONC9+mFsK7NQ9g5g==
X-Google-Smtp-Source: AGHT+IFdOXCjV6WYTt/zwkB5UuQ0oRkBJqqgAgDp2qIDzzYVNu8sLTUOmr2dbUeuVyqxGp6ldB13nA==
X-Received: by 2002:a05:6a20:3ca9:b0:1ad:7e4f:9564 with SMTP id adf61e73a8af0-1b2b6eb668bmr1221578637.9.1717537355547;
        Tue, 04 Jun 2024 14:42:35 -0700 (PDT)
Received: from localhost (132.197.125.34.bc.googleusercontent.com. [34.125.197.132])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-6c35a4b973csm6365068a12.79.2024.06.04.14.42.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 14:42:35 -0700 (PDT)
From: Stephen Boyd <swboyd@chromium.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	patches@lists.linux.dev,
	cros-qcom-dts-watchers@chromium.org,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Pin-yen Lin <treapking@chromium.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Douglas Anderson <dianders@chromium.org>
Subject: [PATCH 0/3] arm64: dts: qcom: sc7180-trogdor: clamshell/detachable fragments
Date: Tue,  4 Jun 2024 14:42:29 -0700
Message-ID: <20240604214233.3551692-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a followup to a series I sent a few months ago[1]. I've split out
the dts patches and dropped the one that ties everything together for
DP/USB as that whole solution is still working it's way through and I
doubt I'll be able to get that done in the next couple weeks. Instead,
I'm sending these patches to reduce the patch stack and make that DP
series more manageable.

Cc: <cros-qcom-dts-watchers@chromium.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: <devicetree@vger.kernel.org>
Cc: Pin-yen Lin <treapking@chromium.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Douglas Anderson <dianders@chromium.org>

[1] https://lore.kernel.org/r/20240210070934.2549994-1-swboyd@chromium.org

Stephen Boyd (3):
  arm64: dts: qcom: sc7180: quackingstick: Disable instead of delete
    usb_c1
  arm64: dts: qcom: sc7180: pazquel: Add missing comment header
  arm64: dts: qcom: sc7180-trogdor: Make clamshell/detachable fragments

 .../boot/dts/qcom/sc7180-trogdor-clamshell.dtsi   |  9 +++++++++
 .../boot/dts/qcom/sc7180-trogdor-coachz.dtsi      |  5 +----
 .../boot/dts/qcom/sc7180-trogdor-detachable.dtsi  | 13 +++++++++++++
 .../boot/dts/qcom/sc7180-trogdor-homestar.dtsi    |  9 +--------
 .../boot/dts/qcom/sc7180-trogdor-kingoftown.dts   |  2 +-
 .../arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi |  3 +--
 .../boot/dts/qcom/sc7180-trogdor-pazquel.dtsi     |  5 +++--
 .../boot/dts/qcom/sc7180-trogdor-pompom.dtsi      |  3 +--
 .../dts/qcom/sc7180-trogdor-quackingstick.dtsi    | 15 ++++++---------
 arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dts    |  3 +--
 .../boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi |  5 +----
 11 files changed, 38 insertions(+), 34 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-clamshell.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-detachable.dtsi

base-commit: c3f38fa61af77b49866b006939479069cd451173
-- 
https://chromeos.dev


