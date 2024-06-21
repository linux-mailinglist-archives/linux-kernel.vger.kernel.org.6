Return-Path: <linux-kernel+bounces-224947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8679128FB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 17:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56A95288CAF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 15:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26CA754FB5;
	Fri, 21 Jun 2024 15:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V9crWYyg"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8302D60C
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 15:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718982546; cv=none; b=KfaaVCP0gc0SDBQUxn0cvCVU4Ozj7DnWCLTt7g446BAydx+2XkLyJdM1GgH8ssp4a4QdzbSNm7NHgK11d7CU4Upgc81gsmN88dm/JGYUprNq/DHvdkc+etgmkylHw7Bo7Pg+uwaVo7HbW81Lrv3qlPVQEw+0gOYIj5RjenL8PmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718982546; c=relaxed/simple;
	bh=1Ym4N4OTEcvKa9VGmSUR7VmYCKVaZFoFDh4ahOMB1/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A5FE5Zu89Fd+KcP6g40qgQvtIDbwd+npldQR6xlN5Uw6QeTbSgBHQd+4SUHrrCf6AtQuty4psee0IRdNbJH5yxM1VulMjDDP73IoZ2u1SctCFn04FC3QnA9kSHRNq1zMZMBSG3mztWIhxx618TpyrtIRunVkZ4PJMbhoiwID0HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V9crWYyg; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718982545; x=1750518545;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1Ym4N4OTEcvKa9VGmSUR7VmYCKVaZFoFDh4ahOMB1/U=;
  b=V9crWYygyoFvcpBQUMp7QdCCbFO6XeXtR4lP8OwXV5XaioLSxVjlgXo2
   lS9xcXHaXV3s5q6gPA1mBKaV1/I5T3pjxekdFWyWNlp3RsBIbx5kVKSEZ
   KBTL5XAfTMEgjbIwouehd65HnebRz7tTHElaZD1ECjONZ4jhhdyQpo71p
   jnX4y9LOWl+46gv66g5XCbH7/TXJqosjyiZEJcqEfw1r3UnMydpXIPmUR
   cwHY/9mZg/NlS8ftxwpRi09LrHEor5h+16j4iQyVpaedbX+fS/hWXSRfq
   sm+RDIPqbXiSr07ps2aKctQVfX54QUNOKCo2lqkfnWjPwKCHgLflgY7Hh
   Q==;
X-CSE-ConnectionGUID: ljaX5NH9SwWoHMDiCfcRYw==
X-CSE-MsgGUID: 6NmyVV9FQNGLwTrLalrSRg==
X-IronPort-AV: E=McAfee;i="6700,10204,11110"; a="16165397"
X-IronPort-AV: E=Sophos;i="6.08,255,1712646000"; 
   d="scan'208";a="16165397"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2024 08:09:04 -0700
X-CSE-ConnectionGUID: YbU7dMI6RI+u4QDHK8umag==
X-CSE-MsgGUID: ZklpEeAzTBiJdOjc2iQKEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,255,1712646000"; 
   d="scan'208";a="46976933"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa003.fm.intel.com with ESMTP; 21 Jun 2024 08:09:02 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 9E8421D6; Fri, 21 Jun 2024 18:09:00 +0300 (EEST)
Date: Fri, 21 Jun 2024 18:09:00 +0300
From: "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
To: Alexander Potapenko <glider@google.com>
Cc: elver@google.com, dvyukov@google.com, dave.hansen@linux.intel.com, 
	peterz@infradead.org, akpm@linux-foundation.org, x86@kernel.org, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
Subject: Re: [PATCH 3/3] x86/traps: fix an objtool warning in handle_bug()
Message-ID: <l3fpuot4mubvhlr2zmioc7rzz3akk2fafptfdwmcmwphyisan7@7mojjgo5ovae>
References: <20240621094901.1360454-1-glider@google.com>
 <20240621094901.1360454-3-glider@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621094901.1360454-3-glider@google.com>

On Fri, Jun 21, 2024 at 11:49:01AM +0200, Alexander Potapenko wrote:
> Because handle_bug() is a noinstr function, call to
> kmsan_unpoison_entry_regs() should be happening within the
> instrumentation_begin()/instrumentation_end() region.
> 
> Fortunately, the same noinstr annotation lets us dereference @regs
> in handle_bug() without unpoisoning them, so we don't have to move the
> `is_valid_bugaddr(regs->ip)` check below instrumentation_begin().

Imperative mood, please. And capitalize "fix" in the subject.

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/tree/Documentation/process/maintainer-tip.rst#n134
> 
> Reported-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Link: https://groups.google.com/g/kasan-dev/c/ZBiGzZL36-I/m/WtNuKqP9EQAJ
> Signed-off-by: Alexander Potapenko <glider@google.com>

Otherwise, looks good.

Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

