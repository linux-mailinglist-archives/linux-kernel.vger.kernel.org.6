Return-Path: <linux-kernel+bounces-553703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA742A58DC4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 09:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B5727A4755
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 08:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82DA223323;
	Mon, 10 Mar 2025 08:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gnMyOg5F"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A495B223321
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 08:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741594479; cv=none; b=X8N9gwwr83KzqYvW858Gy+WcznXoxvrI4L4nnJH+8zJ/xxPIvOhuSK7eQCHkklbcQAj+Gik8vo+ytLwGYuvBVmuAjfR4MgVAy4+J08n8VxvzYUxwK3OmO4hgb+vwlg+auvC6YZdMdXQifSKUGqZGit4Xz4qarbJD+HROLYqvVIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741594479; c=relaxed/simple;
	bh=1GLcW142vfbtiwd4XjUCx0graaVe8sjtJUcrPfiJzQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mLduD1n7wfzHBWvAiFm6On/WOM8hocRKJou7+bN6H+0LjbJm+Kh4JRQeVvekL/35RyFpMldOT1kj4DAABNJYIzhIeF87WvwkQQTjb7yBJneJCQ+kw2+wSbV8IX8gG2nLqJuy+IFsFIEIZX9/GP1Su35cS8P1acGyua+f/F8RZVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gnMyOg5F; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741594478; x=1773130478;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1GLcW142vfbtiwd4XjUCx0graaVe8sjtJUcrPfiJzQQ=;
  b=gnMyOg5FvePLOf8JPuSRxkRRqrZxfNol6eCSPvPPxZLvpENGR2I9/Unx
   O8rEzlXD5/0ep1u4bmiDfazfEUTpvn3AOG18YgiyCn7S+p4vMV3FdbVO2
   7mjTW5vEbIECBquucfT7fRZl+0AD1ujccff4mQj/3vg2LbUNMeULSg2G2
   2ZiBkCM2PECivK2olRBaLw//Sej34Jrs8q8lVIoMmersMn3N4Z8EeSeBh
   kbSbahOkhHejje9Y5zW1YS40v/1QhG7sYoe+nHNEAJN6mDD/iyauhskxG
   OYXYGP1zRkZ7KelAoTIV1GD7o5aKar7R15eQ/1dkHJ8It2Brw15+vpaw5
   Q==;
X-CSE-ConnectionGUID: 8ecSq5J4RsyWFVMrk1Mlxw==
X-CSE-MsgGUID: NWwZSVtlQcee3/HJ30fbPw==
X-IronPort-AV: E=McAfee;i="6700,10204,11368"; a="42289398"
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="42289398"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 01:14:37 -0700
X-CSE-ConnectionGUID: b4bn/W5GTRKD1MclTUdGwA==
X-CSE-MsgGUID: HE4AsaDqTXGfHQPboKzAdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="143132816"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 01:14:36 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1trYHR-00000001Bit-1Gi8;
	Mon, 10 Mar 2025 10:14:33 +0200
Date: Mon, 10 Mar 2025 10:14:33 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, Willy Tarreau <willy@haproxy.com>,
	Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
Subject: Re: [PATCH v1 6/7] auxdisplay: hd44780: Call charlcd_alloc() from
 hd44780_common_alloc()
Message-ID: <Z86faZJpfYyJ1jYq@smile.fi.intel.com>
References: <20250224173010.219024-1-andriy.shevchenko@linux.intel.com>
 <20250224173010.219024-7-andriy.shevchenko@linux.intel.com>
 <CAMuHMdXP1=7YJzYp=_WJsqx2mtBYcwAjpOGK2_9SH+r4w6v2Ug@mail.gmail.com>
 <Z8soDV0U2LG2KX9J@smile.fi.intel.com>
 <CAMuHMdV1+ftjpEcg4xYjBLH1BRJHkZcYB5W+p8WUWWLXT3DnUQ@mail.gmail.com>
 <Z8tCbjJk24ryV0DJ@smile.fi.intel.com>
 <CAMuHMdU3KKSFhN8hD_ZoyNfBUV4ZWa5=zxUPfmpivjmVhW8__Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdU3KKSFhN8hD_ZoyNfBUV4ZWa5=zxUPfmpivjmVhW8__Q@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Mar 07, 2025 at 08:06:37PM +0100, Geert Uytterhoeven wrote:
> On Fri, 7 Mar 2025 at 20:01, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Fri, Mar 07, 2025 at 07:19:57PM +0100, Geert Uytterhoeven wrote:
> > > On Fri, 7 Mar 2025 at 18:08, Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Fri, Mar 07, 2025 at 10:14:48AM +0100, Geert Uytterhoeven wrote:
> > > > > On Mon, 24 Feb 2025 at 18:30, Andy Shevchenko
> > > > > <andriy.shevchenko@linux.intel.com> wrote:

...

> > > > > While I like the general idea, there are two things in the API I do
> > > > > not like:
> > > > >   1. The function is called "hd44780_common_alloc()", but returns
> > > > >      a pointer to a different struct type than the name suggests,
> > > > >   2. The real "struct hd44780_common" must be obtained by the caller
> > > > >      from charlcd.drvdata, which is of type "void *", i.e. unsafe.
> > > > >
> > > > > What about changing it to e.g.?
> > > > >
> > > > >     struct hd44780_common *hd44780_common_alloc(struct charlcd **lcd)
> > > > >
> > > > > so you can return pointers to both structs?
> > > >
> > > > I don't like this prototype as it seems and feels confusing. Also note,
> > > > the APIs are using struct charlcd while being in the hd44780 namespace.
> > > > perhaps better to rename the function to hd44780_common_and_lcd_alloc()?
> > >
> > > That is one option.
> > >
> > > Another option would be to add a "charlcd *lcd" member to
> > > struct hd44780_common.
> > >
> > > That would allow to fix the other odd part in the API:
> > >
> > >     -void hd44780_common_free(struct charlcd *lcd)
> > >     +void hd44780_common_free(struct hd4480_common *hd)
> >
> > This I like better. In a separate patch I think?
> 
> Fine for me...

Thanks, I will check what can I do, but currently it's not
a high priority to me.

-- 
With Best Regards,
Andy Shevchenko



