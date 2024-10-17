Return-Path: <linux-kernel+bounces-370343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 620829A2B4D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 19:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27689282290
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 17:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8F41E04A1;
	Thu, 17 Oct 2024 17:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PRrChvAg"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60401DFE12
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 17:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729187021; cv=none; b=t4xARfn/uROdyfFQJunMwqWmswttZdsMVPR32xtgIVjnSECAPUkCUfvFOsZTcN3/9dDcWBos9d3pp5KhngsrR5mCbxEESTLkSjq1PN3e7qZX+xaCxQ6JSpxJkTBkdXNZKous+g4No4Mf4E/3iL/dhspEjX9mVEEKcUr3HBIeQsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729187021; c=relaxed/simple;
	bh=Ds0AuIbX7AIBOJQAXl1K2AY1bYf7KiGCn7QICt60v18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LynF3suv+joQgcuqS20HEiKoZoDuttFBmddEBDFazkDs1gw2NUZmwAg3zM8NgY7PQ5poNyUYDyz5i+3tAYRrk7uixjFV1QXnyheBkJL5q+XNWkwk3f42P2WgSl+drtxgZPXTMZU0EYhAsyn/JLKKaDdVmB6lM9pTKglbRearv4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PRrChvAg; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729187017; x=1760723017;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ds0AuIbX7AIBOJQAXl1K2AY1bYf7KiGCn7QICt60v18=;
  b=PRrChvAgurvgb+yxqhCNqQnGi1nlAtgOCyweHF585Xhs7mkRogQAYzOJ
   L5d5JY8FjGdyOUSQQC/kdJa/ObEqx55/xDoeY5mkD9FSNb5Dj5eV/WqRc
   zPsK+V3LB02+cPnXBzPqVbqC3YV9A2Q/MK/3hI8iQnaTLfLq3yiwnDByw
   lJVUiaPQeGhES9FScERLTp0BmymN2slSk17XpAbQD8Ui3nF1VOf5NVKd8
   Jhq6rZZM9k0ptyCFrlUkpfEKvew2ADwrDKXPKbgNcIVkBIL1Ak3NYZ9FY
   qJ6Ww580ki3Out/IRA9TquaZeOpVIBp7zPMnbZa8YbToWMa8vfHEgUAdW
   Q==;
X-CSE-ConnectionGUID: jmn6yoauRZSHRr2JSa6eGg==
X-CSE-MsgGUID: zAJX+b8ORqm4bHGBQG8wag==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="32488013"
X-IronPort-AV: E=Sophos;i="6.11,211,1725346800"; 
   d="scan'208";a="32488013"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 10:43:36 -0700
X-CSE-ConnectionGUID: puFAUWHZQzCxmo0JWvXn5g==
X-CSE-MsgGUID: brwTc6nlRS6wZy458Z99yA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,211,1725346800"; 
   d="scan'208";a="109438650"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 10:43:36 -0700
Date: Thu, 17 Oct 2024 10:43:34 -0700
From: Tony Luck <tony.luck@intel.com>
To: James Morse <james.morse@arm.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	H Peter Anvin <hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
	shameerali.kolothum.thodi@huawei.com,
	D Scott Phillips OS <scott@os.amperecomputing.com>,
	carl@os.amperecomputing.com, lcherian@marvell.com,
	bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
	baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
	Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
	dfustini@baylibre.com, amitsinght@marvell.com,
	David Hildenbrand <david@redhat.com>,
	Rex Nie <rex.nie@jaguarmicro.com>,
	Dave Martin <dave.martin@arm.com>
Subject: Re: [PATCH v5 00/40] x86/resctrl: Move the resctrl filesystem code
 to /fs/resctrl
Message-ID: <ZxFMxkYJk14N1k3G@agluck-desk3.sc.intel.com>
References: <20241004180347.19985-1-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004180347.19985-1-james.morse@arm.com>

Summary of my comments:

0002 - fragile, but simple fix
0004 - drop the helper function, or add NULL check?
0007 - needs rebase against tip x86/cache
0011 - fix commit comment
0020 - already in tip x86/cache, drop from series
0030 - Use new RESCTRL_MAX_CLOSID to replace hard coded constant
0038 - duplicate #include

So nothing major.

Reviewed-by: Tony Luck <tony.luck@intel.com>

-Tony


