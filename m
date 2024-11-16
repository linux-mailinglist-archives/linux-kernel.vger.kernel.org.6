Return-Path: <linux-kernel+bounces-411923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 429049D0140
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 23:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C79E71F233A5
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 22:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D503F1946BA;
	Sat, 16 Nov 2024 22:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b="hhi2VXMq"
Received: from lichtman.org (lichtman.org [149.28.33.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B1B179BC
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 22:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.33.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731796713; cv=none; b=j+7RnWVwkmEwi57CWl4DM5dZno0v6JdpE8yPiEvdVjnKlE2EJBPqlb/mmXMRAUMiGh8JoQ72jAQZZNJpVN8bbHJKBaQuCgRqhA5dcsTgAHTs9lIPtcLv3DqtI4AgvDYhgPyeYSqR9PKFRd7EaSv3TPIqk0gHxWWOI4mSgEzuKTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731796713; c=relaxed/simple;
	bh=yMLLHYnoxqdQC1FP9RvK4ZDXdJ419A93fpT/Becp84g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qMnnyTv8Bb1TCHzp651mJ9F6zzpbGL5RJdUxXgr65P5H+EktYv/ShrlxWJ+/48qwLBSjrVi5L2c0ffM6Sv4XMJDSh0Pb4LV0khkzxZoWd1aS9g4WGAQcVY+L5BAdg2fjic7tqI7L1kRbX7MQn1cKfdlClEdJq7anSa316+6g7gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org; spf=pass smtp.mailfrom=lichtman.org; dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b=hhi2VXMq; arc=none smtp.client-ip=149.28.33.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lichtman.org
Received: by lichtman.org (Postfix, from userid 1000)
	id A3261177104; Sat, 16 Nov 2024 22:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=lichtman.org; s=mail;
	t=1731796710; bh=yMLLHYnoxqdQC1FP9RvK4ZDXdJ419A93fpT/Becp84g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hhi2VXMqqcbA8XTtnD5i+biPJSX2i+gpXLHdIgOOS1VTbGv+O879wxxMY37HAiGlx
	 0s4SymIIZ8Ixp+6CkcEKl/gDnfoqaKbZlAvmmL8u2hFzH9Ehd+QkdN2+tDlcEW1fHe
	 5SPyOX1UXtdvrsI1gLSzViajpx3RGMVhaQeoLiuAZf0vGzD90KSM66XKV38qBYo6vg
	 Mxfx9fV5hnyWxQPDCCpLZjvZdC0j2p3OUXfMsC2kylG7h0uOSjuton9j9IYHxtzv8F
	 QuYW9tSR3rFGqPhtZ/FT7cDeLeVDN3vXDsNefaZ9OwuI282Uc4Hj2TZWaeHe3b/70L
	 BPXTjgAuzPzBQ==
Date: Sat, 16 Nov 2024 22:38:30 +0000
From: Nir Lichtman <nir@lichtman.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ebiederm@xmission.com,
	kees@kernel.org, brauner@kernel.org, jack@suse.cz,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] exec: make printable macro more concise
Message-ID: <20241116223830.GA225347@lichtman.org>
References: <20241116061258.GA216473@lichtman.org>
 <20241116072804.GA3387508@ZenIV>
 <CAHk-=wiMEpPZYDeF5ak8FToB_fw7pfjKhuJAcjLpjqMfCvvB7g@mail.gmail.com>
 <20241116172301.GA222714@lichtman.org>
 <20241116220602.GE3387508@ZenIV>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241116220602.GE3387508@ZenIV>

On Sat, Nov 16, 2024 at 10:06:02PM +0000, Al Viro wrote:
> On Sat, Nov 16, 2024 at 05:23:01PM +0000, Nir Lichtman wrote:
> > On Sat, Nov 16, 2024 at 08:49:39AM -0800, Linus Torvalds wrote:
> > > On Fri, 15 Nov 2024 at 23:28, Al Viro <viro@zeniv.linux.org.uk> wrote:
> > > >
> > > Anyway, a.out support is dead, so I think this code is pure historical
> > > leftovers and should be removed.
> > > 
> > >            Linus
> > 
> > Thanks for answering Al and Linus.
> > Al, continuing forward, to work on a new version of the patch removing the
> > support for dynamically loading binfmt kernel modules or you'll take it
> > from here?
> 
> Just kill it off, since you are poking in the area anyway...  No point

Roger, will send out a new patch shortly.

> coordinating patches, etc. - removal is completely straightforward,
> with something along the lines of "that was an ancient leftover from
> a.out-to-ELF transition, left without a single valid use after removal
> of a.out support; anyone who might find future uses for it (currently
> there's none) would be better off using binfmt_misc to trigger whatever
> module loading they might need - would be more flexible that way"

