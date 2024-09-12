Return-Path: <linux-kernel+bounces-325994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 585699760E7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 08:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A9CB1C20803
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 06:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420F11714CC;
	Thu, 12 Sep 2024 06:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MNUcEyk4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7FF2D7BF
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 06:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726120845; cv=none; b=I7QpzEw/19xhAf30NXqo066n0xut1uwechSbuZAMG4pvhEx8FrdgvvuvCQVh8yTx8Sc/pAGg+/OrcnOSWpPZfnCcxcciEGiyECtkOonHdB1bD8OBRlWUSIrtkxNCEklmMZOvQlFCYTa6AKPWZeh2b51ixmcLCpAD0ze0cCaMGKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726120845; c=relaxed/simple;
	bh=MfjO/i9CdfqUAz+os60jkG2jDAdtzzyKea/ilwVUWZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZFqixUGkskSvGlvrv2evpMKnvtVrX8QBf91jHXeg0EJ7opfZ3SqBcG3gNZ2amgI3iI7/JtP+0cN8sG3J9sZbjPyOmXOLBmVLO3KdirQxMF6jZM7quVionO+MAuR/74BXd80jHMhv6KR9YPXREXBmhoOhISNdpD1El5ChDsomCYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MNUcEyk4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0BDCC4CEC3;
	Thu, 12 Sep 2024 06:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726120845;
	bh=MfjO/i9CdfqUAz+os60jkG2jDAdtzzyKea/ilwVUWZk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MNUcEyk456k2ISQ0oJeWp19BlU2EVrA3ZMFrMBqfzqvsDF6EGCmQ4/d3maMGPlHGh
	 m58tmNxysOWnLixs98R/Z3zg8HUAwdO36/ixh6RTsFqNrILX+URNWGL1HPUI5qko4G
	 Mvi19F9KAKTwf0b/brgU5aC6F2Fya4VYTD0GJY4/L3YK2JZG+nyYY06KE1WTTYWU5w
	 sEYC+fEJq/iGga+8MQk09zOClUFK/AK9x/akKaRpLannP4FFVlWOuOGQGkS0gMXYRr
	 TQvbc0CNEeo/P7o3brHnX6dMpcPp3wmVN55riHbL8PehEwvUDtfsQR15kE0nKSsfaC
	 /Lat+Zz3NUCWA==
Date: Wed, 11 Sep 2024 20:00:44 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH sched_ext/for-6.12] sched: Move update_other_load_avgs()
 to kernel/sched/pelt.c
Message-ID: <ZuKDjKEUwgknwlik@slm.duckdns.org>
References: <ZuHxS2LfTBg0TZK1@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZuHxS2LfTBg0TZK1@slm.duckdns.org>

On Wed, Sep 11, 2024 at 09:36:43AM -1000, Tejun Heo wrote:
> 96fd6c65efc6 ("sched: Factor out update_other_load_avgs() from
> __update_blocked_others()") added update_other_load_avgs() in
> kernel/sched/syscalls.c right above effective_cpu_util(). This location
> didn't fit that well in the first place, and with 5d871a63997f ("sched/fair:
> Move effective_cpu_util() and effective_cpu_util() in fair.c") moving
> effective_cpu_util() to kernel/sched/fair.c, it looks even more out of
> place.
> 
> Relocate the function to kernel/sched/pelt.c where all its callees are.
> 
> No functional changes.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>

Applied to sched_ext/for-6.12.

Thanks.

-- 
tejun

