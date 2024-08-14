Return-Path: <linux-kernel+bounces-287261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C2A695259E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 00:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 464091F27ACB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 22:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F289154458;
	Wed, 14 Aug 2024 22:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b="X4B1oVqa"
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCDD149E05;
	Wed, 14 Aug 2024 22:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723674068; cv=pass; b=QlIHXGaqZVPUOEkZNPK5nMd1ajwk+MzI40aBmdwFPrOaapuppMPnT/HTCWwlkAs7bS9dhcY+KMKqPHTL4rdxuRlZKZ7uVIc+nudMZPN45zSuE8qRj2QgfDr94EvXaoJrCmPLSkbs2Ze+7uEJYUWqCg4z3uEcZMp2w4XCvZn4TmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723674068; c=relaxed/simple;
	bh=ZseSJvvQ/STYK+JHtcwi0p5l8QpJ9KnLgXDZTGBHxAc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JbH25sHJy+bofbO5rwBEtzXyh8UK8PkHzYbTL/Zv70PlGWcHchhv+56Zaoi+tJpTC+fljKX8vOrIzTWyGYqvHN+zqOgMEfMs7HPZEu8zQuTWnLXTn2JuGtPzoTlxE+b6ih8mvjWcI73m/Gs7HUJ7O3CSB0M6Q2mAYuu8W3ryDWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b=X4B1oVqa; arc=pass smtp.client-ip=136.143.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: kernel@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1723674037; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=IVIwS2d5odoRB7LQs3KRC3ui9nfT5+8pGR6hW0PKzWQjtEHzUVIP9THB/iRe0c6DV9EVq6o+bqlqedwZyiqtxggfSHuvCavu9PoQqyeEAfNnJtydyDRBvLGRo5jHGTknQp+DkJ8UQRFpQBVsB7bqM11cu36mAWeGLqm347kVX7U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1723674037; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=jXwF5GXS2OQpmjcgp10hOfDqXTFm1+FqxL/OYRoaP74=; 
	b=H+kJMiXJG0zuwXGb5zhbCIQwI64uSZM0u8SMGca1pFtPu2SlWnwgtA3OrhDTCSDPPjIYs+Tcz3fnWzdOvCgGcmlBXvw5Fhbvf3oEVxN+vhoOxEr91UIGhCxS1oCa8qh1yOG0qtkbFTvFq38cyJsmrQv+mdhC5OQZjo97Dk512VQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=detlev.casanova@collabora.com;
	dmarc=pass header.from=<detlev.casanova@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723674037;
	s=zohomail; d=collabora.com; i=detlev.casanova@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=jXwF5GXS2OQpmjcgp10hOfDqXTFm1+FqxL/OYRoaP74=;
	b=X4B1oVqaB6h2Oq9rUOIFpZK3fpZ4TxxjrXMy+liPehBKyB2dI2IYZB+4rBNFVWgE
	diAOjS3D2C6v9WzdwqOktw0Z4Lf54YEB3oBLcwW8jV6RJKU3xU0sdib/VGSqFvzqhSd
	5iOPQR3HUXOafGXAtXLwfiMQrGpjSctLsGE5dpi0=
Received: by mx.zohomail.com with SMTPS id 1723674034407266.1561955146576;
	Wed, 14 Aug 2024 15:20:34 -0700 (PDT)
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
Subject: [PATCH v5 0/2] Add CRU support for rk3576 SoC
Date: Wed, 14 Aug 2024 18:19:21 -0400
Message-ID: <20240814222159.2598-1-detlev.casanova@collabora.com>
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

Changes since v4:
- Fix commit message with idx starting at 0
- Stash all bindings commits
- Cleanup example and add me as maintainer

Changes since v3:
- Add missing include in bindings

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

Detlev Casanova (1):
  dt-bindings: clock, reset: Add support for rk3576

Elaine Zhang (1):
  clk: rockchip: Add clock controller for the RK3576

 .../bindings/clock/rockchip,rk3576-cru.yaml   |   64 +
 drivers/clk/rockchip/Kconfig                  |    7 +
 drivers/clk/rockchip/Makefile                 |    1 +
 drivers/clk/rockchip/clk-rk3576.c             | 1819 +++++++++++++++++
 drivers/clk/rockchip/clk.h                    |   53 +
 drivers/clk/rockchip/rst-rk3576.c             |  652 ++++++
 .../dt-bindings/clock/rockchip,rk3576-cru.h   |  592 ++++++
 .../dt-bindings/reset/rockchip,rk3576-cru.h   |  564 +++++
 8 files changed, 3752 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3576-cru.yaml
 create mode 100644 drivers/clk/rockchip/clk-rk3576.c
 create mode 100644 drivers/clk/rockchip/rst-rk3576.c
 create mode 100644 include/dt-bindings/clock/rockchip,rk3576-cru.h
 create mode 100644 include/dt-bindings/reset/rockchip,rk3576-cru.h

-- 
2.46.0


