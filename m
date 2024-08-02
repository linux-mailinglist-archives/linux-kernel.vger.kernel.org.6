Return-Path: <linux-kernel+bounces-273034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E6094639C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 21:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61D50282697
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 19:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62741547C8;
	Fri,  2 Aug 2024 19:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TnNj421O"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360911E522
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 19:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722626019; cv=none; b=TxPWvGRjmzQkOywLCxZBzcW5yLgEMfyn6rhypDKAdyTka0SbiJu3pwSmxg2Jyv+M8GnJ3P+vNlRs5vSZRgfKEwomv9ygyjgnZQldlvmBOUypMEwKCKxQsx/xPQr7SrvXH7COcPAhzA5R06XFGVeqeUqoSPgGfarov7BqRzYZS9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722626019; c=relaxed/simple;
	bh=Jua3J/LayVcC+eTgoSkiSKa61qcgp60XVTJ0ZVoNlAM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=diJi9edj2cxtCBTkKgaynyANVGoPQeFC8hzZ/pkSE5abONwQotepVKcQV3ylOJsjko56S01nns2GihU65VtY8mHbESBqY/BWdAzChVM2c+8obUc41JLhZsgywuNspBkco/AfqaQ0OnyaewbnTkQHRScpGxI5LpZEieu5a/4H6mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TnNj421O; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42807cb6afdso252925e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 12:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722626016; x=1723230816; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jua3J/LayVcC+eTgoSkiSKa61qcgp60XVTJ0ZVoNlAM=;
        b=TnNj421OBE+viljwMfnYrn+dS9mDFDshKE34X3ejpwM+8LDQUyBp3yDrWLS0edxehN
         TTxhv5BVLgwe/R/0DyZ5nD4+AgSevYEcZlvMB0FRF7qZfP2S1/VBlbT4xdVL2fWLryk7
         z94386ZePO3nP+RwAJehMiBvKy4+lIekng6aqa+nLxzEmjHrqG51UC8tz6BMhP/7/taf
         GGw7bsuPCq798ZBI5Fuz52Og0IEe0heKsIUhIm2M6NPtgsSmeA0M5YCT2HrLU6d+6SNn
         XKRtHcMOMAxuHB8J9d5X8Lh1zJFfxNYgJyUhE8iOw3GnIIFgVbKnrRKiajNj3d0miLU0
         pgRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722626016; x=1723230816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jua3J/LayVcC+eTgoSkiSKa61qcgp60XVTJ0ZVoNlAM=;
        b=e38U7e8AN9uTAtMbbDFz++l3Z1NyrVT/Id+rariLzPosH/dh3SPj+56saWQUhorGg8
         tRwRJpEJAVxPJPZa57vYJtTEIfSA62ucq489qlttEkhii6UcN6hOtSzJOVt7XrwjCb3T
         qJ/veRAuMPCywG30kd7ks8q/EqzlliuYIvPmLrD1pvQDcq1CuduJvuJFmLPk4qB43xhb
         W1wYikI/skzNJMWMGWiA9eFT1Uxl8Tymvo9UTPMpihiJRsQchVCazyitKVqXj6W7l49c
         IP8oiAdUvKcTdurEARvg9K4VZqDhRYuW4aR6T0eAfSALn/g67I2u0Jf7Z7BSXOrIA9Vt
         IJWA==
X-Forwarded-Encrypted: i=1; AJvYcCUqz2s5jMYBW2R0H+LS050qxN0V598cv9HolPeCCK6JTS8HQCDz3yM1uuvLQPYKWZBnWpuzJTtamptj+U+vNRZEl+nB5DTJ6lj/uNbb
X-Gm-Message-State: AOJu0YwAE2RPTGxbDZSinVuxTeIlevAgBHAQU65wAKKMBFHMYGp79vmj
	Sp8WmPTa+L2QqJfkHY8mTRtTPojspK3a5fmLXokk6rn9FupuNOuojIrCQ/P/WHcw+I23+97+aWR
	HBNjAJ4irobcooJgQpZCmzq7eEP4l59YSqc8L
X-Google-Smtp-Source: AGHT+IHXCP4djMRdMYQl12cHAtf0Pg03G/+hHpBldAw68EnWkHz53MNEFLATBuNAIQQfmSo4ksTfZus3Hn/R/QILRYc=
X-Received: by 2002:a05:600c:8112:b0:428:31c:5a42 with SMTP id
 5b1f17b1804b1-428eeaa09famr217385e9.3.1722626016218; Fri, 02 Aug 2024
 12:13:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1720043311.git.babu.moger@amd.com> <e04b721a-b5cb-4089-a3ad-125a6247e5b8@intel.com>
 <1c50b589-a738-4ae6-8362-bd1ce0d0dc98@amd.com> <05b4e345-ad14-4ea9-a13f-2c9b3a6eb422@intel.com>
 <CALPaoCi_TBZnULHQpYns+H+30jODZvyQpUHJRDHNwjQzajrD=A@mail.gmail.com>
 <b3babdac-da08-4dfd-9544-47db31d574f5@intel.com> <05786b1c-cc4e-26ea-581d-3aad3b594f91@amd.com>
In-Reply-To: <05786b1c-cc4e-26ea-581d-3aad3b594f91@amd.com>
From: Peter Newman <peternewman@google.com>
Date: Fri, 2 Aug 2024 12:13:24 -0700
Message-ID: <CALPaoChDv+irGEmccaQ6SpsuVS8PZ_cfzPgceq3hD3N2cqNjZA@mail.gmail.com>
Subject: Re: [PATCH v5 00/20] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
To: babu.moger@amd.com
Cc: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net, fenghua.yu@intel.com, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	paulmck@kernel.org, rdunlap@infradead.org, tj@kernel.org, 
	peterz@infradead.org, yanjiewtw@gmail.com, kim.phillips@amd.com, 
	lukas.bulwahn@gmail.com, seanjc@google.com, jmattson@google.com, 
	leitao@debian.org, jpoimboe@kernel.org, rick.p.edgecombe@intel.com, 
	kirill.shutemov@linux.intel.com, jithu.joseph@intel.com, kai.huang@intel.com, 
	kan.liang@linux.intel.com, daniel.sneddon@linux.intel.com, 
	pbonzini@redhat.com, sandipan.das@amd.com, ilpo.jarvinen@linux.intel.com, 
	maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, eranian@google.com, james.morse@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Babu,

On Fri, Aug 2, 2024 at 11:49=E2=80=AFAM Moger, Babu <bmoger@amd.com> wrote:
>
> Hi Peter/Reinette,
>
> On 8/2/2024 11:13 AM, Reinette Chatre wrote:
> > Hi Peter,
> >
> > On 8/1/24 3:45 PM, Peter Newman wrote:
> >> However, If we don't expect to see these semantics in any other
> >> implementation, these semantics could be implicit in the definition of
> >> a SW assignable counter.
> >
> > It is not clear to me how implementation differences between hardware
> > and software assignment can be hidden from user space. It is possible
> > to let user space enable individual events and then silently upgrade it
> > to all events. I see two options here, either "mbm_control" needs to
> > explicitly show this "silent upgrade" so that user space knows which
> > events are actually enabled, or "mbm_control" only shows flags/events
> > enabled
> > from user space perspective. In the former scenario, this needs more
> > user space support since a generic user space cannot be confident which
> > flags are set after writing to "mbm_control". In the latter scenario,
> > meaning of "num_mbm_cntrs" becomes unclear since user space is expected
> > to rely on it to know which events can be enabled and if some are
> > actually "silently enabled" when user space still thinks it needs to be
> > enabled the number of available counters becomes vague.
> >
> > It is not clear to me how to present hardware and software assignable
> > counters with a single consistent interface. Actually, what if the
> > "mbm_mode" is what distinguishes how counters are assigned instead of h=
ow
> > it is backed (hw vs sw)? What if, instead of "mbm_cntr_assignable" and
> > "mbm_cntr_sw_assignable" MBM modes the terms "mbm_cntr_event_assignable=
"
> > and "mbm_cntr_group_assignable" is used? Could that replace a
> > potential "mbm_assign_events" while also supporting user space in
> > interactions with "mbm_control"?
>
> If I understand correctly, current interface might work for both the sw
> and hw assignments.
>
> In case of SW assignment, you need to manage two counters at context
> switch time. One for total event and one for local event. Basically, you
> need to calculate delta for both events. You need to do rmid read for
> both events and then calculate the delta.
>
> If the user assigns only one event you do the calculations only for the
> event user is interested in. That will save cycles as well. In this case
> "mbm_control" will report as one one event is assigned.
>
> In many cases user will not interested in both the events. Also events
> are configurable so users can get what they want with just one event.
>
> Does that make sense?

I think you've confused soft-RMID for soft-ABMC. Or more likely I've
confused you by not using consistent terminology.

soft-RMIDs are simulated by reading the counters of HW RMIDs
permanently assigned to each CPU at context switch. We found the
context switch cost of this approach unacceptable.

soft-ABMC is permanently associating an RMID with the local and total
counter-pair that will be automatically associated with it when it is
first loaded into a PQR_ASSOC MSR in a domain, then using the
mbm_control interface to choose which group to associate with these
RMIDs. This does not require any context switching work. This
technique is specific to the behavior of AMD hardware.

-Peter

