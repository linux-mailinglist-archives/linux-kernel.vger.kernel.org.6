Return-Path: <linux-kernel+bounces-365371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5839F99E15A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 10:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E4A2281FE7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 08:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134A11CC891;
	Tue, 15 Oct 2024 08:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tz67ruPL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F83D17335E;
	Tue, 15 Oct 2024 08:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728981651; cv=none; b=IpvuaGz6huyaEBQBjuZz5RDeMVoHS3u5BmqACWnKjOIs50DXA+FGbEhRIqWt9M1Q9kXdN+K2sLybr7KDHJIum0tu/FFzsBfOe74L2rdD0H9upxu+ObKsZzsd0tHTgkz+7Gmpaqko8CZWNIqXh2u1SoPtKG8e2eZm8tHrcKxyCJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728981651; c=relaxed/simple;
	bh=fnvz8GVQr2mnOGUgDHGqja/n6PQ9tkzXbBSmSbkZ3Kw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iHFisS+IVocsHc8WcZLJXa5bKyhLLhQ80J9mKpngSyxiuS/apoS4NtULSMLCJLZpY60TuiH5WWzRigEPOng+OPRrNzfvnoDUh7PUG2buobDiD9Fj9harkrBKBivYj2fSpAEsX54TZ4dciXo3uShzNYIudc5b6SCnnP1jS5aGWYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tz67ruPL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6B10C4CEC7;
	Tue, 15 Oct 2024 08:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728981651;
	bh=fnvz8GVQr2mnOGUgDHGqja/n6PQ9tkzXbBSmSbkZ3Kw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tz67ruPLVDSsy2rPzDRsy1gn7KCMMXuD3oNvGcfWRwKjhQZ/bnQ5IPb+zBQUxEzMi
	 1efJdMCzjpaK+K7GOQMeVRlv+JnqOJ9uFZHWU5cYUcjRWQiugMsEY8IUcdCnChYu6E
	 f0yxgV1CtdSZSSPTfBypL+GvPvK2BDSz/GY4tVtwsyVv9KNIPCE8a/s3jaA/mOvJSq
	 cbHLMdF+D5bCySlhs9VLnNgYT0nEbHrLiSaaRug5CJTGnAk6PKYXoaFzOFnBaDOwxa
	 iiy49jQY4/n6Xb9/Y4wU5GWluiYA2ccJrCz5hNQl1BrhC/bbOmutP69xcF8BfaAzYH
	 mVzm3Avtdj3Ww==
Received: by pali.im (Postfix)
	id E62C879D; Tue, 15 Oct 2024 10:40:43 +0200 (CEST)
Date: Tue, 15 Oct 2024 10:40:43 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Armin Wolf <W_Armin@gmx.de>
Cc: hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	siddharth.manthan@gmail.com
Subject: Re: [PATCH] platform/x86: dell-wmi: Ignore suspend notifications
Message-ID: <20241015084043.f2yzv4j7rvf6kajf@pali>
References: <20241014220529.397390-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241014220529.397390-1-W_Armin@gmx.de>
User-Agent: NeoMutt/20180716

On Tuesday 15 October 2024 00:05:29 Armin Wolf wrote:
> Some machines like the Dell G15 5155 emit WMI events when
> suspending/resuming. Ignore those WMI events.
> 
> Tested-by: siddharth.manthan@gmail.com
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

Looks good,

Acked-by: Pali Rohár <pali@kernel.org>

> ---
> For some reason mjg59@srcf.ucam.org causes a local error in processing.
> ---
>  drivers/platform/x86/dell/dell-wmi-base.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/platform/x86/dell/dell-wmi-base.c b/drivers/platform/x86/dell/dell-wmi-base.c
> index 502783a7adb1..24fd7ffadda9 100644
> --- a/drivers/platform/x86/dell/dell-wmi-base.c
> +++ b/drivers/platform/x86/dell/dell-wmi-base.c
> @@ -264,6 +264,15 @@ static const struct key_entry dell_wmi_keymap_type_0010[] = {
>  	/*Speaker Mute*/
>  	{ KE_KEY, 0x109, { KEY_MUTE} },
> 
> +	/* S2Idle screen off */
> +	{ KE_IGNORE, 0x120, { KEY_RESERVED }},
> +
> +	/* Leaving S4 or S2Idle suspend */
> +	{ KE_IGNORE, 0x130, { KEY_RESERVED }},
> +
> +	/* Entering S2Idle suspend */
> +	{ KE_IGNORE, 0x140, { KEY_RESERVED }},
> +
>  	/* Mic mute */
>  	{ KE_KEY, 0x150, { KEY_MICMUTE } },
> 
> --
> 2.39.5
> 

