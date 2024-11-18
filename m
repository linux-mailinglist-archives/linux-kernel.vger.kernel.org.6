Return-Path: <linux-kernel+bounces-413052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0717F9D12C9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 15:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCE9A283AB8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 14:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09F519D890;
	Mon, 18 Nov 2024 14:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="s9UowPha"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7127483
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 14:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731939509; cv=none; b=obygbt/o8RjBU8Bg3PcSSq4OEBEjqMUBnQEJG413ImaIhZyoFdhRww8H3SXZ2vYJhwOR2NkijCKPV4/LmYisGSwEoOsULcJJIUQXUwl3MwbEAxmI/cOlzeHKRZD6YUoct3QT2ev145imySSbq0A1C5D6gIlnKLNA/20iJIsQt+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731939509; c=relaxed/simple;
	bh=zkqAl8HE8woAkTOlQkP2ja11kUGbM7LyIxqnXLPJQBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sUXU25FYXt8RqusU2bJiT/mG9RMEvUC5/Amjfmnv7ArkEVr4ioSOht9l9j3OwXA4n2cR2CnXV6pmJhZvMVmw8BBSWHgIHqaN9UIY+fR2Xn0fuCcQgZ+282mpD3Ex4aYsyJ+9hX89iAmWboTUxfeII22N2vynBAN+K46sveQoWL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=s9UowPha; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4A5CC4CECC;
	Mon, 18 Nov 2024 14:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731939508;
	bh=zkqAl8HE8woAkTOlQkP2ja11kUGbM7LyIxqnXLPJQBs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s9UowPhaxgfENxI82ffb1g+rk5uEjAIY54udZsjNEZx1oinZ6cHYh3OqiCnQywomU
	 wKravejVjwngTak4C+U/NlyHLqv/tqm8Di8ObeKcwbfquF6siItrcPJHS9tQPOsXir
	 CxbBCp/YJGKLDQSCDU06jXwDknwXnARX7X02DyOg=
Date: Mon, 18 Nov 2024 15:17:58 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/2] sysfs: attribute_group: allow registration of const
 bin_attribute
Message-ID: <2024111843-olive-handball-c703@gregkh>
References: <20241115-b4-sysfs-const-bin_attr-group-v1-0-2c9bb12dfc48@weissschuh.net>
 <20241115-b4-sysfs-const-bin_attr-group-v1-1-2c9bb12dfc48@weissschuh.net>
 <71fe4030-d6a1-47da-b8a7-28b899187168@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <71fe4030-d6a1-47da-b8a7-28b899187168@t-8ch.de>

On Mon, Nov 18, 2024 at 12:36:06PM +0100, Thomas Weißschuh wrote:
> Hi Greg,
> 
> On 2024-11-15 17:42:48+0100, Thomas Weißschuh wrote:
> 
> > [..]
> 
> > diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
> > index d713a6445a6267145a7014f308df3bb25b8c3287..0f2fcd244523f050c5286f19d4fe1846506f9214 100644
> > --- a/include/linux/sysfs.h
> > +++ b/include/linux/sysfs.h
> > @@ -106,7 +106,10 @@ struct attribute_group {
> >  					    const struct bin_attribute *,
> >  					    int);
> >  	struct attribute	**attrs;
> > -	struct bin_attribute	**bin_attrs;
> > +	union {
> > +		struct bin_attribute		**bin_attrs;
> > +		const struct bin_attribute	*const *bin_attrs_new;
> > +	};
> 
> Unfortunately this triggers warnings in two drivers.
> These incorrectly have a trailing NULL literal in their struct attribute
> definition (full list at the end of the mail):
> 
> >> drivers/perf/arm-ni.c:248:63: warning: missing braces around initializer [-Wmissing-braces]
>      248 | static const struct attribute_group arm_ni_other_attr_group = {
>          |                                                               ^
> 
> 
> vim +248 drivers/perf/arm-ni.c
> 
> 4d5a7680f2b4d0 Robin Murphy 2024-09-04  247
> 4d5a7680f2b4d0 Robin Murphy 2024-09-04 @248  static const struct attribute_group arm_ni_other_attr_group = {
> 4d5a7680f2b4d0 Robin Murphy 2024-09-04  249  	.attrs = arm_ni_other_attrs,
> 4d5a7680f2b4d0 Robin Murphy 2024-09-04  250  	NULL
> 4d5a7680f2b4d0 Robin Murphy 2024-09-04  251  };
> 4d5a7680f2b4d0 Robin Murphy 2024-09-04  252
> 
> These trailing NULLs should first be removed.
> How do you want to proceed?

Odd, it passed 0-day testing.

Just send me a patch to fix up these obvious problems, strange it built
in the first place (it's a mix of named and not named identifiers, I
thought the compiler would complain about that...)

> Cocci script and results, only the first two results are relevant at
> this moment.
> 
> 	virtual patch
> 
> 	@@
> 	identifier ag, pattrs;
> 	@@
> 
> 	  struct attribute_group ag = {
> 	    .attrs = pattrs,
> 	-   NULL
> 	  };
> 
> diff -u -p a/drivers/s390/char/con3215.c b/drivers/s390/char/con3215.c
> --- a/drivers/s390/char/con3215.c
> +++ b/drivers/s390/char/con3215.c
> @@ -803,7 +803,6 @@ static struct attribute *con3215_drv_att
> 
>  static struct attribute_group con3215_drv_attr_group = {
>  	.attrs = con3215_drv_attrs,
> -	NULL,
>  };
> 
>  static const struct attribute_group *con3215_drv_attr_groups[] = {
> diff -u -p a/drivers/perf/arm-ni.c b/drivers/perf/arm-ni.c
> --- a/drivers/perf/arm-ni.c
> +++ b/drivers/perf/arm-ni.c
> @@ -247,7 +247,6 @@ static struct attribute *arm_ni_other_at
> 
>  static const struct attribute_group arm_ni_other_attr_group = {
>  	.attrs = arm_ni_other_attrs,
> -	NULL
>  };
> 
>  static const struct attribute_group *arm_ni_attr_groups[] = {
> diff -u -p a/kernel/cpu.c b/kernel/cpu.c
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -2866,7 +2866,6 @@ static struct attribute *cpuhp_cpu_attrs
>  static const struct attribute_group cpuhp_cpu_attr_group = {
>  	.attrs = cpuhp_cpu_attrs,
>  	.name = "hotplug",
> -	NULL
>  };
> 
>  static ssize_t states_show(struct device *dev,
> @@ -2898,7 +2897,6 @@ static struct attribute *cpuhp_cpu_root_
>  static const struct attribute_group cpuhp_cpu_root_attr_group = {
>  	.attrs = cpuhp_cpu_root_attrs,
>  	.name = "hotplug",
> -	NULL
>  };
> 
>  #ifdef CONFIG_HOTPLUG_SMT
> @@ -3020,7 +3018,6 @@ static struct attribute *cpuhp_smt_attrs
>  static const struct attribute_group cpuhp_smt_attr_group = {
>  	.attrs = cpuhp_smt_attrs,
>  	.name = "smt",
> -	NULL
>  };
> 
>  static int __init cpu_smt_sysfs_init(void)

Looks sane, send me a patch?

thanks,

greg k-h

