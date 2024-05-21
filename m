Return-Path: <linux-kernel+bounces-185245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D53E8CB2A6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 19:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAEF0B22B53
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 17:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4090C147C99;
	Tue, 21 May 2024 17:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hpEgDhib"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430017711E
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 17:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716311602; cv=none; b=DFStnLORIAmJwJnJInQJDUsuNofheZbk9NtfHOfFHo1G8cCuDRT7SB7R3C9LsFjNYrUEg00IkNbZ6DqOwpJCK6ZqGU/z9sF5si0mq8EsxtHgnFh94Y60ggrkLzMvdy6B/iRfTOj66FtaobW1w1z9DMsaL2L2bQBRCqvZR8xIF/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716311602; c=relaxed/simple;
	bh=8dd+3CyB9ZfUsu9ED1coxbk8SB2YtRQF+xW5vW/Nv/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rveN+ouD+N1esUCh3ppCMp2czZ5YZyjDv59e0OtZCiajm97V0JgjaBp4c3AHFkphb7Qakul2638HdHVVup30wxiMvy6Qt3KihaCbfqhmIfvvPV5DD9XsV/pnGpzQe5X75fSm1CYNWy0BjvVWydOXKT9uXCasAxCQUouDC7kQVAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hpEgDhib; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1ee5f3123d8so6455ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 10:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716311600; x=1716916400; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xvy3vZOZ+DrbSfTr1Y7exdXqXahpXO1bzaeP7lN+Ufk=;
        b=hpEgDhibUlLJxFY55sGD/DxKWW5nybslYJUsHbVtn6N3fRZpXMYhOrpyU/+xXnxp07
         FlEdWGg936tel9MPXpUizcMCcCtp+9IvLMf/K5ZdvoryBHUVVwLnC1qNS2zWxVwpISiB
         P9/HkI2MCLMC4ckECMPhaOzLA7XfoRxav2iX1rbH0piDpOYPbPWfuA1NAx4oaZUDDdmw
         ydJ4Nnul3N4ecj3mIS5DVHBMUM7SFxbi1zL5YqbmWmtHkV+Kmje2idD3QmjVVCjduIUy
         qIcD5oXk1oRFwVOekab9pNSQZ/MX+EAt99dNJ3tg59SHWE9NqgKn7/H1kEEqoafoFM5W
         QGIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716311600; x=1716916400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xvy3vZOZ+DrbSfTr1Y7exdXqXahpXO1bzaeP7lN+Ufk=;
        b=CcahK0r0FdLMqYyY3Sx5V+k8HfRS8LJxVIcuUQF5JupxKBuHPVgqDY37DIyMDPYDnP
         Mt4gatIDYDZ682+o9yNR5IFfGgvEmzyeDyJsKweEVJmrDwGaYj2lIdHFABTRc+WmxljA
         zDMu9Q7AAOGCCpl0FJTPDoySQ/LG05CB0JKtV5SUwpu0ZiXe5Cabz42VcHFtJzR2yBnQ
         zDjfbXlk2uNwOAbEJL/JEgfHUBGyMeQrmdo0SJrT73RtTcdM8jZ61wBXP/Dcjc5Pnqkl
         rbfBEU3ff+So3CmkhQ+/tKJwjUs7uhGd4+aIA9exFf0xYfeCUJCv7+kJxTnhzQGIXJX7
         rI1g==
X-Forwarded-Encrypted: i=1; AJvYcCUTFAQHaoTy6phYwze7I9y1eHycWTWSJ33B9k/kwI1tg8fB6TIAgo29uGZ+6Ti5ttcXXutfdTkFkT6k7XXQUloir4WJ1l4kfj/3dx3Z
X-Gm-Message-State: AOJu0YyjS+UHC3fZuQzqXyIRY92gPSqLs4+1/335nb1XjHFdsqL8r+L4
	sn3XM6T0veNIrRITIA0FhkwC+g6Wn7PJr2+NCnSyiz87s3YM0o4OMa9ecBaLufcSDN3QGr+XPI7
	WQC6I2rOzWcRSS6jsb0lu5gTA6VtFpM/OQcZ5
X-Google-Smtp-Source: AGHT+IH7MCJIERIUNSu5RuWQS0e+JMaobcia4kPXAmSM9jwR4UnOl+yPIfG2Fs55+kkzwmCz/U8IMakT9c6t53PCvhk=
X-Received: by 2002:a17:902:c106:b0:1e8:88b2:17cd with SMTP id
 d9443c01a7336-1f2ecb14a62mr6705655ad.12.1716311599190; Tue, 21 May 2024
 10:13:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240520203643.182920-1-irogers@google.com> <e3e483ff-d160-4bf2-a1e7-ae541c59f63d@oracle.com>
In-Reply-To: <e3e483ff-d160-4bf2-a1e7-ae541c59f63d@oracle.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 21 May 2024 10:13:07 -0700
Message-ID: <CAP-5=fXtahvLa5hFqdQpPyeHYsUNe=MkJBn8Yf5npNUvGJOU0w@mail.gmail.com>
Subject: Re: [PATCH v1] perf jevents: Autogenerate empty-pmu-events.c
To: John Garry <john.g.garry@oracle.com>
Cc: Weilin Wang <weilin.wang@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Sandipan Das <sandipan.das@amd.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 4:45=E2=80=AFAM John Garry <john.g.garry@oracle.com=
> wrote:
>
> On 20/05/2024 16:36, Ian Rogers wrote:
> >       }
> > +                ret =3D pmu_events_table__find_event_pmu(table, table_=
pmu, name, fn, data);
> > +                if (ret !=3D -1000)
> > +                        return ret;
> > +        }
> >           return -1000;
>
> what's -1000 meaning? It would be nice to use some standard error codes.

This is a pre-existing thing. 0 means continue and anything else
generally aborts a search, -1000 is used when searching multiple
tables to indicate not found in 1 table but potentially not all.

Commit 3d5045492ab2 ("perf pmu-events: Add
pmu_events_table__find_event()") added this [1], you were on the cc
list ;-) I think moving to a named constant would make this more
intention revealing so I'll add this to a v2 set.

Thanks,
Ian

[1] https://lore.kernel.org/r/20230824041330.266337-9-irogers@google.com

> Thanks,
> John
>
>

