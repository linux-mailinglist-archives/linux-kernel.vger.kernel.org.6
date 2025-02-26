Return-Path: <linux-kernel+bounces-533862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 638B3A45F70
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A9DC16DE57
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6294621576D;
	Wed, 26 Feb 2025 12:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hAy4cr/J"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DBD2063FD;
	Wed, 26 Feb 2025 12:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740573511; cv=none; b=JhJYF+7R62uTq9X8pShti8jCXJd4Mka+tv7xLMC112PgLfCfg2UIAwGzSBR2oiZ1aJhGExL2e0jLfW6nbXi39Tf/WpShP2fCrrDsormzBikaYFwx63GF7mNRn6pGmH0dDu72qxijqPw9b3cGM3rlTVFfHix9z3a+n03VA7LSQqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740573511; c=relaxed/simple;
	bh=KGFvfxU4db5vtbnoDHtKUfvcsj7Nffzksy8W4HNffuQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iDt9cEoO4IAjRKGR5pYc5sz8gJG89PtlwKi2RmtjhoC1Ojpt2ZR98jjuu9xQks6BCs0rB4sCr/TLLPTOoQY4y5PaJPUoyRnyBCMVyA919CTfna9TyKkNJqnt4s9dlf8A7+pwATE9+JIC33Ekm2rRkWLucZF5+JaHoi5GU4z//HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hAy4cr/J; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740573511; x=1772109511;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KGFvfxU4db5vtbnoDHtKUfvcsj7Nffzksy8W4HNffuQ=;
  b=hAy4cr/JNWWPES9qlI6px7K+TN2FLY8NaSeXnNA/yLyh8t8cZI0iNdVv
   bJQYoPheDs368nWt2SzFSomn897kwBnO0rAz5c0XFFUfSmTpLw107q/O9
   xz2ROV97mDtr6OD7rMpNR+p9+g8qF7IRgOw1ajxFUXqE4/ZmUFSzL3db0
   WL9EGuleAc4lN3B6J2v93BsqtK50Yf+p6cwJjklOJu/aumpIskwZXVsNj
   XDE0kJeXNofrgtABAe1ilC4jdXXWZgqqEoVJKBv0ntTGGvhLSXOQcfhNp
   RRh8dok/otHF39neH6QV3VspCrI3NhOUA+Urts65cdBN4qMLoL6KZCy7s
   g==;
X-CSE-ConnectionGUID: 4eru/AzjT9e6G33QSaZrRw==
X-CSE-MsgGUID: +4NrcPpMR3q/2F2h3OF5dw==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="41611326"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="41611326"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 04:38:30 -0800
X-CSE-ConnectionGUID: L/xqCCUISSWVAQ8L+chRMA==
X-CSE-MsgGUID: noWgvZioS3qyNglv+20Ajw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,317,1732608000"; 
   d="scan'208";a="116476605"
Received: from unknown (HELO [10.237.72.199]) ([10.237.72.199])
  by orviesa009.jf.intel.com with ESMTP; 26 Feb 2025 04:38:28 -0800
Message-ID: <72f3b497-ecac-4efe-8010-a77cc232ce30@linux.intel.com>
Date: Wed, 26 Feb 2025 14:39:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] xhci: ring queuing cleanups plus a quirk
To: Michal Pecio <michal.pecio@gmail.com>,
 Mathias Nyman <mathias.nyman@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250225125750.1b345e2c@foxbook>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <20250225125750.1b345e2c@foxbook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25.2.2025 13.57, Michal Pecio wrote:
> I was looking at all uses of enqueue/dequeue pointers and I found two
> rather complex loops which appear to be doing really simple things.
> 
> I don't understand why they were written this way, it seems wasteful
> and I see nothing that should go wrong if they are replaced with much
> simpler code.
> 
> I rewrote them and the driver still works. I exercised Set TR Dequeue
> code by starting/stopping isoc streams, using usb-storage with crappy
> cable (transaction errors, halts) and also the smartctl -x trick that
> results in URB unlinks (both on usb-storage and uas) with some disks.
> 
> The third patch is a dedupe. BTW, that comment there about section
> 6.4.4.1 of the 0.95 spec seems to be wrong, I suspect it should say
> that the chain bit cannot be *cleared* because that's how the code
> works and what some commit messages say. But I don't have 0.95 spec.
> 
> New in v2:
> - dropped the patch for obsolete update_ring_for_set_deq_completion()
> - added a patch to enable the link chain quirk on one more HC
> - don't touch the chain bit in inc_enq_past_link() on quirky HCs
> - don't call inc_enq_past_link() unnecessarily
> 
> Michal Pecio (3):
>    usb: xhci: Apply the link chain quirk on NEC isoc endpoints
>    usb: xhci: Simplify moving HW Dequeue Pointer past cancelled TDs
>    usb: xhci: Unify duplicate inc_enq() code
> 

Thanks, adding Patch 1/3 and 3/3, skipping 2/3 for now.

-Mathias

