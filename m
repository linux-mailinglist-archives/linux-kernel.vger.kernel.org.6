Return-Path: <linux-kernel+bounces-230931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D549183EA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 16:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02A901F23537
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 14:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E551850B8;
	Wed, 26 Jun 2024 14:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HB4IFK1f"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203CB45C07;
	Wed, 26 Jun 2024 14:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719411868; cv=none; b=FbavZ3+e/5us5qfICWk8pyKUydGNkjnIV7f2vr5jJS8n5KWsYo3sN3wlcshrI88/nvF9o7d4x07ZO4QUMPjXzGmxMhYPXIcxF3IC36C5PvF/9pD2EIx8YekbUzpPftgbnLzw8bXSbzBf20gXRLzyneYrLchU1rl0k+j/TfnK0cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719411868; c=relaxed/simple;
	bh=CuHPqyAPRoQfZVkmRu3Q18KTjaKXZmJG02/XUes9hgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sDlyowcfPmgvPR8ttYlT1Vn3l+ibd7XPo0uv409EvtJTw75xq+jVu0khEWXNQT3k2lOJ89n2IYql/ialKxeaQUTSjgJeSs2pCg/CO6ftdHaWpnpGiGiY76QcUEd8txZAEPbK32yqajgdOuHxNVKP5iJhICFRhrHAOc1/HajCIAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HB4IFK1f; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719411867; x=1750947867;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CuHPqyAPRoQfZVkmRu3Q18KTjaKXZmJG02/XUes9hgQ=;
  b=HB4IFK1fabZAkL39ZItTBgQcTZEJkseRy5shpnmV0WotwSs0HuuyoO/o
   rTdDwdVkC8g47Ny8QC9VpmeWrDs8T8Up/47Vkblq2o0RlLk9mZB+5P0IN
   qlqEx9Q/v6D+mharkAlQCNHUMV8oyc64cTI2CY6Ni7KWrSBERzJfOFvX9
   0YuAguYUaDdwfKHpd2mrmK3nVsBTHGIkEytTCy05xzCgS9VMnZ3OVaVhT
   gljY7kB3RhSrn5cJPjswAax9TYgH08/uX/GcxBuoQaPFdKR6BO+IJOlrL
   x0iwMUpHP3clm7aQMtYOgyjUD0Mx5tGSxmYcd4m07YIXtAz+kZCXysDYw
   w==;
X-CSE-ConnectionGUID: NjaMMb95T1GpfPoP+pmwow==
X-CSE-MsgGUID: HF0mIf2UQVSwlTyjy6pdqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="16634417"
X-IronPort-AV: E=Sophos;i="6.08,267,1712646000"; 
   d="scan'208";a="16634417"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 07:24:26 -0700
X-CSE-ConnectionGUID: YVxzdlZZTNCOOsIetqYlkQ==
X-CSE-MsgGUID: wXROosdSRtqH8MtrKN2U2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,267,1712646000"; 
   d="scan'208";a="48943302"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by orviesa003.jf.intel.com with SMTP; 26 Jun 2024 07:24:23 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 26 Jun 2024 17:24:22 +0300
Date: Wed, 26 Jun 2024 17:24:22 +0300
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
Subject: Re: [PATCH v3 0/7] usb: typec: ucsi: rework glue driver interface
Message-ID: <ZnwkloBH6UVzPOjg@kuha.fi.intel.com>
References: <20240625-ucsi-rework-interface-v3-0-7a6c8e17be3a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625-ucsi-rework-interface-v3-0-7a6c8e17be3a@linaro.org>

On Tue, Jun 25, 2024 at 05:54:25PM +0300, Dmitry Baryshkov wrote:
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

I tested these on couple of systems that use the acpi mailbox, and
didn't see any problems. I'll be away for most of July, so if there's
nothing else, for the series:

Tested-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

thanks,

-- 
heikki

