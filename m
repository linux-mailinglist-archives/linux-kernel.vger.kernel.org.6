Return-Path: <linux-kernel+bounces-273432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 439E994692E
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 12:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA586B2180E
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 10:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D921014D2B5;
	Sat,  3 Aug 2024 10:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="i5Urta9o"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F240135417
	for <linux-kernel@vger.kernel.org>; Sat,  3 Aug 2024 10:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722682679; cv=none; b=SiJ4G8spTmi/LU+/ZH86+HQqozieAZTI0wBakFlZoqQijT0zsoRgXILxJ5etxEifPspMyahT1x0swCO8m5gQx/7bvZypPJ0STryVSYFBw5dVFErR/s/JmF5MK6e+LVih8PgaQIY6scWlvOPv9Z38KjQUg+YbN6MmBm14gS5o08U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722682679; c=relaxed/simple;
	bh=wBcldRlShYsE/tziCShRrZSLFh59JLWVarSBMPwXEuQ=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=TIKJDNCtgBvKEUEO+JRrYQ9LL4EMT5cspC6gUWBtQ49nWW8h4peghnKP0fQue6bERfQxMTMbMwQhKrAKhIQtdi5rlFnTzwNGMYaui/OwOEfOVJO1oz6qLXaviZddJ/FmVD/2aC4Ibnwrwfi4BAvLl4i72mC1nlFaOXqFbHn+XBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=i5Urta9o; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1722682669; x=1722941869;
	bh=+9L3eB0PjTw8/WJJfJ6bjGYnz9iYteO3NaUNJ3h8kP0=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=i5Urta9os9xP1ID5TIudZdf/2btzg9hS3LHDl+wKTVVvJYphjNLfLqYP9PTXhhJRn
	 u6ifuzF1pYmsN1ExSAzZBxmNS3pOxGQv6bu04oHwRcdde2jtR6IghTk6VbB0jH717v
	 JzbuGjVBDKWMA7grSxnch+ncBPZY0bVSBWvTWIZI3jTv7B3nQzgcKHzh4vOK/eRfSh
	 sxgtWam1Ys5NH2bjZ4j/gJfKTtAisyxxOgddVtX26KsJ/JkdQCbglvBpXK9Bpf8BIT
	 5lOnyuRjiVLjiggl8Cfpuklb9ClAUD4DODBfzVPHFptsk2sgo/yY02miNZfV3dzZn8
	 CpvlLBUjvOXFg==
Date: Sat, 03 Aug 2024 10:57:44 +0000
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Michal Simek <michal.simek@amd.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From: Harry Austen <hpausten@protonmail.com>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Harry Austen <hpausten@protonmail.com>
Subject: [PATCH v2 0/9] clk: clocking-wizard: add user clock monitor support
Message-ID: <20240803105702.9621-1-hpausten@protonmail.com>
Feedback-ID: 53116287:user:proton
X-Pm-Message-ID: 3b2a02ce4fddf6b775dcc78b381e70fd5b402cca
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Improve utilised clk/notifier APIs, making use of device managed versions
of functions, make dynamic reconfiguration support optional (because it is
in hardware) and add support for the clock monitor functionailty added in
version 6.0 of the Xilinx clocking wizard IP core, through use of the
auxiliary bus and UIO frameworks.

The combined addition of all of these patches allows, for example, to use
the clocking wizard solely for its user clock monitoring logic, keeping
dynamic reconfiguration support disabled.

This is currently untested on hardware, so any help testing this would be
much appreciated!

v1 -> v2:
- Split and improve clk_hw+devres transition patch (2+3)
- Fix/improve DT binding patches (5+8)
- Utilise auxiliary bus in monitor support patch (6)
- Add dedicated UIO driver for monitor support (7)

Harry Austen (9):
  clk: clocking-wizard: simplify probe/remove with devres helpers
  clk: clocking-wizard: use newer clk_hw API
  clk: clocking-wizard: use devres versions of clk_hw API
  clk: clocking-wizard: move clock registration to separate function
  dt-bindings: clock: xilinx: add description of user monitor interrupt
  clk: clocking-wizard: add user clock monitor support
  uio: add Xilinx user clock monitor support
  dt-bindings: clock: xilinx: describe whether dynamic reconfig is
    enabled
  clk: clocking-wizard: move dynamic reconfig setup behind flag

 .../bindings/clock/xlnx,clocking-wizard.yaml  |  32 +-
 drivers/clk/xilinx/Kconfig                    |   1 +
 drivers/clk/xilinx/clk-xlnx-clock-wizard.c    | 335 +++++++++---------
 drivers/uio/Kconfig                           |   8 +
 drivers/uio/Makefile                          |   1 +
 drivers/uio/uio_xlnx_clk_mon.c                |  71 ++++
 6 files changed, 285 insertions(+), 163 deletions(-)
 create mode 100644 drivers/uio/uio_xlnx_clk_mon.c

--=20
2.46.0



