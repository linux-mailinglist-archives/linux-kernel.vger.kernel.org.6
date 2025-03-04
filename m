Return-Path: <linux-kernel+bounces-543122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08745A4D1B9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 03:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B60518939BE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 02:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7A717C21B;
	Tue,  4 Mar 2025 02:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="II82X1NB"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED2342AA6
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 02:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741055606; cv=none; b=bS+EE8Ls3qtHYfishUPL7FICh77i4f3lB2MtGop8KrEiS2ztME/RaT35vfBqE6LDY/49fO4Q8toADHlgJRbl6zYXc3m/wzjxT+lvn62ojJp8o44HgyCLFQpLrY0lyZ57+xIs4TPpki3Ow1ouaqiCTKui2SGBAcrf/4kM9Es2l0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741055606; c=relaxed/simple;
	bh=dGP7EDwYmcZOROJR5nbhPIsV+sfV6V6rdg14F0fUg+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZYElyih/kg0mh17hqS0+6qmfwr+q2GcA7+AUCr87pkWIGN7RVwNJ3xuGOP9Xs44RaGiY9JElCHz+dcVSMdAR28kyL2fdS5JDbqOFnNRyvjG2hJRIRx/Enj3DPYoPop2H1kpSM/6s/5QOI6xupkid2wJGvEI/GtYxe/PruhLT9bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=II82X1NB; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741055605; x=1772591605;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dGP7EDwYmcZOROJR5nbhPIsV+sfV6V6rdg14F0fUg+k=;
  b=II82X1NBoDlkHFcq6PhFX7UpMH+XrkXHaKFF7OWPvTcckVT6T4UDzfBY
   Uhnen0vN6qgK61WkTcsS+CvMwqxTYCsQwevwiOlqjweWUwyRn3HTB8DxX
   QPmTfka8sdimJLNWZgcM3F6sdhfag3GZFFbet7gaWTK/LxRqHL6cpPCg7
   Ai51WmiilPPRjAazBSHKbYrX2dTF//P72O2Z/wYD64jNVOlsv2e2qib1h
   GjPKuV9uFIZzSrSW4YyntJxflXS3b9S+N4L+D+UyqEbYeER5TB+EoxBT/
   AAyLcc6VGbB4ISPRxU0gKmets2h2OzFL/hY/iS3pecj3QfC07OumaVZCY
   Q==;
X-CSE-ConnectionGUID: FjZfmmkmR/WrjSIHcTh08g==
X-CSE-MsgGUID: wTQpIaEBQZuu7u9eLmeo1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="42075647"
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="42075647"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 18:33:24 -0800
X-CSE-ConnectionGUID: BsUc4SrzSdOaTsQiQIbkKg==
X-CSE-MsgGUID: Q0To7gYNQwauCHTECd7WxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="155403351"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 18:33:24 -0800
Date: Mon, 3 Mar 2025 18:33:23 -0800
From: Andi Kleen <ak@linux.intel.com>
To: Stephane Eranian <eranian@google.com>
Cc: kan.liang@linux.intel.com, peterz@infradead.org, mingo@redhat.com,
	acme@kernel.org, namhyung@kernel.org, irogers@google.com,
	adrian.hunter@intel.com, alexander.shishkin@linux.intel.com,
	linux-kernel@vger.kernel.org, dapeng1.mi@linux.intel.com,
	thomas.falcon@intel.com
Subject: Re: [PATCH V3 0/5] Support auto counter reload
Message-ID: <Z8ZmcyJl_otpzRgX@tassilo>
References: <20250213211718.2406744-1-kan.liang@linux.intel.com>
 <CABPqkBQcKgsrVD+MLYrgiemc2_THOGKi+E1YayFw_pT4VQWGEQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPqkBQcKgsrVD+MLYrgiemc2_THOGKi+E1YayFw_pT4VQWGEQ@mail.gmail.com>

> > the branch-instructions is overflowed. So the "cause" event is the
> > branch-instructions event. The acr_mask is set to 0x2, since the
> > event index of branch-instructions is 1.
> >
> What is your definition of 'event index' here? Is it the position on
> the cmdline?

It's the index into the group.

-Andi

