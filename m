Return-Path: <linux-kernel+bounces-278158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1712794AD34
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 17:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEF81B2CD31
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 15:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351E312D758;
	Wed,  7 Aug 2024 15:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="T/KKV1T6"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2A078C92;
	Wed,  7 Aug 2024 15:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723044372; cv=none; b=XoExtLog78CKi2+bv+9S8oyXvJ4mjPEkwMmT92eI78uaa9/MFZdc2UBcqwfaweavApUA9E49NThcjNmqG9+78qvrT82qpGz/PlJr+SvTCz7qhdW8LDA3Iky8XlK4NVPIk3DT1Gyq69iwal5Sa+c7PxQV+8L7Fvi1lHttZziuZK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723044372; c=relaxed/simple;
	bh=BqdA/vVc4uU03V7CULhvGqkbj4gcBtTlzMOz01n3C6k=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W/XVJRQ5M5Nojd8FHZmsjQR+rQJK/QpiRahNcjmuuRH2tmWQmDspM5JG0T3Jvh7h/d0KoF4xRFrA+Dt3+sRkqidNvjA3VafFJIn1OpYr8WPWkKnMAIG3uREGdSTp7CAaNvgtl3O3s5OhaSZo4ncmGsMR/TOzzIl2UjyNWNgHyR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=T/KKV1T6; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 477FQ3TF032913;
	Wed, 7 Aug 2024 10:26:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723044363;
	bh=88ErLMfQEURwB5Hpcxk5KSlv0G8FZKb8XyZA6cCQhl4=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=T/KKV1T6BNnl1D7ZoxqIiRbcY6BgMc21vmbzBTTKys+HjFnsV/XQzuVX/Kh9uGwAO
	 yLiwYVeGcqasTFcP9OitpazZQVxq+AqU/gwqONusmxw1Utaw83ZeLjd5clum0ssOvu
	 utuA0Eo72w3IyvFhbv54CTH5fIlxuRLuhdzg+yus=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 477FQ3RH054993
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 7 Aug 2024 10:26:03 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 7
 Aug 2024 10:26:02 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 7 Aug 2024 10:26:02 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 477FQ25S075971;
	Wed, 7 Aug 2024 10:26:02 -0500
Date: Wed, 7 Aug 2024 10:26:02 -0500
From: Nishanth Menon <nm@ti.com>
To: Judith Mendez <jm@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Santhosh Kumar
	<s-k6@ti.com>,
        Bryan Brattlof <bb@ti.com>
Subject: Re: [PATCH 3/5] arm64: dts: ti: k3-am62p: Remove 'reserved' status
Message-ID: <20240807152602.qtlqdne256mioogs@embroider>
References: <20240806214605.3379881-1-jm@ti.com>
 <20240806214605.3379881-4-jm@ti.com>
 <20240807114605.ggieur532eh4usus@diagram>
 <65047cc9-011b-46d3-939e-b7733c2f0fe2@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <65047cc9-011b-46d3-939e-b7733c2f0fe2@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 10:13-20240807, Judith Mendez wrote:
> Hi Nishanth,
> 
> On 8/7/24 6:46 AM, Nishanth Menon wrote:
> > On 16:46-20240806, Judith Mendez wrote:
> > > From: Santhosh Kumar K <s-k6@ti.com>
> > > 
> > > Remove 'reserved' status for MCU ESM node in AM62P device tree.
> > 
> > Why?
> 
> Main ESM reset is routed to the MCU ESM, hense enable
> MCU ESM in DT to be able to reset the CPU.

please document that in the commit message - please review the rest
of the patches as well. Is this problem present on other related AM6
products as well - will be good to audit and fixup in the series?

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

