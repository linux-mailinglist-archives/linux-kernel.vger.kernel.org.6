Return-Path: <linux-kernel+bounces-442200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E94F9ED940
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 23:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E31681885BEA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 22:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D658E1C1F22;
	Wed, 11 Dec 2024 22:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a37OOsZ2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2601D88D3
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 22:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733954477; cv=none; b=FtRtWz5NigJiNtC8bux+v7a6/Shm16hcAaDCW5oCySNvy/WkDrKqovSGZpnoYLlUyLBEIzZgGWdoAqQAD4HhxOqmwh+/OBp1IbE4K/NuRRYbHlWSmCLYysSUhdJxIbpVZvUZkQ0XGiDqMFiVazfqh3If+ff80lat7XE5yzBD4Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733954477; c=relaxed/simple;
	bh=kC3+sFyYmroRpJW6DEgEJ8Mjqi2PHmDDEnEmJBMGgEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZEjmV89kHQXH37wca+wXVom2zLHFcsDDDL+5hEKsC8XXyZtMPrlmqfpYtKRp6gwzY1+CEBW6njtClY+BNqXwufLSFSZnF/GtN+YdVSKe7bf09ar3RC6t3T2hwOHym5rPEPOihV39VEGsArHRqZHG4nQd2PW2qWZ4dEm5tPTqDDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a37OOsZ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9063C4CED2;
	Wed, 11 Dec 2024 22:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733954477;
	bh=kC3+sFyYmroRpJW6DEgEJ8Mjqi2PHmDDEnEmJBMGgEg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a37OOsZ2nDZwUAEz1MqbCgU0BrdKankgcQhKMJLf08ioEQBi/lCJI4fmRzjZQUCep
	 Oyl3UIRxrxMW2frhmqDo+VfWdhSH9LylK6dBmniXjXU7tLURBOS/wWVWYDiZJ6cnKs
	 z7ig/dY+0xtWm0nKAZPmrR2RxTpffwbAT+Q3L5FHHV5YCWWLfUHqFAAtCFfAGGNcyJ
	 1EkFpCsljoWY0wasaW5oqltL4hpgrTj/7mNsC+ZfJsBZ98h4mLaGU52lIZcsSyR4WV
	 TPWFn7ZKbdXhATxOEAOyKctE95Oa3gECYXrB5lnPwjLtO4GPvbdDViAz3sFWgZ+GBV
	 lGM8bOC1KuNIg==
Date: Wed, 11 Dec 2024 22:01:15 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Gabriel Krisman Bertazi <krisman@suse.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"hanqi@vivo.com" <hanqi@vivo.com>, Theodore Ts'o <tytso@mit.edu>
Subject: Re: Unicode conversion issue
Message-ID: <Z1oLq7817UOuCJQa@google.com>
References: <Z1mzu4Eg6CPURra3@google.com>
 <87v7vqyzh4.fsf@mailhost.krisman.be>
 <Z1nG-PSEe6tPOZIG@google.com>
 <87cyhyuhow.fsf@mailhost.krisman.be>
 <CAHk-=wice8YV5N1jjyz42uNi-eZTvG-G2M46qaN7T9VsSaCP_Q@mail.gmail.com>
 <CAHk-=wiC3evUXq8QTcOBFTMu1wsUR_dYiS8eGxy0Hh7VbL55yA@mail.gmail.com>
 <875xnqudr1.fsf@mailhost.krisman.be>
 <CAHk-=wi+ZB4fNiMTHOYo2__-NnBXryQwxJ_bHN+cUDsfBBt_MA@mail.gmail.com>
 <Z1oJ7PgRvLyctn0X@google.com>
 <CAHk-=whB_YjwB4sGsRGJx8AbxR8wRAJBfy+x2KhsAQ4QssZpMg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whB_YjwB4sGsRGJx8AbxR8wRAJBfy+x2KhsAQ4QssZpMg@mail.gmail.com>

On 12/11, Linus Torvalds wrote:
> On Wed, 11 Dec 2024 at 13:53, Jaegeuk Kim <jaegeuk@kernel.org> wrote:
> >
> > Casefolding supports f2fs and ext4 per Android request, and only f2fs
> > constructs hash-based directory structure. If we use hash of the
> > case-preserving entry, we had no easy solution to distinguish file_A and file_a.
> 
> I really wish people had just done case-folding as a slow case, and
> not used the hash at all.
> 
> Does that mean that you have to walk the directory linearly? Yes it
> does. But that's my point: you shouldn't optimize for the idiocy of
> case-folding. You should optimize for the sane case, and actively try
> to discourage people from doing stupid bad things.
> 
> Oh well. Too late now.

Ok, well understood. I'll work on how we can implement the linear search for
case-folding. Meanwhile, yea, quite late so, may I ask for its revert?

> 
>              Linus

