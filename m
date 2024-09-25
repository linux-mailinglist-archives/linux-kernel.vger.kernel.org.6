Return-Path: <linux-kernel+bounces-338372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A75985705
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 12:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 567D31C2297E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 10:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A79D18308A;
	Wed, 25 Sep 2024 10:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d1P7vZGp"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AF215C12F;
	Wed, 25 Sep 2024 10:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727259313; cv=none; b=rUByjxWIJLMjecp1qDwxdz8OOJkAXGFAUqlTaef2XIYoSjzslBJs2QpLzRSUlHx8NHhZdUa2HTLbILbVEigRJh/SKSiSWLUhANH7cZbFNhDWn1VBvEHGiEwT1cXA/XiKYBlF3cWthg0ebIObRiSUO5KMtMUdvBSdWfpn0Ndkaxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727259313; c=relaxed/simple;
	bh=yw1mImiPrjqLQht4OtSvNd0TeQGoObVDJhFgu2dtlzE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pFWLKV69aKv8EuPntAm1LAA0Wp8fFBy6lglgtWGU2a5zBQN7VhOekpa0/8FHE4upo+/dGJ1dII3BT5D032eQiQm+w4PcLTvXEwRqimf9orzT2IU1ZnfNVPJJwiXT4r2h9VL2vBgCoDr9zLH+2WQIQElih19WyqeN4dDxeDTG4I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d1P7vZGp; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-374d29ad8a7so4524203f8f.2;
        Wed, 25 Sep 2024 03:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727259310; x=1727864110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mH3iAq1TAeBK36lg95WliQsOcKLSEbditM8M8e4wTwE=;
        b=d1P7vZGpwwqgZ3VNhdNnYIAIEzl5QOVA/wrDKvZqYaQxyzhXYDEW4N0Fpp8UFMhHnU
         cN/d0NZLX5kS93hlLi7Zi3hQzvMq44X6HrUa5p3S6o9i9hQCw3uwRm1Znk7RZl8zR7ln
         vZ2PbrIg4hBEQq40A1YCvuiRcbibr5Me/sTVJD14nB6MDjSk3eZjZyUfJzTs7HMA3U0m
         p+yqindUFz0tVGeOGmsWN1/frB1AAIim9tI1B3pEqFrAiwyP3rorU5iaxxV2DSFkV4Rq
         rUmYbB7uijG/bVIZlUS8CH8Wdp8o7igR84f7crCvsWWpmBHDH+jGSnr3rSUUXDWQLeC1
         28zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727259310; x=1727864110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mH3iAq1TAeBK36lg95WliQsOcKLSEbditM8M8e4wTwE=;
        b=i2OTbBj+eLJ/g2RyyG6k1+TzdTf0wJ8izPZGeWfIoMFy5KwGut1Iou36vPCNU4n9wu
         EhItN2QeMQm+L/HCeTJB4WOZ0wxh2h7AzXOfe/RM0ZVCbwP4l7/KJt8YglPAzdC2Lv29
         nbrrz9WoUMqq2dLmGMdFlrrueSlR/0sejURwlTCLRYla5jRcVbZWCIdTxTfUmr2oiPj7
         GG7eayFYSMNcK6r8SmPcSzDOu4IvvKA8tQA0+4zf7YzXRp2Q8gMmZSTRQCseYnpDPE25
         GldKhNfLIQtlB/NzzL4x37gkk5CCd6eDfnq+XPZ7yv7hkC77OccaCtQRcYm2a7tsi2PU
         TY0A==
X-Forwarded-Encrypted: i=1; AJvYcCU4evc+ZIUstJ62lYNBuDGZuRA0xSd6aKeizxV2s2TAx0zWZ9DAb/UteSvDWLJ8GHUN2uNYLi7qF1C3@vger.kernel.org, AJvYcCWuxG39fWKKUEMh9Me6h8BFRemOQda33gMmckiW2uv4eKtCTZ1qUb027agd6yNallCEvmQh15MsLmnpsIVJ@vger.kernel.org
X-Gm-Message-State: AOJu0YyMQgrqACqYRZxcDvs3nLaybBVdnzA1st9t3IXPbKSRTUjEUgcl
	LMQmR8eeS5mMUxRQ21kW+WHTsFIJM8PgLs/SZ1tMbibtVyLI/N+x
X-Google-Smtp-Source: AGHT+IEDuMF7AmbE72EiRIWfTyj8UDV6s6Ac8BVbi1Q8y0Keq8ajGW2UzIm9myAL8AG1LUQcAtjFmA==
X-Received: by 2002:adf:f1ca:0:b0:374:c8cc:1bb1 with SMTP id ffacd0b85a97d-37cc24b575bmr1521519f8f.39.1727259309987;
        Wed, 25 Sep 2024 03:15:09 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-37cbc1560a7sm3628194f8f.0.2024.09.25.03.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 03:15:09 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-mtd@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	upstream@airoha.com
Subject: [PATCH 1/3] of: also export of_update_property
Date: Wed, 25 Sep 2024 12:13:57 +0200
Message-ID: <20240925101422.8373-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240925101422.8373-1-ansuelsmth@gmail.com>
References: <20240925101422.8373-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar to how is done for of_add_property and of_remove_property, also
export of_update_property to permit kmod to use this additional function
and correctly update entry in DT.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/of/base.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 20603d3c9931..b2d523cf4925 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1746,6 +1746,7 @@ int of_update_property(struct device_node *np, struct property *newprop)
 
 	return rc;
 }
+EXPORT_SYMBOL_GPL(of_update_property);
 
 static void of_alias_add(struct alias_prop *ap, struct device_node *np,
 			 int id, const char *stem, int stem_len)
-- 
2.45.2


