Return-Path: <linux-kernel+bounces-295380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2E1959A45
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F3B82816BA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B811C6F5B;
	Wed, 21 Aug 2024 11:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="EoOppzaX"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2421C6F6A;
	Wed, 21 Aug 2024 11:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724238120; cv=none; b=qUhdRV22TBUS8NPnLuJxgEnDVpl0tx5Rimdz0fRv7JnLXG/MJAzrnUAiOwuyI0YssZ1khOHQ4/498T4g+M3YlORyjz8lUfM4J5pbwNmyu6Z5dc4bkg0k7upIA8ElvJtBS+/bZ4VTyOuU9BHAk8nHFxIIAWwc0zVCRLwzR9fdjvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724238120; c=relaxed/simple;
	bh=HOHb8KCraPzrbCvJ+E0qTpch9IgPjx/67xFxG7KR/O0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X24lnL8GeHvt6MLrx6G4mv5V8A9DwUCW0rY+B2oUYSVNRjaIe4Y7erGm2E1wxkslUjPBLqSwPllTmuS7OdVui8AtlyFskyvvXsTHlQZSEjpkopibiBL/LTMQ33sIbUf0ykcIuYzRxSM04CicgZwQ4LmQ1/TtJpE5vH88vzQD02c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=EoOppzaX; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47LB1nr7095237;
	Wed, 21 Aug 2024 06:01:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724238109;
	bh=047nGRnfjolajDj8O6w/DlUNEueI6Mf8QH2J0scQPjA=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=EoOppzaXD5174Uv37vGhVrmDsXZVPfpg8XCybRe3lP6AwyHb+Du523wwN2ezVAWkI
	 gfPSdPFkfffJbNkKkFlgrW6bBVjD/9fQr6Py4S71rInkbhY2f3kyEE1BZDkosYIS95
	 G1jLdhhgXMuAtPRBdylGiBC1eiUZj2N8lzBhkjuM=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47LB1n62002340
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 21 Aug 2024 06:01:49 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 21
 Aug 2024 06:01:49 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 21 Aug 2024 06:01:49 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47LB1nY1007738;
	Wed, 21 Aug 2024 06:01:49 -0500
Date: Wed, 21 Aug 2024 06:01:49 -0500
From: Nishanth Menon <nm@ti.com>
To: Judith Mendez <jm@ti.com>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jan Kiszka
	<jan.kiszka@siemens.com>,
        Bhavya Kapoor <b-kapoor@ti.com>
Subject: Re: [PATCH] arm64: dts: k3-am654-idk: Add Support for MCAN
Message-ID: <20240821110149.yk3da663fek2a4sy@attitude>
References: <20240820193420.29184-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240820193420.29184-1-jm@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 14:34-20240820, Judith Mendez wrote:
[...]

> +&m_can1 {
> +	status = "okay";

NAK!
	https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/dts-coding-style.rst#n117
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mcu_mcan1_pins_default>;
> +	phys = <&transceiver2>;
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

