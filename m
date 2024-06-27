Return-Path: <linux-kernel+bounces-232126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E560D91A3DA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 12:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72D801F23665
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 10:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4248F8060D;
	Thu, 27 Jun 2024 10:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZtwRljwq"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D717C13C80E
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 10:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719484360; cv=none; b=fOug6iajv+xGdq1zs1roFPo2EIlYlBpb1EHZxRz3+y49/y5IAGqMd7UqY6Q8zQWx33fc5qUdlwS9k205/+deopMKrRBdItKQfJPTF6WewGbfwto7BLPrsr2e9zsb169CIzxqX1PL1q+JZZRMi7pPC3laEPoQAW3rBlxm5641iMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719484360; c=relaxed/simple;
	bh=Zb33PnEyoq7JgdCVFQY8c3fsqudJzBtmqbZshBBoQTU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LpiWMGFowTyVcoujJyigXoVrkI+wVVF4pBhR8dwuCVRA1CUKjl6kKs5ZjPVPoVxPi4+F51Ys7FfSzeAwKmyfSkQIMICinNi6m2+NDMLmqvowa/o6EBMvAYYl3pnS9h9NDFrBfR0h25CnY30m/KGKYmbLqN5gSUf6jV2LYMJ/v4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZtwRljwq; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-425680b1d3aso421475e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 03:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719484357; x=1720089157; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/pocliNAoVNTjwAmPI4SdlGncSkrq4T1ZnfC3MYG3nM=;
        b=ZtwRljwqpfNEUZ0Ftp59yf4EWU0noLC/nNieqXlUJGvmccHAfpJe4w3zgkxpPKPpEK
         DL8ty+/lMTeVCSwY58zsmotaqmszMpfrSxwHJCgahRWCYz5CPCicGRbqLaue5iOdk4Om
         SLdP2AC4/AR5sMZ7via26mIdPkJyX/Rxvno4NPmLVonhPkNhItOYQnO+4Bvc9BzdzouX
         0VwfiRU59AVxdRYVsZMtDKvD3HgIxHGQPV+sdS+YA9BvN6RZH2y5h5AG3kHEol7srFG5
         C4UfYAg3/VJeAzRJL0T3jB/sQQpx3nJyaWTGvH15A96KZHUm5Ibon3qhSQ6XFd++fUlt
         dRxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719484357; x=1720089157;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/pocliNAoVNTjwAmPI4SdlGncSkrq4T1ZnfC3MYG3nM=;
        b=BX22rAcv+s9c/0mLYzH/6OIhpZXKMhFB1vPxakjKVMHTvew7XaNCM3OqjaeNt2IMdX
         QP9UEULUkOCfq1R4LFPYcOT3X6bNJOEoe1J6trIkStK/IWgPOFIKPps3ODbkJvlkO55k
         ZEJzJ6tkrBsnp83+QBsRz0eRV2Ch/hUW8t0DhQQwg0Germw0r95nZTIdUWEaOO1+B/Br
         Xm4ix0oym6YvhYt+MhNXISH++39xJzhZgfvGFefAJUinyirmeCJmjPCB1PIKFJb4KTCH
         74KS8HGxBF3Ap9Ie7uNhiF5E1wPsc7lco72xkJOynxHP3BEbm4Y0M/n07JEOjYLGcqld
         hJug==
X-Forwarded-Encrypted: i=1; AJvYcCVFeRW80vrw3nWiaT7teJUIHALRbeE2mxBEj2l4Jh45AYCh6Qma2SJ+TtqYRfZ6vCQuNkNgBrXIISKUToihfpm3ukWq7hKeF8YMuyVa
X-Gm-Message-State: AOJu0YwNcF5d5ZwRfCpEOVDle2yJAYCT9pvJqkwDIzZeXzQ62G6r7N/f
	7/1VD+Bpu+nJQc3ILI6+FRfwGAZC3GS7Arq3CB+IXh/0N7dbRtZb1Xi9emjqxKU=
X-Google-Smtp-Source: AGHT+IGzsKQ645okLvBapJa1IPZvlBlt1QswcG6XLfpau6Jwa+Z4YLVVxe1f2AvIV7KeLFUfMZXx0A==
X-Received: by 2002:a05:6000:178a:b0:360:7887:31ae with SMTP id ffacd0b85a97d-366e95d37d3mr12440454f8f.54.1719484357309;
        Thu, 27 Jun 2024 03:32:37 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367435852afsm1384352f8f.53.2024.06.27.03.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 03:32:36 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 27 Jun 2024 12:32:17 +0200
Subject: [PATCH v4 1/7] dt-bindings: mfd: syscon: Drop hwlocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240627-dt-bindings-mfd-syscon-split-v4-1-dc6699a9f3e4@linaro.org>
References: <20240627-dt-bindings-mfd-syscon-split-v4-0-dc6699a9f3e4@linaro.org>
In-Reply-To: <20240627-dt-bindings-mfd-syscon-split-v4-0-dc6699a9f3e4@linaro.org>
To: Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, Jacky Huang <ychuang3@nuvoton.com>, 
 Shan-Chun Hung <schung@nuvoton.com>, 
 Khuong Dinh <khuong@os.amperecomputing.com>, Lee Jones <lee@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chuanhua Lei <lchuanhua@maxlinear.com>, 
 Rahul Tanwar <rtanwar@maxlinear.com>, 
 Lars Povlsen <lars.povlsen@microchip.com>, 
 Steen Hegelund <Steen.Hegelund@microchip.com>, 
 Daniel Machon <daniel.machon@microchip.com>, UNGLinuxDriver@microchip.com, 
 Nishanth Menon <nm@ti.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=845;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=Zb33PnEyoq7JgdCVFQY8c3fsqudJzBtmqbZshBBoQTU=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmfT+73BMgXoynDW3Ud4fMi0zPipmaTcLImpE92
 Fx4eYJBxjeJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZn0/uwAKCRDBN2bmhouD
 16o9D/wL/sfLuiHFTg9X1nKfJ4SjKti2z2aIxrrkHixYzPqk9OVt2u06E9hv1CcjXD08OnHa/S8
 zof6DtwKy0pQAL7ssRH6yo3KB1aM+LSoTChO0a3m5zI9OSz44GP0n1bc8dpRIffi0+kBFnZ2gPh
 d427I1oayBlX8Ytb6j5fzKvFWZ89Q0wAq3wNTOdeX17aok/YxCUp3pq+DunObpZofs4X9J1GQpR
 Fhz7daq8HedFR/r2gmliyhKtZwGgkk7bMQjW0cQhNWdtg5YvK3gcNQfsPI8XztqXzTAKI4OXIwp
 NP+yh/adub7xzF89QnjAsmKIlcSrZVEBxcY9iA0JtnavLamYgxgdTWIDL/pHfGTW0SQxh70kMQE
 Gg7AA8gi10NL32yzcJHz2nKaCP7HLka3B2dJ71ZW4R3/gIsk5Cn2jUFWspjeOqCgWYgbg515RG8
 ECXerrLy8VdPq9DoNazpg+0FT7BP4n0iA0oqgp5DuIWzGn4p5Zj+ANpb0s6leGzXNsM8ogHQsl6
 z5z53Olh/1BP1fWeUOKo/XcEkjYdOuHNpK92ISrwXnspc8uEd36gCKfe4/xD8p8Vz8316gKYdVF
 B/+zrB1if+/LOi7wcfxS6zEaCfiedcpPsbjae2j9LRi52rX8mkcaB/KilcsHrNAXmt9XPwH9Ra9
 GfQ9OLSIrbXNWig==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Apparently there is no in-tree DTS syscon node having hwlocks, so drop
the property to simplify the binding.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/mfd/syscon.yaml | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index 993460c3cfe1..cc1e9fec5cc7 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -143,11 +143,6 @@ properties:
   resets:
     maxItems: 1
 
-  hwlocks:
-    maxItems: 1
-    description:
-      Reference to a phandle of a hardware spinlock provider node.
-
 required:
   - compatible
   - reg

-- 
2.43.0


