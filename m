Return-Path: <linux-kernel+bounces-399705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B234D9C031C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 12:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E24381C214DC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 11:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A0E1F4280;
	Thu,  7 Nov 2024 11:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J0T0DkCS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBBB13C682;
	Thu,  7 Nov 2024 11:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730977267; cv=none; b=GyuZ1PyPFZ/TL16nQ3Wx2vTJ9RgmZJfEinDI2o29zVKpLLSZQLylXzW4CjGaz/El4pCWVeYsT+g1rod5Jfb0gmPaWxWxptPJgBgCLKqVrdJfZacIFJtKhFg3+E8Fn0oV/q6xSuKZ3aWK4qUv9LRoFyrveqBRMx59AJFZoWqKlJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730977267; c=relaxed/simple;
	bh=AP9twv5RYZlpbx3l/HpgtWHR7rxuR1ZlYteic2PPmY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lX2mOg3QJ8JFN7jJgTY03iOVX6aEeMyGCJUehtzvFNMtv5rDP22Z12ZszX6FFod81p7l/8iX35ZyfFyngAoQTdH0XlG5SWYaHrSJnS1e8AZ3Jt0zgv5C4RC4cq1zMgVA6gJ4vScyK1/+DExFxtEDJU/bnlpqj4LFVIeM4uNIEJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J0T0DkCS; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730977264; x=1762513264;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AP9twv5RYZlpbx3l/HpgtWHR7rxuR1ZlYteic2PPmY0=;
  b=J0T0DkCSUk2ySIaAKe3E42blJuBaFaJ7FnDIg1Bu6PyrKHByPgrNWdU7
   lWacSsBlsmDZn3UVUWEBT4+tZ6Uy2WdQDosTcjtACX8BRX4aPJzZ6+oY1
   rTNrajoWGjx5St7KnxOG+4EeLLmKfPWOeGQ7oAI4d1PYaHDpfaOO8NGlk
   9lESRpUGG8aBxfZytVrgQIZU+T2pXs1U/RfjK67X3lH+VymK0JeXIjDzB
   KJOdsZMJ2Zi6AicW4R4es5kFXe5AYo5GkVU2m1jqK+UWeLFW4UHmpqUTd
   MXS3/fbBqw/5vclJ7h6b984E4v0wn00FmUugCCKc3zzqj85Pwmp7ERHFH
   Q==;
X-CSE-ConnectionGUID: nx5Vd3uORI+xiFt83xEA4w==
X-CSE-MsgGUID: PBoJ4GmnSymak/3Sqj2bIg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30670106"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30670106"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 03:01:03 -0800
X-CSE-ConnectionGUID: wrb2g6stSCWiRZe/WR/sHw==
X-CSE-MsgGUID: p8iajvAlRcK8Z/c5EDICyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,265,1725346800"; 
   d="scan'208";a="90148386"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa004.jf.intel.com with ESMTP; 07 Nov 2024 03:01:02 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 465477FD; Thu, 07 Nov 2024 13:01:00 +0200 (EET)
Date: Thu, 7 Nov 2024 13:01:00 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Philipp Stanner <pstanner@redhat.com>
Cc: Andreas Noever <andreas.noever@gmail.com>,
	Michael Jamet <michael.jamet@intel.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thunderbolt: Replace deprecated PCI functions
Message-ID: <20241107110100.GO275077@black.fi.intel.com>
References: <20241105111132.57339-2-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241105111132.57339-2-pstanner@redhat.com>

Hi Philipp,

On Tue, Nov 05, 2024 at 12:11:33PM +0100, Philipp Stanner wrote:
> pcim_iomap_table() and pcim_request_regions() have been deprecated in
> commit e354bb84a4c1 ("PCI: Deprecate pcim_iomap_table(),
> pcim_iomap_regions_request_all()") and commit d140f80f60358 ("PCI:
> Deprecate pcim_iomap_regions() in favor of pcim_iomap_region()").
> 
> Replace these functions with pcim_iomap_region().
> 
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>

Applied to thunderbolt.git/next, thanks!

