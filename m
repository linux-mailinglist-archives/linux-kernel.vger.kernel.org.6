Return-Path: <linux-kernel+bounces-447840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB1E9F37B4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 18:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4472F188CDF7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 17:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193DD2063D0;
	Mon, 16 Dec 2024 17:36:32 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D004D2066F2
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 17:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734370591; cv=none; b=YBi4pZpD9KPdVR+zzUbRYofGDMo8WC/bNvkpeREW6dnA/93h2KGViCqvzGOpYF3ER37EahT/oj0j3BijtNzUS11du3DjgzxwUvWDEAESLqV5mm2ftMDheGop4/DtEirNOYxyM+MMmRtUrpYgEUdvNttd/nxtJuJrM8mj6zu/H5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734370591; c=relaxed/simple;
	bh=4VfhosGsgwTEuZycixTM1uoIqDGYHBIiEslwEPWCVuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q4D33f2pCZkp7I2SCYYSBbl2QDEw8Hb34x/tZUZwxZfbLjLXqjSrHs7HrP8cLoObe/x22vxoamsNjxCmMSQLecqq/Y4VYMrL1iDRRaES0/9JfCy4sFUPtNkDhDiTG4eUtnRZSpZYfYbMAuGF9FbFalFrItQgqrvXVQNkZ0jnM5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A148106F;
	Mon, 16 Dec 2024 09:36:57 -0800 (PST)
Received: from J2N7QTR9R3.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2B1E73F528;
	Mon, 16 Dec 2024 09:36:28 -0800 (PST)
Date: Mon, 16 Dec 2024 17:36:22 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Sasha Levin <sashal@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] arm64 fixes for 6.13-rc3
Message-ID: <Z2BlFtmP4QP3XyLe@J2N7QTR9R3.cambridge.arm.com>
References: <Z1xx0ha7lbKkdhRC@arm.com>
 <Z18MixiGByAqDYLC@lappy>
 <Z1_6ukG_Lc5leG1o@J2N7QTR9R3>
 <Z2BAQEuXJg01qWDp@lappy>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z2BAQEuXJg01qWDp@lappy>

On Mon, Dec 16, 2024 at 09:59:12AM -0500, Sasha Levin wrote:
> On Mon, Dec 16, 2024 at 10:02:34AM +0000, Mark Rutland wrote:
> > On Sun, Dec 15, 2024 at 12:06:19PM -0500, Sasha Levin wrote:
> > > On Fri, Dec 13, 2024 at 05:41:38PM +0000, Catalin Marinas wrote:
> > > > - arm64 stacktrace: address some fallout from the recent changes to
> > > >  unwinding across exception boundaries
> > > 
> > > Hi Catalin, Mark,
> > > 
> > > It seems that kselftests can hit a warning that was addressed in the
> > > commit above:
> > 
> > I assume you're referring to commit:
> > 
> >  32ed1205682ec42a ("arm64: stacktrace: Skip reporting LR at exception boundaries")
> > 
> > ... ?
> 
> I was actually thinking 65ac33bed8b9 ("arm64: stacktrace: Don't WARN
> when unwinding other tasks"), sorry for the confusion

That commit should have no impact the case you report, which is seen
when unwinding the current task, not another task.

The commit immediately before that (32ed1205682ec42a) *should* fix the
issue triggered by the ftrace kselftests.

> > That was intended to fix this specific issue, as explained in the commit
> > message (with a very similar splat from running the ftrace kselftests).
> > 
> > Am I missing something? i.e. are you saying it *doesn't* fix that?
> 
> Right - LKFT is able to trigger the warning I copied on Linus's tree.

Is that "Right" as in "Right, that commit fixes it", or "Right, that
commit does not fix it"?

The warning you reported says:

	Not tainted 6.13.0-rc2 #1

... which is *before* either of the two fixes above, since the arm64
for-next/fixes branch is based on v6.13-rc2.

Are you seeing the warning with those applied? e.g. do you see this in
v6.13-rc3? I cannot reproduce the issue on v6.13-rc3 so far.

Mark.

