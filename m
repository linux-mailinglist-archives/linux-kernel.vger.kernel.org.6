Return-Path: <linux-kernel+bounces-299194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA67695D16D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 17:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57DDCB2382F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 15:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDBE11891BB;
	Fri, 23 Aug 2024 15:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iQN7pBsZ"
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A197A185E65
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 15:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724427001; cv=none; b=u6e2gLespXJ60jtnIwKIgfbqou1eyVuF2WFEAboIVOvoMzfOm6WfXA3YJYRXFDEgGmAr7A8P4N+MR1ucLXDqXXEWxc3/zwdBcImzNcz66QrwEUMnW247WYmyjfh29UioTLiRFcT5s4tSzh6TxXIo/zwYnqhwmMmHTnxidxN5pjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724427001; c=relaxed/simple;
	bh=oNfQ4tia5EGE6ACUTEBJMYDZJ9v/LW5wX588X1lUppw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HWPSiWgg7aEIDe+2SnVfv6/b2cZbaAP8iYvzpPLKsRhiNqyOjlcZ8RyMFtlN4VR7/FDtZ12SSRLchhADTgwnjXdFtS6TyIPoopTP2inWhW412OE8DEIm/BL2iZUsXyy7zf2fC35tKzkrWnTJ/RqQ3Z6zc2Ke/mh8HLb4hO7Kjrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=iQN7pBsZ; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7093472356dso1596692a34.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 08:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724426996; x=1725031796; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1l5A3SKIR/YWwP2aJcT73ZHnLsJzRksHrml/jGPsy9k=;
        b=iQN7pBsZJxdRLS65shHFNdfA4clGBHIn22iCALi08T990jK+18GwpLqMiE/icyJLXi
         q2DrcoYC4uQh9mTuq377grkcgtnQB0Ep1LzsSDisK2KwOdXGdPH4CO5bIsFCG9lnGabl
         EYhLHF0W0dqKI1GOLfLh//vaXS7TuUnno+yJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724426996; x=1725031796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1l5A3SKIR/YWwP2aJcT73ZHnLsJzRksHrml/jGPsy9k=;
        b=AP+D09LMVexHtAkfqlLzcmnLPHTKCvN1zJBy9a/ce7oPMPRtB/ygb7A5Rb7+OW6Mzp
         g9m8T2bBeHxr83OS2hfOrTJF8UeHKNMN5rXBwbK9hzv/Y23Tz8SYb2mKpHm4Nu20Ip6E
         Srxo1wJixGAp22eyg0zwa3aYjs91L3EGkOgfWwA09m9+GgVbmQRPgxv7x9Dy3DhNTsNr
         tz8FmpRJodYMqK+Eunx6hI5jhZ9x3vA5LTh/qu/jVBw/XoPyQ/xal4yBJGpi1G8FNR58
         4Aij29rJ71KOvsqgDUb2KhUUjiOvy1kJ1v0k6hyZosPFhkdgy10R/Poab7cdkRy/Lszx
         AX2w==
X-Forwarded-Encrypted: i=1; AJvYcCWmrPknlsIoHqTT5++fjMaUSh/zyzKK8WmVNciTA+XG+myN367dpWyBdim0+am4FhbmjHEsUAgx2S5QteI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYcljc/pJBDQfcFpPNdq0hfHAABI9gd9upri0Rhr3KKhH9W5my
	pT1UwizbFCdOEwsJgVWXtaex6sYQ76JHBbTu7pFxBNt6hAiR8ehyJtg0LEkF/23iiC5TO6UxG7s
	=
X-Google-Smtp-Source: AGHT+IGJsGpPABpIzpkKKIJluxD40vaXA95n3kpVSH1Kox0Jcs+wtXznwZkU/6+9QIhUqKJqT4UFTg==
X-Received: by 2002:a05:6830:6d16:b0:709:3f84:c1e0 with SMTP id 46e09a7af769-70e0ebfaf4dmr3086621a34.26.1724426995995;
        Fri, 23 Aug 2024 08:29:55 -0700 (PDT)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com. [209.85.160.175])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162d1d67fsm19696076d6.1.2024.08.23.08.29.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2024 08:29:54 -0700 (PDT)
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-44ff398cefcso10841561cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 08:29:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU3BDg8CQQZZ+FHA6M6C+EhupvNfbcPsK+XDlJMNsE32/H/SLWTitzXqymiuddBFg3bKTAkFOKMVWs1L74=@vger.kernel.org
X-Received: by 2002:a05:6214:5882:b0:6bf:5d4c:32d8 with SMTP id
 6a1803df08f44-6c16dcb7b44mr27582606d6.39.1724426994067; Fri, 23 Aug 2024
 08:29:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821145353.v3.1.Id4817adef610302554b8aa42b090d57270dc119c@changeid>
 <20240823104552.GB31866@willie-the-truck>
In-Reply-To: <20240823104552.GB31866@willie-the-truck>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 23 Aug 2024 08:29:38 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W2NDBCwTbLtuknejMhHeqgGc86Hb4RRWEsQc9BBasETg@mail.gmail.com>
Message-ID: <CAD=FV=W2NDBCwTbLtuknejMhHeqgGc86Hb4RRWEsQc9BBasETg@mail.gmail.com>
Subject: Re: [PATCH v3] arm64: smp: smp_send_stop() and crash_smp_send_stop()
 should try non-NMI first
To: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Yu Zhao <yuzhao@google.com>, 
	Mark Rutland <mark.rutland@arm.com>, Misono Tomohiro <misono.tomohiro@fujitsu.com>, 
	Marc Zyngier <maz@kernel.org>, Sumit Garg <sumit.garg@linaro.org>, Chen-Yu Tsai <wens@csie.org>, 
	Daniel Thompson <daniel.thompson@linaro.org>, Stephen Boyd <swboyd@chromium.org>, 
	Frederic Weisbecker <frederic@kernel.org>, "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
	James Morse <james.morse@arm.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Kees Cook <kees@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, Tony Luck <tony.luck@intel.com>, 
	linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Will,

On Fri, Aug 23, 2024 at 3:46=E2=80=AFAM Will Deacon <will@kernel.org> wrote=
:
>
> Hi Doug,
>
> On Wed, Aug 21, 2024 at 02:53:57PM -0700, Douglas Anderson wrote:
> > When testing hard lockup handling on my sc7180-trogdor-lazor device
> > with pseudo-NMI enabled, with serial console enabled and with kgdb
> > disabled, I found that the stack crawls printed to the serial console
> > ended up as a jumbled mess. After rebooting, the pstore-based console
> > looked fine though. Also, enabling kgdb to trap the panic made the
> > console look fine and avoided the mess.
>
> Just a small nit:
>
> >       while (num_other_online_cpus() && timeout--)
> >               udelay(1);
> >
> > -     if (num_other_online_cpus())
> > +     /*
> > +      * If CPUs are still online, try an NMI. There's no excuse for th=
is to
> > +      * be slow, so we only give them an extra 10 ms to respond.
> > +      */
> > +     if (num_other_online_cpus() && ipi_should_be_nmi(IPI_CPU_STOP_NMI=
)) {
>
> We probably want an smp_rmb() here...
>
> > +             cpumask_copy(&mask, cpu_online_mask);
> > +             cpumask_clear_cpu(smp_processor_id(), &mask);
> > +
> > +             pr_info("SMP: retry stop with NMI for CPUs %*pbl\n",
> > +                     cpumask_pr_args(&mask));
> > +
> > +             smp_cross_call(&mask, IPI_CPU_STOP_NMI);
> > +             timeout =3D USEC_PER_MSEC * 10;
> > +             while (num_other_online_cpus() && timeout--)
> > +                     udelay(1);
> > +     }
> > +
> > +     if (num_other_online_cpus()) {
>
>
> ... and again here, just to make sure that the re-read of cpu_online_mask
> is ordered after the read of __num_online_cpus in num_other_online_cpus()=
.
>
> I can add those when applying.

Sounds like a plan to me. Thanks!

-Doug

