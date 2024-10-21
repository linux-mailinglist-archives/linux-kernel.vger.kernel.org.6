Return-Path: <linux-kernel+bounces-373964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43AC19A5FEB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 11:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D88D91F21D9D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 09:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3FA1E3762;
	Mon, 21 Oct 2024 09:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T1uQWs/p"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838531E32B6;
	Mon, 21 Oct 2024 09:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729502705; cv=none; b=mByAmRU+6Q0MwBTov/aBXDGqdhauvvK51xkCFi6WM+a0MseHSYUT8AZze12M99GFcl1cYjscaC1fqUUzHx+UZiqIiBybUhsky7ehBqH6web53/LGuoRcNTjyovzNsfiOGIeDmrhrbMunw4igzIsg5u/2NICGU7iujf8qYLHxLB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729502705; c=relaxed/simple;
	bh=lLezU5y3KFOR//1u9nAQcWXUlr7TexFuowQWv4J6V3U=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=sssByc9wh7yW0Q2T7/vIuBH4QFtCTmQr6xWb1S1CtacWTxJ+h1VjvG0O+56VfyAOuUltQEo4boEDpCz339DOHnuuV5vwnHk5QjkABBPHRfREl0bwxAhSiMBs7JdEbiZUszRv8eaqxBi2e1RXuZmCbLL3V5dQYUvc8tRlRyrgy2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T1uQWs/p; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729502704; x=1761038704;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=lLezU5y3KFOR//1u9nAQcWXUlr7TexFuowQWv4J6V3U=;
  b=T1uQWs/pLZ1kn7E1sgOg8wWOOaCstFatvsnBqp/ujKQUara5FrwihetU
   36uTuRZBQ+JfXDoePmVlEqwQeH9hT4Ol0J1BYtu7pXJt2gJxOdaW85E3i
   clZ97jhjEKeJW60TbnZWm9zl+uAmX5UQciBsbDbx+U17F+B6rPsWlYoaw
   PyzrN1+s2sMV4i7YtLBDSy/iLT8JPzDWUtuM7YsFSW+zWSjYAmhDvd5+0
   tiQZk4fd0m8jdCrYH85uaMSo4nCeHH4/wBusIeY6XkUEGzkB0K2JDHdi4
   Bmf65BDkZoC0zJaah8gU4c7L+OLLh+5IU2jNMW2dRJMJaKlpa2GaasjJY
   A==;
X-CSE-ConnectionGUID: oxyVYjVHQua4YUDSvkSpJQ==
X-CSE-MsgGUID: zhuncSOdT+asjcd9Xtqygw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="32663245"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="32663245"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 02:25:03 -0700
X-CSE-ConnectionGUID: y7vbyc06R8Chhx+LJD0Y3Q==
X-CSE-MsgGUID: XgDLpCRZTDiD6bpS9EUOjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="84262340"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.201])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 02:25:01 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 21 Oct 2024 12:24:57 +0300 (EEST)
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc: LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org, 
    Andy Shevchenko <andy@kernel.org>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>, 
    Hans de Goede <hdegoede@redhat.com>, Ferry Toth <fntoth@gmail.com>
Subject: Re: [PATCH v2 1/3] platform/x86: intel_scu_ipc: Replace workaround
 by 32-bit IO
In-Reply-To: <20241021084053.2443545-2-andriy.shevchenko@linux.intel.com>
Message-ID: <2708af18-da90-4021-bd1b-b0491b737d6b@linux.intel.com>
References: <20241021084053.2443545-1-andriy.shevchenko@linux.intel.com> <20241021084053.2443545-2-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 21 Oct 2024, Andy Shevchenko wrote:

> The theory is that the so called workaround in pwr_reg_rdwr() is
> the actual reader of the data in 32-bit chunks. For some reason
> the 8-bit IO won't fail after that. Replace the workaround by using
> 32-bit IO explicitly and then memcpy() as much data as was requested
> by the user. The same approach is already in use in
> intel_scu_ipc_dev_command_with_size().
>
> Tested-by: Ferry Toth <fntoth@gmail.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/platform/x86/intel_scu_ipc.c | 15 ++++-----------
>  1 file changed, 4 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel_scu_ipc.c b/drivers/platform/x86/intel_scu_ipc.c
> index 5b16d29c93d7..290b38627542 100644
> --- a/drivers/platform/x86/intel_scu_ipc.c
> +++ b/drivers/platform/x86/intel_scu_ipc.c
> @@ -217,12 +217,6 @@ static inline u8 ipc_read_status(struct intel_scu_ipc_dev *scu)
>  	return __raw_readl(scu->ipc_base + IPC_STATUS);
>  }
>  
> -/* Read ipc byte data */
> -static inline u8 ipc_data_readb(struct intel_scu_ipc_dev *scu, u32 offset)
> -{
> -	return readb(scu->ipc_base + IPC_READ_BUFFER + offset);
> -}
> -
>  /* Read ipc u32 data */
>  static inline u32 ipc_data_readl(struct intel_scu_ipc_dev *scu, u32 offset)
>  {
> @@ -325,11 +319,10 @@ static int pwr_reg_rdwr(struct intel_scu_ipc_dev *scu, u16 *addr, u8 *data,
>  	}
>  
>  	err = intel_scu_ipc_check_status(scu);
> -	if (!err && id == IPC_CMD_PCNTRL_R) { /* Read rbuf */
> -		/* Workaround: values are read as 0 without memcpy_fromio */
> -		memcpy_fromio(cbuf, scu->ipc_base + 0x90, 16);
> -		for (nc = 0; nc < count; nc++)
> -			data[nc] = ipc_data_readb(scu, nc);
> +	if (!err) { /* Read rbuf */

What is the reason for the removal of that id check? This seems a clear 
logic change but why? And if you remove want to remove that check, what 
that comment then means?

> +		for (nc = 0, offset = 0; nc < 4; nc++, offset += 4)
> +			wbuf[nc] = ipc_data_readl(scu, offset);
> +		memcpy(data, wbuf, count);

So do we actually need to read more than
DIV_ROUND_UP(min(count, 16U), sizeof(u32))? Because that's the approach 
used in intel_scu_ipc_dev_command_with_size() which you referred to.

>  	}
>  	mutex_unlock(&ipclock);
>  	return err;

FYI (unrelated to this patch), there seems to be some open-coded 
FIELD_PREP()s in pwr_reg_rdwr(), some of which is common code between 
those if branches too.

-- 
 i.


