Return-Path: <linux-kernel+bounces-291893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4864B9568A1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 12:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F05E61F21B44
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 10:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C15165EFB;
	Mon, 19 Aug 2024 10:35:09 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298F7165EE3
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 10:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724063709; cv=none; b=RwpfdvCmvg7+/R/bAkD991Kmveol5dC0NF4sJCccOY1Syvk72e/mQWUkVFA2YT7L0Q6kBK/D+p0RvXegRpK0zcoSfleXCni6fZ9T3ZD0dgocfiLKEJRcVTiXyCvh5KWIhBXBsFsmAhNoGNK+w0/4OiGFNv7blHWAIu3WIgVzIMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724063709; c=relaxed/simple;
	bh=RdSa/tpffH245cPnT1qzSVw+G3HARDAfJswJU/t6wB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n5tcC4/6UOndxj1OE0LHXf6mChhZEGvKakSRR60Y8tiPdinzCnP7Rd12EGcQmnExZ+ofqW0xXuHWsOMqm948RpvZesfQ296lY0RLc9aXXMsaARvxlWDHYM0t1oj9O2jJ/btGQGSZq2PklEpHIVgaMPEF8ajgI5qo40iRtJbGtsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0AFD6339;
	Mon, 19 Aug 2024 03:35:32 -0700 (PDT)
Received: from bogus (e107155-lin.cambridge.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 41EAB3F73B;
	Mon, 19 Aug 2024 03:35:05 -0700 (PDT)
Date: Mon, 19 Aug 2024 11:35:02 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH -next] firmware: arm_ffa: Fix beyond size of field warning
Message-ID: <ZsMf1jIfbwwmqe1m@bogus>
References: <20240816100258.2159447-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240816100258.2159447-1-ruanjinjie@huawei.com>

On Fri, Aug 16, 2024 at 06:02:58PM +0800, Jinjie Ruan wrote:
> An allmodconfig build of arm64 resulted in following warning:
> 
> 	In function ‘fortify_memcpy_chk’,
> 	    inlined from ‘export_uuid’ at ./include/linux/uuid.h:88:2,
> 	    inlined from ‘ffa_msg_send_direct_req2’ at ./drivers/firmware/arm_ffa/driver.c:488:2:
> 	./include/linux/fortify-string.h:571:25: error: call to ‘__write_overflow_field’ declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]
> 	  571 |                         __write_overflow_field(p_size_field, size);
> 	      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 	In function ‘fortify_memcpy_chk’,
> 	    inlined from ‘ffa_msg_send_direct_req2’ at ./drivers/firmware/arm_ffa/driver.c:489:2:
> 	./linux-next/include/linux/fortify-string.h:571:25: error: call to ‘__write_overflow_field’ declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]
> 	  571 |                         __write_overflow_field(p_size_field, size);
> 	      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Because ffa_msg_send_direct_req2() memcpy uuid_t and struct
> ffa_send_direct_data2 data to unsigned long dst, the copy size is 2 or
> or 14 unsigned long which beyond size of dst size, fix it by using a temp
> array for memcpy.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  drivers/firmware/arm_ffa/driver.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
> index 1e3764852118..674fbe008ea6 100644
> --- a/drivers/firmware/arm_ffa/driver.c
> +++ b/drivers/firmware/arm_ffa/driver.c
> @@ -480,13 +480,23 @@ static int ffa_msg_send2(u16 src_id, u16 dst_id, void *buf, size_t sz)
>  static int ffa_msg_send_direct_req2(u16 src_id, u16 dst_id, const uuid_t *uuid,
>  				    struct ffa_send_direct_data2 *data)
>  {
> +	unsigned long args_data[14];
> +	unsigned long args_uuid[2];
> +	unsigned long *data_ptr;
> +
>  	u32 src_dst_ids = PACK_TARGET_INFO(src_id, dst_id);
>  	ffa_value_t ret, args = {
>  		.a0 = FFA_MSG_SEND_DIRECT_REQ2, .a1 = src_dst_ids,
>  	};
>  
> -	export_uuid((u8 *)&args.a2, uuid);
> -	memcpy(&args.a4, data, sizeof(*data));
> +	memcpy(args_uuid, uuid, sizeof(uuid_t));
> +	args.a2 = args_uuid[0];
> +	args.a3 = args_uuid[1];
> +
> +	memcpy(args_data, data, sizeof(*data));
> +	data_ptr = &args.a4;
> +	for (int i = 0; i < 14; i++)
> +		*data_ptr++ = args_data[i];
>

So we end up with double copy for both uuid and ffa_send_direct_data2 ?
This is not correct and not needed.

Which toolchain are you using ? I got error only for memcpy which I forgot
to push to -next, now fixed. It must appear in -next soon.

-- 
Regards,
Sudeep

