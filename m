Return-Path: <linux-kernel+bounces-330960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2432397A68E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 19:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 695D61F285DC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 17:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836D715B555;
	Mon, 16 Sep 2024 17:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RJAWGNve"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4305F1581E0
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 17:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726506902; cv=none; b=YOSIV6mv4ZIP5o75QBRLdYwJBDIhjlwDEZDBnGqFKeViwThEA5vUPVfmowW6PtSxZnsZ6CP4vnNmcXgDuGB/2VnjQV9GdLV2YZfjwsMdwSd4HKm13hIkqSze+evbqQyccGZaLNUO2/YDGtIgZJBGafMFev2wq8KvysPxm51yC1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726506902; c=relaxed/simple;
	bh=6IaFT2/ohrQru/Mrl/o1mNIokzVDUxjyxOrF2zTQv68=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j1hSgbNef2pWGCSMtolQMbMVW/k17gc3aiJuf7cagO/8akiKXzmKPqenmYqjqq4WrqWd3qUi+yK3nXc30KyDadUfAqcOE8AaOr/lQitocERgWaeKsJnbUiB0i61E0DzH7C9Cl/wZuhznjOpAh0B/Los/HRoVcHljPNCMiug0deA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RJAWGNve; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726506900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NhZEHGCroaVGHFp9gEos3MTv0PtDFgshMDzxRxracYI=;
	b=RJAWGNveMZj1dzf92qQy2zVWP4aBnU0yw2rLOO97F3F0BeUm8oGqUhxWEAX9LW84B+K61P
	fBNFEM54XOP69+jATyb7lXyWuMvZwZ9vYCja5QC9cqCUcKdPvgqli7XnBNWpBIFiTk/z9x
	3DEcjPPT51W7XQmLRbeHqAAcsfAV0E4=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-k-5k41x8Pkmx5s_R85tOrw-1; Mon, 16 Sep 2024 13:14:58 -0400
X-MC-Unique: k-5k41x8Pkmx5s_R85tOrw-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6c35b3a220aso131193006d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 10:14:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726506898; x=1727111698;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NhZEHGCroaVGHFp9gEos3MTv0PtDFgshMDzxRxracYI=;
        b=wQXI4Hu4CA24PQAe79bx+SQ9SsDL7QMEHQ+eiYxIV+TfwD0ZNr1nUYWhCPn47NHKhq
         ZuG48ws5LunGi0QZoGfJjKl+oNQ1mU9OYfVrRslVxTEAvZ6lNVloHsYenm8HIfnoNbeN
         BZP/HSo/5HQVhd2WzwOfNcvRqZS55JLp3prGOqXDQp8byMEX6u0s/B1pNZYG9mA7OL8S
         h13bVWMr3V2MufFIJrfZny13CpTutvd7lMUf7tpxzsHaYy9HrDjAKgXqsHErgw9aDc9e
         6rsWnuUFb49cklA3rsFdhud599o65G8vsRcbuhJ/INbk99pZ5JingsAA2jJxFO5EWwQH
         PL5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXVTqg0XPmqeyxRqob7hUqgAAsF7CH5C82y+llnZVG0KZLzfAGEClYoCD7RJUe1B9epDk4K/LvHzHc0COA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK44vK1qrqOqL3V/gNFfMHd9ndyHAWNs7Ie1fmA3VRJmXt+I6e
	lYbFFXYlVSrKU1R3N9Iy0yKID6NcRDKoj4loi3VPr5HZBRFL6gZDkM6AbiL6J+sBc06K+2cGhlM
	9E+f+O4VeqnEMqIegEEZP870dSdKaHE9Zm4zS5HJZAjR4KDoSym6Q1aZ8zaocpQ==
X-Received: by 2002:a05:6214:5d89:b0:6c3:5454:6e1e with SMTP id 6a1803df08f44-6c573b5910fmr311393026d6.24.1726506898376;
        Mon, 16 Sep 2024 10:14:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHG0QxGNDmQ1+GIOrknDD4WO1kV7CbK6PFRFI6iPR4lqXaXa/MtbEa348BAmNlFhhhTNmq0rg==
X-Received: by 2002:a05:6214:5d89:b0:6c3:5454:6e1e with SMTP id 6a1803df08f44-6c573b5910fmr311392466d6.24.1726506897968;
        Mon, 16 Sep 2024 10:14:57 -0700 (PDT)
Received: from x1gen2nano.local ([2600:1700:1ff0:d0e0::43])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c58c6262d9sm26342046d6.28.2024.09.16.10.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 10:14:54 -0700 (PDT)
From: Andrew Halaney <ahalaney@redhat.com>
Date: Mon, 16 Sep 2024 12:14:51 -0500
Subject: [PATCH v3 1/2] arm64: dts: ti: k3-j784s4-evm: Mark tps659413
 regulators as bootph-all
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240916-j784s4-tps6594-bootph-v3-1-ab70da0de7bd@redhat.com>
References: <20240916-j784s4-tps6594-bootph-v3-0-ab70da0de7bd@redhat.com>
In-Reply-To: <20240916-j784s4-tps6594-bootph-v3-0-ab70da0de7bd@redhat.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Keerthy <j-keerthy@ti.com>, Neha Malcom Francis <n-francis@ti.com>, 
 Eric Chanudet <echanude@redhat.com>, Enric Balletbo <eballetb@redhat.com>, 
 Udit Kumar <u-kumar1@ti.com>, Beleswar Prasad Padhi <b-padhi@ti.com>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Andrew Halaney <ahalaney@redhat.com>
X-Mailer: b4 0.14.1

In order for the MCU domain to access this PMIC, a regulator
needs to be marked appropriately otherwise it is not seen by SPL and
therefore not configured.

This is necessary if the MCU domain is to program the TPS6594 MCU ESM
state machine, which is required to wire up the watchdog in a manner
that will reset the board.

Tested-by: Udit Kumar <u-kumar1@ti.com>
Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
index 6695ebbcb4d0..87b5b9b11e96 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
@@ -668,6 +668,7 @@ bucka12: buck12 {
 				regulator-max-microvolt = <1100000>;
 				regulator-boot-on;
 				regulator-always-on;
+				bootph-all;
 			};
 
 			bucka3: buck3 {
@@ -676,6 +677,7 @@ bucka3: buck3 {
 				regulator-max-microvolt = <850000>;
 				regulator-boot-on;
 				regulator-always-on;
+				bootph-all;
 			};
 
 			bucka4: buck4 {
@@ -684,6 +686,7 @@ bucka4: buck4 {
 				regulator-max-microvolt = <1800000>;
 				regulator-boot-on;
 				regulator-always-on;
+				bootph-all;
 			};
 
 			bucka5: buck5 {
@@ -692,6 +695,7 @@ bucka5: buck5 {
 				regulator-max-microvolt = <850000>;
 				regulator-boot-on;
 				regulator-always-on;
+				bootph-all;
 			};
 
 			ldoa1: ldo1 {
@@ -700,6 +704,7 @@ ldoa1: ldo1 {
 				regulator-max-microvolt = <1800000>;
 				regulator-boot-on;
 				regulator-always-on;
+				bootph-all;
 			};
 
 			ldoa2: ldo2 {
@@ -708,6 +713,7 @@ ldoa2: ldo2 {
 				regulator-max-microvolt = <3300000>;
 				regulator-boot-on;
 				regulator-always-on;
+				bootph-all;
 			};
 
 			ldoa3: ldo3 {
@@ -716,6 +722,7 @@ ldoa3: ldo3 {
 				regulator-max-microvolt = <800000>;
 				regulator-boot-on;
 				regulator-always-on;
+				bootph-all;
 			};
 
 			ldoa4: ldo4 {
@@ -724,6 +731,7 @@ ldoa4: ldo4 {
 				regulator-max-microvolt = <1800000>;
 				regulator-boot-on;
 				regulator-always-on;
+				bootph-all;
 			};
 		};
 	};

-- 
2.46.0


