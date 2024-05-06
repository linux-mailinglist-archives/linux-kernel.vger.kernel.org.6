Return-Path: <linux-kernel+bounces-169509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F498BC9B7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 10:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B60BB21C8E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 08:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3D6136E22;
	Mon,  6 May 2024 08:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P/HkCHZz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292246BFCC
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 08:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714984755; cv=none; b=QVpaCNvfPszN880FgZiJMu6pW079Ji45kxNrSFEhzKvCNpHU3RFitKJZAHbm4b4TBL1dsS8CIN0fscbS2mxU7qgrUtc9QiBZcXJhwEWfoPxz1BpLE8ufwByqTLJLnL0AcubsCmNJ1TeNXM0n/vZ/JooKZGg/zAC6S6L8MVf1lzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714984755; c=relaxed/simple;
	bh=wVZHpDejSvBl0HAVmlSA3PCZXwbbeGaq5eO6foXgkPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=isATG/nW6MfuQh0OCMmDeF7vKxCKK3YJIcVE4p1oWh1/Wx6Qm7B6ZjlZ1iUpVIK++d/WqVeFkI72rLZm8Yi3kNVM7ZX0qDnc7QYxu56Hrstn9tCyKrpvqrJjFI6REEmLDVShqI8O8WYE8ymL1RJlEmnVl1s/V3CJ7tTVY50Iyuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P/HkCHZz; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714984754; x=1746520754;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wVZHpDejSvBl0HAVmlSA3PCZXwbbeGaq5eO6foXgkPQ=;
  b=P/HkCHZzJ7l39MZLLoOcwxZxwquKi97kNa6bhoMGZn7UWybPRH3Gi9Zc
   sTIoRCGLELDFznAiufqcZOvJ4TNYeVdZxdYo+nZkT9nwoaZE+5EDjATMJ
   YYA38Qk2RSh5TxzmY0Fh9fw0DulOK+QqwETxQl+opeIWDeQzv/HqX6Uzd
   pmGekfgdxuOGI5K1T6DqDr8pyi16mpoH1dFadqQQ63VUF01IAHeclL6ml
   l9aljsDVzKTgrWU70ukRSZUb7fNg2j9RyfphsJN0d00X4elgtUuGIhhqf
   K35VQSNiyl5QhESYMAav4AT9nDYA6M+rioMSHCHJ2GBAJEpZZtF3dniwf
   w==;
X-CSE-ConnectionGUID: MEIeztWER8i5nP7zLL7Akw==
X-CSE-MsgGUID: XX1FMKKORmCk7B4j5tXBtQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11064"; a="10562606"
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; 
   d="scan'208";a="10562606"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 01:39:13 -0700
X-CSE-ConnectionGUID: BX70rk25SYik9IXZ8PPp7Q==
X-CSE-MsgGUID: 2/0ZlfeRTTWV+hexcU3bzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; 
   d="scan'208";a="28110244"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 01:39:12 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s3tsM-00000004byp-18sR;
	Mon, 06 May 2024 11:39:10 +0300
Date: Mon, 6 May 2024 11:39:10 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: compiler_types.h in UAPI?
Message-ID: <ZjiXLm9ZnJwMHiBP@smile.fi.intel.com>
References: <ZjUzt3Rysyk-oGdQ@smile.fi.intel.com>
 <cb22252d-1ea9-4094-9f7a-b94c2142d1f2@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb22252d-1ea9-4094-9f7a-b94c2142d1f2@app.fastmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, May 03, 2024 at 09:34:13PM +0200, Arnd Bergmann wrote:
> On Fri, May 3, 2024, at 20:57, Andy Shevchenko wrote:

> > Today I have stumbled over use of __force and other compiler_types.h related
> > things in UAPI headers. Can anybody explain to me how do they suppose to work
> > outside of the kernel? Or did I miss something obvious? Or it was a mistake
> > during UAPI split to move swab.h and byteorder/ (most of the users of those)
> > to UAPI in the first place?
> 
> These get stripped out by scripts/headers_install.sh during
> the 'make headers_install' stage:
> 
> sed -E -e '
>         s/([[:space:](])(__user|__force|__iomem)[[:space:]]/\1/g
>         s/__attribute_const__([[:space:]]|$)/\1/g
>         s@^#include <linux/compiler(|_types).h>@@
>         s/(^|[^a-zA-Z0-9])__packed([^a-zA-Z0-9_]|$)/\1__attribute__((packed))\2/g
>         s/(^|[[:space:](])(inline|asm|volatile)([[:space:](]|$)/\1__\2__\3/g
>         s@#(ifndef|define|endif[[:space:]]*/[*])[[:space:]]*_UAPI@#\1 @
> ' $INFILE > $TMPFILE || exit 1

Thanks, Arnd, TIL!

But do we discourage using these in UAPI in general? I mean do we have
this somewhere being documented?

-- 
With Best Regards,
Andy Shevchenko



