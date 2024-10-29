Return-Path: <linux-kernel+bounces-387566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61CCB9B5301
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 20:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 993EC1C228CC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 19:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFFAC207206;
	Tue, 29 Oct 2024 19:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3/M5U0sB"
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24813205ACD
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 19:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730231639; cv=none; b=DhJpNUT3QlXRx1FohYKm+lrMgpeIeuYCQuf7KQ0/79mgqUeja0e+UGtX2H50Izuo6mQutkoVV8kf7olVdsjNx3MD7le0uEomb7Nbv+laep2YMz6AMiA4xh1V/PfVRH1LJCiv8EQsjKxYqFm1wajc8dCfdIHg9EwoaQr7MfgTm1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730231639; c=relaxed/simple;
	bh=bC/aoiCY+0/pd6/iVVaQE1r33l0jbGNXMhU7hb06FSY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MF8KXG/yKL1FjfGDahpm23tZDv5Cf7CWPJk+xtPPTvdw2JSj5Z9jnezeev+zZsLfT6zoO0FUmW7PUGBAB5VGuw8V+O1wIhg7FxT90CUXG3nOy/TCUGzUzUg2qc44idkldTvftKQoCfrME9Zt04YItnTiqWxTYTgK7qqrmrpfqHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3/M5U0sB; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-84fd764f6ddso97537241.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 12:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730231636; x=1730836436; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wF8AVBE566042dEisFc0/QOULIDtd917EPRX8LpaS4Q=;
        b=3/M5U0sBReCT31OQrVKHduL8yj73UMh2MTtKVCZvNY7iqdc6BvtrEPSoMMlAGdt4GJ
         UjxSX+h9smV1ZELV8vXuTOU8WdqTY09JfkDjgcFkUXwQ4yJ/UgnXnKlaQczLePgM2iYl
         XsK+sDze55vYw0XSD8BB7+Pu9CCsBe2a0ZyP7WCKozPKMBFnlDr6XCteZWIDKjb/O0fo
         SDizd3+yjSX+5WvcAqnshgYYuaMLQO9dDCI0lSjXT8wpTmZoBNBVH+PyRRtwWfOoPmdq
         Na4GiIyznk02qzlnKGG6xnvueKr63qfPJjE1RLrGOFmraoJJW7qBFCD1xfUHILrP4h6N
         PeMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730231636; x=1730836436;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wF8AVBE566042dEisFc0/QOULIDtd917EPRX8LpaS4Q=;
        b=VluRqvFOJgwzblSFdDMOeAnAP6clsWb2Y6nFhYWtm564AKPO+B2dgmPtElQxOBvMl/
         gAQUhpUwEYf9N4pflGorIJMw20AZ1DOnj+b1BxCK6oIm/R4ZQZDbXjlhXTfePdkCmK3B
         SiCqxV+Fffn84EUQxblXMvz8l6tscV3lgUdVRi+pn71AVKlJbYjrv66ce9wGR3OPMd2H
         k3keWLuP8/ToSqGt03EX3/vTj0vFnh6qA9KYtQQX58joukRkpVQtgpTHN80Rcg751dTp
         pmiTF5kPMVwD2ZsTV33u2QPzt3iuimhK92EGCMLbX7ltbnFOaHACKOBcwc9yf9zVP4sy
         9qog==
X-Forwarded-Encrypted: i=1; AJvYcCVmbFQQMVNdjGNybjXQDNq8uo6S34KlgI2YLlUSa+UPfvAE8lbiyGXTtGSYc1Gh8HJzJjYfXbXntoAzv4w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUV1iZPrdpelk/8OlMipv/Rg5T70ufc5KF2IFMQsG4KAEqABCa
	MBjCIREKTsCvcKB3QoRGI2HOrkaDmieIfbd3I2EnINzI9OQGJmiwJdL7CGUg75IBv9zk9Lt0ZnY
	XvcxPt2Fq14rlYEEXMeKdMDnKEJn3Qx3WfY2W
X-Google-Smtp-Source: AGHT+IGiqS8zkowA0hhH1G9zpWHqiGgjCkwEqm4HQq3vuHcJXKhYb0OieWP/5MMHrb/rtD2no9MHT8oFzOwREShVmNE=
X-Received: by 2002:a05:6102:a52:b0:4a4:77c7:9471 with SMTP id
 ada2fe7eead31-4a8f67c4340mr2620516137.5.1730231635771; Tue, 29 Oct 2024
 12:53:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021042218.746659-1-yuzhao@google.com> <20241021042218.746659-4-yuzhao@google.com>
 <86a5ew41tp.wl-maz@kernel.org> <CAOUHufanq2_nbNiU_=mCgWufoSGDOS3EpAz+4xB5kB=PV2ECVA@mail.gmail.com>
 <86h6902m7y.wl-maz@kernel.org> <CAOUHufbEadyAn0WVdJqYKkUjvMfGXXiLjaApjhaHKg93P8Rymg@mail.gmail.com>
 <864j4u3f7l.wl-maz@kernel.org>
In-Reply-To: <864j4u3f7l.wl-maz@kernel.org>
From: Yu Zhao <yuzhao@google.com>
Date: Tue, 29 Oct 2024 13:53:17 -0600
Message-ID: <CAOUHufZFQ+RrSRiSw00Gv8bjn04hAg92eAbdp-tRoKM36R7uVQ@mail.gmail.com>
Subject: Re: [PATCH v1 3/6] irqchip/gic-v3: support SGI broadcast
To: Marc Zyngier <maz@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Muchun Song <muchun.song@linux.dev>, Thomas Gleixner <tglx@linutronix.de>, 
	Will Deacon <will@kernel.org>, Douglas Anderson <dianders@chromium.org>, 
	Mark Rutland <mark.rutland@arm.com>, Nanyong Sun <sunnanyong@huawei.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 1:02=E2=80=AFPM Marc Zyngier <maz@kernel.org> wrote=
:
>
> On Fri, 25 Oct 2024 18:31:01 +0100,
> Yu Zhao <yuzhao@google.com> wrote:
> >
> > On Fri, Oct 25, 2024 at 10:15=E2=80=AFAM Marc Zyngier <maz@kernel.org> =
wrote:
> > >
> > > On Fri, 25 Oct 2024 06:07:45 +0100,
> > > Yu Zhao <yuzhao@google.com> wrote:
> > > >
> > > > Hi Marc,
> > > >
> > > > On Tue, Oct 22, 2024 at 9:03=E2=80=AFAM Marc Zyngier <maz@kernel.or=
g> wrote:
> > > > >
> > > > > On Mon, 21 Oct 2024 05:22:15 +0100,
> > > > > Yu Zhao <yuzhao@google.com> wrote:
> > > > > >
> > > > > > @@ -1407,6 +1418,13 @@ static void gic_ipi_send_mask(struct irq=
_data *d, const struct cpumask *mask)
> > > > > >        */
> > > > > >       dsb(ishst);
> > > > > >
> > > > > > +     cpumask_copy(&broadcast, cpu_present_mask);
> > > > >
> > > > > Why cpu_present_mask? I'd expect that cpu_online_mask should be t=
he
> > > > > correct mask to use -- we don't IPI offline CPUs, in general.
> > > >
> > > > This is exactly because "we don't IPI offline CPUs, in general",
> > > > assuming "we" means the kernel, not GIC.
> > > >
> > > > My interpretation of what the GIC spec says ("0b1: Interrupts route=
d
> > > > to all PEs in the system, excluding self") is that it broadcasts IP=
Is to
> > > > "cpu_present_mask" (minus the local one). So if the kernel uses
> > > > "cpu_online_mask" here, GIC would send IPIs to offline CPUs
> > > > (cpu_present_mask ^ cpu_online_mask), which I don't know whether it=
's
> > > > a defined behavior.
> >
> > Thanks for clarifying.
> >
> > > Offline CPUs are not known to the kernel.
> >
> > I assume it wouldn't matter to firmware either, correct? IOW, we
>
> Firmware is on the secure side of the stack.
>
> > wouldn't cause firmware any trouble by letting GIC send IPIs to
> > (cpu_present_mask ^ cpu_online_mask), assuming those two masks can be
> > different on arm64 when hotplug is enabled?
>
> You can't send SGIs from non-secure to secure using ICC_SGI1R_EL1.

Right, this makes sense now.

> You
> would need to use ICC_ASGI1R_EL1, and have secure to allow such
> brokenness via a configuration of GICR_NSACR. Linux doesn't use the
> former, and no sane software touches the latter.
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.

