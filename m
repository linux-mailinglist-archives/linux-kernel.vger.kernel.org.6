Return-Path: <linux-kernel+bounces-403721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 019149C399A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 09:22:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3815A1C2061F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 08:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3B215DBAE;
	Mon, 11 Nov 2024 08:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FRj5AnFh"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED55B13E02E;
	Mon, 11 Nov 2024 08:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731313349; cv=none; b=gw42BvfTvmUKPRDIl44mQfAbs5Gi+AhM8FIUVHq7C2bTns59Lm/EcfJ++vOiRqUrL/d6u86EKLlMsxiWbU0lx4lgOHCXLtUsg36I+nUifMhsGuWtCXI5FBoTji3ie+1BxkYUpTUtw+9wazJjRSpV3krtwk7nukThjJRBAlg9cBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731313349; c=relaxed/simple;
	bh=ZeS5FDAy33Y1fgENv3rGXF2N71PNFOa6/M3tla6PgPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lTdGWo8ky/+Q729cK0Vlw8ugHempf3lE8dmsuC8rwKQCJYi+//MNZ7iAxTOsCDgi44cbbGkwR/KBGa/BU/FGV5f6F8Nw53XXOQTwnRQufwklPRM9J0Rqy2ojeI6XSsvzqBhquBXcB3sNj2vMWDr7EhrkvHSq6zGbz/Nan/6/Yuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FRj5AnFh; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731313348; x=1762849348;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZeS5FDAy33Y1fgENv3rGXF2N71PNFOa6/M3tla6PgPc=;
  b=FRj5AnFhn5MV6UbELJbPyoRrL7FIBElgEYy55vf3qvraosVSwTYZAGCn
   ePLj21+uP7fGgjHSR6NSZaw8lmp+OvifnaPuB2ibzyhrvJk82CxpZuAyf
   /ZIFMaDa1AmnH9Qi8kSq59LUZgiIXvHWWuRkeNDbDvrC3gxc+DTj/1JDs
   syhzSGxk5ROYw3g7/KvHfH6o4GI0LU71IZES69gL9BYfCRVQiuQsgZkuI
   1iaRZjK1PmGhcQQziB5rGVX2J6fH3sl+hiJYzJ3YzvLBFHKnuySpHW8hW
   cQrC15amr+jLxsR6rHv1ensREm9h0LOxw9IEmweu1npMWEz0qP0MekGH6
   g==;
X-CSE-ConnectionGUID: Gen74E88ReiG3EQnFi8HuA==
X-CSE-MsgGUID: fphF9OllQfiGZFdbmhFXFQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11252"; a="41725082"
X-IronPort-AV: E=Sophos;i="6.12,144,1728975600"; 
   d="scan'208";a="41725082"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2024 00:22:27 -0800
X-CSE-ConnectionGUID: UywAEPtrQzepja8ojdagUw==
X-CSE-MsgGUID: OMy91UvUSqW18zPoeJ6qSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,144,1728975600"; 
   d="scan'208";a="91889528"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa004.jf.intel.com with ESMTP; 11 Nov 2024 00:22:26 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 0C559193; Mon, 11 Nov 2024 10:22:23 +0200 (EET)
Date: Mon, 11 Nov 2024 10:22:23 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Aaron Rainbolt <arainbolt@kfocus.org>
Cc: YehezkelShB@gmail.com, michael.jamet@intel.com,
	andreas.noever@gmail.com, linux-usb@vger.kernel.org,
	mmikowski@kfocus.org, linux-kernel@vger.kernel.org,
	Gil Fine <gil.fine@linux.intel.com>
Subject: Re: USB-C DisplayPort display failing to stay active with Intel
 Barlow Ridge USB4 controller, power-management related issue?
Message-ID: <20241111082223.GP275077@black.fi.intel.com>
References: <20241023174413.451710ea@kf-ir16>
 <20241024154341.GK275077@black.fi.intel.com>
 <20241031095542.587e8aa6@kf-ir16>
 <20241101072155.GW275077@black.fi.intel.com>
 <20241101181334.25724aff@kf-ir16>
 <20241104060159.GY275077@black.fi.intel.com>
 <20241105141627.5e5199b3@kf-ir16>
 <20241106060635.GJ275077@black.fi.intel.com>
 <20241106110134.1871a7f6@kf-ir16>
 <20241107094543.GL275077@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241107094543.GL275077@black.fi.intel.com>

Hi,

On Thu, Nov 07, 2024 at 11:45:44AM +0200, Mika Westerberg wrote:
> Hi,
> 
> On Wed, Nov 06, 2024 at 11:01:34AM -0600, Aaron Rainbolt wrote:
> > > Unfortunately that does not help here. I need to figure something else
> > > how to detect the redrive case with this firmware but first, does this
> > > work in Windows? I mean if you install Windows to this same system
> > > does it work as expected?
> > 
> > It does work as expected under Windows 11, with one major caveat. We
> > used a Windows 11 ISO with a setup.exe created on April 05 2023 for
> > installing the test system, and after initial installation it behaved
> > exactly the same way as Linux behaves now (displays going blank soon
> > after being plugged in). However, after installing all available
> > Windows updates, the issue resolved, and the displays worked exactly as
> > intended (the screens are recognized when attached and do not end up
> > disconnecting after a timeout).
> > 
> > Would it be helpful to test on Windows 11, and provide a report and
> > system logs?
> 
> Unfortunately, I don't know anything about Windows ;-)
> 
> However, I asked our Thunderbolt hardware/firmware team about this, if
> they have any idea how it was solved in Windows side. Might take a
> couple of days though.

While waiting for this, I wonder if you guys could do one more
experiment? I would like to get the traces what is happening there
(hoping something pops out there). Following steps:

  1. Download and install tbtools [1].
  2. Build and install the kernel with my "redrive" patch.
  3. Boot the system up, nothing connected.
  4. Wait until the Barlow Ridge is in runtime suspend (so wait for
     ~30s or so)
  5. Enable tracing:

    # tbtrace enable

  6. Plug in USB-C monitor to the USB-C port of the Barlow Ridge. Do not
     run 'lspci -k'. Expectation here is that there is no picture on
     the monitor (in other words the issue reproduces).

  7. Stop tracing and take full dump:

    # tbtrace disable
    # tbtrace dump -vv > trace.out

  8. Send trace.out along with full dmesg to me.

Thanks!

[1] https://github.com/intel/tbtools

