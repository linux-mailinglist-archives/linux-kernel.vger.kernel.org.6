Return-Path: <linux-kernel+bounces-533970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B713DA460EF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 715CF1899162
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948451624C0;
	Wed, 26 Feb 2025 13:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lQt/OrFS"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27297C8FE
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 13:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740576624; cv=none; b=k3EQWQ/tXC63jcdsAfCRBmsnuZre0FFCm4rH/IFO5tR2Zc7y1l4ULNC537OhF5MGdVcMEQUAUsGfx4/tBWWuDF/nCSHRBaEYeu7P1dZa+k8i750QTfFbCdCjQjSAvUEvxNVHbmVv1DboIY495mh9W0DDzeu9+B5GPzmMgQ/P4oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740576624; c=relaxed/simple;
	bh=3dDkhn1fLF4MVhPHRiRvY7cjk3QUZvQQu314ISBNtzA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CnhDeP/Jl5lM1w6axEaTPf6Hk9t2M2DzEWoaM+RKNq4ohVQ9RdAQeJ9hdqxkPVsd1zkVgBAV9caM6m2BYk/DAQ3vDViQ14oycUCQNhHkVX0Z5sAsZtb0BVJb8CW2o58+gqmGl0gGstJhXH0kpe+8hWb8/uHA4bfE46sGCFefWhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=lQt/OrFS; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51QDTklD1469543
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 07:29:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1740576586;
	bh=ci5vAe+2l6Sr2oYlsn9z5Et83nVZjCvDi9dpoxa55vw=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=lQt/OrFSvSN3I0KrMZwPomoSdv1fbWfG8fbc8qC95+isYSmwGnxBm5u6vovHYJ9Ab
	 ZPKgezJfy3+FW1IJLGU94/kdx5yHb1mf+6QKPy36YtUq+8xfoPPEfijfwqdKaqcwvs
	 LmTG93Mah6/tYVDcLhsMdnzAYx3n22veslktRaZQ=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51QDTkC0044010
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 26 Feb 2025 07:29:46 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 26
 Feb 2025 07:29:46 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 26 Feb 2025 07:29:46 -0600
Received: from [10.249.129.76] ([10.249.129.76])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51QDTZw1013607;
	Wed, 26 Feb 2025 07:29:36 -0600
Message-ID: <5dd84e6e-61c6-4496-811d-cf7af7ace2d2@ti.com>
Date: Wed, 26 Feb 2025 18:59:34 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: defconfig: Enable HSR driver
To: Meghana Malladi <m-malladi@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>
CC: <elinor.montmasson@savoirfairelinux.com>, <javier.carrasco@wolfvision.net>,
        <ebiggers@google.com>, <biju.das.jz@bp.renesas.com>,
        <quic_tdas@quicinc.com>, <nfraprado@collabora.com>, <arnd@arndb.de>,
        <dmitry.baryshkov@linaro.org>, <krzysztof.kozlowski@linaro.org>,
        <geert+renesas@glider.be>, <quic_bjorande@quicinc.com>,
        <will@kernel.org>, <catalin.marinas@arm.com>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>,
        "Ravi
 Gunasekaran" <r-gunasekaran@ti.com>
References: <20250226104517.1746190-1-m-malladi@ti.com>
Content-Language: en-US
From: "Anwar, Md Danish" <a0501179@ti.com>
In-Reply-To: <20250226104517.1746190-1-m-malladi@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 2/26/2025 4:15 PM, Meghana Malladi wrote:
> From: Ravi Gunasekaran <r-gunasekaran@ti.com>
> 
> HSR is a redundancy protocol that can be realized with any
> two port ethernet controller.
> 
> Many of TI's K3 SoCs support multi port ethernet controller.
> So enable HSR driver inorder to support this protocol on
> such SoCs.
> 
> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Meghana Malladi <m-malladi@ti.com>

Reviewed-by: MD Danish Anwar <danishanwar@ti.com>

-- 
Thanks and Regards,
Md Danish Anwar


