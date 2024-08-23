Return-Path: <linux-kernel+bounces-298686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F94A95CA36
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 12:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C6522874FD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 10:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D493C18732D;
	Fri, 23 Aug 2024 10:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cz1QJ9wU"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6301161313
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 10:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724408029; cv=none; b=qp3VqgEdrh+YjT5RRGGh5Czcmv+08P1aDmBXcNeVmqJCWbl3iIY4+3/nCcrfnp54qY0w8de/xvEf2t7uj6y4XAEoqNDifywk/32hz2rpgrb6C/uBbf+hAx4DamYR9a5T/tTzYp+m+M78AqKv0gJXrHkxwLHKrB0waDnessVuBJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724408029; c=relaxed/simple;
	bh=kwZWXCCJPaCGeMaKS+UIFXgZpykCQVIrE/gdE6I9zBs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ey51axjFl9Y/S4Zmpr+gyUxQ6UeBr+YJBcgqm62mc7DHbONvGA9l8XVHnaOfEYUPNiDorTTtJLalhqfvGfIfBn3r907gSdq6+VCD500gwuTOUZNIxWwecXgX7SlEmNsZsr7V5lmiTt/FQ3KoX0X7iRc9SwsZ1H5SoAtTSzUzxRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cz1QJ9wU; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724408027; x=1755944027;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kwZWXCCJPaCGeMaKS+UIFXgZpykCQVIrE/gdE6I9zBs=;
  b=cz1QJ9wUMO+mXMMdaE30vORBdvV1m/RhcUUDEwuQO8hm7juT8viW+FWV
   k9FBkOvZH2YDsZAcK4a4yhZ3n+lDJdsBrvhDRwSZUza3Gy76Yz3IkFV9o
   pJAf2b+7z/wAkPYqhmJ5YITp0IUnIY7fCYYjDOuz2XAy8YdtXgaWqODN6
   gehCdi8B2h5FVJhjNNPLBl4YXIfADLw15TBS7Y3nNi1Xpq4idc9WKLbtJ
   a3NBvMMm/lQthHmjv3tgQLNqWXb3axMmrZ3TZlt37CEXRzn7fhpal+p6G
   Ic/WFnJFOrlvw4C3GD4Nr9ay+TxN0Cq4YRiAiylD7qRY8NSeSrEudkqHR
   g==;
X-CSE-ConnectionGUID: 2ijc3o5PROWaC/qYr7Jg6w==
X-CSE-MsgGUID: GrRR0Q7PRJWR8Ej6vA17Tw==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="13167759"
X-IronPort-AV: E=Sophos;i="6.10,170,1719903600"; 
   d="scan'208";a="13167759"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 03:13:47 -0700
X-CSE-ConnectionGUID: 1/mEJVR5TOKsiLPNedotmw==
X-CSE-MsgGUID: +Hqgk3NWRPWU33pEWC81OA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,170,1719903600"; 
   d="scan'208";a="61902924"
Received: from mylly.fi.intel.com (HELO [10.237.72.154]) ([10.237.72.154])
  by fmviesa010.fm.intel.com with ESMTP; 23 Aug 2024 03:13:45 -0700
Message-ID: <34e8083e-1439-442d-a979-03ac5b65ae38@linux.intel.com>
Date: Fri, 23 Aug 2024 13:13:43 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/6] i3c: mipi-i3c-hci: Add a quirk to set Response
 buffer threshold
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>,
 Krishnamoorthi M <krishnamoorthi.m@amd.com>, linux-i3c@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240821133554.391937-1-Shyam-sundar.S-k@amd.com>
 <20240821133554.391937-7-Shyam-sundar.S-k@amd.com>
Content-Language: en-US
From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
In-Reply-To: <20240821133554.391937-7-Shyam-sundar.S-k@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/21/24 4:35 PM, Shyam Sundar S K wrote:
> The current driver sets the response buffer threshold value to 1
> (N+1, 2 DWORDS) in the QUEUE THRESHOLD register. However, the AMD
> I3C controller only generates interrupts when the response buffer
> threshold value is set to 0 (1 DWORD).
> 
> Therefore, a quirk is added to set the response buffer threshold value
> to 0.
> 
> Co-developed-by: Krishnamoorthi M <krishnamoorthi.m@amd.com>
> Signed-off-by: Krishnamoorthi M <krishnamoorthi.m@amd.com>
> Co-developed-by: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>
> Signed-off-by: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>
> Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> ---
>   drivers/i3c/master/mipi-i3c-hci/core.c       |  6 +++++-
>   drivers/i3c/master/mipi-i3c-hci/hci.h        |  2 ++
>   drivers/i3c/master/mipi-i3c-hci/hci_quirks.c | 11 +++++++++++
>   3 files changed, 18 insertions(+), 1 deletion(-)
> 
Reviewed-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

