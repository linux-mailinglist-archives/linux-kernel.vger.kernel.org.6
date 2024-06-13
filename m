Return-Path: <linux-kernel+bounces-213060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8704906A79
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 12:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 736E61F23D35
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 10:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA46A1428F1;
	Thu, 13 Jun 2024 10:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lK/pp4Fw"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBF013D534;
	Thu, 13 Jun 2024 10:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718275996; cv=none; b=KZ3bLhInkcfuzzXFf57N7hltYsv4dSAnmnDuzG4DUS3jkqRcdsnPJVv+iBr1P6nwXVliwvYyPZlyBNsHIn8LOjigQpJ8hrJd3903/9zUUVit571lc1911GB8ZDwmYsdiOIcfBMCBGinHrQbV5ey7Srnrv7e+9vY5gEkMCQb5ehE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718275996; c=relaxed/simple;
	bh=NURTeOxOgiogS3ms0vWEjmPgApMszd6tWnaLFNteF5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FsDYPX7VoTYUwd32RiuF22nwMecQhxX33MwtA0rxA/k4OttOc9tb46xK4hhmejMlaeEW8HzTnTRmjgD/cm6Bi/2mSaaAsqLcNyrrt+Zv6iy6FuhtS4dZ6NfK0tFhWtbe9L/6D98MlLkCjwarr3I8RSItTT/z/Vw0/BhNowdg/4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lK/pp4Fw; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718275994; x=1749811994;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NURTeOxOgiogS3ms0vWEjmPgApMszd6tWnaLFNteF5g=;
  b=lK/pp4FwKooB+7B9HjV2HafKxwTj+8EjaJ6j1HnMDLA0Qdn8wNtz78EM
   5ZEkePTSrY+uTNMVgzy2j4MjVPuptxxv7XEKhVfWNDaPmBBhMpmIE1C5O
   fXhL9I9NJaytwE0kZ32NcY4eVw8e8sl1U6+w1z1yXDkxQKDiIYetppYsJ
   MWvPpruDqGFuGOSz36WYIJqJbI6PFFFrK/ojMf8mb9OcQvaX/GOYOMm2k
   e0ldJ393ERCk5l9wvX3KsVcIc67dbr1RZOIuh0DlprIocQE57Hz62AdyJ
   7oXP3QZED13WCgvJtDfzN4beaJwHgfKkQDoRouUUEHNnkELtPe+MkfIYi
   g==;
X-CSE-ConnectionGUID: iF9oWI/4Rsew8+kMMgBjPg==
X-CSE-MsgGUID: xfyABvLkRQu1csOQ+XfaOA==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="15214139"
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="15214139"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 03:53:14 -0700
X-CSE-ConnectionGUID: jG4G3uKzTPG3cO0HGCT8oQ==
X-CSE-MsgGUID: A1Gjxz5gQOmKVwDUw6GKUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="71315684"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmviesa001.fm.intel.com with SMTP; 13 Jun 2024 03:53:11 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 13 Jun 2024 13:53:10 +0300
Date: Thu, 13 Jun 2024 13:53:10 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: ucsi_acpi: Add LG Gram quirk
Message-ID: <ZmrPlvKarsQLYQgj@kuha.fi.intel.com>
References: <20240612-gram_quirk-v1-1-52b0ff0e1546@tecnico.ulisboa.pt>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612-gram_quirk-v1-1-52b0ff0e1546@tecnico.ulisboa.pt>

On Wed, Jun 12, 2024 at 02:13:10PM +0100, Diogo Ivo wrote:
> Some LG Gram laptops report a bogus connector change event after a
> GET_PDOS command for the partner's source PDOs, which disappears from
> the CCI after acknowledging the command. However, the subsequent
> GET_CONNECTOR_STATUS in ucsi_handle_connector_change() still reports
> this bogus change in bits 5 and 6, leading to the UCSI core re-checking
> the partner's source PDOs and thus to an infinite loop.
> 
> Fix this by adding a quirk that signals when a potentially buggy GET_PDOS
> command is used, checks the status change report and clears it if it is a
> bogus event before sending it to the UCSI core.
> 
> Signed-off-by: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> The models affected by this bug have been reported to be of several forms:
> 1xZ90Q, 1xZD90Q, 1xZB90Q, x = {5, 6, 7}, and as such this patch matches
> only on the final 90Q as well as the product family since the "90Q" string
> may collide with other LG models by being too short. If there are other
> better ways of achieving this match I would be happy to hear about them.
> ---
>  drivers/usb/typec/ucsi/ucsi_acpi.c | 61 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi_acpi.c b/drivers/usb/typec/ucsi/ucsi_acpi.c
> index 8d112c3edae5..adf32ca0f761 100644
> --- a/drivers/usb/typec/ucsi/ucsi_acpi.c
> +++ b/drivers/usb/typec/ucsi/ucsi_acpi.c
> @@ -25,6 +25,7 @@ struct ucsi_acpi {
>  	unsigned long flags;
>  #define UCSI_ACPI_COMMAND_PENDING	1
>  #define UCSI_ACPI_ACK_PENDING		2
> +#define UCSI_ACPI_CHECK_BOGUS_EVENT	3
>  	guid_t guid;
>  	u64 cmd;
>  };
> @@ -128,6 +129,58 @@ static const struct ucsi_operations ucsi_zenbook_ops = {
>  	.async_write = ucsi_acpi_async_write
>  };
>  
> +static int ucsi_gram_read(struct ucsi *ucsi, unsigned int offset,
> +			  void *val, size_t val_len)
> +{
> +	u16 bogus_change = UCSI_CONSTAT_POWER_LEVEL_CHANGE |
> +			   UCSI_CONSTAT_PDOS_CHANGE;
> +	struct ucsi_acpi *ua = ucsi_get_drvdata(ucsi);
> +	struct ucsi_connector_status *status;
> +	int ret;
> +
> +	ret = ucsi_acpi_read(ucsi, offset, val, val_len);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (UCSI_COMMAND(ua->cmd) == UCSI_GET_CONNECTOR_STATUS &&
> +	    test_bit(UCSI_ACPI_CHECK_BOGUS_EVENT, &ua->flags) &&
> +	    offset == UCSI_MESSAGE_IN) {
> +		status = (struct ucsi_connector_status *)val;
> +
> +		/* Clear the bogus change */
> +		if (status->change == bogus_change)
> +			status->change = 0;
> +
> +		clear_bit(UCSI_ACPI_CHECK_BOGUS_EVENT, &ua->flags);
> +	}
> +
> +	return ret;
> +}
> +
> +static int ucsi_gram_sync_write(struct ucsi *ucsi, unsigned int offset,
> +				const void *val, size_t val_len)
> +{
> +	struct ucsi_acpi *ua = ucsi_get_drvdata(ucsi);
> +	int ret;
> +
> +	ret = ucsi_acpi_sync_write(ucsi, offset, val, val_len);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (UCSI_COMMAND(ua->cmd) == UCSI_GET_PDOS &&
> +	    ua->cmd & UCSI_GET_PDOS_PARTNER_PDO(1) &&
> +	    ua->cmd & UCSI_GET_PDOS_SRC_PDOS)
> +		set_bit(UCSI_ACPI_CHECK_BOGUS_EVENT, &ua->flags);
> +
> +	return ret;
> +}
> +
> +static const struct ucsi_operations ucsi_gram_ops = {
> +	.read = ucsi_gram_read,
> +	.sync_write = ucsi_gram_sync_write,
> +	.async_write = ucsi_acpi_async_write
> +};
> +
>  static const struct dmi_system_id ucsi_acpi_quirks[] = {
>  	{
>  		.matches = {
> @@ -136,6 +189,14 @@ static const struct dmi_system_id ucsi_acpi_quirks[] = {
>  		},
>  		.driver_data = (void *)&ucsi_zenbook_ops,
>  	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "LG Electronics"),
> +			DMI_MATCH(DMI_PRODUCT_FAMILY, "LG gram PC"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "90Q"),
> +		},
> +		.driver_data = (void *)&ucsi_gram_ops,
> +	},
>  	{ }
>  };
>  
> 
> ---
> base-commit: 5821bf2dffbe18fe1f097dbb027415fa15a38e9a
> change-id: 20240612-gram_quirk-ac150257c415
> 
> Best regards,
> -- 
> Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>

-- 
heikki

