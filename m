Return-Path: <linux-kernel+bounces-545237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86116A4EA9C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 19:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0966C189BAD9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8E22BD5B5;
	Tue,  4 Mar 2025 17:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dDE5aWOV"
Received: from beeline1.cc.itu.edu.tr (beeline1.cc.itu.edu.tr [160.75.25.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3C8259CA4
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 17:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741110064; cv=pass; b=dkmIvL6h39QFpteuYlIJWWlD2MjiEbABj8zv1+03ddgTBk6J9t28GeK9Va4pEDbsMHJWB0qWKNnwlqXeaJEnlhs80a5lxvakp46GazbpHEd3M/FoP8Kne7AJoUdLfJpgkMJT8MzubaFKBgYyF55o3xB41ZdDIOFBN3wFEdT1HW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741110064; c=relaxed/simple;
	bh=tX6xycVlm0hqQ9h8iORXLZHUyLwbVdP+cXKqAOJS+II=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lad+tDmJXzEr+IPwGx4kTGKpcipzBv1SCWzYB9bUcJ6OSoexDD2BWqUP57k6Bj7/D4ru6njNaelksxF4pXTtzhMIv4WMLi3l13TBivtH+gHexJyn5kT1aqgD4kmXE7VzTq2YjRCnHAZ5KOVTN6D/muVyKb3221OlXMX4O5jKg+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dDE5aWOV; arc=none smtp.client-ip=198.175.65.14; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; arc=pass smtp.client-ip=160.75.25.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline1.cc.itu.edu.tr (Postfix) with ESMTPS id C3D83408B665
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 20:41:01 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6hDk3Z2gzG3pL
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 19:37:42 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 2D6F342741; Tue,  4 Mar 2025 19:37:38 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dDE5aWOV
X-Envelope-From: <linux-kernel+bounces-541559-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dDE5aWOV
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id E330641E86
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:31:41 +0300 (+03)
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by fgw2.itu.edu.tr (Postfix) with SMTP id 78D612DCDE
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:31:31 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8213880984
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0C31F4CA7;
	Mon,  3 Mar 2025 11:18:52 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84421F17E5
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 11:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741000729; cv=none; b=EkYSkgN5POzuMlm+2s5i3uSHvm1sAFwHv+BqljFABQbS4VydY/jgSS3/8HbmHyEq41LxO00dXiqMI2XK1FQAyhpd7yr/Q4yzksQKUDRArhhdeHYNlRoitYm4bcuuNtHjb9AizlumkwXasSIQdjWljWBL958X5S0UnElGpIwqMmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741000729; c=relaxed/simple;
	bh=tX6xycVlm0hqQ9h8iORXLZHUyLwbVdP+cXKqAOJS+II=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=olpIAXtMqTvvvZisEb3lWUxoCcg87y5Yd0ixKJy8D7YP1hk00aRlMAdSTmquDUmBHtw2utFEo8UxTL871PQYLpRcwOcwDPZHVy8J/6FqeSjVr7Id4Vf8JYRKTthGDdjf472505r9hKaNmSpgHCZVhyjQbHIWRdLIH6CuGwB4Kdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dDE5aWOV; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741000727; x=1772536727;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tX6xycVlm0hqQ9h8iORXLZHUyLwbVdP+cXKqAOJS+II=;
  b=dDE5aWOVK7PySZrusfImDRRPN4eDpGqSt34y7YEH0r+FnCWCSMuQLBPC
   0fpEjhpVGZtdER83mpFRORb0G6kHQdORnuKQVr7TKkhWtCesyFCd2LnUd
   x5OT3S7izW5dRhTZke8BdKHxQFV8TrrK4a+KWpjtAp9r05GUSq3WyObfy
   1a0kQPnxUzqlXJ+hEHaDBcWxXD1Pl4oHfVBfFoR1IfsDzaglKR1GzteuW
   o85R+6lC1kS8gvdBqPUgdWjyrKLSFuMxRAle+VDCaszmSGJCSze1nFZFH
   XanDNvee5uVMgnVxvXF7okZUu9bkGNVwmF+7mh+2j9LrDXg68ZwBiFU51
   w==;
X-CSE-ConnectionGUID: owYxW47QRMebILrYE/p3Bg==
X-CSE-MsgGUID: JOtlfLnHQBeEgel6pUKBGA==
X-IronPort-AV: E=McAfee;i="6700,10204,11361"; a="45644550"
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; 
   d="scan'208";a="45644550"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 03:18:47 -0800
X-CSE-ConnectionGUID: S5aCuh0sQ0q2PF8VTniF7g==
X-CSE-MsgGUID: 0oCy3AfKT9+VTH5NApmTuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; 
   d="scan'208";a="122978491"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa004.jf.intel.com with ESMTP; 03 Mar 2025 03:18:45 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id A550B125; Mon, 03 Mar 2025 13:18:42 +0200 (EET)
Date: Mon, 3 Mar 2025 13:18:42 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Johannes Weiner <hannes@cmpxchg.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Cc: kernel test robot <lkp@intel.com>,
	Brendan Jackman <jackmanb@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Oscar Salvador <osalvador@suse.de>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: Add lockdep assertion for pageblock type
 change
Message-ID: <Z8WQEpv7BNtDDoH3@black.fi.intel.com>
References: <20250227-pageblock-lockdep-v1-1-3701efb331bb@google.com>
 <202503010129.rJvGqZN1-lkp@intel.com>
 <20250228182804.GB120597@cmpxchg.org>
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228182804.GB120597@cmpxchg.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6hDk3Z2gzG3pL
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741714749.49436@WcbHTD+ZHkkGjO197dVv3g
X-ITU-MailScanner-SpamCheck: not spam

On Fri, Feb 28, 2025 at 01:28:04PM -0500, Johannes Weiner wrote:
> On Sat, Mar 01, 2025 at 01:31:30AM +0800, kernel test robot wrote:

> The patch is missing a dummy in_mem_hotplug() in the
> !CONFIG_MEMORY_HOTPLUG section of <linux/memory_hotplug.h>.

+1, I just stumbled over and this is not fixed in today's Linux Next. I'm
wondering how this was missed during merge into Linux Next. Stephen?

-- 
With Best Regards,
Andy Shevchenko




