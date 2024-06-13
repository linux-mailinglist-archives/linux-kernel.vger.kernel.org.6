Return-Path: <linux-kernel+bounces-213540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 765BD9076A3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 17:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1227288B9B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 15:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2080714AD19;
	Thu, 13 Jun 2024 15:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AvUkHA8N"
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB8E14A606;
	Thu, 13 Jun 2024 15:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718292410; cv=none; b=GVXyoo8MqCSf/UPtCiJzA78tM/Xu7sNhH/jrGCUj01NHtr8QU0TzAPrK0ui0B5+QCQ8DZkPsED260R8Xo/t8G66b0p4t9uzifiErLL7aaNacYmYdiuD3+28Sk6qTEKxu23P+RcbmFXlFzS83uj2hjOI7IPz3CEGAJKSjUI9EuB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718292410; c=relaxed/simple;
	bh=NHYr7kvAJKkFrj1xP2i9qmfkaQKi7bbX0ZHKZHWUnjg=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lwRxECqLlF9H0YKtMq58afJGPZKp/ycbD7ms6kJzF36K3g0MofQwBVKtYE/vjchP7YfHvfFm34obwCbFsO6VhyF76i9k2nt2gjIWLPmR4ZAti0FOE4/Zg73LKY37jZdnWeBN9/ObEqof5DGwEeeH+XO1IaPASd8LCPrfM6xihjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AvUkHA8N; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5b9f9e7176eso583532eaf.2;
        Thu, 13 Jun 2024 08:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718292406; x=1718897206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IeJnC3t034+9p9rSx5xKrlrprvLjTGHeh2PdENFmyOg=;
        b=AvUkHA8NjwRk6xGJPBPdKfcFOIlXURnv8pHdsLixqny1eI8ZggOhJmIG/pGTX1osm4
         uJ+bBF3wwqMoAGq5gyu8OOSYv2pUb3Lxomux382+B5QSiGnPVLPIpklRtSRyw9WU+KOk
         XFTp7Fy4vkioHEQbbxFXxa2AHRwWZ2aVjgknlBYdarYg4RWE2wbZdEj6BEYHWKqiCPbh
         u+mwXPnuQszsSaWUVJSD4G/b64IP/PSTt6HVGtPnEHChIgABbwPKnndOAduQgAEAPv+b
         Klkc6/9wA5d2wPkxghXxPC7oTG+yKjc07FHEHB9O17NC7nk+zzCxKli1952j7YMvOtXI
         BGEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718292406; x=1718897206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IeJnC3t034+9p9rSx5xKrlrprvLjTGHeh2PdENFmyOg=;
        b=wNSasuLr19JN9+wUVpQCFhjHs6+Ve7Ct2IyLMoek75qPDvI/mp7tUzoGREOihdA/Mt
         50H9x7AhyyjpA2++Wgxibk1wengjib7UUj6XRGKb2M3mt2jDV+wnHaH6IGOYt4BWJBpE
         +BEGOAvJ3LXXRWHkpCSjffvVf5mm3XozI0VnI/V6KcbY9Fmq978hSItRrJFKaJTtK49d
         h+WeExZVEqlAegGu4dYzVB2T8Mh1TTjOR+yGVm/zgH10eZWqgrO7rPjXGxoCKMfA/wrg
         tR4FMI33FFON1JaPEuhf+MvbVmue+gm9jXlpncazBKaolUZbI5ZKdd/bvwl+7Can1eUq
         av3g==
X-Forwarded-Encrypted: i=1; AJvYcCWvs9pC7o4350OlYwItILAEIyVvIwMOi6JbhOBNey6lR52Bgxf4EfeSR6Gfx8ooFjFksHLkxfYARVO1kgokl5jXu57FFFFqAH62SqEANgIxCw0jcvOMtykVrUAgqm63WRtTppwEjW9Rdg==
X-Gm-Message-State: AOJu0YynkUztwnyGMJsBEx9RhaID8uNleGsLCd+9QoPc7lPtPEpOG/Bm
	9reAmmePKeL4YxjU4s573V+8b97QtgNQMXU3pBKpc97KbTN1Xgn5
X-Google-Smtp-Source: AGHT+IEM96x99wYwHBRD1XqHFCoVr0ih47Cs4Z7Vc7NT43TO7JrVyAEPapjNJXdZkqyzlOcT/Z+kTg==
X-Received: by 2002:a05:6358:6f02:b0:19f:3ee1:d1b1 with SMTP id e5c5f4694b2df-19fb5039c8bmr7747655d.31.1718292406467;
        Thu, 13 Jun 2024 08:26:46 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6fee41663d2sm1198183a12.92.2024.06.13.08.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 08:26:46 -0700 (PDT)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: patrick@stwcx.xyz,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 6/7] ARM: dts: aspeed: Harma: remove multi-host property
Date: Thu, 13 Jun 2024 23:24:24 +0800
Message-Id: <20240613152425.1582059-7-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240613152425.1582059-1-peteryin.openbmc@gmail.com>
References: <20240613152425.1582059-1-peteryin.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Harma is single host, so remove multi-host property

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index a9caa66a59da..d892e646fced 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -137,7 +137,6 @@ &mac3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_rmii4_default>;
 	use-ncsi;
-	mellanox,multi-host;
 };
 
 &rtc {
-- 
2.25.1


