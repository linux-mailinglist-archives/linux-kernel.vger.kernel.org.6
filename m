Return-Path: <linux-kernel+bounces-330515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C686979F8A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 12:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEB801C22DB0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 10:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2CA14B94C;
	Mon, 16 Sep 2024 10:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HXhEEHRE"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2542938DC7
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 10:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726483192; cv=none; b=LjwTGhvl2+Z7Us0Usjiiss8X7Dz7DI1IUPoYUzhZv2YIAuZgN/gTJErulyZDvsjjs1EvJBirYPUTOdT/ObjIyaCRP4d4mqqdsGL5Ty6CHHxFppjyOI+ywhkKmrDII+kCnRdPTmtSRX8uqbEZl9EkSVJhV2Rv9nEwh9PptXiz7tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726483192; c=relaxed/simple;
	bh=D/Mw6CoFixkcD99JW2+o6/iZe39Eet0PbGm2LBlB3sI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YiQVbLV75g829GHqDs/pR20PmMcHdItZR1GlLs9NZ2jobQ0XPA5AgDVopOk765w9CjMyv4w8RWFfYdsKgunHGowaqZrBlCm5aqkvk2P4ZQoZY8Jzzo97x2ht8/FnQ8BGV1ZZbXBcEAYLA6u/EZlZKs+Jjw/x2k0rlGzhIKQjcXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HXhEEHRE; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726483191; x=1758019191;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=D/Mw6CoFixkcD99JW2+o6/iZe39Eet0PbGm2LBlB3sI=;
  b=HXhEEHRE4CJo41gPh9sAAs6VwXkjxhMyH+gxhWfSk7gAK6GXK0dseshS
   Oi6MKx2NCOWV8dLOn2PiNEtlON5cq6fhRwhc0Wl6KWkGPQgGgPncxpaET
   VLJTfFDTOFikygDr5rA2Q2cb95FtgjhXpLDi/EVUR4QQEaERAgeHIHC9u
   zkMsxMyovm5CpgfEtMIJrGTdFVY3G7w6jm9KvS7a649M7ZavoT8hejgfZ
   OBH+aptEBvUMcHVQ4S0DTLf9Hqmg32434botnH19+7JPGmC5o7D0c3AR1
   3CTdr8hKcT3RgrqIw0YuauqeiGxt2AyB657IOqaH3vc9uK65+Mq77bASa
   w==;
X-CSE-ConnectionGUID: sMTApYEhTnS84wYaMxazLQ==
X-CSE-MsgGUID: 7rtXeEU7QAGyCUNvpObLIQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11196"; a="25429593"
X-IronPort-AV: E=Sophos;i="6.10,233,1719903600"; 
   d="scan'208";a="25429593"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2024 03:39:51 -0700
X-CSE-ConnectionGUID: Knxqc+aRTbqlTdyOyWiinA==
X-CSE-MsgGUID: LFwG0ateS/KOU25k2zskaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,233,1719903600"; 
   d="scan'208";a="72923567"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2024 03:39:49 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sq990-00000009QRa-3DB4;
	Mon, 16 Sep 2024 13:39:46 +0300
Date: Mon, 16 Sep 2024 13:39:46 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Kaixin Wang <kxwang23@m.fudan.edu.cn>
Cc: sre@kernel.org, rdunlap@infradead.org, linux-kernel@vger.kernel.org,
	21210240012@m.fudan.edu.cn, 21302010073@m.fudan.edu.cn
Subject: Re: [PATCH v2] HSI: ssi_protocol: Fix use after free vulnerability
 in ssi_protocol Driver Due to Race Condition
Message-ID: <ZugK8hXvMaMEaOsz@smile.fi.intel.com>
References: <20240914172142.328-1-kxwang23@m.fudan.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240914172142.328-1-kxwang23@m.fudan.edu.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, Sep 15, 2024 at 01:21:43AM +0800, Kaixin Wang wrote:
> In the ssi_protocol_probe function, &ssi->work is bound with
> ssip_xmit_work, In ssip_pn_setup, the ssip_pn_xmit function
> within the ssip_pn_ops structure is capable of starting the
> work.

We refer to the functions as func(). E.g., ssip_pn_setup(),
ssip_pn_xmit().

> If we remove the module which will call ssi_protocol_remove
> to make a cleanup, it will free ssi through kfree(ssi),
> while the work mentioned above will be used. The sequence
> of operations that may lead to a UAF bug is as follows:
> 
> CPU0                                    CPU1
> 
>                         | ssip_xmit_work
> ssi_protocol_remove     |
> kfree(ssi);             |
>                         | struct hsi_client *cl = ssi->cl;
>                         | // use ssi
> 
> Fix it by ensuring that the work is canceled before proceeding
> with the cleanup in ssi_protocol_remove.

Same here.

...

> Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> - add the Acked-by label from Andy

Not that Ack was given to _this_ version of the change (it has been changed
a lot), but I'm fine with keeping it.

-- 
With Best Regards,
Andy Shevchenko



