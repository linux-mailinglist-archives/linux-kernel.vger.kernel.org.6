Return-Path: <linux-kernel+bounces-530642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBEBA43612
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 08:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DFEC7A80FD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 07:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EDEA25A2A5;
	Tue, 25 Feb 2025 07:25:36 +0000 (UTC)
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D6E18A6BA
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 07:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740468335; cv=none; b=YYrHDNrwHbc3hG5HdIgfi361Xo94fKawqSELJA4CAPyM+If96IdsRheWeBJh2JDH73CpxFG5o3//SzIkdn5h2JV2zk8/q8tnx7EQvC1EoOJQebsLC2E1AIVAWgOUzSTHyILsk1vaveGYYdnotGjKnADtIGIBasnn2PZ0TzUvQs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740468335; c=relaxed/simple;
	bh=qrp9TRpXJyfTs3ng9+Sk2bFWz8uGzesUt6kI+cgZdLo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ngwsuFVosxz96Gj0zY9It0TCeqITrUbTFZ0TGme8ne2Fpw+/eCAuDwrjm/hHGZpW/lIWUMCX2BtG+wFXt7DuoLbiST8m40ljuKqCeHjpCI1CDg2C4JiBkoSqCn72ygcowpdEHbbW3PqE+Kt3IL1gu5PSRDBArdzsZOLG5uEpG8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-232.elisa-laajakaista.fi [88.113.26.232])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTP
	id b02b4d02-f349-11ef-8389-005056bdd08f;
	Tue, 25 Feb 2025 09:25:30 +0200 (EET)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 25 Feb 2025 09:25:28 +0200
To: Yu-Chun Lin <eleanor15x@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org, jserv@ccns.ncku.edu.tw,
	visitorckw@gmail.com, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] Input: wdt87xx_i2c - fix compiler warning
Message-ID: <Z71waEVlSnFpYDcC@surfacebook.localdomain>
References: <20250119084312.1851486-1-eleanor15x@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250119084312.1851486-1-eleanor15x@gmail.com>

Sun, Jan 19, 2025 at 04:43:12PM +0800, Yu-Chun Lin kirjoitti:
> As reported by the kernel test robot, the following warning occur:
> 
> >> drivers/input/touchscreen/wdt87xx_i2c.c:1166:36: warning: 'wdt87xx_acpi_id' defined but not used [-Wunused-const-variable=]
>     1166 | static const struct acpi_device_id wdt87xx_acpi_id[] = {
>          |                                    ^~~~~~~~~~~~~~~
> 
> The 'wdt87xx_acpi_id' array is only used when CONFIG_ACPI is enabled.
> Wrapping its definition and 'MODULE_DEVICE_TABLE' in '#ifdef CONFIG_ACPI'
> prevents a compiler warning when ACPI is disabled.

> +#ifdef CONFIG_ACPI
>  static const struct acpi_device_id wdt87xx_acpi_id[] = {
>  	{ "WDHT0001", 0 },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(acpi, wdt87xx_acpi_id);
> +#endif

Instead, this should get rid of ugly ifdeffery and whatever that makes variable
disappear (ACPI_PTR() call?). It even possible that this make unneeded of
inclusion of some header(s).

-- 
With Best Regards,
Andy Shevchenko



