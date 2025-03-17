Return-Path: <linux-kernel+bounces-563537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1BA0A643B7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 08:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 305701891099
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 07:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3755B21ABB2;
	Mon, 17 Mar 2025 07:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HnkOaMnA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228FE2F30;
	Mon, 17 Mar 2025 07:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742196692; cv=none; b=gqov8i/yFffZqI18MRG4q9yp56HktT+A7XyweTHTY43Vo80rk0fKfewA3+wtYDKSc2x18CQ4VSIkXR7d8OS+SDOZuHli0/y/ooY5aYMMooT2tVhVGBgiJxd4rCJBXmdsf2apcUgrwEzZ3ROSSq47UutU4fF+CL7/E/svk8un+80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742196692; c=relaxed/simple;
	bh=3egurgrbXr6J44F1f+fjR4XWQz/Kpcf+rXQbA0gpfK8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U69XMYM0Wu7B2U3t2KmMxlzQLkSXQoORKAH6JGY6JjEMjEi5c52xvkNKLs/gg0aKACca4S7TmtyG3CD5eCbWDeQRWBKsKXD6EM/+TQqG/s5HA5HI6H/5OIrYs1lbAtLb4bIWR6wCjtj5rhxD0uOoMBGAissmUUSPRef7JUKVl+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HnkOaMnA; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742196691; x=1773732691;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3egurgrbXr6J44F1f+fjR4XWQz/Kpcf+rXQbA0gpfK8=;
  b=HnkOaMnAMM9AY+2aOvnPADCTMbgktKrtEI/IZ+E9Rkuoz1JE/rob9Hrv
   /msrL7eR93VSObu6QREa3ToatndGnPsl1RldiRuNqvOwneW2xYgoH/cCV
   Ne0pKryf4USUw9LVskZt+tyjzPRwoWAB8vE8N8YZrLqADzmncMEBkN80A
   fVyGhyZO5/3sVR4qBiajb+fQvua9GgT869A3N8lBF/KC0Bf3eL/WFfovW
   WeNtFVXhKk487+sSe1UXiR4UtNXxNB65OJ37iY4EvGrZCJuCFNyGocp9T
   yP9sgIaVoZ2j0UPcSsHd4mFryGjsZMuEr+hHp0AznyLc08T+THPJAbdTb
   g==;
X-CSE-ConnectionGUID: qkZjq6cHTuamsacGj1ZI9g==
X-CSE-MsgGUID: NmYVsUjJSEmZZrfWunuf8A==
X-IronPort-AV: E=McAfee;i="6700,10204,11375"; a="43381145"
X-IronPort-AV: E=Sophos;i="6.14,253,1736841600"; 
   d="scan'208";a="43381145"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 00:31:29 -0700
X-CSE-ConnectionGUID: FB/0mxyJSDGwSfq8OR4PDQ==
X-CSE-MsgGUID: 4RdYCtM4TIioUT+mUTzHyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,253,1736841600"; 
   d="scan'208";a="121801449"
Received: from choongyo-mobl.gar.corp.intel.com (HELO [10.247.97.179]) ([10.247.97.179])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 00:31:27 -0700
Message-ID: <f02b9127-fec1-49c7-9cc1-f286cc3adca7@linux.intel.com>
Date: Mon, 17 Mar 2025 15:31:23 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] platform/x86: intel_pmc_ipc: add option to build
 without ACPI
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
 David E Box <david.e.box@linux.intel.com>,
 platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <20250313085526.1439092-1-yong.liang.choong@linux.intel.com>
 <CAHp75Vcjqv+j9gkZiQ_LtYE1F7YH8ZweHVTa31AbPht8_Knnkg@mail.gmail.com>
 <2a00773a-b887-7966-36de-0e2b93359912@linux.intel.com>
Content-Language: en-US
From: Choong Yong Liang <yong.liang.choong@linux.intel.com>
In-Reply-To: <2a00773a-b887-7966-36de-0e2b93359912@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 14/3/2025 7:56 pm, Ilpo Järvinen wrote:

> Hi both,
> 
> The original commit went through net-next tree so I cannot take this into
> pdx86 tree until after the merge window. It seems low impact enough that
> coordinating with the netdev might not be worth the effort.
> 
> To get it going through net-next tree, you'd need to submit v3 so that in
> addition to the current receipients, all relevant netdev people & ML are
> included as receipients. But I'd be fine if you leave it until after the
> merge window and I can then handle it then.
> 

Hi Ilpo,

I believe we can leave the patch until after the merge window.
This approach would simplify the merging process without needing assistance 
from the netdev maintainer for the platform code.

Thank you for your support.

