Return-Path: <linux-kernel+bounces-227289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97BE7914EC7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 15:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C95F81C21F9D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 13:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2060F13DB88;
	Mon, 24 Jun 2024 13:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u7rTFSjB"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25A813D62A
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 13:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719235963; cv=none; b=pPpBRK0D5KcnZC78jDuLSmTl6dga797HDluErR73zUacnqAuIbGQfcoQkhoRhm5PzsfB3Gp9mpLWEQjxjMp+BZXvsNhhlYOvwVgXwbP5Wr0gROpJf6bP/PixcrZhIXicNJuufcgff2b5ofQAspkpR/sjtuXu5OLdx46ZPh+945s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719235963; c=relaxed/simple;
	bh=7KHXkSiw3G2cL0hHR90JF2g8MSUEbE7fJYE8XhmJ2hA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Lc66m35HRN5bKfUIERlu6FMA9i/gjv5tFcss/Qw8DmHJj717w6zue4KCUvH0UyDVKyJeYiiiSUeO9CKtdR4v6Yx2InUHNztxUOO+9xFW+OsXF4y9fVrvHLIgqpMVKYva1TpEm6Lc2X5RSetPGRwjlopI1OJW+5DBKkbZvBXc33Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u7rTFSjB; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3621ac606e1so3172831f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 06:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719235960; x=1719840760; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i63v09sV0tTGN/3CN/lUxe+ocEmeawwsZ2O+wqtiMdY=;
        b=u7rTFSjBRQOdJb/2ttfvtvUdTHxLJGwkxGdBRv2zt2ddEvaV9yV8CuZU5k8W2n+1Xw
         L21P8bETdjwNZwuZc9Q/1E7rVLHzIYBNIgdhAsj4A1ftaq0ScLWqiiCpvGRykBc25u9o
         FNx+OJTY4HQVjfgTob18S07F/WaKvseY3ap+tdZSSLpak2yKRpWTDRmJU3NIDw+ZLaqx
         txTQS9Kar8whOVUTq1hOKt3mJmLgQwU0A9S4BIRMpIKQVoeFUj/T2LzlxA+EkzJ20Dmf
         YiwVKovoXwx5nwcTg/MSmIbDWGK4WxeFQc9dzXHq8afb5NmOkKU1+kaf+QbRARbYetNQ
         cdLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719235960; x=1719840760;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i63v09sV0tTGN/3CN/lUxe+ocEmeawwsZ2O+wqtiMdY=;
        b=amKamUPGIbhzRvb2dAXC4M44oqyxFHnDhIc7NGVuUV0IBFEP8tp/sMj+fR0V3c7cix
         mryDTV6kFaI/JiLsxgg+qGxxapfKHXJ2eVSRidHqV+ak+t6kLkiHzETgGWxr9fXDJZWg
         pXI1KJVPsrzLvaM1ou/d/T8mW8BeRBFvj2SOe7AdOwzYlj3cOVEDV401hl7whJbuZtio
         GJpCZdICIOzk1vCls6aleLvE6emn3EGAybtaL6QBaeXp7l3B3Gxf3slzSskj4p5IXWA/
         spXChVuQ90gN4N4gSYwQxWEbuAJ+lU3ReL1Bb+xtNH5IYqvnXI1xPAqsdjIY6KgH7SH8
         3imA==
X-Forwarded-Encrypted: i=1; AJvYcCWDBLnAgN/HN6ZMq0J+/tp1FHDm9km6ZL1lTpYWxc3tek5mjg1GtYxeEiVfQWWdelYZ6mjQjkdxD7uymzk3Pcx96RtiImYXS8SEn7Kb
X-Gm-Message-State: AOJu0YzFG/HEGQtXLD91qzOdvQFwZu/T9IB3vEKmoSa/K90VKFcSklQg
	rYV3I75xbWQeISYReG4ckpjBNyXDds5wbLbGzcLuX7SMxvngq9kYe9flNMSq6yY=
X-Google-Smtp-Source: AGHT+IE4SN9gQRJbIu0u6FodUMhsPJCIqcZC7gf1k65l9XMDPiGEOXnzYwwzkZQjwtfhzTam4uGILA==
X-Received: by 2002:adf:f990:0:b0:361:e909:60c3 with SMTP id ffacd0b85a97d-366e3267fb9mr4464756f8f.9.1719235960019;
        Mon, 24 Jun 2024 06:32:40 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-366f7406f4dsm1888274f8f.114.2024.06.24.06.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 06:32:39 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 0/3] arm64: dts: qcom: x1e80100: Add soundwire
 controller resets
Date: Mon, 24 Jun 2024 14:32:35 +0100
Message-Id: <20240624-x1e-swr-reset-v2-0-8bc677fcfa64@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHN1eWYC/3WNQQ6CMBBFr0K6dkxbCIgr72FYtHQKk2irU4IYw
 t0t7F2+//PyVpGQCZO4FqtgnClRDBn0qRD9aMKAQC6z0FJXstYVLAohfRgYE04gVVt76xt78a3
 IjjUJwbIJ/bhb7z4+wUeGgMu0/y9GT8vRu3eZR0pT5O+Rn9W+/ivNCiQ4U+rayaYsXXV7UDAcz
 5EH0W3b9gPScq9jywAAAA==
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=966;
 i=srinivas.kandagatla@linaro.org; h=from:subject:message-id;
 bh=7KHXkSiw3G2cL0hHR90JF2g8MSUEbE7fJYE8XhmJ2hA=;
 b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBmeXV2FihPkTNyQFaxVnVV8Ez3xGG+fon5oAYL+
 0Nf+l5Y0ZWJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZnl1dgAKCRB6of1ZxzRV
 N80VCACmXKLC+CFKab5XrBN3rQA9JR1VEZIkPu2OWm9+AXi30FzKhuuSjsxgkXj3tbWhJzvAIgt
 y6ldwqxwuy5YPlnNKdALkICl9wshQz23JtQqaGSTikgrxRjSAwrzYXSWWGA1v+4+MmtibDgOPfj
 CDUSDoL6+3n3JiS7X37tch7wN26SdZSbhhgXH1A2jgQKBwZihRN9PHsaYJ17XbI/64KWKpDMSTU
 wtCLmGSGbItEe4ZVUwg/yqlnkLcq9XZ8i89we3DhRnjP7f/l8Sfc0dLZMxS1/jNpCRxPodsHAHJ
 gRADD17sgjKyFDVCDC8MyJaaNLMDevQ/Hya95I7evNf2CLi1
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp;
 fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6

Soundwire resets are missing in the existing dts, add resets for all the 4
instances of Soundwire controllers (WSA, WSA2, RX, TX).

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
Changes in v2:
- fixed dt bindings.
- Link to v1: https://lore.kernel.org/r/20240624-x1e-swr-reset-v1-0-da326d0733d4@linaro.org

---
Srinivas Kandagatla (3):
      dt-bindings: clock: Add x1e80100 LPASS AUDIOCC reset controller
      dt-bindings: clock: Add x1e80100 LPASSCC reset controller
      arm64: dts: qcom: x1e80100: add soundwire controller resets

 .../bindings/clock/qcom,sc8280xp-lpasscc.yaml      | 13 +++++++++---
 arch/arm64/boot/dts/qcom/x1e80100.dtsi             | 23 ++++++++++++++++++++++
 2 files changed, 33 insertions(+), 3 deletions(-)
---
base-commit: 781025f172e19ca5682d7bfc5243e7aa74c4977f
change-id: 20240624-x1e-swr-reset-0196fbf7b8f9

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


