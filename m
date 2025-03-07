Return-Path: <linux-kernel+bounces-551603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81FA7A56E6C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 17:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC5FE16FDB9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA8623C8CF;
	Fri,  7 Mar 2025 16:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nU1aQ7bV"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED6219259A
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 16:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741366658; cv=none; b=cMhV85L4PFsCpC/7UXApyhSNbq9+ok0G8vjnCE0kUxjhPaONy37pZnfIYEMDqAYBFGAM9tEm18VVRUewTxssDJdKsRXkxg9KqkqJaIL/73js1LuWnz8btnMRUlBGgElRALXCVL1NvjK/Htp5UWEtUyqeMXq0e+k5ANbReLkNPp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741366658; c=relaxed/simple;
	bh=BGLOGn+4aiNsAFgfYy3zckEN7R7BsUWxqWTQAZlo/40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m3+EGi+Dvtlzw3K/PoqolDTRctX2TOJiN+JYqahH12l2GxPo4LD1GYWevUocETtlwnyZzS9WQh5G4I2ROxIjN12c7Uygh7Cg5nL4EK+7d4S9d3NuxtHkpUyqSNPVpBIGiKRfmcJNAIxxiFiUItFGmuZLqL+QK5GgDavx7M9es9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nU1aQ7bV; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741366657; x=1772902657;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BGLOGn+4aiNsAFgfYy3zckEN7R7BsUWxqWTQAZlo/40=;
  b=nU1aQ7bVMRPlFCo3jmOvjpPF5ioyvgpkQS+lZxKfAcYuAgs/cC8sL030
   BU0aZXzzUJgLpijkD17k8CLmby3z7giAG58Oh/f5APrpMP3B+vt4XAZmQ
   1URr7Vq2KtONeJj7BoC56UX9vyRUfzt4XbTuwElYVjd/OHz3WCDWcbOn6
   IYrSTLnTV9CwBtFSpZmkBrnzFlLzHtPVeYmI+KsTVz3zuiAAK98mc3J6l
   IxgQML6f4sU5IG/HEJ7bOLi1YNdg7D+WQtBdAGWZJd/ZJNyBzqqXB8bcn
   fjYSk1FJwv52l3oz9o/bnGUZ7uw0xNXJZBPrSSzx2UWEaqIMToxZ3+xKe
   g==;
X-CSE-ConnectionGUID: yuHrjdYdSf+RKFpdEmCFyA==
X-CSE-MsgGUID: nK4mHUrxSd61JpIMnf4vNw==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="53062227"
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="53062227"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 08:57:36 -0800
X-CSE-ConnectionGUID: WNC8zyOWR0OOu4lqyyLBkA==
X-CSE-MsgGUID: lTN/LPSoQuK5g18Hq0Hngg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="120284298"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 08:57:34 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tqb0t-00000000Sq0-3tdI;
	Fri, 07 Mar 2025 18:57:31 +0200
Date: Fri, 7 Mar 2025 18:57:31 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, Willy Tarreau <willy@haproxy.com>,
	Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
Subject: Re: [PATCH v1 1/7] auxdisplay: charlcd: Partially revert "Move
 hwidth and bwidth to struct hd44780_common"
Message-ID: <Z8slexKyo7VFkSKW@smile.fi.intel.com>
References: <20250224173010.219024-1-andriy.shevchenko@linux.intel.com>
 <20250224173010.219024-2-andriy.shevchenko@linux.intel.com>
 <CAMuHMdWBGb5AXv8Ch3XhPPHc0CVYHf31tx1Feh87OU5MDUCdPQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWBGb5AXv8Ch3XhPPHc0CVYHf31tx1Feh87OU5MDUCdPQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Mar 07, 2025 at 10:03:31AM +0100, Geert Uytterhoeven wrote:
> Hi Andy,
> On Mon, 24 Feb 2025 at 18:30, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > The commit 2545c1c948a6 ("auxdisplay: Move hwidth and bwidth to struct
> 
> s/The commit/Commit/

Why? We know that we are talking about the very specific commit.

My English is not native I would appreciate a link to a material to study
the case you pointed out.

> > hd44780_common") makes charlcd_alloc() argument-less effectively dropping
> > the single allocation for the struct charlcd_priv object along with
> > the driver specific one. Restore that behaviour here.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Thanks!

-- 
With Best Regards,
Andy Shevchenko



