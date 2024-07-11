Return-Path: <linux-kernel+bounces-248605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B473F92DFA4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 07:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50E22B21871
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 05:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B736577119;
	Thu, 11 Jul 2024 05:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="G/nGESmn"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1444F2C861;
	Thu, 11 Jul 2024 05:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720676166; cv=none; b=bK0ZNNR7Ut+UajyL6WgrFjUDeA0hYlfNWs/6HawtmPOU7Ff9ACZRMX30Gn1GkU1Hoj6w38hq7bO9+ds1wivzZdikc+E7IaSA2tH1PGnDiaUtGe1FsDK/zIgpLqmrkw0FNRjv4ihOMQrqTJX8Tw6TcJmzJUlXloxO4i3TmoEzOrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720676166; c=relaxed/simple;
	bh=lzZFdRxVXIbFDXrCfk/E4/E90AcbEdg4s+ZsJsqHQAY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cgrdr/5LJdtt6Jn7Z2lCJbdXQbOVutW4w51/hxJ1Wt40C3ttl/4WvwYhZtpYVoV6zMV/4y3u4iknpf1vuAUwI6Er2Zbt3hsc9I/lldTdUGI0QJq9uj+BE447puWWBiW22LA5+TwXW6Y9ebCf+5gQ2AuR8GELUzzeTzwt6IVfw/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=G/nGESmn; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46B5ZZlS042745;
	Thu, 11 Jul 2024 00:35:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1720676135;
	bh=ZTl/h2uPc91FIYXu15lNn+bB1kHydzL1SHPX9n7xbnI=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=G/nGESmnvAWslFpVIrc06f93IHWwIrvn91IbVtZWL6V6cQJa6y0CqbAX04G3nVoGC
	 tm/br4JQEPGuGuVurKFLO1ACze/PPQDmDBg8njQxii2BqcAzXtWqMIdsG08GNFRcIz
	 xTPKQhABdbin+YP2VxKpMtGKbVhAIvd0i7UcyVjs=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46B5ZZb6113198
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 11 Jul 2024 00:35:35 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 11
 Jul 2024 00:35:34 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 11 Jul 2024 00:35:34 -0500
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.81])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46B5ZXNn105937;
	Thu, 11 Jul 2024 00:35:34 -0500
Date: Thu, 11 Jul 2024 11:05:33 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Andrew Halaney <ahalaney@redhat.com>
CC: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        "Tero
 Kristo" <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Philipp
 Zabel" <p.zabel@pengutronix.de>,
        Siddharth Vadapalli <s-vadapalli@ti.com>, <mranostay@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] arm64: dts: ti: k3-j784s4-evm: Consolidate serdes0
 references
Message-ID: <0569049b-89fc-4914-9f78-a2f0f4824c43@ti.com>
References: <20240710-k3-j784s4-evm-serdes0-cleanup-v1-0-03850fe33922@redhat.com>
 <20240710-k3-j784s4-evm-serdes0-cleanup-v1-2-03850fe33922@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240710-k3-j784s4-evm-serdes0-cleanup-v1-2-03850fe33922@redhat.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Wed, Jul 10, 2024 at 10:36:14AM -0500, Andrew Halaney wrote:
> Subnodes were added to serdes0 in two different spots (due to independent
> development of their consumer usage). Let's go ahead and combine those
> into one reference for readability's sake.
> 
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>

This patch could probably be squashed into the previous one.
Irrespective of that,

Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>

[...]

Regards,
Siddharth.

