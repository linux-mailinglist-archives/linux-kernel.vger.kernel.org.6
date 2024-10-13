Return-Path: <linux-kernel+bounces-362966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 083C899BBC7
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 22:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6CB21F21417
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 20:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776361547CE;
	Sun, 13 Oct 2024 20:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="bIrWRZvq"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2AB1531F2;
	Sun, 13 Oct 2024 20:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728852312; cv=none; b=fXLcFZ8h9z8vog0sbYhgwaY2SpBs2Jcx1Y+uw6w5Qx10jPDJRyDEIN5NlUKzD3MAWLLkXYCD08dUfhopHAf4aqec5iAk1vXK0CCFJOpaLZTzFofU07YeCzSTVbS7xSnBGRch9WVXsL7fGlNZ+yIMYjBmfglRHgUYenc0ncFO5PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728852312; c=relaxed/simple;
	bh=pHUprJJUm+kOD8ILCnwS/XICc6ujwvZL6GeC8rTuTj8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bmaa4NtgRSwU8C2zwKIPGweQOnTIBNtBytPNEkL7qj8NthcD4H5zEhq85koH9YNNIYcTLyplBgYooE8HZ/nEQJGmaaFqqwPi99a+/ZeD2A/f8NOt5TUHngZHv0fCxut/NR+5o9W/pJ5bzSz/E5tH4LTmcbd+f/s5v4/9TWn07Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=bIrWRZvq; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c94861ee25so2087331a12.0;
        Sun, 13 Oct 2024 13:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1728852309; x=1729457109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sytY2FNkkLBnOCAcfUv9hkr9CctUcl1zNo07NA/NCoo=;
        b=bIrWRZvqcPIhqgFgLG40U7iS0tir2qQCHHrjkIYkeXzFoNhaogWBVD+zYfHWIyrzkm
         g7CHEkl3qMkWBOTR2fcsR11TpdKLCdzgIHqae8Ray8zcX9tiTR8xjjauX3BSvJYFm151
         HxyHK2K77yQUfdSj+ge+1K3c7spLEGcnT6QylXS2u4qilA8IHe1D8owbYJljgUCCvbsE
         lYTySriaQHq0t+XcoTjxSS2QgHaClroHKFA++5pkfcPSc2mo1sbl1sS1EFqvcnShk6rr
         NSIaiqd/AIZJEgo6lgjZRvk+MXvJSrl6C8flBEGezcwXweJ2Su7iJNZukyOfVOXRdeYW
         59sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728852309; x=1729457109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sytY2FNkkLBnOCAcfUv9hkr9CctUcl1zNo07NA/NCoo=;
        b=T0keKV2bkwIcF3jjoL++koCTSBQl2cZ3auAmpSahwVSV7LIcNs6ZVFlYsw1ghAbYh0
         pjKJif/VZ5I4fvs0rcc9C4DMBzVqNi3753Rmdi8I4m/aa66gtBm6OFQJLkU4eZcjZ0tu
         0VaKFv4HocVi1cow3tciybApoH76ZLMNcVfKHwDtO9fNrhm4F713KlfmvDCClfqRFeaE
         7bzrw2IjMq5H69dpIa7CWdohemyFZXawDI9Q72z2SWJhdr34FUj5Nwv+oUH0SNs9w83B
         GNVTXoo+8D2lsQBKyetTYW5Oxgu+OWhV2LBWPa9ZC/igHsEIvTktDveGT/uOJzxVqOZe
         hSBw==
X-Forwarded-Encrypted: i=1; AJvYcCVq7GSOlBs17yqemcs/RG/8zxuMPb+MDX7MugZi+OhxfgmZwQ5kcDtKNSLnD5fgt5fFlxsjTavu7LngsGyJ@vger.kernel.org, AJvYcCXbnRNzawCQpjG+3MXKDC8sry4BSAckpDCl1YGWnr9NN7YtG3XXcijGIHT7zgF69sYm0LP+lXByu/6o@vger.kernel.org
X-Gm-Message-State: AOJu0YxfNwQYSbZjFi6/0AEKgTnt35Np0JOGEP5oKgZTZpr1EOIIAumR
	rVwRFwntAe8gKlRfdRzFC7Nc1IXpNiJp6O7+CuEN/LkxrS/9M3Uf
X-Google-Smtp-Source: AGHT+IG6hjVN41eeX/ukLBNVoBT3VqnYSYGyiAQdyRNtjxLf1w1mNS+qSGuF+dQPFS2mvhgSf0IuqA==
X-Received: by 2002:a05:6402:8c3:b0:5c9:55aa:4285 with SMTP id 4fb4d7f45d1cf-5c95ac63c95mr10120852a12.34.1728852309459;
        Sun, 13 Oct 2024 13:45:09 -0700 (PDT)
Received: from localhost.localdomain ([2a02:908:1587:1e60:ba33:7ef4:2f9b:8303])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c93729adcdsm4132770a12.89.2024.10.13.13.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2024 13:45:09 -0700 (PDT)
From: Cenk Uluisik <cenk.uluisik@googlemail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Chris Morgan <macromorgan@hotmail.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Tim Lunn <tim@feathertop.org>,
	Andy Yan <andyshrk@163.com>,
	Jagan Teki <jagan@edgeble.ai>,
	Dragan Simic <dsimic@manjaro.org>,
	Michael Riesch <michael.riesch@wolfvision.net>,
	Cenk Uluisik <cenk.uluisik@googlemail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: arm: rockchip: Add Orange Pi 5b
Date: Sun, 13 Oct 2024 22:44:24 +0200
Message-ID: <20241013204446.303727-2-cenk.uluisik@googlemail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241013204446.303727-1-cenk.uluisik@googlemail.com>
References: <20241013204446.303727-1-cenk.uluisik@googlemail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds the Xunlong Orange Pi 5b entry to the device tree
bindings inside the Documentation folder. I know you said I
should extend the Orange Pi 5 one with an enum, but I made a whole new
entry, because looking at all the other entries, they also create new
entries in a case "like this". I hope this is okay, or maybe I misunderstand something.
Thank you in advance.

Signed-off-by: Cenk Uluisik <cenk.uluisik@googlemail.com>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 687823e58c22..130f6ccc1658 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -1053,6 +1053,11 @@ properties:
         items:
           - const: xunlong,orangepi-5
           - const: rockchip,rk3588s
+      
+      - description: Xunlong Orange Pi 5B
+        items:
+          - const: xunlong,orangepi-5b
+          - const: rockchip,rk3588s
 
       - description: Zkmagic A95X Z2
         items:
-- 
2.46.0


