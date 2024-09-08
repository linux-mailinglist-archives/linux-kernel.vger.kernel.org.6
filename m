Return-Path: <linux-kernel+bounces-320021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75688970520
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 07:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63088B21F6B
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 05:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853944778E;
	Sun,  8 Sep 2024 05:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EuPHpnwc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C195D7F6;
	Sun,  8 Sep 2024 05:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725772846; cv=none; b=OEhc/GwUZS6qrFoAvhDIfPapks94DL2pIDd/QLnnqyKcXF1IO52hEUQHc/bIJRdETH5oinLnFEscMwVIxcsC3x3WQ7j1EC95CeYjBMPhF47hI552phALIYZrXAuVNH7LvoEAkE1BSXXu6mHIAyE2NhmkittmIIn/mhb/UOK2jZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725772846; c=relaxed/simple;
	bh=f1Zp6AIuu3bbA6MZQpt7yaZ3+dW58hv2ReaYmPB5G8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OmAmIYUn4/9C73mw6g7uL+lLBCEE7BhqdwF6H1P9MBH10wLPK/GWep0sjQM3VcNyE2CTK3VT8Pn4KnPgtY1aZF3qk5KpR5Zi+NWozD/lNCVnWQ0oV2qCJyyKlYAoXjBvNChS5bftfNBfaZwEIn7Iw2iIA2Kbg4h0OzQ/S+trpbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EuPHpnwc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84F63C4CEC3;
	Sun,  8 Sep 2024 05:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725772846;
	bh=f1Zp6AIuu3bbA6MZQpt7yaZ3+dW58hv2ReaYmPB5G8k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EuPHpnwcKHyXGAu52SuaGdsx1WvavKKy0LxZ2cCK9qfaKlFD1+D8uaz5SssNMJe5V
	 EtQV2vrn4UOTsNnc2XvEKB4G6Db4JsJGZJVK6fCsnKoaVFAyvODkzUX2K7AJb1c3Oi
	 jiNhgdPi0Tlcm6kjHa90tnX66cMoNB146Ixb8zJQ=
Date: Sun, 8 Sep 2024 07:20:40 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Edward Adam Davis <eadavis@qq.com>
Cc: stern@rowland.harvard.edu, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	syzbot+9d34f80f841e948c3fdb@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH V3] USB: usbtmc: prevent kernel-usb-infoleak
Message-ID: <2024090810-arrogant-disallow-6f08@gregkh>
References: <3b4b8e7f-57b2-4ca1-8dc1-63faef573df3@rowland.harvard.edu>
 <tencent_5F7E6CD82F3D6FB49414E9D6EC3ACCFC780A@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_5F7E6CD82F3D6FB49414E9D6EC3ACCFC780A@qq.com>

On Sun, Sep 08, 2024 at 10:20:57AM +0800, Edward Adam Davis wrote:
> The syzbot reported a kernel-usb-infoleak in usbtmc_write.
> 
> The expression "aligned = (transfersize + (USBTMC_HEADER_SIZE + 3)) & ~3;"
> in usbtmcw_write() follows the following pattern:
> 
> aligned = (1 + 12 + 3) & ~3 = 16   // 3 bytes have not been initialized
> aligned = (2 + 12 + 3) & ~3 = 16   // 2 bytes have not been initialized
> aligned = (3 + 12 + 3) & ~3 = 16   // 1 byte has not been initialized
> aligned = (4 + 12 + 3) & ~3 = 16   // All bytes have been initialized
> aligned = (5 + 12 + 3) & ~3 = 20   // 3 bytes have not been initialized
> aligned = (6 + 12 + 3) & ~3 = 20   // 2 bytes have not been initialized
> aligned = (7 + 12 + 3) & ~3 = 20   // 1 byte has not been initialized
> aligned = (8 + 12 + 3) & ~3 = 20   // All bytes have been initialized
> aligned = (9 + 12 + 3) & ~3 = 24
> ...
> 
> Note: #define USBTMC_HEADER_SIZE      12
> 
> This results in the buffer[USBTMC_SEAD_SIZE+transfersize] and its
> subsequent memory not being initialized.
> 
> Fixes: 4ddc645f40e9 ("usb: usbtmc: Add ioctl for vendor specific write")
> Reported-and-tested-by: syzbot+9d34f80f841e948c3fdb@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=9d34f80f841e948c3fdb
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
> V2 -> V3: Update condition and comments
> 
>  drivers/usb/class/usbtmc.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/usb/class/usbtmc.c b/drivers/usb/class/usbtmc.c
> index 6bd9fe565385..faf8c5508997 100644
> --- a/drivers/usb/class/usbtmc.c
> +++ b/drivers/usb/class/usbtmc.c
> @@ -1591,6 +1591,10 @@ static ssize_t usbtmc_write(struct file *filp, const char __user *buf,
>  		goto exit;
>  	}
>  
> +	if (USBTMC_HEADER_SIZE + transfersize < aligned)
> +		memset(&buffer[USBTMC_HEADER_SIZE + transfersize], 0,
> +			aligned - USBTMC_HEADER_SIZE - transfersize);

As this is now a pain to read/understand, and there's no comment
describing it so we'll not really understand it in a few months, let
alone years, how about we just do the trivial thing and make the
allocation with kzalloc() to start with?  And put a comment there saying
why it's zeroed out.

Sorry, I thought this was going to be a lot simpler based on your first
patch than this type of logic.

thanks,

greg k-h

