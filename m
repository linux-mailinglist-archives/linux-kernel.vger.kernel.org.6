Return-Path: <linux-kernel+bounces-169729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 275418BCCBD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 13:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2611BB2217F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 11:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69877142E8F;
	Mon,  6 May 2024 11:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i4War9FW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC8514262C
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 11:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714994507; cv=none; b=o8AwV/z7FeZwVuVx7hiL9B/fnYXEFOGFmfyRAXbUIPFEnt56SaRebX7cTTvBlSQ17nsN6onbeIhKvzg49EdYSD2l+YRbGcfmAB2tmbBr5RzHI3OZ+vMBnETbWczpEHoW2j7CdiVrd2UsrJx4mtLylovMXphDVUdQMPsJnuxCumQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714994507; c=relaxed/simple;
	bh=zrGpFO2KzYviJ12Uk4Knk0nbSHFeCLommmFFiBekSWk=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sKAJ18zzpjzepTlunvCmpzPjhZXDnzbUItJslhpfVN3sYdaEUDLEc52PgFzZ/KUp5QswHuDRzOBTb1d74bMO+bA1KtEl2/Mt+9BlRr0TlXAb2+mo14yyaATgeD3uTQpTkJth8yNVl7C3fWasBW2OfNJaxnYuIS8OTviFvo+m13A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i4War9FW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714994505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lfElTg3P9yi4mhZjKlr5avBuN2og+ERzX6xGJyg7hQg=;
	b=i4War9FW54mBIDAle4hO45El4RmhB8PT20ToNVHIwgTgE1qj0DSAV/XFgy+/jkvCig0Lpg
	56A63dRLlly3Sxh4CR7aVwCfideGg/6cQQ+WmirwF5kS8HorvYnN9zHoDJ9+IDFevJkuWh
	JQByVpWGCzLQqtxrTGTIunDj2gyzodU=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-p-r7mwKJON6y6nGCtHmUdg-1; Mon, 06 May 2024 07:21:43 -0400
X-MC-Unique: p-r7mwKJON6y6nGCtHmUdg-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-6ee089eedb7so2327557b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 04:21:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714994503; x=1715599303;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lfElTg3P9yi4mhZjKlr5avBuN2og+ERzX6xGJyg7hQg=;
        b=gfjyKaezmzqR4wSrTRiTLUwhvblwRV/v5eT/erHDlu6tM0Yz24zf4UzBcen5KQpIxi
         x2cx73A8fHqDV5lb6Lixn3UQNqheVXwZnZNV5JgJTbGXqyLnq2s+h+XydAaK2ZqjcTPQ
         rflgoDMgD3cQZzBg2ecRYtd6KQoc8F5mBe5+2dxgfIC0msuzcIHcCXlWC2UjBrQG0P4N
         AWiDrULJI5vuDzHiZUy2JWGR1XnZcWsMRI4aWGxEraNLuZu/O1xKvxqokF90J1XuGEX7
         BQGfConPcHhCyRYs2rzde/Sw5xaz16mTjewWvmjeIMInIWljeKBqTV81qIMBtWiUeSso
         d9VQ==
X-Forwarded-Encrypted: i=1; AJvYcCXl9pphQERIYqNLNpbkAvVIiHYd5xGfcV1qhvf2l8vP/elAHt/odO7KbyhpfltwrKAGoihbgvYAO9GzQYjgPP9KIjBhe3QX0JDX6KWk
X-Gm-Message-State: AOJu0Yyw2dbXhDn7JvC3BLAboHhlNomuQYROQtt0FPcRXacVkfXqg3b5
	0I9kgF5R5u441mZjx0tYVE6g6c3Aw7bVYpSjM7tE+rEYDv8kPXokPjxa3mYZtEmVJg2o7ngn3G1
	+4MPnMVgILLIB85M7NPQ3RFhQv26ks4yzLlC6q2dpnvOez1c08MbdP88a4qcHu7M3G0rtCgnQIN
	2cSzAJrQO+XRqu6j2Q9BewkT8lXIPxFTMv2jvP
X-Received: by 2002:a05:6a20:da8b:b0:1a7:2ceb:e874 with SMTP id iy11-20020a056a20da8b00b001a72cebe874mr12710502pzb.37.1714994502769;
        Mon, 06 May 2024 04:21:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhyhi7dIVf2+C7OigQZMKNCF9fVW9NM5SSt+qz9BQl1HVEbaT1IXprTHrmUqzyshtiWvHl0EwlK+4i/EV8NvU=
X-Received: by 2002:a05:6a20:da8b:b0:1a7:2ceb:e874 with SMTP id
 iy11-20020a056a20da8b00b001a72cebe874mr12710445pzb.37.1714994502125; Mon, 06
 May 2024 04:21:42 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 6 May 2024 13:21:41 +0200
From: Sergio Lopez Pascual <slp@redhat.com>
In-Reply-To: <CAOgh=Fykg3Xb8Y59R_tJ7_jXe-ozXRMQjU+qVy5DdmFn3pkcPw@mail.gmail.com>
References: <20240411-tso-v1-0-754f11abfbff@marcan.st> <20240411132853.GA26481@willie-the-truck>
 <28ab55b3-e699-4487-b332-f1f20a6b22a1@marcan.st> <20240419165809.GA4020@willie-the-truck>
 <CAOgh=Fykg3Xb8Y59R_tJ7_jXe-ozXRMQjU+qVy5DdmFn3pkcPw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 6 May 2024 13:21:40 +0200
Message-ID: <CAAiTLFW8DWH-ejNgcXgr2tQxxF4pp7BNUFGyUq99BfrYx1kScQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] arm64: Support the TSO memory model
To: Eric Curtin <ecurtin@redhat.com>, Will Deacon <will@kernel.org>
Cc: Hector Martin <marcan@marcan.st>, Catalin Marinas <catalin.marinas@arm.com>, 
	Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Zayd Qumsieh <zayd_qumsieh@apple.com>, Justin Lu <ih_justin@apple.com>, 
	Ryan Houdek <Houdek.Ryan@fex-emu.org>, Mark Brown <broonie@kernel.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Mateusz Guzik <mjguzik@gmail.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Miguel Luis <miguel.luis@oracle.com>, Joey Gouly <joey.gouly@arm.com>, 
	Christoph Paasch <cpaasch@apple.com>, Kees Cook <keescook@chromium.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Baoquan He <bhe@redhat.com>, 
	Joel Granados <j.granados@samsung.com>, Dawei Li <dawei.li@shingroup.cn>, 
	Andrew Morton <akpm@linux-foundation.org>, Florent Revest <revest@chromium.org>, 
	David Hildenbrand <david@redhat.com>, Stefan Roesch <shr@devkernel.io>, Andy Chiu <andy.chiu@sifive.com>, 
	Josh Triplett <josh@joshtriplett.org>, Oleg Nesterov <oleg@redhat.com>, Helge Deller <deller@gmx.de>, 
	Zev Weiss <zev@bewilderbeest.net>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Miguel Ojeda <ojeda@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Asahi Linux <asahi@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

Eric Curtin <ecurtin@redhat.com> writes:

> On Fri, 19 Apr 2024 at 18:08, Will Deacon <will@kernel.org> wrote:
>>
>> On Thu, Apr 11, 2024 at 11:19:13PM +0900, Hector Martin wrote:
>> > On 2024/04/11 22:28, Will Deacon wrote:
>> > >   * Some binaries in a distribution exhibit instability which goes away
>> > >     in TSO mode, so a taskset-like program is used to run them with TSO
>> > >     enabled.
>> >
>> > Since the flag is cleared on execve, this third one isn't generally
>> > possible as far as I know.
>>
>> Ah ok, I'd missed that. Thanks.
>>
>> > > In all these cases, we end up with native arm64 applications that will
>> > > either fail to load or will crash in subtle ways on CPUs without the TSO
>> > > feature. Assuming that the application cannot be fixed, a better
>> > > approach would be to recompile using stronger instructions (e.g.
>> > > LDAR/STLR) so that at least the resulting binary is portable. Now, it's
>> > > true that some existing CPUs are TSO by design (this is a perfectly
>> > > valid implementation of the arm64 memory model), but I think there's a
>> > > big difference between quietly providing more ordering guarantees than
>> > > software may be relying on and providing a mechanism to discover,
>> > > request and ultimately rely upon the stronger behaviour.
>> >
>> > The problem is "just" using stronger instructions is much more
>> > expensive, as emulators have demonstrated. If TSO didn't serve a
>> > practical purpose I wouldn't be submitting this, but it does. This is
>> > basically non-negotiable for x86 emulation; if this is rejected
>> > upstream, it will forever live as a downstream patch used by the entire
>> > gaming-on-Mac-Linux ecosystem (and this is an ecosystem we are very
>> > explicitly targeting, given our efforts with microVMs for 4K page size
>> > support and the upcoming Vulkan drivers).

In addition to the use case Hector exposed here, there's another,
potentially larger one, which is running x86_64 containers on aarch64
systems, using a combination of both Virtualization and emulation.

In this scenario, both not being able to use TSO for emulation
and having to enable it all the time for the whole VM have a very large
impact on performance (~25% on some workloads).

I understand the concern about the risk of userspace fragmentation, but
I was wondering if we could minimize it to an acceptable level by
narrowing down the context. For instance, since both use cases we're
bringing to the table imply the use of Virtualization, we should be able
to restrict PR_SET_MEM_MODEL to only be accepted when running on EL1
(and not in nVHE nor pKVM), returning EINVAL otherwise. This would
heavily discourage users from relying on this feature for native
applications that can run on arbitrary contexts, hence drastically
reducing the fragmentation risk.

We would still need a way to ensure the trap gets to the VMM and for
the VMM to operate on the impdef ACTLR_EL12, but that should be dealt on
a different series.

Thanks,
Sergio.


