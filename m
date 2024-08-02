Return-Path: <linux-kernel+bounces-272450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 252E9945C14
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 12:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3A3A1F2326C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 10:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C1C1E3CA2;
	Fri,  2 Aug 2024 10:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YAsxxdcS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3042C1DE859
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 10:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722594247; cv=none; b=trwEdijH/gi2/K5VDiNH4zLaT9a/zD0n/VGtq7jxsVpDvFyfRlZiWFmp6+KB0CyQMMtk+7L8h7Rxou466Nqez8KwlHeGdFycBllfmFfZhE+jWoocXFXQnI2WIN3VxjppYczcRJBSUxthqWbi85K46TLswi4AkYKtmzNQWn8EmAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722594247; c=relaxed/simple;
	bh=8/lRbN701cWQ3w4M/QitTPDuCQ96WaFukkxfmlE8Mzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oa5WaiG2VFbYD2teT7dYp27OgMf6LS2FPjC4tEAa8PTsAMP3kvxpSxxnHasLfid+U3FC2S32i/oQA0RQDyoB+5LMG+E7KmEvBo+XC1kZ4bFRdusDE2WqgVtlJaIulFb9hQjIs6IOV1/Ibpkqx3EpVWFsbfh9QSFc+psDWDD/kJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YAsxxdcS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3AD6C32782;
	Fri,  2 Aug 2024 10:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722594246;
	bh=8/lRbN701cWQ3w4M/QitTPDuCQ96WaFukkxfmlE8Mzk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YAsxxdcSrNofQrbQy5tZb6HPGJzd01MjTjeYpi/1IUVQrKT960WoGKToMviWTlEaL
	 43QkLtt05T/dP+y3Oim6DOxUvJ3MBgU+WxeNtMDAz/BGqKBqkAMpsRGVzq4aJbNQbz
	 tQjOKybp61Jhs+GIr3K2s1tC35XNeYu34gTHwD05PEB0AG2arg/zeK1Yr44SEMGk/o
	 WL6ZnBiwfXfWjDVOLcuFa5Nir1so1Dh6ifcXqYxb+ESQjBav+dMzX5SzTrd4C2CwuA
	 SfcKZ2JLehBi3JY9XGXAseLXVLMJgJLfm/lNUR5rXQfLFbQfgtvUWKmTPJr4EpdCUd
	 POVa/Yjg727ng==
Date: Fri, 2 Aug 2024 11:24:02 +0100
From: Will Deacon <will@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: catalin.marinas@arm.com, Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: arm_pmuv3: Fix chained event check for cycle
 counter
Message-ID: <20240802102401.GA6004@willie-the-truck>
References: <20240710182357.3701635-1-robh@kernel.org>
 <20240801112923.GA4476@willie-the-truck>
 <CAL_Jsq+YoHYyUF25aD6ACbiUj3+M2c4uH5tWGB+u12AiCp6fGg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_Jsq+YoHYyUF25aD6ACbiUj3+M2c4uH5tWGB+u12AiCp6fGg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Aug 01, 2024 at 11:19:26AM -0600, Rob Herring wrote:
> On Thu, Aug 1, 2024 at 5:29 AM Will Deacon <will@kernel.org> wrote:
> >
> > On Wed, Jul 10, 2024 at 12:23:56PM -0600, Rob Herring (Arm) wrote:
> > > Since commit b7e89b0f5bd7 ("perf: arm_pmu: Remove event index to
> > > counter remapping"), armv8pmu_event_is_chained() is incorrectly
> > > returning that the cycle counter is chained, but the cycle counter has
> > > always been 64-bit. The result is trying to configure counter #30 which
> > > typically doesn't exist.
> > >
> > > As ARMV8_PMU_MAX_GENERAL_COUNTERS is the number of counters (31), the
> > > comparison to the counter index needs to be '<' rather than '<='.
> > >
> > > Fixes: b7e89b0f5bd7 ("perf: arm_pmu: Remove event index to counter remapping")
> > > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> > > ---
> > >  drivers/perf/arm_pmuv3.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
> > > index 3b3a3334cc3f..0e22c68fb804 100644
> > > --- a/drivers/perf/arm_pmuv3.c
> > > +++ b/drivers/perf/arm_pmuv3.c
> > > @@ -482,7 +482,7 @@ static bool armv8pmu_event_is_chained(struct perf_event *event)
> > >       return !armv8pmu_event_has_user_read(event) &&
> > >              armv8pmu_event_is_64bit(event) &&
> > >              !armv8pmu_has_long_event(cpu_pmu) &&
> > > -            (idx <= ARMV8_PMU_MAX_GENERAL_COUNTERS);
> > > +            (idx < ARMV8_PMU_MAX_GENERAL_COUNTERS);
> > >  }
> >
> > Acked-by: Will Deacon <will@kernel.org>
> >
> > Catalin -- please can you pick this up as a fix?
> 
> No, this is the fix for what Will dropped and said to resend on the
> v9.4 fixed instruction counter series. Here's the series with the fix
> in it[1].

Urgh, sorry about that, and thanks for pointing it out.

I'd initially marked this as read, but then I was pointed at it the
other day and thought I'd missed a fix since "git show b7e89b0f5bd7"
still shows the patch, despite pruning the remotes.

I'll queue up the other series for 6.12.

Will

