Return-Path: <linux-kernel+bounces-416068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2789D4093
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 17:54:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CB0DB24C46
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 16:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E4714C5BD;
	Wed, 20 Nov 2024 16:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ktV6EAdv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2993A13E41A;
	Wed, 20 Nov 2024 16:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732119050; cv=none; b=Y7O/HquKyB5atr1ej1ZNjrixsDix4I7Jkex8pvBk0gtuhe+GMJsu+PAhVeCP0tyiiGYzPz01Z2Ei00+YQnuQq3uJVBY/3I4Qg44us5Vz5ICXQHm+rc7gNLCTMoehR3G1oCFWvBZmrkbyJtbL7SQQ4yXyszEAORNm1xfwlyPiPGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732119050; c=relaxed/simple;
	bh=3Za60ZFlpe4MkTK49XqK+z0H+TjcuhfWcXkV4Eo85A4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=fjWbPCENJT8iVLWT6qJJfChlN4m6GxcFCnKCgEoeTwqhE2TzDV9mZ8i76IN33t7ic94zKY5YY+LiqlxxkgXEALSqlHngQmKk6Vv8Cr0d2/PikO4jNJcMhLO6OUXMUIfGvSVJuLYVLJo7j6IJIHZhEnMuvpYufSXn969pbnA6RfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ktV6EAdv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70750C4CECE;
	Wed, 20 Nov 2024 16:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732119049;
	bh=3Za60ZFlpe4MkTK49XqK+z0H+TjcuhfWcXkV4Eo85A4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ktV6EAdvJMbNuEYsQPSJmJo39ZxbS14u+aj7e059i6UhJOjg0P4DNtd0c9piHvHV+
	 39LmVa1NnJ6fQW7RpA8B9iLVwu/tEdNFvce6TsPnIp0me5ONE+xgZ+3xxvE01mp9A2
	 X5rqJcDkZ5p/enneQTKddM8jL2JjCufCgj3eBdkmpxrYo86KU2SlI6uwu8DCA9XROA
	 UxTrmSL1PVUi2H9obUPpaQmfBnoJUZ/yHL6U5t+YwVkwEO43Jhw3cEa6+dSJhrAqM4
	 oX+yuub+RdNyKIVi3EUE6Tk2WsNKM/IUkc/muDLJli4CbM5uYd7jG2ryjdVnWAqx1H
	 LwEcHQCqfF3CQ==
Date: Wed, 20 Nov 2024 10:10:47 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: manivannan.sadhasivam@linaro.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	Stephan Gerhold <stephan.gerhold@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
	stable+noautosel@kernel.org,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>
Subject: Re: [PATCH v2 3/5] PCI/pwrctl: Ensure that the pwrctl drivers are
 probed before the PCI client drivers
Message-ID: <20241120161047.GA2325953@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025-pci-pwrctl-rework-v2-3-568756156cbe@linaro.org>

On Fri, Oct 25, 2024 at 01:24:53PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> As per the kernel device driver model, pwrctl device is the supplier for
> the PCI device. But the device link that enforces the supplier-consumer
> relationship is created inside the pwrctl driver currently. Due to this,
> the driver model doesn't prevent probing of the PCI client drivers before
> probing the corresponding pwrctl drivers. This may lead to a race condition
> if the PCI device was already powered on by the bootloader (before the
> pwrctl driver).

> +	 * Create a device link between the PCI device and pwrctl device (if
> +	 * exists). This ensures that the pwrctl drivers are probed before the
> +	 * PCI client drivers.
> +	 */
> +	pdev = of_find_device_by_node(dn);
> +	if (pdev) {
> +		if (!device_link_add(&dev->dev, &pdev->dev, DL_FLAG_AUTOREMOVE_CONSUMER))
> +			pci_err(dev, "failed to add device link between %s and %s\n",
> +				dev_name(&dev->dev), pdev->name);

This prints the name for "dev" twice (once by pci_err(dev) and again
from dev_name(&dev->dev)).  Is it helpful to see it twice here?

