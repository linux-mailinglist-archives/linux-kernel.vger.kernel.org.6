Return-Path: <linux-kernel+bounces-382710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0186F9B1284
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 00:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A48E61F22CF3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 22:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D33B20C333;
	Fri, 25 Oct 2024 22:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VSJ+Zthn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95BD1C174E
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 22:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729894857; cv=none; b=gVRQiziKY7Bu1/m6/fofKdPgvA81pxGNTLQgBUUs2LaG1vxmCFibMYtug4K6qq7i/a1BKoxE2d3zzvoITixUefZTboC2SvrYCYZhYa1LrAqg2X3RD+ZOg6HMk4mZCeIjeXpuAYpCuFkNge9Cmj0k9iyaTeckxamfZ9mlJyvyHLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729894857; c=relaxed/simple;
	bh=X0imMfETATb5cW4ZjYJ3+Jy8F+LpeoUfm8QlA/zUQBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gF7PmWyCTPkPrWAadaSlZRrRP0OavEb70Cf4xXE3vmFfSB6FJlIPTrdVfNur6RCBJ3p4A5qAife4X5HvuOwEguf1sc3Gv/OxO3HYwL8CENNVH29g01KiZRRee3LKypLNvOmn/E2SUxeV3j/BoCDaYaWlPZRbt3KcaiO/ZLIycdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VSJ+Zthn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E2D4C4CEC3;
	Fri, 25 Oct 2024 22:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729894857;
	bh=X0imMfETATb5cW4ZjYJ3+Jy8F+LpeoUfm8QlA/zUQBA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VSJ+Zthn6NaoAzGi3Kf22RUCdjBVP9qdEOpqvGSo8GMvWZwaZVQo3DFwnHt9+yqBE
	 9lLEMesS7Y0MtS1dHlzvtIvqrfH+TppiJCZYz0SiDW68Um6HZxYDQMwvMFerlxbJbL
	 hB1I8mGpQBhxrp+3N3Sim619aIKbibTXhUh2hJtXVL6qLGRUsFg/LqlI73ayk++4Fl
	 MtRwaxSSrkm5d3pd5Ucki78UFNC8d11CVFv0DW8Enn/XShXT9j8MQWRizeG9hlZ6nY
	 xG67s1GgZQBTt0rAnWPhTJF+Yoot1dUJFQfymuYQgWtwVLfOPKWGQ+eKSyeBttsDPa
	 Z4fFoZyEuIsrw==
Date: Fri, 25 Oct 2024 12:20:56 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, sched-ext@meta.com
Subject: Re: [PATCH sched_ext/for-6.12-fixes] sched_ext: Fix
 enq_last_no_enq_fails selftest
Message-ID: <ZxwZyIyXmu_7htzL@slm.duckdns.org>
References: <ZxwZWpbmKfVcMxMj@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxwZWpbmKfVcMxMj@slm.duckdns.org>

On Fri, Oct 25, 2024 at 12:19:06PM -1000, Tejun Heo wrote:
> cc9877fb7677 ("sched_ext: Improve error reporting during loading") changed
> how load failures are reported so that more error context can be
> communicated. This breaks the enq_last_no_enq_fails test as attach no longer
> fails. The scheduler is guaranteed to be ejected on attach completion with
> full error information. Update enq_last_no_enq_fails so that it checks that
> the scheduler is ejected using ops.exit().
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reported-by: Vishal Chourasia <vishalc@linux.ibm.com>
> Link: http://lkml.kernel.org/r/Zxknp7RAVNjmdJSc@linux.ibm.com
> Fixes: cc9877fb7677 ("sched_ext: Improve error reporting during loading")

Applying to sched_ext/for-6.12-fixes.

Thanks.

-- 
tejun

