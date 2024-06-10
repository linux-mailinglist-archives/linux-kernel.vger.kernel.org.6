Return-Path: <linux-kernel+bounces-209009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B01C902BC6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 00:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D8301C21296
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 22:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337A51509B3;
	Mon, 10 Jun 2024 22:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bpWvbY2Z"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C731D15099E;
	Mon, 10 Jun 2024 22:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718059030; cv=none; b=tokylvmrNeVwQM5fT9FvniRWVu4Xu2Kt5TqDg3CG/7wFW6Z5g5EzRR5qdDyXlHMaD2m651A+wGGckTnpULXnIhFybrNfgtpbh4PV95yNMOh2+Zj0CjZYBJ1q1Go8+kVO7oaQoDOkjcp7xoDjs2rRO8pOKz4J2TPCIkE31bbFRTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718059030; c=relaxed/simple;
	bh=UUjGE1dIt3wWHQK4CxFnESTgMlrvmbty3Vi61/QzSVY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=U++5sXycD/AFppfY87yVWkEG1HphbT1I0hWCqKm4hJ2IOfJkafw7uK/B2Yt5tm3DJSBfNNd/Gi2aiybWc4jBdYnZ85IvsXx5lGluPUTAiWlKxwnjtd6pSggPj6h5Y8Q6eYOeyw2Bzv6rCuo7meBKbrw/0afUDMIuYBHAV8sSHM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bpWvbY2Z; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: linus.walleij@linaro.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718059024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BTtVyjqMEOKamwROfc4Uav8Qw2izbw3MOKMVpFlCw1o=;
	b=bpWvbY2Zo9ZZ0d/80dKuV323LLrIOyzoDfyi2p235pdmXX0u1tiSnVwjooaFiFvCQw0X0P
	ihP6lagDjt8iryw33TT7lVLOrDX6marvKLp8oeNnb5ha+U9QkgHWEgFEBrZvbPf8dIf1fu
	MI2xh1rbi04uUKT8UHSDzBdRZRKZCTM=
X-Envelope-To: michal.simek@amd.com
X-Envelope-To: linux-gpio@vger.kernel.org
X-Envelope-To: andy.shevchenko@gmail.com
X-Envelope-To: sai.krishna.potthuri@amd.com
X-Envelope-To: linux-arm-kernel@lists.infradead.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: sean.anderson@linux.dev
X-Envelope-To: conor+dt@kernel.org
X-Envelope-To: krzk+dt@kernel.org
X-Envelope-To: robh@kernel.org
X-Envelope-To: devicetree@vger.kernel.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
To: Linus Walleij <linus.walleij@linaro.org>,
	Michal Simek <michal.simek@amd.com>,
	linux-gpio@vger.kernel.org
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Krishna Potthuri <sai.krishna.potthuri@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sean Anderson <sean.anderson@linux.dev>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org
Subject: [PATCH v3 0/2] pinctrl: zynqmp: Support muxing individual pins
Date: Mon, 10 Jun 2024 18:35:48 -0400
Message-Id: <20240610223550.2449230-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This series adds support for muxing individual pins, instead of
requiring groups to be muxed together. See [1] for additional
discussion.

[1] https://lore.kernel.org/linux-arm-kernel/5bb0dc7e-4c89-4f3d-abc6-41ae9ded5ae9@linux.dev/

Changes in v3:
- Express groups/pins exclusivity using oneOf
- Fix zynqmp_pinmux_set_mux and zynqmp_pinconf_group_set not handling
  "pin" groups (thanks Sai Krishna).

Changes in v2:
- Use __set_bit instead of set_bit
- Use size_add when calculating the number of kcalloc members
- Expand commit message with some more motivation

Sean Anderson (2):
  dt-bindings: pinctrl: xilinx: Add support for function with pins
  pinctrl: zynqmp: Support muxing individual pins

 .../bindings/pinctrl/xlnx,zynqmp-pinctrl.yaml | 349 +++++++++---------
 drivers/pinctrl/pinctrl-zynqmp.c              |  83 +++--
 2 files changed, 234 insertions(+), 198 deletions(-)

-- 
2.35.1.1320.gc452695387.dirty


