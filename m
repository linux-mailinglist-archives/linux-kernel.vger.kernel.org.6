Return-Path: <linux-kernel+bounces-268572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA9F942662
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 08:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4733F281B5A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 06:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F9C1667CD;
	Wed, 31 Jul 2024 06:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="HdH3BuTa"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C169683CA1
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 06:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722406688; cv=none; b=Dm99MTQYsR5MkjlQxQA94k3bB3tW0uHaeT+bAO/6IXuDTFfUkdDxL/iBOSph5cR7gBjaLm/Fw1nf/iSlBVHfQc6DfdLNKB/86ZY2RUvcphlVpjDdrJ88YC3SkVdi/yr6/IueDc7i3EYnBZSWn28DdfKaHYoQvnEu+JRe8cAVThI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722406688; c=relaxed/simple;
	bh=3TD+IGRLb5fmL9uN/xIlWcShtt4fFIxTIOP6c4SxY6I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZlNX4fvjIYHftpTkuGLC6GFKxIGjIgv27GHvvUipbyqkoARtsNk//mKlQLGqSnRAhCGwL45GdatGAh3hw0I58rrxRoyCH8zQpgzXXzo7pyTV2dyThkOHoUrZG7p8oP1lFMu5KyZdz+xmQg78UhKzTZHfSD4kPGdhq7svrAzqwVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=HdH3BuTa; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 549F33F6AF
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 06:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1722406678;
	bh=ssw5x/CYADqMGy84FcI3TzdNl42qVwl89rpsqSqpOiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=HdH3BuTaVjrPCIgtS1PV+4gTIg91Ug4fPtE4dV1GtxpAaobDDUGRYywUEkskjyVpY
	 yafhtp9tSNJKRzxikcK4VYIkBIggjNJC7qHAvpas57I7H8BWr9Ors0BURYKzL09r2C
	 dr2YWyMz4dRaDG1JYBwljWuMfpKKnvjpir6XH9Z5dPix8xYsaE8+h5vSbYg3VCWrN4
	 lBHDGXg+ShJWY+s9WJRqIPwlyfEML3QAyFjppf/UpPbTaAKz8w8IGrhtlQTNDkMt6F
	 wutaC4ap+KBrCeta/Y/yWZn0K1MfHAZEZm017XlBLXsxFi1kYUDZ3uoCu9jUToooIq
	 z4mwotMMeeIWg==
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2cb4bcdd996so674285a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 23:17:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722406676; x=1723011476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ssw5x/CYADqMGy84FcI3TzdNl42qVwl89rpsqSqpOiY=;
        b=Z3FtHjDfIXTJyenjdq13OH2tjj3gEYnN/K5H+Mhso77xDGTkfA1MesbviFfMCPSHsO
         Z/JLCTUJsvf7qeFCfhNYb7iU49KhtgEN+vQGQ+PRN5kUbq9vdKso/24PFGJb9j10REBa
         Km64eRjAvbMQFFU2jfKRKFJkzt7h3KhkeIyWSL/gtImG5cmK5/Sc0zZ4F7gD2NkRtfyb
         KkxNjMJ1y1eTtcu2wCODxEEuGLnmOVVlRveGdIGGyhX/qpaHuq5hPndHpTgVjtl0PnU0
         YL3C4qQhjImsfmWs9yNdCmdcWX6RNNpV6vihWycJ+383/pMWmNu9tHeYWusl0B/nJpr/
         NhAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLH3+gLHgbQzvbQPKcUvQx3JNrSl/1tSGIL07F6DjdILvXMSwWt4MdKT7cuP6utgbjCHiaovm6+hrmZcIZ/VlwJnpm44sjgF1R0wqN
X-Gm-Message-State: AOJu0YwjTY5hCjF1jl7dzB3+2AsIbgEXqDZ0RwbnnUYm3EUw8qPXUT64
	MV6sQXiTC+ruJeZMnGhpycAVRvUkMxCOe9aViAJqAmH7qn6yN6n8z8ErSbxsukvR+zP9wxaLzLZ
	8CfMlEmcT3uEccxirKjzXuDHoNQADNAkymMFlXajEMk1bycA6Unvzf7Wxb5zN26766QhMcVtOJ0
	hg0ZQK11/pcQIdHGym7eI6V25cgjOpKf5Nd7L8HxittRgRou6HFr10Hh7Q1xHTyig=
X-Received: by 2002:a17:90b:3907:b0:2cb:50b8:e59d with SMTP id 98e67ed59e1d1-2cfcab119b5mr7125413a91.12.1722406676587;
        Tue, 30 Jul 2024 23:17:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHiNHt0e8r+J16WpmTX658h3SHjZ4qclCo5nuyNo1MeoazeMAVzJCq/CVbDiXLbAfOteubHgc26cPv1m8AaaM=
X-Received: by 2002:a17:90b:3907:b0:2cb:50b8:e59d with SMTP id
 98e67ed59e1d1-2cfcab119b5mr7125392a91.12.1722406676190; Tue, 30 Jul 2024
 23:17:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726062601.674078-1-kai.heng.feng@canonical.com>
 <2048df524f8be7ed200bc92eb1c6efe106f0ed19.camel@intel.com>
 <CAAd53p5ftAjtfb-uCcVKR8G0JfoGnA_a0Se1E_vPeietgOENOg@mail.gmail.com> <CAJZ5v0i9Qt3OFKCbqkd-q4VKYreV2PZZpQ2Km9az2htANG5zxA@mail.gmail.com>
In-Reply-To: <CAJZ5v0i9Qt3OFKCbqkd-q4VKYreV2PZZpQ2Km9az2htANG5zxA@mail.gmail.com>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Wed, 31 Jul 2024 14:17:44 +0800
Message-ID: <CAAd53p4macNjQN3i8vaf1s-5vj_7esKw37nqoUN1h+XqjQk71w@mail.gmail.com>
Subject: Re: [PATCH] intel_idle: Add Jasper Lake and Elkhart Lake support
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, 
	"jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>, "lenb@kernel.org" <lenb@kernel.org>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
	"artem.bityutskiy@linux.intel.com" <artem.bityutskiy@linux.intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 9:59=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Mon, Jul 29, 2024 at 6:08=E2=80=AFAM Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
> >
> > [+Cc Rafael, Srinivas]
> >
> > On Fri, Jul 26, 2024 at 2:52=E2=80=AFPM Zhang, Rui <rui.zhang@intel.com=
> wrote:
> > >
> > > On Fri, 2024-07-26 at 14:26 +0800, Kai-Heng Feng wrote:
> > > > Without proper C-state support, the CPU can take long time to exit =
to
> > > > C0
> > > > to handle IRQ and perform DMA.
> > >
> > > Can you provide more details?
> > >
> > > Say, what cstate is entered w/ and w/o this patch?
> >
> > Without the patch it's ACPI C1, C2 and C3.
>
> They are called like this because they come from ACPI _CST.  You need
> to use turbostat (or equivalent) to check what C-states really are
> entered.

Both C1, C2 and C3 have some residencies.

>
> >
> > >
> > > can you show the output of "grep .
> > > /sys/devices/system/cpu/cpu0/cpuidle/state*/*" without this patch?
> >
> > /sys/devices/system/cpu/cpu0/cpuidle$ grep . */*
> > state0/above:0
> > state0/below:631
> > state0/default_status:enabled
> > state0/desc:CPUIDLE CORE POLL IDLE
> > state0/disable:0
> > state0/latency:0
> > state0/name:POLL
> > state0/power:4294967295
> > state0/rejected:0
> > state0/residency:0
> > state0/time:19513
> > state0/usage:635
> > state1/above:26
> > state1/below:12437
> > state1/default_status:enabled
> > state1/desc:ACPI FFH MWAIT 0x0
>
> This is C1 AFAICS.
>
> > state1/disable:0
> > state1/latency:1
> > state1/name:C1_ACPI
> > state1/power:0
> > state1/rejected:0
> > state1/residency:1
> > grep: state1/s2idle: Is a directory
> > state1/time:18621370
> > state1/usage:74523
> > state2/above:1690
> > state2/below:17
> > state2/default_status:enabled
> > state2/desc:ACPI FFH MWAIT 0x31
>
> This looks like something that used to be called "C7s".
>
> > state2/disable:0
> > state2/latency:253
> > state2/name:C2_ACPI
> > state2/power:0
> > state2/rejected:0
> > state2/residency:759
> > grep: state2/s2idle: Is a directory
> > state2/time:7063052
> > state2/usage:7909
> > state3/above:13111
> > state3/below:0
> > state3/default_status:enabled
> > state3/desc:ACPI FFH MWAIT 0x60
>
> And this looks like C10.
>
> > state3/disable:0
> > state3/latency:1048
> > state3/name:C3_ACPI
> > state3/power:0
> > state3/rejected:0
> > state3/residency:3144
> > grep: state3/s2idle: Is a directory
> > state3/time:4451519230
> > state3/usage:55467
> >
> >
> > >
> > > >
> > > > The data collect via wult shows the latency is similar to Broxton, =
so
> > > > use the existing table to support C-state on JSL and EHL.
> > >
> > > so you have done cstate measurement on the EHL using wult?
> > > can you share more details about the measurement results?
> >
> > I look at the "spikes" of the aggregated graph. Not sure if it's the
> > right way to interpret the graph though.
> >
> > It will be much better if Intel can add the proper C-states table for
> > JSL and EHL.
>
> So what's missing in the above, from the technical standpoint?

The crucial part to make the issue (i.e. slow ethernet) is
".disable_promotion_to_c1e =3D true".

Can we use that for EHL and JSL?

Kai-Heng

