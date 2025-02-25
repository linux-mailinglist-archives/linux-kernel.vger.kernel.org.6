Return-Path: <linux-kernel+bounces-531791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3821A444FC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9B213AA5D6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6B2156F3A;
	Tue, 25 Feb 2025 15:52:17 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BE81514EE
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 15:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740498737; cv=none; b=u/IYjR6wEw6Rzyc806D4BPJzNnkKOdG3rex7sSnTeWpYLlP56+NSqNU6WporBZdzQgD0H6C/yydHKtXxod8B7o++6XcRGBT8fdULYYCpprSc1d2Sg6z4QDaYobGQeJOIU4SJSjMTfW3KFbwpqbE3NMWDrKjWZBI3rEYuAZhDV38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740498737; c=relaxed/simple;
	bh=sQgFwV6jCbkrFxsp8hhSwtQMuYAKNFUbyLqEtYKWat8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RJJSIfZ8r5ulnD5zMkd8VCqQ90s6Wx21qec+WVqySNqCwjIl70e2M3XD8vUsQIUpYT9EuIWCYdUQT2jscYe064Yh5Q48c+YFOx4iH0sXbF+UZytq/aM5FMXDZxQ/woHUlAQbg75szevKunEnzDK+slZeQBS0pRrowoV1O5h1pNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51E5FC4CEDD;
	Tue, 25 Feb 2025 15:52:15 +0000 (UTC)
Date: Tue, 25 Feb 2025 10:52:53 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
Cc: catalin.marinas@arm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH scripts] scripts/sorttable: Fix resource leak in
 parse_symbols()
Message-ID: <20250225105253.350285b9@gandalf.local.home>
In-Reply-To: <20250225053724.74582-1-dheeraj.linuxdev@gmail.com>
References: <20250225053724.74582-1-dheeraj.linuxdev@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Feb 2025 11:07:24 +0530
Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com> wrote:

> Fix a resource leak in parse_symbols() where the file pointer fp
> was not closed if add_field() returned an error. This caused an
> open file descriptor to remain unclosed. Ensure that fp is properly
> closed before returning an error.
> 
> Fixes: ef378c3b8233 ("scripts/sorttable: Zero out weak functions in mcount_loc table")

Thanks, but this isn't needed. If it returns -1 it will exit the program.
When a program exits, it will close all opened file descriptors.

I may add it just because it's proper to close descriptors in case this
function is used for something else (highly unlikely). But it's not fixing
anything, and there is no "leak".

-- Steve


> Signed-off-by: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
> ---
>  scripts/sorttable.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/sorttable.c b/scripts/sorttable.c
> index 23c7e0e6c024..b9b066c1afee 100644
> --- a/scripts/sorttable.c
> +++ b/scripts/sorttable.c
> @@ -662,8 +662,10 @@ static int parse_symbols(const char *fname)
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


