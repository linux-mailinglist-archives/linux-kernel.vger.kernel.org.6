Return-Path: <linux-kernel+bounces-308627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1051965FAA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 12:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FA3A1C2353F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 10:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D39318FDAC;
	Fri, 30 Aug 2024 10:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="O/bkr3+e"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E1C15C138;
	Fri, 30 Aug 2024 10:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725015289; cv=none; b=GwUMEm0kOIdAyM+VCYKrWG9KLvX+Nbl/uone0jOxPo8nG3rFI6pYQGon93Yyhhc0HtTlKArPQspcc0V0AfVO4k/PTksakeky4KgTy4GrFch68JEXpStWM7x2rTvSStJZuDGrru2uvCOK6J1qVM6ntwyWE2R07oGzLmfcroaxKJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725015289; c=relaxed/simple;
	bh=1s7khTLZ5wyKPUa8n87VRFstv1zhJhmgu8JwlRGgl8Q=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tgQufuaiA4+rAzCm1EtHhz5zz0jcInZtLZ7PXRnKNR8ymmY44v11GDgRZMgeYF3HtXwe1w24tEkp288WMWYMy+ktDlpqQhKVjY3qoKx1b2GIa5hlfBcswPHW9bsKPvLoli6WOLVIpYviHEiqDTy6DDfVASbmmVQOe98dY7hp2d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=O/bkr3+e; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47UAse8q105188;
	Fri, 30 Aug 2024 05:54:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1725015280;
	bh=R8lCaUe1zudIS4CmdNIdupOWcZxkErAdDnNNQhe1Uok=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=O/bkr3+e/6dt9Trwk5hfobHnRTfEYv+RkBL1QDiPzcS+thgCLtLloFXW5ZzyrDU2G
	 fwmz+7wdvEkwDJice2cpx8EQL3HoVkLkJZncSfmsGfDJOC02oK3v66K2YaAZLWHoPN
	 +eUK3TQ4PQYNR+CdQOKVwEIoQkdH5UgaxDzN2PtQ=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47UAsefc026548
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 30 Aug 2024 05:54:40 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 30
 Aug 2024 05:54:40 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 30 Aug 2024 05:54:40 -0500
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.81])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47UAsdq0021022;
	Fri, 30 Aug 2024 05:54:40 -0500
Date: Fri, 30 Aug 2024 16:24:38 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Nishanth Menon <nm@ti.com>
CC: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, Tero Kristo
	<kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Siddharth Vadapalli
	<s-vadapalli@ti.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-j721s2-evm-gesi-exp-board: Rename
 gpio-hog node name
Message-ID: <c82b1d5f-c601-49a9-a77f-ca9988279731@ti.com>
References: <20240830102822.3970269-1-nm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240830102822.3970269-1-nm@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Fri, Aug 30, 2024 at 05:28:22AM -0500, Nishanth Menon wrote:
> Fix the gpio hog node name to p15-hog to match up with gpio-hog
> convention. This fixes dtbs_check warning:
> p15: $nodename:0: 'p15' does not match '^(hog-[0-9]+|.+-hog(-[0-9]+)?)$'
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---

Thank you for fixing this.

Acked-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Regards,
Siddharth.

