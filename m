Return-Path: <linux-kernel+bounces-438443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 763EB9EA15F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 22:48:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73A51165C36
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 21:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988F91991BB;
	Mon,  9 Dec 2024 21:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wSa/ZMX8"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95734137776
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 21:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733780887; cv=none; b=jMlUCWXBM511pPoItd0H6Ws+2MbaCbxlEhrge/UUL9ogWiy4cZXydtZItgqYEFvZ67U5CulIhx4xA/j/zZCpGAf9mmPROlzNnROK2Et4Y7YTa5cHvDc9BtmYk5Y7ENRbwwmXNCl9XhkT9xFXgHczaLT4yau4/WY5jKezE3NI2E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733780887; c=relaxed/simple;
	bh=fFFrX5olpNfXFoi8G4qimfcekwx7PEoK5pt1FjmAxVU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jyu3+l/6ui88jb5gOOr54TLKQBzZuEx6TZB8VwPTcpmjUZn9TrXjEJF0iFIkuTUqrqF+e8s5k+PYiDAO19nzuLagK3olPdQ8XlueV9Tyiit+ohX8lJLu30cINKyKB6aRCIZd16S4rooC/78/yL6UrdhuUgViZD+6auic8NVrnxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wSa/ZMX8; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3a815a5fb60so17575ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 13:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733780885; x=1734385685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tTbUKnk+1NZrrdOmVyN2UStAy2eKJFeXjEP+ETk++lI=;
        b=wSa/ZMX81DwmTf72Zf9EKhPcvzvXGIOJTThDvif80I71N5p5OSJWmWjd/TLWuSrDPs
         zjVs6zn14kGG+AjIns0N9GaPfTZcsY/HxXr3h4LoefqeLXRR8RfTyUravEq9t5yE4E09
         ep7UiSbffxz9pasFOxa9YsnUkzM7i5uLzEg6QOGLCZYdC7sN/cVxHN/ao/bSZfVpsN6C
         WfAf9cTSz2DfzMXTe0IgblSv11VeJMIR7UCV6YVBDmY2pUkSODqpfBfsELv1UaXEKHMf
         CfWNx3LL61Dl0THfK8Veoe1w+qX9oYU5/ugVKT/nGBWAA+5G5jHwwMCR1m7E+IAqHWzC
         QLlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733780885; x=1734385685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tTbUKnk+1NZrrdOmVyN2UStAy2eKJFeXjEP+ETk++lI=;
        b=dyOj/AFYwV1dJRm1Esn5j1V2VBu5rTzMyMvKL7nT7h5UEWD8P2OICCuM8NFb13XNPR
         Oeqztu8MVYbP90O9+BPKECOhUHEFRCZQi6KFvfR8RDEHkUCff51Tr5m1qYkdMVtVnyf0
         CcEqvNIbmojrMkGdWD85qkoseTaFVAQGMS5ELLqXZv7jjn0gDuvz2TSmzk1IV14PHTLo
         bPrqZf2MGfv+r03XXVX9jyMESf9PoE/N8S0ZOOlzptvQfZqePQR6IefP5aAaJ5Nhj6vD
         jGC0LcnnvroM40VKDaj+DJtrVHf/0QV7QH5JrHI965dmn68YS0+FiwwM+7LHzmVHYPUP
         Kjgg==
X-Forwarded-Encrypted: i=1; AJvYcCXnj6gkX05F+MK35k8ZTAEbSj97GE6ayvxyLE+Zd2305zj/JSIq5/VhdQVFLgpnCDr8muIRUlLmaQ4dQsA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB4Ip5FIEwCteoPv/nWv9CtdEAOC9+73TwfltoGxsFoyxGEYkl
	fY4Reg9/EKj5cmsmgZ0NNy2+CaCK0azXtW+Lbe6jo76HpG8dNgQ0eL8JrmwW92KuovbMjvkEb86
	cNumgUMnZBDu9YwCmRoQdKVqwzmrIKpH4WF8d
X-Gm-Gg: ASbGncuHx4i0+TaIsg2RM/c320s0R97wMWLhIu/seUyeZ2u3iAYa9BEoAW1xMeBmXCd
	GsqWCmJ2pvTSiJCPzkfqtOuBnYSvVMNJubFRD
X-Google-Smtp-Source: AGHT+IGU3AFKv8GXmsLqxrkJ7QgMr0vfqYFIq0+QHALD9ho2Dt4mgPHC4wdrEbokzuNnZ6ohQLXqyqdLuveOZYXwhIk=
X-Received: by 2002:a05:6e02:741:b0:3a7:df79:71b3 with SMTP id
 e9e14a558f8ab-3a9df531a41mr93845ab.19.1733780884670; Mon, 09 Dec 2024
 13:48:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206044035.1062032-1-irogers@google.com> <20241206044035.1062032-2-irogers@google.com>
 <20241206102451.GA3418674@e132581.arm.com> <CAP-5=fVDH6k7rW3_LXK5Y9Givs3WO5MQ8XMKsuUXXY5nQ66qDg@mail.gmail.com>
 <20241206230321.GA5430@e132581.arm.com> <CAP-5=fXOE3k9bmYOykpN6M9bBwLqP54MWWMGxutJ4SS2G_3MZQ@mail.gmail.com>
 <74f3444d28044d858f0f696cea6485a8@AcuMS.aculab.com>
In-Reply-To: <74f3444d28044d858f0f696cea6485a8@AcuMS.aculab.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 9 Dec 2024 13:47:53 -0800
Message-ID: <CAP-5=fVQNDtKUWVgWPJ8i0+8G7+CZg-FEPWTsW6kcvSdLg2v3w@mail.gmail.com>
Subject: Re: [PATCH v1 1/8] perf: Increase MAX_NR_CPUS to 4096
To: David Laight <David.Laight@aculab.com>
Cc: Leo Yan <leo.yan@arm.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Kyle Meyer <kyle.meyer@hpe.com>, 
	Ben Gainey <ben.gainey@arm.com>, 
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 1:36=E2=80=AFPM David Laight <David.Laight@aculab.co=
m> wrote:
>
> ..
> > > > Just changing the int to be a s16 would lower the memory overhead,
> > > > which is why I'd kind of like the abstraction to be minimal.
> > >
> > > Here I am not clear what for "changing the int to be a s16".  Could y=
ou
> > > elaberate a bit for this?
> >
> > I meant this :-)
> > https://lore.kernel.org/lkml/20241207052133.102829-1-irogers@google.com=
/
>
> How many time is this allocated?
> If it is 2 bytes in a larger structure it is likely to be noise.
> For a local the code is likely to be worse.
> Any maths and you start forcing the compiler to mask the value
> (on pretty much anything except x86).

So the data structure is a sorted array of ints, this changes it to
int16s. On the 32 socket GNR with > 2048 logical CPUs, the array would
be over 8kb before and 4kb after for all online CPUs. On my more
modest desktop with 72 logical cores the size goes from 288 bytes down
to 144, a reduction of 2 cache lines. I'm not super excited about the
memory savings, but the patch is only 8 lines in difference.

Thanks,
Ian

