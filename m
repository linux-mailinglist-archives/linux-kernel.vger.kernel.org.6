Return-Path: <linux-kernel+bounces-288200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4535953736
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 17:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FA671F221B2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 15:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5605B1B32D5;
	Thu, 15 Aug 2024 15:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FtMo05j2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C2E1AC44F;
	Thu, 15 Aug 2024 15:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723735646; cv=none; b=nZc5CwqH/7FnRK8yDU6K+Votc86nAO+W9WlBPq64OvHBkizU2Y6xZkX0fauilAlERBw3Zv2JmC1lM8AxoGUskNIjogHjzszGYYGDSsn1yQ8gl4QxqHBR+wcj4zl4DwFTY63lFgZwACqqPnPgCb1OZceSjHgl2yXJFb+RWikRlOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723735646; c=relaxed/simple;
	bh=p2jLPPHB4vsEhoMXb7GF6s/tZkL0eGrxMwHfXM622dg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rp6R3G+6gNlEtnqqABtqmJtGucM0jGOLy+mIcEuI6b6VhFTG6ES2HKwheY1erHrzGX3w83XvQAvyiZvxGvWIE1AQ7ozaxHsKOW6A0JixaL5fsXIt6lP2tSS+cILxTD3BgD4dxJyeqs2dFwbVGRnoQHMJcZI7IVHOJwEmmvgNg6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FtMo05j2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 723F2C32786;
	Thu, 15 Aug 2024 15:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723735644;
	bh=p2jLPPHB4vsEhoMXb7GF6s/tZkL0eGrxMwHfXM622dg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FtMo05j2P1Rj2FW4QY8TCvMhaW59ZLxizsboZkGN1UdCJQSzCyw4TfYMCpI3/e86z
	 e1r0csBsLPPLUpu449bj3BnUTfco+odnS5U9x3+SdX2PB6X4Y5P+cttCKLeZL3WYfs
	 zUXbv2XSkZE5Us7+fbcys9ROT4ZcsmguLsQoKypWZQyXulb1fTKwFwMbbkRR5PGFqs
	 t4aLnuFsloAnfabwuRx5kH0pcZLdLweIvvMuExSki4g0J+IkbU3sFRQ1ZBnMeJVx7K
	 9/JUj3KZRz1lwvV9BhZfMqGhvk/pUXy5KTRTM5ZFeBRmFn8MUdXqX/9UfiyBViS2kC
	 nCq9gxtCR0Ydg==
Date: Thu, 15 Aug 2024 12:27:21 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Ian Rogers <irogers@google.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Linux perf Profiling <linux-perf-users@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	James Clark <james.clark@arm.com>,
	"cc: Marc Zyngier" <maz@kernel.org>,
	Hector Martin <marcan@marcan.st>,
	Asahi Linux <asahi@lists.linux.dev>,
	Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [REGRESSION] Perf (userspace) broken on big.LITTLE systems since
 v6.5
Message-ID: <Zr4eWd6HWLHDcpC9@x1>
References: <08f1f185-e259-4014-9ca4-6411d5c1bc65@marcan.st>
 <ZV1AnNB2CSbAUFVg@archie.me>
 <a9c14dfd-3269-4758-9174-4710bef07088@leemhuis.info>
 <CAP-5=fXqx_k1miPTkcAmS3z2GBPt2KeDtP5fknmdDghZqxXPew@mail.gmail.com>
 <714ed350-0e6c-4922-bf65-36de48f62879@leemhuis.info>
 <0de3b572-f5f7-42e4-b410-d1e315943a3c@linaro.org>
 <ZrzeRM3ekLl9zp3z@x1>
 <348ea015-eccf-4f44-a332-a1d9d8baf81f@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <348ea015-eccf-4f44-a332-a1d9d8baf81f@linaro.org>

On Thu, Aug 15, 2024 at 04:15:41PM +0100, James Clark wrote:
> 
> 
> On 14/08/2024 5:41 pm, Arnaldo Carvalho de Melo wrote:
> > On Wed, Aug 14, 2024 at 05:28:42PM +0100, James Clark wrote:
> > > 
> > > 
> > > On 07/08/2024 9:54 am, Thorsten Leemhuis wrote:
> > > > On 01.08.24 21:05, Ian Rogers wrote:
> > > > > On Wed, Dec 6, 2023 at 4:09 AM Linux regression tracking #update
> > > > > (Thorsten Leemhuis) <regressions@leemhuis.info> wrote:
> > > > > > 
> > > > > > [TLDR: This mail in primarily relevant for Linux kernel regression
> > > > > > tracking. See link in footer if these mails annoy you.]
> > > > > > 
> > > > > > On 22.11.23 00:43, Bagas Sanjaya wrote:
> > > > > > > On Tue, Nov 21, 2023 at 09:08:48PM +0900, Hector Martin wrote:
> > > > > > > > Perf broke on all Apple ARM64 systems (tested almost everything), and
> > > > > > > > according to maz also on Juno (so, probably all big.LITTLE) since v6.5.
> > > > > > 
> > > > > > #regzbot fix: perf parse-events: Make legacy events lower priority than
> > > > > > sysfs/JSON
> > > > > > #regzbot ignore-activity
> > > > > 
> > > > > Note, this is still broken.
> > > > 
> > > > Hmmm, so all that became somewhat messy. Arnaldo, what's the way out of
> > > > this? Or is this a "we are screwed one way or another and someone has to
> > > > bite the bullet" situation?
> > > > 
> > > > Ciao, Thorsten
> > > > 
> > > > > The patch changed the priority in the case
> > > > > that you do something like:
> > > > > 
> > > > > $ perf stat -e 'armv8_pmuv3_0/cycles/' benchmark
> > > > > 
> > > > > but if you do:
> > > > > 
> > > > > $ perf stat -e 'cycles' benchmark
> > > > > 
> > > > > then the broken behavior will happen as legacy events have priority
> > > > > over sysfs/json events in that case. To fix this you need to revert:
> > > > > 4f1b067359ac Revert "perf parse-events: Prefer sysfs/JSON hardware
> > > > > events over legacy"
> > > > > 
> > > > > This causes some testing issues resolved in this unmerged patch series:
> > > > > https://lore.kernel.org/lkml/20240510053705.2462258-1-irogers@google.com/
> > > > > 
> > > > > There is a bug as the arm_dsu PMU advertises an event called "cycles"
> > > > > and this PMU is present on Ampere systems. Reverting the commit above
> > > > > will cause an issue as the commit 7b100989b4f6 ("perf evlist: Remove
> > > > > __evlist__add_default") to fix ARM's BIG.little systems (opening a
> > > > > cycles event on all PMUs not just 1) will cause the arm_dsu event to
> > > > > be opened by perf record and fail as the event won't support sampling.
> > > > > 
> > > > > The patch https://lore.kernel.org/lkml/20240525152927.665498-1-irogers@google.com/
> > > > > fixes this by only opening the cycles event on core PMUs when choosing
> > > > > default events.
> > > > > 
> > > > > Rather than take this patch the revert happened as Linus runs the
> > > > > command "perf record -e cycles:pp" (ie using a specified event and not
> > > > > defaults) and considers it a regression in the perf tool that on an
> > > > > Ampere system to need to do "perf record -e
> > > > > 'armv8_pmuv3_0/cycles/pp'". It was pointed out that not specifying -e
> > > > > will choose the cycles event correctly and with better precision the
> > > > > pp for systems that support it, but it was still considered a
> > > > > regression in the perf tool so the revert was made to happen. There is
> > > > > a lack of perf testing coverage for ARM, in particular as they choose
> > > > > to do everything in a different way to x86. The patch in question was
> > > > > in the linux-next tree for weeks without issues.
> > > > > 
> > > > > ARM/Ampere could fix this by renaming the event from cycles to
> > > > > cpu_cycles, or by following Intel's convention that anything uncore
> > > > > uses the name clockticks rather than cycles. This could break people
> > > > > who rely on an event called arm_dsu/cycles/ but I imagine such people
> > > > > are rare. There has been no progress I'm aware of on renaming the
> > > > > event.
> > > > > 
> > > > > Making perf not terminate on opening an event for perf record seems
> > > > > like the most likely workaround as that is at least something under
> > > > > the tool maintainers control. ARM have discussed doing this on the
> > > > > lists:
> > > > > https://lore.kernel.org/lkml/f30f676e-a1d7-4d6b-94c1-3bdbd1448887@arm.com/
> > > > > but since the revert in v6.10 no patches have appeared for the v6.11
> > > > > merge window. Feature work like coresight improvements and ARMv9 are
> > > > > being actively pursued by ARM, but feature work won't resolve this
> > > > > regression.
> > > > > 
> > > 
> > > I got some hardware with the DSU PMU so I'm going to have a go at trying to
> > > send some fixes for this. My initial idea was to try incorporate the "not
> > > terminate on opening" change as discussed in the link directly above. And
> > > then do the revert of the "revert of prefer sysfs/json".
> > > 
> > > FWIW I don't think Juno currently is broken if the kernel supports extended
> > > type ID? I could have missed some output in this thread but it seems like
> > > it's mostly related to Apple M hardware. I'm also a bit confused why the
> > > "supports extended type" check fails there, but maybe the v6.9 commit
> > > 25412c036 from Mark is missing?
> > > 
> > > I sent a small fix the other day to make perf stat default arguments work on
> > > Juno, and didn't notice anything out of the ordinary: https://lore.kernel.org/linux-perf-users/dac6ad1d-5aca-48b4-9dcb-ff7e54ca43f6@linaro.org/T/#t
> > > I agree that change is quite narrow but it does incrementally improve things
> > > for the time being. It's possible that it would become redundant if I can
> > > just include Ian's change to use strings for Perf stat.
> > > 
> > > Of course I only think I have a handle on the issue right now, seems like it
> > > has a lot of moving parts and something else always comes up. If I hit a
> > > wall at some point I will come back here.
> > 
> > Thanks for working on this, hopefully we'll get to a solution that keeps
> > all the expectations expressed in this thread about not breaking
> > existing muscle memory and that allows us to progress on this matter.
> > 
> > - Arnaldo
> 
> Hi Arnaldo,
> 
> In one of your investigations here
> https://lore.kernel.org/lkml/Zld3dlJHjFMFG02v@x1/ comparing "cycles",
> "cpu-cycles" and "cpu_cycles" events on Arm you say only some of them open
> events on both core types. I wasn't able to reproduce that on
> perf-tools-next (27ac597c0e) or v6.9 (a38297e3fb) for perf record or stat. I
> guessed the 6.9 tag because you only mentioned it was on tip and it was 29th
> May. For me they all open exactly the same two legacy events with the
> extended type ID set.
> 
> It looks like the behavior you see would be caused by either missing this
> kernel change:
> 
>   5c81672865 ("arm_pmu: Add PERF_PMU_CAP_EXTENDED_HW_TYPE capability")
>    (v6.6 release)
> 
> Or this userspace change, but unlikely as it was a fix for Apple M hardware:
> 
>   25412c036 ("perf print-events: make is_event_supported() more robust")
>    (v6.9 release)
> 
> Do you remember if you were using a new kernel or only testing a new Perf?

I normally use the distro/SoC provided kernel, didn't I add the 'uname
-a' output in those investigations (/me slaps himself in the face
speculatively...)?

> Or if you don't mind could you re-test? Hopefully not to derail the

Sure

> discussion but I just want to make sure I'm not missing some other third
> issue before I start hacking away.

This is full of subtleties and has generated a lot of back and forth, so
making sure we don't miss anything is what we should do.
 
> I believe we still need to revert the revert of the JSON/legacy change.

Good to see progress on assessing that.

/me goes and turns on his trusty libre computer board...

- Arnaldo

> Because as Mark mentions there is no guarantee that a PMU's named event is
> the same as a legacy event of the same name, so we do want to prefer
> sysfs/JSON. There are some other edge cases like new Perf on an old kernel
> before we added extended type support, but I don't think I'll list all of
> them.
> 
> Having said that, I believe that currently all the sysfs and legacy events
> actually _are_ the same. So it's not a user facing issue _yet_, or at least
> on any hardware mentioned in these threads.
> 
> Thanks
> James

