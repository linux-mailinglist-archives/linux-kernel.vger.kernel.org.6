Return-Path: <linux-kernel+bounces-335296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C8B97E3B6
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 23:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5896628111E
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 21:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE2776F1B;
	Sun, 22 Sep 2024 21:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="khjSdLE2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA762772A
	for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 21:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727040063; cv=none; b=A5/FSMhw4iNaUrrvIN0MgC1Y5MMVCf5p6tEASqluC3GnqwpJ4Mf3sBJNhoY9DAZW6HRwwrN5lY1PfBs1i/RHEU9SS2MYbWz4Cv8ijGPtfbkHSK1vBQWpDzTtGRuxDk9ZaXtg17a+x9twSuLoNpfx+lfYUiVp1R/Dh8k+SZAyGuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727040063; c=relaxed/simple;
	bh=xXvT2xbLlx/19IWOYFaETJQvkB6DsO1He9ca8kF21LA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kB4HqRNnPkw3S4fRU3v5NmzB1l5cEoXelXmOejss7IbjTcG0dKQNngVnbC+CQAcKvilnDDS7sXJlAs+4vHwGQWEnP79tPlwBpcIWTJgQ18M7DNQYXVxNRuXdwD8lOp1VnYrdpnqxlAclXt48yS0UGJBAk6q3kT7iz16lipoUbU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=khjSdLE2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2634CC4CEC3;
	Sun, 22 Sep 2024 21:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727040063;
	bh=xXvT2xbLlx/19IWOYFaETJQvkB6DsO1He9ca8kF21LA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=khjSdLE2QLp41n3O1zXwE3MSH6TKUGG+IEAq0mfaH4J32pw3mL8HEMDLVtm1esOOW
	 yMu1ijYYqQmAKsdLHE25mdyMJ+AUXbqnSLzo42jcMRsAuVaAYGU9R61FVSJtzhHDk0
	 if2Bfc6DBP1jcBxGKiWCLoC3PNEtmohWT6euAuuJkgvpveEQ/5bIwxjNGS8B/vfBUz
	 HMJy/sDBhUUwyb0jKL2OMmcHatNXRlhg2HHyFGrVLNq5dEic76L8BoQHil4sx5TI7m
	 2ZND67cw+O6GltZl0oPKghKKZAUHJ5w5Qm9d+A7BmlQ6/kEencuhyAeYSuSrfEPsBZ
	 Fgo6u34OJ1alg==
Date: Sun, 22 Sep 2024 11:21:02 -1000
From: Tejun Heo <tj@kernel.org>
To: andrea.righi@linux.dev
Cc: David Vernet <void@manifault.com>,
	Giovanni Gherdovich <giovanni.gherdovich@suse.com>,
	Kleber Sacilotto de Souza <kleber.souza@canonical.com>,
	Marcelo Henrique Cerri <marcelo.cerri@canonical.com>,
	Phil Auld <pauld@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Provide a sysfs enable_seq counter
Message-ID: <ZvCKPkwwC9-o2dsQ@mtj.duckdns.org>
References: <20240921193921.75594-1-andrea.righi@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240921193921.75594-1-andrea.righi@linux.dev>

Hello, Andrea.

On Sat, Sep 21, 2024 at 09:39:21PM +0200, andrea.righi@linux.dev wrote:
>  static struct attribute *scx_global_attrs[] = {
>  	&scx_attr_state.attr,
>  	&scx_attr_switch_all.attr,
>  	&scx_attr_nr_rejected.attr,
>  	&scx_attr_hotplug_seq.attr,
> +	&scx_attr_enable_seq.attr,
>  	NULL,
>  };

Can you put this in scx_sched_attrs instead as it probably would make sense
to track this per-scheduler in the future when we support stacked
schedulers.

Thanks.

-- 
tejun

