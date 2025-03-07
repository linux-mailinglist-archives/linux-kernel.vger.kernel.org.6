Return-Path: <linux-kernel+bounces-550849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB11A564FD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 11:19:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A4803ACAE8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 10:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E9B2116F9;
	Fri,  7 Mar 2025 10:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JvGsjnF4"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055E520E033;
	Fri,  7 Mar 2025 10:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741342698; cv=none; b=WeueDwyvQg7bunrC/lOTNNlepDnbGG2M06yq7pawoyz5poEjSXq1wAIksHvkbh3IT6DYG7wbXs2YcYvQFoCAmUTqjDM79MPbxLlaP4nmqmoT1rGtogU6DpOeYdzId8LHAf1RM+ww/2Rbc9Z0udaLC6fWMkHCU5XSOMoHImu0N6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741342698; c=relaxed/simple;
	bh=Hrpk3fM2ToSeRY6ZSJ5LgTGAbZEfHue5uXU35dGs0RY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LBgdNPc9+9nlejcQHun0liQIM5CzhO0Wcp6WtJayeW6dnZv/IDHZb4XgkmO9F+qK0MK16upPy1zv/W4nbyZTHY/jad6dv6w65FyodQbERv5XJx8mrM/iady0jmo+r7xwxKQ8Ohx9pGbZKN4Dl4luaQFcsutCOB8mdnfAOsGZPOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JvGsjnF4; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43bd732fd27so14198415e9.0;
        Fri, 07 Mar 2025 02:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741342693; x=1741947493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FalLckkLy2c4ipBkbA3HgidqaPtgkZG/OVl2zJ65m2Q=;
        b=JvGsjnF4H+IxdOrRhb3+yQsJ4UMjW7fLyxfKBOX4jTwXqRGMc62UxPSU8Z4RVq+vdF
         d8hyBfeQcPKItA5Z9+HKq0XBtef77LRB8TN5+dA2yAZDINjTVuN8rJjWnEbSnHICzbcY
         Y+wmnm/qzswiOodAjguwllwUKogiv/48VC1B/nNYWPlBLbu3812j3+18U5JI0coO2mkz
         uSKHafjz/0AjXGCWud1DI7NEXq4jgUGunzskktBF8a2cs+G41CJvf9DAODM2s2ngjoLP
         nq5OQOQFuagOWwZfqDdsLTFZeSL9Bo9Qql0kLC5mLxewDAEPx8VG3dyG4TGbOIMQs2WV
         xmww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741342693; x=1741947493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FalLckkLy2c4ipBkbA3HgidqaPtgkZG/OVl2zJ65m2Q=;
        b=VTF0etwqqJnAswuZ4pQdFSk4EMFr9iTmiTv52I90Xvnwpu8ByjmHWvP1IomkfOhbSA
         M/nUcibxnkfEqPL335KTnzdpbfXJlq5JMPciLyGYzwk0MOYzthm9fpasWfSJwmpM+X+S
         1OiqE2DyyA+me32FFSCi49f/4NpHRuDUutVdPYnmBE8/XR2AN/Ecxic7WjTv7l1lY2Xy
         KXWFqVwfjEF6fKM+MCYc3obp8WWFtcX4ilhhHnthDFkONg2LWCuU//zrLGT1I0VLmjO5
         45t01a3UtAp5JJcKLn2+9EYy3WN0Rc7H4JrVD5lc+quQyrab6Z9uJt/kec8sPRxwLeRz
         zJIw==
X-Forwarded-Encrypted: i=1; AJvYcCU3T3rSQwnAZ1lVd/AtbgcWwz248y909p0YhLIKVmLVXVUWeBE/Pn9aPpYwlK8ikfbryzeOyhha5T3E@vger.kernel.org, AJvYcCWrfDfE+gkQ3s6MQLEL7Dulbx+i1otGlelRFC7TZatZ6ER8+boa0Voe/x6BboJpyAk8/0aZP15D1145/WKY@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy077add+jSBzBOxYsfZQE0S8ac5JupeZLAupytQcNMtCQFsTX
	9LbJ1AAu8U38a2pcY2nf+ZtTlZ84BAXDCfA6foOuj/wF9s9/Bk+m
X-Gm-Gg: ASbGncsKzk26rWs/OIEjStRPjJ45Szf/9wGPvbllJf3CIqth6IPlbrYTshIaTLU6ugw
	PYzyP+kiQ7jqstURHOOzHjU+iH0VJ+VDRm7bCbxpOTVxgtbqfZMpYiW3g6c0kzJsZtI3hVD1aHu
	Axm1WEdHGzlnlClDsnGeKAC9MOe+jFTSpC7X9PkHUvHpntle1oMS2/5mv+NEfztS2KZE3elWpIQ
	W2msBCc1mEcgqDcR3pUvmhiCiFEay4DT8lTuB8yfhv5VbD1zeykSaL629DsGkPltKNdTF6WC88i
	xdGtdw6WFTAIUjEGDxFPzKLYYEB8zX0KQPJK1fo1ylu5pmwrwFfa0OqnQviuqpuu3nTxnaZlKHa
	eddeLiOrmiySMNawGcQhsas8=
X-Google-Smtp-Source: AGHT+IHI4qarjn6okL8fiFQY3ltBC2yY6DhIkGRizLqTlNjxjx9HKfSflu8OqxGOPt8PeQnTelbnew==
X-Received: by 2002:a05:6000:402a:b0:391:2dea:c9a5 with SMTP id ffacd0b85a97d-39132d6b61cmr1665637f8f.20.1741342693057;
        Fri, 07 Mar 2025 02:18:13 -0800 (PST)
Received: from ernest.corp.toradex.com (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c103aa5sm4900262f8f.94.2025.03.07.02.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 02:18:12 -0800 (PST)
From: ernestvanhoecke@gmail.com
X-Google-Original-From: ernest.vanhoecke@toradex.com
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v2 1/2] ARM: dts: apalis/colibri-imx6: Enable STMPE811 TS
Date: Fri,  7 Mar 2025 11:17:48 +0100
Message-ID: <20250307101758.27943-2-ernest.vanhoecke@toradex.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250307101758.27943-1-ernest.vanhoecke@toradex.com>
References: <20250307101758.27943-1-ernest.vanhoecke@toradex.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>

Enable the STMPE811 touchscreen in the SOM dtsi files. The STMPE811 is
part of the SOM. It's self contained within it, therefore, disabling it
is not the correct default behavior.

Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
v2: Fixed the "From" field
v1: https://lore.kernel.org/all/20250227170556.589668-2-ernest.vanhoecke@toradex.com/
---
 arch/arm/boot/dts/nxp/imx/imx6qdl-apalis.dtsi  | 1 -
 arch/arm/boot/dts/nxp/imx/imx6qdl-colibri.dtsi | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-apalis.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-apalis.dtsi
index dffab5aa8b9c..23913f18586c 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-apalis.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-apalis.dtsi
@@ -664,7 +664,6 @@ stmpe_ts: stmpe_touchscreen {
 			st,settling = <3>;
 			/* 5 ms touch detect interrupt delay */
 			st,touch-det-delay = <5>;
-			status = "disabled";
 		};
 
 		stmpe_adc: stmpe_adc {
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-colibri.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-colibri.dtsi
index 9f33419c260b..9a9f9764dc65 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-colibri.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-colibri.dtsi
@@ -588,7 +588,6 @@ stmpe_ts: stmpe_touchscreen {
 			st,settling = <3>;
 			/* 5 ms touch detect interrupt delay */
 			st,touch-det-delay = <5>;
-			status = "disabled";
 		};
 
 		stmpe_adc: stmpe_adc {
-- 
2.43.0


