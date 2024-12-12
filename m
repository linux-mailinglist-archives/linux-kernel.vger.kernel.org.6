Return-Path: <linux-kernel+bounces-443065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A5B9EE681
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 13:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A86D31886327
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 12:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EAD9212D8E;
	Thu, 12 Dec 2024 12:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d7A4Fsn8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8842C212B32;
	Thu, 12 Dec 2024 12:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734005909; cv=none; b=nkfJSCCrIAXiBKkrrDiqO3e+fyVbgdy8LdjN06IPRLXbIkMKlWeSfGzpcAucdbYyfyGuntBrL3B3AaLI+r20glXBKh78ZhE4VQxEJHn58qF5DqBoaMVHs8994Jxp9TvjW7nBGrgh2bj/I78tqxCYKLkKeDOfmKfZZjnqlPt9Imw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734005909; c=relaxed/simple;
	bh=7ezu9sBdly/qvSx8Y2gocL3CuNmOZUVxyKqVH0A1Srg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PLs945fynPmEl8LoCTjc3QNwpY8jmODZ1h+xNqAB7dwtuPmnDSfDWMeoGE5PE8bsCZMxTBlZtAjjnmMMwsmYXxtm6sQ5naMoRqHfwOQL1WaOrpozDcaoxI1OgpyQf803OwoYVvfxallL8vA4+2Lb6HrG7JLHvrtaq2AVZRlxW10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d7A4Fsn8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0254DC4CECE;
	Thu, 12 Dec 2024 12:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734005909;
	bh=7ezu9sBdly/qvSx8Y2gocL3CuNmOZUVxyKqVH0A1Srg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=d7A4Fsn8q6y4IdoSpi8r4ysXhSUUtIfXvE6vRln7WjAPkRRgIcB5TRtX2eMC3VdwG
	 o77kuIpuom23aW8RnSXOOHkFLzX6VIXMeLN/AaiHkSRCXtJ149Lp4A+LmlT81m4Vkc
	 bzpO/DWpEBFosJzi3IbzMOnMlkeMiXB2domj4ofYgesvqNfeCoDxMksCPHZCgdY+Ov
	 j7S2ZapDOhlmyYjNcAEHwRn0fxeOc8HNqWrG4N1FmSDVROfSLF6IFVnBc9e21Hkv6j
	 fhMgOmYKQNnkhg4EVR1RILu1twFLm8mP2dCVvAwJHp/dDbDDn7AfnO3ude35aCZEc3
	 SzuETjae1aPyw==
Message-ID: <4e1eb8d2-c725-4572-8419-3027cac10c92@kernel.org>
Date: Thu, 12 Dec 2024 14:18:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/5] usb: cdns3-ti: run HW init at resume() if HW was
 reset
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 Peter Chen <peter.chen@kernel.org>, Pawel Laszczak <pawell@cadence.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mathias Nyman <mathias.nyman@intel.com>
Cc: =?UTF-8?Q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241210-s2r-cdns-v6-0-28a17f9715a2@bootlin.com>
 <20241210-s2r-cdns-v6-2-28a17f9715a2@bootlin.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20241210-s2r-cdns-v6-2-28a17f9715a2@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/12/2024 19:13, Théo Lebrun wrote:
> At runtime_resume(), read the W1 (Wrapper Register 1) register to detect
> if an hardware reset occurred. If it did, run the hardware init sequence.
> 
> This callback will be called at system-wide resume. Previously, if a
> reset occurred during suspend, we would crash. The wrapper config had
> not been written, leading to invalid register accesses inside cdns3.
> 

Did I understand right that the Controller reset can happen only at
system suspend and never at runtime suspend?

If so do you really need the runtime suspend/resume hooks?
you should have different system suspend/resume hooks than runtime suspend/resume
hooks and deal with the re-initialization in system resume hook.


> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---
>  drivers/usb/cdns3/cdns3-ti.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/usb/cdns3/cdns3-ti.c b/drivers/usb/cdns3/cdns3-ti.c
> index d704eb39820ad08a8774be7f00aa473c3ff267c0..d35be7db7616ef5e5bed7dbd53b78a094809f7cc 100644
> --- a/drivers/usb/cdns3/cdns3-ti.c
> +++ b/drivers/usb/cdns3/cdns3-ti.c
> @@ -188,6 +188,12 @@ static int cdns_ti_probe(struct platform_device *pdev)
>  	data->vbus_divider = device_property_read_bool(dev, "ti,vbus-divider");
>  	data->usb2_only = device_property_read_bool(dev, "ti,usb2-only");
>  
> +	/*
> +	 * The call below to pm_runtime_get_sync() MIGHT reset hardware, if it
> +	 * detects it as uninitialised. We want to enforce a reset at probe,
> +	 * and so do it manually here. This means the first runtime_resume()
> +	 * will be a no-op.
> +	 */

Separate system sleep hooks will also prevent this kind of behavior.

>  	cdns_ti_reset_and_init_hw(data);
>  
>  	pm_runtime_enable(dev);
> @@ -232,6 +238,24 @@ static void cdns_ti_remove(struct platform_device *pdev)
>  	platform_set_drvdata(pdev, NULL);
>  }
>  
> +static int cdns_ti_runtime_resume(struct device *dev)
> +{
> +	const u32 mask = USBSS_W1_PWRUP_RST | USBSS_W1_MODESTRAP_SEL;
> +	struct cdns_ti *data = dev_get_drvdata(dev);
> +	u32 w1;
> +
> +	w1 = cdns_ti_readl(data, USBSS_W1);
> +	if ((w1 & mask) != mask)
> +		cdns_ti_reset_and_init_hw(data);
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops cdns_ti_pm_ops = {
> +	RUNTIME_PM_OPS(NULL, cdns_ti_runtime_resume, NULL)
> +	SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
> +};
> +
>  static const struct of_device_id cdns_ti_of_match[] = {
>  	{ .compatible = "ti,j721e-usb", },
>  	{ .compatible = "ti,am64-usb", },
> @@ -245,6 +269,7 @@ static struct platform_driver cdns_ti_driver = {
>  	.driver		= {
>  		.name	= "cdns3-ti",
>  		.of_match_table	= cdns_ti_of_match,
> +		.pm     = pm_ptr(&cdns_ti_pm_ops),
>  	},
>  };
>  
> 

-- 
cheers,
-roger


