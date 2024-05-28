Return-Path: <linux-kernel+bounces-192324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB82D8D1B8D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 14:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75A5B1F22852
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 12:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AEF016D9AD;
	Tue, 28 May 2024 12:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vWvVs02b"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC671EB3F;
	Tue, 28 May 2024 12:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716900207; cv=none; b=tRwWwgAmnTBlxbL61CosHBadd9O9XOSMvtMdcFolFEJ6PjyaC3GwUDr0qT5O574f8S+qLGKaQzHgNy65vt3BLU4ZgBVjqPSGhiNy3lLCQT198hhW5LWl+ieDZS/arbTlFIHTMYz52A4eMZDjdT5xwgDFEbiv8tizHG+N1uKd7qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716900207; c=relaxed/simple;
	bh=XKi0bzYm+I1oLoM2oxpZ+eJwfPXXvsLO3CgIZ91Qo1I=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IyfSpgLo5FHbBeDxOJuSuRMl6rLnCvTOZsY5eSf90aASM2JzUzSidNKJLDtR5XpWXOtcC36sWHFBRJRcGftm83nefiaSb3TA5Mylb05WgXE6TMAYtAwu6bJOmdBJfO1SRBlpTRu4VCaLv7ZNb71/+OgWhmh6onhk/fjvqx42l9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=vWvVs02b; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44SChLlw072260;
	Tue, 28 May 2024 07:43:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716900201;
	bh=qJWNZuzbt41Pf0dVGUZ6rLA1Ty+MIQZ0hGGS/qZHzdE=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=vWvVs02bmNJacq5eTSDsx8gtWdu58GA6rQiewRe5DWoFyiBAZIeyaNJjn5t7kf0TO
	 662nSVp+SNc0UqMpJeOdDipgR4su9nwbnirXv+qogHB4yQrUXYdRLH63Yi2c6yUwws
	 SGLSjKW7wIfIjCiG97XP9MkyFW/g04VNPqtzebXM=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44SChL9U092516
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 28 May 2024 07:43:21 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 28
 May 2024 07:43:21 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 28 May 2024 07:43:21 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44SChKRN051243;
	Tue, 28 May 2024 07:43:20 -0500
Date: Tue, 28 May 2024 18:13:19 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Roger Quadros <rogerq@kernel.org>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <afd@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <u-kumar1@ti.com>,
        <danishanwar@ti.com>, <srk@ti.com>
Subject: Re: [PATCH v3 6/7] arm64: dts: ti: k3-j722s-main: Add WIZ1 and
 Serdes1 nodes
Message-ID: <da42f0b1-f723-4115-b855-0c586f372352@ti.com>
References: <20240524090514.152727-1-s-vadapalli@ti.com>
 <20240524090514.152727-7-s-vadapalli@ti.com>
 <c384efac-cca1-4822-a231-1ddb8019c800@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c384efac-cca1-4822-a231-1ddb8019c800@kernel.org>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Tue, May 28, 2024 at 03:24:44PM +0300, Roger Quadros wrote:

[...]

> > +			#size-cells = <0>;
> > +			#clock-cells = <1>;
> > +		};
> > +	};
> > +
> 
> Any particular reason to split addition of various nodes in the k3-j722s-main file?
> I think all k3-j722s-main.dtsi additions can be in one patch.

The intent was to preserve patch ownership from v2. I will combine them
in the v4.

Regards,
Siddharth.

