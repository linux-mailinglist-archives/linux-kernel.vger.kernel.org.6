Return-Path: <linux-kernel+bounces-385475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 285F89B379B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 18:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1C752822C2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 17:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D658C1DF254;
	Mon, 28 Oct 2024 17:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r/lAKwQD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A351DD533
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 17:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730136414; cv=none; b=EkorodXyBmUnoWHUdFEMnyJvKjphQkunycekqEYgNX7Zk8iPcWcE0bNxnct+aHUJsE7pYXxn50ia7dee+HnBfKzynRZd8D5UaZYTIKOMmee5LUzaQ3MQ83z2vbrlvhEmJu2SS+8WlT2xpqxjrNEFfSOqTi26pcPsnJ20hVwa5n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730136414; c=relaxed/simple;
	bh=SKqZVIdbcpTAJdp25Ku/rlpGb1j+HCxQ0QZMwxF98NA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZH2W4rmgk4k6TsfyNZVJLstpkvVqfK4JHNB60ax5+Bu7ASXdf2LZ0QhkNy6LwG5FuGHUHqQuZUCzlVyeXpor7GhvOAz6Me82u+S5qK4UqXzQc+BlpgQsS3o/h6EeBYc44/hhKr2cEN5VJjYOHs8N/TRr5ph53A2CVeInuUZUfqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r/lAKwQD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5085FC4CEC3;
	Mon, 28 Oct 2024 17:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730136413;
	bh=SKqZVIdbcpTAJdp25Ku/rlpGb1j+HCxQ0QZMwxF98NA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r/lAKwQDurB3M9qJLZpE61TvOd5s05B2G6+c9/KEZ6fU2GRJekqo0+OK18Dec7yeg
	 8LSARWFaeNF6I9Lt5SZlaeZCmYtOU4QUjCxsgjdYR1ErU+8NW1+In5eGwx3k+bhDPQ
	 8G7Lnhnx1xwLjukiuQpOy5HXIBFc3Uerll5OzvFxsIZvb5GWQTuUpsQrdNsDTxY82U
	 dHoJith1tEq42QRdE7AUKS1TqMJAt8j+ZhrD/vV/zN4/eCfeeMzpQbYc5u/Su4lwFn
	 HXkKZYIxkiZ2p0ygNutzWWHyyDsPRAocJryCCT+99/uCDaEzP/oyu7ugTtzuF4rLId
	 jLu3eTIKqYMVA==
Date: Mon, 28 Oct 2024 17:26:48 +0000
From: Will Deacon <will@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/arm_pmuv3: Add PMUv3.9 per counter EL0 access
 control
Message-ID: <20241028172647.GB2871@willie-the-truck>
References: <20241002184326.1105499-1-robh@kernel.org>
 <20241024103953.GA30206@willie-the-truck>
 <CAL_JsqKT3gXJQLNr+H8D8nmEeGuDxS8iOje6yaCs+ne-4FcCvg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqKT3gXJQLNr+H8D8nmEeGuDxS8iOje6yaCs+ne-4FcCvg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Oct 24, 2024 at 11:41:11AM -0500, Rob Herring wrote:
> On Thu, Oct 24, 2024 at 5:40 AM Will Deacon <will@kernel.org> wrote:
> > On Wed, Oct 02, 2024 at 01:43:24PM -0500, Rob Herring (Arm) wrote:
> > > diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
> > > index 0afe02f879b4..bb93d32b86ea 100644
> > > --- a/drivers/perf/arm_pmuv3.c
> > > +++ b/drivers/perf/arm_pmuv3.c
> > > @@ -770,18 +770,27 @@ static void armv8pmu_enable_user_access(struct arm_pmu *cpu_pmu)
> > >       int i;
> > >       struct pmu_hw_events *cpuc = this_cpu_ptr(cpu_pmu->hw_events);
> > >
> > > -     /* Clear any unused counters to avoid leaking their contents */
> > > -     for_each_andnot_bit(i, cpu_pmu->cntr_mask, cpuc->used_mask,
> > > -                         ARMPMU_MAX_HWEVENTS) {
> > > -             if (i == ARMV8_PMU_CYCLE_IDX)
> > > -                     write_pmccntr(0);
> > > -             else if (i == ARMV8_PMU_INSTR_IDX)
> > > -                     write_pmicntr(0);
> > > -             else
> > > -                     armv8pmu_write_evcntr(i, 0);
> > > +     if (is_pmuv3p9(cpu_pmu->pmuver)) {
> > > +             u64 mask = 0;
> > > +             for_each_set_bit(i, cpuc->used_mask, ARMPMU_MAX_HWEVENTS) {
> > > +                     if (armv8pmu_event_has_user_read(cpuc->events[i]))
> > > +                             mask |= BIT(i);
> > > +             }
> > > +             write_pmuacr(mask);
> >
> > Since this is a new register, should we be zeroing it as part of our
> > reset callback?
> 
> That should not be necessary since EL0 access is gated off in PMUSEREN
> in general and enabling this register additionally requires setting
> the UEN bit. That's only done right after this.

That bit is set unconditionally, but it looks like we always write pmuacr
for v3p9 parts so it should be ok. Thanks.

Will

