Return-Path: <linux-kernel+bounces-410746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A67039CE078
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 14:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 683BF28BC10
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 13:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10A61D4332;
	Fri, 15 Nov 2024 13:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="cZ6QPHRw"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F325B1CCEDB
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 13:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731678255; cv=none; b=BXAiU/tJR97E3vFtCABDEkrbA4+4pYSc3RsNxp04qxwOu8Rm8ekN7eeCRx6L9SCv7tlShyC3Vl3OwPc3Ld6r7ZmiU7UFkDoQK4WRoexZljvAe87RFY0ZXCkzNl4FXnKYGXRNvjRbYKnB7O7fZ7wprm1jKhof2gPfj8wKPkCKCLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731678255; c=relaxed/simple;
	bh=sc9CTLdGF8akXnnEYKS+FLO0ZLiAdZAgjw2Zn2YLkZY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jtzvoXsRDoBO3btMGyxZDIQ32uXf4GK4+69yIhmZFWwFxiQvJWK4blBn2tkWFFX3vuQVm8r5iTw2A1qOVmQUtZK0DxX82wIqu8e5Kkrx/9CpkTKK9UF5NTo74yLQIXHdHuEK/r++hzhN2Ilm2sU8xQkwa62rpTI/N3f4PMH+Qw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=cZ6QPHRw; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37d447de11dso548912f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 05:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1731678250; x=1732283050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I5y0VsPSk08U7p2tqXaJQIjq2ov8qkIzEO02XgcshlA=;
        b=cZ6QPHRw2v9fRpfq/O9//sWF/iUaj9Tg7mO9Ecb7J6ul5a5b+RXxskLp/OOidKjuxh
         lZnx4zRwmLEW8veeZ2koSbUbiP+PeGOVEWLSCT4wTUG+e4SJyy1IWTtJUA9AazGQvDnD
         qdfKQdU+iqrAaSsg4KljC+3bO2tyOFObyOMGEhbqjQNwssbumBtqa8YFi4U8Wovo7F8x
         EL5jhNDWgI06viNMpnXDvl2uXsAu2/bpUpyB884NPC2EAg1y7RYfTRHwNiaJf/ZiIAwn
         247fP8Ewh/Ehb+4p3noMczXFuwPmHPTsYhLVYuL4L9hQUvFNOZHVJoB8j2BeUFZsE1PX
         NyZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731678250; x=1732283050;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I5y0VsPSk08U7p2tqXaJQIjq2ov8qkIzEO02XgcshlA=;
        b=S9rqDolKzSJy0SsIyYXutSFgUhZns7cQ4L9THhhWcMQmKdt4YDPPFMZicMzo1OzUTj
         nAEBVm9ON2V4vUpor8s14+FjpKnS4H1Q2q8g08b65PPTvAZkYycLAMR017Zy4VoSEMkR
         +2RNeujRlvwJoRtRhDspHKb+rf9C+m3rYzlCIIaBopO6xPHZjOl57gZfR2aBQMiwGp+9
         HezDKQ3kA6D9CZp1IyQFh9kwS6WoPkBnMqnApWYrqmw5JYgn7sO/hAb53ZzC9qJbAboQ
         tLWDR5qSB9X91iD+7aaI0CqE2SeBz7NH2HllAsv+tvRVBacRk4n7S6B6xNBRIa5nOxjq
         LAwA==
X-Forwarded-Encrypted: i=1; AJvYcCWR8hfeMU1CU1wMCzv6YrS565T0tIbnSP4WFxBRsxMu+DpgaxRaeNddSpP5zXYbtS6omwPo4eUBkS9HiCU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6zjDDssb9XbN4kJ9cAREc/oEvjMIkqOWm8dyN9Axuj+2rdQQ3
	xbjMesm2vM1CWAvTJQhlyjNpGbAwylymZSMgR7AqP7LqP1SqAJ1qT7nfqgwZQIE=
X-Google-Smtp-Source: AGHT+IGiHMG9rqSM5bsbyK7EYOKL8gBTuBz9Z6IzT33QoBCun/jgIVK6Zf54KY6LeEKMlhUGRk6A4g==
X-Received: by 2002:a05:6000:1866:b0:37d:4f1b:35a with SMTP id ffacd0b85a97d-382259020f2mr2182114f8f.3.1731678249494;
        Fri, 15 Nov 2024 05:44:09 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821ada3fc9sm4378016f8f.20.2024.11.15.05.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 05:44:09 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: geert+renesas@glider.be,
	magnus.damm@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	p.zabel@pengutronix.de,
	lethal@linux-sh.org,
	g.liakhovetski@gmx.de
Cc: linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-serial@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v3 0/8] Add support for the rest of Renesas RZ/G3S serial interfaces
Date: Fri, 15 Nov 2024 15:43:53 +0200
Message-Id: <20241115134401.3893008-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

The Renesas RZ/G3S SoC has 6 serial interfaces. One of them is used
as debug console (and it is already enabled in the current code base).
Series adds support for the remaining ones.

Patches:
-    01/08 - adds clock, reset and power domain support for the serial
             interfaces
-    02/08 - serial driver fix patch identified while adding RZ/G3S
             support
-    03/08 - extends suspend to RAM support on the serial driver for
             the RZ/G3S SoC
- 04-08/08 - add device tree support

Merge strategy, if any:
- patch 01/08 can go through Renesas tree
- patches 02-03/08 can go through serial tree
- patches 04-08/08 can go through Renesas tree

Thank you,
Claudiu Beznea

Changes in v3:
- in patch "serial: sh-sci: Check if TX data was written to device in
  .tx_empty()":
-- check the status of the DMA transaction in tx_empty()
-- changed the variable name that tracks if TX occurred

Changes in v2:
- drop patch "serial: sh-sci: Clean sci_ports[0] after at earlycon exit"
  from v1 as it was already applied
- used bool instead of atomic_t in patch
  "serial: sh-sci: Check if TX data was written to device in .tx_empty()"

Claudiu Beznea (8):
  clk: renesas: r9a08g045: Add clock, reset and power domain for the
    remaining SCIFs
  serial: sh-sci: Check if TX data was written to device in .tx_empty()
  serial: sh-sci: Update the suspend/resume support
  arm64: dts: renesas: r9a08g045: Add the remaining SCIF interfaces
  arm64: dts: renesas: rzg3s-smarc: Fix the debug serial alias
  arm64: dts: renesas: rzg3s-smarc-switches: Add a header to describe
    different switches
  arm64: dts: renesas: rzg3s-smarc: Enable SCIF3
  arm64: dts: renesas: r9a08g045s33-smarc-pmod: Add overlay for SCIF1

 arch/arm64/boot/dts/renesas/Makefile          |  3 +
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi    | 90 +++++++++++++++++++
 .../dts/renesas/r9a08g045s33-smarc-pmod.dtso  | 48 ++++++++++
 .../boot/dts/renesas/rzg3s-smarc-som.dtsi     | 25 +-----
 .../boot/dts/renesas/rzg3s-smarc-switches.h   | 32 +++++++
 arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi  | 25 +++++-
 drivers/clk/renesas/r9a08g045-cpg.c           | 20 +++++
 drivers/tty/serial/sh-sci.c                   | 79 ++++++++++++++--
 8 files changed, 288 insertions(+), 34 deletions(-)
 create mode 100644 arch/arm64/boot/dts/renesas/r9a08g045s33-smarc-pmod.dtso
 create mode 100644 arch/arm64/boot/dts/renesas/rzg3s-smarc-switches.h

-- 
2.39.2


