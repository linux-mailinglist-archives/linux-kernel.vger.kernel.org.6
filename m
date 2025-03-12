Return-Path: <linux-kernel+bounces-557827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E7AA5DE4E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 14:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF25F7A3B1C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 13:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC0A242904;
	Wed, 12 Mar 2025 13:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mSuNL+tl"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B4B1CF8B
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 13:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741787196; cv=none; b=r9cljKyOs1Q82isfNas19Ir8Ncz1kOn4tAu2Csi4Oc70PNNOy0biAMQ5BJmbjJCamWLxdfq7ILRsJhNS49j1IGTBtMRnXSF1zdukKm1qXwcppuRzIw2kvuYaxoSsA4wH8Hm/PPtJt0nRTubmOMsBZyDWvIG+IFSQH38bmQdRIN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741787196; c=relaxed/simple;
	bh=P4vE55AYHsys/MGCv23SCGQXidP0GHUzlbX2Ufr0iec=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=t0GqZIrJ1mnz8r76ZCE952njgHd9+p+SBnWEvgdLt3CIghD16ejJ33/St2SQw5HzmkPcdX5gl3klv0Toh+jrq6wuFQrgfZe+sI2APue8l3VORDzSudNsM5e6ffXrD/ld53XVd026J1BoUI3cpal18Aw6MZxs5IRAUiu5rw3Ij1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=mSuNL+tl; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52CDkP6x1509037
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 12 Mar 2025 08:46:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1741787185;
	bh=St1OHBKFenhOMKyOuAwGEmP4LdUW/yuDHIRSEsAWFS8=;
	h=Date:Subject:From:To:CC:References:In-Reply-To;
	b=mSuNL+tlziSpgsYRGMRiAZ337EviHVssQ6jBwn+up9evY1iXCQFcMhUBoTZVkvW+q
	 KjSb3If1wJbfvaX3vSwXiHQG21r39sy8yEggoUrw+XQhtvHjOFhnXGjaxshtjEyBEO
	 928tO6XhikbpMfXqlvssgvjsThwEWX5NwCM0u3To=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52CDkPri117711;
	Wed, 12 Mar 2025 08:46:25 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 12
 Mar 2025 08:46:24 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 12 Mar 2025 08:46:24 -0500
Received: from [10.24.68.192] (dhcp-10-24-68-192.dhcp.ti.com [10.24.68.192])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52CDkLqP125702;
	Wed, 12 Mar 2025 08:46:22 -0500
Message-ID: <dec6ccc4-76df-47c3-8622-2c08035eff3e@ti.com>
Date: Wed, 12 Mar 2025 19:16:21 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [GIT PULL 2/2] arm64: defconfig: Updates for v6.15 for TI K3
 platforms
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm-soc
	<arm@kernel.org>, SoC <soc@kernel.org>
CC: Tero Kristo <kristo@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>
References: <5d612c0e-4cd4-469a-9856-dd4552d74412@ti.com>
Content-Language: en-US
In-Reply-To: <5d612c0e-4cd4-469a-9856-dd4552d74412@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

The following changes since commit c7691aec5e991cec9c5c5fdab08c24856a1fc56f:

  arm64: defconfig: Enable TISCI Interrupt Router and Aggregator (2025-02-06 09:10:24 +0530)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git tags/ti-k3-config-for-v6.15

for you to fetch changes up to 75a41c26351a77cd5dd01e14d059eaf11358689c:

  arm64: defconfig: Enable SPI NAND flashes (2025-03-07 16:33:25 +0530)

----------------------------------------------------------------
TI K3 defconfig updates for v6.15

- Enable Support for SPI NAND flashes on AM62Ax/J721s2 and other boards
- HSR protocol support for AM65/AM64 ICSSG based multi-port ethernet
- Greybus modules to support CC1352P7 chips on BeaglePlay

----------------------------------------------------------------
Ayush Singh (1):
      arm64: defconfig: Enable gb_beagleplay

Ravi Gunasekaran (1):
      arm64: defconfig: Enable HSR protocol driver

Santhosh Kumar K (1):
      arm64: defconfig: Enable SPI NAND flashes

 arch/arm64/configs/defconfig | 4 ++++
 1 file changed, 4 insertions(+)

