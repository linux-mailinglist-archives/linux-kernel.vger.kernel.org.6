Return-Path: <linux-kernel+bounces-228832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2973491679E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 14:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A8581C223D9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 12:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09DC316D33A;
	Tue, 25 Jun 2024 12:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y5ihHA4K"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192BE1494A0;
	Tue, 25 Jun 2024 12:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719318065; cv=none; b=SwVgRjT2+eqPM3GnOB2DZdgM3VFQIl5GverNHdCXy5voiyGCYuk5UVZsgwLHG5u6BzZfNfXC/9Nkx67E4tO1/IAsThsujZF8WuaN6hreMfcErlhalBXxkWLcLLdleqaf+GUJqHto7/ONY5UKEZ4Woq99ggjO0UeXuUwrRrUyCNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719318065; c=relaxed/simple;
	bh=mYFriQEBKDozsPNPJa2LuEHBJlWuukdWNEEziNwxBuE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=irK60Xsxa6NnjGhQq1Me8wdwVFNKtzPwZmWJ48N7a03/r4gV1uDMDIyX7zYT+tZbP9pfBRWFBqKMegfVnj1yNbAsiOJHMGDBBJHNh1XReoYvekXZ9kFwUOsgonO98BVr9TTI9fGZ2l0/bud5GvTXaDcXih+bVIJKSNOwxy6oISs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y5ihHA4K; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-706642b4403so2177788b3a.1;
        Tue, 25 Jun 2024 05:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719318063; x=1719922863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GXlYaImuhyzLH4pYO5uD8xNkBf2rJUj2xPuv+IWcoog=;
        b=Y5ihHA4KEQg6JBiezucToC87Gk69Zf0hs+ovHjf4iRT0znr/qsBB6GvmVHWBHij6qV
         FfWHhjV4Os//X9VCj9JQ+gVRQA4XrnLJYagJPGwrJks5T9uMtqAqBHAuql/EWtp+FVJn
         HGG/msU2j2tEgHaD6J1uzDgVSNO1NrO57HopFR2pPxgnRV6ffLlmq95tSJve3T87ws6M
         4DCfcKgpIwoJoEyuc/db4yX6Ai2nhw/B98aznZ6xEnS1LjwAZaJICHMPLtpIHKJ4SVMT
         797JywsvEACLAUU4mat1LJghFq/6KlMJV1ZWTpjLX8QEJA0lDoiIXJUF+eRoVtGu632E
         lHEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719318063; x=1719922863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GXlYaImuhyzLH4pYO5uD8xNkBf2rJUj2xPuv+IWcoog=;
        b=jNd/0ciDf5NMidUtb98fxFcb6lbSzUac+p1L9nUynovRLHSedbDX5g41bnFpFuktnJ
         ZPj8TLRLGPoUk1F3pyu6UHajGabFM77AQx/5ZbJtLi/4MTx2eVAL7F4x4pijOTq3jGHk
         u70TqSQTCv2GaJflx78w2M81NfZLzxBXPaFb0xcKcJK8iHniKsqigDFmEaAbt1Js10dv
         EGijCxNplScqOthIuauMq/OTX1sLkdwHbx7EjZU3u4FrNjWil75IdQq9lQE1Lvrazta6
         3HekFgQj4c30XXiFZCUh1KFXGhvgFu9PhhRECyTerhhFQdDMCChQEJGtaQy7RCEqWdGN
         Z7/w==
X-Forwarded-Encrypted: i=1; AJvYcCUqQ+8+RUCIaFSY1FfHo6zvezdzjg2IeIfvp/gnUdANkkqB4hc8sHcqNzRLjgBfJDMPzc/tNq96PA/tlwjO8cBJz2ffTRe2gONZu92mzgMVZjRSkbPzdNBQOWTnZuvUz+d1+bKtwKZOTA==
X-Gm-Message-State: AOJu0YwMmtgPBBg0fbmiqQ52F5x8Ur7x2FDa7FICfrh4V+EC84ubHx5u
	UJukWPbxVmDABfBb4LylWUIgoWjhEN6P+5Hf1kVQUIsU3Lmye3CVPpwmXgJ5
X-Google-Smtp-Source: AGHT+IF9+MgAE+eccf+8vrgxyv+i3L+xcqs0riGfMjQXInNcrydpeZHHWE5cWwB4YshZn99ZhQ9Jwg==
X-Received: by 2002:a05:6a20:1719:b0:1bd:25bd:ef6f with SMTP id adf61e73a8af0-1bd25bdf203mr972374637.18.1719318063337;
        Tue, 25 Jun 2024 05:21:03 -0700 (PDT)
Received: from obliging-System-Product-Name.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70650e312e4sm7978146b3a.0.2024.06.25.05.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 05:21:02 -0700 (PDT)
From: Yang Chen <yangchen.openbmc@gmail.com>
To: joel@jms.id.au,
	andrew@codeconstruct.com.au,
	patrick@stwcx.xyz,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Jerry.Lin@quantatw.com,
	yangchen.openbmc@gmail.com
Subject: [PATCH 11/17] ARM: dts: aspeed: minerva: enable ehci0 for USB
Date: Tue, 25 Jun 2024 20:18:29 +0800
Message-Id: <20240625121835.751013-12-yangchen.openbmc@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240625121835.751013-1-yangchen.openbmc@gmail.com>
References: <20240625121835.751013-1-yangchen.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yang Chen <yang.chen@quantatw.com>

Enable ehci0 for USB.

Signed-off-by: Yang Chen <yang.chen@quantatw.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
index 58a083536c79..830616663387 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
@@ -552,6 +552,10 @@ &adc1 {
 	pinctrl-0 = <&pinctrl_adc10_default>;
 };
 
+&ehci0 {
+	status = "okay";
+};
+
 &ehci1 {
 	status = "okay";
 };
-- 
2.34.1


