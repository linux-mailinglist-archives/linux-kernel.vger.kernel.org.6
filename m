Return-Path: <linux-kernel+bounces-344075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9191998A3E7
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 15:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB94CB20F8C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 13:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A4418C011;
	Mon, 30 Sep 2024 13:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VArNVY6f"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5581DA3D
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 13:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727701371; cv=none; b=Li6HzfIcJmvOGgvgiFv/mtQEVD2G6S8T4kvzr+E4eHXLeqCPiZezyuE9TG7gBxlvTIxRZVOezUr/AiMMR+Wsyt3e2a1lHyuKMWHskRMM/YD1kgvt6k+llCTxy/E4uPpPkI5uhIXGiP6sZO40OjSpqKN55mdrY2Nq9jNZ4ex2WCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727701371; c=relaxed/simple;
	bh=fkxcP//T2bdCrNiiepbSkSNWGrnL8P9uBimRUKy/Y3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xh4d6C1GvPXRYPhU5PsW/OsSL8ISrCoviNcUklfRyfYsXgq0oEb28cRgQ1aEQg7AV+vcRue9sQwLDiL5SJA16Fag+WioQ6CSaH9aiP9L8vZlPjpV4S0r18SRRQwxztZ4qpzaz3wtIGu5O7/jMlH6W1nX3/SjfT7NMmc8E1Mfkc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VArNVY6f; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727701370; x=1759237370;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fkxcP//T2bdCrNiiepbSkSNWGrnL8P9uBimRUKy/Y3E=;
  b=VArNVY6fv2VEe8J6C1pdz1EDGgR/f3qaSmWyPI2Q5RfwUtUjHounrYHv
   ye/nKSQdXX+MbWGuyl5NgLExwbBlq4M8tu58vg1WEfLXhflP73+p8jF3e
   8U8Ef1N0oMzcq29KmA3suJccyj0eWxCe1MvKK9bZt3B4uOPqiYtogCN1W
   7bje5c4QtjD6dypQeeNxfV+WpMcaaF5itb4xhhHAko5WzMJEyTh+2NEpV
   1SqZ//T3M6oJb94rsHa4ittKKLUQq7p8W+cZ+GMQdkrs7q+g/dWyemKEy
   Zd03+bJ/lmLUtGNhVFHWbkVrTE/1vitnWeN+eq+eJcPuo0yiS7kiZN+zh
   A==;
X-CSE-ConnectionGUID: YnKwYJHSSRG63kJIek6rdQ==
X-CSE-MsgGUID: rFrf/PUGQKKf+UTnovjTwQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11210"; a="44249662"
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="44249662"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 06:02:49 -0700
X-CSE-ConnectionGUID: IDGE5YPgQRStRbNatNEhYQ==
X-CSE-MsgGUID: txLXHwaCSB27TWZKlrI/3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="104095475"
Received: from mylly.fi.intel.com (HELO [10.237.72.151]) ([10.237.72.151])
  by orviesa002.jf.intel.com with ESMTP; 30 Sep 2024 06:02:48 -0700
Message-ID: <d0de10c7-bd99-4b81-aa11-5039c514eefc@linux.intel.com>
Date: Mon, 30 Sep 2024 16:02:46 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: TODO : i3c/master/mipi-i3c-hci/dma.c
To: cvam <cvam0000@gmail.com>, alexandre.belloni@bootlin.com
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <CADVSkwnC6b3irLx58YRGJayw09AvVUqmN=3_b35vdhJKFpsgog@mail.gmail.com>
Content-Language: en-US
From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
In-Reply-To: <CADVSkwnC6b3irLx58YRGJayw09AvVUqmN=3_b35vdhJKFpsgog@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi

On 9/28/24 9:39 PM, cvam wrote:
> Hello Alexandre
> 
> This mail is regarding TODO present in the i3c/master/mipi-i3c-hci/dma.c, i
> would like to work on it, please give some more info what exactly we are
> referring here.
> 
> 
>                                  dev_err(&hci->master.dev,
>                                          "response tid=%d when expecting
> %d\n",
>                                          tid, xfer->cmd_tid);
>                                  /* TODO: do something about it? */
>                          }
>                          if (xfer->completion)
>                                  complete(xfer->completion);
> 
Well source code has minimum handling for unexpected but uncertain what 
to do about it. In my opinion "TODO" is a fair comment about it.

I'd leave it as it until somebody sees it on real and then we can debug 
does it need some steps in HW/SW point of view to recover.

