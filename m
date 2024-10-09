Return-Path: <linux-kernel+bounces-357850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3199976F4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 22:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEA8128949E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 20:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BDA31C9B99;
	Wed,  9 Oct 2024 20:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="uRMe6Ko8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F191990A7
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 20:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728507173; cv=none; b=pwgpRqbszslYKkAZ6Ih8s7EpKUG3v+8iP/bSoookKPLw/loGuusYANgs5gu3zMgoMtwN7MTA4nRG0gExhH4+UOTREof/8d4FYf1Rk+dKY3TjfpBQW2tfjZaGIPZEkihFEoKXhISdl9WJu2Kzkkn91SOxM7ArXtE85tKMobBsX7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728507173; c=relaxed/simple;
	bh=DcUpYc7SKu3p/E6bewuvuO4MdwDIgXpZgloN8GqkSlc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=f6Vh80qsgHf9kWOnmSgI92RpWdXp0MGruBCMbGvwGG/BIPkxH4Jci74FlxmwEMoOgDb/A7E1f6PADlu5pCXqeVHCBjV9G2qP201zf4H3RkEKuQm0gpGQ8f3S62G5xn2PuPJQG/tgLBi21hVOdzrWF6dky6Dq8dAkYWbZ6YiWNXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=uRMe6Ko8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C2DAC4CEC3;
	Wed,  9 Oct 2024 20:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1728507173;
	bh=DcUpYc7SKu3p/E6bewuvuO4MdwDIgXpZgloN8GqkSlc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uRMe6Ko80K0ZAY8xAbsMJ9ziTGKtGSRpvqB3Cg0M4HCD89vhSxG3gMH1vXWbJbRYO
	 8zOFjIGUTrdFGKrA6D3j1Y4h4Cv0RYTR7E8jG1fTjiq7DdjaXcLhOlHOUPV8GnOtAa
	 vMBjmDJfpnNnPSZ5o5GccoqpeI+azC9zLdfGuE1E=
Date: Wed, 9 Oct 2024 13:52:52 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc: Yu Zhao <yuzhao@google.com>, <linux-mm@kvack.org>,
 <linux-kernel@vger.kernel.org>, Zhaoyang Huang <huangzhaoyang@gmail.com>,
 <steve.kang@unisoc.com>
Subject: Re: [PATCH] mm: throttle and inc min_seq when both page types reach
 MIN_NR_GENS
Message-Id: <20241009135252.53276de999d3006a20cad21c@linux-foundation.org>
In-Reply-To: <20241009074953.608591-1-zhaoyang.huang@unisoc.com>
References: <20241009074953.608591-1-zhaoyang.huang@unisoc.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 9 Oct 2024 15:49:53 +0800 "zhaoyang.huang" <zhaoyang.huang@unisoc.com> wrote:

> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> The test case of [1] leads to system hang which caused by a local
> watchdog thread starved over 20s on a 5.5GB RAM ANDROID15(v6.6)
> system. This commit solve the issue by have the reclaimer be throttled
> and increase min_seq if both page types reach MIN_NR_GENS, which may
> introduce a livelock of switching type with holding lruvec->lru_lock.
> 
> [1]
> launch below script 8 times simutanously which allocates 1GB virtual
> memory and access it from user space by each thread.
> $ costmem -c1024000 -b12800 -o0 &
> 

That looks like a pretty simple testcase.  Do people know where to get
`costmem' from?

> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c

This is a somewhat serious issue, so I'll add the patch for some
testing, but I'll await feedback from MGLRU developers before
proceeeding further, thanks.


