Return-Path: <linux-kernel+bounces-364545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1859099D5F1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 19:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76987B243CF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 17:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7915A1C728F;
	Mon, 14 Oct 2024 17:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="gyeaPKgm"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFE91CCED9
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 17:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728928485; cv=none; b=TCOjvaC2SbDlqHMhhQsdzPc97ap6olYVAmuNHOqupXF7wdFr1yMyHEVDd+jIORVNOQ8vrXm05kcp4aq5kJtYICEaUGMHhc6pgW1CPf4XqLAVGPCVZsC0P5lN2ttf4tyTzOyenPaglaulyJEQutuA2gx2j94kOb8EEH689H+qPcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728928485; c=relaxed/simple;
	bh=SQK/KTPs/zaTbJpQJUohBtIMjsOZ37RzHMSdBhEfir4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kBI84z2Cv7xhcHOgNq4puFFczKkR94t9shvZGTD85gFXzklbtdpwJ9K7j5HJzOtayuTfXAl/WHrYc3nU12lrNFhEx3vj3zFmrdIwozZ3Oj47nBDVdW+dKj6On/lk7bxkzmUPO/eUhWgVcj2ZpMnsYFxmu6CfPl1zdQuYJG7xXz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=gyeaPKgm; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-71e72db7bb1so278654b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 10:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1728928484; x=1729533284; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qxQK+n9uvqhf6yQ2qTxF/yuzmEwFlzvtchBbUqK4Amk=;
        b=gyeaPKgmSqidUVx+9e5vrv2/fRmlJexWL8QP4NvCEnrW2X9jcafxvnlzWLygPjMkbJ
         t+Nay+EsnJXtIFWPSfGGFlXEst8itOtcTJIiNrjyHz9FS/FrGKHVegWR6YEfbbQT8zi+
         gjhti0cYfNRrMFBbFg+nZH2e2Z9r3Iw4l1U+L/x1NLeVaao6se4jbOosgpRG6lAj/dYU
         hL4FC4F4sJuwo/eNjMATwl/mUpSEKqa7naX8dkBAIu7B8eArgqKJzy2H+3EpZ+MQrZmv
         0fb/maW/Bmg1hYbpPCmNmgkowKDZRFeIN6jcYTSV2ohdgYlUpOnZzkMjtIzk87MWPa22
         X8pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728928484; x=1729533284;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qxQK+n9uvqhf6yQ2qTxF/yuzmEwFlzvtchBbUqK4Amk=;
        b=BVmT7zk18BqIHyWOSNAXtsYmMZ1GjOtciOc1OekayCeGwGH4UbqPQ2l3V8VTkVqX4u
         YrjuSBDv8atWGnUf5m7HmvWr17/KgPMSBNw2AbGR0BJEZQh6LY0y6RdlHj8XBvkVBsEu
         15CgFGefccRjB0CLHy16BofGn7Jgl00RtSudrxx/9EjUVGRFTAiEuJDobFpEcol3xS4Z
         w6UKUQ7n1h/sVpFo8ra6h7Gri26/nbo3YNvrmGoJw/upPGwbUYogc1obgtChLmZ8okTv
         +ExusghyOseQov7hj9T5CIxL82sWQNGPqZpqburTpm+67njooEu8kzUcnlNnjZNFq20T
         bYiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqQ1skk2KpaBzpD8Pn6g5veJjaFzynntqBf4R0EBd08S3NiXBQmuJptePdlvJs6zKJJVjm5ECIp7jku7U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMjuDckCFu0JafLhedPNQbmrDdxnbZ7OyIeqwLle9J/c/S6CQv
	ZSN9x4vL9vO2y9V8h4HOhMDxc9BZEJQ6V/Q1LzlfdWRhb17i4hKfw4TEz/Awocc=
X-Google-Smtp-Source: AGHT+IFZUMYy9vf9WX9eJFZ1DI5EcPS1iVJ1rtk3ygNh04bgPoR2FuxlgA7ZyP+WLjWOVGFidWnbzQ==
X-Received: by 2002:a05:6a00:2e11:b0:71e:4c34:e294 with SMTP id d2e1a72fcca58-71e4c34e41bmr13808172b3a.7.1728928483815;
        Mon, 14 Oct 2024 10:54:43 -0700 (PDT)
Received: from [127.0.1.1] (71-34-69-82.ptld.qwest.net. [71.34.69.82])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e49a7e5e7sm5611109b3a.179.2024.10.14.10.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 10:54:43 -0700 (PDT)
From: Drew Fustini <dfustini@tenstorrent.com>
Date: Mon, 14 Oct 2024 10:54:24 -0700
Subject: [PATCH 7/8] riscv: dts: thead: Add missing GPIO clock-names
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241014-th1520-pinctrl-dts-v1-7-268592ca786e@tenstorrent.com>
References: <20241014-th1520-pinctrl-dts-v1-0-268592ca786e@tenstorrent.com>
In-Reply-To: <20241014-th1520-pinctrl-dts-v1-0-268592ca786e@tenstorrent.com>
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>, 
 Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>, 
 Fu Wei <wefu@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
 Kanak Shilledar <kanakshilledar@gmail.com>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Drew Fustini <dfustini@tenstorrent.com>
X-Mailer: b4 0.14.1

From: Emil Renner Berthing <emil.renner.berthing@canonical.com>

The gpio-dwapb looks for clock named "bus" so add clock-names property
for the gpio controller nodes.

Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
[dfustini: add two more lines to the commit message]
Signed-off-by: Drew Fustini <dfustini@tenstorrent.com>
---
 arch/riscv/boot/dts/thead/th1520.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
index 31725c3a13d7..cd835aea07d2 100644
--- a/arch/riscv/boot/dts/thead/th1520.dtsi
+++ b/arch/riscv/boot/dts/thead/th1520.dtsi
@@ -329,6 +329,7 @@ gpio@ffe7f34000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			clocks = <&clk CLK_GPIO2>;
+			clock-names = "bus";
 
 			gpio2: gpio-controller@0 {
 				compatible = "snps,dw-apb-gpio-port";
@@ -349,6 +350,7 @@ gpio@ffe7f38000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			clocks = <&clk CLK_GPIO3>;
+			clock-names = "bus";
 
 			gpio3: gpio-controller@0 {
 				compatible = "snps,dw-apb-gpio-port";
@@ -376,6 +378,7 @@ gpio@ffec005000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			clocks = <&clk CLK_GPIO0>;
+			clock-names = "bus";
 
 			gpio0: gpio-controller@0 {
 				compatible = "snps,dw-apb-gpio-port";
@@ -396,6 +399,7 @@ gpio@ffec006000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			clocks = <&clk CLK_GPIO1>;
+			clock-names = "bus";
 
 			gpio1: gpio-controller@0 {
 				compatible = "snps,dw-apb-gpio-port";

-- 
2.34.1


