Return-Path: <linux-kernel+bounces-327893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F7C977C5B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 11:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2EA01F21733
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 09:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB691D79A6;
	Fri, 13 Sep 2024 09:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KmM2LyOb"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD601BD4F2;
	Fri, 13 Sep 2024 09:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726220351; cv=none; b=qIDqeYUu+ttHUpZLgKmLl6Xvf8Vl5rQcDafGRX1CZX250el9YXgdTZYi2+TtewKYuNcaWbrJqHUrGNjaqI0Y3IEbUFngq398TZd0vmAMtriYmbJ7liDphCgH3+0NDXfYVy2SCs4en3pLH2U0fMQXas0yBtW60ueyP9xCrZGXOps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726220351; c=relaxed/simple;
	bh=JI2ZLU0FyTqnuSB6wzQzLJ8IjKER/NhO6YLSEUfYLns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uELa0EtJV/RX4kEGLGFgV5zW4IfStx0gcF32yCupjnycM+/BdWTB0hQ1ldxCJ/Y/vDIVB2s6ltlHnC0VM+RPGCC4IzZv9PMneBUBWwhu2ARqjK8dL5rCI9/IQ+bmX68MvnwTesKJbLLRN++FaGEJL/GwtrMnJzLur/MmhF5BiTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KmM2LyOb; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726220349; x=1757756349;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JI2ZLU0FyTqnuSB6wzQzLJ8IjKER/NhO6YLSEUfYLns=;
  b=KmM2LyObMEXacq4m5QHvhsswNtERTpU9rZ0+Z63GzItGvKBh5dV9IXSE
   shpE32RoK60/MPj/zMFfnlZEgDlrQetG6nSrHBMWEvcgEXXxGo3Fu1WGD
   DeXMPHQOGodtpP1EVWYccCc6bmWN9zJqcIhbzORsvKuc0ATANh9bueYga
   NPCMOY2xteDsnFdzvpqz6MHJCZwcPRP4TT3XUfAQ79AkJS4FMTDMErZZv
   W12IVre94vlckuRgcpycK7r6GGCudsKcZZKsD0Omk2kSAF/XtHQXxvda1
   9inbenWboZHCWtDYPhYopeX52Zh5ZFR14ElguzG+o16UOWmcIliC6ewh8
   w==;
X-CSE-ConnectionGUID: RDnyyfA2QUSCMqS8HYIFoQ==
X-CSE-MsgGUID: 4S+SHxS0TXaOt84EEgJpDg==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="25240118"
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="25240118"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 02:39:09 -0700
X-CSE-ConnectionGUID: 82q8k3OBSUeFliXMTpbJEA==
X-CSE-MsgGUID: saJO+JZ6Qw6jSfZ5p00AYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="98687270"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 02:39:07 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sp2ld-00000008FJY-0JzY;
	Fri, 13 Sep 2024 12:39:05 +0300
Date: Fri, 13 Sep 2024 12:39:04 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: robh@kernel.org, saravanak@google.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] Use functionality of irq_get_trigger_type() and
Message-ID: <ZuQIOKzDO5aUhoCJ@smile.fi.intel.com>
References: <20240912221605.27089-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912221605.27089-1-vassilisamir@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Sep 13, 2024 at 12:16:03AM +0200, Vasileios Amoiridis wrote:
> The series is compile tested.

LGTM, FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



