Return-Path: <linux-kernel+bounces-188656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6918CE4FA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 13:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ED2C1C2139C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 11:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C593A8625F;
	Fri, 24 May 2024 11:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A8fdJMwO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0476F8624B
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 11:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716551326; cv=none; b=d22zn4qjXbbA3y23KSNGi00MldUE96z4AXW1eJA5WqyAa1OdOBmVADc+uiBLq+RlxEB/t4JrAW3+QH/7HVEdTWEju7zcFK2JNXPVW+9Hekv/A4MajYfB1kWEQgP15Gbtp70hnf+WqH4pV7Z8gLgYWCLWlQnPpX/Bfw7U4Tj7RyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716551326; c=relaxed/simple;
	bh=gtWh5abJ4RgJ37MQ6UElH+W5h+wMAq5hU4/UmO3u/9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XKI4Pd0nROmIOyyaiyeblLMWl2SWnSeANit7LqPeAoVASsiDVqStiTgWDPA12YdJ2IGMQb/1wR3up+z92XeCtHh+P9APwplfT82HznjzXzDQEK5O2vlrUUOOfDigUbe0jVgdiODEWgiNtWC/YIK+Im6M0gnx6wch//ljHWYqbiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A8fdJMwO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67959C2BBFC;
	Fri, 24 May 2024 11:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716551325;
	bh=gtWh5abJ4RgJ37MQ6UElH+W5h+wMAq5hU4/UmO3u/9A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A8fdJMwOF/BdS+PKqLzkJsnS8IFYxWDcf3qG2Aeqa6aM8C3T8U0mSuJGnmQrBqHqt
	 uZC8Rv9WOYZV5oD3sJUrIVL4NabgP+1oQe87a8YtsmCA5hVs5D6L72zFjns3fnctnj
	 qYeisKCDgiHtCsPbe8o2GzEdRT1pPfZRAong+Q4VUlfsmdxU3jslgOGM2oRixc0DZ/
	 da4SxX126HNORHAgMx42m2NmMb9/kvdsOfQMhYiqo1tIk/5hByt7Xvxvd3N8dt8TTX
	 Er1hcaXFxd66UQFOrHOnvw9KDTdGAQiyTGAHhiBcf7vwD1qryJUyyOvW9OgG2W9hjv
	 hl5adCzxhlj+w==
Date: Fri, 24 May 2024 13:48:40 +0200
From: Christian Brauner <brauner@kernel.org>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: linux-kernel@vger.kernel.org, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, "Eric W . Biederman" <ebiederm@xmission.com>, 
	javier@dowhile0.org, Andrew Morton <akpm@linux-foundation.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nhat Pham <nphamcs@gmail.com>, Petr Mladek <pmladek@suse.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Yoann Congal <yoann.congal@smile.fr>
Subject: Re: [PATCH] userns: Default to 'yes' when CONFIG_MEMCG option is
 enabled
Message-ID: <20240524-beurkunden-kantig-101649d6b5cf@brauner>
References: <20240524082434.657573-1-javierm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240524082434.657573-1-javierm@redhat.com>

On Fri, May 24, 2024 at 10:24:16AM +0200, Javier Martinez Canillas wrote:
> The default value for the CONFIG_USER_NS Kconfig symbol changed over time.
> 
> When first was introduced by commit acce292c82d4 ("user namespace: add the
> framework"), the default was 'no'. But then it was changed to 'yes' if the
> CONFIG_NAMESPACES option was enabled, by commit 17a6d4411a4d ("namespaces:
> default all the namespaces to 'yes' when CONFIG_NAMESPACES is selected").
> 
> Then, commit 5673a94c1457 ("userns: Add a Kconfig option to enforce strict
> kuid and kgid type checks") changed the default to 'no' again and selected
> the (now defunct) UIDGID_STRICT_TYPE_CHECKS option.
> 
> This selected option was removed by commit 261000a56b63 ("userns: Remove
> UIDGID_STRICT_TYPE_CHECKS"), but CONFIG_USER_NS default was left to 'no'.
> 
> Finally, the commit e11f0ae388f2 ("userns: Recommend use of memory control
> groups") added to the Kconfig symbol's help text a recommendation that the
> memory control groups should be used, to limit the amount of memory that a
> user who can create user namespaces can consume.
> 
> Looking at the changes' history, a default to 'yes' when the CONFIG_MEMCG
> option is enabled seems like a sane thing to do. Specially since systemd
> requires user namespaces support for services that use the PrivateUsers=
> property in their unit files (e.g: the UPower daemon).

Fyi, user namespaces are an entirely optional feature in systemd and it
gracefully falls back if they are not available with PrivateUsers= set.
If that isn't the case then it's a bug in systemd with PrivateUsers=
handling and should be reported.

But specifically to you change, afair CONFIG_MEMCG and userns are
unrelated so tying them together like this in the kconfig seems
misguided.

