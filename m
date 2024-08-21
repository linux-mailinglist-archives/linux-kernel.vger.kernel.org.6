Return-Path: <linux-kernel+bounces-295240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7269598F6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 805CC1F213ED
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6831F4CB0;
	Wed, 21 Aug 2024 09:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H2pZRAT2"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143BF1F4CA2;
	Wed, 21 Aug 2024 09:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724233094; cv=none; b=Nnqw3K1lHr25P78dascq/Vvv8VP/uioF7yy6cAYnIeMYBGu9OK99HlPzGooBYwjEtXE778SBXDXkDYuThzp0wiu03V38UBs8xyiAhEwQeA+WlTPxXS+ycIPI0qFPNm9ZVnRZK5rUy9I3zZ0ZNP+sgoDaF0Qv8xYTmkLWwFNxQDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724233094; c=relaxed/simple;
	bh=o8K/iOkxZSenB/j7yEqWNX9k5WMP1Z5uLpEhKAXgaCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IDhncXRebx/gLhbPaLMDubpcpVbhrf0CeL2VBjSC77UkC8+ArDjM1JZ5lLpo5Um8QgRQRW9aCK1zXGgfqE5NgaG5kvtvtSLQRVcabq9ON8TbDkj94WCZWmtOjWGFG/dSwPYNtKxPQ3shGS/lFrp2T9yrGbSMhewG9CJuXiHgjRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H2pZRAT2; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724233093; x=1755769093;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=o8K/iOkxZSenB/j7yEqWNX9k5WMP1Z5uLpEhKAXgaCM=;
  b=H2pZRAT2j0HUwZdQnIi/lpZ4+sgUk+Gvw8GNU3iQrwfLKGfd9dBc3YFL
   S4AAd2ExZTyVtKYE3MgVzfdSzlGLWgp06eKCqZEYXtkw3b63t3yzEvvpH
   mUn+vb1Do3qB9BngnrDzrcu8svi5O9uuWpNWyvH0Kd1DuqqthF3M4w9VT
   8JJB05ITWIbScTk3W3X3D3zfxSEP6AWVqSJd9a08GbqQy+q5DpjtmKUer
   XLPLEIE1GBtEIgBBqJjkhzNte0GZbmtMltjeC0mMP9HwWmHhK8UAYXRaX
   dk++l1NB/gpQdQNg4gfkGeENozGRyqiwV2vHC7hg4oY9lQC9KMPmDO+22
   A==;
X-CSE-ConnectionGUID: ChR27p4uS9aLm3xMsa+MiA==
X-CSE-MsgGUID: b8CZr6n8SPyufDI9HXkboQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="22451423"
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="22451423"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 02:38:12 -0700
X-CSE-ConnectionGUID: lZ2qKQs8SBiYo/uAeq+zXA==
X-CSE-MsgGUID: OukMhjCtQZK+SUCOviFURg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="60885819"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by orviesa010.jf.intel.com with ESMTP; 21 Aug 2024 02:38:10 -0700
Message-ID: <cd0cc5d1-0776-4d5f-9f3f-8261deb0e3bb@linux.intel.com>
Date: Wed, 21 Aug 2024 12:40:15 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] usb: xhci: ext-caps: Use cpu_relax() when polling
 registers
To: Zhongqiu Han <quic_zhonhan@quicinc.com>, Thinh.Nguyen@synopsys.com,
 gregkh@linuxfoundation.org, mathias.nyman@intel.com
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240820121501.3593245-1-quic_zhonhan@quicinc.com>
 <20240820121501.3593245-3-quic_zhonhan@quicinc.com>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <20240820121501.3593245-3-quic_zhonhan@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20.8.2024 15.15, Zhongqiu Han wrote:
> It is considered good practice to call cpu_relax() in busy loops, see
> Documentation/process/volatile-considered-harmful.rst. This can lower
> CPU power consumption or yield to a hyperthreaded twin processor and
> also serve as a compiler barrier. In addition, if something goes wrong
> in the busy loop at least it can prevent things from getting worse.
> 
> Signed-off-by: Zhongqiu Han <quic_zhonhan@quicinc.com>
> ---
>   drivers/usb/host/xhci-ext-caps.h | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/host/xhci-ext-caps.h b/drivers/usb/host/xhci-ext-caps.h
> index 96eb36a58738..25d148d60ab0 100644
> --- a/drivers/usb/host/xhci-ext-caps.h
> +++ b/drivers/usb/host/xhci-ext-caps.h
> @@ -144,6 +144,8 @@ static inline int xhci_find_next_ext_cap(void __iomem *base, u32 start, int id)
>   		if (offset != start && (id == 0 || XHCI_EXT_CAPS_ID(val) == id))
>   			return offset;
>   
> +		cpu_relax();
> +
>   		next = XHCI_EXT_CAPS_NEXT(val);
>   		offset += next << 2;
>   	} while (next);

Similar case as with PATCH 1/2

This isn't a busy loop polling for some value.
We traverse xhci extended capabilities until the one we are looking for is found.

Thanks
Mathias


