Return-Path: <linux-kernel+bounces-558731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 985F0A5EA1E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 04:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E59383B6AF4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 03:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB7426ACD;
	Thu, 13 Mar 2025 03:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XpyCoBJY"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE23E127E18
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 03:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741836608; cv=none; b=pazfrTmDpoYPGUTra8c8zjn4Q8bHqrUIqaxkZnotgztlNwa3rChvdXpslRTlvLZMiQthuCQfM6l3OodXGk5JITZROVwxsql7D9HS8/aDJMsMNz6Knyrmb67IqiUGAjnW6znawIV3lvtpIAATCmpVtXpI/zBhREM99b9wQCoNXz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741836608; c=relaxed/simple;
	bh=bbBZi6MVy7nlRnL/DgCQhanz6APDqugq2ukfGiqGxyE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qP1nHtnSIzyYe1NrcZNqQCCwupCY4cy/LTYn8y0FE1v4cG2TQdtj9M5EpUuNqASEdTlYIy8YYQqaKEQT6o3OKBvoYbKU044P0QWkKCXgbgbcH1Z6/1xjKor0PfqlOy8o/cB2AT0d6ewa8OTQ/b5VOfWjp7A4s7WH5v+BF8v8gDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XpyCoBJY; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741836606; x=1773372606;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bbBZi6MVy7nlRnL/DgCQhanz6APDqugq2ukfGiqGxyE=;
  b=XpyCoBJYrIKdwjrObShLt1scT5z7le1ZxSOT4Tx/CKQ9b792Zuo6wRvA
   cqe1iknO8eFIUIjeUpIpoXM+CAwbTteKbRe4aciuKaTvfmTtJXkeH78HQ
   +uNJMvbic+csokLNTlkh3UBONlNnlaHzF9LTDaCtuHXwXhlgIAm1UBpqu
   reY3NoYjJnW5QsP9TCzuZo2FYKK88m2YUuX2ONn0ZvBTuG/ErU4B//uET
   009XZk2IWb6XDqtNIf/baiSgUDhXkw+cLiSPfJLe+JCy8AbeoKQOrcdd2
   jlo9yl7B8QpNlSXzNj/9Qd/mmCfQw+pQBr/QEFTfYDkhoS+oc8BE+97Y5
   w==;
X-CSE-ConnectionGUID: zHxoy6aDSkCr1IvnZbj2Og==
X-CSE-MsgGUID: PNAqLR8rQfuNNQ+tUIwIpA==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="43119429"
X-IronPort-AV: E=Sophos;i="6.14,243,1736841600"; 
   d="scan'208";a="43119429"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 20:30:06 -0700
X-CSE-ConnectionGUID: fRmeCmNuQYSezUKtRI/7Hw==
X-CSE-MsgGUID: dq7yv8nzQDuSJpU21wn95A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,243,1736841600"; 
   d="scan'208";a="126006587"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 20:30:04 -0700
Message-ID: <1b0badd7-c046-466c-8261-ecfb85248b7a@linux.intel.com>
Date: Thu, 13 Mar 2025 11:26:47 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu: Don't warn prematurely about dodgy probes
To: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org, will@kernel.org
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <72a4853e7ef36e7c1c4ca171ed4ed8e1a463a61a.1741791691.git.robin.murphy@arm.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <72a4853e7ef36e7c1c4ca171ed4ed8e1a463a61a.1741791691.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/12/25 23:01, Robin Murphy wrote:
> The warning for suspect probe conditions inadvertently got moved too
> early in a prior respin - it happened to work out OK for fwspecs, but in
> general still needs to be after the ops->probe_device call so drivers
> which filter devices for themselves have a chance do do that.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Fixes: bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper probe 
path")

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Thanks,
baolu

