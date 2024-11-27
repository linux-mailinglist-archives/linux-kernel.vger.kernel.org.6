Return-Path: <linux-kernel+bounces-423357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF769DA644
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 11:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEB00163044
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 10:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A681E1029;
	Wed, 27 Nov 2024 10:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="INu+BY+B"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BB61E0DE6
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 10:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732705097; cv=none; b=V9U9tNXzxgqP79UUeE6pNk3LrH5vulOKZ5IYDfLgsh8BULeSeqAYCABXb5L2CbBDnOH/JgpW787SxKSKwK+ejOfarO440Bm0TvTKIY5LT90R/8SCTuFvYeCAhoHmJ2sKXc4JR0onDxLtAIE/vXlaZyb0ZOYJyns4MspEFZMbVgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732705097; c=relaxed/simple;
	bh=HoOWfskOM/L20/Qi5xKqj5oCq9iYQQhysTOwTI0G2Xo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kaoGCqvu2oj9tlHv69ytpdygmMhuTRjpmJzudzs1WuUc3PQI3tHmp3YhVMoUwiHUrJd98zVZtIrdAzrsp0V99pmQnDjFN4x8Qwx+71pW+j/oHmUdvfP2PLz+HJkRanvyoGsy9BvHhnLtAzt/hjEO5LpE+rnJCDxtXrLphMzHLz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=INu+BY+B; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5cfa1ec3b94so7666383a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 02:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732705094; x=1733309894; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3jtF9ci8OPnOP4Hi31zRxsQ8dcNSQiS08yT+hSgOwYg=;
        b=INu+BY+BPm2TSfOsOAdv7Ew/mRHGZVbUAopTmZ1DCG1nvN06Qv2gKcoSwJSl73v+Em
         ecytZzjZBivNRAESQcitRPTzK97xhpbExVMBl45ygtUYtklCBpjgapcoxLRKw6Lo10gh
         5Wj5gTjqMyg5bBWFzPhcJ5UHNZDd7lxZiC18e7TdDo6PWcXtCqYLURf/3tljvrB/2/1V
         rV6JpgYRSn02eG5NTTg/SEpcoqvHHUx8E4GaQYmf57nSwabokKoGapRhCkD6/VJU0lhY
         bi24aTXk06uWZLFTw9qwBl58BmeYPs+hMAJOW+qS4Q6mhtTYcLrtXzCyqqWHBOwm3xIb
         0R5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732705094; x=1733309894;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3jtF9ci8OPnOP4Hi31zRxsQ8dcNSQiS08yT+hSgOwYg=;
        b=Pa07pyraoC9pF71AU/PETgZKlpAIGI0rkT/bPtoCd8je60yWPWSewhl5GylO5D62O+
         SwVOTXU7cI5TxBQesEoNVl5nmqbGpgj9cfBesEEaHH5tGk/U6M9PF4pNGvbsg8j5yFBn
         xsunhqoHZ9+EtbUrE2T+r7gP3yOXyKtpq6YbqXKTs6bbS3oVhyAwxVoIt4XSEOgOobS3
         LCrARA8Ke6Te626jSR4DnOLM3sYKW2oE/BQc8ZN/8vaGzmrwQ3PAJAT+gnc1ZhvU7dne
         yTX2wSSgAHjHmi9b3Et8GeKNGOjmu42QnKEpVSeQXh2tEamm/mtyGwji8aN8lR36v4Nf
         8Y/w==
X-Forwarded-Encrypted: i=1; AJvYcCXYsx85d8vyYMDprDDf9qtRgKLcrqgKwVPpfB2mlkr19e0BY8r1dhdJPvzVDiSFLxp2NOHss9rcXFQYeY8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRjxrvJAmmgxWPNR+IZwsNUICuisFgL3TQnV+pE2Mtx6W5Jdax
	Pi5GJiAQpKJTUUWT5QWcOdIPUhtr8uwleY+sPLkTNyd7jrMSIfYUOK1F/qVbh3o=
X-Gm-Gg: ASbGncv+8nIsPpJGS8DLa5rabBcQE0AKRHR6mDjOwBJZAGmXeqMXCiF2gFHQskXMc/E
	28uNdsqSZHxeBzNsAuq0qrkOGFxoRp+PDowjj1Z9xFIhE1TOJ5FW4VUEMjjYX3cRaHS+bHPjiY0
	j6uaCS2n5PV+9s5ZJw1jhkKN2s1zI9CwwJ9TQoj0wvBmqqBhaGX/A+h8zXrcHbjFA5UDHDXPC04
	H5+k1srek33MNhLamUw33A0G3XJWbJk5c0HZYVr5NNmwxgqTzCjIQPHesp4BkcXWhlt6gm7FQJ1
	Jk2ddtO/GMcpNLB6Qc7BNUW33pqyCI/3tA==
X-Google-Smtp-Source: AGHT+IGpI0XPyLOxUc3SxNULKeFDjg8DEK2PQJHajpwT4G6OmiaLmyMslU+q4NFnVHObUoaipseY+w==
X-Received: by 2002:a17:907:7711:b0:aa5:12dc:2e19 with SMTP id a640c23a62f3a-aa58107690fmr187546066b.52.1732705093727;
        Wed, 27 Nov 2024 02:58:13 -0800 (PST)
Received: from puffmais.c.googlers.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa54a6db906sm412183566b.41.2024.11.27.02.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 02:58:13 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Wed, 27 Nov 2024 10:58:13 +0000
Subject: [PATCH 3/9] dt-bindings: phy: samsung,usb3-drd-phy: gs101: require
 Type-C properties
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241127-gs101-phy-lanes-orientation-phy-v1-3-1b7fce24960b@linaro.org>
References: <20241127-gs101-phy-lanes-orientation-phy-v1-0-1b7fce24960b@linaro.org>
In-Reply-To: <20241127-gs101-phy-lanes-orientation-phy-v1-0-1b7fce24960b@linaro.org>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, Roy Luo <royluo@google.com>, 
 kernel-team@android.com, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.13.0

The USB PHY on gs101 needs to be configured based on the orientation of
the connector. For that the DTS needs a link between the phy's port and
a TCPCi, and we'll need to inform the phy driver that it should handle
the orientation (register a handler).

Update the schema to enforce that by requiring the orientation-switch
and port properties (on gs101 only).

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 Documentation/devicetree/bindings/phy/samsung,usb3-drd-phy.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/samsung,usb3-drd-phy.yaml b/Documentation/devicetree/bindings/phy/samsung,usb3-drd-phy.yaml
index 6c17a44718aa..0659fc1ce13e 100644
--- a/Documentation/devicetree/bindings/phy/samsung,usb3-drd-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/samsung,usb3-drd-phy.yaml
@@ -142,6 +142,8 @@ allOf:
 
       required:
         - reg-names
+        - orientation-switch
+        - port
         - pll-supply
         - dvdd-usb20-supply
         - vddh-usb20-supply

-- 
2.47.0.338.g60cca15819-goog


