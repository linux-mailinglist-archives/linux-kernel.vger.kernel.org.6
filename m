Return-Path: <linux-kernel+bounces-276468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A5294942C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 17:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 323691C22C2C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 15:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F321EA0CB;
	Tue,  6 Aug 2024 15:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GfFhatj1"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3649C1D6DDB;
	Tue,  6 Aug 2024 15:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722956733; cv=none; b=OJlbcgWenr/pUz+IUUSk4jmP+d7KgQ/wqwNPz1RJJ3MZc8EALYDk+RGlCA9SggCEt3gI/P291j2QH7z6t6lbaUs5rz7EM0soD6KPapRqoFE6ANa8IdWo/2npSIj+ZoUMmnQR0Ml9D3mCAmLHxDx7cay9eTDllMDyVB/6eyI3w98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722956733; c=relaxed/simple;
	bh=cKLi7+6crt9HUr5A8M2ER4zioa92HQFRFtOAa82Xb0s=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kC6+TPb7zUSOZIGMpNV7hmJ7M2t0UYRfpl3eVo8gdVnKltyEqzTfNBu/Boo8rfAxIMljaI1spMC7EqZ4VfG5A4qZiPwtZhutOEmiCt+TS0Qik+KqIr0xp61eQY1jBWMNEEBj+LOaB0WZrJT8aJsxyjqmpbWCSzoKkC9kvHRLUIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=GfFhatj1; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 476F5P63084874;
	Tue, 6 Aug 2024 10:05:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722956725;
	bh=jRUVh2j7bRPlAnSp8fPUpjC66w/pHoa9+DKzEoGOPCo=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=GfFhatj1AH1w+I8hHz5eD57b8l+SyNRCcbQPYqYzm+fkPNangrGHipqyCHCCigd51
	 o2PsQclEC/4fZVWjpysGkVNSXJnI3EbhnvnElIEidf6urCvJG9FJakTOhcVJbMaMrL
	 Zm+1OSOrTuG9wHaYUKRTIFfgpABqyutJpJdBJYFc=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 476F5PbV005455
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 6 Aug 2024 10:05:25 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 Aug 2024 10:05:25 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 Aug 2024 10:05:25 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 476F5PMh109855;
	Tue, 6 Aug 2024 10:05:25 -0500
Date: Tue, 6 Aug 2024 10:05:25 -0500
From: Nishanth Menon <nm@ti.com>
To: Andrew Davis <afd@ti.com>
CC: Manorit Chawdhry <m-chawdhry@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Neha Malcom
 Francis <n-francis@ti.com>,
        Aniket Limaye <a-limaye@ti.com>, Udit Kumar
	<u-kumar1@ti.com>,
        Beleswar Padhi <b-padhi@ti.com>,
        Siddharth Vadapalli
	<s-vadapalli@ti.com>
Subject: Re: [PATCH v3 1/5] arm64: dts: ti: k3-j721s2*: Add bootph-*
 properties
Message-ID: <20240806150525.5aj6hnqmzwir7j22@fruit>
References: <20240730-b4-upstream-bootph-all-v3-0-9bc2eccb6952@ti.com>
 <20240730-b4-upstream-bootph-all-v3-1-9bc2eccb6952@ti.com>
 <bcd96f9f-54bd-4793-b9f1-04a011f2df82@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <bcd96f9f-54bd-4793-b9f1-04a011f2df82@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 09:43-20240806, Andrew Davis wrote:
> On 7/30/24 4:53 AM, Manorit Chawdhry wrote:
> > Adds bootph-* properties to the leaf nodes to enable U-boot to
> > utilise them.
> 
> U-Boot? Let's try to pretend like this is a generic property and
> just say "bootloader" :)

Yes please - respin with wording fixup.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

