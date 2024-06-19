Return-Path: <linux-kernel+bounces-220910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9AB90E90B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 13:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD2D21F22B06
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 11:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92707136E2E;
	Wed, 19 Jun 2024 11:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nS192f2p"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154A075817;
	Wed, 19 Jun 2024 11:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718795504; cv=none; b=n38IyOKJ3oJHjF3O9dm2UL4Qppx9NxanVGgrWDW1XZYkbKDsv0xuppOH0IWFNZEoAIYEeRFJZt+uuilkPJ4fs+NM6RszUAloGUhEwID/aa061WqtMx+BihgpLUjnDYBKWe40fuPhw1aa3i72u3CaipeJDMG096aMtXVSIHAHn6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718795504; c=relaxed/simple;
	bh=Q4p8OGkyZzyrh1giwx6LIVg6Ii/VKLg/MXvccZBGuxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P50JDl5ly5XAzGBV2Y512jdRN6khF1J9weV0J43FY9iVsBaSBqtkz8pF+6kRVu/4wpaVpPUk4X1hkcnYLDDYOY1qqhPNAs2xWo+XA3HjYfjszd7QOecDTqaOfVL5jhIPKNRFKmP4UQ7QDQ8I5wJmZ5QrDkXIzcCAjTImxDTx2HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nS192f2p; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718795503; x=1750331503;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Q4p8OGkyZzyrh1giwx6LIVg6Ii/VKLg/MXvccZBGuxM=;
  b=nS192f2pB2rr8Y19mdkmR3LUk2HjpknqCNtXWssfgmiAlO9vJRtGXV7V
   BIEbZVzGGvw0b92s45K6hhHmreSiKpPp/lmU9AiuYMhC7DtlqIZnckImM
   kVvee0Ky8ebedgVkEaYkcl7zGq62VQ/VNxxxHj1xMnhRR6K7YtWKYgRbm
   h85sAu5ovaVHXsTns84ExLayRXnL4AhwgNjZAhOXN6HZidOppUf1e/pqe
   73zXsFmgD0A1FJSentPsAvGakiLUBkLPsPeTwx8VSjisprMiMn8yLKGAt
   PhMINX/7aB0BjbyfjOZKoQyqAxKpFzt6oNGgGdAw5SJ7l6BXKXaArTFZ+
   g==;
X-CSE-ConnectionGUID: 7ad/JKByTTyhl6QL5G1O6g==
X-CSE-MsgGUID: 74ai+d2NSZiLY7KHHp92gg==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="19509363"
X-IronPort-AV: E=Sophos;i="6.08,250,1712646000"; 
   d="scan'208";a="19509363"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 04:11:42 -0700
X-CSE-ConnectionGUID: Mdk7oiMqRseYyKPfAuwCtg==
X-CSE-MsgGUID: Us5UChcrTv2vW5+bzdDyiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,250,1712646000"; 
   d="scan'208";a="46323943"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmviesa005.fm.intel.com with SMTP; 19 Jun 2024 04:11:39 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 19 Jun 2024 14:11:38 +0300
Date: Wed, 19 Jun 2024 14:11:37 +0300
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
Subject: Re: [PATCH RFC 0/7] usb: typec: ucsi: rework glue driver interface
Message-ID: <ZnK86Zgkr6krdV9C@kuha.fi.intel.com>
References: <20240603-ucsi-rework-interface-v1-0-99a6d544cec8@linaro.org>
 <hgqvyaziumpag5g5ajzupllvpwlz44scma6yu3drmtoqwcwav4@w366suy7c2eo>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <hgqvyaziumpag5g5ajzupllvpwlz44scma6yu3drmtoqwcwav4@w366suy7c2eo>

Hi Dmitry,

On Tue, Jun 18, 2024 at 09:59:07PM +0300, Dmitry Baryshkov wrote:
> On Mon, Jun 03, 2024 at 02:24:53AM GMT, Dmitry Baryshkov wrote:
> > The interface between UCSI and the glue driver is very low-level. It
> > allows reading the UCSI data from any offset (but in reality the UCSI
> > driver reads only VERSION, CCI an MESSAGE_IN data). All event handling
> > is to be done by the glue driver (which already resulted in several
> > similar-but-slightly different implementations). It leaves no place to
> > optimize the write-read-read sequence for the command execution (which
> > might be beneficial for some of the drivers), etc.
> > 
> > The patchseries attempts to restructure the UCSI glue driver interface
> > in order to provide sensible operations instead of a low-level read /
> > write calls.
> > 
> > If this approach is found to be acceptable, I plan to further rework the
> > command interface, moving reading CCI and MESSAGE_IN to the common
> > control code, which should simplify driver's implementation and remove
> > necessity to split quirks between sync_control and read_message_in e.g.
> > as implemented in the ucsi_ccg.c.
> > 
> > Note, the series was tested only on the ucsi_glink platforms. Further
> > testing is appreciated.
> 
> Gracious ping for the reviews / comments. My endgoal is to simplify the
> command submission interface, allowing us to handle odd commands in a
> single function rather than having the code split between sync_write()
> and notification handling.

I don't have any objections. Just rebase these and drop the RFC. The
patch 6/7 did not apply cleanly anymore on top of the two dependencies
you listed.

thanks,

-- 
heikki

