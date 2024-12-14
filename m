Return-Path: <linux-kernel+bounces-445927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B1BF9F1D96
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 09:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71A19168542
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 08:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED3B15CD49;
	Sat, 14 Dec 2024 08:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SLIYGXj1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA65411712;
	Sat, 14 Dec 2024 08:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734166189; cv=none; b=PonQuI/h5lW3f2okqUA53bm8rjQdGYC8KzVZuo9sNBV2+WktLOzm2/maC55ugvQUkk7b6s/FV57vzbnNicqPSlySXn61WzJ0RzSFIXsja78fhHKPqi5B3Edj+NvujolXn0vQR6wUuc5HQ54nuqz1fhcjGizJrTj+4FsnjSnErBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734166189; c=relaxed/simple;
	bh=4grMQMw6rtH/ZKhgxDacEbqLbGv2ReJBu1YFLbC15og=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=beiZE9hjh3SX9GboebIirAgfuVjD9EyiVpU4NxPfda7RTBUIQ8ARJeMbfi0TOrAaeetRWGW2ZOT2UNYuwK0yQiNtCglfHkYuwgnxhwliGSAYAqaHlE9LFlsrIy4j+iJ8U3n9H5mgHGRqS8XI+5ZdBoUWEWnc/Ib4e4buHvzDw2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SLIYGXj1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0032FC4CED1;
	Sat, 14 Dec 2024 08:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734166188;
	bh=4grMQMw6rtH/ZKhgxDacEbqLbGv2ReJBu1YFLbC15og=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SLIYGXj1G8hndfmtTPJSZq6u/mOWI+3A+zOkQwJPSutwXfClqOUdOT3EMlAsvAiju
	 Yu4PmGxedHoo4JR8ddDYIyAupsfSc4GXnU7osZoh4Jx0T15veHktRIFHlhl8ZzVG61
	 eYwZ/IZ+a/tU1foTMUDv39AyFD4Bo6i9/0zTJT78L5MUFpZV5NfhU7GbWuPDQUkZMe
	 52CyJDacoSUPT0vJjJHA5Vj3aHsoesltZU1okQZ5xkZfVqm2+7SZXZHKYXmZHUpT+i
	 oG/23H2DDtIg4lcU+YvyaMFEMTMcTsHV5hDx5LMmuhoEYKe3ScWQK+8mwSiojQPB7/
	 Gw8yG1T9dw+4A==
Date: Sat, 14 Dec 2024 16:49:40 +0800
From: Peter Chen <peter.chen@kernel.org>
To: =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>
Cc: Pawel Laszczak <pawell@cadence.com>, Roger Quadros <rogerq@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mathias Nyman <mathias.nyman@intel.com>,
	=?iso-8859-1?Q?Gr=E9gory?= Clement <gregory.clement@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/5] usb: cdns3-ti: run HW init at resume() if HW was
 reset
Message-ID: <20241214084940.GA4102926@nchen-desktop>
References: <20241210-s2r-cdns-v6-0-28a17f9715a2@bootlin.com>
 <20241210-s2r-cdns-v6-2-28a17f9715a2@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241210-s2r-cdns-v6-2-28a17f9715a2@bootlin.com>

On 24-12-10 18:13:36, Théo Lebrun wrote:
> At runtime_resume(), read the W1 (Wrapper Register 1) register to detect
> if an hardware reset occurred. If it did, run the hardware init sequence.
> 
> This callback will be called at system-wide resume. Previously, if a
> reset occurred during suspend, we would crash. The wrapper config had
> not been written, leading to invalid register accesses inside cdns3.
> 
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

Why only runtime resume, but without runtime suspend?

Peter

