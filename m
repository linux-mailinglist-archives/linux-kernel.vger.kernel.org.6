Return-Path: <linux-kernel+bounces-407284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF8A9C6B4C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 10:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD092B2717F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 09:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114691CEAD7;
	Wed, 13 Nov 2024 09:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YScggIdP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3EB1CF284
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 09:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731489360; cv=none; b=nopx/W+vope2LMkSsHYjS0cbHkeTNitE3chnkOHe9EilzPLQNRXeHIdFOvmkBVMuDHWkUQnXhsmIrbHRyCALbvebysSvR6lZC/IB6edZF/TLKewN/RZnBCUlnfLbzT4OsJsiuBCelLy6WLPe4AS4qMl51lnDClCJuezCI50CTZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731489360; c=relaxed/simple;
	bh=z/u1dS7bqU+pERIEwXwPJnV5rEt13+2pmf/a0imcVHo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eXc/pxQH+EPEMFBdPXsYSK4ybctkvOIo88TJKCxOHiUsuMnsy04R29LBTkcxlu88lc9KwnQmAh7Cjqsy0wakMypCzByn5s0aU1IP1QGQiXZ/dUQFcqrZHvShHpog7/0Tr5HlkwGkdqEkS2EYUYyFSoCodUKQsKuQ39L0RNHDXaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YScggIdP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731489357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pePq91fMf5htVRE/fsTzHK2L3qy0wyzwWaV988CadX0=;
	b=YScggIdPaXDizXiI/L3Ic1xPJkRmMuhUdK4ebtfA7tgCwds60mdw5V8KjJm+ybZp64k3S0
	jZlXI71OKkN7FXBIbKMbYTh7G4YkHRjefrX6cUGjDN5plLZMpDTkw8lgRdcou7bvTOZqRZ
	jak5IfxCLGl9Vm+VIwq+56D1jHuVIDQ=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-ITmBGM27PYewzkCmIltPOA-1; Wed, 13 Nov 2024 04:15:56 -0500
X-MC-Unique: ITmBGM27PYewzkCmIltPOA-1
X-Mimecast-MFC-AGG-ID: ITmBGM27PYewzkCmIltPOA
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6cbe5e8658fso10762876d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 01:15:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731489355; x=1732094155;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pePq91fMf5htVRE/fsTzHK2L3qy0wyzwWaV988CadX0=;
        b=E0HNU7TI0xfSId3LHJS2QfYo2ToHTAcdzLhmL/+rb0bJCH1FD8/D0nKrLSze/fWg3K
         Wuniy5Z5BOGxtu8n+Me82/9dqHl7e14NpAhfNvjxtvRKVl+0XoTCoCW26vjtiJu/p1xh
         QE0rXc2vsSIpUhNALkev5COyOpcsXQNMLZQb8xhiQ4rIBbfjAVpMo2wCisRb/3dxRO7C
         mMKuNojsWHLwPuH+Gq7Dwyrhn11WVN/yo+rGbvMmkYcmgVewXG9Acu8P1zxDJZusZ9vW
         LOM42VM0Kt7tES/1O1tAJFKPipkrgOFJV7c3+q8ZanXiARKnelVQ6MZXyFdBCfpXtFAk
         cJEA==
X-Forwarded-Encrypted: i=1; AJvYcCWJ0vyu/18ifAevUxTIwXdqFTl+DK2sGcTNXmNLmE984Ay9QIAQQb97DBw+oDmLF45v6qKvwlGnVPn/xPA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpxIodWxuFytKm8Vx4ACFVJiNOF7L8gzcjb2Muc4T9zVz0DW4e
	Jkl7mRmFmdgAVfyY6Y7Lh3eS2S0hA2gshRRAWQ/pBtuuyHvwTT30SWNC1kBW4Bksafgf2kcL3NE
	rYvxXoOBoctb36f3SQHVs31NUK4ItuZCI9CoPxm9C3NqhYdrMLnVFSGGoFqaiLg==
X-Received: by 2002:a05:6214:1bca:b0:6cc:1827:5750 with SMTP id 6a1803df08f44-6d39e117943mr116376436d6.6.1731489355091;
        Wed, 13 Nov 2024 01:15:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHXkduxutfFmovavdzvpkZColmr0+85g14otssbj3k1m3rxX8IZRUy9FgLZXbOcskqZ5EdCIg==
X-Received: by 2002:a05:6214:1bca:b0:6cc:1827:5750 with SMTP id 6a1803df08f44-6d39e117943mr116376266d6.6.1731489354775;
        Wed, 13 Nov 2024 01:15:54 -0800 (PST)
Received: from [192.168.1.51] (207.red-83-46-1.dynamicip.rima-tde.net. [83.46.1.207])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d396630ec5sm81599036d6.101.2024.11.13.01.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 01:15:54 -0800 (PST)
From: Enric Balletbo i Serra <eballetb@redhat.com>
Date: Wed, 13 Nov 2024 10:15:17 +0100
Subject: [PATCH v4 2/2] arm64: dts: ti: k3-am69-sk: Mark tps659413
 regulators as bootph-all
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241113-b4-j784s4-tps6594-bootph-v4-2-102ddaa1bdc6@redhat.com>
References: <20241113-b4-j784s4-tps6594-bootph-v4-0-102ddaa1bdc6@redhat.com>
In-Reply-To: <20241113-b4-j784s4-tps6594-bootph-v4-0-102ddaa1bdc6@redhat.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Andrew Halaney <ajhalaney@gmail.com>, 
 Andrew Halaney <ahalaney@redhat.com>, 
 Enric Balletbo i Serra <eballetb@redhat.com>, Udit Kumar <u-kumar1@ti.com>, 
 Beleswar Padhi <b-padhi@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731489348; l=2349;
 i=eballetb@redhat.com; s=20241113; h=from:subject:message-id;
 bh=BCtRel6q2GhIghcOmJUAkR2/nR6+u2ZqHw8UA5ZGnE4=;
 b=WxCC1gigyKvqi4EPSikNJ0eWI6e3xd+/wYjiBy6LpTVreKIzonG/vp/Lk08HG1tb8vu8O+M7y
 OFvp/8EKH4zCiXg9c1IMAawbuqbHWG+lvLxJAtQfZdOaXd4h0sOZ78e
X-Developer-Key: i=eballetb@redhat.com; a=ed25519;
 pk=xAM6APjLnjm98JkE7JdP1GytrxFUrcDLr+fvzW1Dlyw=

From: Andrew Halaney <ahalaney@redhat.com>

In order for the MCU domain to access this PMIC, a regulator
needs to be marked appropriately otherwise it is not seen by SPL and
therefore not configured.

This is necessary if the MCU domain is to program the TPS6594 MCU ESM
state machine, which is required to wire up the watchdog in a manner
that will reset the board.

Tested-by: Udit Kumar <u-kumar1@ti.com>
Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
Reviewed-by: Beleswar Padhi <b-padhi@ti.com>
Signed-off-by: Enric Balletbo i Serra <eballetb@redhat.com>
---
 arch/arm64/boot/dts/ti/k3-am69-sk.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am69-sk.dts b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
index 1e36965a14032ca07143230855e04b9549f1d0d1..5f24a1608bdc4fef0610e2ba9a210264e3c4917e 100644
--- a/arch/arm64/boot/dts/ti/k3-am69-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
@@ -755,6 +755,7 @@ bucka12: buck12 {
 				regulator-max-microvolt = <1100000>;
 				regulator-boot-on;
 				regulator-always-on;
+				bootph-all;
 			};
 
 			bucka3: buck3 {
@@ -763,6 +764,7 @@ bucka3: buck3 {
 				regulator-max-microvolt = <850000>;
 				regulator-boot-on;
 				regulator-always-on;
+				bootph-all;
 			};
 
 			bucka4: buck4 {
@@ -771,6 +773,7 @@ bucka4: buck4 {
 				regulator-max-microvolt = <1800000>;
 				regulator-boot-on;
 				regulator-always-on;
+				bootph-all;
 			};
 
 			bucka5: buck5 {
@@ -779,6 +782,7 @@ bucka5: buck5 {
 				regulator-max-microvolt = <850000>;
 				regulator-boot-on;
 				regulator-always-on;
+				bootph-all;
 			};
 
 			ldoa1: ldo1 {
@@ -787,6 +791,7 @@ ldoa1: ldo1 {
 				regulator-max-microvolt = <1800000>;
 				regulator-boot-on;
 				regulator-always-on;
+				bootph-all;
 			};
 
 			ldoa2: ldo2 {
@@ -795,6 +800,7 @@ ldoa2: ldo2 {
 				regulator-max-microvolt = <3300000>;
 				regulator-boot-on;
 				regulator-always-on;
+				bootph-all;
 			};
 
 			ldoa3: ldo3 {
@@ -803,6 +809,7 @@ ldoa3: ldo3 {
 				regulator-max-microvolt = <800000>;
 				regulator-boot-on;
 				regulator-always-on;
+				bootph-all;
 			};
 
 			ldoa4: ldo4 {
@@ -811,6 +818,7 @@ ldoa4: ldo4 {
 				regulator-max-microvolt = <1800000>;
 				regulator-boot-on;
 				regulator-always-on;
+				bootph-all;
 			};
 		};
 	};

-- 
2.47.0


