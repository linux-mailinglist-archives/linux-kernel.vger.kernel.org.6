Return-Path: <linux-kernel+bounces-431998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8059E43A9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 19:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AC1B2831F6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 18:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18D11A8F85;
	Wed,  4 Dec 2024 18:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fFjMxuuS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1581F26AC1
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 18:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733337996; cv=none; b=UnsA7kRxlpAoEnfABKAweBFMd9uCA5uJMLTpKimK+dDZxnDeyvog/IC4xgmEdLGW39JHbV4IR1LUv1oXV8cfjLKPTIIupp6P8jSK75ns387sVt/KUeNk0orviR6VHMY/123eb3Y9HM65KypKEy2zoh7ceSRRkgyjpZTal2JfX3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733337996; c=relaxed/simple;
	bh=vZ+NtrN8opjtOgd3OLYYzi72bFsvsf2aJcbiPfxIkv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j3bQTOdrqKn0v9T0qWuGisbL6fveOCoN8oeESPdzZqeqN8w71OpzXkuP+bXpx7mBsrpOFI9+yhBU/6UwsLzUHGivaBrp7dSMs2BkXHKSprK0KEHketG0QX6yewyihl2pkPBgfigQaz/Ng6E7923QfS1TFBRjoMs3ixEFo1TadsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fFjMxuuS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AD55C4CECD;
	Wed,  4 Dec 2024 18:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733337994;
	bh=vZ+NtrN8opjtOgd3OLYYzi72bFsvsf2aJcbiPfxIkv8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fFjMxuuSsDZ09DoxKDn+mAvh9yF5ya4OIi0hEJVT9vCMq8AcXLEv2wBB0yKGqoy8F
	 e96aCr0Vd3xcWb61zikIYvJZ6E74jk5bgf0xeydu7Wa1VHNk6gVwl+pp1C4CCKvqfR
	 Y4setpRF6qiTBFjGzgRWbWZH7vOuYJvehv1EoduBxT/Qz3EDjAszTr1J5tBNFoZdaS
	 RzY4h3xb+wMe3GszYc4jotT/Gq/TzN9ffKBCEkeP8NNvc55czmAvOEePkr8DEsW/K9
	 rnLEGWYIW5S4vRHR0AM+Y8RO9f59HDxmA84PqkTVUg7uy/NDWMIeB99//GFltI7vIJ
	 b6oLmPsnlLiRQ==
Date: Wed, 4 Dec 2024 08:46:33 -1000
From: Tejun Heo <tj@kernel.org>
To: Changwoo Min <changwoo@igalia.com>
Cc: Changwoo Min <multics69@gmail.com>, void@manifault.com,
	mingo@redhat.com, peterz@infradead.org, kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/5] sched_ext: Manage the validity of scx_rq_clock
Message-ID: <Z1CjiYdeYMzxZNuo@slm.duckdns.org>
References: <20241203142802.36305-1-changwoo@igalia.com>
 <20241203142802.36305-3-changwoo@igalia.com>
 <Z0-TiGC5eUg4ZMWT@slm.duckdns.org>
 <ea78741a-09d6-42b6-b106-9fa5a54ed0fa@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea78741a-09d6-42b6-b106-9fa5a54ed0fa@igalia.com>

Hello,

On Wed, Dec 04, 2024 at 10:42:13AM +0900, Changwoo Min wrote:
> I investigated all sched_ext_ops. Besides these two ops, all the
> rest are control operations, of which BPF operation should be
> relatively simple. On the other hand, ops.running() and
> ops.update_idle() are different from the others since a CPU
> executes a task or becomes idle, which could be arbitrarily long.
> So I think refreshing the clock in those cases would be nice.
> Does it make sense to you?

Hmm... I'm not really following. Both ops.running() and ops.update_idle()
are called during task switches with rq lock held. I don't see why they'd be
any different in terms of expected runtime, which should be pretty short,
compared to any other rq-locked operations.

Thanks.

-- 
tejun

