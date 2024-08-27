Return-Path: <linux-kernel+bounces-302940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFD796054C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 11:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7EEFB2165C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 09:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2F41940B5;
	Tue, 27 Aug 2024 09:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gQBvCXQU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138CB76056
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 09:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724750130; cv=none; b=BuYHC8km7ywUeU88l9kmGR7qConrLqfOILJpfbS/c9EEIquhcgTEH/mh/5NcPFO1WZw+XmgfK8TOLn2z8emxrsVR2nNaeVyd8OWUqspAhQQZ+GeTUIhCftIXfdU2ruBretKg9BxxBIHla28OtEZtFfLXUmVw9oK2Zm4ANy5KGX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724750130; c=relaxed/simple;
	bh=xQWpjwyGez3lqvuj3nJTCm683oykMe4FI2uhRGhHJZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FffURr1E7FiL2gWBxiB6mc3mpcmFAEwAuPRKpuNgonK/g93EwZjiDuib6MmsvAiOiyujhDBxC/jgAlznlga7HMVoqmw+vR0XrPsKzVPWPJ/W9Q1Hhik74dv2jGnNT+DwKeeSNo3TB123E/5GNUZ26k8RPgeVg76JTUcwrLqRkO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gQBvCXQU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47BD6C8B7A0;
	Tue, 27 Aug 2024 09:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724750129;
	bh=xQWpjwyGez3lqvuj3nJTCm683oykMe4FI2uhRGhHJZY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gQBvCXQUKVPEqkM4Nz+dYrv7LDSgXXeTXaOb6mo4mMhX8FTlvXthCnKYpkg7u97pT
	 qXig76iFhTwALb4M9+Fuiat8+pcN2nn9eu+Xao0QFRu9WbSrbIteAKdkFEDneC2MyF
	 f/9uucBYGgLVRHLYmdxIV5eqF2TEaJ22+KR2OCtI=
Date: Tue, 27 Aug 2024 11:15:25 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: sunyiqi <sunyiqixm@gmail.com>
Cc: rafael@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpu: add CAP_SYSLOG check for reading crash_notes address
Message-ID: <2024082701-trailing-poster-6126@gregkh>
References: <20240827081133.872741-1-sunyiqixm@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827081133.872741-1-sunyiqixm@gmail.com>

On Tue, Aug 27, 2024 at 04:11:33PM +0800, sunyiqi wrote:
> CPU crash_notes value can be obtained through /sys/devices/system/cpu/\
> cpu[NUM]/crash_notes for leaking the phys address(introduced in kernel
> 5.10-rc1, but some distributions may migrate this feature to 4.x
>   kernel).
> The relevant function is crash_notes_show() in file drivers/base/cpu.c.
> 
> Though crash_notes file permission is 400 and owner is root:root,
> but in container, the root user can also read crash_notes which leads to
> information leak as most of kernel pointer value can not by read for
> root user in container without CAP_SYSLOG capability.

"most", but not all?

> In current linux kernel implementation, kernel pointer value or address
> printked by %pK is not directly exposed to root user in container. For
> kernel interface which includes those values, like /sys/kallsyms,
> /proc/net/packet, etc., address values are guarded by kernel function
> restricted_pointer(). Without CAP_SYSLOG capability, value 0 or NULL
> will be returned for reading those interfaces in container using root
> user.

I understand the request here, but why is giving the "real" kernel
pointer value somehow bad here?  What can userspace in a container do
with it?

And why not give root permissions access to it container or not?

> In restricted_pointer() and container, address values only returned by
> kernel when root user has CAP_SYSLOG capability which is not the default
> capabilities for Docker container. CAP_SYSLOG prevents root user in
> container to get kernel pointer from lots of interfaces based on printk,
> but not for cpu crash_notes.
> 
> Add CAP_SYSLOG permission check in crash_notes_show() for viewing kernel
> address.

Is this really the only place where this type of check needs to be
added?

> Fixes: aa838896d87a ("drivers core: Use sysfs_emit and sysfs_emit_at for show(device *...) functions")
> Signed-off-by: sunyiqi <sunyiqixm@gmail.com>

No cc: stable?

> ---
>  drivers/base/cpu.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
> index fdaa24bb641a..a2f27bb0ffe6 100644
> --- a/drivers/base/cpu.c
> +++ b/drivers/base/cpu.c
> @@ -156,6 +156,9 @@ static ssize_t crash_notes_show(struct device *dev,
>  	unsigned long long addr;
>  	int cpunum;
>  
> +	if (!has_capability_noaudit(current, CAP_SYSLOG))
> +		return sysfs_emit(buf, "%llx\n", 0ull);

Why not return an error?  Why is 0 ok?

thanks,

greg k-h

