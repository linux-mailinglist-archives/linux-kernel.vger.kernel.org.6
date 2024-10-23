Return-Path: <linux-kernel+bounces-378783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 882F89AD570
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 22:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6B9B1C21AED
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 20:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960841D279D;
	Wed, 23 Oct 2024 20:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="er0d/802"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA9B14EC62;
	Wed, 23 Oct 2024 20:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729714966; cv=none; b=Ukb+/ryc+kOLHYRUrQ6ig3fZc4SjJchxKneLSmWc+sRDGAFAnQgseNz1aU5H/n+nnW8sEO3CqHRHaOMqLYaG3rzsfXYgF3AH6xwrK5SpkazBEFIe7p4+o4DYWbjZQXv13ruNTGG0tGunsECoSKJnZHgdUit4ir2a7xVhh1h5uxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729714966; c=relaxed/simple;
	bh=NQslc/lH5EPvA7LJuUKYCsOwiKhMc9jkkn/XFJCsQKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M0vU1zqe/7qaSvcMQfWoSCwMDHqKOAG55ziJxTXAOaVfriindKoqN3+6CG1EpFNeaagYh/5om+qL71V2k9V9sVPxkAYWHU2f6mSNF9oUA1WrS3AJyPezenZsQsocaFuTeWQshf7q84y/mDou2EFRolao0RbevcmssiYMkPAdTbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=er0d/802; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EDC4C4CEC6;
	Wed, 23 Oct 2024 20:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729714965;
	bh=NQslc/lH5EPvA7LJuUKYCsOwiKhMc9jkkn/XFJCsQKg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=er0d/802FhraM0Iw950OJhfpnfBMJjk/V/MgsZlVGbjfbypZY7fBszRk+WACF30mP
	 A8bGfc9bJSe0KIa0U4cET0gFs7fibWMeFRNko+xZ6WFQOr5KOwaxXKHWxdmwmyheSe
	 M28an9obemOM8Z/r47wkHAE8hFXDe2QDMSNri0lx+tMKpCYkadPCGOqNGZXoTxWiVi
	 BihGRJBOjU8EYn1zL0FamypFAbPSg0XhhSzUGNWtgTPh43p3G7FTwHVCKQv91iz5h8
	 3i47mOpFHXsXw8v3Z3FYUBQ8wq1f0iddQriDswQw51OMcesqAd/PnsN7rRzxH2k/4y
	 B+MN6IocCNSnA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 0D0FBCE0EE1; Wed, 23 Oct 2024 13:22:45 -0700 (PDT)
Date: Wed, 23 Oct 2024 13:22:45 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christoph Hellwig <hch@infradead.org>, Sasha Levin <sashal@kernel.org>,
	Kees Cook <kees@kernel.org>, ksummit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: linus-next: improving functional testing for to-be-merged pull
 requests
Message-ID: <7c66ff8d-f139-4cf7-b477-d0179c62f922@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <ZxZ8MStt4e8JXeJb@sashalap>
 <792F4759-EA33-48B8-9AD0-FA14FA69E86E@kernel.org>
 <ZxdKwtTd7LvpieLK@infradead.org>
 <ZxdyYjzxSktk34Zz@sashalap>
 <ZxiOjBRdO6EMAY4H@infradead.org>
 <10b0cb74-2068-4819-ac91-fcf98ca8d96c@paulmck-laptop>
 <CAHk-=wj4aSJsVA6weV7u9KD1yA74JZq3dYZKbUtxp=3o_esnVA@mail.gmail.com>
 <e4ac4459-faf6-48df-851a-a5204bdee4cd@paulmck-laptop>
 <CAHk-=wjT3EzfL3b37k1aNMPkmdyfaqNoxKiqsJz0rrOqnfky2w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjT3EzfL3b37k1aNMPkmdyfaqNoxKiqsJz0rrOqnfky2w@mail.gmail.com>

On Wed, Oct 23, 2024 at 12:24:05PM -0700, Linus Torvalds wrote:
> On Wed, 23 Oct 2024 at 11:37, Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > Functional testing?
> 
> Yes. Things like the stuff that Guenter does every -rc, and that
> invariably finds several issues every single merge window.
> 
> Like actually booting up the kernel on multiple different odd
> architectures. But also much more complex things than just running a
> torture test for a very small piece of the kernel.
> 
> The same way linux-next does the build testing on many different
> architectures, and that often finds things that developers missed
> simply because the bulk of developers are still purely on x86-64.

Fair point, my testing is still strictly x86-64.

							Thanx, Paul

