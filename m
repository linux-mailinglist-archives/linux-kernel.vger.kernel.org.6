Return-Path: <linux-kernel+bounces-447912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7EF9F388C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 19:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F2CB18967E7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 18:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF8820B7ED;
	Mon, 16 Dec 2024 18:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ekg0/WH7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137BB207E0F
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 18:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734372128; cv=none; b=piaQedLPWV+3gBwgKcffYwpSaQ7mwsiOi9/CclQGnfIiz5gDH3vdq20Rk27ALTNXll0yKkBJRxuV/ak0IwdI4/y8fxQoIX7GiH9WRiP9+lvCM4KvNr8Nv18JMUjJTsoIe0HlZuWtevL+5h2uMX1duST5WWTek+7bKByMJtGSUC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734372128; c=relaxed/simple;
	bh=7DaBdbpJGOIdrosp4c2sKJ55oWRxT2JIUO/xboGNxhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FdRSg9ymbqDlszEK/VcpTiR3j8UTT2quBeFBIHkJevj64Oehqc96irK6sF1q3BMzaiLThSxtrXJGrBMAJcRdduX2KwRjjT2tJ1wDhJHBTxPvCxHAqsCSL1Bygb/BzKXl6VacqdSN0BFWmgznshgc0kfdxBnSws4nvIhUnOIhu68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ekg0/WH7; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734372128; x=1765908128;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7DaBdbpJGOIdrosp4c2sKJ55oWRxT2JIUO/xboGNxhw=;
  b=Ekg0/WH7Ir7XgkemLlYMyLpilwbeHiNqqr6/GhyiPNs6A16aDwFiqrP9
   We46JBtimowxSRnfeQt9ODqtTqEzJs2Wbi2drLIBU/E4nBFB7IeBBg7Ht
   slO0FVlJJ63n6oQJhoP7vG8dKJ5j7ZaU5i9jJ3mh1p/eb2lEOBYrhtUI0
   saR3buCm+vkoB1ey4NcMLmxmkJEB6hmHSBv2BvN7+pk68y9oFXGgDnlck
   YfJ6Hm1/jywBMdyofnfi7ts9rIdyVuJuileu87ZtLp4aAgEot43auo9QG
   InTqITgUwmAd92tV71DsAZ37F3VYySV/spjLC8u9hkb1Z3l2Z9jCtAZ6m
   w==;
X-CSE-ConnectionGUID: qB0EiTxBRM61/yZr9D6fyg==
X-CSE-MsgGUID: HKdNRjUySBWyaHlQ3Ajc9g==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="34806657"
X-IronPort-AV: E=Sophos;i="6.12,239,1728975600"; 
   d="scan'208";a="34806657"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 10:02:07 -0800
X-CSE-ConnectionGUID: oxlL5EdlRp+ZY5QqsoSV5w==
X-CSE-MsgGUID: A5Cz6fvnTIO+IiTh1ybQ/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="128244532"
Received: from ldmartin-desk2.corp.intel.com (HELO ldmartin-desk2) ([10.125.111.64])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 10:02:05 -0800
Date: Mon, 16 Dec 2024 12:02:00 -0600
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, linux-kernel@vger.kernel.org, willy@infradead.org, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com
Subject: Re: [PATCH 00/19] perf: Make perf_pmu_unregister() usable
Message-ID: <pdmlj5dhoums5kjyzz4j7nfh6jiwoyft3ub2rxukt4hdluwlxi@ymgq3lvj6j66>
References: <20241104133909.669111662@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241104133909.669111662@infradead.org>

Hi Peter,

On Mon, Nov 04, 2024 at 02:39:09PM +0100, Peter Zijlstra wrote:
>Hi,
>
>Lucas convinced me that perf_pmu_unregister() is a trainwreck; after
>considering a few options I was like, how hard could it be..
>
>So find here a few patches that clean things up in preparation and then a final
>patch that makes unregistering a PMU work by introducing a new event state
>(REVOKED) and ensuring that any event in such a state will never get to using
>it's PMU methods ever again.

Any updates on this series? I'm trying to understand if there are any
blockers I could help with - we are aiming to add perf pmu to the xe
driver, but I'd like to have a reliable unregister first.

thanks
Lucas De Marchi

>
>

