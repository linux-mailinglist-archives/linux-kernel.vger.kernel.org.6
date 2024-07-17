Return-Path: <linux-kernel+bounces-254922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CAFB933952
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 10:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4A9F1F21FA4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 08:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DCF039879;
	Wed, 17 Jul 2024 08:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fTlGwY84"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEC61CA9F;
	Wed, 17 Jul 2024 08:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721205867; cv=none; b=cDyucxef7a8shpFMQ1YkgQRIKW51yyWi2+9CWOfZVZpvk4Zq/MkOLNIfEBM3Xa6ZfWt7GRhT/jnoPmz5v5KRv80UkTNruT9GeAngVnOfdAPDh0622gDoEQTuCh6LCcoZeS3TvqJeMqjeotm49wOztm9yZJVI08FpBM+AExARWEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721205867; c=relaxed/simple;
	bh=pp8ecDqCWu3ffOiI8I0C47ny69ipdzZxE83fouoYMJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XdLphkx99wmXc6D0re6KDKuNcYWJbaecw3eUWUnDRLBgcgWnt1EyBhhd1U40GHCIK4cF80PV39pdjY67PWfQMQt3AMClcYwceU+bJ4JorUh+fONb6CoKqc8OjwF6AXckHuQ5F7is3wnFgxXJ9tFOJmjXaQ2XQzmM1kI0WavpjBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fTlGwY84; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38C46C32782;
	Wed, 17 Jul 2024 08:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721205866;
	bh=pp8ecDqCWu3ffOiI8I0C47ny69ipdzZxE83fouoYMJ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fTlGwY84J8YJ4lkSlXycm5Ln4KdZHikMjrp6NvXhpKfCd2SZgvAQp/fXVbEMNV3BQ
	 /pvMeMKj0RbSsHTUvxM5zE06aop3Hchnlglt4yE4D2lDm0nKjR4ZtYQbMZXnEtiIFo
	 Gi+CgbXdA+emZzkY06b5K9Qv02TcweezR1vyOgS8=
Date: Wed, 17 Jul 2024 10:44:23 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Akshay Gupta <akshay.gupta@amd.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux@roeck-us.net, arnd@arndb.de, naveenkrishna.chatradhi@amd.com
Subject: Re: [PATCH v2 3/8] misc: amd-sbi: Add support for AMD_SBI IOCTL
Message-ID: <2024071719-boil-curvy-48df@gregkh>
References: <20240717081027.2079549-1-akshay.gupta@amd.com>
 <20240717081027.2079549-4-akshay.gupta@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717081027.2079549-4-akshay.gupta@amd.com>

On Wed, Jul 17, 2024 at 08:10:22AM +0000, Akshay Gupta wrote:
> +/* These are byte indexes into data_in and data_out arrays */
> +#define RD_WR_DATA_INDEX	0
> +#define REG_OFF_INDEX		0
> +#define REG_VAL_INDEX		4
> +#define RD_FLAG_INDEX		7
> +
> +#define MB_DATA_SIZE		4

These are VERY badly named global defines for all of the kernel and
userspace.  But most importantly, do you even need them here?  If so,
please provide something sane.


> +
> +struct apml_message {
> +	/* message ids:
> +	 * Mailbox Messages:	0x0 ... 0x999
> +	 */
> +	__u32 cmd;
> +
> +	/*
> +	 * 8 bit data for reg read,
> +	 * 32 bit data in case of mailbox,
> +	 */
> +	union {
> +		__u32 mb_out[2];
> +		__u8 reg_out[8];
> +	} data_out;
> +
> +	/*
> +	 * [0]...[3] mailbox 32bit input
> +	 * [7] read/write functionality
> +	 */
> +	union {
> +		__u32 mb_in[2];
> +		__u8 reg_in[8];
> +	} data_in;
> +} __attribute__((packed));
> +
> +/* ioctl command for mailbox msgs using generic _IOWR */
> +#define AMD_SBI_BASE_IOCTL_NR	0xF9
> +#define SBRMI_IOCTL_CMD		_IOWR(AMD_SBI_BASE_IOCTL_NR, 0, struct apml_message)

Why is the ioctl command not prefixed with AMD_SBMI_BASE as well?

thanks,

greg k-h

