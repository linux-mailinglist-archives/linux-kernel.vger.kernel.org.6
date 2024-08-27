Return-Path: <linux-kernel+bounces-303436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6DE960C0B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 15:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B10771C231E2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 13:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499F51BF334;
	Tue, 27 Aug 2024 13:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ut06LWvQ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224D71B3F2B;
	Tue, 27 Aug 2024 13:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724765383; cv=none; b=sSom1mc/Ft9NsD7/H0QenrCF75fCI/ya5mwQOTtX3iPEmnRQGv2MkMouXX3AZsAQRdWjGjZEmevzQWx9mkX1j4//C5pp3rEHp435KlehfP2JnXKgH14mdYfqonn6m7eklJPBXf8eE5q0uS5TUzZiN8BPj/HQHtI1ZoJ/rhW5SRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724765383; c=relaxed/simple;
	bh=m4va17MNKF1s/LDPwp8wFhie2OyGpeLYqP5feOuDO98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qF6Xd/RPSOYxbXkJGSFB40hweE+e/pVPms2GUlkMBOsKk7RapBGuOTOrTGO3UyUWpCMSPm7CATHk5B81hjhQ/J4Mh9lPebYOzBmdJHlg42OPEsElsw80O9ANQp5Nci2lxu/XkfNnZYxTco1TFwpppxX1QCe8fqYxnL3jWXp7jgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ut06LWvQ; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724765382; x=1756301382;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=m4va17MNKF1s/LDPwp8wFhie2OyGpeLYqP5feOuDO98=;
  b=Ut06LWvQ6NDXbbswAyBu3+Dmnf0zPL1hikIwaNgHfh9ebSAqdcQRFUZ9
   gnBIzAVmSEET9Jn6MpwNuXJWC7dtRKNTMU8E8qN+0Lt4XvHMGAQTpXbq9
   8wQLolTimOeHX9mx/bz6qQh3pSO4QK++had/HP6xDE6bYFE2/oIAWSIYk
   IOnVL/0LWyg9BZiHU6rqiwj9oA21J14WQ6tZc5At54+p4wjwzals9QJ0k
   FLmqRP/kHljq2gOG0M/1kh9KY/hFho2PhT1JdYHKbI7emD4vBHQYE57C5
   7sypr41tVnzIhEo8kxk2Y8DqeYaU95nTAXqV6+pWIjWznWV4MJJHP7IKj
   Q==;
X-CSE-ConnectionGUID: Pr9RyI3WSaKFehJUEvuk+w==
X-CSE-MsgGUID: hGRvoufSTd6Xu2TwcjnLtg==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="40745442"
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="40745442"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 06:29:40 -0700
X-CSE-ConnectionGUID: I77NCGnzSRKWcxgffA5GTg==
X-CSE-MsgGUID: xutKtHd8Sf6XVcoUGwmUHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="62532831"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 06:29:37 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1siwG7-00000002H5E-1FvU;
	Tue, 27 Aug 2024 16:29:19 +0300
Date: Tue, 27 Aug 2024 16:29:18 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>,
	John Ogness <john.ogness@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] hexdump: Allow skipping identical lines
Message-ID: <Zs3UrlufPJ9wVyep@smile.fi.intel.com>
References: <20240826162416.74501-1-miquel.raynal@bootlin.com>
 <Zsy8JPaiGknBypw9@smile.fi.intel.com>
 <20240827110147.29a7481a@xps-13>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827110147.29a7481a@xps-13>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Aug 27, 2024 at 11:01:47AM +0200, Miquel Raynal wrote:
> andriy.shevchenko@linux.intel.com wrote on Mon, 26 Aug 2024 20:32:20
> +0300:
> > On Mon, Aug 26, 2024 at 06:24:14PM +0200, Miquel Raynal wrote:

...

> > Also here is the formal NAK till the series gains the test cases.
> 
> What test cases are you talking about?

Anything meaningful you come up with to show that the printed data is
what it's expected. The module has a complimentary test case,
lib/test_hexdump.c. Without changes in that file, there is no go
to what ever golden ideas you have.

-- 
With Best Regards,
Andy Shevchenko



