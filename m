Return-Path: <linux-kernel+bounces-276507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C019494BD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 17:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD81B1F226E7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 15:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AAFC1DDEA;
	Tue,  6 Aug 2024 15:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="P3rO48UP"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BDD18D625
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 15:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722958929; cv=none; b=frpQUAkB8r6gFNnhIVOwO0+LykkvEgaftFVeWKBHpA49nh9rmZxtjqUWLy8GTH2ZoeNBeQiHUQQtMe3ep+fmnkE6hDU/U0tYhd5gstDTxJKD8PxEJe1onqLhB4j0Rbq46gbqYjCIQwTu9Wn7/YKkzOmvyqnXtSU4P9QT0dSSngM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722958929; c=relaxed/simple;
	bh=2P3an4w7gfUoX11+anvDdFaQApl/JcxcnNXCSOFW/q8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k6WvpF30AUD8+sxbGbCAgGX7dv/bg/7Kwyhz2mmrAq1V4M3NjJ9Gg5k0K0hVtJr5J6EbYft5hw5T90PkDI4bmPgOEcBDnVPmzuYwQRuIPcIeB67lxgminJQ/6AKnrJ5CK4mgzRQYMFH/Cv/kGLYE1MbyiJ/eE4HF7ktvvJ9w/6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=P3rO48UP; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 476Fg1N9098251;
	Tue, 6 Aug 2024 10:42:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722958921;
	bh=x8SgTFtSMWNW8cge/SCwclavovE9l5hGsdVvQ3ubDuI=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=P3rO48UPg/mfT4NbEOuoYoeSyovDa4N2KarCErIbEEEiQQzE+a4PfjkKuJxEPZ9Ij
	 aS8FZ6jaBdMhXRL6ClEZyA7t8io4z5vSHh3soxoFZM9m4+5HUU392gOeJ5se4NbL1n
	 Dy0An84yLWI7fo0oxOmQW96FE/wclIgG5rLgM6iI=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 476Fg1oa026047
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 6 Aug 2024 10:42:01 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 Aug 2024 10:42:01 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 Aug 2024 10:42:01 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 476Fg1gw041653;
	Tue, 6 Aug 2024 10:42:01 -0500
Date: Tue, 6 Aug 2024 10:42:01 -0500
From: Nishanth Menon <nm@ti.com>
To: Markus Schneider-Pargmann <msp@baylibre.com>
CC: Tero Kristo <kristo@kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>,
        Vibhore Vardhan <vibhore@ti.com>, Kevin Hilman <khilman@baylibre.com>,
        "Dhruva Gole" <d-gole@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Georgi Vlaev <g-vlaev@ti.com>
Subject: Re: [PATCH v8 2/3] firmware: ti_sci: Add support for querying the
 firmware caps
Message-ID: <20240806154201.tfqq27csd6zvtbrw@browsing>
References: <20240801195422.2296347-1-msp@baylibre.com>
 <20240801195422.2296347-3-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240801195422.2296347-3-msp@baylibre.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 21:54-20240801, Markus Schneider-Pargmann wrote:
[...]

>  static int ti_sci_cmd_core_reboot(const struct ti_sci_handle *handle)
>  {
>  	struct ti_sci_info *info;
> @@ -3113,6 +3172,12 @@ static void ti_sci_setup_ops(struct ti_sci_info *info)
>  
>  	pmops->lpm_wake_reason = ti_sci_msg_cmd_lpm_wake_reason;
>  
> +	if (info->fw_caps & MSG_FLAG_CAPS_LPM_DM_MANAGED) {
> +		pr_debug("detected DM managed LPM in fw_caps\n");
> +		ops->pm_ops.set_device_constraint = ti_sci_cmd_set_device_constraint;
> +		ops->pm_ops.set_latency_constraint = ti_sci_cmd_set_latency_constraint;
pmops-> ?

Also lpm_wake_reason makes sense only if the flag is set, so
this should probably be the first patch in your series?

> +	}

Side-note: please drop bouncing emails from your patch CC list.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

