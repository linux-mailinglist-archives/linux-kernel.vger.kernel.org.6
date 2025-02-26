Return-Path: <linux-kernel+bounces-535128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87BAFA46F4F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 00:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90D873A6783
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 23:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9F72702BF;
	Wed, 26 Feb 2025 23:19:38 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB562702A6;
	Wed, 26 Feb 2025 23:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740611978; cv=none; b=KnlJd/UqsINk0KLZ2C6PS6L3IUSD1CDfRORd0HdHNn9uXXmy5BYUufqsQI4yGVNVBfkR4tksMhBFbpwTr7oO0ykZpTg6htvY9g2lzqnTWO7MKUz7vCU2IdYRH3etPZMqbZol82ckQmhmt9LwmupKLvGiHVBEidwV1IyHCfLAQ2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740611978; c=relaxed/simple;
	bh=owaFQLkC86L8zl5qP6dwQlbJi/coAKtJa4IPFwey/bM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UrBArOCGyJtS+RLcgTSSMVfMbIoSuPNgMSY1QEQblKoyu0eU9LvdcThsOitmJChwfkYJS53nsnoOhxlP94NMtZ4ghBFaiAq4De+caErM2w8rpBh2pzmhM8cqn4rHEPEE2UciTXZiqf20VInmV9S+92numynl8glDVMss1Elo3TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 824E3C4CED6;
	Wed, 26 Feb 2025 23:19:37 +0000 (UTC)
Date: Wed, 26 Feb 2025 18:20:18 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] scripts/sorttable: Fix resource leak on file
 pointer fp
Message-ID: <20250226182018.0389f561@gandalf.local.home>
In-Reply-To: <20250226224934.594983-1-colin.i.king@gmail.com>
References: <20250226224934.594983-1-colin.i.king@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Feb 2025 22:49:34 +0000
Colin Ian King <colin.i.king@gmail.com> wrote:

> There is a resource leak on fp on an error return path in function
> parse_symbols that causes a resource leak. Fix this by adding in
> the missing fclose.

This patch has already been sent, and it's not really a leak, as when this
returns -1, it causes the program to exit and that will close all file descriptors.

I said I'll take the other patch as a clean up though.

  https://lore.kernel.org/all/20250225053724.74582-1-dheeraj.linuxdev@gmail.com/

-- Steve


> 
> Fixes: ef378c3b8233 ("scripts/sorttable: Zero out weak functions in mcount_loc table")
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  scripts/sorttable.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/sorttable.c b/scripts/sorttable.c
> index 7b4b3714b1af..e35abf28d037 100644
> --- a/scripts/sorttable.c
> +++ b/scripts/sorttable.c
> @@ -665,8 +665,10 @@ static int parse_symbols(const char *fname)
>  
>  		addr = strtoull(addr_str, NULL, 16);
>  		size = strtoull(size_str, NULL, 16);
> -		if (add_field(addr, size) < 0)
> +		if (add_field(addr, size) < 0) {
> +			fclose(fp);
>  			return -1;
> +		}
>  	}
>  	fclose(fp);
>  


