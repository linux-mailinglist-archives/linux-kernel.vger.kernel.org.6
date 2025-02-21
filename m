Return-Path: <linux-kernel+bounces-526489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D0DA3FF56
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 20:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95C23189DAF2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 19:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9DD42528E5;
	Fri, 21 Feb 2025 19:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V1ZiiQb2"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9331EE006;
	Fri, 21 Feb 2025 19:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740165010; cv=none; b=Y2AJoejgtZaXITRxNHAFjfqYoFcnV4Jn6n0DfkQ9dLYyO7xl0CFaKPbNHiGGPl3m7TmA3Hz98eF7DmS8oHT6lo8bCx6h+sz+lHygGkpCiTw16QcZZ+30Bo0r0DLj8dUDOaxO7ZHTSIQsM7My6fhD0RE4tXkJr9eBwdis7C9SYvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740165010; c=relaxed/simple;
	bh=cSTaSEFNxDxO766u+g2scX6EoRBsJTeVLMz/j7PoO1A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IrteGUkb6M+h45/F08TPMnKnyVyP4obuQF/zbrtP+DElyYM/XgOvUZbWmAyvBlnlgMrTdz2LvFxoXtj4J+Ew5yRMnFhL9+p7mYEwCgZl6/oHWxWUlfJbzLlDGOsjCEZQ32Omq5IIGQ1OQXG5zFJ5F4HT24YXuqucFY0/FZeHojo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V1ZiiQb2; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-abb7520028bso343108066b.3;
        Fri, 21 Feb 2025 11:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740165007; x=1740769807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/RCLtFgB40kh5NGeWf7eTgIwKvvdlHuGYWJTu9Fn9iQ=;
        b=V1ZiiQb2TPg0vWc/JPNio+XXSBiyYWD59XY7IzXFbw6wn4EjB2/5ZKa5gAaSpCCPJH
         CXoOXRninlQfCcBJSd1hM1IygPRDydkmHo6avwVhkUTRpBl+DeOsCLyp6K1TCBDJ+SuJ
         27mU7KVCFJ1EOm/sBrLmRzoYcsWT8C3/AWjRybijQ5WAVtazMflmz6v5Iw3XFeOr7MCc
         KDLdBQmNoGklk9e/dBvmwtKwc+r8UIjy/rVlyIB8xXJ3gSaARHreeiIVX6yj/T+i7Z/S
         blShgQoCm+RwJcQrwwnd02NfoTJiAKA+EK6/t6xQp54iJQGg752hMgPzE9fJw9NB0MZg
         7c5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740165007; x=1740769807;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/RCLtFgB40kh5NGeWf7eTgIwKvvdlHuGYWJTu9Fn9iQ=;
        b=ugg2vBDk0m4ayf0tp8c7MoSlCKwSbMdbW/vA9eDiVblJYYhpK3PHWDWdBWx3Istzc8
         StWcR6GnHp/IuzzhkOXWX1n4uo7My2+sJp6ax4hKeg0812TgblrzophcBUkw5ZQOv8UX
         b3ErZNmMIvaWuXLtku0E1Rziv3aJkShDfcjR1Vy6goX5t1e/Q3NdbyLzpUIWWzaMvkzW
         cUbg8LU30ER6hfMQUcL8wrDfqOZoFolK8nxM3ml8XjIbes7MV7DBQRI+gzuc8NVzkxXU
         gFU7dM82ZG4lkF1xtN5OAHjGgVrKIarqnicPxkfb7WL5gIorL9n7KGWTkfsC/ofM8CJD
         XF1g==
X-Forwarded-Encrypted: i=1; AJvYcCUbkHPZEGPhBvSvtPNFkbD1FrpGShmrtlVDjxdqEl8376Yw938KiEs02kDwJoQ5c3QZynI0b5t6EDHr@vger.kernel.org, AJvYcCWGzMNHXRnFXZ2blyqo1RXMdHMzutr98rYo8h4lEUZSCchIFIR2EteOO88K/+BzV+eWXcA4RDWc62LI3hQk@vger.kernel.org, AJvYcCXDkgQV+WGX8j2i/iU4Ro5LhBSmzjXV0jq4Q8Vzjx8n65X9MMExfMjXAPBSwv84iscks4gjydLVgeXg@vger.kernel.org
X-Gm-Message-State: AOJu0YwqSHAbFwmaNguStYIV5qmikWTvpTaUP73feCytbkGZlC6FUABe
	JlHAqDa0AM/vBUJHIxP5G25YZozbaIa21i2wQfiveHt07E5Uf+yNxI+Rvv5dGv4=
X-Gm-Gg: ASbGncsTcXFDyLxw4DwnPm/cuHn8nkhgywCre+BfJ1cMeRfpYIs8I+tv4aZUii7yvps
	zlLMWk2FTvSerSp3fgFBm68v9tYE2tsFyXXtjm5GnInxP11ZxAD7wQU1kxDiCtndQKOzE6TWZFv
	tzP/YJ7CW7130c6KLlZTEAYLO96rgiAD1M64AC+ZMGG6LVA3b7G7PkREGefELVyxdRXYC1xkk7z
	5u/LH+9ndbx6Fjemeten/7kC5LltqURKMZtp12fMIYQfYcO+/n24McyL+CZNpHA39aST6qXFUn5
	oBKGcmeuxH1j/5ymGzOOpU4jdZUQAuYWRAQzqTZcVj+QF5AFXZ2up1YFBnA=
X-Google-Smtp-Source: AGHT+IFpUclfl3GP+JTSRxwBFyvgILom2sf5gyrQlkLG8A1WEQOIo0TKJpX4cHGGPDFAFepHADJp5w==
X-Received: by 2002:a17:907:d9f:b0:ab7:66d3:bc88 with SMTP id a640c23a62f3a-abc09e459famr488105666b.52.1740165006472;
        Fri, 21 Feb 2025 11:10:06 -0800 (PST)
Received: from playground.nxp.com ([82.79.237.175])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb9b187203sm1027261566b.61.2025.02.21.11.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 11:10:06 -0800 (PST)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Abel Vesa <abelvesa@kernel.org>,
	Peng Fan <peng.fan@nxp.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Marek Vasut <marex@denx.de>,
	Stephen Boyd <sboyd@kernel.org>,
	Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-clk@vger.kernel.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] clk: imx8mp: fix parents of AUDIOMIX DSP/OCRAM_A
Date: Fri, 21 Feb 2025 14:09:25 -0500
Message-Id: <20250221190929.31469-1-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

Correct the parent of the AUDIOMIX DSP and OCRAM_A clock gates by setting
it to AUDIO_AXI_CLK_ROOT, instead of AUDIO_AHB_CLK_ROOT. Additionally, set
the frequency of AUDIO_AXI_CLK_ROOT to 800MHz instead of the current
400MHz.

---
Changes in v2:
* add Fixes tags
* add Iulia's R-b
* link to v1: https://lore.kernel.org/imx/20250217165718.74619-1-laurentiumihalcea111@gmail.com/
---

Laurentiu Mihalcea (4):
  dt-bindings: clock: imx8mp: add axi clock
  clk: clk-imx8mp-audiomix: fix dsp/ocram_a clock parents
  arm64: dts: imx8mp: add AUDIO_AXI_CLK_ROOT to AUDIOMIX block
  arm64: dts: imx8mp: change AUDIO_AXI_CLK_ROOT freq. to 800MHz

 .../devicetree/bindings/clock/imx8mp-audiomix.yaml     | 10 ++++++----
 arch/arm64/boot/dts/freescale/imx8mp.dtsi              |  7 ++++---
 drivers/clk/imx/clk-imx8mp-audiomix.c                  |  6 +++---
 3 files changed, 13 insertions(+), 10 deletions(-)

-- 
2.34.1


