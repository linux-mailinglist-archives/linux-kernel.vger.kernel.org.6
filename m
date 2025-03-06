Return-Path: <linux-kernel+bounces-549273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CFABA55029
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 17:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5CD03A729F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 16:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98FB220F087;
	Thu,  6 Mar 2025 16:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JAA4wyOM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B7E145A0B
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 16:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741277172; cv=none; b=GvS4CZ6S1BGcRi8mbwVSzvi9iZKa5VjYAXkbBbINH8OpDacAHTNaKO8DTrc0fKV2HQs/WVGwyoWKpP3k6T0Rev+vhVvLSfH25mVtmZFCApg6qIZTJFHn5ALodJ6GmF7yFKeT/sI/Pvy+bPyRiiV/cLqKXYGklF6MnboCkLVR4ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741277172; c=relaxed/simple;
	bh=AGz2/+jVEH/UpIDgDMw9RAN0js7FQBt8mSC8PyN6TBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kBxbGlQJOKP4ucHZFvZb9eUwEEd8RK3L/55FQ5fQLON4qEaOgmiKvlTOGy6K2HIdooNlQSgFGiwp0O/PdmwMftbmnK6At1gwVPT9b8MUjIxFVQMuQ/XzqtPR01hhPLccfHDN+l7y9AHw+QySrfm79qeLFydh2NHe7NoxrFAmd1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JAA4wyOM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69E5CC4CEE0;
	Thu,  6 Mar 2025 16:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741277171;
	bh=AGz2/+jVEH/UpIDgDMw9RAN0js7FQBt8mSC8PyN6TBM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=JAA4wyOMZCR2xqfjUee5QChNp9l2vP/vLtYqKrwV14KnpT34pb2smRVQAJ1JVu3ut
	 m1XctH0O+udLMxfiCLjRRI/dolqhkmaE+mlGBRj7BKVP0EQyy3GwB3js2T9Sj+PpVe
	 t854L/R4h2M+wQpiHJ/ZpT8NFs1lWa12O7LWZlQXoVXMF6u2VA0JqUU0J6/PfS5C/I
	 Ozba9QgXVwf0n3mpGHczWVX7utUlOCbwMbOgeaBX2DgCJa5JYR1eFLZ8eMNtRPzL8/
	 ylEHDstx+jEwpJWcc/wJWFtIwHJ/E1x3sg3qTuWihH2OH5eIv3rsoswhMDsBZ2ur4l
	 3zmeXSbOrgwxA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 15487CE13D4; Thu,  6 Mar 2025 08:06:11 -0800 (PST)
Date: Thu, 6 Mar 2025 08:06:11 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, jstultz@google.com, sboyd@kernel.org,
	christian@heusel.eu, kernel-team@meta.com
Subject: Re: [PATCH clocksource] Defer marking clocksources unstable to
 kthread
Message-ID: <e344af94-6516-4bfa-bb28-ea65f6bb81f2@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <f6bb6dd3-7183-42db-8e7e-c9103c0bd5ff@paulmck-laptop>
 <871pva5zww.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871pva5zww.ffs@tglx>

On Thu, Mar 06, 2025 at 09:25:19AM +0100, Thomas Gleixner wrote:
> Paul!
> 
> On Wed, Mar 05 2025 at 09:43, Paul E. McKenney wrote:
> 
> I'm pretty sure, that I pointed this out to you before:
> 
>    "[PATCH subsys] Short description"
> 
> is not a valid subject line.
> 
> The canonical and documented form is:
> 
>    [PATCH] subsys: Short description
> 
> Can you please stop making your own rules and thereby breaking the
> automated workflow of people so they have to manually fix up your stuff?

Apologies!

I do not recall being chastised on this particular issue, but I clearly
do need to reread submittingpatches.rst more often.

I have adjusted my scripts for this particular issue and will resend v2
of this patch.

							Thanx, Paul

