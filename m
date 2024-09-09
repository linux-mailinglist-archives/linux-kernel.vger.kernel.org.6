Return-Path: <linux-kernel+bounces-322151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4DA9724DD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 00:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EC862849D7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 22:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BC518CC09;
	Mon,  9 Sep 2024 22:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j4iGNMnK"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CA818CBFE
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 22:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725919245; cv=none; b=cK92fzWlewbhyWIDZvk8n2kmdj8cXQTr5DdC+9K7V81J9R3erjzWYeefuxxYEDkiamR9R88vlHjw1iudIgyxCKeIjBySqEM9JKU3B+7Hd0hXKJ/xf/GjROociceWTaJUV7ixZHdZPnjeY1Fn1ViV+50fdugvNIvPU/MkxV+nf+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725919245; c=relaxed/simple;
	bh=jFmE10NY4nDymrGpFrGQLkUzdd+T1rpk9Y87FgAuX+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l7QKc77tTvw/W3rDVOxSh22/+gWlmbt4yZr8F6lVDOKzp2541o9A8QEknVeKEh1v3KBNy/rPE8bcwHy3XtDH8xNqQOd1VhvSV9odrTQmVq37cItwuZwAhk/pkq1ShKNdy0kDeqUKVOn/WE5HND2Ie2ETs2di8F1bvZaZ4WmVBX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j4iGNMnK; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725919243; x=1757455243;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jFmE10NY4nDymrGpFrGQLkUzdd+T1rpk9Y87FgAuX+s=;
  b=j4iGNMnKf8yy8LEeNXjHj+U9GI6iTxacfmAnmFHFdGd2vA5dHp/PvkZY
   kh3+ITN+UMv6sNg42qG4Olwqxrq922CIoqnIDW3Hzo3p/HFY+gi1ByhMO
   uySSfC1C1TedpYsgFYRj/VLtOZGNDPr5r1VdLfYb4hFwNlGfTNeZ375/f
   TtqubxyRsIUde1TasWTzJGkCzVJReN4xfV+TCAr7w5PUuCq1slnjlfeOL
   XTxrY+w1B8sIikFO0tyblIXQ8mvnetgH7La3Mw8m4wZWJ0xQnfX1ojeE8
   +pOpXQpSk9IIE/1C17hziF5CIsr/EIVNIJpFf31hEZHd3A3tg84b91+O1
   A==;
X-CSE-ConnectionGUID: G3aaWBM+RACN6Vd5AcoQQQ==
X-CSE-MsgGUID: BMoBiT/bTqat94xLQS0BNg==
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="35782913"
X-IronPort-AV: E=Sophos;i="6.10,215,1719903600"; 
   d="scan'208";a="35782913"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 15:00:43 -0700
X-CSE-ConnectionGUID: KLMWswB7TcqzyMgx7C4r1A==
X-CSE-MsgGUID: 8fgWyY/8SfqIz3JMXboCbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,215,1719903600"; 
   d="scan'208";a="71603008"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa003.jf.intel.com with ESMTP; 09 Sep 2024 15:00:41 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id F3E831AC; Tue, 10 Sep 2024 01:00:39 +0300 (EEST)
Date: Tue, 10 Sep 2024 01:00:39 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, David Hildenbrand <david@redhat.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] mm/page: Drop has_unaccepted_memory() helper
Message-ID: <3inyypayz63x3zktypqdgzrcsrwoetub4y66r4dleoz2lscmws@ocfmmnc2q5f5>
References: <20240909081930.748708-1-kirill.shutemov@linux.intel.com>
 <20240909122558.aa726d312d8b166a515dd751@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909122558.aa726d312d8b166a515dd751@linux-foundation.org>

On Mon, Sep 09, 2024 at 12:25:58PM -0700, Andrew Morton wrote:
> On Mon,  9 Sep 2024 11:19:30 +0300 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com> wrote:
> 
> > has_unaccepted_memory() has the only caller -- cond_accept_memory().
> > 
> > Remove the helper and check zones_with_unaccepted_pages directly in
> > cond_accept_memory().
> > 
> > It also fixes warning with clang 18 when kernel is compiled without
> > unaccepted memory support:
> > 
> >  mm/page_alloc.c:7043:20: error: unused function 'has_unaccepted_memory' [-Werror,-Wunused-function]
> > 
> 
> Thanks, mm-unstable has a similar fix:

Works for me.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

