Return-Path: <linux-kernel+bounces-229066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E15D3916A63
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 16:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C3E41F2302E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 14:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CD416F901;
	Tue, 25 Jun 2024 14:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E9kitTR/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FF039FD6;
	Tue, 25 Jun 2024 14:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719325721; cv=none; b=gx70UjL8i8ktf6ew1DD99Qbwzg36Qtg/BRMxQ99H/BxCbJqq/qZh6LT7kEOdKQ2FAQjhmsPlwH76NAOrhfYfLdW2/1zUVYkvj/imwyEXUzg1Etl0OPUq0gZV6+FYQuWb2PBvssQ0W8TNmOWf5fE3+KvGDLQxCBIPqHGewhuNduw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719325721; c=relaxed/simple;
	bh=4VC/dpmvV2yj+XWaUHU3QaBpFS4x/fGnrsDdid1YfWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WCDlnFZFYWJ10rloZ7rjcWIPioq9Ng/kqZiugoDT1Meam41pceQ0/6xH2Kk0Yep6SHNB+9gDvmqQqNHKOq0a3cATaqnvG09BGr+B6aOjE0bbLY0z1kLiIGnO18nZH5jH/QiAAkd6SuMZpMZDjISY46t92eBo1uygQbePXxR/0GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E9kitTR/; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719325719; x=1750861719;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4VC/dpmvV2yj+XWaUHU3QaBpFS4x/fGnrsDdid1YfWM=;
  b=E9kitTR/g/0YmIBEtWLoCAYqZifG9/sNyvZnzJHZusYPWmg49yJDxOjf
   sJeL7XBJ+WyQhbIEl1xTjaG8I3lqbGW6OpfvEQncpiOubGBBRm1zoTYrW
   PdGdnUVq5Ptw6+5keGLcbUoVxXO2By88549A1aybfiAMIpP+HRIr4j128
   b5qVFF+EjA3Bcv+hShX7Kl6X9PTeo60Zz9kZx9o4CJsQYE3jYbXpz71mR
   EdBrMHPtx79QkVd2EkXKWX2Qy3ivHzT5eL+qKkxA9PmLdvkZulXaEMk0i
   CIYjBp143f957yfXnZwiii/qHg993y1ZZA5T8UYBgRl5ECmKlTPj0q7W0
   Q==;
X-CSE-ConnectionGUID: a0x1Gck1Q02wzl2Tdosq8Q==
X-CSE-MsgGUID: n1Dc4KBXRAOWnv/vVFIDPA==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="16309089"
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="16309089"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 07:28:39 -0700
X-CSE-ConnectionGUID: kbnTYjbeThOxOrKl80gX5Q==
X-CSE-MsgGUID: +lgyiggYS0WF8pCBWxD4Ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="43546824"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by orviesa010.jf.intel.com with SMTP; 25 Jun 2024 07:28:35 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 25 Jun 2024 17:28:34 +0300
Date: Tue, 25 Jun 2024 17:28:34 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Nikita Travkin <nikita@trvn.ru>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/7] usb: typec: ucsi: rework glue driver interface
Message-ID: <ZnrUEp0C9+Q7p+8a@kuha.fi.intel.com>
References: <20240621-ucsi-rework-interface-v2-0-a399ff96bf88@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621-ucsi-rework-interface-v2-0-a399ff96bf88@linaro.org>

On Fri, Jun 21, 2024 at 01:55:19AM +0300, Dmitry Baryshkov wrote:
> The interface between UCSI and the glue driver is very low-level. It
> allows reading the UCSI data from any offset (but in reality the UCSI
> driver reads only VERSION, CCI an MESSAGE_IN data). All event handling
> is to be done by the glue driver (which already resulted in several
> similar-but-slightly different implementations). It leaves no place to
> optimize the write-read-read sequence for the command execution (which
> might be beneficial for some of the drivers), etc.
> 
> The patchseries attempts to restructure the UCSI glue driver interface
> in order to provide sensible operations instead of a low-level read /
> write calls.
> 
> If this approach is found to be acceptable, I plan to further rework the
> command interface, moving reading CCI and MESSAGE_IN to the common
> control code, which should simplify driver's implementation and remove
> necessity to split quirks between sync_control and read_message_in e.g.
> as implemented in the ucsi_ccg.c.
> 
> Note, the series was tested only on the ucsi_glink platforms. Further
> testing is appreciated.

I can run a few tests against these tomorrow.

I don't have have any objections with this approach, but you'll need
to do another rebase. Now these don't apply cleanly because of
9e3caa9dd51b ("usb: typec: ucsi_acpi: Add LG Gram quirk").

thanks,

> Depends: [1], [2]
> 
> [1] https://lore.kernel.org/linux-usb/20240612124656.2305603-1-fabrice.gasnier@foss.st.com/
> 
> [2] https://lore.kernel.org/linux-usb/20240621-ucsi-yoga-ec-driver-v8-1-e03f3536b8c6@linaro.org/
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
> Changes in v2:
> - Dropped the RFC prefix
> - Rebased on top of the fixed STM32 patch
> - Included the pending Yoga C630 driver into the cleanup.
> - Link to v1: https://lore.kernel.org/r/20240603-ucsi-rework-interface-v1-0-99a6d544cec8@linaro.org
> 
> ---
> Dmitry Baryshkov (7):
>       usb: typec: ucsi: move ucsi_acknowledge() from ucsi_read_error()
>       usb: typec: ucsi: simplify command sending API
>       usb: typec: ucsi: split read operation
>       usb: typec: ucsi: rework command execution functions
>       usb: typec: ucsi: inline ucsi_read_message_in
>       usb: typec: ucsi: extract common code for command handling
>       usb: typec: ucsi: reorder operations in ucsi_run_command()
> 
>  drivers/usb/typec/ucsi/ucsi.c           | 215 +++++++++++++++++---------------
>  drivers/usb/typec/ucsi/ucsi.h           |  26 ++--
>  drivers/usb/typec/ucsi/ucsi_acpi.c      | 100 +++++++--------
>  drivers/usb/typec/ucsi/ucsi_ccg.c       | 103 +++++++--------
>  drivers/usb/typec/ucsi/ucsi_glink.c     |  74 ++++-------
>  drivers/usb/typec/ucsi/ucsi_stm32g0.c   |  79 ++++--------
>  drivers/usb/typec/ucsi/ucsi_yoga_c630.c | 104 +++++----------
>  7 files changed, 309 insertions(+), 392 deletions(-)
> ---
> base-commit: f0dbf09a40c8100a895f675d619db5ed1f58f7ac
> change-id: 20240525-ucsi-rework-interface-5ff2264f6aec
> 
> Best regards,
> -- 
> Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
heikki

