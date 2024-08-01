Return-Path: <linux-kernel+bounces-271754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3EAE9452E7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 20:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 556CD1F241A0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 18:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF8414A4F3;
	Thu,  1 Aug 2024 18:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b="T05bv26C"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB6614A4C0
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 18:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722537509; cv=none; b=tBBqPilvLCQ2W4DzV34YdQd8saG6foKaoshfs6N8yazLTBovthkTA5HE5UkpbZRkPwi7KhqvtAuGBfVStOUhQ6tDXro5oFkFtd1CFGkxZdlBh+nrGrlBB3ASFWqt2WiCF39RWz5WJDjxJGau3ZioiRE2f4fv3oLlffkYkUMY+SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722537509; c=relaxed/simple;
	bh=l3zCoSXugn4d1wZq7zuWBdlwj6OU/WdHP/Tlj6XrimQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ctTeUSHGk6VLMCZ9UX/Q6WEEVEUifrWipdOaU6u8ar27Qb8jjBlpMs8yRgG8SFtDgLvQkCVqmtrNKsEl5jpB89nfxPFYcLtGUwJn28UQE7itmV9MO20wq0kCgrX+8IG5UIvgcFTQpkJWE5LUK4eoqLs0bUkTHilUo4vU+e2sY+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com; spf=none smtp.mailfrom=pdp7.com; dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b=T05bv26C; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pdp7.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7ab09739287so4427078a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 11:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pdp7-com.20230601.gappssmtp.com; s=20230601; t=1722537507; x=1723142307; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5vq4jHV8nbxc5imvEqzCuTIu9VwOjDaomzudxx3WtyA=;
        b=T05bv26CgXBFufHuXFLa6C/GCp2XnTs5vFgvj9OAIyyUUtJODpc89UdVDhBMotv5r7
         lyOlOUTZgEf23G/AfZ3GCkuF12kefzM3rNjdkzVHBdawWb+79bcl1iZCD7g+APof56ul
         mIsFuOFL1ZU6ZeAtA7p3phyvObrTrgj0jQ2hNqxavNAhXIvKBVNGgoSD3qmmD1Fyqm/+
         xhm/gVy9ihRlgpVqpXUe7FAsZSUjvkqu+aDuKQKVBvJk/BqtceEFoMWK+fxokJl1/Blp
         uP9uc6uNfnCqrU4kMIK5jxxOmegpv5yjtv/rrrcFu4IAbPSZIzX17ftt2IEHZdNttFZs
         utZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722537507; x=1723142307;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5vq4jHV8nbxc5imvEqzCuTIu9VwOjDaomzudxx3WtyA=;
        b=thP3ftjd+CIFN+hWc1JyVKhkrlLwbqUOUh29FwOxrxAYNACSqDc2rLtjM8CN+y36CF
         WQWGFFbIEcrB+tzeprBu6AZpk/4ETN3cm8pgxFUhaWpH2uOt7/NhTHAvJ0FFnITJJAFz
         fl/kfql8rAA5623oGcamrzlGoStYRJrly18m9/MLUCTUOOFvgcsBVTJjrBbQ6JFGHrUT
         gSLEzbd4Lq5KJLMP/u66JgMc/0VN0PI2cjUsr3L0GdYafR/1nEmcHywrzllTcWFg4Yka
         dk7mQNHuJzpSdFU/NL6AgIN4pHX7Z+kp7WDkLauKzQbI1yUUNXchs4plG4/bvJ1NIG/g
         hPdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVm4RkKKQAwZOnF6vci7BOxNg51hagayTXUztEvpPtwAb5NnBsSqstHKYVYKwDnhDTNE1Unh8XrUdmnwVY/DRxhNY5W1/r3xvMr/K7t
X-Gm-Message-State: AOJu0YxsU6YQhQ/ugn35t0HVpZcsmJcJ4Lpxna+NZnmFOD8ZsVzP5ai/
	tKzXZb/auoerpVPFVZMBPaVcUCE2ZeIiHuF1Ou5l/x0crAOjXwEZajhMLnB4iGs=
X-Google-Smtp-Source: AGHT+IHnPHgk53nMt9sJxkeT7R3JYwKkr0GOY6NgiaPiYEwg+ooJVjf3p/z5vpN557IayqH1ywEWjw==
X-Received: by 2002:a17:90b:8c2:b0:2ca:1c9e:e012 with SMTP id 98e67ed59e1d1-2cff93d4117mr1330754a91.6.1722537506992;
        Thu, 01 Aug 2024 11:38:26 -0700 (PDT)
Received: from [127.0.1.1] ([2601:1c2:1802:170:dfa1:41a7:9478:9d47])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cffaf69d54sm279728a91.12.2024.08.01.11.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 11:38:26 -0700 (PDT)
From: Drew Fustini <drew@pdp7.com>
Date: Thu, 01 Aug 2024 11:38:09 -0700
Subject: [PATCH 5/6] riscv: dts: thead: add clock to TH1520 gpio nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240801-th1520-clk-dts-v1-5-71077a0614b8@pdp7.com>
References: <20240801-th1520-clk-dts-v1-0-71077a0614b8@pdp7.com>
In-Reply-To: <20240801-th1520-clk-dts-v1-0-71077a0614b8@pdp7.com>
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>, 
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
 Kanak Shilledar <kanakshilledar@gmail.com>, 
 Jisheng Zhang <jszhang@kernel.org>, Guo Ren <guoren@kernel.org>, 
 Fu Wei <wefu@redhat.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Drew Fustini <drew@pdp7.com>, 
 Drew Fustini <dfustini@tenstorrent.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1705; i=drew@pdp7.com;
 h=from:subject:message-id; bh=L05YOZ6P7b77yQdqua1ed/hLSCwatc60q8wYDB+6T9E=;
 b=owGbwMvMwCF2+43O4ZsaG3kYT6slMaStviZ1Nn7JpyPK8uce7rlh2D/xSpjfu91qh5hX7lsU/
 7R145otCR2lLAxiHAyyYoosmz7kXVjiFfp1wfwX22DmsDKBDGHg4hSAiahMZPif9uS1ncGMoE3s
 NtuM37J+MtSfJrjra44Ss9GDmMDzly2BKrwjy5qyfr+boZahwBBQdXrqnff1u7dqNH75PlfiUaL
 6a1YA
X-Developer-Key: i=drew@pdp7.com; a=openpgp;
 fpr=1B6F948213EA489734F3997035D5CD577C1E6010

From: Drew Fustini <dfustini@tenstorrent.com>

Add clock property to TH1520 gpio controller nodes. These clock gates
refer to corresponding enable bits in the peripheral clock gate control
register. Refer to register PERI_CLK_CFG in section 4.4.2.2.52 of the
TH1520 System User Manual.

Link: https://git.beagleboard.org/beaglev-ahead/beaglev-ahead/-/tree/main/docs
Signed-off-by: Drew Fustini <dfustini@tenstorrent.com>
---
 arch/riscv/boot/dts/thead/th1520.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
index 6ea5cabbcf60..5f4f94ca9cc7 100644
--- a/arch/riscv/boot/dts/thead/th1520.dtsi
+++ b/arch/riscv/boot/dts/thead/th1520.dtsi
@@ -327,6 +327,7 @@ gpio2: gpio@ffe7f34000 {
 			reg = <0xff 0xe7f34000 0x0 0x1000>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			clocks = <&clk CLK_GPIO2>;
 
 			portc: gpio-controller@0 {
 				compatible = "snps,dw-apb-gpio-port";
@@ -345,6 +346,7 @@ gpio3: gpio@ffe7f38000 {
 			reg = <0xff 0xe7f38000 0x0 0x1000>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			clocks = <&clk CLK_GPIO3>;
 
 			portd: gpio-controller@0 {
 				compatible = "snps,dw-apb-gpio-port";
@@ -363,6 +365,7 @@ gpio0: gpio@ffec005000 {
 			reg = <0xff 0xec005000 0x0 0x1000>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			clocks = <&clk CLK_GPIO0>;
 
 			porta: gpio-controller@0 {
 				compatible = "snps,dw-apb-gpio-port";
@@ -381,6 +384,7 @@ gpio1: gpio@ffec006000 {
 			reg = <0xff 0xec006000 0x0 0x1000>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			clocks = <&clk CLK_GPIO1>;
 
 			portb: gpio-controller@0 {
 				compatible = "snps,dw-apb-gpio-port";

-- 
2.34.1


