Return-Path: <linux-kernel+bounces-373395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 987899A5640
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 21:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E0A51C20FD3
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 19:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74079199239;
	Sun, 20 Oct 2024 19:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hmal9wc3"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FAC1990D6;
	Sun, 20 Oct 2024 19:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729453241; cv=none; b=D7Yni/9DmuHoIqMmxitHkK2LCfaDzaep1FV8d6rN8KmVE5uKc7xAbvM5qCIHOkomyYfCoBOOehNIcmQO/YCcCUlSm/Kq/sSdyLGODNYkNKQ9j+veAcqt+0Cxy31hfVq+t4Xw0iWs+6UDmTN3ee/TYWTy87IQvLkx2v3qrWX8nmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729453241; c=relaxed/simple;
	bh=V2yl4lNntEuPEV0X2MVL+IE3GiZVw/y9HCOf0Pz1aTk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IPnXrB26wrAJQwGbUaDhP+4tbQBP8hWj9mW0QosQ4fa0e+C16iNaalDHu/FwRE0yB151kDubBUAaLYW7zjW64pQNkx8RgCiAsEOfRlx3KDrIA6tWbZpsDLNIB1LHS8TmzutPER9CesTM3NTjJC9/bgBCi9evU81REXmiYyvC7Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hmal9wc3; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c8ae7953b2so613128a12.2;
        Sun, 20 Oct 2024 12:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729453238; x=1730058038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9wwdH5E3n/FKvtFIFoeUG2vP8wssuIiUjkTOLgVYvdE=;
        b=hmal9wc3QvYCrHXv2utNaLd+jigDQURvqcwwGvpH3NaPz5Z83pBSooUwOKMwcCdyMv
         kqalbcNuOCirPBuM5zSgc1O5oD4lLZOn3ly7zyuycJ8jwEHf/1TEChBeJvX4slTPNGz2
         tDvQwLi4gla5+PXyfzOWUHEU7crf2+sKfU8by6XE+tKsN9e/5xqRrk71xDHET0fLZiTE
         W/kmJ5elkE0pMxM8vTODAWa6uou5DN5cjQphZunMYmNIEJ0M0KQMAfEs8K6/iJfX8zoh
         beUQSvOeww7nlTSe10nrFZXpVfL7JMyT+TTmxjB1GXe+oOVa5T0F2hofQgN3JyUNGgew
         CsGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729453238; x=1730058038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9wwdH5E3n/FKvtFIFoeUG2vP8wssuIiUjkTOLgVYvdE=;
        b=waZfzaTl/QL/8JR0dhx6w/3XTrtJdepuKwZyBKnOixYJZy2jv/Qwlk/6cK/A7dxpLT
         UuM2ph7VHF1mfSm96V07GS5qA1EgqtxTC1QqqZvwohgqq8Rd9fuISRvvp6Uhm5LcFwGI
         bqkuSnPQGTS/IK+JYbCv1f0qdUZMQS+VuC0c2nk7k26dxWGZjkSl0V458UFljpxeUoRg
         7uef8iJm9fvdst7lmt72MFzeRyfyQSRh16bgJbbW+KipqgQlubXOQr589VTLLtWWhPCc
         Q6sLFem003JjZgUpGIce5r52nEXnfE2leLHIFVheau+JtESqha8rQQVlGWm+2DT05rC1
         LVew==
X-Forwarded-Encrypted: i=1; AJvYcCWhm/b4J6rRzT+SNwnwj178Jb5MmTT6oGlwVxpM1sBucwUiXmEcgbH4RCHQbP3XvirY3yEmgTRhNClE@vger.kernel.org, AJvYcCXRZSzQkBIR/lZI5w8weIZZDs0uiPvQj7xQscxbmoVCDgN17+RpckkdawQlj20PPLr4A5DGptAk+C6D3/eF@vger.kernel.org
X-Gm-Message-State: AOJu0YzfS0K/Xd6eGD3GMn1zvz3/XuuBKJUh2X5ZnqOjaOjAAdBNLUrh
	PJWMJ9f38G7wnMPOlbE+K23fZHnEDv7jiEPsP233IvZ30L1WQgEx
X-Google-Smtp-Source: AGHT+IEoUqPWyMGSegIGl7DGeOkVLEGnTmbG8Hwr2jDlIpvyJfAnfAvxvisexunW9mN25cbmNor73Q==
X-Received: by 2002:a17:906:cb89:b0:a9a:123d:3f25 with SMTP id a640c23a62f3a-a9a69ca374fmr320996366b.13.1729453238173;
        Sun, 20 Oct 2024 12:40:38 -0700 (PDT)
Received: from e8ff02ae9b18.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a91578129sm120576966b.186.2024.10.20.12.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 12:40:37 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dinguyen@kernel.org,
	marex@denx.de,
	s.trumtrar@pengutronix.de
Cc: l.rubusch@gmail.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCHv2 05/23] ARM: dts: socfpga: add label to clock manager
Date: Sun, 20 Oct 2024 19:40:10 +0000
Message-Id: <20241020194028.2272371-6-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241020194028.2272371-1-l.rubusch@gmail.com>
References: <20241020194028.2272371-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Devicetree setup expects a clock manager label to be around. In
preparation of upcoming changes to allow for compatibility.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
index 90e4ea61d..7f7ac0dc1 100644
--- a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
@@ -88,7 +88,7 @@ fpga-region {
 			fpga-mgr = <&fpga_mgr>;
 		};
 
-		clkmgr@ffd04000 {
+		clkmgr: clkmgr@ffd04000 {
 				compatible = "altr,clk-mgr";
 				reg = <0xffd04000 0x1000>;
 
-- 
2.25.1


