Return-Path: <linux-kernel+bounces-353054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB2A9927B6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 11:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C747A281697
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 09:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93FF818BBB7;
	Mon,  7 Oct 2024 09:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="ckhZh34E"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705F2165F08
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 09:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728291613; cv=none; b=dQxW5GT275/wBjVpeODkatP/Ih1qypj728/t6vjIOb1Up5qR6oAktxrcCk9xVsxrR+cviFICFuo9HpeRe4RiuQJOAKVQBNrGdyWAUL4/OvpHVnqRMOCJCuVrpN8gfUaTX2rMDvOzrW63Kf+bH2njqK2kEmyZEiFvy6WGN8z5Jg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728291613; c=relaxed/simple;
	bh=7t8za9SU76UnKziAfRSqjBWaKM3Dyv0vsO0xzXUIxn8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UrvQGgxiYUyf0aoPGrW/K+oxSi+9dEyZMPTiHWCtP9kBcFliqqi0fcbQdU/offpGLiY1Q9vUk2O4yFj97G0I4hnDPczalAs12nOGvVvit3Nsj9wT0wnxQcWWne/g5stKPYAhyCHO5m90XC1UH/gC+c5Mx0NxRgtTcMToZhxCg/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=ckhZh34E; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1728291607; x=1730883607;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=7t8za9SU76UnKziAfRSqjBWaKM3Dyv0vsO0xzXUIxn8=;
	b=ckhZh34EXdAd/78n4qWqWQyM798deh1BqL67tDWCvReA+eHVKl0TxOrhW+p9cA5W
	5Nv2ShIxZ3h8eZ3zUK1c/YCT9qhlaCEGl17VDBR6eOBdUC+xo6yTYd4maTkuFhnm
	1LNCZaq9vRie1aMeTT2N2BML4og3b7cxqWRMIwGoqv4=;
X-AuditID: ac14000a-4637f70000004e2a-6d-6703a317fe0b
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id B5.B0.20010.713A3076; Mon,  7 Oct 2024 11:00:07 +0200 (CEST)
Received: from [172.25.39.28] (172.25.0.11) by Berlix.phytec.de (172.25.0.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 7 Oct 2024
 11:00:06 +0200
Message-ID: <92066fdd-9e2f-4132-add0-9c296a119f3b@phytec.de>
Date: Mon, 7 Oct 2024 11:00:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: ti: k3-am62a7-phyboard-lyra-rdk: Update
 ethernet internal delay
To: Nathan Morrisson <nmorrisson@phytec.com>, <nm@ti.com>, <vigneshr@ti.com>,
	<kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <upstream@lists.phytec.de>
References: <20241004221049.1155022-1-nmorrisson@phytec.com>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20241004221049.1155022-1-nmorrisson@phytec.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCIsWRmVeSWpSXmKPExsWyRpKBR1d8MXO6Qf8uLos1e88xWcw/co7V
	Yvnn2ewWL2fdY7PY9Pgaq8XlXXPYLN78OMtk8aFxM5vF/z072C2636lb/D/7gd2B22PTqk42
	j81L6j36u1tYPf5cfMfqcfzGdiaPz5vkAtiiuGxSUnMyy1KL9O0SuDIeHnrDXHCIvaL1xDrG
	BsaVbF2MnBwSAiYS2/YeYOli5OIQEljCJPF8+WZmCOcOo8SXz99YQap4BWwknnx6xgxiswio
	SKyZNp8NIi4ocXLmExYQW1RAXuL+rRnsILawQJJEz8p7rCCDRASWMko8XrWDCcRhFmhjlHjy
	8ADYJCGgqQ/vTwabxCwgLnHryXwmEJtNQF3izgaIzZwCthJvW3+yQtRYSCx+c5AdwpaX2P52
	DtQceYkXl5azQPwjLzHt3GtmCDtUYuuX7UwTGIVnITl2FpJ1s5CMnYVk7AJGllWMQrmZydmp
	RZnZegUZlSWpyXopqZsYQTEnwsC1g7FvjschRiYOxkOMEhzMSiK8EWsY04V4UxIrq1KL8uOL
	SnNSiw8xSnOwKInzru4IThUSSE8sSc1OTS1ILYLJMnFwSjUwdhk+/rKTMdo7e9na9tjHm1uq
	b8zR0lx88pxT3+6Lt6W5a06cTOnUCXZuyeb0+CyWvHjLfpE2519fDj/QiPv/cunnyXbnFzUz
	3m+Ywm21Pve54Hu3uIKkXY9kdFsD+X8/KfaT67RhXcKVFHSa+fiEKxV+V1bbyKW5pzi2s/Yb
	37yyMNZmQWiBEktxRqKhFnNRcSIAG8SeaqcCAAA=



Am 05.10.24 um 00:10 schrieb Nathan Morrisson:
> Update the RGMII delay to 2.5ns to improve performance. We use an
> additional mapper board for the am62a7 phyBOARD Lyra which makes this
> delay necessary.
> 
> Signed-off-by: Nathan Morrisson <nmorrisson@phytec.com>

Reviewed-by: Wadim Egorov <w.egorov@phytec.de>

> ---
>   arch/arm64/boot/dts/ti/k3-am62a7-phyboard-lyra-rdk.dts | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62a7-phyboard-lyra-rdk.dts b/arch/arm64/boot/dts/ti/k3-am62a7-phyboard-lyra-rdk.dts
> index 3b93409b23e7..77e5fef618ba 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62a7-phyboard-lyra-rdk.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am62a7-phyboard-lyra-rdk.dts
> @@ -16,3 +16,7 @@ / {
>   		     "phytec,am62a-phycore-som", "ti,am62a7";
>   	model = "PHYTEC phyBOARD-Lyra AM62A7";
>   };
> +
> +&cpsw3g_phy3 {
> +	ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_50_NS>;
> +};


