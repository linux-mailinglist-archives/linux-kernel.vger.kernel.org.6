Return-Path: <linux-kernel+bounces-330320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD11979C88
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 10:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85F61284B15
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 08:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A0414A629;
	Mon, 16 Sep 2024 08:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zenC4e/3"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF22A1487E9
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 08:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726474134; cv=none; b=TEXj1+r6UnXJYNCjdgHRG/MwP3Pkxie8j83KNYarh7Cg/UR1YUgH5oa7PH2pGCtT3W9+IWSNTryRV5XVgL3aK4/urtoQ46WkndMwZWsbODEASZfXoj7l8Gk0UX/iXEUAcycu5JCkzwzXm6OcAy6YnCLN4IaYsDt089IctTXeu0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726474134; c=relaxed/simple;
	bh=IX5ZFj1FormQAKEsvBJqiSBB66gwgLEwGfZq8lM9Ze0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bLW9GEMOFRrNTFwGJUCrOcg4i82nxVENyml/ghZQarHQCEDzh4hVt6NElmUak57ybhO8JmmxGhNJ7kgWC+/5ZgwyPuB493RxZUnwYzV1CFAwKoEYBXw6XpL84K+5+xSbGpSwVvWxhuL8YuIJh861iAkN2n1+X4FpzhHa8aevkTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zenC4e/3; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42cde6b5094so32581595e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 01:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726474130; x=1727078930; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1eJN9EUrF+mtCv7v8IjDGJqaK6GCUYx9tVtkrONiwQQ=;
        b=zenC4e/3cQtHvL0aToo69kQ7fbPXhTTYX3J0VRpOlamv7P3L/6aTojKz6gRlqeUzs+
         3VFW86IK6EhEnzonpf+7KcYTDbZIZuMflPijyHUeP7XMJ7dQpsu22tHUCd/Fdmh9gA8w
         GGbLskLpXqmctC9nAB6nd5ZrW3VrH8gsbjPsK56Dna9DW8xixrnSYNswrSnk4Ia41TFG
         PllN2Z3FQRSqo+PvymxDAdHQBbdlqs0Qqx+tkwt4Mw2jgoIVL0zHE9tD2vKb7FURVDpn
         BNS0itadu1XwKA19mF/F54batmPLrlfa878Oucyb5/+f7Q3LC8dYiNXHaZmmthhdEFyh
         GdAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726474130; x=1727078930;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1eJN9EUrF+mtCv7v8IjDGJqaK6GCUYx9tVtkrONiwQQ=;
        b=I7bZSQY59a94OfC32EmGQrrrv7XMEWarzN9qHuzHNeKO452/zwwVD+Ib0X8jsVZrg7
         5IdCH2hFl54kXqTnO9lj3umIABE8fR5/O2L7KcsJCGVndu0tAUBJwhghaaIuQDNyGwY0
         DCnhkcA5aU+f0vISI05DJ+j89Ee+HSAhTxCG0GJQLjzdW1YQu1HddOujTXPNL42OsReI
         mzZQxT5DTculeTHLV9Kk08a17IkMy4d+nQLa6FJFjj2L0cqltDxpXIyRRHdvHBxNnGrZ
         1dyLiuwrwV2H4ZNPBkB38VjkUABHd7UfQuCxkF3/ZpiyJKfxXLtxq/frahigAm7T6t+1
         KafA==
X-Forwarded-Encrypted: i=1; AJvYcCUDDdFquuZir0ZX5DnSO+bgVUiKrZ77mqqS5pPkYfMXY8Iyr40KldijYLrC0etegz/68LLDq6x7Dgz46CM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx16/jJA1W2Q/6sBlr+BVE8HbnVkSERGfJhhrLdddaXDtNi1Dri
	K3kBlNshYQG1LFNNmEyY5ip8mWDyVjW+1xCoC+FkRONPrtZ7cPJLV5hPcPIY3gs=
X-Google-Smtp-Source: AGHT+IHaWC/S2zT9Ky6i8PYfd4kfDoDe/O0upMkirvhwlpdd7sdpz6GyZCzCtOIrMuHidaEXyAE82Q==
X-Received: by 2002:a05:600c:5127:b0:426:67ad:38e3 with SMTP id 5b1f17b1804b1-42cdb531b27mr109286915e9.3.1726474129956;
        Mon, 16 Sep 2024 01:08:49 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42da22b900esm69309465e9.1.2024.09.16.01.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 01:08:49 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 16 Sep 2024 10:08:37 +0200
Subject: [PATCH v2 08/11] ARM: dts: amlogic: add missing phy-mode in ethmac
 node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240916-topic-amlogic-arm32-upstream-bindings-fixes-v2-8-0b20ed4f0571@linaro.org>
References: <20240916-topic-amlogic-arm32-upstream-bindings-fixes-v2-0-0b20ed4f0571@linaro.org>
In-Reply-To: <20240916-topic-amlogic-arm32-upstream-bindings-fixes-v2-0-0b20ed4f0571@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=755;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=IX5ZFj1FormQAKEsvBJqiSBB66gwgLEwGfZq8lM9Ze0=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm5+eHVkKY7/Vx/PCvPzzh7kK6uwCnnzl0I1D1erOw
 05LTHmWJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZufnhwAKCRB33NvayMhJ0fInD/
 44HA5EkFvbgK/7tZuYQ1YAtRcf3PK4XYwVM+yehtOQje3opK28vke4HlDVblw9oID/e2M8JSYC6fh9
 Nvb6/5cFOBXZ9/COSnPvZMpE7JyA/lK6uFCrXVXVRduR9AFHHwUsUfJYA+uMlmIAX4BS306MX0ee9E
 FgS3A1g1r7KAs1FVBembtxDh7d/3QN2/vZfy8HJKipZvYSVZMMUzckT20BSIj3fFoGzW+vrwfpWPj0
 9sMZMjxyhWs9AXKBbLH1E1SvSKNL/EE1ZKsxA1xfIKv8Cu1IVzBQe2+vBUmkLoyeRYZm6ulQCPaV6S
 ETTrozeX2afgB0n5EfPrwjUdf2hKSCUuryD5AZQydPSkIo0Fj9hi6Y4zQWJ0ZWgStyds5bbslH5RlD
 t9UGfLzEAhKp0fRjD9fitERbOllN8wdcP4rFdHDY2Sx85mha3pbHLP6gexgkQFhQ+VvR+yG3TAzfNM
 KpUnNJKa/H01qo9Ya4cMNJ+zvg+Df8vkoUsayZA831m22oxCQcgtvDVoyzB4JNLIdWtlXtBS4Tnb3+
 1YTmZU7jSwH5dix4djUPrezKm0553u80qmxJ5AdwQ0kyLdObwCe5izDgsvBlwZiFwCt4M+Q6WHw6L4
 bKp3dKVdvj6br6WbSuZXv2n/VWFUdwF4e4Q07GdQFN1QhsS3dKDfuuK914QQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

The phy-node property is required, add it and fix:
ethernet@c9410000: 'phy-mode' is a required property
	from schema $id: http://devicetree.org/schemas/net/snps,dwmac.yaml#

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm/boot/dts/amlogic/meson8-minix-neo-x8.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/amlogic/meson8-minix-neo-x8.dts b/arch/arm/boot/dts/amlogic/meson8-minix-neo-x8.dts
index b97531000d55..f42f97f2c7e7 100644
--- a/arch/arm/boot/dts/amlogic/meson8-minix-neo-x8.dts
+++ b/arch/arm/boot/dts/amlogic/meson8-minix-neo-x8.dts
@@ -94,4 +94,5 @@ &ethmac {
 	status = "okay";
 	pinctrl-0 = <&eth_pins>;
 	pnictrl-names = "default";
+	phy-mode = "rmii";
 };

-- 
2.34.1


