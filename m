Return-Path: <linux-kernel+bounces-418185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 840179D5E4E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 12:41:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D088BB26408
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 11:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2352A1DED53;
	Fri, 22 Nov 2024 11:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nMK7/YRk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727861D0143
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 11:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732275682; cv=none; b=o0AmKN6PwwIr1iOOm/ANCyffkSrZ4gMDZ7bpU82YZlbNM1hKCmFWzttgAwIkPSPL4pE/ymjORptWIGUwyN4+cQ29wKEHI/55OuRhA/M8t5MwYfPH0vHiqrii6xUS/fo+u5cRwONcN5o7lQr2bq2e4uikhGjYCyw4L+jgAUD6rUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732275682; c=relaxed/simple;
	bh=RGp8zlFWi4p2MA+HNh4Sk15uim2Ilye2OWmvde+TrGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xi4gZjS7LPbqkG/XWo3Gq3XwyYZdJeT9WzyRwo1bdXE2kGwzJka7XJ5DoHp2/Kdk45brnq5+SdUCtbbO1mlP+inoJdPmvM7vRHxG6YgbC+sFRR0w1hcDvmGMpHt7OA5erqZbeicwvLZU6ylUyXMNMCWYxvHpPuS+IxCzUw3yCVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nMK7/YRk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B605C4CED0;
	Fri, 22 Nov 2024 11:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732275682;
	bh=RGp8zlFWi4p2MA+HNh4Sk15uim2Ilye2OWmvde+TrGM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nMK7/YRkrBRt22zV7uQ/+FhkOlytrdTH5RJlE1+fMJXcGFr45Vo1BCxNGmT0D8LJC
	 llQ8GRoK5Eo00xJCNDYB4YqSFneQHWNmTC53qwL3JBGnpatnc8BYtSnAvHVw99vqBk
	 77zyz7Fyr95T65VaIWTVDRimQHkgQu32rIHUw0Q7E8UDkgKzCQubMtgKtf5Da3EErM
	 qJCLcJ43/1GayMSLCssbT32VQe+KykJ2fvbBXi5k0VZxquOo7TDK4SVjH4j2PeB5aa
	 kWMcqAdzjuPtpJA45Xv6TLUjaNQoSci8obS8SUyL0W8NhkbwP5i3mYapNdNgRjpPC2
	 9nt1kIyfFZ9IQ==
Date: Fri, 22 Nov 2024 12:41:17 +0100
From: Christian Brauner <brauner@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [GIT pull] timers/core for v6.13-rc1
Message-ID: <20241122-kopieren-galopp-c81933b11034@brauner>
References: <173195757899.1896928.6143737920583881655.tglx@xen13>
 <173195758632.1896928.11371209657780930206.tglx@xen13>
 <CAHk-=wiX7=bqOEO06+BsO_25dHoa=KBWcNzLg=-rAKJ=dqKxYg@mail.gmail.com>
 <20241120-backwaren-faible-99807b4768bb@brauner>
 <Zz3SLAW-97Zhjfhv@gmail.com>
 <20241120-nennwert-hausfassade-e515eddb6198@brauner>
 <Zz4J_a2bYyNzJxWZ@gmail.com>
 <20241120-kurort-belehren-9f5212e1dc18@brauner>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241120-kurort-belehren-9f5212e1dc18@brauner>

On Wed, Nov 20, 2024 at 08:44:39PM +0100, Christian Brauner wrote:
> On Wed, Nov 20, 2024 at 05:10:37PM +0100, Ingo Molnar wrote:
> > 
> > * Christian Brauner <brauner@kernel.org> wrote:
> > 
> > > On Wed, Nov 20, 2024 at 01:12:28PM +0100, Ingo Molnar wrote:
> > > > 
> > > > * Christian Brauner <brauner@kernel.org> wrote:
> > > > 
> > > > > On Tue, Nov 19, 2024 at 04:33:45PM -0800, Linus Torvalds wrote:
> > > > > > On Mon, 18 Nov 2024 at 11:22, Thomas Gleixner <tglx@linutronix.de> wrote:
> > > > > > >
> > > > > > 
> > > > > > >   - Core infrastructure for VFS multigrain timestamping
> > > > > > >
> > > > > > >     This is required to allow the kernel to use coarse grained time stamps
> > > > > > >     by default and switch to fine grained time stamps when inode attributes
> > > > > > >     are actively observed via getattr().
> > > > > > >
> > > > > > >     These changes have been provided to the VFS tree as well, so that the
> > > > > > >     VFS specific infrastructure could be built on top.
> > > > > > 
> > > > > > Bah. Except the vfs tree didn't take it as a shared branch, but
> > > > > > instead cherry-picked the commits and as a result they are duplicate
> > > > > > and caused a (trivial) merge conflict.
> > > > > 
> > > > > Wait, I'm confused. I definitely pulled that branch the day after Thomas
> > > > > gave it to me and in my vfs.mgtime branch I clearly see:
> > > > > 
> > > > > commit d7c898a73f875bd205df53074c1d542766171da1
> > > > > Merge: 8cf0b93919e1 2a15385742c6
> > > > > Author:     Christian Brauner <brauner@kernel.org>
> > > > > AuthorDate: Mon Oct 7 12:47:19 2024 +0200
> > > > > Commit:     Christian Brauner <brauner@kernel.org>
> > > > > CommitDate: Thu Oct 10 10:20:57 2024 +0200
> > > > > 
> > > > >     Merge tag 'timers-core-for-vfs' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip into vfs.mgtime
> > > > > 
> > > > >     Timekeeping interfaces for consumption by the VFS tree.
> > > > > 
> > > > >     Signed-off-by: Christian Brauner <brauner@kernel.org>
> > > > > 
> > > > > Unless I did something odd during the pull?
> > > > 
> > > > The problem was caused by two commits which got rebased in the VFS 
> > > > tree:
> > > > 
> > > > Commit 1:
> > > > 
> > > >   ee3283c608df ("timekeeping: Add interfaces for handling timestamps with a floor value")
> > > > 
> > > >   commit ee3283c608dfa21251b0821d7bb198c7ae3189f6
> > > >   Author:     Jeff Layton <jlayton@kernel.org>
> > > >   AuthorDate: Wed Oct 2 17:27:16 2024 -0400
> > > >   Commit:     Christian Brauner <brauner@kernel.org>
> > > >   CommitDate: Thu Oct 10 10:20:46 2024 +0200
> > > >               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > > 
> > > > Which is a rebase of Thomas's original commit:
> > > > 
> > > >   70c8fd00a9bd ("timekeeping: Add interfaces for handling timestamps with a floor value")
> > > > 
> > > >   commit 70c8fd00a9bd0509bbf7bccd9baea8bbd5ddc756
> > > >   Author:     Jeff Layton <jlayton@kernel.org>
> > > >   AuthorDate: Wed Oct 2 17:27:16 2024 -0400
> > > >   Commit:     Thomas Gleixner <tglx@linutronix.de>
> > > >   CommitDate: Sun Oct 6 20:56:07 2024 +0200
> > > > 
> > > > And commit 2:
> > > > 
> > > >   2a15385742c6 ("timekeeping: Add percpu counter for tracking floor swap events")
> > > > 
> > > >   commit 2a15385742c689a271345dcbb4c28b9c568bc7ce
> > > >   Author:     Jeff Layton <jlayton@kernel.org>
> > > >   AuthorDate: Wed Oct 2 17:27:17 2024 -0400
> > > >   Commit:     Christian Brauner <brauner@kernel.org>
> > > >   CommitDate: Thu Oct 10 10:20:46 2024 +0200
> > > >               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > > 
> > > > Which is a rebase of Thomas's original commit:
> > > > 
> > > >   96f9a366ec8a timekeeping: Add percpu counter for tracking floor swap events
> > > > 
> > > >   commit 96f9a366ec8abe027326d7aab84d64370019f0f1 (tag: timers-core-for-vfs)
> > > >   Author:     Jeff Layton <jlayton@kernel.org>
> > > >   AuthorDate: Wed Oct 2 17:27:17 2024 -0400
> > > >   Commit:     Thomas Gleixner <tglx@linutronix.de>
> > > >   CommitDate: Sun Oct 6 20:56:07 2024 +0200
> > > 
> > > I was just looking through my reflog and I realised that I did a rebase
> > > onto v6.12-rc2 (v6.12-rc1 had a horribly virtqueue bug that made testing
> > > in a vm a giant pain). Sorry about that I should've noticed that
> > > earlier.
> > 
> > So, so sh1t happens, but I think there could also be a workflow bug 
> > here: somehow your tooling added your Signed-off-by during the rebase, 
> > to a commit not committed by you originally.
> 
> I see. I assume that happens because I have an ancient
> .git/hooks/prepare-commit-msg which contains:
> 
> COMMIT_MSG_FILE=$1
> COMMIT_SOURCE=$2
> 
> SOB=$(git var GIT_COMMITTER_IDENT | sed -n 's/^\(.*>\).*$/Signed-off-by: \1/p')
> git interpret-trailers --in-place --trailer "$SOB" "$COMMIT_MSG_FILE"
> 
> I honestly have no idea anymore why I added that hook originally...

To bring this to an end: I removed the hook and tested that on rebase no
SoB will be added to the rebased patches. Thanks for pointing me in the
right direction Ingo!

And Thomas, sorry for the confusion and thanks for providing the tag. It
won't happen again.

