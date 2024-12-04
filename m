Return-Path: <linux-kernel+bounces-430847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1283E9E3665
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 10:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB852285C93
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 09:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB001A9B4F;
	Wed,  4 Dec 2024 09:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NyH4qiiV"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D824F18D622;
	Wed,  4 Dec 2024 09:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733304201; cv=none; b=PsU0cB25bV3ypGTgMUpyvne06UsxcIdTWkdC/7fsWXud7HWPgG4PAaHbqmHrBX0I1kET+Wnt1RegUfrcwBZuXcJhk/1PhkV0JTvKT9sa9AlPTaDsXl4FuDLUrFbJbh2Mj42hq2UrMbfkRuRMShCG9fVybEEQa2Ox1FamupSaejQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733304201; c=relaxed/simple;
	bh=BWbXJDFaI8EgLty7YFvm7ppdf4GZ7oJgBPeaxZsl3yU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QTC9gnwwMfoC6exiwmjONcpK3IoURBNR8mKc6Hd1rUux0+z92f9Ef9mNGfWAeLciZdFy6MT7WFDjHOTsjUioOpmVS/E0CbN1KFolVI8Dw73Mb/4xP5W2oaQrYszCYJPnfFQaF//Kc/sy1zPAcZ6CQMF0U4q8MXTNGoJ71w3g3So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NyH4qiiV; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733304200; x=1764840200;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BWbXJDFaI8EgLty7YFvm7ppdf4GZ7oJgBPeaxZsl3yU=;
  b=NyH4qiiVFfpHnfkL123aT3KfL6K6CY5FAYumV8B3T9bTVmYfmT78yI75
   t9oWwHIPmBXS6lUxSOWixGBMblrHH41Q3/ClXm4y8KQIZqxqGzLLPffpR
   3QTFnncygV911935mIP7QemfCExtLWRd0MIaQU1eBRnW+Kxf2h4V9ykIo
   po992i0GCMGYMoXcv0jg2j7MieA1baBGFO6zOhKkZ/JLNxsHajYyMos/H
   w/74IwuI4sy6yA6em68c72VVHaZe0ilDED7yxGqLCfcf+J5hxiY8ubYrH
   vHtMbB9//zEb9DeCOYCey3IOZTqgstWIDZT+WaA7a0qMlDeotyn2D6DME
   g==;
X-CSE-ConnectionGUID: OYzLE+ZpQnO2wnolG75yXQ==
X-CSE-MsgGUID: isxobMq1QsCGtPb1gpxIwQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="50977933"
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="50977933"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 01:23:19 -0800
X-CSE-ConnectionGUID: xC3LvTocSFKz5nyzjgXt6Q==
X-CSE-MsgGUID: RIuRbvCDTeaBd0Ph9fTK3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="97770729"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by fmviesa003.fm.intel.com with SMTP; 04 Dec 2024 01:23:15 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 04 Dec 2024 11:23:14 +0200
Date: Wed, 4 Dec 2024 11:23:14 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	chaitanya.kumar.borah@intel.com, Luca Coelho <luca@coelho.fi>
Subject: Re: [PATCH] usb: typec: ucsi: Fix connector status writing past
 buffer size
Message-ID: <Z1AfghOi8jvIEq_9@kuha.fi.intel.com>
References: <20241203200010.2821132-1-lucas.demarchi@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203200010.2821132-1-lucas.demarchi@intel.com>

On Tue, Dec 03, 2024 at 12:00:10PM -0800, Lucas De Marchi wrote:
> Similar to commit 65c4c9447bfc ("usb: typec: ucsi: Fix a missing bits to
> bytes conversion in ucsi_init()"), there was a missing conversion from
> bits to bytes. Here the outcome is worse though: since the value is
> lower than UCSI_MAX_DATA_LENGTH, instead of bailing out with an error,
> it writes past the buffer size.
> 
> The error is then seen in other places like below:
> 
> 	Oops: general protection fault, probably for non-canonical address 0x891e812cd0ed968: 0000 [#1] PREEMPT SMP NOPTI
> 	CPU: 3 UID: 110 PID: 906 Comm: prometheus-node Not tainted 6.13.0-rc1-xe #1
> 	Hardware name: Intel Corporation Lunar Lake Client Platform/LNL-M LP5 RVP1, BIOS LNLMFWI1.R00.3222.D84.2410171025 10/17/2024
> 	RIP: 0010:power_supply_get_property+0x3e/0xe0
> 	Code: 85 c0 7e 4f 4c 8b 07 89 f3 49 89 d4 49 8b 48 20 48 85 c9 74 72 49 8b 70 18 31 d2 31 c0 eb 0b 83 c2 01 48 63 c2 48 39 c8 73 5d <3b> 1c 86 75 f0 49 8b 40 28 4c 89 e2 89 de ff d0 0f 1f 00 5b 41 5c
> 	RSP: 0018:ffffc900017dfa50 EFLAGS: 00010246
> 	RAX: 0000000000000000 RBX: 0000000000000011 RCX: c963b02c06092008
> 	RDX: 0000000000000000 RSI: 0891e812cd0ed968 RDI: ffff888121dd6800
> 	RBP: ffffc900017dfa68 R08: ffff88810a4024b8 R09: 0000000000000000
> 	R10: 0000000000000000 R11: 0000000000000000 R12: ffffc900017dfa78
> 	R13: ffff888121dd6800 R14: ffff888138ad2c00 R15: ffff88810c57c528
> 	FS:  00007713a2ffd6c0(0000) GS:ffff88846f380000(0000) knlGS:0000000000000000
> 	CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> 	CR2: 000000c0004b1000 CR3: 0000000121ce8003 CR4: 0000000000f72ef0
> 	DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> 	DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 0000000000000400
> 	PKRU: 55555554
> 	Call Trace:
> 	 <TASK>
> 	 ? show_regs+0x6c/0x80
> 	 ? die_addr+0x37/0xa0
> 	 ? exc_general_protection+0x1c1/0x440
> 	 ? asm_exc_general_protection+0x27/0x30
> 	 ? power_supply_get_property+0x3e/0xe0
> 	 power_supply_hwmon_read+0x50/0xe0
> 	 hwmon_attr_show+0x46/0x170
> 	 dev_attr_show+0x1a/0x70
> 	 sysfs_kf_seq_show+0xaa/0x120
> 	 kernfs_seq_show+0x41/0x60
> 
> Just use the buffer size as argument to fix it.
> 
> Fixes: 226ff2e681d0 ("usb: typec: ucsi: Convert connector specific commands to bitmaps")
> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/ucsi/ucsi.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index c435c0835744a..69caae84879e9 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -651,7 +651,8 @@ static void ucsi_unregister_altmodes(struct ucsi_connector *con, u8 recipient)
>  static int ucsi_get_connector_status(struct ucsi_connector *con, bool conn_ack)
>  {
>  	u64 command = UCSI_GET_CONNECTOR_STATUS | UCSI_CONNECTOR_NUMBER(con->num);
> -	size_t size = min(UCSI_GET_CONNECTOR_STATUS_SIZE, UCSI_MAX_DATA_LENGTH(con->ucsi));
> +	size_t size = min(sizeof(con->status),
> +			  UCSI_MAX_DATA_LENGTH(con->ucsi));
>  	int ret;
>  
>  	ret = ucsi_send_command_common(con->ucsi, command, &con->status, size, conn_ack);
> -- 
> 2.47.0

-- 
heikki

