Return-Path: <linux-kernel+bounces-535838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E097CA477EE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 09:37:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA1591637D3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 08:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA20224B08;
	Thu, 27 Feb 2025 08:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LrREfj5D"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDB313A3F2
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 08:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740645417; cv=none; b=RsScIwzPFIV/rA1HmITjTCzmXDNhfkZ5WB9Sa7Z/dslGtfYOD6g5oLpHbyWWpzqi/6i34m4GwJ+FvqeOFjKHTgYRfhynPG5aqV2sc5kTEPQjEAeYMS889k65UhCLZ81RU6AKDnRbT9Ft5tZ+f1xhiBN5DJ9j+VRjSPrcHN2a4O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740645417; c=relaxed/simple;
	bh=2fgm/t8SmQha9aOuyc63QP2w702ksgRACwKPM3V0uN8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fHor9bEgPP8pJ3a1DwkS04QTceBd/F2hNpwacvS+1LnelwkM6yFpuokS0oAvp3aGFsn4rwfDGJ+/0/z4yXU5bS2+X12WOnSRIVN5E1XRbnGm8AVSAJqHJ0+P5sP+6veliueX/bAlpI6UjTUWnYHX1FEMaE08Lj3qew5CFSDQIOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LrREfj5D; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740645415; x=1772181415;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2fgm/t8SmQha9aOuyc63QP2w702ksgRACwKPM3V0uN8=;
  b=LrREfj5DiQwhVhXffllWWtK1C2cJ9daspVoAci2bRjnpZl72QoD3S+Nd
   C1dHeDQlx0k1IULMU5mCkCxlSJSQXZAIXCI67DFz6TLjX+ab2TPLOb0cY
   bew5Aksl2EDypNzEoioyjzBXFJMvM5os7DIWOylIRI32syemFrPSHuef9
   hmy8TxXq/4kwmJueI62LadFHRtrhJcpPD4y+O7dY+Jfy7m6yj9t3ikfqv
   EFqAHHNW+MEafkD8YY6W4sNJFhmmwSPWneSricLIxabzlSodJT+7okKLP
   JGQqqH5qYvqQZGPq2IdKoD8uN3EdJU50hS9zo8visWmNJtDQsG9T7Dfhx
   g==;
X-CSE-ConnectionGUID: ZziRV2OlQQabjjJyc/Uz6Q==
X-CSE-MsgGUID: B16pIJUCQruItGoXLZZVwQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="45436097"
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="45436097"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 00:36:55 -0800
X-CSE-ConnectionGUID: CWHXJ9ImRgSnInY7jL3gyQ==
X-CSE-MsgGUID: kIHcHcaHTSiywuCyrqMY1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="121969913"
Received: from akadakia-mobl2.amr.corp.intel.com (HELO [10.246.17.153]) ([10.246.17.153])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 00:36:51 -0800
Message-ID: <41667dcc-b57d-44ff-99cf-5a91dbec1e56@linux.intel.com>
Date: Thu, 27 Feb 2025 09:36:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] accel/amdxdna: Check interrupt register before
 mailbox_rx_worker exits
To: Lizhi Hou <lizhi.hou@amd.com>, ogabbay@kernel.org,
 quic_jhugo@quicinc.com, Mario.Limonciello@amd.com,
 dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, min.ma@amd.com, max.zhen@amd.com,
 sonal.santan@amd.com, king.tam@amd.com
References: <20250226161810.4188334-1-lizhi.hou@amd.com>
Content-Language: en-US
From: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20250226161810.4188334-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Reviewed-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>

On 2/26/2025 5:18 PM, Lizhi Hou wrote:
> There is a timeout failure been found during stress tests. If the firmware
> generates a mailbox response right after driver clears the mailbox channel
> interrupt register, the hardware will not generate an interrupt for the
> response. This causes the unexpected mailbox command timeout.
> 
> To handle this failure, driver checks the interrupt register before
> exiting mailbox_rx_worker(). If there is a new response, driver goes back
> to process it.
> 
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> ---
>  drivers/accel/amdxdna/amdxdna_mailbox.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/accel/amdxdna/amdxdna_mailbox.c b/drivers/accel/amdxdna/amdxdna_mailbox.c
> index de7bf0fb4594..8651b1d3c3ab 100644
> --- a/drivers/accel/amdxdna/amdxdna_mailbox.c
> +++ b/drivers/accel/amdxdna/amdxdna_mailbox.c
> @@ -348,8 +348,6 @@ static irqreturn_t mailbox_irq_handler(int irq, void *p)
>  	trace_mbox_irq_handle(MAILBOX_NAME, irq);
>  	/* Schedule a rx_work to call the callback functions */
>  	queue_work(mb_chann->work_q, &mb_chann->rx_work);
> -	/* Clear IOHUB register */
> -	mailbox_reg_write(mb_chann, mb_chann->iohub_int_addr, 0);
>  
>  	return IRQ_HANDLED;
>  }
> @@ -366,6 +364,9 @@ static void mailbox_rx_worker(struct work_struct *rx_work)
>  		return;
>  	}
>  
> +again:
> +	mailbox_reg_write(mb_chann, mb_chann->iohub_int_addr, 0);
> +
>  	while (1) {
>  		/*
>  		 * If return is 0, keep consuming next message, until there is
> @@ -379,10 +380,18 @@ static void mailbox_rx_worker(struct work_struct *rx_work)
>  		if (unlikely(ret)) {
>  			MB_ERR(mb_chann, "Unexpected ret %d, disable irq", ret);
>  			WRITE_ONCE(mb_chann->bad_state, true);
> -			disable_irq(mb_chann->msix_irq);
> -			break;
> +			return;
>  		}
>  	}
> +
> +	/*
> +	 * The hardware will not generate interrupt if firmware creates a new
> +	 * response right after driver clears interrupt register. Check
> +	 * the interrupt register to make sure there is not any new response
> +	 * before exiting.
> +	 */
> +	if (mailbox_reg_read(mb_chann, mb_chann->iohub_int_addr))
> +		goto again;
>  }
>  
>  int xdna_mailbox_send_msg(struct mailbox_channel *mb_chann,


