Return-Path: <linux-kernel+bounces-204746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9558FF316
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 18:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C6D11F2A443
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 16:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E05195F0F;
	Thu,  6 Jun 2024 16:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gyY9mGf7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855DA224D1
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 16:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717693002; cv=none; b=DRpxN0Gr96NtXd3YnidKuPT5ZSaWu2vUExZvnkksUOBK+MEtkzCc4myoq9JQuP1b4ZNzWyZPaeCVj4pQzzZDxbodGMUXulqRwyA49zJbM0LhzR4zEA9d2II/pB/jRv//KAb30ooTAAVGwfNJqFVf86c5xyAlL7bwIWuV2cKF2+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717693002; c=relaxed/simple;
	bh=TCjJrhdDbP5pQDHzS6TnuP2QNA9JBdFuTM3jg2PHGtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qR6/yOnZPrpEUoPKOvKnkvu6z0dERTOIKv+hiXd1HiK20MNB09Cib2Xawa37f0jyzuyeGgwJtxDffwk/FTn9gPe1W39TSKDYfxCqiKNrkTif2x/OBSBIQy0kB63zF3qHn4Ap2y0lOZPvPjTZAVK/b2rUbxjb527kppJoDWNeEPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gyY9mGf7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC8B4C2BD10;
	Thu,  6 Jun 2024 16:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717693002;
	bh=TCjJrhdDbP5pQDHzS6TnuP2QNA9JBdFuTM3jg2PHGtQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=gyY9mGf7PDfODP3laEIzQ2SH4QNWgKxcBQiJ2AQ4riaJj3NY0I3thQKnJpgEPDZZq
	 stAzpuRxUnV+orAX5zrPGnJq00jbOaBiPP6MS4sbAKV6tqszoObRN3Pjy4KSeStCX0
	 3dCHA//hj3lTh+drdp9Ei5PdU/3gRqk5AE+fsJRjL6sn1yToUahjUuQcNJDxq6o+YF
	 O6waygYVvFkSN5ww9prTik3hZ1X/un+6zjkO1a2GRZH4A+hFkJJdZxgLdr5+g0Er+y
	 SSxgeqN3POmLYVwqbHfvuPmk9HITNVDBNavfU8pJmfopAAux8BhX14licdWVG2DSFh
	 1ShU7yz1oR7yA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 8F96CCE3F34; Thu,  6 Jun 2024 09:56:41 -0700 (PDT)
Date: Thu, 6 Jun 2024 09:56:41 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, will@kernel.org,
	peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
	dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
	akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
	linux-kernel@vger.kernel.org, hernan.poncedeleon@huaweicloud.com,
	jonas.oberhauser@huaweicloud.com
Subject: Re: [PATCH 2/2] tools/memory-model: Code reorganization in lock.cat
Message-ID: <4e02f72f-f901-4734-ba3d-6a0663915107@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <eb202b3b-7408-4ab9-be82-81ca554b7603@rowland.harvard.edu>
 <6211154e-7db9-4129-b0d4-26ff69e2398c@rowland.harvard.edu>
 <ZmHg23/0cJ+REHNy@andrea>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmHg23/0cJ+REHNy@andrea>

On Thu, Jun 06, 2024 at 06:16:27PM +0200, Andrea Parri wrote:
> (... Reorganize code in lock.cat)
> 
> On Thu, Jun 06, 2024 at 09:59:01AM -0400, Alan Stern wrote:
> > Code reorganization for the lock.cat file in tools/memory-model:
> > 
> > Improve the efficiency by ruling out right at the start RU events
> > (spin_is_locked() calls that return False) inside a critical section
> > for the same lock.
> > 
> > Improve the organization of the code for handling LF and RU events by
> > pulling the definitions of the pair-to-relation macro out from two
> > different complicated compound expressions, using a single standalone
> > definition instead.
> > 
> > Rewrite the calculations of the rf relation for LF and RU events, for
> > greater clarity.
> > 
> > Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> 
> Tested-by: Andrea Parri <parri.andrea@gmail.com>
> Acked-by: Andrea Parri <parri.andrea@gmail.com>

I queued them both, and thank you both!

							Thanx, Paul

