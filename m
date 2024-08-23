Return-Path: <linux-kernel+bounces-298890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB72A95CCCB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 14:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A69E5287EB8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 12:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56359185B55;
	Fri, 23 Aug 2024 12:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J6njZBo9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D644186287
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 12:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724417295; cv=none; b=g/0Vw2j5b54+oIbslWOJY5B6p9Imkrg/il+PEVgwnpLJvirLevCuS+rUtSAjS3jXmBioM4EElUEhDMqP8yWPtl7UcZXtk7VmE1ySEqlnpYueqGIh76kFnRaJAw5INHrPVGhBQD5Q1LC/19NT89HJ5mlN40qRzMMxmP8ND6GbGZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724417295; c=relaxed/simple;
	bh=IAqcMqU8mCp77ZE2JJJNSsjrrmdmH41CGEMxBizPaSQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tPoaP62i78C/qf/oMUsUx7UYP6kp/Gbs/sYBMnwQbPd67jOSTpCawZQtWe/tnMoHn23kVD1AuFVEhzvOGbGzICA3IdK3aSHNw+iuaPWDbZrD1WynVHAdM19oS9CM84kmgwH+TNAlnyCtxnrfUYeGUgzc+kxDyHptDF+onLRAaRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J6njZBo9; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724417292; x=1755953292;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=IAqcMqU8mCp77ZE2JJJNSsjrrmdmH41CGEMxBizPaSQ=;
  b=J6njZBo97yt2fBincVo/FhBs93/7vJX7TBR2fINjMWU1WVWeXmh6yMUp
   8Wke1+0SOmO3QqQ+J3poVYw1Qgh+CiUHIpIOulACP1wGCbU0bVKrVhFYn
   2gTsN57m3suzG+8HeLYJJQiWvEgr1v6HNF0aRKRHLHZ6epSkm2VRdbeil
   OfD22tUyX6jf4UxVIbslQnWYFYLPX76ZXFKaMrVtbWnL8EnaGorFjTf+q
   JHL3XW+gGUZG+GYzOnn4/lLgk7cWr4O4Zb0nLzJK6/P8may5WjQ/Y/rw6
   PAIfO/4BA7Npoz8oH3SnuWfeNTfuZYbWqwkUUJzZXxkWUutyBXoqF5PdA
   g==;
X-CSE-ConnectionGUID: 7jbBWW6sTOq6jXbCucCagw==
X-CSE-MsgGUID: 8VkFjDvbQQaCd/9a8CZFEw==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="25777033"
X-IronPort-AV: E=Sophos;i="6.10,170,1719903600"; 
   d="scan'208";a="25777033"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 05:48:12 -0700
X-CSE-ConnectionGUID: 7VIo5akBRryUwe8G7Xjlig==
X-CSE-MsgGUID: YIMoobw5Se6RXftgBh8F1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,170,1719903600"; 
   d="scan'208";a="62507011"
Received: from mylly.fi.intel.com (HELO [10.237.72.154]) ([10.237.72.154])
  by orviesa008.jf.intel.com with ESMTP; 23 Aug 2024 05:48:10 -0700
Message-ID: <473d838e-7b19-46b7-99a1-73fb8037188b@linux.intel.com>
Date: Fri, 23 Aug 2024 15:48:09 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i3c/master: cmd_v1: Fix the exit criteria for the daa
 procedure
To: Billy Tsai <billy_tsai@aspeedtech.com>, alexandre.belloni@bootlin.com,
 linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240823062535.3073706-1-billy_tsai@aspeedtech.com>
Content-Language: en-US
From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
In-Reply-To: <20240823062535.3073706-1-billy_tsai@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi

On 8/23/24 9:25 AM, Billy Tsai wrote:
> The exit criteria for the DAA should check if the data length is equal to
> 1, instead of checking if the response status is equal to 1.
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
>   drivers/i3c/master/mipi-i3c-hci/cmd_v1.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i3c/master/mipi-i3c-hci/cmd_v1.c b/drivers/i3c/master/mipi-i3c-hci/cmd_v1.c
> index d97c3175e0e2..6a781f89b0e4 100644
> --- a/drivers/i3c/master/mipi-i3c-hci/cmd_v1.c
> +++ b/drivers/i3c/master/mipi-i3c-hci/cmd_v1.c
> @@ -339,7 +339,7 @@ static int hci_cmd_v1_daa(struct i3c_hci *hci)
>   			break;
>   		}
>   		if (RESP_STATUS(xfer[0].response) == RESP_ERR_NACK &&
> -		    RESP_STATUS(xfer[0].response) == 1) {
> +		    RESP_DATA_LENGTH(xfer->response) == 1) {
>   			ret = 0;  /* no more devices to be assigned */
>   			break;
>   		}
Did you accidentally resend this from a local tree? Is this the same 
than your commit cbf871e6d8ce ("i3c/master: cmd_v1: Fix the exit 
criteria for the daa procedure")?

