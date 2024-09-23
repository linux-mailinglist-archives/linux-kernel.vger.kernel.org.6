Return-Path: <linux-kernel+bounces-336138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C04B97EF9E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 18:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85F1FB21A2D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 16:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDDA519F104;
	Mon, 23 Sep 2024 16:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iIk6NOHK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A7519E995
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 16:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727110411; cv=none; b=Fpg4ZaOpDT9dh50Z9rhathy7z00QdObepLBlQh8VR9Tu57bKPuV2iaS8hqj8itffeb/TVeMQHxOJRWPmIUgstVz53UKq1lik7ccrBmDUl6ohMuEDnT9EaL7BWuXav1fVBmaXSLT0r6a02Ro98NmWVoJj2BpHkbXrCM5LOuGf1mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727110411; c=relaxed/simple;
	bh=AOekrjMAf/E4H0CF4ZooYTUhSwrWXAefAA03HBlNfSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H3Yp800m5xTrK6ybASMi+8xPL2zdlHJFrTzugBEgpM/XcxpGtOmx86timrO74U6V2kiK/8j6oiws+bszetKEmxZLjOt108Wz8yRTZFGkKrFxtOWD9/tWCr23Xeln6Lfvc2FKk6gWopx8WhZg49SsgIk3zLEi5XIlS6njnP+mJ7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iIk6NOHK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5AD5C4CEC4;
	Mon, 23 Sep 2024 16:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727110410;
	bh=AOekrjMAf/E4H0CF4ZooYTUhSwrWXAefAA03HBlNfSc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iIk6NOHKeikLefnU7mW03NYTl0X+6urhODEJ3/Cvs8es9Iuz9YQ4pPzuA79R9bA1i
	 wArQS68rL2KJtsPb/tc1gLKR2tpdbI77tMDvOOcW8iMIflnxllzEh0VAPgs7ztM+3H
	 w9RM7YCP/E9Te3cazmatsr39VMdfKI7lk3gdqanIGCbDIGZV+frokd/dAl396CMuiB
	 lGWliDlKMuvBJw8HK/OkNRO801dy37tWVxg2A9mxyI4AmORT+AgHUUUPZB1fWVz/fZ
	 pvsGRJkiRKjtBWVthV4n4W6zfRlaPfeC+ExJGN4ZZZFm5VEwxPWTRhHVkf+KAAeaLo
	 YaYFRUtzyv28Q==
Date: Mon, 23 Sep 2024 06:53:29 -1000
From: Tejun Heo <tj@kernel.org>
To: andrea.righi@linux.dev
Cc: David Vernet <void@manifault.com>,
	Giovanni Gherdovich <giovanni.gherdovich@suse.com>,
	Kleber Sacilotto de Souza <kleber.souza@canonical.com>,
	Marcelo Henrique Cerri <marcelo.cerri@canonical.com>,
	Phil Auld <pauld@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Provide a sysfs enable_seq counter
Message-ID: <ZvGdCQ1G5eoxEUX3@slm.duckdns.org>
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

On Sat, Sep 21, 2024 at 09:39:21PM +0200, andrea.righi@linux.dev wrote:
> From: Andrea Righi <andrea.righi@linux.dev>
> 
> As discussed during the distro-centric session within the sched_ext
> Microconference at LPC 2024, introduce a sequence counter that is
> incremented every time a BPF scheduler is loaded.
> 
> This feature can help distributions in diagnosing potential performance
> regressions by identifying systems where users are running (or have ran)
> custom BPF schedulers.
> 
> Example:
> 
>  arighi@virtme-ng~> cat /sys/kernel/sched_ext/enable_seq
>  0
>  arighi@virtme-ng~> sudo scx_simple
>  local=1 global=0
>  ^CEXIT: unregistered from user space
>  arighi@virtme-ng~> cat /sys/kernel/sched_ext/enable_seq
>  1
> 
> In this way user-space tools (such as Ubuntu's apport and similar) are
> able to gather and include this information in bug reports.
> 
> Cc: Giovanni Gherdovich <giovanni.gherdovich@suse.com>
> Cc: Kleber Sacilotto de Souza <kleber.souza@canonical.com>
> Cc: Marcelo Henrique Cerri <marcelo.cerri@canonical.com>
> Cc: Phil Auld <pauld@redhat.com>
> Signed-off-by: Andrea Righi <andrea.righi@linux.dev>

Applied to sched_ext/for-6.12-fixes.

Thanks.

-- 
tejun

