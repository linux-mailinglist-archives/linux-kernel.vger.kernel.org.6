Return-Path: <linux-kernel+bounces-513442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2731A34A59
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 17:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C9BE1785BD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5B424292B;
	Thu, 13 Feb 2025 16:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sVvf9Yl/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3BF2040B7
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 16:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739464077; cv=none; b=pMjx7iNWulLJ9a5lPt4GwDRCjX75m5Jj7gCP/gxoygSj8eIWEYpkvkEWQafzS9LkkJO3lthnsBIeLHiu/vfgxqNXQfrWH9J/M6Uv75QTfapBJepIUdMKeBlILqhWqLxFu1JUZ4TQHvx2wwkHOZJHEDXYKutM9yucoQUVY9qpV5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739464077; c=relaxed/simple;
	bh=s+A7jI4dXcMYQT3HKzn14m2BVeLQG7vau7O52vLCSNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AYusRK7lqXLc8WPkS/OtbxhMO/W1S+M2t9D3bPr2OnEyaKDiItj7tXGjPyXQoXXOILUbjLIQeDVjufILDJZdkQ2c50Ax7AIGYOqw+5DdUu8UWJrv2ZFsvPJEtbbvOpFAjxN2EytCBSQJN6pDvyteHXJhTwi2tvcDcd4CIGo/Sok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sVvf9Yl/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4996AC4CED1;
	Thu, 13 Feb 2025 16:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739464076;
	bh=s+A7jI4dXcMYQT3HKzn14m2BVeLQG7vau7O52vLCSNc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sVvf9Yl/NloUcKwapYi/0nDJO6bPTgpq5sEWD3qQYJsaU4C+fH/i/Fd/326wvbvCD
	 huFQoyWbeoMcoJs2mvRYMColP8EqP0co+oAfBsCEBT1sv3VKQ/EsfzBllK+NOLkP0S
	 dTc7Lw9v6ThfTHZ0Vf5TyfZ3DQEemzS97H3byJt8EQPddD5uLCnru38qTdw7SHSxjA
	 tBsVM7QYoEYtgkBowzvZrA+JKNFLEwcNivG4zAKzlzLowTw06Hnq5PpZfk9O9QMxI0
	 /Dry7i2K3lFE0BySBNx/R+/JvP+SQBbEFWY/i33eRLmAmgK7geYnWKHwBiAGtTDLOF
	 vU8J2Q4/r4B/w==
Date: Thu, 13 Feb 2025 06:27:55 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Neel Natu <neelnatu@google.com>,
	Barret Rhoden <brho@google.com>, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, sched-ext@meta.com
Subject: Re: [PATCH sched_ext/for-6.15] sched_ext: Implement
 SCX_OPS_ALLOW_QUEUED_WAKEUP
Message-ID: <Z64di-4TaQ10GAbl@slm.duckdns.org>
References: <Z60p755gE1aDiimC@slm.duckdns.org>
 <Z62q4Zuh7ry9tH3L@gpd3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z62q4Zuh7ry9tH3L@gpd3>

Hello,

On Thu, Feb 13, 2025 at 09:18:41AM +0100, Andrea Righi wrote:
> > Implement SCX_OPS_ALLOW_QUEUED_WAKEUP which allows BPF schedulers to choose
> > to enable ttwu_queue optimization.
> 
> I'm wondering whether it makes sense to introduce a new SCX_OPS flag for
> this, considering that we already have the TTWU_QUEUE sched feature, that
> determines this behavior.
> 
> Is this in perspective of a future scenario, when we may potentially have
> multiple scx schedulers running at the same time and they may want to set a
> different queued wakeup behavior?

It's more that it can be a breaking change for schedulers that expect
ops.select_cpu() to be called on wakeups. e.g. If we make this behavior the
default, scx_layered as of the last relesae would break in an unobvious but
serious way - it'd fail to occupy CPUs fully as it'd be skipping picking
idle CPU and pushing tasks there for a noticeable portion of wakeups on
multi-LLC machines. The same holds for most of the C schedulers.

Down the line, once everyone is onboard, we can maybe make it the default
and drop the flag but, for now, this needs to be opt-in.

Thanks.

-- 
tejun

