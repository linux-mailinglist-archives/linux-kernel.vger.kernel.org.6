Return-Path: <linux-kernel+bounces-373985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D90AF9A6038
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 11:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13A101C20A18
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 09:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844FF1E3DD6;
	Mon, 21 Oct 2024 09:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VmkhrYi9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0529E192D69;
	Mon, 21 Oct 2024 09:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729503338; cv=none; b=YNEQ6SYLfbUubiNr4CDpNHjxJ7CfNP57HBlbbh/0Wnqz8Y1rgTfn6whXl38q/WiG/Ogop4E12g8xxt+ju0O62rBDcpN4LZokb5++IBJCZm/tupU9Ra0ueLjrmcdLH4iWsyJBXBdYz4XSIgNsi0E7/ReSucUc/VMiqQ47W1dHXwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729503338; c=relaxed/simple;
	bh=CmfmX/OlWgODNrVM0cSIY8L+Ta+eZHdD6TiroiEav/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uujAqbL9VxJ71jH0wxgS0p+fjJGuAJOmtnXuKyCMb+F+5vtb5hf1RB1HGmWWXNKsyuXlhyUSmWTwNuGBqE0DM4BAgDd6V6k9uoWZukHeMieJTRFLjxLB3g87x79eCQCEpj8NYvSJe6gkIjq4RNPmJQd+d+q5FtOrv94jsjB/sTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VmkhrYi9; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729503337; x=1761039337;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=CmfmX/OlWgODNrVM0cSIY8L+Ta+eZHdD6TiroiEav/k=;
  b=VmkhrYi9HZEpqXETtojoY86buoHfNP/55OV7x9dXHtkzz3Uoermmrnd6
   WQluSlL3UYaFGNeG4aG0M4XD5KcUes3zPIjZvp4YlSkxWak1ihc8YfcEK
   OMnw5wtrjvO9lGfuB09yE8id24PmCusyqUOEJe7A6YVSwb+dIItBJ2lBh
   3mAI6S8RnUWqTCaje5dGTCQtHctZKG4b2A3SwQ9CtXfJlaEvuLI++myCb
   Sr0aORmVi4DUnxlFmlRzybt6S3yMK/F6HjNS5l0Mic3GsBL/fqa7loZ+8
   4gKns8hVO1QHwgs7hnIfh4CqCsOQukQlL8Tac1UIb6MsnqC/d+sbUWdzX
   Q==;
X-CSE-ConnectionGUID: KPCiCgPRT+abax1uD4NCag==
X-CSE-MsgGUID: o0vvVvyARhilCiA9663wfg==
X-IronPort-AV: E=McAfee;i="6700,10204,11231"; a="39600065"
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="39600065"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 02:35:37 -0700
X-CSE-ConnectionGUID: imbTtBNZS/mmpOiNR7MBFQ==
X-CSE-MsgGUID: nYjZ3tG2RWGPgR0jeNQZ3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="110236155"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 02:35:35 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t2op2-00000005Rr2-2ePf;
	Mon, 21 Oct 2024 12:35:32 +0300
Date: Mon, 21 Oct 2024 12:35:32 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	platform-driver-x86@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>, Ferry Toth <fntoth@gmail.com>
Subject: Re: [PATCH v2 1/3] platform/x86: intel_scu_ipc: Replace workaround
 by 32-bit IO
Message-ID: <ZxYgZGYTzINm2lpz@smile.fi.intel.com>
References: <20241021084053.2443545-1-andriy.shevchenko@linux.intel.com>
 <20241021084053.2443545-2-andriy.shevchenko@linux.intel.com>
 <2708af18-da90-4021-bd1b-b0491b737d6b@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2708af18-da90-4021-bd1b-b0491b737d6b@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Oct 21, 2024 at 12:24:57PM +0300, Ilpo Järvinen wrote:
> On Mon, 21 Oct 2024, Andy Shevchenko wrote:
> 
> > The theory is that the so called workaround in pwr_reg_rdwr() is
> > the actual reader of the data in 32-bit chunks. For some reason
> > the 8-bit IO won't fail after that. Replace the workaround by using
> > 32-bit IO explicitly and then memcpy() as much data as was requested
> > by the user. The same approach is already in use in
> > intel_scu_ipc_dev_command_with_size().

...

> >  	err = intel_scu_ipc_check_status(scu);
> > -	if (!err && id == IPC_CMD_PCNTRL_R) { /* Read rbuf */
> > -		/* Workaround: values are read as 0 without memcpy_fromio */
> > -		memcpy_fromio(cbuf, scu->ipc_base + 0x90, 16);
> > -		for (nc = 0; nc < count; nc++)
> > -			data[nc] = ipc_data_readb(scu, nc);
> > +	if (!err) { /* Read rbuf */
> 
> What is the reason for the removal of that id check? This seems a clear 
> logic change but why? And if you remove want to remove that check, what 
> that comment then means?

Let me split this to a separate change with better explanation then.

> > +		for (nc = 0, offset = 0; nc < 4; nc++, offset += 4)
> > +			wbuf[nc] = ipc_data_readl(scu, offset);
> > +		memcpy(data, wbuf, count);
> 
> So do we actually need to read more than
> DIV_ROUND_UP(min(count, 16U), sizeof(u32))? Because that's the approach 
> used in intel_scu_ipc_dev_command_with_size() which you referred to.

I'm not sure I follow. We do IO for whole (16-bytes) buffer, but return only
asked _bytes_ to the user.

> >  	}
> >  	mutex_unlock(&ipclock);
> >  	return err;
> 
> FYI (unrelated to this patch), there seems to be some open-coded 
> FIELD_PREP()s in pwr_reg_rdwr(), some of which is common code between 
> those if branches too.

This code is quite old and full of tricks that has to be tested. So, yes
while it's possible to convert, I would like to do it in a small (baby)
steps. This series is already quite intrusive from this perspective :-)

-- 
With Best Regards,
Andy Shevchenko



