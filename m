Return-Path: <linux-kernel+bounces-374023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0CC9A60BC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 11:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 734E4284914
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 09:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3531E47A1;
	Mon, 21 Oct 2024 09:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cQEFE862"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F47D1E3776;
	Mon, 21 Oct 2024 09:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729504463; cv=none; b=uejceOx1Jp/6NJfQKcZEQR6hD9u1Nh8lMmIv5673yzkfLc27F0SKfivkeUJw1H8SVQQ4V+TTmixGkatiM5Ztu+6HeIBHK6xi/SrcUuqaPqIXeKlmBUqg+nIvhLK0ssCmMQO/5Zc8XDdCkl3FjHVu5mTtFeCyMLDxdVpf6HTUyio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729504463; c=relaxed/simple;
	bh=wcviCQ9r8niYEkQiSDiTF/TFcR4LffIr93w4PDGYR+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VVRnWO5LyeTtYS45GeueaQyAcqgdsCp5yxxFL609wDdF9RUIzSHRIiQbZerTn+DSvlpd3eJxuAhmRhfWhIpKMvGP9D61uTP72eFvTVZKBfj2iHrkcRVxWFJssqoOTOYzEtrzAeJOBAFDASnx1qHX9qt/51mci8OOnvcs0pYTnEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cQEFE862; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729504462; x=1761040462;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=wcviCQ9r8niYEkQiSDiTF/TFcR4LffIr93w4PDGYR+A=;
  b=cQEFE8625EryygqNirveDbNSltQEVYy7lTo1fZtke9KXk4g3R847aGjv
   5vVgBkKBLIT9OoxIGquCl9h7PxEng+OIcERrZdme9BZXDBK/QacHjDzg0
   RBH0YJTeHlxPCxl4/uId5iRHPYoVIr5o7XLVi9T8iAtrW+VKW12l6sL71
   Vxa12Z0Zx5rRs19epm+bP13l3snSPEmfMhHoYpJH0Y3FYz9hgInVZ7j0L
   f0lpnY3qR6Hhslay+GuOp+ZnQXPUgdIflcBqdm8iJLoE3GtWxCC1zfWOQ
   ytno91DSxO6L/wcb+NQdMVoRhQOhdg8hd8RH2V8Sv57jBrxUTyQWJNHdh
   Q==;
X-CSE-ConnectionGUID: 4REUzPddQX2g7S8eiWrR7w==
X-CSE-MsgGUID: oxUDKtNES3qFDEpG6dAtRw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28758287"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28758287"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 02:54:21 -0700
X-CSE-ConnectionGUID: 1UHauq+tTd6Xr4n1reRQDg==
X-CSE-MsgGUID: RgQqIdyHR3u1g3V6mXFmnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="79117739"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 02:54:19 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t2p7A-00000005SAV-47H6;
	Mon, 21 Oct 2024 12:54:16 +0300
Date: Mon, 21 Oct 2024 12:54:16 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	platform-driver-x86@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>, Ferry Toth <fntoth@gmail.com>
Subject: Re: [PATCH v2 1/3] platform/x86: intel_scu_ipc: Replace workaround
 by 32-bit IO
Message-ID: <ZxYkyC00pDzarnVU@smile.fi.intel.com>
References: <20241021084053.2443545-1-andriy.shevchenko@linux.intel.com>
 <20241021084053.2443545-2-andriy.shevchenko@linux.intel.com>
 <2708af18-da90-4021-bd1b-b0491b737d6b@linux.intel.com>
 <ZxYgZGYTzINm2lpz@smile.fi.intel.com>
 <d40d824e-1827-4030-794c-a7c7e15137e6@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d40d824e-1827-4030-794c-a7c7e15137e6@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Oct 21, 2024 at 12:49:08PM +0300, Ilpo Järvinen wrote:
> On Mon, 21 Oct 2024, Andy Shevchenko wrote:
> > On Mon, Oct 21, 2024 at 12:24:57PM +0300, Ilpo Järvinen wrote:
> > > On Mon, 21 Oct 2024, Andy Shevchenko wrote:

...

> > > > +		for (nc = 0, offset = 0; nc < 4; nc++, offset += 4)
> > > > +			wbuf[nc] = ipc_data_readl(scu, offset);
> > > > +		memcpy(data, wbuf, count);
> > > 
> > > So do we actually need to read more than
> > > DIV_ROUND_UP(min(count, 16U), sizeof(u32))? Because that's the approach 
> > > used in intel_scu_ipc_dev_command_with_size() which you referred to.
> > 
> > I'm not sure I follow. We do IO for whole (16-bytes) buffer, but return only
> > asked _bytes_ to the user.
> 
> So always reading 16 bytes is not part of the old workaround? Because it 
> has a "lets read enough" feel.

Ah, now I got it! Yes, we may reduce the reads to just needed ones.
The idea is that we always have to perform 32-bit reads independently
on the amount of data we want.

> > > >  	}
> > > >  	mutex_unlock(&ipclock);
> > > >  	return err;
> > > 
> > > FYI (unrelated to this patch), there seems to be some open-coded 
> > > FIELD_PREP()s in pwr_reg_rdwr(), some of which is common code between 
> > > those if branches too.
> > 
> > This code is quite old and full of tricks that has to be tested. So, yes
> > while it's possible to convert, I would like to do it in a small (baby)
> > steps. This series is already quite intrusive from this perspective :-)
> 
> Yeah, no pressure, I just noted down what I saw. :-)

Thanks, I will keep this.

-- 
With Best Regards,
Andy Shevchenko



