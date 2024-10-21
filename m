Return-Path: <linux-kernel+bounces-373928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B80D49A5F1F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 10:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 749AD28189C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 08:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC4B1E1C2F;
	Mon, 21 Oct 2024 08:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fCkh2FU4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2C91C36;
	Mon, 21 Oct 2024 08:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729500585; cv=none; b=Tf4JVNjkjIWdgHNUkMmmAKtXiYtE7Vc9V83s+xJJtfJhqWl2fOI62lsx7XB265qpNsw+1Yue+mJVMW7VLGf7+UTReoyGAhAgfrFA3log9brG0uBx9IMtEFSWW9EbDC7kPonVk/ukjFALwo0EQMtVts7ZJyz1UmVq+K/G2jiwzlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729500585; c=relaxed/simple;
	bh=5IpIJsIrRiiv9BTTjqU2cxSkoRQDK5CzDyOpvPp16T8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NsUpFnYc0zYhgQ0VW+loZ6T+JVeSsDwwSLTgTgn7Pi+ItU37BVUKezF4uNqx2B1DD28tGXV2451Sy6OS709TlCW/n43oLkJyNFjkUcdverHpmRQxqGjDsYVnsuVund1T2EXX+NaoB5hWQKJE0tsf/57gEP2QOUxTUKH0jlq0NDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fCkh2FU4; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729500585; x=1761036585;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5IpIJsIrRiiv9BTTjqU2cxSkoRQDK5CzDyOpvPp16T8=;
  b=fCkh2FU4gMIosAXiXU43BB9869JZGMy6m0rlYjJKZnr6LdP5+EXB2jtU
   Zj5EDP+GN/LXGJlGNgIv7bK8VuoBWtSgnO6T+FCFjBHZbqEincyXpLATb
   iZJpx1GMnw++ZvfKISSYoe7GLjebhIXhVfx/Cc1Z1oXZwwECI54QEv0FX
   AUNippRyjiUWnzNFgJvfFoNEGdnAgnfCsY38rJkzR6Om/eKVadCdCIn8c
   LYhjXYZWAsBPAsFE1g+KRmpJso0FhOPJNgRdVQ0zw1lldITdDZip465to
   /+Eg1M0MO1PmS7Py1SoxIMYEHxmHWcfa4VI5QXwe4NQ82LEIfYyX5UJr/
   g==;
X-CSE-ConnectionGUID: Z54EJttvSX2nLC/cpfWUbg==
X-CSE-MsgGUID: dIxEEs3bRyeDX7UcIH6XKQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11231"; a="32779569"
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="32779569"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 01:49:44 -0700
X-CSE-ConnectionGUID: msJ6+U/YQ2aZwWyG1X9j/w==
X-CSE-MsgGUID: hvCH0GkBTPSgsZEuqMVhxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="79810954"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa010.fm.intel.com with ESMTP; 21 Oct 2024 01:49:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id CCFD412B; Mon, 21 Oct 2024 11:49:40 +0300 (EEST)
Date: Mon, 21 Oct 2024 11:49:40 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
	Andy Shevchenko <andy@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Ferry Toth <fntoth@gmail.com>
Subject: Re: [PATCH v2 1/3] platform/x86: intel_scu_ipc: Replace workaround
 by 32-bit IO
Message-ID: <20241021084940.GA275077@black.fi.intel.com>
References: <20241021084053.2443545-1-andriy.shevchenko@linux.intel.com>
 <20241021084053.2443545-2-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241021084053.2443545-2-andriy.shevchenko@linux.intel.com>

On Mon, Oct 21, 2024 at 11:38:51AM +0300, Andy Shevchenko wrote:
> The theory is that the so called workaround in pwr_reg_rdwr() is
> the actual reader of the data in 32-bit chunks. For some reason
> the 8-bit IO won't fail after that. Replace the workaround by using
> 32-bit IO explicitly and then memcpy() as much data as was requested
> by the user. The same approach is already in use in
> intel_scu_ipc_dev_command_with_size().
> 
> Tested-by: Ferry Toth <fntoth@gmail.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

