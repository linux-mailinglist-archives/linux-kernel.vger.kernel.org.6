Return-Path: <linux-kernel+bounces-304960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84FEA962760
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 14:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F96E1F25234
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 12:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E53178384;
	Wed, 28 Aug 2024 12:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=cristian.ciocaltea@collabora.com header.b="GBaYBiMK"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7966F176AA0;
	Wed, 28 Aug 2024 12:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724848852; cv=pass; b=dH+himBsNGswycmOEemqGUCqCLZtOxSrQXDQ4tWBHYtuB+3CSKd0nzZZ2qO7la1MOnN9j0nUxAB57HTjWOmpVeFdiXSLTo7qZo/0olk8m5EYxZV0UJ2k4I2/IhXzBDUTGaHJ7sRtrRPPPdY8AG40YmNVvj9oHgQAJSfKrHGcKSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724848852; c=relaxed/simple;
	bh=EasWgWbQkmMYTcKdGQUxWRbjGrsAf159+DNB2A39Tcg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=V0SWjN3LgDZU4UZTLICRYFn+RFNER9MwYUqdE/E7DkdS3aW3ZhOycpYJYtfs/Kwtfw5AOYpS4I7DKBs15WBn5RCS2aNn1jIoi8S4yLJHDLn2qMqsTrZ5xydgYTtL9rxSFzW9uthYz0fgz7YFFiyGyGCH5JmocV8lWQqDAcfBeko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=cristian.ciocaltea@collabora.com header.b=GBaYBiMK; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: kernel@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1724848836; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Mr9vXI19AMRK+7sP300gtmXGiYFnNaRjoSgmu2avGnmrMV3sy7/bVG/0HnuD+cSuok7t/5xml0A7+isEAT1tJj3MA277D8cgJ3+R5jQ6joGTX38KE8GOLbzo3u24dO8ydfP/NWnwyHdelhCiuQmRPtf20JhwjRLagRijWs9PX38=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1724848836; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=hMhceDYSJT3sweNsBvB0D+Xx2msIrWuw/AOE4Zw1sKM=; 
	b=TagecXMhwN1/1gdeVIsVuQBtRZAOQEm9AddRI2HNh8fUIOcCMOWRFh1HjRFI3uI+bo8P7iZ+UtJ4wxpg6gKSnaV4EdXpKQD2JWsb+y1RzLrDuvOrp7xrT0CbPQS1IcvS3TRUT9CZTG0XwxHdJXOjlzm2luh6YneVhwxtaDI+Qpw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=cristian.ciocaltea@collabora.com;
	dmarc=pass header.from=<cristian.ciocaltea@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1724848836;
	s=zohomail; d=collabora.com; i=cristian.ciocaltea@collabora.com;
	h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
	bh=hMhceDYSJT3sweNsBvB0D+Xx2msIrWuw/AOE4Zw1sKM=;
	b=GBaYBiMKPFOr9IZts8uWExL/VeGTFa1f5sSYNSQokGegbQzNKORuAq3naw77tnvg
	aXoZnIzFAjgB8mspUhrArCtTuLQ5MOvtY58KXPB9B9t6eTLCmMw1p83lf+1+d4w0PGs
	1AfMhaEHzmQzzYTiZkGP2ItWFQ5m5uYiTboDm0rM=
Received: by mx.zohomail.com with SMTPS id 17248488348410.2640791504728668;
	Wed, 28 Aug 2024 05:40:34 -0700 (PDT)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Subject: [PATCH v2 0/2] Fix compatibles for RK3588 VO{0,1}_GRF
Date: Wed, 28 Aug 2024 15:40:07 +0300
Message-Id: <20240828-rk3588-vo-grf-compat-v2-0-4db2f791593f@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKcaz2YC/4WNQQ6CMBBFr0Jm7RhaS6iuvIdhMbQFGpGSKWk0p
 He3cgGX7+f/93eIjr2LcKt2YJd89GEpIE8VmImW0aG3hUHWUtVatsjPS6M1poAjD2jCa6UNlZV
 GK2taLXso05Xd4N+H9tEVnnzcAn+OlyR+6R9hElijVSQ0meHaCLqbMM/UB6ZzqUCXc/4CurrrA
 rwAAAA=
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: kernel@collabora.com, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Conor Dooley <conor@kernel.org>
X-Mailer: b4 0.14.1
X-ZohoMailClient: External

As Conor noticed recently [1], RK3588 VO0 & VO1 GRFs incorrectly share
the compatible string, since they are not identical (though quite
similar in terms of layout).

Provide dedicated compatible strings, as a follow-up.

[1] https://lore.kernel.org/lkml/20240821-stretch-scam-09d7adc08a4c@spud/

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
Changes in v2:
- Deprecate the old compatible instead of removing it from the binding
  document (Krzysztof)
- Link to v1: https://lore.kernel.org/r/20240827-rk3588-vo-grf-compat-v1-0-d4a18acf951a@collabora.com

---
Cristian Ciocaltea (2):
      dt-bindings: soc: rockchip: Fix compatibles for RK3588 VO{0,1}_GRF
      arm64: dts: rockchip: Fix compatibles for RK3588 VO{0,1}_GRF

 Documentation/devicetree/bindings/soc/rockchip/grf.yaml | 10 +++++++++-
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi           |  6 +++---
 2 files changed, 12 insertions(+), 4 deletions(-)
---
base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
change-id: 20240827-rk3588-vo-grf-compat-4d2c84dc782b


