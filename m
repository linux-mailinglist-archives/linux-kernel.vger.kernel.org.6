Return-Path: <linux-kernel+bounces-312957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A9C969E46
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 14:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8EF5B24013
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 12:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E111A0BEA;
	Tue,  3 Sep 2024 12:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nh9hCt5j"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6C91CA693
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 12:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725367549; cv=none; b=a0jdjNjjhHDNtZL8TjZWvhjn9FEshPXa9m8bo6ALvhBfjp7ZTkujehnlh0E1vtBhM2grROYMaomunPDQmW4iy+XV4VJtC6LjC1rMyJb1FXEI4H2xR9MaZonSPvVYAI81LNrpZ3uL0o9tcl4AYAquzw/zk2YkqQxkycFpRmAjGuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725367549; c=relaxed/simple;
	bh=biFHo9yc7uEHCwKXvIGDhCCO7+LwjOLsYJXhrY7+60M=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OKkWHeaQHQA9wm5OvATQWGe0eSp4OGcR4Df7IG+XGN5wzxrKz2xRmWB0liEJgCLtZRK+Bts1C+UYPfQAAE460I8B3Pzt1gnOBw3x/oDXB3u27CvdyMN6QoKZlc/pombos3i6Je+1eIxk2qJoCTLTYRSFj07ldKOgqTFtSYbDcBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=nh9hCt5j; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 483CjeuT050627;
	Tue, 3 Sep 2024 07:45:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1725367540;
	bh=pCib/IRg7/CXDznhduqYaavWCjHDSzq5T5maGxoi/1M=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=nh9hCt5jvnQUgVwZr49rNRiL6TyH9i+wNkjLNhpMIYzkojXpTfuJaeiqpcKZf5AIH
	 q6LC4YTMKT2UGoZtDAIaiO/Rk2QiomJrMiJ/pvP2kdd/LqiOuET6+nJ7htFU1KTUe9
	 ALh9+wAqGGPNEE00fkPEkjKQ7cgEMZnAF6TU9dvU=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 483CjeLY049539;
	Tue, 3 Sep 2024 07:45:40 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 3
 Sep 2024 07:45:40 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 3 Sep 2024 07:45:39 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 483CjelL013961;
	Tue, 3 Sep 2024 07:45:40 -0500
Date: Tue, 3 Sep 2024 07:45:40 -0500
From: Nishanth Menon <nm@ti.com>
To: Nathan Chancellor <nathan@kernel.org>
CC: Markus Schneider-Pargmann <msp@baylibre.com>,
        Tero Kristo
	<kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Vibhore Vardhan
	<vibhore@ti.com>, Kevin Hilman <khilman@baylibre.com>,
        Dhruva Gole
	<d-gole@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v11 4/4] firmware: ti_sci: add CPU latency constraint
 management
Message-ID: <20240903124540.73cdhsf755lyfisa@tartness>
References: <20240829201606.1407773-1-msp@baylibre.com>
 <20240829201606.1407773-5-msp@baylibre.com>
 <20240903005422.GA4638@thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240903005422.GA4638@thelio-3990X>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 17:54-20240902, Nathan Chancellor wrote:
[...]

> > @@ -3669,7 +3671,27 @@ static int ti_sci_prepare_system_suspend(struct ti_sci_info *info)
> >  static int __maybe_unused ti_sci_suspend(struct device *dev)
> >  {
> >  	struct ti_sci_info *info = dev_get_drvdata(dev);
> > -	int ret;
> > +	struct device *cpu_dev, *cpu_dev_max = NULL;
> > +	s32 val, cpu_lat = 0;
> > +	int i, ret;
> > +
> > +	if (info->fw_caps & MSG_FLAG_CAPS_LPM_DM_MANAGED) {
> > +		for_each_possible_cpu(i) {
> > +			cpu_dev = get_cpu_device(i);
> > +			val = dev_pm_qos_read_value(cpu_dev, DEV_PM_QOS_RESUME_LATENCY);
> 
> This change is now in -next as commit 458d22d2e064 ("firmware: ti_sci:
> add CPU latency constraint management"), where it breaks the build
> when this driver is built as a module because dev_pm_qos_read_value() is
> not exported to modules:
> 
>   ERROR: modpost: "dev_pm_qos_read_value" [drivers/firmware/ti_sci.ko] undefined!
> 
> Obviously exporting it would fix the build but sometimes that is
> controversial, hence just the report.

Thank you for the report. I will drop the series from my queue for now.
That should give us some time to sort things out properly for the next
window.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

