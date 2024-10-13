Return-Path: <linux-kernel+bounces-362993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EADB99BC4A
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 23:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D87A9281155
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 21:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7C314B956;
	Sun, 13 Oct 2024 21:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="In+6rOGh"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01F913A868;
	Sun, 13 Oct 2024 21:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728855234; cv=none; b=N+F7wEUReHleoIKEj0MDSt+LwXzR0935RTxqrL8g2Gy8KyxiPjpnCwTVdRp2mxbwYWelsJnU8TTSjBrWND27zkXVBegsz0cJsecxz93DqGVLz3fKVxZgHOU0p7Z3V8iQhX4el9m8vf0XRv8Gjpe/wkv1ws9tCHsBk9rVsweM08w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728855234; c=relaxed/simple;
	bh=pHUprJJUm+kOD8ILCnwS/XICc6ujwvZL6GeC8rTuTj8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EtRvqLfviTT+q0gmF18A1cKWkHfUn09QtZM2DgzCyOD/jiLKjfHwFYfEAv46QHGUAl2a2i5r1Jx7pfTKrE7t8K8R7Aw5YFiMhmh0TA4VPVhfHIH1InYiq+ar15c0d4J+RLLGj81N0NcmrXJrHQFrye6bmre273encnLPi4egR+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=In+6rOGh; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a9a0472306cso97327166b.3;
        Sun, 13 Oct 2024 14:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1728855231; x=1729460031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sytY2FNkkLBnOCAcfUv9hkr9CctUcl1zNo07NA/NCoo=;
        b=In+6rOGh2eTqFhOaR9r14nU4IJu5qoudPT9F9nKL87loPF+AahbCuNuc9KveNFRMUF
         i+k/QONdpuy6we2C7yIC734yVCXKRgkN2EaUIKhigLxFRUFs5CoUzEnVXiFYUvwGTl0/
         p7hvxfjwlHiuZ/t4ccuDjKlKLS0H9puwlBhupvVBafpRDsbvm01K459CN115mnKolhG3
         kGHW7XhL/f0x0CWoqII/vU9XMThVOGQM63UN2b7JfcpO6h0m0nd0U9pII5Ub9g0fNapT
         VqvZLK912kIXt2sV3iB6x5gxhkxLGmWUAosjRDZ8MINallxM8BCWznsdztHUVoplMATm
         iPrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728855231; x=1729460031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sytY2FNkkLBnOCAcfUv9hkr9CctUcl1zNo07NA/NCoo=;
        b=liuf4Rmeik8Awgt0CGyvnzyPPBcXosPzIamdzjjlO05rYRFOZ8xcSDp96/3ustS+P5
         qTcuwg5QVueL97oWicZj+uHyoIac1a4/M+XItBUlPsTSRAjgxVEDMM/o+k3MKJeG3OPg
         xfSHdLvzhi4VgBAnGLLygiycUKsBdAK0/0Wdl/rx6fcZvkdXNo2SH3ATQmbmDpKo+S4F
         m/zgM+dSMrG7OuqnpIlXostFu3SotojRd7lKzSK0CMXz4gsKruyd+jw6e88a82+LwvVS
         +yDSkxwYQ/wweTylpfLFPMf6KjAw0zvqPk64Mgpq6Ke39i/atV1NX0j0EiNa2YJlTDN3
         BLsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFcIpqM1K5K7U0ef5mit9tHG0yqAdTItmmBL3K1l1/zKCQ1/QnlD15P2aiyMhMwBAxRZJE9+jRgCq4@vger.kernel.org, AJvYcCXsgzx2ntDHpIwJRFHN+zIsPFHOw7PKjDad2S/VhrLwUvot/Nk7UlupCuIL9FS8mvNbNElrQWbXOEjZNmQq@vger.kernel.org
X-Gm-Message-State: AOJu0YzNz97sqIKC1Cn7/sKw4DGNEGrT9LtxrgL8rAkTouB4wgpm97ML
	tJlLRUET/tpEeWsYV5No3prmVuV+fXB6jGmImHWnc5gbaGXfY8+G
X-Google-Smtp-Source: AGHT+IG7ExnbcS3+M2fgUbQl6n1Tt8baiJ5a7KWvoXfWNem7QdFcbv71w/NQPB0td9aTVoU+aU5Jug==
X-Received: by 2002:a17:907:7b95:b0:a9a:d2a:be39 with SMTP id a640c23a62f3a-a9a0d2ac035mr162886066b.25.1728855230903;
        Sun, 13 Oct 2024 14:33:50 -0700 (PDT)
Received: from localhost.localdomain ([2a02:908:1587:1e60:ba33:7ef4:2f9b:8303])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a80f2752sm492798166b.213.2024.10.13.14.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2024 14:33:50 -0700 (PDT)
From: Cenk Uluisik <cenk.uluisik@googlemail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Chris Morgan <macromorgan@hotmail.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Jonas Karlman <jonas@kwiboo.se>,
	Tim Lunn <tim@feathertop.org>,
	Andy Yan <andyshrk@163.com>,
	Jagan Teki <jagan@edgeble.ai>,
	Michael Riesch <michael.riesch@wolfvision.net>,
	Jimmy Hon <honyuenkwun@gmail.com>,
	Cenk Uluisik <cenk.uluisik@googlemail.com>,
	Jing Luo <jing@jing.rocks>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V3 2/2] dt-bindings: arm: rockchip: Add Orange Pi 5b
Date: Sun, 13 Oct 2024 23:32:37 +0200
Message-ID: <20241013213305.310844-2-cenk.uluisik@googlemail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241013213305.310844-1-cenk.uluisik@googlemail.com>
References: <20241013213305.310844-1-cenk.uluisik@googlemail.com>
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


