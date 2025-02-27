Return-Path: <linux-kernel+bounces-535672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2FCA475CE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 07:04:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28B331881E73
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 06:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B2321930E;
	Thu, 27 Feb 2025 06:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jcpdBJGT"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA140215769;
	Thu, 27 Feb 2025 06:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740636277; cv=none; b=ulw/DcDYivc2D2kjHl7GVEBLAO0iUzS3B9y46nYfQ+Fpy7D9BhbmUZXuohdpZNusFNeUWBdEcxeqHThHAUKfH6wJyzE5AQsxjMhrs5G5qIQEsFiWOGTyzwkxpg0mVrTNahVkTTKdAKgL40oGFKqWepe0H/2uHKXpCgKJIStlLYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740636277; c=relaxed/simple;
	bh=yLIxoMkr0ur2OAbRZKbGVnmARCH0t2/K8u/fv8aAomQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SRBX4X/x4A+ZdyHgk69rC9Y6O1nasMaVMqjo+IMn8xxIiostRXKoiqLbEVtCmXsZBZxMXhU09cmwxzOS8N22mYuStwC8gqq/xSthDlwwlDAC+7f5N3jX4BNSZj1gv5rYMnbhiUkWY0sndq2AV3zu3qPnNP1u1bQ49DwwvNWjoEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jcpdBJGT; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740636276; x=1772172276;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yLIxoMkr0ur2OAbRZKbGVnmARCH0t2/K8u/fv8aAomQ=;
  b=jcpdBJGTRjzLObhK2N6J4MhsktsjOlLh4RADHrZ9Ko9sfS9YwrqWyeD8
   mkWRcLsyjp4VaJkM1W9qQUTwQK/sqclYSPN6dSnD7jRSsMxLl7lxq1/A8
   4eBBPrXL6msq6i3HUTJAOSmsj4CTBHTv2Pv+x3FXaSQ8i5Us6WhD67p3S
   OGW5cYHRHBV2ar03OGG2Ttzw8dLeJRpZo/79k09b9dZyz0Cwq6VWu0j0H
   /jL8laEJekZhryxge4bqCazqSWGOaghtpCIkLpQdVBTjUbVwZUWtDWcmg
   b6mbYYINIF2FlBZE3jzei0rttXqiUjGGTvVgs9+HGEHmwVa2iNAa1/Fj9
   g==;
X-CSE-ConnectionGUID: KQMSTt1mThilhBIa1HC6KA==
X-CSE-MsgGUID: o9ndrhS/Q0yy1dkp5sGVbw==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="41640178"
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="41640178"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 22:04:35 -0800
X-CSE-ConnectionGUID: QgCQH2GoRguX54NQ8SGVNw==
X-CSE-MsgGUID: 35ZqiWAnTHi81G0DsoBGTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="147748144"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 22:04:35 -0800
Date: Wed, 26 Feb 2025 22:04:33 -0800
From: Andi Kleen <ak@linux.intel.com>
To: Chun-Tse Shao <ctshao@google.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@redhat.com,
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, terrelln@fb.com, leo.yan@arm.com,
	dvyukov@google.com, james.clark@linaro.org,
	christophe.leroy@csgroup.eu, ben.gainey@arm.com,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1 1/2] perf record: Add 8-byte aligned event type
 PERF_RECORD_COMPRESSED2
Message-ID: <Z8AAcZXtuD7O3TAV@tassilo>
References: <20250227053738.788153-1-ctshao@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227053738.788153-1-ctshao@google.com>

On Wed, Feb 26, 2025 at 09:34:06PM -0800, Chun-Tse Shao wrote:
> The original PERF_RECORD_COMPRESS is not 8-byte aligned, which can cause
> asan runtime error:

It seems pointless. Most architectures have cheap unaligned accesses
these days.

Just disable that error?

-Andi

