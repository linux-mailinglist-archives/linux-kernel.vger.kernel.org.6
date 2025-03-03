Return-Path: <linux-kernel+bounces-541038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C54A4B7B5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 06:45:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3090D3ACEC2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 05:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7DC61E285A;
	Mon,  3 Mar 2025 05:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jDBn37kS"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFDC1D7E35;
	Mon,  3 Mar 2025 05:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740980704; cv=none; b=LaZr4qO1Y8rLyhfzrUQXWRJSMiMN7/QpMy21NTbiOuxAzlguyDaRIzduhoNJ4RwNdKOvILkF7vQEqSaTARwL8+EYr0FXeCvyPASnWV861Fd/fCTJmN3CAayX4eRCANyNhWzqHRIfO1JOy4IQqdjdhoNI3ruD/RBiXCIeV7D9JK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740980704; c=relaxed/simple;
	bh=eTgsFgduWfWOBkO7IIQM/M0uYYUvH2qwuq39B19cQlk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u0zB0+YB7By8BEWuyk9sQfGr5wLTU79VM/3E6BLy+jq3iK8nUwLS4K0nOC/MWuHmfxQLLg3jry5NEjNrDnuJCC3IiTI1JiNFvZwWDcFb9E5fkQ1OhiL7W3Tn5+Keb2ThtcXlTXo+M49Y715YmwL96SZaUfXUslLkKarH0Ny/Wps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=jDBn37kS; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 5235itIu2676475
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 2 Mar 2025 23:44:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1740980695;
	bh=TgjePP/VH8TK7QXaCuvYzFYO+A7MauVHPXUyzIuHO/Q=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=jDBn37kS9ZMZNXACk7vNjVjaLjhDHyxH+zKRa4LnrfmCOvpbZ2Tk63/Gq/kui2OAA
	 m+xnVNZ2ZiQRFx1HJ3y8UUxrgZXVzkfeYqjqJhVaqTRLAUn8IshA9ZfdWI4DqLlSE2
	 TKYsZJqOLMOQ3sNkAQrXCLLrK6Sn0cfdbYMixVXE=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 5235isgH025289
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 2 Mar 2025 23:44:55 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 2
 Mar 2025 23:44:54 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 2 Mar 2025 23:44:54 -0600
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.113])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 5235ir1M116614;
	Sun, 2 Mar 2025 23:44:54 -0600
Date: Mon, 3 Mar 2025 11:14:53 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Chintan Vankar <c-vankar@ti.com>
CC: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, Tero Kristo
	<kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon
	<nm@ti.com>,
        <s-vadapalli@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 1/2] arm64: dts: ti: k3-am68-sk/k3-j721s2-mcu: Add
 bootph-all property to enable Ethernet boot
Message-ID: <20250303054453.r6r7i25ewdoosyzk@uda0492258>
References: <20250302153502.181832-1-c-vankar@ti.com>
 <20250302153502.181832-2-c-vankar@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250302153502.181832-2-c-vankar@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Sun, Mar 02, 2025 at 09:05:01PM +0530, Chintan Vankar wrote:
> Ethernet boot requires CPSW nodes to be present starting from R5 SPL
> stage. Add bootph-all property to required nodes to enable Ethernet boot
> on AM68-SK and J721S2-EVM.
> 
> Signed-off-by: Chintan Vankar <c-vankar@ti.com>

Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Regards,
Siddharth.

