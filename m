Return-Path: <linux-kernel+bounces-529090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB56A41F7F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A49D718958B8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 12:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54EDB23BD0C;
	Mon, 24 Feb 2025 12:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HKYjXcHv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B7223BCFC;
	Mon, 24 Feb 2025 12:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740401209; cv=none; b=kKO2lYeSm0mVArH3RJd7RzK93bYv7LGVjoAzQqa1kKITEqPahupa8TRiwpZGJN/bOYd+r9hzHenoKJi9QPbQebwXxk5/niCAwP3gPqOWF6bWvNVM+8ojXuCBlI+7zZFGz63x5UDVGyAM4kxuZ1Y9qbk+rV3dLoLa9yIbSghd59M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740401209; c=relaxed/simple;
	bh=0B0CsThfPjGTpaa60Jmv4WtnpWqz89tZ838PBLhiS1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E5a4pq6kAexPkGDrA78l/D/mV1CT7orIs3rmHgzyzcQpMH6WJpox5z6A1Z7oTVdHWbTsCGf95ERbWm17Mdqhm65imlnuKsGoljT4zDPjWnucKrtbNBdQCFetd47a0uH7maIOnZNzorc4c2csYIDah8XKN952GPUyMrEsaAIN5C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HKYjXcHv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32F8BC4CEE8;
	Mon, 24 Feb 2025 12:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740401209;
	bh=0B0CsThfPjGTpaa60Jmv4WtnpWqz89tZ838PBLhiS1M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HKYjXcHvXoCFVXB33ypRTMi+qhyXXBGo35E/k5RKPWwJtemmIWmE54meLKFZs/EvJ
	 3Sj5yokM+60rAF5eOEJsXxZUsRSJTL9gieVYI7odceLW7YtFOAtpJ1f1jaiAT5QvF6
	 VdQYXKDiyS7Zsl9VeINxjotnJc2NhNY+pDqCZkUmoZowSL5okxpWuO9JuO5gDF7z8q
	 uEETt/7G+YPbqpb1AkdCI3osV8Gl0Qlpu2b4EY1Ebr+060OKuJkXRzM4z/5klxtS2w
	 kOZLWvJ8qoeFPZNxulPgsx3CZktIrjFRwFMc/itwI46QhFscpfyp6fY0sOMoWH7yPx
	 68tHEOSFVsICQ==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e033c2f106so5752131a12.3;
        Mon, 24 Feb 2025 04:46:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU1snL8XXmri7I1NfbPSU0phd3YvTUJ77HALIWaIuk3sWeabj25TmpTUBEUJDiFWdvt638vDuUjX57PP9q1@vger.kernel.org, AJvYcCV4oLoJILvFQvRMNjGf0s6dG2mvlG+9eNSCj5SNv46LAdfO8FLmsejF4HVKKwjdakIsAXR7ZXpuWBGWpYjqC3DiRQ==@vger.kernel.org, AJvYcCWQHJ21eEWs+mvwO6XWy07w9sWThtfRCatAOtSy/EzCbsuxHQDLV5jj3IDDt0kAUzB6cHx706RI2OM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnxdV5EPDjT3hdCj/WMo5hCdUgBMpX2sUfLr6KGkZ75t/qTGbD
	d9gcJVSdV4ZbWFE/MLPcDKPVrz/4HeB5M31v4mLJqeOw/BPnF27JWMX730hI8iThsSkZcjFY1es
	gHQ92Hf6g5VJ2CNNubi9kQtrF1Q==
X-Google-Smtp-Source: AGHT+IFSrlzVDhPG7lgCi1VU8B1AxKksGxiI/QFAwg0k5D4fCtrCiSkO61qkvx8HAbvnWUGOsp8xAAa6cceHz1Shh+I=
X-Received: by 2002:a05:6402:278e:b0:5dc:cf9b:b04a with SMTP id
 4fb4d7f45d1cf-5e0b70bfd22mr30104043a12.1.1740401207751; Mon, 24 Feb 2025
 04:46:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250218-arm-brbe-v19-v20-0-4e9922fc2e8e@kernel.org>
 <20250218-arm-brbe-v19-v20-11-4e9922fc2e8e@kernel.org> <20250224122507.GE8144@e132581.arm.com>
In-Reply-To: <20250224122507.GE8144@e132581.arm.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 24 Feb 2025 06:46:35 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+0fZ2uasgAam7qGTdCeDBQxXeyL-J1_suyxy6GE_ERTg@mail.gmail.com>
X-Gm-Features: AWEUYZlK0yq7SIgMIaSVRny1cLnFGm1k0eFBcoGHQEZGYoT0-XXIWWwS_6M-XJc
Message-ID: <CAL_Jsq+0fZ2uasgAam7qGTdCeDBQxXeyL-J1_suyxy6GE_ERTg@mail.gmail.com>
Subject: Re: [PATCH v20 11/11] perf: arm_pmuv3: Add support for the Branch
 Record Buffer Extension (BRBE)
To: Leo Yan <leo.yan@arm.com>
Cc: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	James Clark <james.clark@linaro.org>, Anshuman Khandual <anshuman.khandual@arm.com>, 
	linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	kvmarm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 6:25=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
>
> On Tue, Feb 18, 2025 at 02:40:06PM -0600, Rob Herring (Arm) wrote:
> >
> > From: Anshuman Khandual <anshuman.khandual@arm.com>
>
> [...]
>
> > BRBE records are invalidated whenever events are reconfigured, a new
> > task is scheduled in, or after recording is paused (and the records
> > have been recorded for the event). The architecture allows branch
> > records to be invalidated by the PE under implementation defined
> > conditions. It is expected that these conditions are rare.
>
> [...]
>
> > +static void armv8pmu_sched_task(struct perf_event_pmu_context *pmu_ctx=
, bool sched_in)
> > +{
> > +       struct arm_pmu *armpmu =3D *this_cpu_ptr(&cpu_armpmu);
> > +       struct pmu_hw_events *hw_events =3D this_cpu_ptr(armpmu->hw_eve=
nts);
> > +
> > +       if (!hw_events->branch_users)
> > +               return;
> > +
> > +       if (sched_in)
> > +               brbe_invalidate();
> > +}
>
> Just a minor concern.  I don't see any handling for task migration.
> E.g., for a task is migrated from one CPU to another CPU, I expect we
> need to save and restore branch records based on BRBE injection.  So
> far, the driver simply invalidates all records.
>
> I think this topic is very likely discussed before.  If this is the
> case, please ignore my comment.  Except this, the code looks good
> to me.

Not really discussed on the list, but that was present in v18 (though
not functional because .sched_task() hook wasn't actually enabled) and
Mark removed it. His work is here[1].The only comment was:

Note: saving/restoring at context-switch doesn't interact well with
event rotation (e.g. if filters change)

Rob

[1] https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?=
h=3Darm64/brbe&id=3D642985af34d2d6f54e76995380cf24d512078c56

