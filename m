Return-Path: <linux-kernel+bounces-410685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C949A9CDFBF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 14:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 744A31F22A6C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 13:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94FF41BDA99;
	Fri, 15 Nov 2024 13:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F6688M8P"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD021B6CE0;
	Fri, 15 Nov 2024 13:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731676828; cv=none; b=F1wq+XqFqdPERptfrgKc19u1ttRLc1MEDi4XnnblBLcEWC58Cm61l9MWWFXVZ/S1huH6B9nKFm9vOQGCQU59+NywrOtTi7xs/iuCMMBfpSnG4fSRWoBNikTgwolz/EFpwLrDBRpaYmVH3Ps8KYS4nEXIfoDGUG8WFVzlfywSqFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731676828; c=relaxed/simple;
	bh=yf7P02xXc+t+WHLkR7S0ClWLGsb9txjkaH84YbGF9qE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b8fU+5qLnUn99awxEgc6M7aou0dKOYG6x2GskxKKB+3omOC05qAklIe1W1KGEoLcrvE7n5ICInuS2ZeFuwEy5TKBAVT8vrUK674O4GU8jY2Y5bbuqbfqtLrLLVVStD8y3m5PIPb7H8dbsOej4cf4OV5+N2uHCazON7jVtet90n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F6688M8P; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731676827; x=1763212827;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yf7P02xXc+t+WHLkR7S0ClWLGsb9txjkaH84YbGF9qE=;
  b=F6688M8Pk/SxG/8sFgbkfY3bJ0oE8W1uhorxX+wMqNTvN3yzAQI5Zx+C
   Bzv9Q1SQnaaE948XmUJ9FsGbffr5AhaTAcbupYpjRxmDAjH2SANRazMeo
   IN73FBjlj1zv40IeEfPzeMDlbFoZ8AeBPZXa7EfpBrUJnFOmy3Swiae8U
   GPUfz6xduZOnGUPGeGFCY0/+AVj7IjHdCvOPnziVD5w8Ae0dyI3MbG7Yn
   QvKxIJo8Muvbr4+7mB3c/GRpCEqoPJbqOH0bWrXUC/8+ySEydV8vS6TJy
   8ls0QKKK1njW4K9VpZn+ePc5zmSiVWcRu2Ni6ZK22vMj8dJUmL+YJljjC
   w==;
X-CSE-ConnectionGUID: gLfG3+TjRZKbc2g1n+jMkw==
X-CSE-MsgGUID: 74Xwg5BwRGaJsQzWTqnD+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11257"; a="49111956"
X-IronPort-AV: E=Sophos;i="6.12,156,1728975600"; 
   d="scan'208";a="49111956"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2024 05:20:26 -0800
X-CSE-ConnectionGUID: 19XebeG+Qomow2q91W89bA==
X-CSE-MsgGUID: sGd9UwUFT5+GQxc+lwfgRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,156,1728975600"; 
   d="scan'208";a="88971640"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa009.fm.intel.com with ESMTP; 15 Nov 2024 05:20:23 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 8BC0A1AC; Fri, 15 Nov 2024 15:20:22 +0200 (EET)
Date: Fri, 15 Nov 2024 15:20:22 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Aaron Rainbolt <arainbolt@kfocus.org>
Cc: YehezkelShB@gmail.com, michael.jamet@intel.com,
	andreas.noever@gmail.com, linux-usb@vger.kernel.org,
	mmikowski@kfocus.org, linux-kernel@vger.kernel.org,
	Gil Fine <gil.fine@linux.intel.com>
Subject: Re: USB-C DisplayPort display failing to stay active with Intel
 Barlow Ridge USB4 controller, power-management related issue?
Message-ID: <20241115132022.GC3187799@black.fi.intel.com>
References: <20241101181334.25724aff@kf-ir16>
 <20241104060159.GY275077@black.fi.intel.com>
 <20241105141627.5e5199b3@kf-ir16>
 <20241106060635.GJ275077@black.fi.intel.com>
 <20241106110134.1871a7f6@kf-ir16>
 <20241107094543.GL275077@black.fi.intel.com>
 <20241111082223.GP275077@black.fi.intel.com>
 <20241112164447.4d81dc3a@kfocus.org>
 <20241114115136.GB3187799@black.fi.intel.com>
 <20241114104125.00a02eb1@kf-ir16>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241114104125.00a02eb1@kf-ir16>

Hi,

On Thu, Nov 14, 2024 at 10:41:25AM -0600, Aaron Rainbolt wrote:
> This is production hardware (specifically Clevo's X370SNW1-G and
> X370SNV1-G laptops), available for purchase from Sager, XOTICPC,
> Schenker, likely many other resellers, and our own website
> at https://kfocus.org/spec/spec-m2.html (with a tool that allows users
> to work around the bug). The firmware is baked into the hardware
> provided to us by our ODM, and for the sake of stability we do not
> modify any firmware on the machines with the exception of applying BIOS
> updates provided to us directly by the ODM. They appear to get
> their firmware directly from Clevo.

Okay thanks.

> We have requested an updated BIOS from the ODM. If one is available, we
> will upgrade and run the tests again.

Yes, I hope you can get the firmwares. The one you have now is not
"production quality" firmare so you should not really have that there in
the first place and Clevo should definitely provide you an upgrade. Note
this is separate from the BIOS. But your BIOS has issue too regarding
the USB4 power contract that is required by Microsoft so I would expect
that you should get that one upgraded too.

The patch I shared earlier should deal with all the other cases except
that weird one where we do not seem to get unplugs (and the resource is
available) which is not how the firmware is expected to work. I was
planning to submit it upstream after some more validation on our end,
probably afer v6.13-rc1 is released. I'll CC you.

If/when you get the new firmare I would definitely appreciate if your
folks could give it a try.

