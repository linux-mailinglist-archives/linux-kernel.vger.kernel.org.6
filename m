Return-Path: <linux-kernel+bounces-284402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7429095008A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0015AB21C8C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 08:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA6F13C80E;
	Tue, 13 Aug 2024 08:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Lhc4XpVY"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A510813A244;
	Tue, 13 Aug 2024 08:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723539444; cv=none; b=CuHRxj47HkyRGN6KhHIRgUqyhCxKw06jgvwaY8mGF5qDf5SHa2psIUhqvU7SkRCMPFmG/Bb/c5zNxtgbTphyw4kWFKDa4He2r0BC50ngdD+//209RqPDPrErs1W26FEmkCv7+L3lV4M1I/zqoh6ixIHekWwM0A328xyQO5WVbBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723539444; c=relaxed/simple;
	bh=hfrVbez70Un9YwYVLufmvGPm/A0lwXmzlFO8uZ3zwjE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ENyY9sI3w3BzFm6tp3SlTMfnZo9U/DYUi7cRjzJrgoL8RisaDP08J+Ba9jWvXPfYlkOaolh93pLSRwKsxRv6X69N2rx3lVk83IbgffVhjFT9hYy4v6r5UedP1SAmlVmFJTwhsT+lY1jAge/n6x8fylk+f9x012unt7qEHuSwg5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Lhc4XpVY; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47D8v5AK068911;
	Tue, 13 Aug 2024 03:57:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723539425;
	bh=u5bcw0YSP2AlCy/t9P4fKlF6jZcLA7J982qAL5M7q1o=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=Lhc4XpVYSbRENVfMqnukDeWr9eYwmOpUchAIDGdlAABU1e5GnRIwjMdSSNp1SBXq4
	 huzK1Xu3goPDgkDsEZewff0lzzVn2GIR198natKS9g4NhJKxO0ZkG34sD+lqr5Ce1t
	 SMP0LHxNCy6JhV9gZgUmMIhWuyTqM4IIuk1LxZtc=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47D8v5s7006302
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 13 Aug 2024 03:57:05 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 13
 Aug 2024 03:57:04 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 13 Aug 2024 03:57:04 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.227.68])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47D8v3aT032867;
	Tue, 13 Aug 2024 03:57:04 -0500
Date: Tue, 13 Aug 2024 14:27:03 +0530
From: Dhruva Gole <d-gole@ti.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC: <sudeep.holla@arm.com>, <cristian.marussi@arm.com>, <saravanak@google.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <arm-scmi@vger.kernel.org>, Peng Fan
	<peng.fan@nxp.com>
Subject: Re: [PATCH V2] firmware: arm_scmi: bus: bypass set fwnode for scmi
 cpufreq
Message-ID: <20240813085703.zz6ltcxmrrbdgt77@lcpd911>
References: <20240729070325.2065286-1-peng.fan@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240729070325.2065286-1-peng.fan@oss.nxp.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Jul 29, 2024 at 15:03:25 +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Two drivers scmi_cpufreq.c and scmi_perf_domain.c both use
> SCMI_PROTCOL_PERF protocol, but with different name, so two scmi devices
> will be created. But the fwnode->dev could only point to one device.
> 
> If scmi cpufreq device created earlier, the fwnode->dev will point to
> the scmi cpufreq device. Then the fw_devlink will link performance
> domain user device(consumer) to the scmi cpufreq device(supplier).
> But actually the performance domain user device, such as GPU, should use
> the scmi perf device as supplier. Also if 'cpufreq.off=1' in bootargs,
> the GPU driver will defer probe always, because of the scmi cpufreq

The commit message itself seems very specific to some platform to me.
What about platforms that don't atall have a GPU? Why would they care
about this?

> device not ready.
> 
> Because for cpufreq, no need use fw_devlink. So bypass setting fwnode
> for scmi cpufreq device.
> 
> Fixes: 96da4a99ce50 ("firmware: arm_scmi: Set fwnode for the scmi_device")
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> 
> V2:
>  Use A!=B to replace !(A == B)
>  Add fixes tag
>  This might be a workaround, but since this is a fix, it is simple for
>  backporting.

More than a workaround, it feels like a HACK to me.

> 
> V1:
>  https://lore.kernel.org/all/20240717093515.327647-1-peng.fan@oss.nxp.com/
> 
>  drivers/firmware/arm_scmi/bus.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/arm_scmi/bus.c b/drivers/firmware/arm_scmi/bus.c
> index 96b2e5f9a8ef..be91a82e0cda 100644
> --- a/drivers/firmware/arm_scmi/bus.c
> +++ b/drivers/firmware/arm_scmi/bus.c
> @@ -395,7 +395,8 @@ __scmi_device_create(struct device_node *np, struct device *parent,
>  	scmi_dev->id = id;
>  	scmi_dev->protocol_id = protocol;
>  	scmi_dev->dev.parent = parent;
> -	device_set_node(&scmi_dev->dev, of_fwnode_handle(np));
> +	if ((protocol != SCMI_PROTOCOL_PERF) || strcmp(name, "cpufreq"))
> +		device_set_node(&scmi_dev->dev, of_fwnode_handle(np));

I kind of disagree with the idea here to be specific about the
PROTOCOL_PERF or cpufreq. This is a generic arm scmi bus driver right?
Why bring in specific code into a bus driver? We will never fix the
actual root cause of the issue this way.

-- 
Best regards,
Dhruva Gole <d-gole@ti.com>

