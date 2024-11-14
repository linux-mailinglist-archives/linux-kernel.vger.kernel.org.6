Return-Path: <linux-kernel+bounces-408865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3EE89C8470
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 09:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65CC4283CCD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 08:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62AFD1F472D;
	Thu, 14 Nov 2024 08:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZFTlStl7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BF01EBFE2
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 08:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731571258; cv=none; b=VhnbBCBhAIquXAK4RIIXWe3p7FzZTbZsRljKjp9l/naVBwAAOrIzCTckOCOz2uYTXDn2fxe9XSXt5e1L/SVmeQSl6ywth0o5+VQghFzv//3m1HJ7K/6N3yjXBkXXaqqLXP7WpWEKg0OQkoa/ksPC2SQw589iofQPYavkYAikeEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731571258; c=relaxed/simple;
	bh=da4pBsK4DBhIwCdc93CYocbC+ItcYg4K13DNt5dXyCg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AIcno7JbQZeIi2kTfqrCZkY0Fq/oh0oEG+hMknLj5WZcT5zvCrG6S9vJPezr/OW1CRzWl9nDQxy/AICBYd8/248x6BIDTveJIJOZOjUE6WXj3s4Z3ZnRWFyR3hBuckP0FIVj79KhmlcLSkajyy+DhMH+rKZXWIGFbsbEC0i9IGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZFTlStl7; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731571257; x=1763107257;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=da4pBsK4DBhIwCdc93CYocbC+ItcYg4K13DNt5dXyCg=;
  b=ZFTlStl7ql0938R7eDpO4Q3QF/VuXG3wcX8dDeHgKYtj9tAjE9MjFeIo
   2pM0W7b+AJ1XakqSV3qr6wkTbNHtN5xmjCp6ITFUjOtO5pbyoydK0XgU7
   lBqbFGPvHDz/bnL3Vcjzr/gaz5E+u4LU+lRw8ha26wbbPqBMimJhjaRM6
   41UkNvpqfCLJP/w8V72oBnD/e9R7EJLMi1/Tw33VpcAYZTyRTMwRyxFmS
   kk+PrsjgHaq6aZrIqZowOa7WwiZadbImFMC+877HDZFnzKMqb+b87/Alv
   sY8d3aDHiJBfFnYwMkDCGiGQAchcv2F5ZUGSYXToYSD6VadjW/9j+mrme
   Q==;
X-CSE-ConnectionGUID: vfjDHmyFQxOhbiN+AFu4oA==
X-CSE-MsgGUID: 31EWJPSLTZaoH11HIOgoGQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11255"; a="35290934"
X-IronPort-AV: E=Sophos;i="6.12,153,1728975600"; 
   d="scan'208";a="35290934"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2024 00:00:56 -0800
X-CSE-ConnectionGUID: y9Fj111VQ5ahIXsLyg258g==
X-CSE-MsgGUID: haOo8p+MRSCT+ytWq5K/+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,153,1728975600"; 
   d="scan'208";a="118942637"
Received: from unknown (HELO [10.237.72.151]) ([10.237.72.151])
  by orviesa002.jf.intel.com with ESMTP; 14 Nov 2024 00:00:55 -0800
Message-ID: <6ebcd448-e0c8-4b31-950c-4c73961be758@linux.intel.com>
Date: Thu, 14 Nov 2024 10:00:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] i3c: dw: Add support for AMDI0015 ACPI ID
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Sanket.Goswami@amd.com, linux-i3c@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20241108073323.523805-1-Shyam-sundar.S-k@amd.com>
 <20241108073323.523805-2-Shyam-sundar.S-k@amd.com>
Content-Language: en-US
From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
In-Reply-To: <20241108073323.523805-2-Shyam-sundar.S-k@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/8/24 9:33 AM, Shyam Sundar S K wrote:
> Add AMDI0015 _HID for Designware I3C driver so that the dw-i3c-master
> driver can be probed on AMD platforms.
> 
> Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> ---
>   drivers/i3c/master/dw-i3c-master.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
Reviewed-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

