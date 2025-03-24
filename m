Return-Path: <linux-kernel+bounces-574094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D30A6E083
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 18:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5ADD3B485F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 17:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E062F2641F7;
	Mon, 24 Mar 2025 17:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="KvIyrkXj"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC410263C75;
	Mon, 24 Mar 2025 17:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742835867; cv=none; b=Al+57qDvPXox9++ZWFoILOheweBnhBEjqW2GfZKnmb+59Zjc8T5lGxgCpdi+fKMPFFqlkaGQ/ZKaEkCf6yMknIOStKzfErphiNOTFhvi/sMTCoAzC/89EkGK67/144sAOk7/nDRRhfGyRz8ADWub45bsNY9ICixKBjju9NZ75fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742835867; c=relaxed/simple;
	bh=NcPJopNj4QkFL7RS7LVqktzn6/GCRQbuGX0pRkX8TIA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mRg+VCH9Bjtcy/lu9Yra5voUaxF1UYsWdyualdVC+IZl/lTFRNWWDniH2om4GSwbFkW/Ye1cxTJps46jms7nm8vPdVPIsVI8tTL8ecAZLFv0MBh2ts9JJw3Gy2p6YaQWF9uHFInltmoIefCrunNkutYZudhoP8klbdn+FNHyqKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=KvIyrkXj; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1742835863;
	bh=NcPJopNj4QkFL7RS7LVqktzn6/GCRQbuGX0pRkX8TIA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KvIyrkXjD1AqH24UsP+0/qiibVyXFwpBc+LY1/w6GIg0XBoP1YoQtWTien4bT499O
	 oU9EStS6kAO+0luuoMJokjzOsINpTgLCY5Ctk1ykYpCfJJDgy67juhAr9ltylCjqGV
	 y++JZZabIKxqj70NR2o20BXmnh9pCa/OL14KhRPYIL/KCsgk9U4xkeHxAkCF59Lw/E
	 5kfMNXQzM+2AZ4ZV2/8Bb3cP3l1eUcuAoDdR6oOVhiaagfOY2GH96Ks7kBqzh5/Btv
	 Mb1wpOipEpUObxEkFhl7vHfaGiDVj6ndV5Pdne2gUAa8rKDUNJ2Giwc4L4gRq+jCEK
	 z+0UrEhEp8SLQ==
Received: from jupiter.universe (dyndsl-091-248-188-184.ewe-ip-backbone.de [91.248.188.184])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 18B2617E0A80;
	Mon, 24 Mar 2025 18:04:23 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
	id D647F480036; Mon, 24 Mar 2025 18:04:22 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Mon, 24 Mar 2025 18:04:22 +0100
Subject: [PATCH 1/5] arm64: dts: rockchip: move rock 5b to include file
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250324-rock5bp-for-upstream-v1-1-6217edf15b19@kernel.org>
References: <20250324-rock5bp-for-upstream-v1-0-6217edf15b19@kernel.org>
In-Reply-To: <20250324-rock5bp-for-upstream-v1-0-6217edf15b19@kernel.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=992; i=sre@kernel.org;
 h=from:subject:message-id; bh=NcPJopNj4QkFL7RS7LVqktzn6/GCRQbuGX0pRkX8TIA=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGfhkJbrMXGmfQ2nwIyb2HseFcb3BZuRbFxhj
 lv3TZvWB0s134kCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJn4ZCWAAoJENju1/PI
 O/qaLzkP/AiLeIlniF7EV2ceuFniQbWROAgLHK5bQo4k/CkqYVE9NvW+ia54EEqwOENOB/Ro+VN
 +mFX8AvAtVOnqsn40lf9Xg+9dlJdZFvJaOCZLSNdscRBHujP/eu1COtwusr0A9Dwq4PD0cX4fd7
 2XCvFiRtkLBwGFmfgaRqEgvu8yqLtD25/wnDF4zmkiA/C4A/GDL1GrQZZ8OWILvkNz2j96+w3ix
 Cxlf9HpZ5PcrLOhSxxaWZ93kj76sVRrYVSw/9qfqONTeHJjYktWjvGq2o1aL1M6dRifDYBq5agl
 ikazqgLAKcU3HLKdq+G+JWUjLKYEQUffaqENv3hmk/d2mQLQznwVAsiNLxKdPSaTAJSDYLxLZHL
 ScSw/LfWM89e8nbmbdbczScUn4G4HoJ8Krt9N4LlS4w+5Kkt/JOiyXBoyzWUBcpT6FJPhJdxFlv
 ZjZAOJZuWT+PYOTjoFDNr22IdB/w0U9Yq1iUbFHGhyQjbEJJKL2yvbJ+RU+OpCDbKrOz69+ZbP1
 VZyhxxrzKaHg1YBFcTyEa3DA2mRUaSGLtpUSqZKKlHEocLIjw+2JsPB8Dp07y1Pp/1eutyfnA/0
 m5pXeBEV7lPTd76F/5yLkGh2RTgHcHLBtJbU8VzFqeopg8teAo9cJozf8WeAopHSt6ULq7ZQnyS
 KeK/MncpkkgSh8JOybwYuGA==
X-Developer-Key: i=sre@kernel.org; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

Radxa released some more boards, which are based on the original
Rock 5B. Move its board description into an include file to avoid
unnecessary duplication.

NOTE: this should be merged with the following commit to ensure
bisectability. The rename happens in a separete commit during
development because git does not properly detect the rename when
the original filename is reused in the same commit. This means

1. it's a lot harder to review the changes
2. it's a lot harder to rebase the patch series

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 arch/arm64/boot/dts/rockchip/{rk3588-rock-5b.dts => rk3588-rock-5b.dtsi} | 0
 1 file changed, 0 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dtsi
similarity index 100%
rename from arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
rename to arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dtsi

-- 
2.47.2


