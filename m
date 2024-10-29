Return-Path: <linux-kernel+bounces-386499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A819B4432
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 09:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94D671F23739
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 08:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9012A2038BC;
	Tue, 29 Oct 2024 08:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ah9IM8hX"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A4D202F77
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 08:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730190396; cv=none; b=NpQ5nV2OMuPBMdkNSUL4vTn7vC6T+PQgh1Ya9Iqnc45xaPxZw8owzosK+p8VAmGA6JPSLzYtN5agv74RbqnHb3IvTOW7l7zLpRHW74zFH+1haJLj7MroMCwTXNjlga3dyQ44KKAt9N05ZY2JArCj3khip4S/WWU+Y//AQIWfggE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730190396; c=relaxed/simple;
	bh=8uk0FVvE9pWJWA6iF2yhYrwIfONO6RygQeZr5dGB1SQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C36QcfNKwWUaxIO87m/9XdLGLu4UClxxZJwGW534hA1+QD1jbqToPESS9pebnO5ffVC6PcxwENv1og6wWGngTkWFFPdsTD/53LDjFx+/kMDEo3sp4WkQoYVNQ6wZyzgw/AMgXBptTsOV5h6hBiRT0znBb/wMg4MSrG1GCPkE5+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ah9IM8hX; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730190394; x=1761726394;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8uk0FVvE9pWJWA6iF2yhYrwIfONO6RygQeZr5dGB1SQ=;
  b=Ah9IM8hXu7kp+kkWmBXJsKCZe8qu2z2uPvFVvyAUQLpgY+WM/aVU+7x3
   WvMFbsEGbGkpE0XMcKSWaardVdD53GUU7kR38CAPw2ZN93b6gqxETGxnu
   tJhJfT3CojETT/hE9kLz5NZ7UzqWQkjkM7zW+GzmdUGRwqaRDw+oxxkN+
   oSZDpn+L/ZS3riZA6J9IG2yx4AEkaA2GaHbqpZxqelCBUPS0LyoXTJAN8
   T2TdmUWEbe21p+enpRN0tOmzYfCNHSxv8ST03ci+tPMf8bT4dHeCkVaLf
   XilxVBTse+ma2NbCa1fUdLt2djELumEqmK2nzziG3zxOE835kqPys0a0r
   A==;
X-CSE-ConnectionGUID: 4soGqq1eRTi21JVixAei3A==
X-CSE-MsgGUID: T9U0qbXmQJ+PiZpZma3dpw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="40352582"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="40352582"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 01:26:34 -0700
X-CSE-ConnectionGUID: 8TWyuDX6TeymalCmN9JWDg==
X-CSE-MsgGUID: rAoUfCGcT7G4Po3zj+ZP5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="81449563"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.56])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 01:26:29 -0700
Date: Tue, 29 Oct 2024 10:26:25 +0200
From: Tony Lindgren <tony.lindgren@linux.intel.com>
To: Chris Down <chris@chrisdown.name>
Cc: Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>, kernel-team@fb.com
Subject: Re: [PATCH v6 07/11] printk: Constrain hardware-addressed console
 checks to name position
Message-ID: <ZyCcMSJ0OZJL1x0x@tlindgre-MOBL1>
References: <cover.1730133890.git.chris@chrisdown.name>
 <507dee05e622cc37418b23e5de96b6b449410414.1730133890.git.chris@chrisdown.name>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <507dee05e622cc37418b23e5de96b6b449410414.1730133890.git.chris@chrisdown.name>

On Mon, Oct 28, 2024 at 04:45:48PM +0000, Chris Down wrote:
> Commit 7640f1a44eba ("printk: Add
> match_devname_and_update_preferred_console()") adds support for
> DEVNAME:n:n style console= registration. It determines whether or not
> this is a hardware-addressed console by looking at whether the console=
> string has a colon in it. However, this interferes with loglevel:n and
> potentially other future named options, which also make use of the
> character.
> 
> In order to avoid this, only search positions before options.

Looks good to me:

Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>

