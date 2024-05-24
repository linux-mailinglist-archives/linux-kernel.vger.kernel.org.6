Return-Path: <linux-kernel+bounces-188337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F17D8CE0BA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 07:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1BA41C2135A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 05:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A87F8595C;
	Fri, 24 May 2024 05:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Nh9d/SP+"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7186D84A53;
	Fri, 24 May 2024 05:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716529471; cv=none; b=W9abtHF9tLu3miLTM7/HgUREOZJsUK4fRfGbgaHW0lY7kfEGq1RyxGaK3WgMwzpEWsai63m26XTplog1ejVbS21oawEZdfT0Z0Znpu+81OepqSRjHv11hhKZTu4p+3b4T8hZAJGPZK+bqez+hclqI2v4/0tcck/qtW1MO+cyGfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716529471; c=relaxed/simple;
	bh=utRZGHW+qqJ8hKrhUjKQ2YbtwMo+qqee+eB1TurKZ/0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Js+rzNN3pHm55e7SJsHBvtdNLitkS/ANJcoyVN7GJ+TkKOe3FF7BY3C/mHgnuK0ORr6bzM5tGlIku8nq0hVOEnIkueeJxnCzZhamndcfAazg3anRNWEeJnOiWQE3VSLRLiCkT9nDXE/FxIS+IWnMKIg9inTQyUHOil3WnXx3u8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Nh9d/SP+; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44O5iIr1011905;
	Fri, 24 May 2024 00:44:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716529458;
	bh=ACiw7mgG4p02/MBjOsgcntVMnzB9sZ5zgmABeLbwTi4=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=Nh9d/SP+fMqtAlN1ZosHKdeyoeU2SV9ncR+2SwipFDdt5iKl5ErbWXdNH4PoccYM2
	 7o5wqObow+teqZmTeNQg1tW/lLv2TK556ebEKLLanDJ8f4kjpcjNSiSXuZBZ/KmUX9
	 74kqgDsvsieUHxjqzptxtz6afhgjEkmyQFsMZ368=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44O5iIZl100522
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 24 May 2024 00:44:18 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 24
 May 2024 00:44:18 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 24 May 2024 00:44:18 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44O5iHVY069882;
	Fri, 24 May 2024 00:44:18 -0500
Date: Fri, 24 May 2024 11:14:16 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Ravi Gunasekaran <r-gunasekaran@ti.com>
CC: <nm@ti.com>, <vigneshr@ti.com>, <afd@ti.com>, <robh@kernel.org>,
        <rogerq@kernel.org>, <kristo@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <srk@ti.com>, <s-vadapalli@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] arm64: dts: ti: k3-j722s-evm: Update USB0 and USB1
Message-ID: <a94bccd1-c0a9-4381-ac36-32c73aad07e5@ti.com>
References: <20240513114443.16350-1-r-gunasekaran@ti.com>
 <20240513114443.16350-4-r-gunasekaran@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240513114443.16350-4-r-gunasekaran@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Mon, May 13, 2024 at 05:14:43PM +0530, Ravi Gunasekaran wrote:
> The GPIO expander on the EVM allows the USB selection for Type-C
> port to either USB0 or USB1 via USB hub. By default, let the Type-C
> port select USB0 via the GPIO expander port P05.
> 
> Enable super-speed on USB1 by updating SerDes0 lane configuration.
> 
> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
> ---
>  

[...]

> @@ -384,3 +399,43 @@
>  	status = "okay";
>  	bootph-all;
>  };
> +
> +&serdes0_ln_ctrl {
> +	idle-states = <J722S_SERDES0_LANE0_USB>,
> +		      <J722S_SERDES1_LANE0_PCIE0_LANE0>;

Patch 1/3 only added the Mux for Serdes0. So the idle-states property
for Serdes1 is incorrect and should be dropped.

[...]

Regards,
Siddharth.

