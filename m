Return-Path: <linux-kernel+bounces-278409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B13294AFEA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 20:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA0991F267A2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 18:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27EEB140360;
	Wed,  7 Aug 2024 18:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="B206mSKX"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFBD4653A;
	Wed,  7 Aug 2024 18:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723055864; cv=none; b=WGSeE7f7tYKoFOyCWsJPjxqgIKZ+AElfq+aNgTEexGazyvZm7+7gGIQZfmARjmXNxD/ystDN1S0GDdzWfZTdUGhuOC+/jwtHJbV2jf7n46g0IEL2+uQjO14S2tuPNAO+aQoU/DALrjX/rethHIqvLPiLTbNC9SSkAU7g8E0PzJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723055864; c=relaxed/simple;
	bh=CI38NBqvpLgEio8pnShmGbgJ4EtQ22pvUjsmaMuyq64=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CqJmb1saFeAx7SPGVlBFHnReDSjiMCZ2jQaK3m9XLkgCj1a0JtpyrBzLZp4ryrbv0OUrL4WBfN8M8iTF1bociLw62Pv2CzUDH2I+NFK9aeEu38EUTlDxkGYoCiSfMJK1qF0w/CYLRoCo4NxuP3LD0ysLEU9jdPImcBbRswAWF+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=B206mSKX; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 40314418B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1723055857; bh=j5tAlNX+pQUFnmYMm1+XGm4T1zHfXV5AsYeIWLqsfhk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=B206mSKX1ap3GEhkyNPF/td7lR907oObEkliyxa37AQRSt16MSPApNHFnqkaCSQwU
	 Wqm1DWFay3XZ6wkIpFiG7Dgiixq/vp16Opvj3xrHU00EcIEKJi1XYYe3RCGY6YbgqO
	 yyCPAComXzcjiDDVsA1j8JvCct67Wdsw49d6+EsyKFcw230sjPcTmmNTI7YK9F/FNN
	 neCN+HDCv33dn0KMznLpsvU9131i3KDj5IX7MA5MVEKRpEKWJdmW9JapxDurcRdwPX
	 RiYmXKyOxpfeHJZhxMqbwY9FtSF/UImJEwtKj10ZxWxAqWNLpcmB/bGmCirsy8CygI
	 4z7XhdHcaHtjw==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 40314418B1;
	Wed,  7 Aug 2024 18:37:37 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: regressions@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>, Petr
 =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
Subject: Re: [PATCH v1] docs: bug-bisect: rewrite to better match the other
 bisecting text
In-Reply-To: <10a565e4ebca5e03a2e7abb7ffe1893136471bf9.1722846343.git.linux@leemhuis.info>
References: <10a565e4ebca5e03a2e7abb7ffe1893136471bf9.1722846343.git.linux@leemhuis.info>
Date: Wed, 07 Aug 2024 12:37:36 -0600
Message-ID: <87ttfwrxfz.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thorsten Leemhuis <linux@leemhuis.info> writes:

> Rewrite the short document on bisecting kernel bugs. The new text
> improves .config handling, brings a mention of 'git skip', and explains
> what to do after the bisection finished -- including trying a revert to
> verify the result. The rewrite at the same time removes the unrelated
> and outdated section on 'Devices not appearing' and replaces some
> sentences about bug reporting with a pointer to the document covering
> that topic in detail.
>
> This overall brings the approach close to the one in the recently added
> text Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst.
> As those two texts serve a similar purpose for different audiences,
> mention that document in the head of this one and outline when the
> other might be the better one to follow.
>
> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
> ---
>  Documentation/admin-guide/bug-bisect.rst | 205 +++++++++++++++--------
>  MAINTAINERS                              |   1 +
>  2 files changed, 135 insertions(+), 71 deletions(-)

So overall this seems like a good thing to do.  I wouldn't be me if I
didn't have some comments though...:)

> diff --git a/Documentation/admin-guide/bug-bisect.rst b/Documentation/admin-guide/bug-bisect.rst
> index 325c5d0ed34a0a..f4a9acab65d0f5 100644
> --- a/Documentation/admin-guide/bug-bisect.rst
> +++ b/Documentation/admin-guide/bug-bisect.rst
> @@ -1,76 +1,139 @@
> -Bisecting a bug
> -+++++++++++++++
> -
> -Last updated: 28 October 2016
> -
> -Introduction
> -============
> -
> -Always try the latest kernel from kernel.org and build from source. If you are
> -not confident in doing that please report the bug to your distribution vendor
> -instead of to a kernel developer.
> -
> -Finding bugs is not always easy. Have a go though. If you can't find it don't
> -give up. Report as much as you have found to the relevant maintainer. See
> -MAINTAINERS for who that is for the subsystem you have worked on.
> -
> -Before you submit a bug report read
> -'Documentation/admin-guide/reporting-issues.rst'.
> -
> -Devices not appearing
> -=====================
> -
> -Often this is caused by udev/systemd. Check that first before blaming it
> -on the kernel.
> -
> -Finding patch that caused a bug
> -===============================
> -
> -Using the provided tools with ``git`` makes finding bugs easy provided the bug
> -is reproducible.
> -
> -Steps to do it:
> -
> -- build the Kernel from its git source
> -- start bisect with [#f1]_::
> +.. SPDX-License-Identifier: (GPL-2.0+ OR CC-BY-4.0)
> +.. [see the bottom of this file for redistribution information]
>  
> -	$ git bisect start
> -
> -- mark the broken changeset with::
> -
> -	$ git bisect bad [commit]
> -
> -- mark a changeset where the code is known to work with::
> -
> -	$ git bisect good [commit]
> -
> -- rebuild the Kernel and test
> -- interact with git bisect by using either::
> -
> -	$ git bisect good
> -
> -  or::
> -
> -	$ git bisect bad
> -
> -  depending if the bug happened on the changeset you're testing
> -- After some interactions, git bisect will give you the changeset that
> -  likely caused the bug.
> -
> -- For example, if you know that the current version is bad, and version
> -  4.8 is good, you could do::
> -
> -           $ git bisect start
> -           $ git bisect bad                 # Current version is bad
> -           $ git bisect good v4.8
> +===============
> +Bisecting a bug
> +===============
>  
> +This document describes how to find a change causing a kernel regression using
> +``git bisect``.

This seems a bit terse.  A bit of information on when doing a bisection
makes sense would not go amiss - when somebody has observed that a
previously working feature broke with an update.

> -.. [#f1] You can, optionally, provide both good and bad arguments at git
> -	 start with ``git bisect start [BAD] [GOOD]``
> +The text focuses on the gist of the process. If you are new to bisecting the
> +kernel, better follow Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst
> +instead: it depicts everything from start to finish while covering multiple
> +aspects even kernel developers occasionally forget. This includes:
>  
> -For further references, please read:
> +- Detecting situations where a bisections would be a waste of time, as nobody
> +  would care about the result -- for example, because the problem is triggered
> +  by a .config change, was already fixed, is caused by something your Linux
> +  distributor changed, occurs in an abandoned version, or happens after the
> +  kernel marked itself as 'tainted'.
> +- Preparing the .config file using an appropriate kernel while enabling or
> +  disabling debug symbols depending on the situation's needs -- while optionally
> +  trimming the .config to tremendously reduce the build time per bisection step.
> +- For regressions in stable or longterm kernels: checking mainline as well, as
> +  the result determines to whom the regression must be reported to.

This instead seems a bit verbose; I'd be tempted to take out the
itemized list and leave just the paragraph above.

> -- The man page for ``git-bisect``
> -- `Fighting regressions with git bisect <https://www.kernel.org/pub/software/scm/git/docs/git-bisect-lk2009.html>`_
> -- `Fully automated bisecting with "git bisect run" <https://lwn.net/Articles/317154>`_
> -- `Using Git bisect to figure out when brokenness was introduced <http://webchick.net/node/99>`_
> +Neither document describes how to report a regression, as that is covered by
> +Documentation/admin-guide/reporting-issues.rst.

This could maybe go at the end - "once you've found the regression, see
this document on how to report it" ?

> +Finding the change causing a kernel issue using a bisection
> +===========================================================
> +
> +*Note: the following process assumes you prepared everything for a bisection;
> +this includes having a Git clone with the appropriate sources, installing the
> +software required to build and install kernels, as well as a .config file stored
> +in a safe place (the following example assumes '~/prepared_kernel_.config') to
> +use as pristine base at each bisection step.*
> +
> +* Preparation: start the bisection and tell Git about the points in the history
> +  you consider to be working and broken, which Git calls 'good' and 'bad'::
> +
> +    git bisect start
> +    git bisect good v6.0
> +    git bisect bad v6.1
> +
> +  Instead of Git tags like 'v6.0' and 'v6.1' you can specify commit-ids, too.
> +
> +1. Copy your prepared .config into the build directory and adjust it to the
> +   needs of the codebase Git checked out for testing::
> +
> +     cp ~/prepared_kernel_.config .config
> +     make olddefconfig
> +
> +2. Now build, install, and boot a kernel; if any of this fails for unrelated
> +   reasons, run ``git bisect skip`` and go back to step 1.

Spell out "unrelated reasons" a bit more thoroughly?  I'd mention that
things can go wrong (despite our best efforts) when bisect lands in the
middle of a patch series, and to recognize a failure that is not the bug
in question.

> +3. Check if the feature that regressed works in the kernel you just built.
> +
> +   If it does, execute::
> +
> +     git bisect good
> +
> +   If it does not, run::
> +
> +     git bisect bad
> +
> +   Be sure what you tell Git is correct, as getting this wrong just once will
> +   send the rest of the bisection totally off course.

Something about hard-to-trigger bugs and putting in the effort to be
sure that a good kernel is really good?  Along those lines, maybe
something at the top about having a well-defined reproducer for the
problem would be good.

> +   Go back to back to step 1, if Git after issuing one of those commands checks
> +   out another bisection point while printing something like 'Bisecting:
> +   675 revisions left to test after this (roughly 10 steps)'.
> +
> +   You finished the bisection and move to the next point below, if Git instead
> +   prints something like 'cafecaca0c0dacafecaca0c0dacafecaca0c0da is the first
> +   bad commit'; right afterwards it will show some details about the culprit
> +   including its patch description.

That's a big and hard-to-parse sentence.  I'd start with the "if"
condition - this isn't perl :)

>     The latter can easily fill your terminal,
> +   so you might need to scroll up to see the message mentioning the culprit's
> +   commit-id; alternatively, run ``git bisect log`` to show the result.
> +
> +* Recommended complementary task: put the bisection log and the current
> +  .config file aside for the bug report; furthermore tell Git to reset the
> +  sources to the state before the bisection::
> +
> +     git bisect log > ~/bisection-log
> +     cp .config ~/bisection-config-culprit
> +     git bisect reset
> +
> +* Recommended optional task: try reverting the culprit on top of the latest
> +  codebase; if successful, this will validate your bisection and enable
> +  developers to resolve the regression through a revert.

"successful" could be misinterpreted as referring to the revert itself
here.  An explicit "if that fixes the bug..." would be more clear.

> +  To try this, update your clone and check out latest mainline. Then tell Git to
> +  revert the change::
> +
> +     git revert --no-edit cafec0cacaca0
> +
> +  This might be impossible, for example when the bisection landed on a merge
> +  commit. In that case, abandon the attempt. Do the same, if Git fails to revert
> +  the culprit because later changes depend on it -- unless you bisected using a
> +  stable or longterm kernel series, in which case you want to retry using the
> +  latest code from that series.
> +
> +  If a revert succeeds, build and test another kernel to validate the result of
> +  the bisection. Mention the outcome in your bug report.
> +
> +Additional reading material
> +---------------------------
> +
> +* The `man page for 'git bisect' <https://git-scm.com/docs/git-bisect>`_ and
> +  `fighting regressions with 'git bisect' <https://git-scm.com/docs/git-bisect-lk2009.html>`_
> +  in the Git documentation.
> +* `Working with git bisect <https://nathanchance.dev/posts/working-with-git-bisect/>`_
> +  from kernel developer Nathan Chancellor.
> +* `Using Git bisect to figure out when brokenness was introduced <http://webchick.net/node/99>`_.
> +* `Fully automated bisecting with 'git bisect run' <https://lwn.net/Articles/317154>`_.
> +
> +..
> +   end-of-content

end-of-comments

Thanks for doing this.

jon

