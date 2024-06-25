Return-Path: <linux-kernel+bounces-229808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 631B9917498
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 01:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 186222881E5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 23:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EDAA17F4EB;
	Tue, 25 Jun 2024 23:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mHTdwn4a"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0918C149C53
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 23:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719356914; cv=none; b=odhJRYqvrT7v/tC/jsHSDbzVdnfLZffQAJb35G9/AuWPI5nQFLvA1AFYUo/0pX4VehWfb5Ra3GHzAp+xHdQ2/LKIGbE1kpFqy16Zat1SJHsTGhtwylvgO1lZIqQbZ9HR85BfOTkrlcuwMebsQbkxeqVDVg+hmehijpPnyB0W3T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719356914; c=relaxed/simple;
	bh=y8RROw7hK4bFGNKaZjwYn3WbP4jQnIdKEQRsHJfh6EI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B9V9r++G3QPKpVAkxHsUJsGG3LChx6wu645BEsKCu1pLvr0M/PpaqWJpKugRM2cUrl5YLakMq2julknfbjJGNnHsaxVDWY3rclOqbs/fbRrk/jTpsXzgIGCSn7W3gjASBZQgUvdZhr5Ik1sMOftVSnnqaToGq15sucsZgkK83wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mHTdwn4a; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-444fe697f61so6102851cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 16:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1719356910; x=1719961710; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9u4uD/4mMNchcd2b711P+PDpdk0X0lw6OjibLkEzG1A=;
        b=mHTdwn4a5Hn6yp0y1jWRT1uk2uyP9DYgqnX+prpJ8leyRb0BBF2R6ahL+tvhtUK6vB
         /7dVELAy1rEwLvwpFJShgufbkxF0IjGhi7C0AVX1hFLLeV5OoMVUXwMndDRUPFHkRWDp
         eVJvZi/dw9AG3Ja38aPpoNFM8ZKvaW8X+Y9TA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719356910; x=1719961710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9u4uD/4mMNchcd2b711P+PDpdk0X0lw6OjibLkEzG1A=;
        b=QXD+scq9fbW0rxmns58ChdvOUVVM8KmiOU9qlcVFHeSdiLxANJam6qdgD1HKKTB87g
         3xZ/+p/l7JkyWt9KE6+NNmhpVhxdz6Xo8IrFr4dOAgFFGzN1ROXVNp+WQq1ztp7MdMx9
         FYy22560MEIDPuCUz8CsueTDe2GeGTkNkyPLSOpBewsP/rh+q7tUDjDrUGI3pzgp61nr
         JSdmvgIrHc7qDaHHh7BKVemlDiNTOwa1K1nnbL8PZpxr91RMb0Raw9682s0LNVqXnLz2
         IHqMOzaW1khVuJ2hVXBsLcDOQrb2cALE2iiBGV2FkrFEI1OCNCNQCLeijTTKIeGxPPMY
         ECVA==
X-Forwarded-Encrypted: i=1; AJvYcCUoLWaRYLF3OY4zo7N5MAsKEqs3QG9harL07cPp5K1OECVwQ6+w9F5u8nKxt1QbwsTKkOMGE4YkrvhR4+HSIk1AQt6QAqn4cFLd677w
X-Gm-Message-State: AOJu0YwZBP0qGWDPfAoACzS2iXWN2qCJhY0EBObatgNJTZQztcug6aah
	ZA1bmTclkWa0kFHOBl18Tz+O71kCd3YMAZUW+XcPn2DlVqrYrabEHSTuml+y13B0bhJ2s1Tv34Y
	=
X-Google-Smtp-Source: AGHT+IGX3wpy1pClfnWXyoWhqy40lLnVCevXI0MsxU3Q6fekpz0k+mUMcXVC+v5qqR/Ia7otIAZ2+g==
X-Received: by 2002:ac8:5a15:0:b0:43d:e4c8:8059 with SMTP id d75a77b69052e-444d92335aamr110105541cf.38.1719356909998;
        Tue, 25 Jun 2024 16:08:29 -0700 (PDT)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com. [209.85.160.176])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44504b1b0f7sm3103631cf.19.2024.06.25.16.08.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 16:08:29 -0700 (PDT)
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-444fdaed647so66881cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 16:08:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVFzV/Lz3Kkq2obe6r392CS/ysuXVSaNJhJyw8UJSWeGy5VYpT9ChlNx5aDqCV1ICdaSgIcgm1Dksc2bvvx0gBiEQzgZ4kzEqKFxTxt
X-Received: by 2002:ac8:5753:0:b0:443:4d56:5f40 with SMTP id
 d75a77b69052e-4453aac2407mr732101cf.9.1719356908641; Tue, 25 Jun 2024
 16:08:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231207170251.1.Id4817adef610302554b8aa42b090d57270dc119c@changeid>
 <CAD=FV=V_TGvRgZy9uFzF_tGX25oYzVrjHRrg-CphwmhmJRwsKg@mail.gmail.com> <20240624135452.GB8616@willie-the-truck>
In-Reply-To: <20240624135452.GB8616@willie-the-truck>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 25 Jun 2024 16:08:13 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xzynqn8H8G175OodJgiCoV4TjTQQQuzOcbSAzcLZcyhw@mail.gmail.com>
Message-ID: <CAD=FV=Xzynqn8H8G175OodJgiCoV4TjTQQQuzOcbSAzcLZcyhw@mail.gmail.com>
Subject: Re: [PATCH] arm64: smp: smp_send_stop() and crash_smp_send_stop()
 should try non-NMI first
To: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, 
	Marc Zyngier <maz@kernel.org>, Misono Tomohiro <misono.tomohiro@fujitsu.com>, 
	Chen-Yu Tsai <wens@csie.org>, Stephen Boyd <swboyd@chromium.org>, 
	Daniel Thompson <daniel.thompson@linaro.org>, Sumit Garg <sumit.garg@linaro.org>, 
	Frederic Weisbecker <frederic@kernel.org>, "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Kees Cook <keescook@chromium.org>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Tony Luck <tony.luck@intel.com>, Valentin Schneider <vschneid@redhat.com>, 
	linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 24, 2024 at 6:55=E2=80=AFAM Will Deacon <will@kernel.org> wrote=
:
>
> On Fri, May 17, 2024 at 01:01:58PM -0700, Doug Anderson wrote:
> > On Thu, Dec 7, 2023 at 5:03=E2=80=AFPM Douglas Anderson <dianders@chrom=
ium.org> wrote:
> > >         local_irq_disable();
> >
> > The above local_irq_disable() is not new for my patch but it seems
> > wonky for two reasons:
> >
> > 1. It feels like it should have been the first thing in the function.
> >
> > 2. It feels like it should be local_daif_mask() instead.
>
> Is that to ensure we don't take a pNMI? I think that makes sense, but
> let's please add a comment to say why local_irq_disable() is not
> sufficient.

Right, that was my thought. Mostly I realized it was right because the
normal (non-crash) stop case calls local_cpu_stop() which calls
local_daif_mask(). I was comparing the two and trying to figure out if
the difference was on purpose or an oversight. Looks like an oversight
to me.

Sure, I'll add a comment.


Ironically, looking at the code again I found _yet another_ corner
case I missed: panic_smp_self_stop(). If a CPU hits that case then we
could end up waiting for it when it's already stopped itself. I tried
to figure out how to solve that properly and it dawned on me that
maybe I should rethink part of my patch. Specifically, I had added a
new `stop_mask` in this patch because the panic case didn't update
`cpu_online_mask`. ...but that's easy enough to fix: just add a call
to `set_cpu_online(cpu, false)` in ipi_cpu_crash_stop(). ...so I'll do
that and avoid adding a new mask. If there's some reason why crash
stop shouldn't be marking a CPU offline then let me know and I'll go
back...

-Doug

