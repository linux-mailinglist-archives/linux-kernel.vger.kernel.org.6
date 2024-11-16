Return-Path: <linux-kernel+bounces-411898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 922A59D00E0
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 22:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E6E5B250CD
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 21:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4241990A2;
	Sat, 16 Nov 2024 21:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rwk7rjdf"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1F5F9D6
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 21:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731791235; cv=none; b=oHzeiZReafabqNYozRXr1yt26iCUukuA+3ean8L3BExSh5Yv0X0ZZjSLt0LjC9PCR+6bzELs/M9Mry6pnFZXORMiR9g6XAxNeLcBJZRpiVzApzsd4LpzbPIr6iLL/HExbhBi7jjBr/HkKKDlhamTqDSoC9YoYezRVXWL38s0EA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731791235; c=relaxed/simple;
	bh=wqpBju2iQvdpkaXSz/WHEClr7FInLdLGK3LXpaMShVM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m7OOaXYK5skZVlokNbj+ATyinX4W6RLHqGSr/2Y1IKacMpVOh3mnzNAMBG9PxMF3/fSR9tYG9/S1y3BQT8GGAQyrCu5jPu6kCYkoUSdZlt0BV6Re/6SAwhYJfhm4cr6jEF5Jb0y/dcgS4VSdRXXIXxYZMnW30+xg/8facp2jeyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rwk7rjdf; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7245a9d0e92so1809359b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 13:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731791234; x=1732396034; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wqpBju2iQvdpkaXSz/WHEClr7FInLdLGK3LXpaMShVM=;
        b=rwk7rjdfg+UtK/a/ImbNZ8JXUq1XYgsv1sTBJszEg0EJHlnlTI8T8dejlDOlVY4sbY
         aSAV0Msj+DVxUHiUzQ9Q3gT8j8yCO4lK5I+q2GUBGFT8++L5bDgpdf12fLnJbgz7Vd6/
         T5ABMFBwECjBtl56ffrMnm/E8dhEk57i/iFmyr/qwrMOLenYp03yh4Q+upKFq9cSkE/J
         OqfU/bdOiCnUwpYlF5wlgvM7gWO5IAhRReMNChFiJInXvb7Dfu/V1LDUn6xFKkby7Any
         HbIAvL9CCDKlaZvSa+WkqXh2ZK1gCo6QocW3AbAkdA/IDO/QeWwlhs2r+CG6HSdMuxEP
         yvVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731791234; x=1732396034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wqpBju2iQvdpkaXSz/WHEClr7FInLdLGK3LXpaMShVM=;
        b=dDXWiojzIH21Bu9gWk7m21Frr4BiA8H2XffmZYQ901m3cpQVbA/6Lv0v77+cTqnrm5
         p6zNSHW3KwH9R9L1KOetzg/NxSt0HJvMJuFe8XykXWkxXmgnHSzl0zCTv4JBKVcbANE2
         2m4ti7NriQ2rNDPZJ4WbX1L2x+94YXTb1NruqrpPZXJwHifXCcwWeDe3D/otesHWCuWS
         SiKTjFaHQzh40Puvfsp8akNVH2I5iQjtVX10nVTuEbYdsF9iUnufti3UihC/rofGULcf
         SXn6Sncmgd1Xeb/xKftdcoRN9AKGQXBVKmgiCT00gywfOdogvPv0DtZsTUTv714txPkx
         eolw==
X-Forwarded-Encrypted: i=1; AJvYcCUwCKRXF3NnOoGiqMOReq/uwU+o8FKidgu8MgDIWfVWA5/QfaNlTKG8xBWnYNgaHaA+uGI/wt3375q5wm4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU6fha24eWRO64jIBJIR2gkUSdjP0tXvnlZRDVKoLuzwFw1mWn
	SCNQJ0Aq4ebyQsR3+HkvvnxKQ5y7bj3oC20bAubP4Wgl1iMWIhvd5e4gDacB7CbfkXRBgvIbIIh
	8Y8WJfp3CGUaD4h4WuScNdlkA1K6bfxuWyv97
X-Google-Smtp-Source: AGHT+IGvCeKtnZ1h3atqVG9XoO7JlLn/f8YQvwAVTd4IG9CzW/z20P072kn2t4NdRfdPdSWzeZ9Kgu9wcExWmWgdIJ8=
X-Received: by 2002:a17:90b:1812:b0:2ea:2906:a700 with SMTP id
 98e67ed59e1d1-2ea2906aa50mr6456929a91.25.1731791233460; Sat, 16 Nov 2024
 13:07:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114220921.2529905-1-saravanak@google.com>
 <20241114220921.2529905-2-saravanak@google.com> <2024111648-drilling-jubilant-1285@gregkh>
In-Reply-To: <2024111648-drilling-jubilant-1285@gregkh>
From: Saravana Kannan <saravanak@google.com>
Date: Sat, 16 Nov 2024 13:06:36 -0800
Message-ID: <CAGETcx-+ThXuG_JsFRj+mOL8RY-eECb5_NvUPAQQxpWnZJiDKw@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] PM: sleep: Fix runtime PM issue in dpm_resume()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Marek Vasut <marex@denx.de>, 
	Bird@google.com, Tim <Tim.Bird@sony.com>, kernel-team@android.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2024 at 11:43=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Nov 14, 2024 at 02:09:15PM -0800, Saravana Kannan wrote:
> > Some devices might have their is_suspended flag set to false. In these
> > cases, dpm_resume() should skip doing anything for those devices.
> > However, runtime PM enable and a few others steps are done before
> > checking for this flag. Fix it so that we do things in the right order.
> >
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
>
> This looks like a nice generic fix as well, should it go to older
> kernels?

Yeah, it's meant to be a generic fix. But I'll feel better about it if
someone familiar with this code can give it a Reviewed-by.

And as I look at it... I have a bug in there. I think it should be
goto Complete and not Unlock! No idea how my devices didn't get freed
after a few suspend aborts!

I can send it out as a separate patch too if you want. And depending
on when it lands, I can keep it or drop it from v2 of this series.

Thanks,
Saravana

