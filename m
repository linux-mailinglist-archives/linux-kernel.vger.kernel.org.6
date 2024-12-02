Return-Path: <linux-kernel+bounces-427777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 154A59E0593
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 15:53:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A59228AF6E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 14:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6CD820D516;
	Mon,  2 Dec 2024 14:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hx6/WCps"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF89820D50C
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 14:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733150739; cv=none; b=Hm6C+zyHJnTZqo1B0gffard4o9wZMK636OKXLV3Y6dPf89R0mey/cObbffhwFpQ/K6wnF17UU+S/ilWV32GRo2fk2y+Di7yehsgQ7LQ4TW2gYWIf1UvB5iENiKoifBx/DMgQ1IzMkKV6JaWav0ywmTTHHECmlBaBScmCP8zCKOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733150739; c=relaxed/simple;
	bh=n70OEj1mC+cdL0WdOAR5oKz8bYnGJfdRI3Edu7mnlh0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TSNq0Tg+6d/Uz3sYU3TR8xyO82HX/AV/IKlVR5JjSZUqCv8GmpLMN0fGxYRrcwqN7zU1PP3XCe8dDqqWiwpfff8NmaxuAEs8Lazrd9iJS7nrQk0EIbVje35qBLFVt5I+swqnYhFp7Xs1n7DaVZnLE+J4eFtiDH1u3nqYz8RzhS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hx6/WCps; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733150736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W10UJR/Z3Y1g/9yP+6tAwUQlbmi/1LL8javKNMvmKDs=;
	b=hx6/WCpswS6AzSijjuOcC1boRtYqwc1/sxS2mlQfcJX8vt/Us3t7ravaqtrW2BGfQO1OGZ
	8VaAxLxJXGKmX+mhabH1xSrWRqJSapag3apyNoNw2xrSWmdA0Cx1VDJvuodIqn2rfoR6YX
	2r/JjUUsWcxs0G1u98n928J9KuYWeSo=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-A7HYaWkhNq-wu4uRXbWVqA-1; Mon, 02 Dec 2024 09:45:35 -0500
X-MC-Unique: A7HYaWkhNq-wu4uRXbWVqA-1
X-Mimecast-MFC-AGG-ID: A7HYaWkhNq-wu4uRXbWVqA
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5d0d322ce63so1468300a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 06:45:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733150734; x=1733755534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W10UJR/Z3Y1g/9yP+6tAwUQlbmi/1LL8javKNMvmKDs=;
        b=Oon0gk0KQ9K3Fyc38XaPQ4GqHK/O79G86yXIEXLXrqYewRYwhhp8CRkOimz3iCDLpC
         n0GP+c+eABEbfnzvKxd83uldK1u0oif+kGIDwqYtzawEDowOvmpRwg4FSGiBN5bH/siJ
         2Mavbv+wsk0/Hc8yKsrl7savlnafGmvG/SuIeuq2INZat1DGCCpkDib9FGdkPME5QpoG
         YQhJGryLM+Q+rBLkpITDa3lDz4E/yWoM5cAO3Vz8o+k9O7sKIPyrLUJYNpwkwMX7Ixd7
         TxPA6fWoBUAR4VMDf5KZrTedD8yJMUV3oXNPToyHU+Tb0FGj9MHMIUPGtHGWYdamovXt
         jtNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVN0Z1ZfOQfSDlyMq6WujV/K2vcsCbmQeX6CFOihJb8lqhZvR/oW4YpYq8uZqFYBdN7SR1K+WoM5g3yBI0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrEzdKpVnF/kF6Fe1r3kbWkOxHapRp56ruMjikQZbFey/MdJ0e
	72bXYTqNXpIxnDb1+M0z0ms9rQy9wq+SsTw15pRL+s1L0h69W9I+s9vz9zkgnnuCQHF0GZ38fsM
	w0u8ehaF9xgzqoKVJ8bxZUTRl09Xx5fZOsSyxwiNsKzGURV9852d3nYJwSx6CGlk1udMhrIz/ih
	Yw/JyS1R1nh9SjQGMil9PrDVz9KK+SngjiI0M2wXNQK5qoWrk=
X-Gm-Gg: ASbGncurn82PoQbw7F3FIYTcdqaeQiY04Q4QfnYKNgxgUg5CuGCAZrP0hjK5n5o/mt1
	MM1DrwbgjY8lU162GNRjdpLeM++idT12YKV2j1NQK9QUHMlavEXiqNPg8Udi9hO4=
X-Received: by 2002:a17:906:9c2:b0:aa5:225f:1902 with SMTP id a640c23a62f3a-aa580ee048cmr1817439166b.8.1733150733917;
        Mon, 02 Dec 2024 06:45:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFcA/wDe0r3wh7CcYqSoBDkWCwoa5A7JE11X7DdWa0YQ127gdehXm4o9jBtj0pJi92GpZIL1+glwSsQzVTNRV8=
X-Received: by 2002:a17:906:9c2:b0:aa5:225f:1902 with SMTP id
 a640c23a62f3a-aa580ee048cmr1817436966b.8.1733150733572; Mon, 02 Dec 2024
 06:45:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021-add-m68k-tracing-support-v1-0-0883d704525b@yoseli.org>
 <3a8f6faa-62c6-4d32-b544-3fb7c00730d7@yoseli.org> <20241115102554.29232d34@gandalf.local.home>
 <cbb67ee2-8b37-4a4d-b542-f89ddae90e94@yoseli.org> <20241115145502.631c9a2c@gandalf.local.home>
 <2c43288a-517d-4220-ad31-f84dda8c1805@yoseli.org> <CAP4=nvTjdZRfWtpvM+gThPv6SghW96i9YykA88vAFH5x39GZqw@mail.gmail.com>
 <c2d5cfd5-8bdb-4060-a974-18f9c2b9a2d0@yoseli.org>
In-Reply-To: <c2d5cfd5-8bdb-4060-a974-18f9c2b9a2d0@yoseli.org>
From: Tomas Glozar <tglozar@redhat.com>
Date: Mon, 2 Dec 2024 15:45:21 +0100
Message-ID: <CAP4=nvQe0KGxUAQSers9GbvZS0sVptbFzXufgGhuxAzVOyicHA@mail.gmail.com>
Subject: Re: [PATCH RFC 0/2] Add basic tracing support for m68k
To: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-m68k@lists.linux-m68k.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Greg Ungerer <gerg@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jean-Michel,

po 2. 12. 2024 v 13:53 odes=C3=ADlatel Jean-Michel Hautbois
<jeanmichel.hautbois@yoseli.org> napsal:
>
> Thanks, I will cook a patch !
>

Thanks!

> > As of the FOPTS changes: are those necessary for rtla to build, or
> > were you just using them for easier debugging? AFAIK rtla shouldn't
> > depend on unwind tables or stack protection for functionality.
>
> Well, my toolchain does not support it, so it fails at link time:
>    LINK    /home/yocto/Projects/wabtec/linux/tools/tracing/rtla/rtla
> /opt/m68k-buildroot-linux-uclibc_sdk-buildroot/bin/../lib/gcc/m68k-buildr=
oot-linux-uclibc/13.3.0/../../../../m68k-buildroot-linux-uclibc/bin/ld:
> /tmp/ccih6k6Z.ltrans0.ltrans.o: in function `err_msg':
> /home/yocto/Projects/wabtec/linux/tools/tracing/rtla/src/utils.c:30:(.tex=
t+0x1a0):
> undefined reference to `__stack_chk_guard'
> /opt/m68k-buildroot-linux-uclibc_sdk-buildroot/bin/../lib/gcc/m68k-buildr=
oot-linux-uclibc/13.3.0/../../../../m68k-buildroot-linux-uclibc/bin/ld:
> /home/yocto/Projects/wabtec/linux/tools/tracing/rtla/src/utils.c:39:(.tex=
t+0x1e0):
> undefined reference to `__stack_chk_guard'
>   <snip>
>
> That's why I removed this option.
>

Sorry, I misread the diff. I thought you were adding options, but you
are just removing  -fstack-protector-strong, right? I believe rtla
should check for the feature first before adding
-fstack-protector-strong, like perf does in
tools/perf/Makefile.config:

ifeq ($(feature-stackprotector-all), 1)
 CORE_CFLAGS +=3D -fstack-protector-all
endif

The feature-stackprotector-all does a test build, if you have a
toolchain where building with -fstack-protector-all is broken for any
reason, it will return 0. You can try doing something similar for
rtla.

Tomas


> >>
> >> But it is not enough, as executing rtla fails with a segfault.
> >> I can dump a core, but I could not manage to build gdb for my board so=
 I
> >> can't debug it (I don't know how to debug a coredump without gdb !).
> >>
> >> JM
> >>
> >
> > I have seen a similar libtraceevent-related rtla segfault recently on
> > ARM64, which was fixed by updating libtraceevent to a version that
> > includes the fix. Such issues are caused by the files for kernel
> > tracepoint tracefs having different contents on different
> > architectures, exposing bugs. I see Steven has already fixed one of
> > the issues on m68k [2].
>
> I will try to use the very last versions of both libtracefs and
> libtracevent and see if it is still happening !
>
> Thanks !
> JM
>


