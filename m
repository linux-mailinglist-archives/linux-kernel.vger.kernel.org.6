Return-Path: <linux-kernel+bounces-376811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3319F9AB624
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 20:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9A74284847
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 18:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC661CB309;
	Tue, 22 Oct 2024 18:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="H5nwin2W"
Received: from smtp-190f.mail.infomaniak.ch (smtp-190f.mail.infomaniak.ch [185.125.25.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22DC1C9DC5
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 18:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729623012; cv=none; b=uoj3tOYG3uhmWqlzpmf5m/o+vQih1plFkpYEvsa5Tfl0fU74mpRecRUXPiTgYHmEQfCxCo8eAvTErqCaQuuDvW4wLtEhQGYXP3Q2axD9UZJstxQIS4bv0vkBsjHRciq2ptnVgoOgC40GLbQI4H8FlpnSvDHkKhmc2bv/mWYcbxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729623012; c=relaxed/simple;
	bh=rzEfqvMCwNPvnROLLEKOHkkfJYfrE/ITRVrNm+kfwcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aJC/1TroG61NaxfKp4d0+wQi7I8ZTKi/kX6DRz/Z2/xtwXM9gC9PRdTzbifrqild9sykriLpFSMEn0b4R/l5cfUkYLinklbcoHJMvngspc6D9Md7AQMSGshmfZO0ZcdHOcDyBIORTJg5LUpXWMf/vnbW+g05HZW8RLKG/k/A+BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=H5nwin2W; arc=none smtp.client-ip=185.125.25.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10:40ca:feff:fe05:0])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XY1St0zbczkgb;
	Tue, 22 Oct 2024 20:50:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1729623006;
	bh=f/ta3AxLOvb07LysQmqxTAkTwof++RaTMAGaYQwf3Us=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H5nwin2WAeaL2gX8GHUyjL4HXE+2Y21Zp8vXzHCpagTHtadYxGFVum8mfcnjnSIr0
	 gmu6KnZ1BmC809SO/4nmMH+sILnGUFRER3zfPVG6SbiVE43b/a/gqPoys2jpp/FysG
	 Qt1KIKARmFvm1hqC2lZ4yafaHXZwPYnJyyvuMFp0=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4XY1Ss3whczLrS;
	Tue, 22 Oct 2024 20:50:05 +0200 (CEST)
Date: Tue, 22 Oct 2024 20:50:03 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Matthieu Buffet <matthieu@buffet.re>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Ivanov Mikhail <ivanov.mikhail1@huawei-partners.com>, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tahera Fahimi <fahimitahera@gmail.com>
Subject: Re: [PATCH v3 3/3] samples/landlock: Clarify option parsing behaviour
Message-ID: <20241022.Oov8ohRe4shu@digikod.net>
References: <20241019151534.1400605-1-matthieu@buffet.re>
 <20241019151534.1400605-4-matthieu@buffet.re>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241019151534.1400605-4-matthieu@buffet.re>
X-Infomaniak-Routing: alpha

On Sat, Oct 19, 2024 at 05:15:34PM +0200, Matthieu Buffet wrote:
> Clarify the distinction between filesystem variables (mandatory)
> and all others (optional).
> For optional variables, explain the difference between unset variables
> (no access check performed) and empty variables (nothing allowed for
> lists of allowed paths/ports, or no effect for lists of scopes).
> List LL_SCOPED values understood and their effect.
> 
> Signed-off-by: Matthieu Buffet <matthieu@buffet.re>
> ---
>  samples/landlock/sandboxer.c | 29 +++++++++++++++--------------
>  1 file changed, 15 insertions(+), 14 deletions(-)
> 
> diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
> index 38fc6ebd7222..96b451cf0531 100644
> --- a/samples/landlock/sandboxer.c
> +++ b/samples/landlock/sandboxer.c
> @@ -296,23 +296,24 @@ static bool check_ruleset_scope(const char *const env_var,
>  /* clang-format off */
>  
>  static const char help[] =
> -	"usage: "
> -	ENV_FS_RO_NAME "=\"...\" "
> -	ENV_FS_RW_NAME "=\"...\" "
> -	ENV_TCP_BIND_NAME "=\"...\" "
> -	ENV_TCP_CONNECT_NAME "=\"...\" "
> -	ENV_SCOPED_NAME "=\"...\" %1$s <cmd> [args]...\n"
> +	"usage: " ENV_FS_RO_NAME "=\"...\" " ENV_FS_RW_NAME "=\"...\" "
> +	"[other environment variables] %1$s <cmd> [args]...\n"
>  	"\n"
> -	"Execute a command in a restricted environment.\n"
> +	"Execute the given command in a restricted environment.\n"
> +	"Multi-valued settings (lists of ports, paths, scopes) are colon-delimited.\n"
>  	"\n"
> -	"Environment variables containing paths and ports each separated by a colon:\n"
> -	"* " ENV_FS_RO_NAME ": list of paths allowed to be used in a read-only way\n"
> -	"* " ENV_FS_RW_NAME ": list of paths allowed to be used in a read-write way\n"
> +	"Mandatory settings:\n"
> +	"* " ENV_FS_RO_NAME ": paths allowed to be used in a read-only way\n"
> +	"* " ENV_FS_RW_NAME ": paths allowed to be used in a read-write way\n"
>  	"\n"
> -	"Environment variables containing ports are optional and could be skipped.\n"
> -	"* " ENV_TCP_BIND_NAME ": list of ports allowed to bind (server)\n"
> -	"* " ENV_TCP_CONNECT_NAME ": list of ports allowed to connect (client)\n"
> -	"* " ENV_SCOPED_NAME ": list of scoped IPCs\n"
> +	"Optional settings (when not set, their associated access check "
> +	"is always allowed, which is different from an empty string which "
> +	"means an empty list)\n"

I would just add ":" at the end of the line.  No need to send another
patch for that.

> +	"* " ENV_TCP_BIND_NAME ": ports allowed to bind (server)\n"
> +	"* " ENV_TCP_CONNECT_NAME ": ports allowed to connect (client)\n"
> +	"* " ENV_SCOPED_NAME ": actions denied on the outside of the landlock domain\n"
> +	"  - \"a\" to restrict opening abstract unix sockets\n"
> +	"  - \"s\" to restrict sending signals\n"
>  	"\n"
>  	"Example:\n"
>  	ENV_FS_RO_NAME "=\"${PATH}:/lib:/usr:/proc:/etc:/dev/urandom\" "
> -- 
> 2.39.5
> 
> 

