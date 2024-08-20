Return-Path: <linux-kernel+bounces-293837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3995695858E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 13:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE3631F24DED
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 11:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3243818A95D;
	Tue, 20 Aug 2024 11:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MCe3+yNn"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443484963C
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 11:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724152546; cv=none; b=Ygw7hmOm0HOaKH431bJZMdmNgutWnrF1gBTTZKvTbqToiqb+Qz5ywHaQ2DcLHs++SBF7F3BpmZTL5K6p4Fn+oEfPmoICkk7d+kV9OkYO58Nnr/AqTRMFGKDd3mYMMJv8ffVyDhxS3pORSxkkPJkEdNv8dQYYZUYq0YmxLTsSXvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724152546; c=relaxed/simple;
	bh=oo+LPlstNx1XmSbdBKgl9rTzfmwSa7MIHwn71UM1RQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tu3naFEzvLGNHdHOOL4aB7bs8QfVfWJLBqpiNYtaOxUiXJpdtAahR1TY3HlJLvhcziPSBauY0db8Sdw8ZRmTPYDGiXDLuEtRQ85VZgOzXNscip+nfDaCnS/9gmhqNxvUvPrfG0WInJ+6XSgeilE6uc2pFcYPnvUh76pq8sLvyF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MCe3+yNn; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724152545; x=1755688545;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oo+LPlstNx1XmSbdBKgl9rTzfmwSa7MIHwn71UM1RQs=;
  b=MCe3+yNnGJXsmmeuwb5rYuMvo0lrysKzbUPi7cWXxhfOgnVW30Gb4MQU
   jb02r/YuhrN4AW/YAnT+y62yvJo+0co9JNz5f7dNzndhVqWuYkREOVKVR
   tmK+KfJxvIixwW3kMS/9nTc31+Bx9rktXfjbJsp7WcQSAa6PJPDKvD+oT
   QVOo/YuvDXIWdBURmMb9ksTOddHhsSVYGQSnEQolDKERDdM3PFWlMAMpb
   BGyrxOe0an/MtoYtn/CXTnH7Hg7NZANl011acyplYniEsedwcvDZKXohG
   KWkj4VvQk6u4zxhUzzaw5eNKKJHjKxDQ9gB85hJ3it52ayAfUbxX8jY9m
   Q==;
X-CSE-ConnectionGUID: Q6RliCBLS5uCciGRxuVVtA==
X-CSE-MsgGUID: cUOwef2uQ/qeGYNwgSgz3Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="47838602"
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="47838602"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 04:15:34 -0700
X-CSE-ConnectionGUID: zvvhrIbsTQO3XCw3GxMEag==
X-CSE-MsgGUID: wVI1b9m9TcuP6XwLThELGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="60354625"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa006.fm.intel.com with ESMTP; 20 Aug 2024 04:15:32 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 9A5BD3C0; Tue, 20 Aug 2024 14:15:30 +0300 (EEST)
Date: Tue, 20 Aug 2024 14:15:30 +0300
From: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
To: "Huang, Kai" <kai.huang@intel.com>
Cc: "Hansen, Dave" <dave.hansen@intel.com>, "bp@alien8.de" <bp@alien8.de>, 
	"x86@kernel.org" <x86@kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, 
	"hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>, 
	"tglx@linutronix.de" <tglx@linutronix.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"nik.borisov@suse.com" <nik.borisov@suse.com>
Subject: Re: [PATCH 1/2] x86/kexec: Fix a comment of swap_pages() assembly
Message-ID: <agqteql33qjf4cnun2ex6y7xulxo6yb4r3bx43rpobqs6hatqp@rbfam4g2nws5>
References: <cover.1724068916.git.kai.huang@intel.com>
 <d4538576fc5eeab2e4f3ea4c5111dc9597369ed4.1724068916.git.kai.huang@intel.com>
 <q2y5vte3wwn5qde5p4nfmjfqtzxfen3nhjdyafc7nbirfidpvr@ro3djjz3pub4>
 <4c35dfdadff667ae5ea00dd6002b8cd73301dc22.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c35dfdadff667ae5ea00dd6002b8cd73301dc22.camel@intel.com>

On Tue, Aug 20, 2024 at 10:32:39AM +0000, Huang, Kai wrote:
> But the two commits were introduced at 2004 and 2006, so I don't think it
> worth any Fixes tag?

Nah. It is a comment after all.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

