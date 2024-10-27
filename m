Return-Path: <linux-kernel+bounces-383658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D559B1ED1
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 15:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18EC01C225F4
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 14:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4435185B67;
	Sun, 27 Oct 2024 14:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GSxuJUYR"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A69117E8F7;
	Sun, 27 Oct 2024 14:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730039831; cv=none; b=evHUJ/zxfILfsNAMOVrTewTIZFTWzvm/LPQNQPxb6v0teguwD3aVUzLeX8PQQLPX72kwkfLy8u/+MlGHGXFbwiQ0pqSqi0aK9vgmiTeMicJaqYld3hyY7Ia/JiiJMNK4sDSUPZsSaj5NjYLfM6OxYYzKK4rhMcUvrUvRH1dFb2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730039831; c=relaxed/simple;
	bh=y6S/vFniqdK8FnY4Owxt462kYlq+HMo/27OIQpdXFyk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q9kCn0KFylzBWGI/DQSImvAuJU8IOxGZWs3Y9X67e9TzBt7MmzJObrXLeR3CTq83dGQ/7RrcRZEEjJa1PdMdj8cM21oC3LDndd/J/MLg3iqnjzt9ZWWype3wzM12thNn+K5FGucOrwkMkB2K8B4j3agVMbh6nViciWJ/L4E8OzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GSxuJUYR; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c8ae7953b2so623883a12.2;
        Sun, 27 Oct 2024 07:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730039827; x=1730644627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QbnDXxocaCyheHFI8hTECOWKPKoXgfCmEGz3dctI1es=;
        b=GSxuJUYR1w/+nE6xEifphPlnP2cqHk9LZZ+EQpdeJX7JlWk4w7+G9EbqHCFENWBae8
         qU8q1zsW68GmBkWROmmCOjySmXqv9d3T5nevnIGKIv/EsUW72UEsfes/QNRSFuWG8TEw
         S6NRz6ixO4MOByFuKJYDPlp1agjdC9dNPlbwva+hKRkCJJJmHJ0mq70WsLa9Kb8fwNeJ
         1UuRxIFgUqqLS4fQF1o1nhFXToS0qXANay/8cajkfe7OPg6ZArfLHSkgkwM2Q2/xmqfD
         X05tamrIJP7xYaeK2fnzLWiSrZH1e2B9yQL5fB6WHIVY3C0EXKoh6Cx8hIQGKoNmhvZg
         pIgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730039827; x=1730644627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QbnDXxocaCyheHFI8hTECOWKPKoXgfCmEGz3dctI1es=;
        b=nogW9RB59O4ChE3EwVZDQstFJxrz06B8bSQOZ5sGE3mNTPCHqIpMPfCltgrzK7VYWl
         EcgbIJr81dM66SmjVHrxyj7Co+bmAphh3ccEuyLYIVpHZmZIfC6cZ2EzludKhwu4u/3r
         EYEVErg+xXkpw6lZsgf8eaAvV91msUYy/Ou7QGb3PTWj/RHfxBIro5KpIzcF/Dg/2BHm
         82R8/VN/qWtEFER7II0lDLpMvqk/lWfxCmvQ16q2iPcBjpMoE/0NJiT+4qBTLjdRXxvm
         9IfQKF8HIfrJIKcdyx8IdJurJyN6hj1Grs0jUxs9EOcXJE9zWhyar4BdjNwNeGSsk0JM
         KaeA==
X-Forwarded-Encrypted: i=1; AJvYcCV/vPF9/a03X8bA6iNaZDHucnyt4wwuiZjc6HTd3kdQaV++GHBebP8DJsHec0/rQpFPi4AJSMLmN+Rd@vger.kernel.org, AJvYcCXsyqyhplc2uALyOWAij0RjyxWUuK7p4/ppRa5AnAMl28BYJxbzDX78V2NWRTS5zk6uMhX74d3AFsdz/2yq@vger.kernel.org
X-Gm-Message-State: AOJu0YwxjL8nbmzOzO3ViPFrmhVaY10qhUxMA98+rhE7wVjs9Oiunca/
	usi35qXs2KIe+bNQE0zPIHjYnYfPjhdujf79I60g2ezB2joYdBGU
X-Google-Smtp-Source: AGHT+IEk5d8ilAP9HXUoi9ltelUyJjo7yA0FxnqN/Awpr1Z6PWz0JcVNNeUn5+0cnQdPMPL+z10MBQ==
X-Received: by 2002:a17:906:d554:b0:a9a:130e:120c with SMTP id a640c23a62f3a-a9de631e898mr229491666b.12.1730039827396;
        Sun, 27 Oct 2024 07:37:07 -0700 (PDT)
Received: from 6c1d2e1f4cf4.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b331b0d44sm281127966b.187.2024.10.27.07.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 07:37:07 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	a.fatoum@pengutronix.de
Cc: conor+dt@kernel.org,
	dinguyen@kernel.org,
	marex@denx.de,
	s.trumtrar@pengutronix.de,
	l.rubusch@gmail.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCHv3 08/22] ARM: dts: socfpga: add clock-frequency property
Date: Sun, 27 Oct 2024 14:36:40 +0000
Message-Id: <20241027143654.28474-9-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241027143654.28474-1-l.rubusch@gmail.com>
References: <20241027143654.28474-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add 'clock-frequency' is a required property by dtschema. Initialization
is open, similar to agilex devices.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
index 65d04339f..5f4bed187 100644
--- a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10.dtsi
@@ -99,21 +99,25 @@ clocks {
 					cb_intosc_hs_div2_clk: cb_intosc_hs_div2_clk {
 						#clock-cells = <0>;
 						compatible = "fixed-clock";
+						clock-frequency = <0>;
 					};
 
 					cb_intosc_ls_clk: cb_intosc_ls_clk {
 						#clock-cells = <0>;
 						compatible = "fixed-clock";
+						clock-frequency = <0>;
 					};
 
 					f2s_free_clk: f2s_free_clk {
 						#clock-cells = <0>;
 						compatible = "fixed-clock";
+						clock-frequency = <0>;
 					};
 
 					osc1: osc1 {
 						#clock-cells = <0>;
 						compatible = "fixed-clock";
+						clock-frequency = <0>;
 					};
 
 					main_pll: main_pll@40 {
-- 
2.25.1


