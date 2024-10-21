Return-Path: <linux-kernel+bounces-374048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8AF9A6120
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 12:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 640741C2298E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 10:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB071E7679;
	Mon, 21 Oct 2024 10:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mPUN/Z/s"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A9E1E47AE;
	Mon, 21 Oct 2024 10:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729504972; cv=none; b=NIQhH8DczDmymFTdZE7HZez+4M63Cmm7GXhGg6jcIEnp1dtfnPZKCbJ85B8B1ABeRi6kO6qixPTnJGXSny3VyrQoE3+OqlHVDQB2Z8VKxhjKuW1IAzYzU+APY6JdFJ+cfd7rmZ74ugeUfQyRc24O2WW2gaoHPG8Wt4RZ80FLuIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729504972; c=relaxed/simple;
	bh=8OdnFqJrs1jelRCPSzIphGcvaOUyL7W11I0nCB/0Bgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xlb083mFUb4EC1euHtqB5eaHxq99qdGLDx1I3UfQPZyn03ycJFecxdQMs4Zg8aIKgUtXqNOp1W3cwDBjKNHLCfpCbTexMDIFN3jfCu+curMy/L07QP2I8O7XgEHAcN/RREhZphdjXvSEQlVWzuIXRpI5RDKj5RxjHPPwvwMbO7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mPUN/Z/s; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729504970; x=1761040970;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=8OdnFqJrs1jelRCPSzIphGcvaOUyL7W11I0nCB/0Bgw=;
  b=mPUN/Z/salLV9lBuIQ5h/8gN2uc1nAt2GvWmvuDePG+2iXnA4Dfg9Vkh
   nwIkozlmEqAxBRv4emQObA5Oi4EtHymhNsIoQCwUqWrbvv1EyoEuB97Jj
   8PMliLOxHpZ9rVKq+4jcyiHfWGT/q5Zb/Kbqe3nJFsOowl/duwTxLuEyi
   /el5NY3RiroCStrRvu/+V0+gw0cNytp+oZUucPjzWbNx5NWD8w2r2l1ov
   BY0xdR7IrB3aVvCTC0wYwOi290fJuoHrvDibX/Vax3D2ED0i088GWOb8b
   LgjyEj/JDKf71XNHQMkAzqNcjaZJQn7sp5pJ+u1VIk79W8J4iTzX/c8Wy
   Q==;
X-CSE-ConnectionGUID: M01ywfhdTcuh2yuOGPYUoA==
X-CSE-MsgGUID: pjheyuMtTn6nj1Y1IvWMew==
X-IronPort-AV: E=McAfee;i="6700,10204,11231"; a="39569484"
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="39569484"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 03:02:49 -0700
X-CSE-ConnectionGUID: 6hdzjYeFQ+KT0loKfr+xkw==
X-CSE-MsgGUID: 9Fel2LIsRpGXt9ywve/yEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="79432821"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 03:02:47 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t2pFN-00000005SK6-08XE;
	Mon, 21 Oct 2024 13:02:45 +0300
Date: Mon, 21 Oct 2024 13:02:44 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	platform-driver-x86@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>, Ferry Toth <fntoth@gmail.com>
Subject: Re: [PATCH v2 1/3] platform/x86: intel_scu_ipc: Replace workaround
 by 32-bit IO
Message-ID: <ZxYmxOPLOGol22gz@smile.fi.intel.com>
References: <20241021084053.2443545-1-andriy.shevchenko@linux.intel.com>
 <20241021084053.2443545-2-andriy.shevchenko@linux.intel.com>
 <2708af18-da90-4021-bd1b-b0491b737d6b@linux.intel.com>
 <ZxYgZGYTzINm2lpz@smile.fi.intel.com>
 <d40d824e-1827-4030-794c-a7c7e15137e6@linux.intel.com>
 <ZxYkyC00pDzarnVU@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZxYkyC00pDzarnVU@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Oct 21, 2024 at 12:54:16PM +0300, Andy Shevchenko wrote:
> On Mon, Oct 21, 2024 at 12:49:08PM +0300, Ilpo Järvinen wrote:
> > On Mon, 21 Oct 2024, Andy Shevchenko wrote:
> > > On Mon, Oct 21, 2024 at 12:24:57PM +0300, Ilpo Järvinen wrote:
> > > > On Mon, 21 Oct 2024, Andy Shevchenko wrote:

...

> > > > > +		for (nc = 0, offset = 0; nc < 4; nc++, offset += 4)
> > > > > +			wbuf[nc] = ipc_data_readl(scu, offset);
> > > > > +		memcpy(data, wbuf, count);
> > > > 
> > > > So do we actually need to read more than
> > > > DIV_ROUND_UP(min(count, 16U), sizeof(u32))? Because that's the approach 
> > > > used in intel_scu_ipc_dev_command_with_size() which you referred to.
> > > 
> > > I'm not sure I follow. We do IO for whole (16-bytes) buffer, but return only
> > > asked _bytes_ to the user.
> > 
> > So always reading 16 bytes is not part of the old workaround? Because it 
> > has a "lets read enough" feel.
> 
> Ah, now I got it! Yes, we may reduce the reads to just needed ones.
> The idea is that we always have to perform 32-bit reads independently
> on the amount of data we want.

Oh, looking at the code (*) it seems they are really messed up in the original
with bytes vs. 32-bit words! Since the above has been tested, let me put this
on TODO list to clarify this mess and run with another testing.

Sounds good to you?

*) the mythical comment about max 5 items for 20-byte buffer is worrying and
now I know why,

-- 
With Best Regards,
Andy Shevchenko



