Return-Path: <linux-kernel+bounces-553144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E5BA5847C
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 14:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBFE31698D2
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 13:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C991F8745;
	Sun,  9 Mar 2025 13:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iHArOGzU"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57C11F4CA1;
	Sun,  9 Mar 2025 13:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741527059; cv=none; b=Zn6cIDhgl46fIwSnbIKw2yUxCOs+WpGa/rcGts4erQNNVz+7UHzjSo5zMoaVstuNldLXtHKmQW0mywGBgpSM/L9n6se9RC5xXCFpc1F9HBxKB1lKr+YJ2FGS0bm24ZGadesPFF64H3WybmsoEOMU/W883JUKs84rVbR/kAqaw/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741527059; c=relaxed/simple;
	bh=0DVNgFmCaYiuTa3nRsT6E8kjMPJtRCfoCmjiu+brQuo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NiYA9c9SJUfKcC4/vqRDexbsaztN2fZC7h2GIymIzqQ/bIZxJueICUKa9D8U3KyDhgTZIGH8H+tG7E/cJB33WjhiPrBUj2XcYmhlx8eV3BexRK0gkex1wmvIeM3XJhMPwgN8jHz+VVyT4XXojQT/wBt6nTpKqNH7x0QhPD0xc+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iHArOGzU; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3912d2c89ecso2801673f8f.2;
        Sun, 09 Mar 2025 06:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741527056; x=1742131856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MZocKeaP4+m6t9O2v1jxFvpKpeZLmzryJkfebv96Xm0=;
        b=iHArOGzUE1s9P+l0SHVLTYeRR7Uq3YCh8ma76hH7+YtEzs40lGIppqc7C60Hy3/q/6
         JFWPoJvK9OgKLz7/J1i9xmhO5nCFM9WBzggoUlLsrwI5SnmTs0JhX7TcT2dCc1keP4P2
         kGAKKSFskmMwq29WmbrxaO3YKRA2E5Z3fxT/fuI6jI7kxDxqFH5jMUj5wXPqBdQCR8ms
         QETubdiPCbvvo6S3hNOJVTmbKJz97srL4tSmZCWAIpMEobyjRuHmrIFifR2ztDnnaBaY
         vrzATF0eGfkXBPi8foQy+KxZ/72fjA6evRJIDpVqN6n/zdpd2bpAaEDNEJ6IoXPZo5tj
         2LvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741527056; x=1742131856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MZocKeaP4+m6t9O2v1jxFvpKpeZLmzryJkfebv96Xm0=;
        b=pEwtwp9/VTyJaPf0tqLS1Jsod2JfYCxx2gBN71D082PLwNIC0nF3FbxuW/4ZUlHvEU
         eG/rJkAXN33LWgZsUBq1N3q3jBCQzMQnae8dwF3FDTStsJSSqDuxJYZYWzinni7gofqE
         m9a0/bRGTjK10+A3MEB26LT2UQit9L2u/BR4kOw6af+QLi8ZVjSkAOMMpgMC6eUg117/
         KpKYRUVmKFlcsUugA22iLECUd94y+zi+vjX0KQwSoMppIDP2j2TOdccstEA7aHuNk8SG
         CPnTK5rXzaCAPPYyOz7QOoz/NOyW96fFj8r5BRw3d4BpRtA2zj0GQeJkEI5fchJV9cYz
         vUiw==
X-Forwarded-Encrypted: i=1; AJvYcCUeKJeDhA3B8ncfxtHGjp3IAmYN3c9m9oGqedbu6bZFRh6T46TD7mRoTemC5uhOMGArghVmhnz7R3wA@vger.kernel.org, AJvYcCWVLV70d3TNBBEWWWaSavgmubkxHKijQl+lIDo53Uo1RsPXnLIuPFwVnOhjCW4H6pWq8Byww6TDfeyW@vger.kernel.org, AJvYcCWqBArmzjeENcH/bi9w899VRPA1qc/MImor8VLnV/HhWpZKWh+9I0owJ1EWFk2cBtldt/FIUGh3r2+Dp1To@vger.kernel.org, AJvYcCXYrBaPNO4dK6Gxgt1t5XKnySsuXNqripn+/A32rK2RN8vH4ISFkEG7bdLqRrLNsWGGAnnwjZOHypUN@vger.kernel.org
X-Gm-Message-State: AOJu0YwRP20LhDvFdFXUYRxdyTxpP9bI2cur+9U8kDcbJsQD8fhse7aE
	OjCqf0RprMoDXE1RfmcqcCe/vu4ynvypl/LB55LyPbWq9Z/F5n03
X-Gm-Gg: ASbGncuKcc0FdRASwaA3xtHFA5dw456+Jptuf01pVN2Kx2cQ9TyBFutnX4TKcLJkC4F
	kR+lYau4tgNZFO7bmNEp3hMFKOjPy8adDg9RIdDxcX+JWLSJWS1psrTE2rHc6dhUGhO0tE64VMQ
	GiNrEtLmdjQZAwDJC8RblBeZCyg70EG1Im7mWAyaXKkVsUJ36H2AIY2Gpz5s/N4tb+rTTP7rQLF
	cvZ3G3hv682pDafWiTSrkkzyzSk4rKWpqw3NNbossdnLTkIsAx5PcRcxnoEF4nLKQ/BhmJ2ehd3
	sF16vq4GpZ19hBXjrVAZ0LCU3hoy+1Qbu/YYeNpT500gEtBr5UyGadgYDI3lLG4v7igzVpSxMO1
	DA2+AAH7Ma8UY0cd5owbpzO7V
X-Google-Smtp-Source: AGHT+IGueJHW1j9BhtVPmDBGX8blLXmKHwrxWVgv1ht1LrkVtNBdxRa6fjj8ZPsr1C+nUsiR9Cs4RQ==
X-Received: by 2002:a5d:5f93:0:b0:390:ee01:68fa with SMTP id ffacd0b85a97d-39132d6cfb5mr5971194f8f.24.1741527056010;
        Sun, 09 Mar 2025 06:30:56 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-129.ip49.fastwebnet.it. [93.34.90.129])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3912bee262esm11867536f8f.0.2025.03.09.06.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 06:30:55 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Daniel Danzberger <dd@embedd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Nikita Shubin <nikita.shubin@maquefel.me>,
	Guo Ren <guoren@kernel.org>,
	Yangyu Chen <cyy@cyyself.name>,
	Ben Hutchings <ben@decadent.org.uk>,
	Felix Fietkau <nbd@nbd.name>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-phy@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-usb@vger.kernel.org,
	upstream@airoha.com
Subject: [PATCH 11/13] usb: host: add ARCH_AIROHA in XHCI MTK dependency
Date: Sun,  9 Mar 2025 14:29:42 +0100
Message-ID: <20250309132959.19045-12-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250309132959.19045-1-ansuelsmth@gmail.com>
References: <20250309132959.19045-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Airoha SoC use the same register map a logic of the Mediatek xHCI
driver, hence add it to the dependency list to permit compilation also
on this ARCH.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/usb/host/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index d011d6c753ed..9d8626f36ca6 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -71,7 +71,7 @@ config USB_XHCI_HISTB
 config USB_XHCI_MTK
 	tristate "xHCI support for MediaTek SoCs"
 	select MFD_SYSCON
-	depends on (MIPS && SOC_MT7621) || ARCH_MEDIATEK || COMPILE_TEST
+	depends on (MIPS && SOC_MT7621) || ARCH_MEDIATEK || ARCH_AIROHA || COMPILE_TEST
 	help
 	  Say 'Y' to enable the support for the xHCI host controller
 	  found in MediaTek SoCs.
-- 
2.48.1


