Return-Path: <linux-kernel+bounces-279855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CDAE94C298
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 18:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1165F1F24957
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 16:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34086190480;
	Thu,  8 Aug 2024 16:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b="gSHRfec0"
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89DB19007C;
	Thu,  8 Aug 2024 16:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723134195; cv=pass; b=Z74d1noEdjfo/eKURJRD0iO7hNQHGl8luO++VPxnR9mKQMVbpLyLWEaLhBZjJ7Ra9pP454bZjFCtf10erNxoI7zlJdQWC7LDNThMSs/ZiYqukg7Rgr5RTJPP4yRRsxVhIUZms6GNCQzqDO4u6SgyCQZcNZTpuTJT0O28zClS1Lg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723134195; c=relaxed/simple;
	bh=dlLlt9rphin8DHBwcRdnICMNgIt8ZmZCX22PpNlO0Fc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FXTQrHg2B2MTVdmJynwSCmlTVZh3HnH4kYBJwP+sXGZYbowftiTu6oD9T02Kxux2J4hLadsBTfuix3V5XtVjHJdo2XL4cNPuKI7glRW9mfhxwH82vWlXpXWN7OvqY4HB0Q2x3UB5sy0PRWXVyVmMJ3FXBvQXIGnq5veeyLXW78g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b=gSHRfec0; arc=pass smtp.client-ip=136.143.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: kernel@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1723134165; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=S4saYWfvU7yDd/11V5gxU4GYwjw+V44lgzpWpKnZv9tiIOInC9l0R2hyF+9unIpxseIshV8sYpeDSQNWq/klkOm/7YXJTq6olcQmE/aqVmEOjljMyrRnJ2rGyaR6jClDQFwllFPZkKs6LD9zKsZpuPt1ZimaaL7lzfVD3oFstvY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1723134165; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=PV+G4SQkttZHwQN25E8l67uUEkfDIu3oeofJucfzkuo=; 
	b=K5fVu9eib1vRA6QzCHFOF2yF492hrKY/TkFnIBqh34CyOqoJUtvXIdInYKFlzRPfa7QUXZoHC8IVRSbBANApgHqgw0N5ZGpvuhINf3k1Kll80KG6/eF1PCFqsYzJNtObaQ6+bEfDi9WapkRJOYa4LymNF746uKh5ZNzOXKoBKMw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=detlev.casanova@collabora.com;
	dmarc=pass header.from=<detlev.casanova@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723134165;
	s=zohomail; d=collabora.com; i=detlev.casanova@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=PV+G4SQkttZHwQN25E8l67uUEkfDIu3oeofJucfzkuo=;
	b=gSHRfec0Unj/01yTWeXlIvO6a6eEmTUgxwjRtGcNeKJ2bFmjsCVWgsm48Lw6y7UI
	Ghq9EDVjM4TgSuIpZO/Ee3yWM0vv7qSAOXVp8WE7/D74oU9JEWw1cOlcC9PaLK2tZeF
	cLZC5w0EyCqW6F7AAam8vSE+aHdBaeZ+ZeoB51r8=
Received: by mx.zohomail.com with SMTPS id 1723134164385222.1880514309653;
	Thu, 8 Aug 2024 09:22:44 -0700 (PDT)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Elaine Zhang <zhangqing@rock-chips.com>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	kernel@collabora.com,
	Detlev Casanova <detlev.casanova@collabora.com>
Subject: [PATCH v3 0/3] Add CRU support for rk3576 SoC
Date: Thu,  8 Aug 2024 12:20:55 -0400
Message-ID: <20240808162258.79271-1-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Add support for clocks and resets on the rk3576.
Patches from downstream have been squashed and rebased.

The resets have been renumbered without gaps and their actual register/bit
information is set in rst-rk3576.c as it has been done for rk3588.

Changes since v2:
- Renumber IDs from 0
- Commit clock header with clock bindings
- Add missing resets on sub-cores
- Add redundant fields in bindings

Changes since v1:
- Remove reset defines that are probably out of the main core
- Separate resets and clocks bindings
- Renumber the resets without gaps

Detlev.

Detlev Casanova (2):
  dt-bindings: reset: Add rk3576 reset definitions
  dt-bindings: clock: Add rk3576 clock definitions and documentation

Elaine Zhang (1):
  clk: rockchip: Add clock controller for the RK3576

 .../bindings/clock/rockchip,rk3576-cru.yaml   |   83 +
 drivers/clk/rockchip/Kconfig                  |    7 +
 drivers/clk/rockchip/Makefile                 |    1 +
 drivers/clk/rockchip/clk-rk3576.c             | 1819 +++++++++++++++++
 drivers/clk/rockchip/clk.h                    |   53 +
 drivers/clk/rockchip/rst-rk3576.c             |  652 ++++++
 .../dt-bindings/clock/rockchip,rk3576-cru.h   |  592 ++++++
 .../dt-bindings/reset/rockchip,rk3576-cru.h   |  564 +++++
 8 files changed, 3771 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3576-cru.yaml
 create mode 100644 drivers/clk/rockchip/clk-rk3576.c
 create mode 100644 drivers/clk/rockchip/rst-rk3576.c
 create mode 100644 include/dt-bindings/clock/rockchip,rk3576-cru.h
 create mode 100644 include/dt-bindings/reset/rockchip,rk3576-cru.h

-- 
2.46.0


