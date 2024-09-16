Return-Path: <linux-kernel+bounces-330962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E72F97A692
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 19:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B25EB24B68
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 17:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E024015D5B6;
	Mon, 16 Sep 2024 17:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S+n0hPbs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF75E15C12E
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 17:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726506906; cv=none; b=kVLOxy/KDel0bjHzNJXUU2FxaURktGhl157EulJjmcoscAfS5qfP3cAq7WiGmAl5Alzcv1O1oIPDAIwlm9wElmm/81rgKWgA5g/okxSRDVymdWNhTD+VLpBiT4Qy+8mTf5sGSX5bbuNthgLDwAarCpu1T/DG8JZX/lf5YF3U4kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726506906; c=relaxed/simple;
	bh=4ECZLKiRHA+gtMcwnStLm7lZ8TTumzynBfppq8efj+M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bm7Q3DOAV6miPO1T7sonbceIjwhhNgIi845BzoJUVXU/Y6Viq2Sjv3oWOsLfEHgSerL5mMpXLdTFYqZ2ywr4rZzRi/W3O50QIru8cPkCfWLKcdy0Ld2viBEujQrTZStE79MlYgVnabSXjCLTeccH4zodWOp2Z5GGfrVInUD+0oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S+n0hPbs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726506903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/dEEkhuQZAOrCmKjg6Ee/Hctgl/7cBRuPP+SnJEJWVw=;
	b=S+n0hPbs9CnIaqsgsTECZJ/u/dJkI9Ua+HubFMN+TL7GIEXZHXh7rIR1kBwmBjukTrEp6O
	JCSFtgQkDSnDvYoqOpei4VCccL80QRHV7iAFTI1AJ2qWM3+qzoYYsg9+3lZt49jUpVXGv0
	8xCZ/AfBcUCr9A1Cs5uoqeXnvMkt4LQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-qGkRw8hrP6mR106xB6EKpw-1; Mon, 16 Sep 2024 13:15:00 -0400
X-MC-Unique: qGkRw8hrP6mR106xB6EKpw-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6c353d32ea0so91590226d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 10:15:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726506900; x=1727111700;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/dEEkhuQZAOrCmKjg6Ee/Hctgl/7cBRuPP+SnJEJWVw=;
        b=O5XFiFI110p+BuVE0txaom9WAp7lXQ5h5M6WBXcNCRu2ZuK+auZqvK3044bFHmmCGi
         /HMUYoGwgNpZY1l7lZJcUVAaf4RJjGgZQw74TyuhiEX9N6YrhDxiCDS5L5oS8pmdV6Lt
         q0cACeLM1V+/nQC6nSbA9KuGQahte1cGlXjcTH4jVNHfqaefLCiAZk3ANIUjgCuAS8Se
         anfhiMFJnvIqcWH7FtUNLsaQX6VWrwbT0jjF7aag57HZqmTK60XdC0YhKqYWIuCyYyuO
         xz7zn9i30u1y0C+1ZIlPDflVcnSsDJGa4dQsk75kBpw7FM/85LV50PnMiW/ymf54Vr+R
         7E5A==
X-Forwarded-Encrypted: i=1; AJvYcCUj4QHTrH47/kNeWz11kcIJKx/BkCJFo3+lfAK56RBQNs1vHua2WbJfy06q9xPzp+f8op3yZH+zLlZVBko=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnRpJ0zgvb+uUYynZpJvK4aCNlC7utpcW5wZmovsD0ybPyIL31
	/cfI9cly3ChDIvbdph6oHAuN+MkF7CWIMIV26wQ+ZMWiPAZzUeaoj5d3cErguHRcEIoxMuYuq6C
	is1MOT2mXrsJNCsTtLkE7x3uDVHI75YZQ7c7xtH37IJQunKRmh3i1iEvRykr27w==
X-Received: by 2002:a05:6214:311b:b0:6c5:119f:de71 with SMTP id 6a1803df08f44-6c57351057fmr203020546d6.4.1726506899870;
        Mon, 16 Sep 2024 10:14:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFu9a0U8VximqKCxmOsMbOtnFV+etYAH6DyNbSVDPs/EdOxgubQUM0Lat71tP/H2RBIuxlwXw==
X-Received: by 2002:a05:6214:311b:b0:6c5:119f:de71 with SMTP id 6a1803df08f44-6c57351057fmr203020246d6.4.1726506899508;
        Mon, 16 Sep 2024 10:14:59 -0700 (PDT)
Received: from x1gen2nano.local ([2600:1700:1ff0:d0e0::43])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c58c6262d9sm26342046d6.28.2024.09.16.10.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 10:14:58 -0700 (PDT)
From: Andrew Halaney <ahalaney@redhat.com>
Date: Mon, 16 Sep 2024 12:14:52 -0500
Subject: [PATCH v3 2/2] arm64: dts: ti: k3-am69-sk: Mark tps659413
 regulators as bootph-all
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240916-j784s4-tps6594-bootph-v3-2-ab70da0de7bd@redhat.com>
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
 arch/arm64/boot/dts/ti/k3-am69-sk.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am69-sk.dts b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
index 1e36965a1403..5f24a1608bdc 100644
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
2.46.0


