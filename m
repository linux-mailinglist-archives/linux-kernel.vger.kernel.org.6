Return-Path: <linux-kernel+bounces-514442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13CCBA35717
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 07:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B9EE3A5428
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 06:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7803620103A;
	Fri, 14 Feb 2025 06:30:17 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E09200BB3
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 06:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739514617; cv=none; b=FOyAJGEeoIn19UP1eJLHNf+c+jSPZf7Tx2OBtye7M7XwlbaN07sXvrdnCAiFPAWiR8E2rP2RK3Wmtn6tw8FEO1/XCvAbbZ/LB7qTHTZIwdTf4BbpCn7uQPxHa+8+jMH464W7O1MQwINdUwQdckRawcasa6MMbOvOCeEoofFGtaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739514617; c=relaxed/simple;
	bh=ONnE7smu8/9nIlmyt9HAOZbYmNQ170FAywkKcOU+mRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fNYkk1wCpeg+r1p+q7TPMnSuc3NbOEjlJPtzu2OK7QdFbWcsLq+PhfuUs5KGdk7ySlPt4rCVprIcNMa5M7lKD092x+rVjs4ndPAiCCv4w40NN9LGBGZ/byQu/0G4lj2PXd8SiEfKbVSGqEwE537M2R0maP6sbji3olYtFJBJg8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1tipDB-0006zp-I1; Fri, 14 Feb 2025 07:30:05 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1tipDB-000s8w-0M;
	Fri, 14 Feb 2025 07:30:05 +0100
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1tipDB-00EbY2-01;
	Fri, 14 Feb 2025 07:30:05 +0100
Date: Fri, 14 Feb 2025 07:30:04 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, marex@denx.de,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V3] soc: imx8m: Unregister cpufreq and soc dev in cleanup
 path
Message-ID: <20250214063004.jvz5vukaxszcucd7@pengutronix.de>
References: <20241219145029.1776006-1-peng.fan@oss.nxp.com>
 <20250214034923.GA20275@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214034923.GA20275@localhost.localdomain>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hi Peng,

On 25-02-14, Peng Fan wrote:
> Hi Shawn,
> 
> On Thu, Dec 19, 2024 at 10:50:29PM +0800, Peng Fan (OSS) wrote:
> >From: Peng Fan <peng.fan@nxp.com>
> >
> >Unregister the cpufreq device and soc device when resource unwinding,
> >otherwise there will be warning when do removing test:
> >sysfs: cannot create duplicate filename '/devices/platform/imx-cpufreq-dt'
> >CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.13.0-rc1-next-20241204
> >Hardware name: NXP i.MX8MPlus EVK board (DT)
> >
> >Fixes: 9cc832d37799 ("soc: imx8m: Probe the SoC driver as platform driver")
> >Cc: Marco Felsch <m.felsch@pengutronix.de>
> >Signed-off-by: Peng Fan <peng.fan@nxp.com>
> >---
> 
> Any comments?
> 
> Thanks,
> Peng
> 
> >
> >V3:
> > Per Marco, drop remove function, use devm_add_action and update the patch
> > title accordingly.
> >
> >V2:
> > Add err check when create the cpufreq platform device
> > https://lore.kernel.org/all/20241217015826.1374497-1-peng.fan@oss.nxp.com/

This is got lost. Albeit platform_device_unregister() can handle
IS_ERROR() cases I don't like the fact that we do not return the error
if there is any during probe. Please see below.

> >
> > drivers/soc/imx/soc-imx8m.c | 23 +++++++++++++++++++++--
> > 1 file changed, 21 insertions(+), 2 deletions(-)
> >
> >diff --git a/drivers/soc/imx/soc-imx8m.c b/drivers/soc/imx/soc-imx8m.c
> >index 8ac7658e3d52..585631b7ae44 100644
> >--- a/drivers/soc/imx/soc-imx8m.c
> >+++ b/drivers/soc/imx/soc-imx8m.c
> >@@ -192,9 +192,20 @@ static __maybe_unused const struct of_device_id imx8_soc_match[] = {
> > 	devm_kasprintf((dev), GFP_KERNEL, "%d.%d", ((soc_rev) >> 4) & 0xf, (soc_rev) & 0xf) : \
> > 	"unknown"
> > 
> >+static void imx8m_unregister_soc(void *data)
> >+{
> >+	soc_device_unregister(data);
> >+}
> >+
> >+static void imx8m_unregister_cpufreq(void *data)
> >+{
> >+	platform_device_unregister(data);
> >+}
> >+
> > static int imx8m_soc_probe(struct platform_device *pdev)
> > {
> > 	struct soc_device_attribute *soc_dev_attr;
> >+	struct platform_device *cpufreq_dev;
> > 	const struct imx8_soc_data *data;
> > 	struct device *dev = &pdev->dev;
> > 	const struct of_device_id *id;
> >@@ -239,11 +250,19 @@ static int imx8m_soc_probe(struct platform_device *pdev)
> > 	if (IS_ERR(soc_dev))
> > 		return PTR_ERR(soc_dev);
> > 
> >+	ret = devm_add_action(dev, imx8m_unregister_soc, soc_dev);
> >+	if (ret)
> >+		return ret;
> >+
> > 	pr_info("SoC: %s revision %s\n", soc_dev_attr->soc_id,
> > 		soc_dev_attr->revision);
> > 
> >-	if (IS_ENABLED(CONFIG_ARM_IMX_CPUFREQ_DT))
> >-		platform_device_register_simple("imx-cpufreq-dt", -1, NULL, 0);
> >+	if (IS_ENABLED(CONFIG_ARM_IMX_CPUFREQ_DT)) {
> >+		cpufreq_dev = platform_device_register_simple("imx-cpufreq-dt", -1, NULL, 0);
		if (IS_ERROR(cpufreq_dev))
			return dev_err_probe(dev, "Failed to imx-cpufreq-dev device\n",
					     PTR_ERR(cpufreq_dev));

Regards,
  Marco

> >+		ret = devm_add_action(dev, imx8m_unregister_cpufreq, cpufreq_dev);
> >+		if (ret)
> >+			return ret;
> >+	}
> > 
> > 	return 0;
> > }
> >-- 
> >2.37.1
> >
> >
> 

