Return-Path: <linux-kernel+bounces-185036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA6C8CAFAD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 15:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC8BA1C22065
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 13:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915AE7EF06;
	Tue, 21 May 2024 13:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aUEChHWN"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FF955783;
	Tue, 21 May 2024 13:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716299562; cv=none; b=NJIxki9VHUIzv42FMnWk65PTamjdz0c0qmc212X8kjojw8yzX5+pVBBTVS+WvYnQYwWPiSx9ddptSXGWoaa7INuBth5eiBYfMxCDU2W4bv5E2SdeTfoGIbEv0dz5XN4N7YGE1mcFsVVgEro5GflnTkyh2JmvQ+ixROsOpm0aI3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716299562; c=relaxed/simple;
	bh=k3vzM2ZPvvj3dFxZRjVEhzFtdv4Z6sdqsTExxgfobCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fdXZaUPS+MJRZT435H6+VoMIDF7nc9r/Mz7Vrk3ADqoN3h6GyPgjALhEUhXfyl0zOJzV+mncQVLNbW+qdy772OrlCpQXsSBCRS7wjNzSElg2x2VFDXzx3wNSxR/qqsYEjTzIT3+ILqhzso+VlyYSDBDAs8ri8AR6A5cymfdS7LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aUEChHWN; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716299561; x=1747835561;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=k3vzM2ZPvvj3dFxZRjVEhzFtdv4Z6sdqsTExxgfobCE=;
  b=aUEChHWNIOwjT7aKZly6LfuDn6xBRiefIwII6nCJAqI9SD7YOoXcqeG8
   ozk9BVlRHFon0Jm5uimK2X7MdC9HvO5BVlFgEEbDu6Pn5CtyhUyLCETdL
   oI+aByepGE/eXpeuDLQQyhU9SxTxy63SrXVNTKE2VTL1HfCqfL6PPgWiC
   Y2HdR95v2HtA75NHwgd7Ym3Vga2vrzomqOHYR+MtpoY85re2TVVk7d4qa
   opSexD6oG7XGJHi2n0kLNl5cRwKd+VxdiIkBZBX5/zzwopiOmZGg/GxlR
   AxmFPX7quWSnnM4+zghhBMPhio8mxEGOziTp9RNK8ChThoenkiz06ZTn+
   w==;
X-CSE-ConnectionGUID: XIEEdlZaSTOt51vrzzMy+Q==
X-CSE-MsgGUID: MrGYEwQST6KaHYZxg9Ggfw==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="23905604"
X-IronPort-AV: E=Sophos;i="6.08,177,1712646000"; 
   d="scan'208";a="23905604"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2024 06:52:40 -0700
X-CSE-ConnectionGUID: l2KgpjeHR3m1UtZGYCQAuw==
X-CSE-MsgGUID: pl8uZ8z8Q+e5W5sioVk/+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,177,1712646000"; 
   d="scan'208";a="56153774"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmviesa002.fm.intel.com with SMTP; 21 May 2024 06:52:37 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 21 May 2024 16:52:36 +0300
Date: Tue, 21 May 2024 16:52:36 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>
Cc: gregkh@linuxfoundation.org, lk@c--e.de, u.kleine-koenig@pengutronix.de,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] usb: typec: ucsi_acpi: Add LG Gram quirk
Message-ID: <ZkynJGchSsg8YQH7@kuha.fi.intel.com>
References: <5qc55gruhn4pmutiukohauki5dehba6n2k22jgvpt7i3hafkon@v2ng2a33o7vv>
 <5fh2v2dcjjcgg3qgvbhlsf24kfigzzbv3sq5ykjuwyjodbqzsa@kf7crcyswm5y>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5fh2v2dcjjcgg3qgvbhlsf24kfigzzbv3sq5ykjuwyjodbqzsa@kf7crcyswm5y>

On Thu, May 09, 2024 at 04:27:41PM +0100, Diogo Ivo wrote:
> On Thu, May 09, 2024 at 12:50:36PM GMT, Diogo Ivo wrote:
> > Some LG Gram laptops report a bogus connector change event after a
> > GET_PDOS command for the partner's source PDOs, which disappears from
> > the CCI after acknowledging the command. However, the subsequent
> > GET_CONNECTOR_STATUS in ucsi_handle_connector_change() still reports
> > this bogus change in bits 5 and 6, leading to the UCSI core re-checking
> > the partner's source PDOs and thus to an infinite loop.
> > 
> > Fix this by adding a quirk that signals when a potentially buggy GET_PDOS
> > command is used, checks the status change report and clears it if it is a
> > bogus event before sending it to the UCSI core.
> > 
> > [Sending as RFC both to see if this is a good idea and so that more
> > users can test it to gather all the models affected by this bug.]
> > 
> > Signed-off-by: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>
> > ---
> 
> I just realized that I should be using the {set, test, clear}_bit()
> functions in the patch I sent, sorry for that. With this in mind it
> would still be good to hear what you think about it.

The quirk looks reasonable to me.

thanks,

-- 
heikki

