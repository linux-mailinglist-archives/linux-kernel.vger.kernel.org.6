Return-Path: <linux-kernel+bounces-212239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6266D905D30
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 22:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 722491C212D5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 20:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3BF84FDC;
	Wed, 12 Jun 2024 20:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.de header.i=@mail.de header.b="6QIKw9Rs"
Received: from shout12.mail.de (shout12.mail.de [62.201.172.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E78D84D0B;
	Wed, 12 Jun 2024 20:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.201.172.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718225666; cv=none; b=dTUfIhxC2VdnzzwYhKbfAjXlBLzMw+9rWiH7UW8EF9UTVTG21lmyHO6CJhfEV3GXC+8M7a9igPVJhMz7iNEKsvnaHdFckaQEOW2a/Hla09Oo1ACdjPofzch7EbFtq98WNEmI/BdYgnyErUgJRRh+LGUl83P2xe4aXSJq5bhSB78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718225666; c=relaxed/simple;
	bh=6m8xzsYHtwC9JE0M/yKVz8jVu/Kt+2HzHaIfh10Nz0E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WOc1w+S0L61+FPI3bU2Ji/GgNSc1yIKzg5EtSkmT1bmliPhBlY8oze0ZDVE6ztcnUERBVDSrQ0Vi5vi+1TlEpdX9wSN1LtueTE5lZBqmO1x8JmHuMeIetBDL+eB6FHlxUuq1P+TWMMJVoXT3M0x+mJbzDj7ivSf1APHAVLIn/mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.de; spf=pass smtp.mailfrom=mail.de; dkim=pass (2048-bit key) header.d=mail.de header.i=@mail.de header.b=6QIKw9Rs; arc=none smtp.client-ip=62.201.172.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.de
Received: from shout02.mail.de (unknown [10.0.120.222])
	by shout12.mail.de (Postfix) with ESMTPS id B4E4E24193D;
	Wed, 12 Jun 2024 22:54:17 +0200 (CEST)
Received: from postfix02.mail.de (postfix02.bt.mail.de [10.0.121.126])
	by shout02.mail.de (Postfix) with ESMTP id 9BFA92409FE;
	Wed, 12 Jun 2024 22:54:17 +0200 (CEST)
Received: from smtp01.mail.de (smtp01.bt.mail.de [10.0.121.211])
	by postfix02.mail.de (Postfix) with ESMTP id 79143A00E2;
	Wed, 12 Jun 2024 22:54:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mail.de;
	s=mailde202009; t=1718225657;
	bh=6m8xzsYHtwC9JE0M/yKVz8jVu/Kt+2HzHaIfh10Nz0E=;
	h=From:To:Cc:Subject:Date:Message-ID:From:To:CC:Subject:Reply-To;
	b=6QIKw9Rsu7n7mugdZdPgsZCP5RoN1d8UdXFDSM2jJN16MDT6GPwUNfogw9SsRqD3C
	 FMoNtk9N9LUzoPE69SQ4DhwdQgORjCf2UqFdQUUP6C7TJ8uhZ6g9v0LYozBfsdj99F
	 RMnjD8TrGIJTWH8TB9KiakYMGvLUfX9/sBkwO0QEtB9BuFc56TWP0e0KsXV5Nbb1SJ
	 wkqhlrNrxC2XZsSaOAraoSRwScaR0CxjUKUKuRSQ1NUvzXlv4uSUPOvhFBWsdwAoQG
	 khVbU4997HK6yoWuYcUU0sQnRsWhhej1cUSav/eyNrUJ+fzu4LJ857VogZRU38foyN
	 GMHuRYEkXjFmQ==
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp01.mail.de (Postfix) with ESMTPSA id 30B682400C1;
	Wed, 12 Jun 2024 22:54:15 +0200 (CEST)
From: Sebastian Kropatsch <seb-dev@mail.de>
To: Heiko Stuebner <heiko@sntech.de>
Cc: linux-rockchip@lists.infradead.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] Refactor, fix and improve NanoPi R6 series
Date: Wed, 12 Jun 2024 22:48:09 +0200
Message-ID: <20240612205056.397204-1-seb-dev@mail.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
X-purgate-size: 1402
X-purgate-ID: 154282::1718225657-FE5BF670-6DE0309F/0/0

Hello,

This patch series fixes a lot of minor issues in the current devicetree
for the FriendlyElec NanoPi R6 series (R6C and R6S), as well as adding
support for the GPU and one USB3 port which was previously disabled.

To aid with these patches, I have refactored the devicetrees in such a
way that they will now share a common dtsi source file in a similar
fashion than what the NanoPi R5C and R5S are already doing.
This makes changes which only affect one of the boards easier, less
error-prone and more maintainable. Also we don't need to work with
/delete-node/ and /delete-property/ this way :)

Cheers,
Sebastian

PS: Additional comments in patch 2 and 3.

---

Sebastian Kropatsch (5):
  arm64: dts: rockchip: Add common definitions for NanoPi R6C and R6S
  arm64: dts: rockchip: Fix regulators, gmac and naming on NanoPi
    R6C/R6S
  arm64: dts: rockchip: Improve LEDs on NanoPi R6C/R6S
  arm64: dts: rockchip: Enable lower USB3 port on NanoPi R6C/R6S
  arm64: dts: rockchip: Enable GPU on NanoPi R6C/R6S

 ...-nanopi-r6s.dts => rk3588s-nanopi-r6.dtsi} | 242 +++---
 .../boot/dts/rockchip/rk3588s-nanopi-r6c.dts  |  48 +-
 .../boot/dts/rockchip/rk3588s-nanopi-r6s.dts  | 743 +-----------------
 3 files changed, 193 insertions(+), 840 deletions(-)
 copy arch/arm64/boot/dts/rockchip/{rk3588s-nanopi-r6s.dts => rk3588s-nanopi-r6.dtsi} (81%)

-- 
2.43.0


