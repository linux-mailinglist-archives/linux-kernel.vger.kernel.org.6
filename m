Return-Path: <linux-kernel+bounces-516837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DFD2A3780B
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 23:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17B513A50CB
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 22:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9BD01A5B8C;
	Sun, 16 Feb 2025 22:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="TUjKT8sV"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677A11A256B;
	Sun, 16 Feb 2025 22:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739744300; cv=pass; b=gQySkjAxUqwtgVDGZCCGl7IX1a2sE/5QuLfFrkYbIOiecfOvGg4V5NnDvZwr7zbAi1R85x/r5bR029K4x4/2A83Ui24VoOIHpufAkSPekEiG43H8Ukaxco0N4S3T/8PjtQZ50TnJD/kMat1QKnbiwCSaH/nVkVyTPYY9zDqQzoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739744300; c=relaxed/simple;
	bh=UbTmSHeRcNR9y1w9sWk4L+7Gfr+PNHE8EJupaM4yiQA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d8FDrHMaG7dAk4ouZ51/0SVYtw4FXlC0hsed4faQBKRFIC5T8rtOGssXfiz+f+Ry0/LVIgHTZqLF0DA/egOPnLImJxaofjOI/eU/IJqw/cpjAzrMDzqGq4yntjgiWQMioU8TnzK+ln69nZUKffdgj7dhNgKZavc5/Hb0ErSzV44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=TUjKT8sV; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1739744261; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=cjI1qX5rKD2Zjd20T7ze3hGakn5kKhIB0o6VZ+kacmLQQknY6m5HK/Z2kPAI8S7Ic8kLO7v9dRTz66ffqNKhx+s17tg8ZXt9XkvnuoRka8xzQhXa2+0dtBgeoEOrSiFbQNpZ3SX0Qsj4r3ksCEjnBzrl4EoH3jd6T+sVcM/TCO0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1739744261; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=2uXMZuqioGZ1TWUtUfrDpKK3F04ilgq6QgvYzApfTE0=; 
	b=GNuYeyVCaqibMqrL9uJLNkYcJxiVKYbyDfAym4RTQH4oyEIHR7wygKFwNbeqjpUq/Ukk1YFZXFFo7h+zlgXyoOf2WwCb7Zg0H5bEK99Hrxp4j35pzq+omGtjSbGlaCjF1h3+VEyoS7mJMpgvoToWn32x/O858e3ypXZUrGSnbVU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1739744261;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=2uXMZuqioGZ1TWUtUfrDpKK3F04ilgq6QgvYzApfTE0=;
	b=TUjKT8sVz4Q7MKk9pzKkq+2ImEWDG810ozJpX2eI8IPJ9nz1IM8iX9hn1ExHEFYp
	pVdMqD71PdwbaV4MUug4DTPEcKuYoVhoR8vlRPtgqzAy/e9AvuwLEW9Tb+3FX5L/d80
	XhxOIsg5wddLEjwm8KlnN1h4zCqsx5J/TcPk7V98=
Received: by mx.zohomail.com with SMTPS id 1739744258146392.05421080390477;
	Sun, 16 Feb 2025 14:17:38 -0800 (PST)
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: Heiko Stuebner <heiko@sntech.de>,
	Marc Zyngier <maz@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Kever Yang <kever.yang@rock-chips.com>,
	XiaoDong Huang <derrick.huang@rock-chips.com>,
	Peter Geis <pgwipeout@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>,
	kernel@collabora.com
Subject: [PATCH v2 0/3] Add Rockchip 3568001/2 errata workarounds and enable ITS on RK356x
Date: Mon, 17 Feb 2025 01:16:31 +0300
Message-ID: <20250216221634.364158-1-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Enable GIC ITS support on Rockchip RK3566/RK3568 SoCs by adding
necessary GIC erratum workarounds and moving RK356x PCIe MSI to use
ITS instead of MBI.

Changelog:

v2: - Changed Kconfig and commit descriptions of the GIC driver patch,
      as was requested by Marc Zyngier.

    - Added ack from Marc Zyngier to the GIC driver patch.

    - Squashed DT patch that added dma-noncoherent property to GIC node
      into the patch that adds MSI controller node, as was suggested by
      Marc Zyngier.

Dmitry Osipenko (3):
  irqchip/gic-v3: Add Rockchip 3568002 erratum workaround
  arm64: dts: rockchip: rk356x: Add MSI controller node
  arm64: dts: rockchip: rk356x: Move PCIe MSI to use GIC ITS instead of
    MBI

 Documentation/arch/arm64/silicon-errata.rst   |  2 ++
 arch/arm64/Kconfig                            |  9 ++++++++
 arch/arm64/boot/dts/rockchip/rk356x-base.dtsi | 14 ++++++++++-
 drivers/irqchip/irq-gic-v3-its.c              | 23 ++++++++++++++++++-
 4 files changed, 46 insertions(+), 2 deletions(-)

-- 
2.48.1


