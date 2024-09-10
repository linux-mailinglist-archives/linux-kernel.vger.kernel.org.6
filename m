Return-Path: <linux-kernel+bounces-323404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3FA9973CDB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 18:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0396A1C21436
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 16:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77BE199FD6;
	Tue, 10 Sep 2024 16:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HlRwcI7y"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C526F2FD
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 16:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725984110; cv=none; b=Gowg37MUuOnvc+OA7stu55EyRL74tfvRLUsXWAuDY8kGSv1v0BbJMuLCNHZhflZpjnEpPXcEYTcWeGTM6gcJpLmDpAiLxYdGmDWGQFpZFCnXgiBTVgRsIHMloa/bKMLJdMJnQv3LTGuRVQJmGJzlcsThR91lXnYSeyGhw/26pas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725984110; c=relaxed/simple;
	bh=MQgPafDHjLHaX5gKO9KL1IlRjgS9muJNkIylVhQgN5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gN3PccaQ5/b10QXAq6Tk2lXN8jwMCdZG6iUK+NzmV9jKvuHJEbQzHmmT4dhE0M/Q1+tFq7GXVHbqatl2HNnhasOa8CR0BOeNLhFFPY4/JEgmUuD1CycsMSTcKQIZuF7czZHftNOlfbC1SDkRDKd3K1+CzkhqDFfAPee5tp450P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HlRwcI7y; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725984108; x=1757520108;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MQgPafDHjLHaX5gKO9KL1IlRjgS9muJNkIylVhQgN5I=;
  b=HlRwcI7yw1YKZbvzgX1Tj0eZMmyZh+Y0bpZkwTsLxliEor5ksbM0Hhu8
   nXQLmkM8h40vxqvhFmEDn9nqXDc/u/+sF4LOBP/BvSSqd61yOA5ShWYCc
   yadIhI3/mW4wxgwa29Yl1vUss4tjAl/bazGFAwPBeFHNmv8PhaG8VRgeB
   jKY5ZX9a7o5k+frOiyD+0mMhFR9Q8bUpcmUp8gGW9SqkV1W3Rj/ZQ29Qa
   DpRgtQkoyLhuPAZQADKA3rxwtfH/WM4doiHbiVhSxrZvxx7lKmbRjIvQm
   r8bmeV8NMTH6BwrCOFEq9YESaIqTR5MGfIL8/xlwlAyaGSsA19MmXu0cm
   Q==;
X-CSE-ConnectionGUID: D2CznBlHSQe+tsMTYR3m4g==
X-CSE-MsgGUID: Zu9GcBmdTw2La/4XI99E5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="35409395"
X-IronPort-AV: E=Sophos;i="6.10,217,1719903600"; 
   d="scan'208";a="35409395"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 09:01:48 -0700
X-CSE-ConnectionGUID: BUvuTxknQXeTFlj1hWLUJQ==
X-CSE-MsgGUID: VXRhtHmDSM2DsFvkPdW7LA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,217,1719903600"; 
   d="scan'208";a="97898098"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 09:01:45 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1so3JG-00000007Fbm-2XJr;
	Tue, 10 Sep 2024 19:01:42 +0300
Date: Tue, 10 Sep 2024 19:01:42 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Waiman Long <longman@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will.deacon@arm.com>,
	Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Subject: Re: [PATCH] locking/rwsem: Move is_rwsem_reader_owned() and
 rwsem_owner() under CONFIG_DEBUG_RWSEMS
Message-ID: <ZuBtZuK9mJCwdvO1@smile.fi.intel.com>
References: <20240909182905.161156-1-longman@redhat.com>
 <ZuAAOmjTGYEFQJPC@smile.fi.intel.com>
 <ZuAAbi7hRWz2DUte@smile.fi.intel.com>
 <5142d007-dc8b-4eea-b708-4ec2df08f90a@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5142d007-dc8b-4eea-b708-4ec2df08f90a@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Sep 10, 2024 at 11:47:17AM -0400, Waiman Long wrote:
> On 9/10/24 04:16, Andy Shevchenko wrote:
> > On Tue, Sep 10, 2024 at 11:15:54AM +0300, Andy Shevchenko wrote:
> > > On Mon, Sep 09, 2024 at 02:29:05PM -0400, Waiman Long wrote:
> > > > Both is_rwsem_reader_owned() and rwsem_owner() are currently only used when
> > > > CONFIG_DEBUG_RWSEMS is defined. This causes a compilation error with clang
> > > > when `make W=1` and CONFIG_WERROR=y:
> > > > 
> > > > kernel/locking/rwsem.c:187:20: error: unused function 'is_rwsem_reader_owned' [-Werror,-Wunused-function]
> > > >    187 | static inline bool is_rwsem_reader_owned(struct rw_semaphore *sem)
> > > >        |                    ^~~~~~~~~~~~~~~~~~~~~
> > > > kernel/locking/rwsem.c:271:35: error: unused function 'rwsem_owner' [-Werror,-Wunused-function]
> > > >    271 | static inline struct task_struct *rwsem_owner(struct rw_semaphore *sem)
> > > >        |                                   ^~~~~~~~~~~
> > > > 
> > > > Fix this by moving these two functions under the CONFIG_DEBUG_RWSEMS define.
> > > At least this solves my issue,
> > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ...and
> > 
> > Tested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Thanks for the testing.
> 
> No functional change is intended for this patch. Ingo & Peter, can this
> patch lands in v6.12 or has to wait until v6.13?

I see it already in PeterZ's tree.

-- 
With Best Regards,
Andy Shevchenko



